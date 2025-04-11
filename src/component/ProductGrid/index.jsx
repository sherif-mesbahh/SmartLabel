import React, { useState } from "react";
import { useFavorites } from "../../hooks/useCart";
import { Link } from "react-router-dom";

function ProductGrid({ food }) {
  const { toggleFavorite, favorites } = useFavorites();
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 8;
  console.log(food);
  const isFavorite = (item) =>
    favorites.items.some((fav) => fav.food.id === item.id);

  return (
    <div className="mb-12">
      <div className="max-w-7xl mx-auto px-4 grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
        {food.map((item) => (
          <div
            key={item.id}
            className="bg-white rounded-lg shadow-md p-4 relative hover:shadow-xl transition-shadow duration-300"
          >
            <Link to={`/food/${item.id}`} className="relative">
              <img
                src={`http://smartlabel1.runasp.net/Uploads/${item.imageUrl}`}
                alt={item.name}
                className="w-full h-48 object-cover rounded-lg"
              />
              <div className="absolute top-2 left-2 bg-blue-600 text-white px-2 py-1 rounded text-xs">
                {item.discount ? `-${item.discount}%` : "NEW"}
              </div>
            </Link>
            <div className="mt-3 text-center">
              <h3 className="text-lg font-semibold text-blue-600">
                {item.name}
              </h3>
              <h4 className=" font-bold">
                ${item.price}{" "}
                <del className="text-gray-400 text-sm">${item.oldPrice}</del>
              </h4>
            </div>
            <button onClick={() => toggleFavorite(item)}>
              <i
                className={`fa fa-heart text-2xl hover:scale-110 transition-transform ${
                  isFavorite(item) ? "text-red-600" : "text-slate-500"
                }`}
              ></i>
            </button>
          </div>
        ))}
      </div>

      {food.length > itemsPerPage && (
        <div className="flex justify-center mt-6">
          <nav aria-label="Product pagination">
            <ul className="inline-flex -space-x-px">
              {Array.from(
                { length: Math.ceil(food.length / itemsPerPage) },
                (_, i) => (
                  <li key={i}>
                    <button
                      onClick={() => setCurrentPage(i + 1)}
                      className={`py-2 px-3 text-gray-500 border border-gray-300 hover:bg-gray-100 hover:text-gray-700 ${
                        currentPage === i + 1 ? "bg-white text-teal-400" : ""
                      }`}
                    >
                      {i + 1}
                    </button>
                  </li>
                )
              )}
            </ul>
          </nav>
        </div>
      )}
    </div>
  );
}

export default ProductGrid;
