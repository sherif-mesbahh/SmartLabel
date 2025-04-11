import React, { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";
import { addFood, getById, updateFood } from "../../services/foodServices";
import { uploadImage } from "../../services/uploadServices";
import { toast } from "react-toastify";
import { useAuth } from "../../hooks/useAuth";

function FoodEditPage() {
  const { foodId } = useParams();
  const isEditMode = !!foodId;
  const [Food, setFood] = useState();
  const [Image, setImageUrl] = useState();
  const [Name, setName] = useState();
  const [Price, setPrice] = useState();
  const [CategoryId, setCategoryId] = useState();
  const [Discount, setdiscount] = useState();
  const [ExpirationDate, setExpirationDate] = useState();
  const navigate = useNavigate();
  const { user } = useAuth();

  useEffect(() => {
    if (!isEditMode) return;
    console.log(user);
    getById(foodId).then((food) => {
      setImageUrl(food.imagePath);
      setName(food.name);
      setPrice(food.price);
      setCategoryId(food.categoryId);

      setdiscount(food.discount);
    });
  }, [foodId, isEditMode]);
  const handleSubmit = async (e) => {
    e.preventDefault();
    console.log("Name:", Name);

    if (isEditMode) {
      await updateFood(
        Name,
        Image,
        Price,
        Discount,
        ExpirationDate,
        CategoryId,
        foodId
      );
      toast.success(`food ${Name} updated successfully`);
    } else {
      const newFood = await addFood(
        Name,
        Image,
        Price,
        Discount,
        ExpirationDate,
        CategoryId
      ); // Corrected function call here
      console.log(newFood);
      toast.success(`Food ${newFood.name} added successfully`);
      navigate(`/admin/editfood/${newFood.id}`, { replace: true }); // Corrected typo
    }
  };
  // const upload = async (event) => {
  //   setImageUrl(null);
  //   const imageUrl = await uploadImage(event);
  //   setImageUrl(imageUrl);
  // };

  return (
    <div className="flex justify-center items-center min-h-screen bg-gray-50">
      <div className="bg-white p-8 rounded shadow-md w-full max-w-md">
        <h2 className="text-2xl font-semibold text-center mb-6">
          {isEditMode ? "Edit Food" : "Add Food"}
        </h2>
        <form onSubmit={handleSubmit} className="space-y-4">
          <input
            type="text"
            placeholder="Name"
            onChange={(e) => setName(e.target.value)}
            value={Name}
            className="block w-full border border-gray-300 rounded p-2"
          />
          <label className=" text-gray-700">Select Image:</label>
          <input
            type="text"
            placeholder=" Image url ..."
            onChange={(e) => setImageUrl(e.target.value)}
            className="block w-full text-sm text-gray-500 border border-gray-300 rounded p-2"
          />
          {Image && (
            <a href={Image} target="_blank" rel="noopener noreferrer">
              <img
                src={Image}
                alt="Preview"
                className="my-4 w-full h-48 object-cover rounded"
              />
            </a>
          )}

          <input
            type="number"
            placeholder="Price"
            onChange={(e) => setPrice(e.target.value)}
            value={Price}
            className="block w-full border border-gray-300 rounded p-2"
          />
          <input
            type="number"
            placeholder="Discount"
            onChange={(e) => setdiscount(e.target.value)}
            value={Discount}
            className="block w-full border border-gray-300 rounded p-2"
          />
          <input
            type="text"
            placeholder="Expiration Date"
            onChange={(e) => setExpirationDate(e.target.value)}
            value={ExpirationDate}
            className="block w-full border border-gray-300 rounded p-2"
          />
          <input
            type="number"
            placeholder="Category Id"
            onChange={(e) => setCategoryId(e.target.value)}
            value={CategoryId}
            className="block w-full border border-gray-300 rounded p-2"
          />

          <button
            type="submit"
            className="block w-full bg-blue-500 text-white rounded p-2 mt-4"
          >
            {isEditMode ? "Update" : "Add"}
          </button>
        </form>
      </div>
    </div>
  );
}

export default FoodEditPage;
