import { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import { getById } from "../../services/foodServices";
import { useFavorites } from "../../hooks/useCart";
import NotFound from "../../component/NotFound";
import { Swiper, SwiperSlide } from "swiper/react";
import "swiper/css";
import { Navigation } from "swiper/modules";

function FoodPage() {
  const [food, setFood] = useState({});
  const [mainImage, setMainImage] = useState("");
  const { id } = useParams();
  const { toggleFavorite, favorites } = useFavorites();

  const isFavorite = (item) => {
    return favorites.items.some((favItem) => favItem.id === item.id);
  };

  useEffect(() => {
    getById(id).then((data) => {
      setFood(data.data);
      setMainImage(data.data.mainImage);
    });
  }, [id]);

  const images = food.images;

  if (!food?.name) return <NotFound message="Food not found" />;

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 dark:from-gray-900 dark:to-gray-800 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-7xl mx-auto">
        {/* Header Section */}
        <div className="text-center mb-12">
          <h1 className="text-4xl md:text-5xl font-extrabold text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-indigo-800 dark:from-blue-400 dark:to-indigo-600 mb-4">
            Product Details
          </h1>
        </div>

        {/* Product Details */}
        <div className="bg-white dark:bg-gray-800 rounded-2xl shadow-lg overflow-hidden">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-8 p-6">
            {/* Image Section */}
            <div className="relative">
              <img
                src={`http://smartlabel1.runasp.net/Uploads/${food.mainImage}`}
                alt={food.name}
                className="w-full h-96 object-cover rounded-xl"
              />
              {food.discount && (
                <div className="absolute top-4 left-4 bg-gradient-to-r from-blue-600 to-indigo-600 text-white px-4 py-2 rounded-full text-sm font-bold">
                  {food.discount}% OFF
                </div>
              )}
            </div>

            {/* Info Section */}
            <div className="space-y-6">
              <div>
                <h2 className="text-3xl font-bold text-gray-900 dark:text-white mb-2">
                  {food.name}
                </h2>
                <p className="text-gray-600 dark:text-gray-400">
                  {food.description}
                </p>
              </div>

              <div className="flex items-center space-x-4">
                <span className="text-2xl font-bold text-blue-600 dark:text-blue-400">
                  ${food.newPrice}
                </span>
                {food.oldPrice && (
                  <span className="text-lg text-gray-500 dark:text-gray-400 line-through">
                    ${food.oldPrice}
                  </span>
                )}
              </div>

              <div className="flex items-center space-x-4">
                <button
                  onClick={() => toggleFavorite(food)}
                  className="p-2 rounded-full bg-gray-100 dark:bg-gray-700 hover:bg-gray-200 dark:hover:bg-gray-600 transition-colors"
                >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    className={`h-6 w-6 transition-all duration-300 ${
                      favorites.items.some((fav) => fav.id === food.id)
                        ? "fill-red-500 text-red-500"
                        : "text-gray-400 dark:text-gray-500"
                    }`}
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                    strokeWidth="2"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"
                    />
                  </svg>
                </button>
                <button
                  onClick={() => addToCart(food)}
                  className="flex-1 bg-blue-600 hover:bg-blue-700 dark:bg-blue-500 dark:hover:bg-blue-600 text-white px-6 py-3 rounded-lg font-medium transition-colors"
                >
                  Add to Cart
                </button>
              </div>

              {/* Additional Info */}
              <div className="border-t border-gray-200 dark:border-gray-700 pt-6">
                <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">
                  Product Information
                </h3>
                <div className="space-y-2">
                  <div className="flex justify-between">
                    <span className="text-gray-600 dark:text-gray-400">Category</span>
                    <span className="text-gray-900 dark:text-white font-medium">
                      {food.category?.name}
                    </span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-gray-600 dark:text-gray-400">Stock</span>
                    <span className="text-gray-900 dark:text-white font-medium">
                      {food.stock} units
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default FoodPage;
