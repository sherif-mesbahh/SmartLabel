import React from "react";
import { Link } from "react-router-dom";
import { useFavorites } from "../../hooks/useCart";

const ProductCard = React.memo(({ item }) => {
  const { toggleFavorite, favorites } = useFavorites();
  const isFavorite = favorites.items.some((favItem) => favItem.id === item.id);

  return (
    <div className="group bg-white  rounded-2xl shadow-lg overflow-hidden w-[300px] relative hover:shadow-2xl transition-all duration-300 p-4 flex flex-col justify-between border border-gray-100 hover:border-orange-100 ">
      {/* Image Section */}
      <Link
        to={`/food/${item.id}`}
        className="block relative overflow-hidden rounded-xl aspect-square"
      >
        <img
          src={`http://smartlabel1.runasp.net/Uploads/${item.mainImage}`}
          alt={item.name}
          className="w-full h-full object-cover rounded-xl transition-all duration-500 group-hover:scale-110"
          loading="lazy"
        />

        {/* Discount Badge */}
        {item.discount ? (
          <div className="absolute top-3 left-3 bg-gradient-to-r from-[#10EAF0] to-[#24009C] text-white px-3 py-1 rounded-full text-xs font-bold shadow-lg transform -rotate-12 animate-pulse">
            {`${item.discount}% OFF`}
          </div>
        ) : (
          <div className="absolute top-3 left-3 bg-gradient-to-r from-blue-500 to-indigo-600 text-white px-3 py-1 rounded-full text-xs font-bold shadow-lg">
            NEW
          </div>
        )}
      </Link>

      {/* Product Info */}
      <div className="mt-4 px-2">
        <h3 className="text-lg font-bold text-gray-800 line-clamp-2 h-14">
          {item.name}
        </h3>
        <div className="mt-3 flex items-center justify-between">
          <div>
            <span className="text-xl font-bold text-[#0028FF]">
              ${item.newPrice}
            </span>
            {item.oldPrice && (
              <span className="text-gray-400 text-sm line-through ml-2">
                ${item.oldPrice}
              </span>
            )}
          </div>
        </div>
      </div>

      {/* Favorite Button - Moved outside the Quick View Link */}
      <button
        type="button"
        onClick={(e) => {
          e.preventDefault();
          e.stopPropagation(); // Prevent event bubbling
          toggleFavorite(item);
        }}
        className="absolute top-4 right-4 bg-white/90 backdrop-blur-sm p-2 rounded-full shadow-md hover:scale-110 transition-all duration-300 group/fav z-10" // Added z-10
        aria-label={isFavorite ? "Remove from favorites" : "Add to favorites"}
      >
        <svg
          xmlns="http://www.w3.org/2000/svg"
          className={`h-6 w-6 transition-all duration-300 ${
            isFavorite
              ? "fill-[#24009C] scale-110"
              : "fill-gray-300 group-hover/fav:fill-[#10EAF0]"
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

      {/* Quick View Button - Adjusted to not cover the favorite button */}
      <Link
        to={`/food/${item.id}`}
        className="absolute inset-0 flex items-center justify-center opacity-0 group-hover:opacity-100 bg-black/30 transition-opacity duration-300 rounded-xl"
        style={{ pointerEvents: "none" }} // Disable pointer events
      >
        <span
          className="bg-white text-[#10EAF0] px-4 py-2 rounded-full font-medium shadow-lg hover:bg-[#10EAF0] hover:text-white transition-all"
          style={{ pointerEvents: "auto" }} // Re-enable pointer events for the button
        >
          Quick View
        </span>
      </Link>
    </div>
  );
});

ProductCard.displayName = "ProductCard";

export default ProductCard;
