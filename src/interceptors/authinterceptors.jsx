import axios from "axios";
import { getUser, refreshToken } from "../services/userServices";

// Create axios instance
const axiosInstance = axios.create();

// Flag to prevent multiple refresh attempts
let isRefreshing = false;
// Store pending requests
let failedQueue = [];
// Timer for periodic refresh
let refreshTimer = null;

const processQueue = (error, token = null) => {
  failedQueue.forEach((prom) => {
    if (error) {
      prom.reject(error);
    } else {
      prom.resolve(token);
    }
  });
  failedQueue = [];
};

const refreshTokenAndUpdate = async () => {
  try {
    const userData = getUser();
    if (!userData?.user?.data?.refreshToken) {
      throw new Error("No refresh token available");
    }

    const response = await refreshToken(userData.user.data.refreshToken);
    
    if (response?.data?.data) {
      const { accessToken, refreshToken: newRefreshToken } = response.data.data;
      
      // Update localStorage with new tokens
      const updatedUser = {
        ...userData.user,
        data: {
          ...userData.user.data,
          accessToken,
          refreshToken: newRefreshToken
        }
      };
      
      localStorage.setItem("user", JSON.stringify(updatedUser));
      
      return accessToken;
    }
    throw new Error("Invalid refresh token response");
  } catch (error) {
  
    throw error;
  }
};

const scheduleNextRefresh = () => {
  if (refreshTimer) {
    clearTimeout(refreshTimer);
  }
  
  // Schedule next refresh in 19 minutes
  refreshTimer = setTimeout(async () => {
    try {
      await refreshTokenAndUpdate();
      scheduleNextRefresh(); // Schedule next refresh after successful refresh
    } catch (error) {
      // If refresh fails, try again in 1 minute
      refreshTimer = setTimeout(scheduleNextRefresh, 60000);
    }
  }, 19 * 60 * 1000);
  
};

// Initialize refresh timer if user is logged in
const initializeRefreshTimer = () => {
  const userData = getUser();
  if (userData?.user?.data?.accessToken) {
    scheduleNextRefresh();
  } else {
  }
};

// Initialize on module load
initializeRefreshTimer();

// Request interceptor
axios.interceptors.request.use(
  (config) => {
    const userData = getUser();
    if (userData?.user?.data?.accessToken) {
      config.headers.Authorization = `Bearer ${userData.user.data.accessToken}`;
    } else {
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// Response interceptor
axios.interceptors.response.use(
  (response) => response,
  async (error) => {
    const originalRequest = error.config;

    if (error.response?.status === 401 && !originalRequest._retry) {
      if (isRefreshing) {
        return new Promise((resolve, reject) => {
          failedQueue.push({ resolve, reject });
        })
          .then((token) => {
            originalRequest.headers.Authorization = `Bearer ${token}`;
            return axios(originalRequest);
          })
          .catch((err) => Promise.reject(err));
      }

      originalRequest._retry = true;
      isRefreshing = true;

      try {
        const newToken = await refreshTokenAndUpdate();
        isRefreshing = false;
        processQueue(null, newToken);
        originalRequest.headers.Authorization = `Bearer ${newToken}`;
        return axios(originalRequest);
      } catch (refreshError) {
        isRefreshing = false;
        processQueue(refreshError, null);
        return Promise.reject(refreshError);
      }
    }

    return Promise.reject(error);
  }
);

export default axiosInstance;
