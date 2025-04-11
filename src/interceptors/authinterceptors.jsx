import axios from "axios";
import { useEffect } from "react";

// Add Axios request interceptor
axios.interceptors.request.use(
  (req) => {
    // Get the user object from localStorage
    const user = localStorage.getItem("user");
    const token = user && JSON.parse(user).token;

    // If the token exists, set it in the Authorization header
    if (token) {
      req.headers["Authorization"] = `Bearer ${token}`;
    }
    return req;
  },
  (error) => {
    // Handle request errors
    return Promise.reject(error);
  }
);
