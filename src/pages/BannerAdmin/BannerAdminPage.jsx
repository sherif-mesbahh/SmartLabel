import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { DeleteBannerId, getBanners } from "../../services/foodServices";
import { toast } from "react-toastify";

function BannerAdminPage() {
  const [Banners, setBanners] = useState();

  useEffect(() => {
    loadBanners();
  }, []);

  const loadBanners = async () => {
    const response = await getBanners();
    setBanners(response.data.data);
  };

  const deleteBanner = async (banner) => {
    const confirmed = window.confirm("Are you sure you want to delete?");
    if (!confirmed) return;

    await DeleteBannerId(banner.id);
    toast.success(`"${banner.title}" has been deleted`);
    setBanners(Banners.filter((b) => b.id !== banner.id));
  };

  return (
    <div className="p-8 bg-slate-100 min-h-screen">
      <div className="text-center mb-8">
        <h1 className="text-3xl font-bold text-indigo-600 mb-4">
          Manage Banners
        </h1>
        <Link
          to="/admin/addbanner"
          className="bg-indigo-600 text-white px-6 py-2 rounded-full font-medium hover:bg-indigo-700 transition"
        >
          + Add Banner
        </Link>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {Banners &&
          Banners.map((banner) => (
            <div
              key={banner.id}
              className="bg-white rounded-xl shadow-md overflow-hidden"
            >
              <Link to={`/banner/${banner.id}`}>
                <img
                  src={`http://smartlabel1.runasp.net/Uploads/${banner.mainImage}`}
                  alt={banner.name}
                  className="w-full h-48 object-cover"
                />
              </Link>

              <div className="p-4 text-center">
                <h3 className="text-lg font-semibold text-indigo-700">
                  {banner.title}
                </h3>
                <div className="flex justify-center gap-4 mt-4">
                  <Link
                    to={`/admin/editbanner/${banner.id}`}
                    className="bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-lg transition"
                  >
                    Edit
                  </Link>
                  <button
                    onClick={() => deleteBanner(banner)}
                    className="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-lg transition"
                  >
                    Delete
                  </button>
                </div>
              </div>
            </div>
          ))}
      </div>
    </div>
  );
}

export default BannerAdminPage;
