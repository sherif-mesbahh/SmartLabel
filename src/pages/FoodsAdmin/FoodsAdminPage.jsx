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
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 dark:from-gray-900 dark:to-gray-800 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-7xl mx-auto">
        {/* Header */}
        <div className="text-center mb-12">
          <h1 className="text-4xl md:text-5xl p-2 font-extrabold text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-indigo-800 dark:from-blue-400 dark:to-indigo-600 mb-4">
            Manage Products
          </h1>
          <div className="flex flex-col sm:flex-row items-center justify-center gap-4 mb-6">
            <Search
              defaultRoute="/admin/products/"
              placeholder="Search Products"
            />
          </div>
        </div>

        {/* Food Cards */}
        <div className="bg-white dark:bg-gray-800 rounded-2xl shadow-lg overflow-hidden p-6">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {foods.map((food) => (
              <div
                key={food.id}
                className="bg-gray-50 dark:bg-gray-700 rounded-xl overflow-hidden shadow-[6px_6px_10px_0px_rgba(0,0,0,0.6)]"
              >
                <div className="relative">
                  <Link to={`/product/${food.id}`}>
                    <img
                      src={`http://smartlabel1.runasp.net/Uploads/${food.mainImage}`}
                      alt={food.name}
                      className="w-full h-48 object-cover"
                    />
                  </Link>
                  <div className="absolute top-2 left-2 bg-blue-600 text-white px-2 py-1 rounded text-xs font-semibold">
                    {food.discount ? `${food.discount}%` : "Regular"}
                  </div>
                </div>

                <div className="p-4 text-center">
                  <h3 className="text-xl font-semibold text-black dark:text-white mb-1">
                    {food.name}
                  </h3>
                  <div className="text-gray-700 dark:text-gray-300 text-base font-medium flex items-center gap-2">
                    <span className="  text-lg">
                      ${food.newPrice.toFixed(2)}
                    </span>
                    {food.oldPrice && food.discount !== 0 && (
                      <span className="text-lg text-gray-500 dark:text-red-400 line-through">
                        ${food.oldPrice.toFixed(2)}
                      </span>
                    )}
                  </div>

                  <div className="flex justify-center gap-4 mt-4">
                    <Link
                      to={`/admin/editfood/${food.id}`}
                      className="px-4 py-1 bg-blue-600 hover:bg-blue-700 dark:bg-blue-500 dark:hover:bg-blue-600 text-white rounded-lg transition-colors"
                    >
                      Edit
                    </Link>
                    <button
                      onClick={() => DeleteFood(food)}
                      className="px-4 py-1 bg-red-600 hover:bg-red-700 dark:bg-red-500 dark:hover:bg-red-600 text-white rounded-lg transition-colors"
                    >
                      Delete
                    </button>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
      {/* Footer */}
    </div>
  );
}

export default FoodsAdminPage;
