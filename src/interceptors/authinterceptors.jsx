import axios from "axios";
import { refreshToken } from "../services/userServices";

// Create axios instance
const axiosInstance = axios.create();

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

    if (error.response?.status === 401 && !originalRequest._retry && user) {
      originalRequest._retry = true;

      try {
        const parsedUser = JSON.parse(user);
        const refreshTokenValue = parsedUser.data.refreshToken;

        // Call your refresh token service
        const response = await refreshToken(refreshTokenValue);

        // Update stored tokens
        parsedUser.data.accessToken = response.data.accessToken;
        parsedUser.data.refreshToken = response.data.refreshToken;
        localStorage.setItem("user", JSON.stringify(parsedUser));
        // Update the Authorization header
        originalRequest.headers[
          "Authorization"
        ] = `Bearer ${response.data.accessToken}`;

        // Retry the original request
        return axiosInstance(originalRequest);
      } catch (refreshError) {
        // If refresh fails, logout the user
        localStorage.removeItem("user");
        window.location.href = "/login"; // Redirect to login
        return Promise.reject(refreshError);
      }
    }

    return Promise.reject(error);
  }
);

export default axiosInstance;
