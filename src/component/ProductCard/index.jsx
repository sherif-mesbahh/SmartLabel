import React from "react";
import { Link } from "react-router-dom";
import { useFavorites } from "../../hooks/useCart";

const ProductCard = React.memo(({ item }) => {
  const { toggleFavorite, favorites } = useFavorites();
  const isFavorite = favorites.items.some((favItem) => favItem.id === item.id);

  return (
    <div className="bg-white dark:bg-gray-800 rounded-2xl shadow-lg overflow-hidden transform transition-all duration-300 hover:shadow-xl">
      <div className="relative">
        <img
          src={`http://smartlabel1.runasp.net/Uploads/${item.mainImage}`}
          alt={item.name}
          className="w-full h-48 object-cover"
        />
        <div className="absolute top-2 right-2">
          <button
            onClick={() => toggleFavorite(item)}
            className="p-2 rounded-full bg-white/80 dark:bg-gray-800/80 backdrop-blur-sm hover:bg-white dark:hover:bg-gray-700 transition-colors"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              className={`h-6 w-6 transition-all duration-300 ${
                favorites.items.some((fav) => fav.id === item.id)
                  ? "fill-red-500 text-red-500"
                  : "text-gray-400 dark:text-gray-500"
              }`}
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
          </button>
        </div>
      </div>
      <div className="p-4">
        <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-2">
          {item.name}
        </h3>
        <p className="text-sm text-gray-600 dark:text-gray-400 mb-4 line-clamp-2">
          {item.description}
        </p>
        <div className="flex justify-between items-center">
          <div className="flex items-center space-x-2">
            <span className="text-lg font-bold text-blue-600 dark:text-blue-400">
              ${item.newPrice}
            </span>
            {item.oldPrice && (
              <span className="text-sm text-gray-500 dark:text-gray-400 line-through">
                ${item.oldPrice}
              </span>
            )}
          </div>
          <Link
            to={`/food/${item.id}`}
            className="px-4 py-2 bg-blue-600 hover:bg-blue-700 dark:bg-blue-500 dark:hover:bg-blue-600 text-white rounded-lg transition-colors"
          >
            View Details
          </Link>
        </div>
      </div>
    </div>
  );
});

ProductCard.displayName = "ProductCard";

export default ProductCard;
