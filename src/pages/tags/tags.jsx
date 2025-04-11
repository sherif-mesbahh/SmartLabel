import React, { useEffect, useState } from "react";
import Sidebar from "../../component/Sidebar";
import { getAll, getAllTags } from "../../services/foodServices";
import ProductGrid from "../../component/ProductGrid";

function Tags() {
  const [food, setFood] = useState([]);
  const [tags, setTags] = useState([]);
  const [selectedTags, setSelectedTags] = useState([]); // Track selected categories

  useEffect(() => {
    getAll().then((data) => setFood(data.data));
    getAllTags().then((data) => setTags(data.data));
  }, []);

  // Function to toggle category selection

  // Filter products based on selected categories

  return (
    <div className="flex">
      <Sidebar tags={tags} />
      <div className="flex-1 p-4">
        <ProductGrid food={food} />
      </div>
    </div>
  );
}

export default Tags;
