import React, { useEffect } from "react";
import { Link } from "react-router-dom";
import { useFavorites } from "../../hooks/useFavorites";

const ProductCard = React.memo(({ item }) => {
  const { toggleFavorite, favorites, updateFavoriteItem, isLoading } =
    useFavorites();
  const isFavorite = favorites.items.some((favItem) => favItem.id === item.id);

  // Update favorite item when the product data changes
  useEffect(() => {
    if (isFavorite) {
      updateFavoriteItem(item);
    }
  }, [item, isFavorite, updateFavoriteItem]);

  return (
    <div className="bg-white max-h-[350px] min-h-[350px] dark:bg-gray-800 rounded-2xl shadow-lg overflow-hidden transform transition-all duration-300 hover:shadow-xl">
      <div className="relative">
        <img
          src={`http://smartlabel1.runasp.net/Uploads/${item.mainImage}`}
          alt={item.name}
          className="w-full h-48 object-cover"
        />
        <div className="absolute top-2 left-2 bg-blue-600 text-white px-2 py-1 rounded text-xs font-semibold">
          {item.discount ? `${item.discount}%` : "Regular"}
        </div>
        <div className="absolute top-2 right-2 shadow-xl rounded-full">
          <button
            onClick={() => toggleFavorite(item)}
            disabled={isLoading}
            className="p-2 rounded-full bg-white/80 dark:bg-gray-800/80 backdrop-blur-sm hover:bg-white dark:hover:bg-gray-700 transition-colors"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              className={`h-6 w-6 transition-all duration-300 ${
                isFavorite
                  ? "fill-red-500 text-red-500"
                  : "text-gray-400 dark:text-gray-500"
              } ${isLoading ? "opacity-50" : ""}`}
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
        <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-2 max-w-[55ch] truncate">
          {item.name}
        </h3>
        <p className="text-sm text-gray-600 dark:text-gray-400 mb-4 line-clamp-2">
          {item.description}
        </p>
        <div className="flex justify-between items-center flex-col gap-2 ">
          <div className="text-gray-700 dark:text-gray-300 text-base font-medium flex items-center gap-2">
            <span className="  text-lg">${item.newPrice.toFixed(2)}</span>
            {item.oldPrice && item.discount !== 0 && (
              <span className="text-lg text-gray-500 dark:text-red-400 line-through">
                ${item.oldPrice.toFixed(2)}
              </span>
            )}
          </div>
          <Link
            to={`/product/${item.id}`}
            className="px-2 py-2  w-3/4 mx-auto text-center bg-blue-600 hover:bg-blue-700 dark:bg-blue-500 dark:hover:bg-blue-600 text-white rounded-lg transition-colors"
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
