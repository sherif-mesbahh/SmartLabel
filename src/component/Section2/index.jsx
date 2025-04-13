import { Swiper, SwiperSlide } from "swiper/react";
import { Link } from "react-router-dom";
import { useFavorites } from "../../hooks/useCart";
import "swiper/css";
import "swiper/css/pagination";
import { Pagination, Autoplay } from "swiper/modules";

const NewProducts = ({ food }) => {
  const { toggleFavorite, favorites } = useFavorites();

  const AddItemHandle = (item) => {
    toggleFavorite(item);
  };

  const isFavorite = (item) => {
    return favorites.items.some((favItem) => favItem.food.id === item.id);
  };

  return (
    <div className="mb-12">
      <h1 className=" text-3xl font-bold uppercase mb-2 text-center">
        {" "}
        Top Seller
      </h1>
      <div className="max-w-7xl mx-auto px-4">
        <Swiper
          slidesPerView={5}
          spaceBetween={20}
          autoplay={{ delay: 5000, disableOnInteraction: false }}
          modules={[Pagination, Autoplay]}
          className="pb-6"
        >
          {food.map((item) => (
            <SwiperSlide key={item.id}>
              <div className="bg-white rounded-lg shadow-md p-4">
                <div className="relative">
                  <Link to={`/food/${item.id}`}>
                    <img
                      src={`http://smartlabel1.runasp.net/Uploads/${item.imageUrl}`}
                      alt="Product"
                      className="w-full h-48 object-cover rounded-lg"
                    />
                  </Link>
                  <div className="absolute top-2 left-2 bg-blue-600 text-white px-2 py-1 rounded text-xs">
                    {item.discount ? `${item.discount}%` : "NEW"}
                  </div>
                </div>
                <div className="mt-3 text-center">
                  <h3 className="text-lg font-semibold text-blue-600">
                    {item.name}
                  </h3>
                  <h4 className=" font-bold">
                    ${item.newPrice}{" "}
                    <del className="text-gray-400 text-sm">{item.oldPrice}</del>
                  </h4>
                </div>
                <button onClick={() => AddItemHandle(item)}>
                  <i
                    className={`fa fa-heart mr-1 ${
                      isFavorite(item) ? "text-red-600" : "text-slate-500"
                    }   text-2xl hover:scale-110 transition-transform  `}
                  ></i>
                </button>
              </div>
            </SwiperSlide>
          ))}
        </Swiper>
      </div>
      <div className=" text-center pt-3">
        <Link
          to="/allproduct"
          className="bg-blue-600 text-white text-3xl font-bold uppercase px-6 py-3 rounded-lg hover:bg-blue-700 transition duration-300"
        >
          All Product
        </Link>
      </div>
    </div>
  );
};

export default NewProducts;
