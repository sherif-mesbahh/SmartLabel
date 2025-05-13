import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { deleteCategory, getAllCat } from "../../services/foodServices";
import { toast } from "react-toastify";

function CategoriesAdminPage() {
  const [foods, setFoods] = useState();

  useEffect(() => {
    LoadFoods();
  }, []);

  const LoadFoods = async () => {
    const foods = await getAllCat();
    setFoods(foods.data);
  };

  const DeleteFood = async (food) => {
    const confirmed = window.confirm("Are you sure you want to delete?");
    if (!confirmed) return;
    await deleteCategory(food.id);
    toast.success(`"${food.name}" has been deleted`);
    setFoods(foods.filter((f) => f.id !== food.id));
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 dark:from-gray-900 dark:to-gray-800 py-12 px-4 sm:px-6 lg:px-8">
  <div className="max-w-7xl mx-auto">
    {/* Header */}
    <div className="text-center mb-12">
      <h1 className="text-4xl md:text-5xl font-extrabold text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-indigo-800 dark:from-blue-400 dark:to-indigo-600 mb-4">
        Manage Categories
      </h1>
      <Link
        to="/admin/addcategory"
        className="px-5 py-2 bg-blue-600 hover:bg-blue-700 dark:bg-blue-500 dark:hover:bg-blue-600 text-white rounded-full text-sm font-medium shadow transition-colors"
      >
        + Add Category
      </Link>
    </div>

    {/* Category Cards */}
    <div className="bg-white dark:bg-gray-800 rounded-2xl shadow-lg overflow-hidden p-6">
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {foods &&
          foods.map((food) => (
            <div
              key={food.id}
              className="bg-gray-50 dark:bg-gray-700 rounded-xl overflow-hidden"
            >
              <div className="relative">
                <Link to={`/category/${food.id}`}>
                  <img
                    src={`http://smartlabel1.runasp.net/Uploads/${food.imageUrl}`}
                    alt={food.name}
                    className="w-full h-48 object-cover"
                  />
                </Link>
              </div>

              <div className="p-4 text-center">
                <h3 className="text-xl font-semibold text-white dark:text-white">
                  {food.name}
                </h3>

                <div className="flex justify-center space-x-3 mt-4">
                  <Link
                    to={`/admin/addfood/${food.id}`}
                    className="px-4 py-1 bg-blue-600 hover:bg-blue-700 dark:bg-blue-500 dark:hover:bg-blue-600 text-white rounded-full text-sm font-medium transition-colors"
                  >
                    Add Food +
                  </Link>
                  <Link
                    to={`/admin/editcategory/${food.id}`}
                    className="px-4 py-1 bg-blue-600 hover:bg-blue-700 dark:bg-blue-500 dark:hover:bg-blue-600 text-white rounded-full text-sm transition-colors"
                  >
                    Edit
                  </Link>
                  <button
                    onClick={() => DeleteFood(food)}
                    className="px-4 py-1 bg-red-600 hover:bg-red-700 dark:bg-red-500 dark:hover:bg-red-600 text-white rounded-full text-sm transition-colors"
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
</div>

  );
}

export default CategoriesAdminPage;
