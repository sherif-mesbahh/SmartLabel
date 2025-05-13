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
  const [loading, setLoading] = useState(false);


  const navigate = useNavigate();
  useEffect(() => {
    if (!isEditMode) {
      setCategoryId(categoryId);
      return;
    }
  
    setLoading(true);
    getById(foodId)
      .then((food) => {
        const data = food.data;
        setName(data.name);
        setOldPrice(data.oldPrice);
        setCategoryId(data.categoryId);
        setDescription(data.description);
        setdiscount(data.discount);
        setMainImage(data.mainImage);
        setImages(data.images?.map((img) => img.imageUrl) || [null]);
        setRemovedImageId(data.images?.map((img) => img.imageId));
      })
      .finally(() => setLoading(false));
  }, [foodId, isEditMode, categoryId]);
  
  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);

 
      try {   if (isEditMode) {
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
      navigate(`/food/${newFood.id}`, { replace: true });
    }
      } catch (error) {
        toast.error(error.response.data.errors[0] || "something went wrong");
      } finally {
        setLoading(false);  
      }
  
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 dark:from-gray-900 dark:to-gray-800 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-3xl mx-auto">
        <div className="text-center mb-12">
          <h1 className="text-4xl md:text-5xl font-extrabold text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-indigo-800 dark:from-blue-400 dark:to-indigo-600 mb-4">
            {isEditMode ? "Edit Food" : "Add Food"}
          </h1>
          <p className="text-lg text-gray-600 dark:text-gray-300">
            {isEditMode ? "Update your food information" : "Create a new food item"}
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
                  placeholder="Enter food name"
                  onChange={(e) => setName(e.target.value)}
                  value={Name}
                  className="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 focus:border-transparent dark:bg-gray-700 dark:text-white transition-colors"
                  required
                  disabled={loading}
                />
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                    Price
                  </label>
                  <input
                    type="number"
                    placeholder="Enter price"
                    onChange={(e) => setOldPrice(e.target.value)}
                    value={OLdPrice}
                    className="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 focus:border-transparent dark:bg-gray-700 dark:text-white transition-colors"
                    required
                    disabled={loading}
                  />
                </div>

                <div>
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                    Discount
                  </label>
                  <input
                    type="number"
                    placeholder="Enter discount percentage"
                    onChange={(e) => setdiscount(e.target.value)}
                    value={Discount}
                    disabled={loading}
                    className="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 focus:border-transparent dark:bg-gray-700 dark:text-white transition-colors"
                  />
                </div>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                  Description
                </label>
                <textarea
                  placeholder="Enter food description"
                  onChange={(e) => setDescription(e.target.value)}
                  value={Description}
                  className="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 focus:border-transparent dark:bg-gray-700 dark:text-white transition-colors h-32 resize-none"
                  required
                  disabled={loading}
                ></textarea>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                  Main Image
                </label>
                <input
                  type="file"
                  accept="image/*"
                  onChange={(e) => setMainImage(e.target.files[0])}
                  disabled={loading}
                  className="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 focus:border-transparent dark:bg-gray-700 dark:text-white transition-colors file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-blue-50 file:text-blue-700 dark:file:bg-blue-900 dark:file:text-blue-300 hover:file:bg-blue-100 dark:hover:file:bg-blue-800"
                />
                {MainImage && (
                  <div className="mt-4">
                    <img
                      src={
                        typeof MainImage === "string"
                          ? `http://smartlabel1.runasp.net/Uploads/${MainImage}`
                          : URL.createObjectURL(MainImage)
                      }
                      alt="Main Preview"
                      className="w-full h-48 object-cover rounded-lg shadow-md"
                    />
                  </div>
                )}
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                  Additional Images
                </label>
                <input
                  type="file"
                  accept="image/*"
                  multiple
                  onChange={(e) => setImages(Array.from(e.target.files))}
                  disabled={loading}
                  className="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 focus:border-transparent dark:bg-gray-700 dark:text-white transition-colors file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-blue-50 file:text-blue-700 dark:file:bg-blue-900 dark:file:text-blue-300 hover:file:bg-blue-100 dark:hover:file:bg-blue-800"
                />
                {images && images.length > 0 && (
                  <div className="mt-4 grid grid-cols-2 gap-4">
                    {images.map((img, idx) => (
                      <div key={idx} className="relative">
                        <img
                          src={
                            typeof img === "string"
                              ? `http://smartlabel1.runasp.net/Uploads/${img}`
                              : URL.createObjectURL(img)
                          }
                          alt={`Preview ${idx}`}
                          className="w-full h-32 object-cover rounded-lg shadow-md"
                        />
                      </div>
                    ))}
                  </div>
                )}
              </div>

              <div className="flex justify-end">
              <button
                  type="submit"
                  disabled={isLoading}
                  className="px-8 py-3 bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-700 hover:to-indigo-700 dark:from-blue-500 dark:to-indigo-500 dark:hover:from-blue-600 dark:hover:to-indigo-600 text-white rounded-lg transition-all duration-300 transform hover:scale-105 font-medium disabled:opacity-50 disabled:cursor-not-allowed disabled:hover:scale-100 relative"
                >
                  {isLoading ? (
                    <div className="flex items-center">
                      <svg className="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                        <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                        <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                      </svg>
                      {isEditMode ? "Updating..." : "Adding..."}
                    </div>
                  ) : (
                    isEditMode ? "Update Banner" : "Add Banner"
                  )}
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  );
}

export default FoodEditPage;
