import React, { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";
import { addFood, getById, updateFood } from "../../services/foodServices";
import { toast } from "react-toastify";

function FoodEditPage() {
  const { foodId, categoryId } = useParams();
  const isEditMode = !!foodId;

  const [images, setImages] = useState();
  const [MainImage, setMainImage] = useState();
  const [RemovedImageIds, setRemovedImageId] = useState([]);
  const [Name, setName] = useState("");
  const [OLdPrice, setOldPrice] = useState("");
  const [CategoryId, setCategoryId] = useState();
  const [Discount, setdiscount] = useState("");
  const [Description, setDescription] = useState("");

  const navigate = useNavigate();

  useEffect(() => {
    if (!isEditMode) {
      setCategoryId(categoryId);
      return;
    }

    getById(foodId).then((food) => {
      const data = food.data;
      setName(data.name);
      setOldPrice(data.oldPrice);
      setCategoryId(data.categoryId);
      setDescription(data.description);
      setdiscount(data.discount);
      setMainImage(data.mainImage);
      setImages(data.images?.map((img) => img.imageUrl) || [null]);
      setRemovedImageId(data.images?.map((img) => img.imageId));
    });
  }, [foodId, isEditMode, categoryId]);

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (isEditMode) {
      await updateFood(
        foodId,
        Name,
        OLdPrice,
        Discount,
        Description,
        CategoryId,
        MainImage,
        images,
        RemovedImageIds
      );
      toast.success(`Food ${Name} updated successfully`);
    } else {
      const newFood = await addFood(
        Name,
        OLdPrice,
        Discount,
        Description,
        CategoryId,
        MainImage,
        images
      );
      toast.success(`Food ${Name} added successfully`);
      navigate(`/admin/editfood/${newFood.id}`, { replace: true });
    }
  };

  return (
    <div className="flex justify-center items-center min-h-screen bg-slate-100 px-4">
      <div className="bg-white p-8 rounded-2xl shadow-lg w-full max-w-lg">
        <h2 className="text-3xl font-bold text-center text-indigo-600 mb-8">
          {isEditMode ? "Edit Food" : "Add Food"}
        </h2>
        <form onSubmit={handleSubmit} className="space-y-5">
          <input
            type="text"
            placeholder="Name"
            onChange={(e) => setName(e.target.value)}
            value={Name}
            className="w-full border border-gray-300 rounded-lg p-3 focus:outline-none focus:ring-2 focus:ring-indigo-500"
          />
          <input
            type="number"
            placeholder="Price"
            onChange={(e) => setOldPrice(e.target.value)}
            value={OLdPrice}
            className="w-full border border-gray-300 rounded-lg p-3 focus:outline-none focus:ring-2 focus:ring-indigo-500"
          />
          <input
            type="number"
            placeholder="Discount"
            onChange={(e) => setdiscount(e.target.value)}
            value={Discount}
            className="w-full border border-gray-300 rounded-lg p-3 focus:outline-none focus:ring-2 focus:ring-indigo-500"
          />
          <textarea
            placeholder="Description"
            onChange={(e) => setDescription(e.target.value)}
            value={Description}
            className="w-full border border-gray-300 rounded-lg p-3 h-28 resize-none focus:outline-none focus:ring-2 focus:ring-indigo-500"
          ></textarea>

          <div>
            <label className="block mb-2 text-sm text-gray-700 font-medium">
              Select Main Image
            </label>
            <input
              type="file"
              accept="image/*"
              onChange={(e) => setMainImage(e.target.files[0])}
              className="w-full text-sm border border-gray-300 rounded-lg p-2.5"
            />
          </div>

          <div>
            <label className="block mb-2 text-sm text-gray-700 font-medium">
              Select Images
            </label>
            <input
              type="file"
              accept="image/*"
              multiple
              onChange={(e) => setImages(Array.from(e.target.files))}
              className="w-full text-sm border border-gray-300 rounded-lg p-2.5"
            />
          </div>

          <button
            type="submit"
            className="w-full bg-indigo-600 hover:bg-indigo-700 text-white font-medium py-3 rounded-lg transition duration-200"
          >
            {isEditMode ? "Update" : "Add"}
          </button>
        </form>
      </div>
    </div>
  );
}

export default FoodEditPage;
