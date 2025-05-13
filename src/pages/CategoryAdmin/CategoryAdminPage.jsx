import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { DeleteCategoryId, getCategories } from "../../services/foodServices";
import { toast } from "react-toastify";

function CategoryAdminPage() {
  const [Categories, setCategories] = useState();

  useEffect(() => {
    loadCategories();
  }, []);

  const loadCategories = async () => {
    const response = await getCategories();
    setCategories(response.data.data);
  };

  const deleteCategory = async (category) => {
    const confirmed = window.confirm("Are you sure you want to delete?");
    if (!confirmed) return;

    await DeleteCategoryId(category.id);
    toast.success(`"${category.name}" has been deleted`);
    setCategories(Categories.filter((c) => c.id !== category.id));
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 dark:from-gray-900 dark:to-gray-800 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-7xl mx-auto">
        {/* Header Section */}
        <div className="text-center mb-12">
          <h1 className="text-4xl md:text-5xl font-extrabold text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-indigo-800 dark:from-blue-400 dark:to-indigo-600 mb-4">
            Category Administration
          </h1>
          <p className="text-lg text-gray-600 dark:text-gray-300 max-w-2xl mx-auto">
            Manage and organize your food categories
          </p>
        </div>

        {/* Category List */}
        <div className="bg-white dark:bg-gray-800 rounded-2xl shadow-lg overflow-hidden">
          <div className="p-6">
            <div className="flex justify-between items-center mb-6">
              <h2 className="text-2xl font-bold text-gray-900 dark:text-white">
                Categories
              </h2>
              <Link
                to="/admin/addcategory"
                className="px-4 py-2 bg-blue-600 hover:bg-blue-700 dark:bg-blue-500 dark:hover:bg-blue-600 text-white rounded-lg transition-colors"
              >
                Add New Category
              </Link>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
              {Categories &&
                Categories.map((category) => (
                  <div
                    key={category.id}
                    className="bg-gray-50 dark:bg-gray-700 rounded-xl overflow-hidden"
                  >
                    <div className="relative">
                      <img
                        src={`http://smartlabel1.runasp.net/Uploads/${category.mainImage}`}
                        alt={category.name}
                        className="w-full h-48 object-cover"
                      />
                      <div className="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent"></div>
                      <div className="absolute bottom-0 left-0 right-0 p-4">
                        <h3 className="text-xl font-bold text-white">
                          {category.name}
                        </h3>
                        <p className="text-sm text-gray-200">
                          {category.description}
                        </p>
                      </div>
                    </div>
                    <div className="p-4">
                      <div className="flex justify-between items-center">
                        <span
                          className={`px-3 py-1 rounded-full text-sm ${
                            category.isActive
                              ? "bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-200"
                              : "bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-200"
                          }`}
                        >
                          {category.isActive ? "Active" : "Inactive"}
                        </span>
                        <div className="flex space-x-2">
                          <Link
                            to={`/admin/editcategory/${category.id}`}
                            className="text-blue-600 dark:text-blue-400 hover:text-blue-800 dark:hover:text-blue-300"
                          >
                            Edit
                          </Link>
                          <button
                            onClick={() => deleteCategory(category)}
                            className="text-red-600 dark:text-red-400 hover:text-red-800 dark:hover:text-red-300"
                          >
                            Delete
                          </button>
                        </div>
                      </div>
                    </div>
                  </div>
                ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default CategoryAdminPage; 