import React, { useEffect, useRef } from "react";
import { Swiper, SwiperSlide } from "swiper/react";
import { Pagination, Autoplay, EffectFade } from "swiper/modules";
import { Link } from "react-router-dom";
import { motion } from "framer-motion";
import "swiper/css";
import "swiper/css/pagination";
import "swiper/css/effect-fade";

function Section3({ banners }) {
  const swiperRef = useRef(null);

  useEffect(() => {
    if (swiperRef.current && banners?.length > 0) {
      swiperRef.current.swiper.autoplay.start();
    }
  }, [banners]);

  if (!banners?.length) {
    return null;
  }

  return (
    <Swiper
      ref={swiperRef}
      modules={[Pagination, Autoplay, EffectFade]}
      effect="fade"
      loop={true}
      autoplay={{
        delay: 2000,
        disableOnInteraction: true,
      }}
      speed={800}
      spaceBetween={0}
      slidesPerView={1}
      className="w-full [&_.swiper-pagination-bullet]:w-3 [&_.swiper-pagination-bullet]:h-3 [&_.swiper-pagination-bullet]:bg-white [&_.swiper-pagination-bullet]:opacity-50 [&_.swiper-pagination-bullet]:transition-all [&_.swiper-pagination-bullet]:duration-300 [&_.swiper-pagination-bullet-active]:opacity-100 [&_.swiper-pagination-bullet-active]:scale-120"
    >
      {banners.map((banner) => (
        <SwiperSlide key={banner.id}>
          <div className="relative w-full">
            <div className="block w-full h-[60vh] md:h-[80vh] relative group">
              <div className="absolute inset-0 transform group-hover:scale-105 transition-transform duration-700">
                <img
                  src={`http://smartlabel1.runasp.net/Uploads/${banner.mainImage}`}
                  alt={banner.title}
                  className="w-full h-full object-cover"
                  loading="lazy"
                />
              </div>

              <div className="absolute inset-0 bg-gradient-to-t from-black/90 via-black/60 to-transparent opacity-80 group-hover:opacity-95 transition-all duration-500"></div>

              <div className="absolute inset-0 flex flex-col items-start justify-end text-left px-8 md:px-16 pb-16 md:pb-24">
                <motion.div
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ duration: 0.8 }}
                  className="max-w-2xl"
                >
                  <h1 className="text-4xl md:text-6xl font-extrabold text-white tracking-tight leading-tight mb-6 drop-shadow-lg transform hover:scale-105 transition-transform duration-300">
                    {banner.title}
                  </h1>
                  <p className="text-lg md:text-2xl text-white/90 font-medium mb-8">
                    {banner.description || "Discover the best deals today!"}
                  </p>

                  <div className="flex items-center gap-4">
                    <Link
                      to={`/banner/${banner.id}`}
                      className="inline-block bg-white text-blue-600 font-semibold px-6 py-3 rounded-full hover:bg-opacity-90 hover:scale-105 transition-all duration-300 shadow-lg hover:shadow-xl"
                    >
                      Shop Now
                    </Link>
                   
                  </div>
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
  );
}

export default Section3;
