import { Swiper, SwiperSlide } from "swiper/react";
import { Link } from "react-router-dom";
import "swiper/css";

import "swiper/css";
import "swiper/css/pagination";
import ProductCard from "../ProductCard";
import { Pagination, Autoplay } from "swiper/modules";
const NewProducts = ({ food }) => {
  return (
    <div className="mb-16">
      {/* Title */}
      <div className="max-w-7xl mx-auto px-4">
        <h1 className="text-3xl md:text-4xl font-bold text-center mb-8 text-gray-800">
          Top Seller Products
        </h1>

        {/* Swiper */}
        <Swiper
          modules={[Pagination, Autoplay]}
          loop={true}
          autoplay={{ delay: 4000, disableOnInteraction: false }}
          spaceBetween={10}
          slidesPerView={3}
          className="mySwiper "
        >
          {food.map((item) => (
            <SwiperSlide key={item.id} className="pb-8">
              <ProductCard item={item} />
            </SwiperSlide>
          ))}
        </Swiper>
      </div>

      {/* Button */}
      <div className="text-center mt-8">
        <Link
          to="/allproduct"
          className="inline-block bg-blue-600 hover:bg-blue-700 text-white font-medium px-6 py-3 rounded-lg transition-colors duration-200"
        >
          View All Products
        </Link>
      </div>
    </div>
  );
};

export default NewProducts;
