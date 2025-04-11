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
    <header>
      {/* MAIN HEADER */}
      <div id="header" className="bg-white shadow-md py-4">
        <div className="container mx-auto flex justify-between items-center px-4">
          <div className="header-logo">
            <Link to="/" className="logo">
              <img src={logo} alt="Logo" className="h-10" />
            </Link>
          </div>

          {/* Desktop Menu */}
          <div className="hidden md:flex items-center space-x-6">
            <Link className="text-blue-600" to="/dashboard">
              Dashboard
            </Link>
            {user ? (
              <button onClick={logout} className="text-blue-600">
                Logout
              </button>
            ) : (
              <Link className="text-blue-600" to="/login">
                Login
              </Link>
            )}
            <Link to="/fav" className="relative">
              <i className=" ">❤️</i>
              <span className="absolute -top-2 -right-3 w-4 h- text-xs flex items-center justify-center bg-blue-400 text-white rounded-full">
                {favorites.totalCount}
              </span>
            </Link>
          </div>

          {/* Mobile Menu Button */}
          <button
            className="md:hidden text-gray-700 focus:outline-none"
            onClick={() => setMenuOpen(!menuOpen)}
          >
            <i className="fa fa-bars text-2xl"></i>
          </button>
        </div>

        {/* Mobile Menu */}
        {menuOpen && (
          <div className="md:hidden bg-white shadow-md p-4 flex flex-col space-y-4">
            <Link
              to="/dashboard"
              className="text-blue-600"
              onClick={() => setMenuOpen(false)}
            >
              Dashboard
            </Link>
            {user ? (
              <button onClick={logout} className="text-blue-600">
                Logout
              </button>
            ) : (
              <Link
                to="/login"
                className="text-blue-600"
                onClick={() => setMenuOpen(false)}
              >
                Login
              </Link>
            )}
            <Link
              to="/fav"
              className="text-red-500 relative"
              onClick={() => setMenuOpen(false)}
            >
              <i className="fa fa-heart"></i> Your Wishlist
              <span className="absolute -top-2 -right-2 w-5 h-5 text-xs flex items-center justify-center bg-red-500 text-white rounded-full">
                {favorites.totalCount}
              </span>
            </Link>
          </div>
        )}
      </div>
    </header>
  );
}

export default Header;
