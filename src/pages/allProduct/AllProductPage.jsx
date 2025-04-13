import React, { useEffect, useState } from "react";
import { getAll, search as searchFoods } from "../../services/foodServices";
import { Link, useParams } from "react-router-dom";
import { useFavorites } from "../../hooks/useCart";
import Search from "../../component/Search";
import { useLocation } from "react-router-dom";
function useQuery() {
  return new URLSearchParams(useLocation().search);
}
function AllProductPage() {
  const { toggleFavorite, favorites } = useFavorites();
  const [foods, setFoods] = useState([]);

  const query = useQuery();
  const searchTerm = query.get("Search");
  useEffect(() => {
    if (searchTerm) {
      searchFoods(searchTerm).then((data) => {
        setFoods(data.data);
        console.log(data.data);
      });
    } else {
      getAll().then((data) => setFoods(data.data));
    }
  }, [searchTerm]);
  const AddItemHandle = (item) => {
    toggleFavorite(item);
  };

  const isFavorite = (item) => {
    return favorites.items.some((favItem) => favItem.food.id === item.id);
  };

  return (
    <div className="min-h-screen bg-gray-50 py-10 px-4">
      <h1 className="text-4xl font-bold text-center text-blue-700 mb-10 uppercase">
        All Products
      </h1>
      <Search />

      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
        {foods &&
          foods.map((food) => (
            <div
              key={food.id}
              className="bg-white rounded-xl shadow-lg overflow-hidden transition-transform hover:scale-[1.02]"
            >
              <div className="relative">
                <Link to={`/food/${food.id}`}>
                  <img
                    src={`http://smartlabel1.runasp.net/Uploads/${food.imageUrl}`}
                    alt={food.name}
                    className="w-full h-48 object-cover"
                  />
                </Link>
                <div className="absolute top-2 left-2 bg-blue-600 text-white px-3 py-1 rounded-full text-xs font-semibold">
                  {food.discount ? `${food.discount}% OFF` : "NEW"}
                </div>
              </div>

              <div className="p-4 text-center">
                <h3 className="text-lg font-bold text-gray-800 mb-1">
                  {food.name}
                </h3>
                <p className="text-blue-600 font-bold text-lg">
                  ${food.newPrice}
                  <span className="text-sm text-gray-400 line-through ml-2">
                    {food.oldPrice}
                  </span>
                </p>

                <button
                  onClick={() => AddItemHandle(food)}
                  className="mt-3"
                  title="Add to Favorites"
                >
                  <i
                    className={`fa fa-heart ${
                      isFavorite(food) ? "text-red-600" : "text-gray-400"
                    } text-2xl hover:scale-110 transition-transform`}
                  ></i>
                </button>
              </div>
            </div>
          ))}
      </div>
    </div>
  );
}

export default AllProductPage;
