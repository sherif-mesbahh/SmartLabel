import { useContext, useState, createContext } from "react";
import { toast } from "react-toastify";
import * as userService from "../services/userServices";
import { useNavigate } from "react-router-dom";

const AuthContext = createContext();

function AuthProvider({ children }) {
  const navigate = useNavigate();
  const [user, setUser] = useState(userService.getUser());
  const [userInfo, setUserInfo] = useState(userService.getUser());

  const login = async (email, password) => {
    try {
      const { data } = await userService.Login(email, password);
      localStorage.setItem("user", JSON.stringify(data));
      setUser(data);

      const { data: userdata } = await userService.UserInfo();
      localStorage.setItem("userInfo", JSON.stringify(userdata));
      setUserInfo(userdata);

      toast.success("Login Successful");
      navigate("/");
      window.location.reload();
    } catch (error) {
      toast.error(error.response?.data?.errors?.[0] || "Login failed");
    }
  };

  const register = async (
    firstName,
    lastName,
    email,
    password,
    confirmPassword
  ) => {
    try {
      await userService.register(
        firstName,
        lastName,
        email,
        password,
        confirmPassword
      );

      toast.success("Registration Successful");
      navigate("/login");
    } catch (error) {
      toast.error(error.response?.data?.errors?.[0] || "Registration failed");
    }
  };

  const updateProfile = async (profileData) => {
    try {
      await userService.updateProfile(profileData);

      toast.success("Profile updated successfully");
    } catch (error) {
      toast.error(error.response?.data?.errors?.[0] || "Profile update failed");
    }
  };

  const logout = () => {
    userService.Logout();

    toast.success("Logout Successful");
    navigate("/login");
  };

  const changePassword = async (passwords) => {
    try {
      await userService.changePassword(passwords);
      toast.success("Password updated successfully. Please log in again.");
      logout();
    } catch (error) {
      toast.error(
        error.response?.data?.errors?.[0] || "Password update failed"
      );
    }
  };

  return (
    <AuthContext.Provider
      value={{
        user,
        userInfo,
        login,
        register,
        logout,
        updateProfile,
        changePassword,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
}

export default AuthProvider;
export const useAuth = () => useContext(AuthContext);
