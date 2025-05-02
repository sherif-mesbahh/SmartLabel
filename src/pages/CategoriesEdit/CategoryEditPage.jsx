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
    <div className="flex justify-center items-center min-h-screen bg-gray-50">
      <div className="bg-white p-8 rounded-2xl shadow-lg w-full max-w-md">
        <h2 className="text-3xl font-bold text-center text-gray-800 mb-6">
          {isEditMode ? "Edit Category" : "Add Category"}
        </h2>
        <form onSubmit={handleSubmit} className="space-y-5">
          <input
            type="text"
            placeholder="Name"
            onChange={(e) => setName(e.target.value)}
            value={Name}
            className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none"
          />

          <input
            type="file"
            onChange={(e) => setImageUrl(e.target.files[0])}
            className="w-full px-4 py-2 text-sm border border-gray-300 rounded-lg"
          />

          {Image && typeof Image === "string" && (
            <a
              href={`http://smartlabel1.runasp.net/Uploads/${Image}`}
              target="_blank"
              rel="noopener noreferrer"
            >
              <img
                src={`http://smartlabel1.runasp.net/Uploads/${Image}`}
                alt="Preview"
                className="my-4 w-full h-48 object-cover rounded-lg"
              />
            </a>
          )}

          <button
            type="submit"
            className="w-full bg-blue-600 hover:bg-blue-800 text-white font-medium py-2 rounded-lg transition duration-200"
          >
            {isEditMode ? "Update" : "Add"}
          </button>
        </form>
      </div>
    </div>
  );
}

export default CategoryEditPage;
