import axios from "axios";

const API_URL = "https://smartlabel1.runasp.net";

export const getUser = () => {
  try {
    const user = localStorage.getItem("user");
    const userinfo = localStorage.getItem("userInfo");
    
    if (!user || user === "undefined") {
      console.log("No user data found in localStorage");
      return null;
    }

    const parsedUser = JSON.parse(user);
    const parsedUserInfo = userinfo ? JSON.parse(userinfo) : null;

    if (!parsedUser?.data?.accessToken) {
      console.log("No access token found in user data");
      return null;
    }

    // Return both user and userInfo in a consistent structure
    return {
      user: parsedUser,
      userInfo: parsedUserInfo
    };
  } catch (err) {
    console.error("Error parsing user data:", err);
    return null;
  }
};

export const Login = (email, password) => {
  return axios.post(`${API_URL}/api/Authentication/login`, { email, password });
};

export const register = (
  firstName,
  lastName,
  email,
  password,
  confirmPassword
) => {
  return axios.post(`${API_URL}/api/Authentication/register`, {
    firstName,
    lastName,
    email,
    password,
    confirmPassword,
  });
};

export const Logout = () => {
  localStorage.removeItem("user");
  localStorage.removeItem("userInfo");
};

export const refreshToken = async (refreshTokenValue) => {
  try {
    console.log("Attempting to refresh token with value:", refreshTokenValue);
    const response = await axios.post(`${API_URL}/api/Authentication/refresh-token`, {
      refreshToken: refreshTokenValue
    });
    console.log("Token refresh successful:", response.data);
    return response;
  } catch (error) {
    console.error("Token refresh failed:", {
      status: error.response?.status,
      data: error.response?.data,
      message: error.message
    });
    throw error;
  }
};

export const getAll = (searchTerm) => {
  return axios.get(`${API_URL}/api/Users/admin${searchTerm ?? ""}`);
};

export const getById = (id) => {
  return axios.get(`${API_URL}/api/Authorization/user-roles/${id}`);
};

export const editUser = (email, roleName) => {
  return axios.put(`${API_URL}/api/Authorization/user-roles`, {
    email,
    roleName,
  });
};

export const updateProfile = (updateuser) => {
  return axios.put(`${API_URL}/api/Users/me`, updateuser);
};

export const changePassword = (passwords) => {
  return axios.put(`${API_URL}/api/Users/me/password`, passwords);
};

export const UserInfo = () => {
  return axios.get(`${API_URL}/api/Users/me`);
};

export const ForgetPassword = (email) => {
  return axios.post(
    `${API_URL}/api/Authentication/forget-password`,
    { email },
    {
      headers: {
        "Content-Type": "application/json",
      },
    }
  );
};

export const ResetCode = (email, code) => {
  return axios.post(`${API_URL}/api/Authentication/reset-code`, {
    email,
    code,
  });
};

export const ResetPassword = (email, password, confirmPassword) => {
  return axios.post(`${API_URL}/api/Authentication/reset-password`, {
    email,
    password,
    confirmPassword,
  });
};
