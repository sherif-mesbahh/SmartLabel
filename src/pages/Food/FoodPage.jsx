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

  useEffect(() => {
    getById(id).then((data) => {
      setFood(data.data);
      setMainImage(data.data.images[0]);
    });
  }, [id]);
  console.log(food);

  const images = [food.images];

  const AddItemHandle = () => {
    toggleFavorite(food);
  };

  const isFavorite = (item) => {
    return favorites.items.some((favItem) => favItem.food.id === item.id);
  };

  return (
    <div className="container mx-auto py-10">
      <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
        <div className="flex flex-col items-center">
          <Swiper
            direction="vertical"
            slidesPerView={3}
            spaceBetween={10}
            navigation
            modules={[Navigation]}
            className="w-32 h-[400px]"
          >
            {images.map((img, index) => (
              <SwiperSlide key={index}>
                <img
                  src={`http://smartlabel1.runasp.net/Uploads/${img}`}
                  alt={`Thumbnail ${index}`}
                  className="cursor-pointer rounded-lg h-31  "
                  onClick={() => setMainImage(img)}
                />
              </SwiperSlide>
            ))}
          </Swiper>
        </div>

        <div className="flex justify-center">
          <img
            src={`http://smartlabel1.runasp.net/Uploads/${mainImage}`}
            alt="Main"
            className="h-96 w-96 rounded-lg shadow-lg"
          />
        </div>

        <div className="space-y-4">
          <h2 className="text-2xl font-bold">{food.name}</h2>

          <p className="text-gray-600">{food.description}</p>
          <h3 className="text-xl font-semibold">
            {food.newPrice}${" "}
            <del className="text-red-500">{food.oldPrice}$</del>
          </h3>
          <button
            onClick={AddItemHandle}
            className="px-4 py-2 bg-teal-400 text-white rounded-lg hover:bg-teal-500 transition"
          >
            <i className="fa fa-heart"></i>{" "}
            {isFavorite(food) ? "Remove from Favorites" : "Add to Favorites"}
          </button>
        </div>
      </div>
    </div>
  );
}

export default FoodPage;
