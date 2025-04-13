import React, { useEffect, useState } from "react";
import { getBannerById } from "../../services/foodServices";
import { useParams } from "react-router-dom";
import { Swiper, SwiperSlide } from "swiper/react";
import { Navigation } from "swiper/modules";

function BannerPage() {
  const [banner, setBanner] = useState([]);
  const [mainImage, setMainImage] = useState("");
  const { id } = useParams();

  useEffect(() => {
    getBannerById(id).then((data) => {
      setBanner(data.data.data);
      setMainImage(data.data.data.images[0]);
    });
  }, [id]);

  const images = banner.images || [];

  const formatDate = (dateStr) =>
    new Date(dateStr).toLocaleDateString("en-US", {
      year: "numeric",
      month: "long",
      day: "numeric",
    });

  return (
    <div className="max-w-6xl mx-auto p-6 min-h-screen">
      <div className="bg-white rounded-xl shadow-lg overflow-hidden">
        <div className="flex flex-col lg:flex-row">
          {/* Images Section - Left Side */}
          <div className="lg:w-1/2 p-6 flex flex-col items-center">
            {/* Main Image */}
            <div className="mb-6 w-full h-96 flex items-center justify-center bg-gray-100 rounded-lg overflow-hidden">
              {mainImage && (
                <img
                  src={`http://smartlabel1.runasp.net/Uploads/${mainImage}`}
                  alt="Main"
                  className="object-contain h-full w-full"
                />
              )}
            </div>

            {/* Thumbnail Swiper */}
            <div className="w-full">
              <Swiper
                slidesPerView={4}
                spaceBetween={10}
                navigation
                modules={[Navigation]}
                className="thumbnail-swiper"
              >
                {images.map((img, index) => (
                  <SwiperSlide key={index}>
                    <div
                      className={`cursor-pointer border-2 ${
                        mainImage === img
                          ? "border-blue-500"
                          : "border-transparent"
                      } rounded-lg overflow-hidden`}
                      onClick={() => setMainImage(img)}
                    >
                      <img
                        src={`http://smartlabel1.runasp.net/Uploads/${img}`}
                        alt={`Thumbnail ${index}`}
                        className="object-cover h-20 w-full"
                      />
                    </div>
                  </SwiperSlide>
                ))}
              </Swiper>
            </div>
          </div>

          {/* Information Section - Right Side */}
          <div className="lg:w-1/2 p-6 lg:p-8 flex flex-col justify-center">
            <h1 className="text-4xl font-bold text-gray-800 mb-4">
              {banner.title}
            </h1>
            <p className="text-gray-600 text-lg mb-6">{banner.description}</p>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
              <div className="bg-gray-50 p-4 rounded-lg">
                <h3 className="text-sm font-semibold text-gray-500 mb-1">
                  Start Date
                </h3>
                <p className="text-gray-800 font-medium">
                  {banner.startDate ? formatDate(banner.startDate) : "N/A"}
                </p>
              </div>
              <div className="bg-gray-50 p-4 rounded-lg">
                <h3 className="text-sm font-semibold text-gray-500 mb-1">
                  End Date
                </h3>
                <p className="text-gray-800 font-medium">
                  {banner.endDate ? formatDate(banner.endDate) : "N/A"}
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default BannerPage;
