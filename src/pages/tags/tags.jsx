import React, { useEffect, useState } from "react";
import Sidebar from "../../component/Sidebar";
import { getAll, getAllByCat, getAllCat } from "../../services/foodServices";
import ProductGrid from "../../component/ProductGrid";
import { useParams } from "react-router-dom";

function Tags() {
  const [food, setFood] = useState([]);
  const [cats, setcats] = useState([]);
  const { id } = useParams(); // Track selected categories

  useEffect(() => {
    getAllCat().then((data) => setcats(data.data));
    getAllByCat(id).then((data) => setFood(data.data.products));
    if (!id) {
      getAll().then((data) => setFood(data.data));
    }
  }, [id]);

  return (
    <div className="flex">
      <Sidebar cats={cats} />
      <div className="flex-1 p-4">
        <ProductGrid food={food} />
      </div>
    </div>
  );
}

export default Tags;
