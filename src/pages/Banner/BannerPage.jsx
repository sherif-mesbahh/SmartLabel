import React, { useEffect, useState } from "react";
import { getBannerById } from "../../services/foodServices";
import { useParams } from "react-router-dom";
import { Swiper, SwiperSlide } from "swiper/react";
import { Navigation } from "swiper/modules";
import { formatDate } from "../../EditData";
import "swiper/css";

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
    <div className="container mx-auto py-10 text-[#0028FF]">
      <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
        {/* Thumbnail Swiper */}
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
                  src={`http://smartlabel1.runasp.net/Uploads/${img.imageUrl}`}
                  alt={`Thumbnail ${index}`}
                  className={`w-28 h-28 object-cover cursor-pointer border-2 ${
                    mainImage === img.imageUrl
                      ? "border-blue-500"
                      : "border-transparent"
                  } rounded-lg`}
                  onClick={() => {
                    if (mainImage === img.imageUrl) return;
                    const prevMain = mainImage;
                    setMainImage(img.imageUrl);
                    if (!images.some((image) => image.imageUrl === prevMain)) {
                      setBanner((prev) => ({
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
          {mainImage && (
            <img
              src={`http://smartlabel1.runasp.net/Uploads/${mainImage}`}
              alt="Main"
              className="h-96 w-96 object-cover rounded-lg shadow-lg"
            />
          )}
        </div>

        {/* Banner Info */}
        <div className="space-y-4">
          <h2 className="text-3xl font-bold">{banner.title}</h2>
          <p className="text-gray-600">{banner.description}</p>

          <div className="bg-gradient-to-r from-[#10EAF0] to-[#24009C] text-white p-4 rounded-lg shadow-md space-y-2">
            <div>
              <span className="font-semibold">Start Date:</span>{" "}
              {banner.startDate ? formatDate(banner.startDate) : "N/A"}
            </div>
            <div>
              <span className="font-semibold">End Date:</span>{" "}
              {banner.endDate ? formatDate(banner.endDate) : "N/A"}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default BannerPage;
