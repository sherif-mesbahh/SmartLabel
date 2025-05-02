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
    <div className="p-8 bg-gray-50 min-h-screen">
      <div className="text-center mb-8">
        <h1 className="text-3xl font-bold text-gray-800 mb-4">
          Manage Categories
        </h1>
        <Link
          to="/admin/addcategory"
          className="bg-blue-600 text-white rounded-full px-5 py-2 text-sm font-medium shadow hover:bg-blue-800 transition duration-200"
        >
          + Add Category
        </Link>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        {foods &&
          foods.map((food) => (
            <div
              key={food.id}
              className="bg-white rounded-2xl shadow-md p-4 hover:shadow-lg transition duration-300"
            >
              <div className="relative">
                <Link to={`/category/${food.id}`}>
                  <img
                    src={`http://smartlabel1.runasp.net/Uploads/${food.imageUrl}`}
                    alt={food.name}
                    className="w-full h-48 object-cover rounded-xl"
                  />
                </Link>
              </div>

              <div className="mt-3 text-center">
                <h3 className="text-lg font-semibold text-gray-700">
                  {food.name}
                </h3>
              </div>

              <div className="flex justify-center space-x-4 mt-4">
                <Link
                  to={`/admin/addfood/${food.id}`}
                  className="bg-blue-600 hover:bg-blue-800 text-white rounded-full px-5 py-2 font-medium transition duration-200"
                >
                  Add Food +
                </Link>
                <Link
                  to={`/admin/editcategory/${food.id}`}
                  className="bg-blue-600 text-white px-4 py-1 rounded-full text-sm hover:bg-blue-800 transition"
                >
                  Edit
                </Link>
                <button
                  onClick={() => DeleteFood(food)}
                  className="bg-red-500 text-white px-4 py-1 rounded-full text-sm hover:bg-red-600 transition"
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

export default CategoriesAdminPage;
