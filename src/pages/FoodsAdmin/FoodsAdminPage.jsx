import React, { useEffect, useState } from "react";
import { Link, useLocation } from "react-router-dom";
import {
  DeleteFoodId,
  getAll,
  search as SearchFood,
} from "../../services/foodServices";
import Search from "../../component/Search";
import { toast } from "react-toastify";

function useQuery() {
  return new URLSearchParams(useLocation().search);
}

function FoodsAdminPage() {
  const [foods, setFoods] = useState([]);
  const query = useQuery();
  const searchTerm = query.get("Search");

  useEffect(() => {
    LoadFoods();
  }, [searchTerm]);

  const LoadFoods = async () => {
    const foods = searchTerm ? await SearchFood(searchTerm) : await getAll();
    setFoods(foods.data);
  };

  const DeleteFood = async (food) => {
    const confirmed = window.confirm("Are you sure you want to delete?");
    if (!confirmed) return;
    await DeleteFoodId(food.id);
    toast.success(`"${food.name}" has been deleted`);
    setFoods(foods.filter((f) => f.id !== food.id));
  };

  return (
    <div className="p-6 sm:p-8 bg-gray-50 min-h-screen">
      <div className="text-center mb-8">
        <h1 className="text-3xl font-bold text-gray-800 mb-4">Manage Foods</h1>
        <div className="flex flex-col sm:flex-row items-center justify-center gap-4 mb-6">
          <Search defaultRoute="/admin/foods/" />
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {foods.map((food) => (
          <div
            key={food.id}
            className="bg-white rounded-xl shadow-md hover:shadow-xl transition duration-300 p-4"
          >
            <div className="relative">
              <Link to={`/food/${food.id}`}>
                <img
                  src={`http://smartlabel1.runasp.net/Uploads/${food.mainImage}`}
                  alt={food.name}
                  className="w-full h-48 object-cover rounded-lg"
                />
              </Link>
              <div className="absolute top-2 left-2 bg-blue-600 text-white px-2 py-1 rounded text-xs font-semibold">
                {food.discount ? `${food.discount}%` : "NEW"}
              </div>
            </div>

            <div className="mt-4 text-center">
              <h3 className="text-lg font-semibold text-blue-600">
                {food.name}
              </h3>
              <div className="text-gray-700 mt-1 text-base font-medium">
                ${food.newPrice.toFixed(2)}
                {food.oldPrice && (
                  <span className="text-sm text-gray-400 ml-2 line-through">
                    ${food.oldPrice.toFixed(2)}
                  </span>
                )}
              </div>
            </div>

            <div className="flex justify-center gap-4 mt-4">
              <Link
                to={`/admin/editfood/${food.id}`}
                className="bg-blue-600 hover:bg-blue-800 text-white px-4 py-1 rounded-lg transition duration-200"
              >
                Edit
              </Link>
              <button
                onClick={() => DeleteFood(food)}
                className="bg-red-600 hover:bg-red-700 text-white px-4 py-1 rounded-lg transition duration-200"
              >
                Delete
              </button>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

export default FoodsAdminPage;
