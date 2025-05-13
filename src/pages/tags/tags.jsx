import React, { useEffect, useState } from "react";
import Sidebar from "../../component/Sidebar";
import {
  getAll,
  getAllByCat,
  getAllCat,
  search as SearchFood,
} from "../../services/foodServices";
import ProductGrid from "../../component/ProductGrid";
import { useParams, useLocation } from "react-router-dom";
import Search from "../../component/Search";

function useQuery() {
  return new URLSearchParams(useLocation().search);
}

function Tags() {
  const query = useQuery();
  const searchTerm = query.get("Search");
  const [food, setFood] = useState([]);
  const [cats, setCats] = useState([]);
  const { id } = useParams();

  useEffect(() => {
    getAllCat().then((data) => setCats(data.data));
  }, []);

  useEffect(() => {
    if (searchTerm) {
      SearchFood(searchTerm).then((data) => setFood(data.data));
    } else if (id) {
      getAllByCat(id).then((data) => setFood(data.data.products));
    } else {
      getAll().then((data) => setFood(data.data));
    }
  }, [id, searchTerm]);

  return (
    <div className="flex">
      <Sidebar cats={cats} />
      <div className="flex-1 p-4">
        <Search defaultRoute="/category/" />
        <ProductGrid food={food} />
      </div>
    </div>
  );
}

export default Tags;
