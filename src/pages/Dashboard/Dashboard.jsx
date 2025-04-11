import React from "react";
import { useAuth } from "../../hooks/useAuth";
import { Link } from "react-router-dom";

function Dashboard() {
  const { user } = useAuth();
  const cards = [
    {
      label: "profile",
      Link: "profile",

      icon: "../public/icons/profile.png",
      bgColor: "bg-blue-500",
    },
    {
      label: "categories",
      Link: "admin/categories",
      forAdmin: true,
      icon: "../public/icons/category.png",
      bgColor: "bg-teal-500",
    },
    {
      label: "foods",
      Link: "admin/foods",
      forAdmin: true,
      icon: "../public/icons/fast-food.png",
      bgColor: "bg-purple-500",
    },
  ];

  return (
    <div className="flex flex-col items-center min-h-screen bg-gray-100">
      <h1 className="text-3xl font-bold mt-10 mb-8">Dashboard</h1>

      <div className="grid grid-cols-2 gap-4">
        {cards.map((card, index) => (
          <Link
            to={`/${card.Link}`}
            key={index}
            className={`flex flex-col items-center justify-center w-40 h-40 ${card.bgColor} rounded-lg shadow-lg text-white`}
          >
            <img src={card.icon} alt={card.label} className="w-12 h-12 mb-2" />
            <p className="text-lg font-medium">{card.label}</p>
          </Link>
        ))}
      </div>
    </div>
  );
}

export default Dashboard;
