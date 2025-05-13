import React, { useEffect, useState } from "react";
import { getBannerById } from "../../services/foodServices";
import { useParams } from "react-router-dom";
import { Swiper, SwiperSlide } from "swiper/react";
import { Pagination, Autoplay, EffectFade } from "swiper/modules";
import { formatDate } from "../../EditData";
import "swiper/css";
import "swiper/css/pagination";
import "swiper/css/effect-fade";

function BannerPage() {
  const [banner, setBanner] = useState({});
  const [mainImage, setMainImage] = useState("");
  const { id } = useParams();

  useEffect(() => {
    getBannerById(id).then((data) => {
      const result = data.data.data;
      setBanner(result);
      setMainImage(result.mainImage);
    });
  }, [id]);

  const images = banner.images || [];

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 dark:from-gray-900 dark:to-gray-800 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-7xl mx-auto">
        {/* Header Section */}
        <div className="text-center mb-12">
          <h1 className="text-4xl md:text-5xl font-extrabold text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-indigo-800 dark:from-blue-400 dark:to-indigo-600 mb-4">
            Banner Management
          </h1>
          <p className="text-lg text-gray-600 dark:text-gray-300 max-w-2xl mx-auto">
            Manage your promotional banners and featured content
          </p>
        </div>

        {/* Banner Swiper */}
        <div className="mb-12">
          <Swiper
            modules={[Pagination, Autoplay, EffectFade]}
            effect="fade"
            spaceBetween={30}
            slidesPerView={1}
            pagination={{ clickable: true }}
            autoplay={{
              delay: 3000,
              disableOnInteraction: false,
            }}
            className="rounded-2xl shadow-lg overflow-hidden [&_.swiper-pagination-bullet]:w-3 [&_.swiper-pagination-bullet]:h-3 [&_.swiper-pagination-bullet]:bg-white [&_.swiper-pagination-bullet]:opacity-50 [&_.swiper-pagination-bullet]:transition-all [&_.swiper-pagination-bullet]:duration-300 [&_.swiper-pagination-bullet-active]:opacity-100 [&_.swiper-pagination-bullet-active]:scale-120"
          >
            {mainImage && (
              <SwiperSlide>
                <div className="relative h-[400px] group">
                  <div className="absolute inset-0 transform group-hover:scale-105 transition-transform duration-700">
                    <img
                      src={`http://smartlabel1.runasp.net/Uploads/${mainImage}`}
                      alt="Main Banner"
                      className="w-full h-full object-cover"
                    />
                  </div>
                  <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-black/50 to-transparent opacity-80 group-hover:opacity-90 transition-all duration-500"></div>
                  <div className="absolute bottom-0 left-0 right-0 p-6">
                    <h3 className="text-2xl font-bold text-white mb-2">{banner.title}</h3>
                    <p className="text-gray-200">{banner.description}</p>
                  </div>
                </div>
              </SwiperSlide>
            )}
            {images.map((img, index) => (
              <SwiperSlide key={index}>
                <div className="relative h-[400px] group">
                  <div className="absolute inset-0 transform group-hover:scale-105 transition-transform duration-700">
                    <img
                      src={`http://smartlabel1.runasp.net/Uploads/${img.imageUrl}`}
                      alt={`Banner ${index + 1}`}
                      className="w-full h-full object-cover"
                    />
                  </div>
                  <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-black/50 to-transparent opacity-80 group-hover:opacity-90 transition-all duration-500"></div>
                  <div className="absolute bottom-0 left-0 right-0 p-6">
                    <h3 className="text-2xl font-bold text-white mb-2">{banner.title}</h3>
                    <p className="text-gray-200">{banner.description}</p>
                  </div>
                </div>
              </SwiperSlide>
            ))}
          </Swiper>
        </div>

        {/* Banner Info */}
        <div className="bg-white dark:bg-gray-800 rounded-2xl shadow-lg p-6 space-y-6">
          <div className="flex justify-between items-center">
            <h2 className="text-3xl font-bold text-gray-800 dark:text-white">{banner.title}</h2>
            <span className={`px-4 py-2 rounded-full text-sm font-medium ${
              banner.isActive 
                ? "bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-200"
                : "bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-200"
            }`}>
              {banner.isActive ? "Active" : "Inactive"}
            </span>
          </div>
          
          <p className="text-gray-600 dark:text-gray-300">{banner.description}</p>

          <div className="bg-gradient-to-r from-[#10EAF0] to-[#24009C] text-white p-6 rounded-xl shadow-md space-y-3">
            <div className="flex items-center space-x-2">
              <span className="font-semibold">Start Date:</span>
              <span>{banner.startDate ? formatDate(banner.startDate) : "N/A"}</span>
            </div>
            <div className="flex items-center space-x-2">
              <span className="font-semibold">End Date:</span>
              <span>{banner.endDate ? formatDate(banner.endDate) : "N/A"}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default BannerPage;
