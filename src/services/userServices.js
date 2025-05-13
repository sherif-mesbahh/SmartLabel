import axios from "axios";

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
  return axios.post(`/api/Authentication/login`, { email, password });
};

export const register = (
  firstName,
  lastName,
  email,
  password,
  confirmPassword
) => {
  return axios.post(`/api/Authentication/register`, {
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
  return axios.post(`/api/Authentication/refresh-token`, {
    refreshToken,
  });
};

export const getAll = (searchTerm) => {
  return axios.get(`/api/Users/admin${searchTerm ?? ""}`);
};

export const getById = (id) => {
  return axios.get(`/api/Authorization/user-roles/${id}`);
};

export const editUser = (email, roleName) => {
  return axios.put(`/api/Authorization/user-roles`, {
    email,
    roleName,
  });
};

export const updateProfile = (updateuser) => {
  return axios.put(`/api/Users/me`, updateuser);
};

export const changePassword = (passwords) => {
  return axios.put(`/api/Users/me/password`, passwords);
};

export const UserInfo = () => {
  return axios.get(`/api/Users/me`);
};

export const ForgetPassword = (email) => {
  return axios.post(
    `/api/Authentication/forget-password`,
    { email },
    {
      headers: {
        "Content-Type": "application/json",
      },
    }
  );
};

export const ResetCode = (email, code) => {
  return axios.post(`/api/Authentication/reset-code`, {
    email,
    code,
  });
};

export const ResetPassword = (email, password, confirmPassword) => {
  return axios.post(`/api/Authentication/reset-password`, {
    email,
    password,
    confirmPassword,
  });
};
