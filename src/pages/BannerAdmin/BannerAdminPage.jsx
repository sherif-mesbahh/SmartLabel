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
    console.log(response.data.data);
  };

  const deleteBanner = async (banner) => {
    const confirmed = window.confirm("Are you sure you want to delete?");
    if (!confirmed) return;

    await DeleteBannerId(banner.id);
    toast.success(`"${banner.title}" has been deleted`);
    setBanners(Banners.filter((b) => b.id !== banner.id));
  };

  return (
    <div className=" bg-gradient-to-br from-blue-50 to-indigo-100 dark:from-gray-900 dark:to-gray-800 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-7xl mx-auto">
        {/* Header Section */}
        <div className="text-center mb-12">
          <h1 className="text-4xl md:text-5xl font-extrabold text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-indigo-800 dark:from-blue-400 dark:to-indigo-600 mb-4">
            Banner Administration
          </h1>
          <p className="text-lg text-gray-600 dark:text-gray-300 max-w-2xl mx-auto">
            Manage and customize your promotional banners
          </p>
        </div>

        {/* Banner List */}
        <div className="bg-white dark:bg-gray-800 rounded-2xl shadow-lg overflow-hidden">
          <div className="p-6">
            <div className="flex justify-between items-center mb-6">
              <h2 className="text-2xl font-bold text-gray-900 dark:text-white">
                Active Banners
              </h2>
              <Link
                to="/admin/addbanner"
                className="px-4 py-2 bg-blue-600 hover:bg-blue-700 dark:bg-blue-500 dark:hover:bg-blue-600 text-white rounded-lg transition-colors"
              >
                Add New Banner
              </Link>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
              {Banners &&
                Banners.map((banner) => (
                  <div
                    key={banner.id}
                    className="bg-gray-50 dark:bg-gray-700 rounded-xl overflow-hidden shadow-[6px_6px_10px_0px_rgba(0,0,0,0.6)]"
                  >
                    <div className="relative">
                      <img
                        src={`http://smartlabel1.runasp.net/Uploads/${banner.mainImage}`}
                        alt={banner.title}
                        className="w-full h-48 object-cover"
                      />
                      <div className="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent"></div>
                      <div className="absolute bottom-0 left-0 right-0 p-4">
                        <h3 className="text-xl font-bold text-white">
                          {banner.title}
                        </h3>
                        <p className="text-sm text-gray-200">
                          {banner.description}
                        </p>
                      </div>
                    </div>
                    <div className="p-4">
                      <div className="flex justify-between items-center">
                       
                        <div className="flex space-x-2">
                          <Link
                            to={`/admin/editbanner/${banner.id}`}
                            className="text-blue-600 dark:text-blue-400 hover:text-blue-800 dark:hover:text-blue-300"
                          >
                            Edit
                          </Link>
                          <button
                            onClick={() => deleteBanner(banner)}
                            className="text-red-600 dark:text-red-400 hover:text-red-800 dark:hover:text-red-300"
                          >
                            Delete
                          </button>
                        </div>
                      </div>
                    </div>
                  </div>
                ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default BannerAdminPage;
