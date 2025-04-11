import React, { useEffect, useState } from "react";
import { useAuth } from "../../hooks/useAuth";
import { useNavigate, useSearchParams, Link } from "react-router-dom";
function RegisterPage() {
  const { register, user } = useAuth();

  const [Username, setUsername] = useState("");
  const [Email, setEmail] = useState("");
  const [Password, setPassword] = useState("");
  const [PhoneNumber, setPhoneNumber] = useState();
  const [error, setError] = useState("");
  const [emailError, setEmailError] = useState("");
  const [passwordError, setPasswordError] = useState("");

  const navigate = useNavigate();
  const [params] = useSearchParams();
  const redirectTo = params.get("redirect_to") || "/";

  const validateEmail = (email) => {
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailPattern.test(email);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    // Reset errors
    setEmailError("");
    setPasswordError("");

    // Input validation
    let valid = true;
    if (!validateEmail(Email)) {
      setEmailError("Invalid email format");
      valid = false;
    }
    if (Password.length < 6) {
      setPasswordError("Password must be at least 6 characters long");
      valid = false;
    }

    if (!valid) return;

    try {
      await register(Username, Password, Email, PhoneNumber);
    } catch (err) {
      setError(err.message);
    }
  };
  useEffect(() => {
    if (!user) return;
    if (user) {
      navigate(redirectTo);
    }
  }, [user]);

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-100">
      <div className="bg-white p-6 rounded-lg shadow-lg w-full max-w-md">
        <h1 className="text-2xl font-bold mb-6 text-center">Register Page</h1>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <input
              type="text"
              placeholder="Name"
              value={Username}
              onChange={(e) => setUsername(e.target.value)}
              className="w-full p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500"
            />
          </div>
          <div>
            <input
              type="email"
              placeholder="Email"
              value={Email}
              onChange={(e) => setEmail(e.target.value)}
              className={`w-full p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 ${
                emailError && "border-red-500"
              }`}
            />
            {emailError && (
              <p className="text-red-500 text-sm mt-1">{emailError}</p>
            )}
          </div>
          <div>
            <input
              type="password"
              placeholder="Password"
              value={Password}
              onChange={(e) => setPassword(e.target.value)}
              className={`w-full p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 ${
                passwordError && "border-red-500"
              }`}
            />
            {passwordError && (
              <p className="text-red-500 text-sm mt-1">{passwordError}</p>
            )}
          </div>

          <div>
            <input
              type="text"
              placeholder="Phone Number"
              value={PhoneNumber}
              onChange={(e) => setPhoneNumber(e.target.value)}
              className="w-full p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500"
            />
          </div>
          <button
            type="submit"
            className="w-full p-2 bg-blue-700 text-white font-semibold rounded-lg hover:bg-blue-800 transition duration-300"
          >
            Register
          </button>
          {error && (
            <p className="text-red-500 text-sm mt-1 text-center">{error}</p>
          )}
        </form>

        <p className="mt-4 text-center">
          Already have an account?{" "}
          <Link
            className="text-blue-500 underline"
            to={`/login${redirectTo ? `?redirect_to=` + redirectTo : ``}`}
          >
            Login
          </Link>
        </p>
      </div>
    </div>
  );
}

export default RegisterPage;
