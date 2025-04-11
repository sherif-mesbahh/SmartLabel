import React, { useEffect, useState } from "react";
import { useAuth } from "../../hooks/useAuth";
import { useNavigate, useSearchParams, Link } from "react-router-dom";

function Loginpage() {
  const { user, login } = useAuth();
  const [Username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [usernameerror, setUserNameError] = useState("");
  const [passwordError, setPasswordError] = useState("");
  const navigate = useNavigate();
  const [params] = useSearchParams();
  const redirectTo = params.get("redirect_to") || "/";

  const handleSubmit = async (e) => {
    e.preventDefault();

    // Reset errors
    setUserNameError("");
    setPasswordError("");

    // Input validation
    let valid = true;

    if (password.length < 6) {
      setPasswordError("Password must be at least 6 characters long");
      valid = false;
    }

    if (!valid) return;

    try {
      await login(Username, password);
    } catch (err) {
      // Handle login failure (e.g., incorrect credentials)
      setUserNameError("Incorrect Username or password");
      setPasswordError("Incorrect username or password");
    }
  };

  useEffect(() => {
    if (!user) return;
    if (user) {
      // Redirect only once when user is logged in
      navigate(redirectTo);
    }
  }, [user]);

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-100">
      <div className="bg-white p-6 rounded-lg shadow-lg w-full max-w-md">
        <h1 className="text-2xl font-bold mb-6 text-center">Login Page</h1>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <input
              type="text"
              placeholder="Email"
              value={Username}
              onChange={(e) => setUsername(e.target.value)}
              className={`w-full p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 ${
                user ? "border-red-500" : "border-gray-300"
              }`}
            />
            {usernameerror && (
              <p className="text-red-500 text-sm mt-1">{usernameerror}</p>
            )}
          </div>
          <div>
            <input
              type="password"
              placeholder="Password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className={`w-full p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 ${
                passwordError ? "border-red-500" : "border-gray-300"
              }`}
            />
            {passwordError && (
              <p className="text-red-500 text-sm mt-1">{passwordError}</p>
            )}
          </div>
          <button
            type="submit"
            className="w-full p-2 bg-blue-700 text-white font-semibold rounded-lg hover:bg-blue-800 transition duration-300"
          >
            Login
          </button>
        </form>
        <p className="mt-4 text-center">
          new user ?{" "}
          <Link
            className="text-blue-500 underline"
            to={`/register${redirectTo ? `?redirect_to=` + redirectTo : ``}`}
          >
            Register here
          </Link>
        </p>
      </div>
    </div>
  );
}

export default Loginpage;
