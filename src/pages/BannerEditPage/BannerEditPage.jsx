import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import {
  addBanner,
  getBannerById,
  updateBanner,
} from "../../services/foodServices";
import { toast } from "react-toastify";

function BannerEditPage() {
  const { bannerId } = useParams();
  const isEditMode = !!bannerId;

  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");
  const [mainImage, setMainImage] = useState(null);
  const [imagesFiles, setImagesFiles] = useState([]);
  const [removedImageIds, setRemovedImageIds] = useState([]);

  useEffect(() => {
    if (!isEditMode) return;

    getBannerById(bannerId).then((res) => {
      const data = res.data.data;
      setTitle(data.title);
      setDescription(data.description);
      setStartDate(data.startDate);
      setEndDate(data.endDate);
      setMainImage(data.mainImage);
      setImagesFiles(data.images?.map((img) => img.imageUrl) || []);
      setRemovedImageIds(data.images?.map((img) => img.imageId) || []);
      console.log(data.startDate);
    });
  }, [bannerId, isEditMode]);

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (isEditMode) {
      await updateBanner(
        bannerId,
        title,
        description,
        startDate,
        endDate,
        mainImage,
        imagesFiles,
        removedImageIds
      );
      toast.success(`Banner "${title}" updated successfully`);
    } else {
      await addBanner(
        title,
        description,
        startDate,
        endDate,
        mainImage,
        imagesFiles
      );
      toast.success(`Banner "${title}" added successfully`);
    }
  };

  return (
    <div className="flex justify-center items-center min-h-screen bg-gray-100">
      <div className="bg-white p-8 rounded-xl shadow-lg w-full max-w-lg">
        <h2 className="text-2xl font-bold text-center mb-6 text-indigo-600">
          {isEditMode ? "Edit Banner" : "Add Banner"}
        </h2>
        <form onSubmit={handleSubmit} className="space-y-4">
          <input
            type="text"
            placeholder="Title"
            value={title}
            onChange={(e) => setTitle(e.target.value)}
            className="w-full border border-gray-300 rounded-lg p-2"
            required
          />

          <input
            type="text"
            placeholder="Description"
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            className="w-full border border-gray-300 rounded-lg p-2"
            required
          />

          <input
            type="date"
            value={startDate ? startDate.substring(0, 10) : ""}
            onChange={(e) => setStartDate(e.target.value)}
            className="w-full border border-gray-300 rounded-lg p-2 text-gray-600"
            required
          />

          <input
            type="date"
            value={endDate ? endDate.substring(0, 10) : ""}
            onChange={(e) => setEndDate(e.target.value)}
            className="w-full border border-gray-300 rounded-lg p-2 text-gray-600"
            required
          />

          <label className="block text-sm font-medium text-gray-600">
            Main Image:
          </label>
          <input
            type="file"
            accept="image/*"
            onChange={(e) => setMainImage(e.target.files[0])}
            className="w-full border border-gray-300 rounded-lg p-2"
          />
          {mainImage && (
            <img
              src={
                typeof mainImage === "string"
                  ? `http://smartlabel1.runasp.net/Uploads/${mainImage}`
                  : URL.createObjectURL(mainImage)
              }
              alt="Main Preview"
              className="w-full h-48 object-cover rounded mt-2"
            />
          )}

          <label className="block text-sm font-medium text-gray-600">
            Extra Images:
          </label>
          <input
            type="file"
            accept="image/*"
            multiple
            onChange={(e) => setImagesFiles(Array.from(e.target.files))}
            className="w-full border border-gray-300 rounded-lg p-2"
          />
          <div className="grid grid-cols-2 gap-2">
            {imagesFiles &&
              imagesFiles.map((img, idx) => (
                <img
                  key={idx}
                  src={
                    typeof img === "string"
                      ? `http://smartlabel1.runasp.net/Uploads/${img}`
                      : URL.createObjectURL(img)
                  }
                  alt={`Preview ${idx}`}
                  className="h-24 object-cover rounded"
                />
              ))}
          </div>

          <button
            type="submit"
            className="w-full bg-indigo-600 hover:bg-indigo-700 text-white py-2 rounded-lg font-medium transition"
          >
            {isEditMode ? "Update" : "Add"} Banner
          </button>
        </form>
      </div>
    </div>
  );
}

export default BannerEditPage;
