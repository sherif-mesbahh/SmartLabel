import axios from "axios";

const API_URL = "http://smartlabel1.runasp.net";

export const getUser = () => {
  const user = localStorage.getItem("user");
  const userinfo = localStorage.getItem("userInfo");
  if (!user || user === "undefined") return null;

  try {
    return JSON.parse(user), JSON.parse(userinfo);
  } catch (err) {
    console.error("Invalid user JSON:", err);
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
};

export const refreshToken = (refreshToken) => {
  return axios.post(`${API_URL}/api/Authentication/refresh-token`, {
    refreshToken,
  });
};

export const getAll = (searchTerm) => {
  return axios.get(`${API_URL}/api/admin${searchTerm ?? ""}`);
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
  return axios.put(`${API_URL}/api/me`, updateuser);
};

export const changePassword = (passwords) => {
  return axios.put(`${API_URL}/api/me/password`, passwords);
};

export const UserInfo = () => {
  return axios.get(`${API_URL}/api/me`);
};
