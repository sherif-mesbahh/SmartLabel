import { useContext, useState, createContext, useEffect } from "react";
import { toast } from "react-toastify";
import * as userService from "../services/userServices";
import { useNavigate } from "react-router-dom";

const AuthContext = createContext();

function AuthProvider({ children }) {
  const navigate = useNavigate();
  const [user, setUser] = useState(null);
  const [userInfo, setUserInfo] = useState(null);
  const [isLoading, setIsLoading] = useState(true);

  // Initialize user data on mount
  useEffect(() => {
    const initializeUser = async () => {
      try {
        const userData = userService.getUser();
        if (userData) {
          setUser(userData.user);
          setUserInfo(userData.userInfo);
          
          // If we have a user but no userInfo, fetch it
          if (userData.user && !userData.userInfo) {
            try {
              const { data } = await userService.UserInfo();
              setUserInfo(data);
              localStorage.setItem("userInfo", JSON.stringify(data));
            } catch (error) {
              console.error("Error fetching user info:", error);
            }
          }
        }
      } catch (error) {
        console.error("Error initializing user:", error);
      } finally {
        setIsLoading(false);
      }
    };

    initializeUser();
  }, []);

  const login = async (email, password) => {
    try {
      setIsLoading(true);
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
      throw error;
    } finally {
      setIsLoading(false);
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
      setIsLoading(true);
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
      throw error;
    } finally {
      setIsLoading(false);
    }
  };

  const updateProfile = async (profileData) => {
    try {
      setIsLoading(true);
      await userService.updateProfile(profileData);
      
      // Update local userInfo
      const { data } = await userService.UserInfo();
      setUserInfo(data);
      localStorage.setItem("userInfo", JSON.stringify(data));

      toast.success("Profile updated successfully");
    } catch (error) {
      toast.error(error.response?.data?.errors?.[0] || "Profile update failed");
      throw error;
    } finally {
      setIsLoading(false);
    }
  };

  const logout = () => {
    userService.Logout();
    setUser(null);
    setUserInfo(null);
    toast.success("Logout Successful");
    navigate("/login");
  };

  const changePassword = async (passwords) => {
    try {
      setIsLoading(true);
      await userService.changePassword(passwords);
      toast.success("Password updated successfully. Please log in again.");
      logout();
    } catch (error) {
      toast.error(
        error.response?.data?.errors?.[0] || "Password update failed"
      );
      throw error;
    } finally {
      setIsLoading(false);
    }
  };

  const ForgetPassword = async (email) => {
    try {
      setIsLoading(true);
      await userService.ForgetPassword(email);
      toast.success("Code has been sent to your email");
    } catch (error) {
      toast.error(error.response?.data?.errors?.[0] || "Failed to send reset code");
      throw error;
    } finally {
      setIsLoading(false);
    }
  };

  const ResetCode = async (email, code) => {
    try {
      setIsLoading(true);
      await userService.ResetCode(email, code);
      toast.success("Code is correct");
    } catch (error) {
      toast.error(error.response?.data?.errors?.[0] || "Invalid code");
      throw error;
    } finally {
      setIsLoading(false);
    }
  };

  const ResetPassword = async (email, password, confirmPassword) => {
    try {
      setIsLoading(true);
      await userService.ResetPassword(email, password, confirmPassword);
      toast.success("Password changed successfully");
    } catch (error) {
      toast.error(error.response?.data?.errors?.[0] || "Failed to reset password");
      throw error;
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <AuthContext.Provider
      value={{
        user,
        userInfo,
        isLoading,
        login,
        register,
        logout,
        updateProfile,
        changePassword,
        ForgetPassword,
        ResetCode,
        ResetPassword,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
}

export default AuthProvider;
export const useAuth = () => useContext(AuthContext);
