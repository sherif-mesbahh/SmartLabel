import React from "react";
import { Swiper, SwiperSlide } from "swiper/react";
import { Pagination } from "swiper/modules";
import { Link } from "react-router-dom";

function Section3({ banners }) {
  return (
    <div className="w-full px-4 py-6">
      <Swiper
        modules={[Pagination]}
        loop={true}
        spaceBetween={30}
        slidesPerView={1}
        className="mySwiper"
      >
        {banners &&
          banners.map((banner) => (
            <SwiperSlide key={banner.id}>
              <div
                className="relative w-full h-64 md:h-96 rounded-2xl overflow-hidden shadow-lg"
                style={{
                  backgroundImage: `url(http://smartlabel1.runasp.net/Uploads/${banner.imageUrl})`,
                  backgroundSize: "cover",
                  backgroundPosition: "center",
                }}
              >
                <Link to={`/banner/${banner.id}`}>
                  {/* Gradient overlay */}
                  <div className="absolute inset-0 bg-gradient-to-r from-black/70 to-black/30 z-10" />

                  {/* Text */}
                  <div className="relative z-20 flex items-center justify-center h-full px-4 text-center">
                    <h1 className="text-white text-2xl md:text-4xl font-extrabold drop-shadow-lg">
                      {banner.title}
                    </h1>
                  </div>
                </Link>{" "}
              </div>
            </SwiperSlide>
          ))}
      </Swiper>
    </div>
  );
}

export default Section3;
