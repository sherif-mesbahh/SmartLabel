import React, { useEffect, useState } from "react";
import { Link, useParams } from "react-router-dom";
import { DeleteFoodId, getAll, search } from "../../services/foodServices";
import Search from "../../component/Search";
import { toast } from "react-toastify";

function FoodsAdminPage() {
  const [foods, setFoods] = useState();
  const { searchTerm } = useParams();

  useEffect(() => {
    LoadFoods();
  }, [searchTerm]);

  const LoadFoods = async () => {
    const foods = searchTerm ? await search(searchTerm) : await getAll();
    setFoods(foods);
  };

  const DeleteFood = async (food) => {
    const confirmed = window.confirm("Are you sure you want to delete");
    if (!confirmed) return;
    await DeleteFoodId(food.id);
    toast.success(`"${food.name}" has been deleted`);
    setFoods(foods.filter((f) => f.id !== food.id));
  };

  return (
    <div className="p-8">
      <div className="text-center mb-6">
        <h1 className="text-2xl font-semibold mb-4">Manage Foods</h1>
        <div className="flex items-center justify-center space-x-2 mb-6">
          <Search SearchRoute={"/admin/foods/"} defaultRoute={"/admin/foods"} />
        </div>
        <Link
          to="/admin/addfood"
          className="bg-blue-600 text-white rounded-full px-4 py-2 font-medium mb-4 inline-block hover:bg-blue-800"
        >
          Add Food +
        </Link>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {foods &&
          foods.map((food) => (
            <div
              key={food.id}
              className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6"
            >
              <img
                src={food.imagePath}
                alt={food.name}
                className="w-24 h-24 rounded-full object-cover mb-3"
              />
              <Link
                to={`/food/${food.id}`}
                className="text-lg font-medium text-blue-600 hover:underline"
              >
                {food.name}
              </Link>
              <div className="text-gray-700 font-semibold mt-1">
                ${food.price}
              </div>
              <div className="flex space-x-4 mt-3">
                <Link
                  to={`/admin/editfood/${food.id}`}
                  className="bg-blue-600 text-white px-3 py-1 rounded-lg hover:bg-blue-700"
                >
                  Edit
                </Link>
                <button
                  onClick={() => DeleteFood(food)}
                  className="bg-red-600 text-white px-3 py-1 rounded-lg hover:bg-red-700"
                >
                  Delete
                </button>
              </div>
            </div>
          ))}
      </div>
    </div>
  );
}

export default FoodsAdminPage;
