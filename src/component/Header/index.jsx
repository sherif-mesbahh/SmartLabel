import React, { useState } from "react";
import { Link } from "react-router-dom";
import { useFavorites } from "../../hooks/useCart";
import { useAuth } from "../../hooks/useAuth";
import logo from "../../../public/img/logo.png";

function Header() {
  const { user, logout } = useAuth();
  const { favorites } = useFavorites();
  const [menuOpen, setMenuOpen] = useState(false);

  return (
    <header className="sticky top-0 z-50">
      {/* MAIN HEADER */}
      <div className="bg-white shadow-sm border-b border-gray-100 py-4 backdrop-blur-sm bg-white/90">
        <div className="container mx-auto flex justify-between items-center px-4">
          {/* Logo */}
          <Link
            to="/"
            className="logo transition-transform hover:scale-105 active:scale-95"
          >
            <img
              src={logo}
              alt="Logo"
              className="h-10 md:h-12 object-contain"
            />
          </Link>

          {/* Desktop Navigation */}
          <nav className="hidden md:flex items-center space-x-8">
            <Link
              to="/dashboard"
              className="text-gray-700 hover:text-blue-600 font-medium transition-colors relative group"
            >
              Dashboard
              <span className="absolute bottom-0 left-0 w-0 h-0.5 bg-blue-600 transition-all duration-300 group-hover:w-full"></span>
            </Link>

            {user ? (
              <button
                onClick={logout}
                className="text-gray-700 hover:text-blue-600 font-medium transition-colors relative group"
              >
                Logout
                <span className="absolute bottom-0 left-0 w-0 h-0.5 bg-blue-600 transition-all duration-300 group-hover:w-full"></span>
              </button>
            ) : (
              <Link
                to="/login"
                className="text-gray-700 hover:text-blue-600 font-medium transition-colors relative group"
              >
                Login
                <span className="absolute bottom-0 left-0 w-0 h-0.5 bg-blue-600 transition-all duration-300 group-hover:w-full"></span>
              </Link>
            )}

            <Link
              to="/fav"
              className="relative p-2 group"
              aria-label="Wishlist"
            >
              <div className="relative">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  className="h-9 w-9 text-gray-400 group-hover:text-[#24009C] transition-colors"
                  fill={favorites.totalCount > 0 ? "#24009C" : "none"}
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth="2"
                    d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"
                  />
                </svg>
                {favorites.totalCount > 0 && (
                  <span className="absolute -top-1 -right-1 w-4 h-4 flex items-center justify-center bg-[#10EAF0] text-white text-xs font-bold rounded-full transform group-hover:scale-110 transition-transform">
                    {favorites.totalCount}
                  </span>
                )}
              </div>
            </Link>
          </nav>

          {/* Mobile Menu Button */}
          <button
            className="md:hidden text-gray-700 focus:outline-none p-2 rounded-full hover:bg-gray-100 transition-colors"
            onClick={() => setMenuOpen(!menuOpen)}
            aria-label="Toggle menu"
          >
            {menuOpen ? (
              <svg
                className="w-6 h-6"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth="2"
                  d="M6 18L18 6M6 6l12 12"
                />
              </svg>
            ) : (
              <svg
                className="w-6 h-6"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth="2"
                  d="M4 6h16M4 12h16M4 18h16"
                />
              </svg>
            )}
          </button>
        </div>

        {/* Mobile Menu */}
        <div
          className={`md:hidden bg-white shadow-lg transition-all duration-300 ease-in-out overflow-hidden ${
            menuOpen ? "max-h-96 py-4" : "max-h-0 py-0"
          }`}
        >
          <div className="container mx-auto px-4 flex flex-col space-y-4">
            <Link
              to="/dashboard"
              className="text-gray-700 hover:text-blue-600 font-medium py-2 transition-colors border-b border-gray-100"
              onClick={() => setMenuOpen(false)}
            >
              Dashboard
            </Link>

            {user ? (
              <button
                onClick={() => {
                  logout();
                  setMenuOpen(false);
                }}
                className="text-gray-700 hover:text-blue-600 font-medium py-2 transition-colors border-b border-gray-100 text-left"
              >
                Logout
              </button>
            ) : (
              <Link
                to="/login"
                className="text-gray-700 hover:text-blue-600 font-medium py-2 transition-colors border-b border-gray-100"
                onClick={() => setMenuOpen(false)}
              >
                Login
              </Link>
            )}

            <Link
              to="/fav"
              className="text-gray-700 hover:text-red-500 font-medium py-2 transition-colors flex items-center space-x-2"
              onClick={() => setMenuOpen(false)}
            >
              <span>Wishlist</span>
              {favorites.totalCount > 0 && (
                <span className="w-2 h-2 flex items-center justify-center bg-red-500 text-white text-xs font-bold rounded-full">
                  {favorites.totalCount}
                </span>
              )}
            </Link>
          </div>
        </div>
      </div>
    </header>
  );
}

export default Header;
