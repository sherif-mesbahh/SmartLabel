import { Link } from "react-router-dom";
import { useAuth } from "../../hooks/useAuth";

function Dashboard() {
  const { userInfo } = useAuth();

  const cards = [
    {
      label: "Profile",
      link: "profile",
      icon: "/icons/profile.png",
      bgColor: "bg-blue-500",
    },
    {
      label: "Categories",
      link: "admin/categories",
      forAdmin: true,
      icon: "/icons/category.png",
      bgColor: "bg-teal-500",
    },
    {
      label: "Foods",
      link: "admin/foods",
      forAdmin: true,
      icon: "/icons/fast-food.png",
      bgColor: "bg-purple-500",
    },
    {
      label: "Banners",
      link: "admin/banners",
      forAdmin: true,
      icon: "/icons/banner.png",
      bgColor: "bg-orange-400",
    },
    {
      label: "Admin Users",
      link: "admin/dashboard",
      forAdmin: true,
      icon: "/icons/users.png",
      bgColor: "bg-red-400",
    },
  ];

  return (
    <div className="min-h-screen bg-gray-100 flex flex-col items-center py-10 px-4">
      <h1 className="text-4xl font-bold text-indigo-700 mb-10">Dashboard</h1>

      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6">
        {cards
          .filter(
            (card) => !card.forAdmin || userInfo?.data.roles[0] === "Admin"
          )
          .map((card, index) => (
            <Link
              to={`/${card.link}`}
              key={index}
              className={`flex flex-col items-center justify-center w-40 h-40 rounded-xl shadow-lg text-white transition-transform hover:scale-105 ${card.bgColor}`}
            >
              <img
                src={card.icon}
                alt={card.label}
                className="w-14 h-14 mb-3"
              />
              <p className="text-lg font-semibold">{card.label}</p>
            </Link>
          ))}
      </div>
    </div>
  );
}

export default Dashboard;
