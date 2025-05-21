import React, { useState } from "react";
import { useAuth } from "../../hooks/useAuth";
import { useNavigate, Link } from "react-router-dom";
import { motion } from "framer-motion";

function RegisterPage() {
  const { register } = useAuth();
  const navigate = useNavigate();

  const [firstName, setfirstName] = useState("");
  const [lastName, setlastName] = useState("");
  const [Email, setEmail] = useState("");
  const [Password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [error, setError] = useState("");
  const [emailError, setEmailError] = useState("");
  const [passwordError, setPasswordError] = useState("");
  const [confirmPasswordError, setConfirmPasswordError] = useState("");
  const [isLoading, setIsLoading] = useState(false);

  const validateEmail = (email) => {
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailPattern.test(email);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setIsLoading(true);

    // Reset errors
    setError("");
    setEmailError("");
    setPasswordError("");
    setConfirmPasswordError("");

    let valid = true;

    if (!validateEmail(Email)) {
      setEmailError("Invalid email format");
      valid = false;
    }

    if (Password.length < 6) {
      setPasswordError("Password must be at least 6 characters long");
      valid = false;
    }

    if (Password !== confirmPassword) {
      setConfirmPasswordError("Passwords do not match");
      valid = false;
    }

    if (!valid) {
      setIsLoading(false);
      return;
    }

    try {
      await register(firstName, lastName, Email, Password, confirmPassword);
    } catch (err) {
      setError(err.message || "Registration failed");
    } finally {
      setIsLoading(false);
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
    <div className="py-8 flex items-center justify-center bg-gradient-to-br from-blue-50 via-white to-purple-50">
      <motion.div
        initial="hidden"
        animate="visible"
        variants={containerVariants}
        className="bg-white p-8 rounded-2xl shadow-2xl w-full max-w-md backdrop-blur-sm bg-white/90"
      >
        <motion.h1
          variants={itemVariants}
          className="text-4xl font-extrabold text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-purple-600 mb-8 text-center"
        >
          Create Your Account
        </motion.h1>

        <motion.form
          variants={containerVariants}
          onSubmit={handleSubmit}
          className="space-y-6"
        >
          <motion.div variants={itemVariants}>
            <input
              type="text"
              placeholder="First Name"
              value={firstName}
              onChange={(e) => setfirstName(e.target.value)}
              className="w-full p-4 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-300 shadow-sm"
              required
            />
          </motion.div>

          <motion.div variants={itemVariants}>
            <input
              type="text"
              placeholder="Last Name"
              value={lastName}
              onChange={(e) => setlastName(e.target.value)}
              className="w-full p-4 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-300 shadow-sm"
              required
            />
          </motion.div>

          <motion.div variants={itemVariants}>
            <input
              type="email"
              placeholder="Email"
              value={Email}
              onChange={(e) => setEmail(e.target.value)}
              className={`w-full p-4 border rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-300 shadow-sm ${
                emailError ? "border-red-500" : "border-gray-200"
              }`}
              required
            />
            {emailError && (
              <motion.p
                initial={{ opacity: 0, y: -10 }}
                animate={{ opacity: 1, y: 0 }}
                className="text-red-500 text-sm mt-1"
              >
                {emailError}
              </motion.p>
            )}
          </motion.div>

          <motion.div variants={itemVariants}>
            <input
              type="password"
              placeholder="Password"
              value={Password}
              onChange={(e) => setPassword(e.target.value)}
              className={`w-full p-4 border rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-300 shadow-sm ${
                passwordError ? "border-red-500" : "border-gray-200"
              }`}
              required
              minLength={6}
            />
            {passwordError && (
              <motion.p
                initial={{ opacity: 0, y: -10 }}
                animate={{ opacity: 1, y: 0 }}
                className="text-red-500 text-sm mt-1"
              >
                {passwordError}
              </motion.p>
            )}
          </motion.div>

          <motion.div variants={itemVariants}>
            <input
              type="password"
              placeholder="Confirm Password"
              value={confirmPassword}
              onChange={(e) => setConfirmPassword(e.target.value)}
              className={`w-full p-4 border rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-300 shadow-sm ${
                confirmPasswordError ? "border-red-500" : "border-gray-200"
              }`}
              required
            />
            {confirmPasswordError && (
              <motion.p
                initial={{ opacity: 0, y: -10 }}
                animate={{ opacity: 1, y: 0 }}
                className="text-red-500 text-sm mt-1"
              >
                {confirmPasswordError}
              </motion.p>
            )}
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
                Creating Account...
              </div>
            ) : (
              "Register"
            )}
          </motion.button>

          {error && (
            <motion.p
              initial={{ opacity: 0, y: -10 }}
              animate={{ opacity: 1, y: 0 }}
              className="text-red-500 text-center text-sm mt-2"
            >
              {error}
            </motion.p>
          )}
        </motion.form>

        <motion.p
          variants={itemVariants}
          className="mt-6 text-center text-sm text-gray-600"
        >
          Already have an account?{" "}
          <Link
            to="/login"
            className="text-blue-600 font-medium hover:text-purple-600 transition-colors duration-300"
          >
            Login here
          </Link>
        </motion.p>
      </motion.div>
    </div>
  );
}

export default RegisterPage;
