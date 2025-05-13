import axios from "axios";
import { refreshToken } from "../services/userServices";

// Create axios instance
const axiosInstance = axios.create();

// Flag to prevent multiple refresh attempts
let isRefreshing = false;
// Store pending requests
let failedQueue = [];

const processQueue = (error, token = null) => {
  failedQueue.forEach(prom => {
    if (error) {
      prom.reject(error);
    } else {
      prom.resolve(token);
    }
  });
  failedQueue = [];
};

// Add request interceptor
axios.interceptors.request.use(
  (req) => {
    const user = localStorage.getItem("user");
    if (user) {
      const parsedUser = JSON.parse(user);
      const token = parsedUser?.data?.accessToken;
      if (token) {
        req.headers["Authorization"] = `Bearer ${token}`;
      }
    }
    return req;
  },
  (error) => Promise.reject(error)
);

// Add response interceptor to handle token refresh
axios.interceptors.response.use(
  (response) => response,
  async (error) => {
    const originalRequest = error.config;
    const user = localStorage.getItem("user");

    // If the error is 401 and we haven't retried yet
    if (error.response?.status === 401 && !originalRequest._retry && user) {
      // If we're already refreshing, queue this request
      if (isRefreshing) {
        return new Promise((resolve, reject) => {
          failedQueue.push({ resolve, reject });
        })
          .then(token => {
            originalRequest.headers["Authorization"] = `Bearer ${token}`;
            return axios(originalRequest);
          })
          .catch(err => Promise.reject(err));
      }

      originalRequest._retry = true;
      isRefreshing = true;

      try {
        const parsedUser = JSON.parse(user);
        const refreshTokenValue = parsedUser.data.refreshToken;

        // Call refresh token service
        const response = await refreshToken(refreshTokenValue);

        // Update stored tokens
        parsedUser.data.accessToken = response.data.accessToken;
        parsedUser.data.refreshToken = response.data.refreshToken;
        localStorage.setItem("user", JSON.stringify(parsedUser));

        // Update Authorization header
        originalRequest.headers["Authorization"] = `Bearer ${response.data.accessToken}`;

        // Process queued requests
        processQueue(null, response.data.accessToken);

        // Retry the original request
        return axios(originalRequest);
      } catch (refreshError) {
        processQueue(refreshError, null);
        // If refresh fails, clear user data and redirect to login
        localStorage.removeItem("user");
        localStorage.removeItem("userInfo");
        window.location.href = "/login";
        return Promise.reject(refreshError);
      } finally {
        isRefreshing = false;
      }
    }

    return Promise.reject(error);
  }
);

export default axiosInstance;
