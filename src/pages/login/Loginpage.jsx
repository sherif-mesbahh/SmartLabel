import React, { useState } from "react";
import { useAuth } from "../../hooks/useAuth";
import { useNavigate, Link } from "react-router-dom";
import { motion } from "framer-motion";

function LoginPage() {
  const { login, ForgetPassword, ResetCode, ResetPassword } = useAuth();
  const navigate = useNavigate();

  const [showCodeForm, setShowCodeForm] = useState(false);
  const [showPasswordReset, setShowPasswordReset] = useState(false);

  const [code, setCode] = useState("");
  const [newPassword, setNewPassword] = useState();
  const [confirmPassword, setConfirmPassword] = useState();

  const [formData, setFormData] = useState({ email: "", password: "" });
  const [isLoading, setIsLoading] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setIsLoading(true);
    try {
      await login(formData.email, formData.password);
    } catch (error) {
      // Error is handled in useAuth
    } finally {
      setIsLoading(false);
    }
  };

  const ResetCodeHandle = async () => {
    try {
      await ResetCode(formData.email, code);
      setShowCodeForm(false);
      setShowPasswordReset(true);
    } catch (error) {
      // Error is handled in useAuth
      setShowCodeForm(true);
    }
  };

  const handleResetPassword = async () => {
    try {
      await ResetPassword(formData.email, newPassword, confirmPassword);
      setShowPasswordReset(false);
    } catch (error) {
      // Error is handled in useAuth
      setShowPasswordReset(true);
    }
  };

  const containerVariants = {
    hidden: { opacity: 0, y: 20 },
    visible: {
      opacity: 1,
      y: 0,
      transition: {
        duration: 0.5,
        staggerChildren: 0.1
      }
    }
  };

  const itemVariants = {
    hidden: { opacity: 0, x: -20 },
    visible: {
      opacity: 1,
      x: 0,
      transition: { duration: 0.3 }
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-blue-50 via-white to-purple-50 dark:from-gray-900 dark:via-gray-800 dark:to-gray-900">
      <motion.div
        initial="hidden"
        animate="visible"
        variants={containerVariants}
        className="bg-white dark:bg-gray-800 p-8 rounded-2xl shadow-2xl w-full max-w-md backdrop-blur-sm bg-white/90 dark:bg-gray-800/90"
      >
        <motion.h1
          variants={itemVariants}
          className="text-4xl font-extrabold text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-purple-600 dark:from-blue-400 dark:to-purple-400 mb-8 text-center"
        >
          Welcome Back
        </motion.h1>

        <motion.form
          variants={containerVariants}
          onSubmit={handleSubmit}
          className="space-y-6"
        >
          <motion.div variants={itemVariants}>
            <input
              type="email"
              placeholder="Email"
              value={formData.email}
              onChange={(e) =>
                setFormData({ ...formData, email: e.target.value })
              }
              className="w-full p-4 border border-gray-200 dark:border-gray-600 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-300 shadow-sm dark:bg-gray-700 dark:text-white dark:placeholder-gray-400"
              required
              autoFocus
            />
          </motion.div>
          <motion.div variants={itemVariants}>
            <input
              type="password"
              placeholder="Password"
              value={formData.password}
              onChange={(e) =>
                setFormData({ ...formData, password: e.target.value })
              }
              className="w-full p-4 border border-gray-200 dark:border-gray-600 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-300 shadow-sm dark:bg-gray-700 dark:text-white dark:placeholder-gray-400"
              required
              minLength={6}
            />
          </motion.div>
          <motion.button
            variants={itemVariants}
            type="submit"
            disabled={isLoading}
            className={`w-full py-4 bg-gradient-to-r from-blue-600 to-purple-600 text-white font-semibold rounded-xl hover:from-blue-700 hover:to-purple-700 transition-all duration-300 transform hover:scale-[1.02] active:scale-[0.98] shadow-lg ${
              isLoading ? "opacity-70 cursor-not-allowed" : ""
            }`}
          >
            {isLoading ? (
              <div className="flex items-center justify-center">
                <div className="w-5 h-5 border-t-2 border-white rounded-full animate-spin mr-2"></div>
                Logging in...
              </div>
            ) : (
              "Login"
            )}
          </motion.button>
        </motion.form>

        <motion.div
          variants={itemVariants}
          className="mt-6 text-center text-sm text-gray-600"
        >
          New user?{" "}
          <Link
            to="/register"
            className="text-blue-600 font-medium hover:text-purple-600 transition-colors duration-300"
          >
            Register here
          </Link>
        </motion.div>

        <motion.button
          variants={itemVariants}
          onClick={async () => {
            if (!formData.email) {
              toast.error("Please enter your email first.");
              return;
            }
            try {
              await ForgetPassword(formData.email);
              setShowCodeForm(true);
            } catch (error) {
              // Error is handled in useAuth
            }
          }}
          className="mt-4 text-sm text-blue-600 font-medium hover:text-purple-600 transition-colors duration-300 block text-center"
        >
          Forgot password?
        </motion.button>

        {showCodeForm && (
          <motion.div
            initial={{ opacity: 0, height: 0 }}
            animate={{ opacity: 1, height: "auto" }}
            exit={{ opacity: 0, height: 0 }}
            className="mt-6"
          >
            <label className="block mb-2 text-sm font-semibold text-gray-700">
              Enter the code sent to your email
            </label>
            <input
              type="text"
              placeholder="Verification code"
              value={code}
              onChange={(e) => setCode(e.target.value)}
              className="w-full p-4 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all duration-300 shadow-sm"
            />
            <button
              className="mt-3 w-full py-4 bg-gradient-to-r from-green-500 to-emerald-600 text-white font-semibold rounded-xl hover:from-green-600 hover:to-emerald-700 transition-all duration-300 transform hover:scale-[1.02] active:scale-[0.98] shadow-lg"
              onClick={ResetCodeHandle}
            >
              Verify Code
            </button>
          </motion.div>
        )}

        {showPasswordReset && (
          <motion.div
            initial={{ opacity: 0, height: 0 }}
            animate={{ opacity: 1, height: "auto" }}
            exit={{ opacity: 0, height: 0 }}
            className="mt-6"
          >
            <label className="block mb-2 text-sm font-semibold text-gray-700">
              Enter new password
            </label>
            <input
              type="password"
              placeholder="New Password"
              value={newPassword}
              onChange={(e) => setNewPassword(e.target.value)}
              className="w-full p-4 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-300 shadow-sm"
            />

            <label className="block mt-4 mb-2 text-sm font-semibold text-gray-700">
              Confirm password
            </label>
            <input
              type="password"
              placeholder="Confirm Password"
              value={confirmPassword}
              onChange={(e) => setConfirmPassword(e.target.value)}
              className="w-full p-4 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-300 shadow-sm"
            />

            <button
              className="mt-4 w-full py-4 bg-gradient-to-r from-blue-600 to-purple-600 text-white font-semibold rounded-xl hover:from-blue-700 hover:to-purple-700 transition-all duration-300 transform hover:scale-[1.02] active:scale-[0.98] shadow-lg"
              onClick={handleResetPassword}
            >
              Reset Password
            </button>
          </motion.div>
        )}
      </motion.div>
    </div>
  );
}

export default LoginPage;
