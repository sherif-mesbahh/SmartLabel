import React from "react";
import { Swiper, SwiperSlide } from "swiper/react";
import { Pagination, Autoplay } from "swiper/modules";
import { Link } from "react-router-dom";
import "swiper/css";
import "swiper/css/pagination";

function Section3({ banners }) {
  return (
    <div className="w-full px-4 py-10">
      <Swiper
        modules={[Pagination, Autoplay]}
        loop={true}
        autoplay={{ delay: 4000, disableOnInteraction: false }}
        spaceBetween={30}
        slidesPerView={1}
        className="mySwiper"
      >
        {banners?.map((banner) => (
          <SwiperSlide key={banner.id}>
            <div className="relative w-full overflow-hidden rounded-3xl shadow-2xl group">
              <Link
                to={`/banner/${banner.id}`}
                className="block w-full h-64 md:h-[500px] relative"
              >
                {/* Background Image */}
                <img
                  src={`http://smartlabel1.runasp.net/Uploads/${banner.mainImage}`}
                  alt={banner.title}
                  className="w-full h-full object-cover rounded-3xl transition-transform duration-700 ease-in-out group-hover:scale-110"
                />

                {/* Dark overlay with gradient on hover */}
                <div className="absolute inset-0 bg-gradient-to-t from-black/70 via-black/40 to-transparent opacity-80 group-hover:opacity-90 transition-all duration-500 rounded-3xl"></div>

                {/* Centered Text */}
                <div className="absolute inset-0 flex flex-col items-center justify-end text-center px-6 pb-4">
                  <h1 className="text-white text-3xl md:text-5xl font-extrabold tracking-wide leading-tight drop-shadow-lg animate-fadeIn">
                    {banner.title}
                  </h1>
                  <p className="mt-4 text-white text-lg md:text-2xl font-medium opacity-90 animate-fadeIn delay-100">
                    Discover the best deals today!
                  </p>
                </div>
              </Link>
            </div>
          </SwiperSlide>
        ))}
      </Swiper>
    </div>
  );
}

export default Section3;
