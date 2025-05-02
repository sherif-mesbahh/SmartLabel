import React, { useEffect, useState } from "react";
import { getAll, search as searchFoods } from "../../services/foodServices";
import { Link, useParams } from "react-router-dom";
import { useFavorites } from "../../hooks/useCart";
import Search from "../../component/Search";
import { useLocation } from "react-router-dom";
import ProductCard from "../../component/ProductCard";
function useQuery() {
  return new URLSearchParams(useLocation().search);
}
function AllProductPage() {
  const { toggleFavorite, favorites } = useFavorites();
  const [foods, setFoods] = useState([]);

  const query = useQuery();
  const searchTerm = query.get("Search");
  useEffect(() => {
    if (searchTerm) {
      searchFoods(searchTerm).then((data) => {
        setFoods(data.data);
        console.log(data.data);
      });
    } else {
      getAll().then((data) => setFoods(data.data));
    }
  }, [searchTerm]);
  const AddItemHandle = (item) => {
    toggleFavorite(item);
  };

  const isFavorite = (item) => {
    return favorites.items.some((favItem) => favItem.id === item.id);
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-gray-100 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-7xl mx-auto">
        {/* Animated Header */}
        <div className="text-center mb-12">
          <h1 className="text-4xl md:text-5xl font-extrabold text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-indigo-800 mb-4 animate-fade-in">
            Discover Our Products
          </h1>
          <p className="text-lg text-gray-600 max-w-2xl mx-auto animate-fade-in delay-100">
            Explore our premium selection of items with exclusive discounts
          </p>
        </div>

        <Search />

        {/* Product Grid */}
        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-8">
          {foods &&
            foods.map((food) => <ProductCard item={food} key={food.id} />)}
        </div>
      </div>
    </div>
  );
}

export default AllProductPage;
