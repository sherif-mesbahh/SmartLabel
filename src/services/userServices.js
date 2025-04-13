import axios from "axios";

export const getUser = () => {
  return localStorage.getItem("user")
    ? JSON.parse(localStorage.getItem("user"))
    : null;
};

export const Login = async (email, password) => {
  const { data } = await axios.post(
    "http://smartlabel1.runasp.net/api/Authentication/login",
    { email, password }
  );
  localStorage.setItem("user", JSON.stringify(data));
  return data;
};

export const register = async (
  firstName,
  lastName,
  email,
  password,
  confirmPassword
) => {
  const { data } = await axios.post(
    "http://smartlabel1.runasp.net/api/Authentication/register",
    { firstName, lastName, email, password, confirmPassword }
  );
  localStorage.setItem("user", JSON.stringify(data));
  return data;
};

export const Logout = () => {
  localStorage.removeItem("user");
};
export const updateProfile = async (updateuser) => {
  const { data } = await axios.put("/api/users/updateProfile", updateuser);

  localStorage.setItem("user", JSON.stringify(data));
  return data;
};
export const changePassword = async (passwords) => {
  const { data } = await axios.put("/api/users/changePassword", passwords);
  localStorage.setItem("user", JSON.stringify(data));
  return data;
};
export const getAll = async (searchTerm) => {
  const { data } = await axios.get("/api/users/getAll/" + (searchTerm ?? ""));

  return data;
};
export const toggleBlock = async (userId) => {
  const { data } = await axios.put("/api/users/toggleBlock/" + userId);

  return data;
};
export const getById = async (userId) => {
  const { data } = await axios.get("/api/users/getById/" + userId);

  return data;
};
export const EditUser = async (userForm) => {
  const { data } = await axios.put("/api/users/EditUser", userForm);

  return data;
};
