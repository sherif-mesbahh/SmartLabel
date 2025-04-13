import React from "react";
import { Link } from "react-router-dom";
import NotFound from "../../component/NotFound";
import { useFavorites } from "../../hooks/useCart";

function FavoritesPage() {
  const { favorites, clearFavorites, DeleteFavorite } = useFavorites();
  console.log(favorites.items);
  return (
    <div className="flex justify-center p-6">
      {favorites.items.length === 0 ? (
        <NotFound message={"No favorite items yet!"} />
      ) : (
        <div className="w-full max-w-2xl mx-auto bg-white shadow-lg rounded-lg p-6">
          <h2 className="text-xl font-bold text-gray-800 text-center mb-4">
            Your Favorites
          </h2>
          <ul className="divide-y divide-gray-300">
            {favorites.items.map((item) => (
              <li
                key={item.id}
                className="flex justify-between items-center py-4 px-2 hover:bg-gray-100 rounded-lg transition duration-200"
              >
                <div className="flex items-center gap-4">
                  <img
                    src={`http://smartlabel1.runasp.net/Uploads/${item.imageUrl}`}
                    alt={item.name}
                    className="w-24 h-32 object-cover rounded-md shadow-md"
                  />
                  <Link
                    to={`/food/${item.id}`}
                    className="text-lg font-semibold text-blue-600 hover:underline"
                  >
                    {item.name}
                  </Link>
                </div>
                <button
                  className="text-red-500 text-2xl hover:scale-110 transition-transform"
                  onClick={() => DeleteFavorite(item)}
                >
                  ❤️
                </button>
              </li>
            ))}
          </ul>
          <div className="mt-6 text-center">
            <button
              className="px-4 py-2 bg-red-500 text-white rounded-md shadow hover:bg-red-600 transition"
              onClick={clearFavorites}
            >
              Clear All Favorites
            </button>
          </div>
        </div>
      )}
    </div>
  );
}

export default FavoritesPage;
