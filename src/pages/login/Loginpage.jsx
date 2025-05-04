import React, { useState } from "react";
import { useAuth } from "../../hooks/useAuth";
import { useNavigate, Link } from "react-router-dom";
import { toast } from "react-toastify";

function LoginPage() {
  const { login, ForgetPassword, ResetCode, ResetPassword } = useAuth();

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
      error && setShowCodeForm(true);
    }
  };
  const handleResetPassword = async () => {
    try {
      await ResetPassword(formData.email, newPassword, confirmPassword);
      setShowPasswordReset(false);
    } catch (error) {
      error && setShowPasswordReset(true);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-100">
      <div className="bg-white p-6 rounded-lg shadow-lg w-full max-w-md">
        <h1 className="text-2xl font-bold mb-6 text-center">Login</h1>
        <form onSubmit={handleSubmit} className="space-y-4">
          <input
            type="email"
            placeholder="Email"
            value={formData.email}
            onChange={(e) =>
              setFormData({ ...formData, email: e.target.value })
            }
            className="w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500"
            required
            autoFocus
          />
          <input
            type="password"
            placeholder="Password"
            value={formData.password}
            onChange={(e) =>
              setFormData({ ...formData, password: e.target.value })
            }
            className="w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500"
            required
            minLength={6}
          />
          <button
            type="submit"
            disabled={isLoading}
            className={`w-full p-2 bg-blue-700 text-white font-semibold rounded-lg hover:bg-blue-800 transition duration-300 ${
              isLoading ? "opacity-70 cursor-not-allowed" : ""
            }`}
          >
            {isLoading ? "Logging in..." : "Login"}
          </button>
        </form>
        <p className="mt-4 text-center">
          New user?{" "}
          <Link to="/register" className="text-blue-500 hover:underline">
            Register here
          </Link>
        </p>
        <button
          onClick={async () => {
            if (!formData.email) {
              toast.error("Please enter your email first.");
              return;
            }

            try {
              await ForgetPassword(formData.email);

              setShowCodeForm(true); // show the next form
            } catch (error) {
              //
            }
          }}
          className="mt-4 text-sm text-blue-600 hover:underline"
        >
          Forgot password?
        </button>
        {showCodeForm && (
          <div className="mt-6">
            <label className="block mb-2 text-sm font-medium text-gray-700">
              Enter the code sent to your email
            </label>
            <input
              type="text"
              placeholder="Verification code"
              value={code}
              onChange={(e) => setCode(e.target.value)}
              className="w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500"
            />
            {/* You can add a Verify button here */}
            <button
              className="mt-3 w-full p-2 bg-green-600 text-white rounded-lg hover:bg-green-700 transition"
              onClick={ResetCodeHandle}
            >
              Verify Code
            </button>
          </div>
        )}
        {showPasswordReset && (
          <div className="mt-6">
            <label className="block mb-2 text-sm font-medium text-gray-700">
              Enter new password
            </label>
            <input
              type="password"
              placeholder="New Password"
              value={newPassword}
              onChange={(e) => setNewPassword(e.target.value)}
              className="w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500"
            />

            <label className="block mt-4 mb-2 text-sm font-medium text-gray-700">
              Confirm password
            </label>
            <input
              type="password"
              placeholder="Confirm Password"
              value={confirmPassword}
              onChange={(e) => setConfirmPassword(e.target.value)}
              className="w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500"
            />

            <button
              className="mt-4 w-full p-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition"
              onClick={handleResetPassword}
            >
              Reset Password
            </button>
          </div>
        )}
      </div>
    </div>
  );
}

export default LoginPage;
