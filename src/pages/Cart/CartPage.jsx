import React, { useEffect } from "react";
import { Link } from "react-router-dom";
import NotFound from "../../component/NotFound";
import { useFavorites } from "../../hooks/useFavorites";

function FavoritesPage() {
  const { favorites, DeleteFavorite, isLoading, refreshFavorites } =
    useFavorites();

  // Refresh favorites when the page loads
  useEffect(() => {
    refreshFavorites();
  }, [refreshFavorites]);

  if (isLoading) {
    return (
      <div className="flex justify-center items-center min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 dark:from-gray-900 dark:to-gray-800">
        <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-blue-500"></div>
      </div>
    );
  }

  return (
    <div className="flex justify-center items-center min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 dark:from-gray-900 dark:to-gray-800 p-4 sm:p-8">
      {favorites.items.length === 0 ? (
        <NotFound message={"Your favorites list is empty"} />
      ) : (
        <div className="w-full max-w-3xl mx-auto bg-white/95 dark:bg-gray-800/95 backdrop-blur-lg shadow-xl rounded-3xl overflow-hidden animate-fade-in">
          {/* Header with decorative elements */}
          <div className="relative bg-gradient-to-r from-blue-600 to-indigo-700 dark:from-blue-700 dark:to-indigo-800 p-6 text-center">
            <div className="absolute -top-4 -left-4 w-16 h-16 bg-yellow-400 rounded-full mix-blend-multiply opacity-20"></div>
            <div className="absolute -bottom-4 -right-4 w-20 h-20 bg-pink-400 rounded-full mix-blend-multiply opacity-20"></div>
            <h2 className="relative z-10 text-3xl font-bold text-white tracking-wide">
              Your Favorites
              <span className="block mt-2 text-sm font-normal text-blue-100 opacity-90">
                {favorites.items.length}{" "}
                {favorites.items.length === 1 ? "item" : "items"}
              </span>
            </h2>
          </div>

          {/* Favorites list with floating card effect */}
          <div className="p-6">
            <ul className="space-y-4">
              {favorites.items.map((item) => (
                <li
                  key={item.id}
                  className="relative flex justify-between items-center bg-white p-4 rounded-xl shadow-sm hover:shadow-md transition-all duration-300 border border-gray-100 hover:border-blue-100"
                >
                  <div className="absolute -left-1 top-1/2 transform -translate-y-1/2 w-2 h-16 bg-gradient-to-b"></div>

                  <div className="flex items-center gap-4 pl-3">
                    <div className="relative">
                      <img
                        src={`http://smartlabel1.runasp.net/Uploads/${item.mainImage}`}
                        alt={item.name}
                        className="w-20 h-24 object-cover rounded-lg shadow-md border-2 border-white ring-2 ring-blue-200 transform hover:scale-105 transition-transform duration-300"
                      />
                      <div className="absolute -bottom-2 -right-2 bg-blue-500 text-white text-xs font-bold px-2 py-1 rounded-full shadow">
                        ${item.newPrice}
                      </div>
                    </div>
                    <Link
                      to={`/food/${item.id}`}
                      className="text-lg font-semibold text-gray-800 hover:text-blue-600 transition-colors duration-200"
                    >
                      {item.name}
                    </Link>
                  </div>

                  <button
                    type="button"
                    onClick={() => DeleteFavorite(item)}
                    className="p-2 rounded-full hover:bg-red-50 transition-colors duration-200 group"
                    disabled={isLoading}
                  >
                    <span className="relative">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        className={`h-6 w-6 transition-all duration-300 
                fill-red-500 scale-110
               ${isLoading ? "opacity-50" : ""}
          `}
                        viewBox="0 0 24 24"
                        stroke="currentColor"
                        strokeWidth="2"
                      >
                        <path
                          strokeLinecap="round"
                          strokeLinejoin="round"
                          d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"
                        />
                      </svg>
                    </span>
                  </button>
                </li>
              ))}
            </ul>
          </div>
        </div>
      )}
    </div>
  );
}

export default FavoritesPage;
