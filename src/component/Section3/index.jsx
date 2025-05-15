import React from "react";
import { Swiper, SwiperSlide } from "swiper/react";
import { Pagination, Autoplay, EffectFade } from "swiper/modules";
import { Link } from "react-router-dom";
import { motion } from "framer-motion";
import "swiper/css";
import "swiper/css/pagination";
import "swiper/css/effect-fade";

function Section3({ banners }) {
  return (
    <div className="w-full">
      <Swiper
        modules={[Pagination, Autoplay, EffectFade]}
        effect="fade"
        loop={true}
        autoplay={{ delay: 1500, disableOnInteraction: true }}
        spaceBetween={0}
        slidesPerView={1}
        className="w-full [&_.swiper-pagination-bullet]:w-3 [&_.swiper-pagination-bullet]:h-3 [&_.swiper-pagination-bullet]:bg-white [&_.swiper-pagination-bullet]:opacity-50 [&_.swiper-pagination-bullet]:transition-all [&_.swiper-pagination-bullet]:duration-300 [&_.swiper-pagination-bullet-active]:opacity-100 [&_.swiper-pagination-bullet-active]:scale-120"
      >
        {banners?.map((banner) => (
          <SwiperSlide key={banner.id}>
            <div className="relative w-full ">
              <div className="block w-full h-[60vh] md:h-[80vh] relative group">
                <div className="absolute inset-0 transform group-hover:scale-105 transition-transform duration-700">
                  <img
                    src={`http://smartlabel1.runasp.net/Uploads/${banner.mainImage}`}
                    alt={banner.title}
                    className="w-full h-full object-cover"
                  />
                </div>

                <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-black/50 to-transparent opacity-80 group-hover:opacity-90 transition-all duration-500"></div>

                <div className="absolute inset-0 flex flex-col items-center justify-end text-center px-6 pb-16 md:pb-24">
                  <motion.div
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.8 }}
                    className="max-w-4xl mx-auto"
                  >
                    <h1 className="text-4xl md:text-6xl font-extrabold text-white tracking-tight leading-tight mb-6 drop-shadow-lg">
                      {banner.title}
                    </h1>
                    <p className="text-lg md:text-2xl text-white/90 font-medium mb-8 max-w-2xl mx-auto">
                      {banner.description || "Discover the best deals today!"}
                    </p>

                    <Link
                      to={`/banner/${banner.id}`}
                      className="inline-block bg-white text-blue-600 font-semibold px-4 py-4 rounded-full z-50 relative hover:bg-opacity-90 transition-all duration-300 shadow-lg"
                      style={{ pointerEvents: "auto" }}
                    >
                      Learn More
                    </Link>
                  </motion.div>
                </div>

                <div className="absolute top-0 left-0 w-full h-full pointer-events-none">
                  <div className="absolute top-1/4 left-1/4 w-64 h-64 bg-blue-500 rounded-full mix-blend-multiply filter blur-3xl opacity-20 animate-blob"></div>
                  <div className="absolute top-1/3 right-1/4 w-64 h-64 bg-purple-500 rounded-full mix-blend-multiply filter blur-3xl opacity-20 animate-blob animation-delay-2000"></div>
                  <div className="absolute bottom-1/4 left-1/3 w-64 h-64 bg-pink-500 rounded-full mix-blend-multiply filter blur-3xl opacity-20 animate-blob animation-delay-4000"></div>
                </div>
              </div>
            </div>
          </SwiperSlide>
        ))}
      </Swiper>
    </div>
  );
}

export default Section3;
