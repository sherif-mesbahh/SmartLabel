import React, { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";
import {
  addCategory,
  getAllByCat,
  updateCategory,
} from "../../services/foodServices";
import { toast } from "react-toastify";
import { useAuth } from "../../hooks/useAuth";

function CategoryEditPage() {
  const { foodId } = useParams();
  const isEditMode = !!foodId;
  const [foods, setfoods] = useState([]);
  const [Image, setImageUrl] = useState();
  const [Name, setName] = useState("");

  const navigate = useNavigate();
  const { user } = useAuth();

  useEffect(() => {
    if (!isEditMode) return;
    getAllByCat(foodId).then((food) => {
      setfoods(food.data);
      setName(food.data.name);
      setImageUrl(food.data.imageUrl);
    });
  }, [foodId, isEditMode]);

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (isEditMode) {
      await updateCategory(foodId, Name, Image);
      toast.success(`Category "${Name}" updated successfully`);
    } else {
      const newFood = await addCategory(Name, Image);
      toast.success(`Category "${Name}" added successfully`);
      navigate(`/admin/editfood/${newFood.id}`, { replace: true });
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 dark:from-gray-900 dark:to-gray-800 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-3xl mx-auto">
        <div className="text-center mb-12">
          <h1 className="text-4xl md:text-5xl font-extrabold text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-indigo-800 dark:from-blue-400 dark:to-indigo-600 mb-4">
            {isEditMode ? "Edit Category" : "Add Category"}
          </h1>
          <p className="text-lg text-gray-600 dark:text-gray-300">
            {isEditMode ? "Update your category information" : "Create a new category"}
          </p>
        </div>

        <div className="bg-white dark:bg-gray-800 rounded-2xl shadow-lg overflow-hidden">
          <div className="p-6">
            <form onSubmit={handleSubmit} className="space-y-6">
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                  Name
                </label>
                <input
                  type="text"
                  placeholder="Enter category name"
                  onChange={(e) => setName(e.target.value)}
                  value={Name}
                  className="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 focus:border-transparent dark:bg-gray-700 dark:text-white transition-colors"
                  required
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                  Category Image
                </label>
                <input
                  type="file"
                  accept="image/*"
                  onChange={(e) => setImageUrl(e.target.files[0])}
                  className="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 focus:border-transparent dark:bg-gray-700 dark:text-white transition-colors file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-blue-50 file:text-blue-700 dark:file:bg-blue-900 dark:file:text-blue-300 hover:file:bg-blue-100 dark:hover:file:bg-blue-800"
                />
                {Image && typeof Image === "string" && (
                  <div className="mt-4">
                    <img
                      src={`http://smartlabel1.runasp.net/Uploads/${Image}`}
                      alt="Category Preview"
                      className="w-full h-48 object-cover rounded-lg shadow-md"
                    />
                  </div>
                )}
              </div>

              <div className="flex justify-end">
                <button
                  type="submit"
                  className="px-8 py-3 bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-700 hover:to-indigo-700 dark:from-blue-500 dark:to-indigo-500 dark:hover:from-blue-600 dark:hover:to-indigo-600 text-white rounded-lg transition-all duration-300 transform hover:scale-105 font-medium"
                >
                  {isEditMode ? "Update Category" : "Add Category"}
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  );
}

export default CategoryEditPage;
