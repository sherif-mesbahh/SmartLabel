import { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import { getById } from "../../services/foodServices";
import { useFavorites } from "../../hooks/useCart";
import NotFound from "../../component/NotFound";
import { Swiper, SwiperSlide } from "swiper/react";
import { Navigation, Pagination, Thumbs } from "swiper/modules";
import "swiper/css";
import "swiper/css/navigation";
import "swiper/css/pagination";
import "swiper/css/thumbs";

function FoodPage() {
  const [food, setFood] = useState({});
  const [thumbsSwiper, setThumbsSwiper] = useState(null);
  const { id } = useParams();
  const { toggleFavorite, favorites } = useFavorites();

  useEffect(() => {
    getById(id).then((data) => {
      setFood(data.data);
    });
  }, [id]);

  const images = food.images || [];

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
            <div className="space-y-4">
              <div className="relative w-full h-[400px]">
                <Swiper
                  spaceBetween={10}
                  thumbs={{ swiper: thumbsSwiper }}
                  modules={[  Thumbs]}
                  className="w-full h-full rounded-xl"
                >
                  <SwiperSlide>
                    <div className="relative w-full h-full">
                      <img
                        src={`http://smartlabel1.runasp.net/Uploads/${food.mainImage}`}
                        alt={food.name}
                        className="w-full h-full object-cover rounded-xl"
                      />
                      {food.discount && (
                        <div className="absolute top-4 left-4 bg-gradient-to-r from-blue-600 to-indigo-600 text-white px-4 py-2 rounded-full text-sm font-bold">
                          {food.discount}% OFF
                        </div>
                      )}
                    </div>
                  </SwiperSlide>
                  {images.map((img, index) => (
                    <SwiperSlide key={index}>
                      <img
                        src={`http://smartlabel1.runasp.net/Uploads/${img.imageUrl}`}
                        alt={`${food.name} - Image ${index + 1}`}
                        className="w-full h-full object-cover rounded-xl"
                      />
                    </SwiperSlide>
                  ))}
                </Swiper>
              </div>

              {/* Thumbnails */}
              <div className="h-24">
                <Swiper
                  onSwiper={setThumbsSwiper}
                  spaceBetween={10}
                  slidesPerView={4}
                  watchSlidesProgress={true}
                  modules={[Thumbs]}
                  className="w-full h-full"
                >
                  <SwiperSlide>
                    <img
                      src={`http://smartlabel1.runasp.net/Uploads/${food.mainImage}`}
                      alt="Main thumbnail"
                      className="w-full h-full object-cover rounded-lg cursor-pointer opacity-40 transition-opacity duration-300 hover:opacity-60"
                    />
                  </SwiperSlide>
                  {images.map((img, index) => (
                    <SwiperSlide key={index}>
                      <img
                        src={`http://smartlabel1.runasp.net/Uploads/${img.imageUrl}`}
                        alt={`Thumbnail ${index + 1}`}
                        className="w-full h-full object-cover rounded-lg cursor-pointer opacity-40 transition-opacity duration-300 hover:opacity-60"
                      />
                    </SwiperSlide>
                  ))}
                </Swiper>
              </div>
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

              <button
                onClick={() => toggleFavorite(food)}
                className="w-full px-6 py-3 bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-700 hover:to-indigo-700 text-white rounded-lg transition-all duration-300 transform hover:scale-105"
              >
                {favorites.items.some((fav) => fav.id === food.id)
                  ? "Remove from Favorites"
                  : "Add to Favorites"}
              </button>
            </div>
          </div>
        </div>
      </div>

      {/* Swiper Navigation Styles */}
      <style jsx global>{`
        .swiper-button-next,
        .swiper-button-prev {
          @apply bg-black/50 text-white w-10 h-10 rounded-full;
        }
        .swiper-button-next:after,
        .swiper-button-prev:after {
          @apply text-xl;
        }
        .swiper-pagination-bullet {
          @apply bg-white;
        }
        .swiper-pagination-bullet-active {
          @apply bg-blue-500;
        }
        .swiper-slide-thumb-active img {
          @apply opacity-100;
        }
      `}</style>
    </div>
  );
}

export default FoodPage;
