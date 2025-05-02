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
    <div className="container mx-auto py-10 text-[#0028FF]">
      <div className="grid grid-cols-1 md:grid-cols-3 gap-8 items-start">
        {/* Thumbnail Swiper */}
        <div className="flex flex-col items-center">
          <Swiper
            direction="vertical"
            slidesPerView={3}
            spaceBetween={10}
            navigation
            modules={[Navigation]}
            className="w-36 h-[450px]"
          >
            {images &&
              images.map((img, index) => (
                <SwiperSlide key={index}>
                  <img
                    src={`http://smartlabel1.runasp.net/Uploads/${img.imageUrl}`}
                    alt={`Thumbnail ${index}`}
                    className={`cursor-pointer w-32 h-32 object-cover border-2 ${
                      mainImage === img.imageUrl
                        ? "border-[#0028FF]"
                        : "border-transparent"
                    } rounded-lg`}
                    onClick={() => {
                      if (mainImage === img.imageUrl) return;
                      const prevMain = mainImage;
                      setMainImage(img.imageUrl);
                      if (
                        !images.some((image) => image.imageUrl === prevMain)
                      ) {
                        setFood((prev) => ({
                          ...prev,
                          images: [...images, { imageUrl: prevMain }],
                        }));
                      }
                    }}
                  />
                </SwiperSlide>
              ))}
          </Swiper>
        </div>

        {/* Main Image */}
        <div className="flex justify-center">
          <img
            src={`http://smartlabel1.runasp.net/Uploads/${mainImage}`}
            alt="Main"
            className="w-96 h-96 object-cover rounded-lg shadow-lg border-4 border-[#0028FF]"
          />
        </div>

        {/* Info Section */}
        <div className="space-y-5">
          <h2 className="text-3xl font-bold">{food.name}</h2>
          <p className="text-gray-600">{food.description}</p>

          <div className="text-xl font-semibold space-x-2">
            <span>{food.newPrice}$</span>
            <del className="text-red-500">{food.oldPrice}$</del>
          </div>

          <button
            onClick={() => toggleFavorite(food)}
            className="px-5 py-2 rounded-lg bg-gradient-to-r from-[#10EAF0] to-[#24009C] text-white font-semibold hover:opacity-90 transition"
          >
            <i className="fa fa-heart mr-2"></i>
            {isFavorite(food) ? "Remove from Favorites" : "Add to Favorites"}
          </button>
        </div>
      </div>
    </div>
  );
}

export default FoodPage;
