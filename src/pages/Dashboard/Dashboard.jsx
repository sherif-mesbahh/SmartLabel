import { Link } from "react-router-dom";
import { useAuth } from "../../hooks/useAuth";
import { motion } from "framer-motion";
import { useEffect, useState } from "react";
import { getAll as getAllUsers } from "../../services/userServices";
import { getAll as getAllFoods, getAllCat } from "../../services/foodServices";

function Dashboard() {
  const { userInfo } = useAuth();
  const [stats, setStats] = useState({
    totalProducts: 0,
    activeCategories: 0,
    totalUsers: 0,
  });
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    const fetchStats = async () => {
      try {
        if (userInfo?.data.roles[0] === "Admin") {
          const [usersData, foodsData, categoriesData] = await Promise.all([
            getAllUsers(),
            getAllFoods(),
            getAllCat(),
          ]);

          setStats({
            totalProducts: foodsData.data?.length || 0,
            activeCategories: categoriesData.data?.length || 0,
            totalUsers: usersData.data.data?.length || 0,
          });
        }
      } catch (error) {
        console.error("Error fetching stats:", error);
      } finally {
        setIsLoading(false);
      }
    };

    fetchStats();
  }, [userInfo]);

  const cards = [
    {
      label: "Profile",
      link: "profile",
      icon: "/icons/profile.png",
      bgColor: "from-blue-500 to-blue-600",
      description: "Manage your personal information and settings",
    },
    {
      label: "Categories",
      link: "admin/categories",
      forAdmin: true,
      icon: "/icons/category.png",
      bgColor: "from-teal-500 to-teal-600",
      description: "Manage product categories and subcategories",
    },
    {
      label: "Products",
      link: "admin/foods",
      forAdmin: true,
      icon: "/icons/fast-food.png",
      bgColor: "from-purple-500 to-purple-600",
      description: "Add, edit, or remove products from your catalog",
    },
    {
      label: "Banners",
      link: "admin/banners",
      forAdmin: true,
      icon: "/icons/banner.png",
      bgColor: "from-orange-400 to-orange-500",
      description: "Manage promotional banners and featured content",
    },
    {
      label: "Admin Users",
      link: "admin/dashboard",
      forAdmin: true,
      icon: "/icons/users.png",
      bgColor: "from-red-400 to-red-500",
      description: "Manage user roles and permissions",
    },
  ];

  const containerVariants = {
    hidden: { opacity: 0 },
    visible: {
      opacity: 1,
      transition: {
        staggerChildren: 0.1,
      },
    },
  };

  const itemVariants = {
    hidden: { opacity: 0, y: 20 },
    visible: {
      opacity: 1,
      y: 0,
      transition: { duration: 0.5 },
    },
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-gray-50 to-gray-100 dark:from-gray-900 dark:to-gray-800 py-12 px-4 sm:px-6 lg:px-8">
      <motion.div
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5 }}
        className="max-w-7xl mx-auto"
      >
        {/* Header Section */}
        <div className="text-center mb-12">
          <h1 className="text-4xl md:text-5xl font-extrabold text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-indigo-800 dark:from-blue-400 dark:to-indigo-600 mb-4">
            Welcome to Dashboard
          </h1>
          <p className="text-lg text-gray-600 dark:text-gray-300 max-w-2xl mx-auto">
            Manage your account, products, and settings all in one place
          </p>
        </div>

        {/* Cards Grid */}
        <motion.div
          variants={containerVariants}
          initial="hidden"
          animate="visible"
          className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8"
        >
          {cards
            .filter(
              (card) => !card.forAdmin || userInfo?.data.roles[0] === "Admin"
            )
            .map((card, index) => (
              <motion.div
                key={index}
                variants={itemVariants}
                whileHover={{ scale: 1.02 }}
                whileTap={{ scale: 0.98 }}
              >
                <Link to={`/${card.link}`} className="block h-full">
                  <div
                    className={`h-full bg-gradient-to-br ${card.bgColor} rounded-2xl shadow-lg overflow-hidden transform transition-all duration-300 hover:shadow-xl`}
                  >
                    <div className="p-6">
                      <div className="flex items-center space-x-4 mb-4">
                        <div className="bg-white/20 p-3 rounded-xl">
                          <img
                            src={card.icon}
                            alt={card.label}
                            className="w-8 h-8"
                          />
                        </div>
                        <h3 className="text-xl font-bold text-white">
                          {card.label}
                        </h3>
                      </div>
                      <p className="text-white/80 text-sm">
                        {card.description}
                      </p>
                    </div>
                    <div className="bg-black/10 p-4 flex justify-between items-center">
                      <span className="text-white/90 text-sm">
                        Click to access
                      </span>
                      <svg
                        className="w-5 h-5 text-white/90"
                        fill="none"
                        stroke="currentColor"
                        viewBox="0 0 24 24"
                      >
                        <path
                          strokeLinecap="round"
                          strokeLinejoin="round"
                          strokeWidth="2"
                          d="M9 5l7 7-7 7"
                        />
                      </svg>
                    </div>
                  </div>
                </Link>
              </motion.div>
            ))}
        </motion.div>

        {/* Quick Stats Section */}
        {userInfo?.data.roles[0] === "Admin" && (
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5, delay: 0.2 }}
            className="mt-12 bg-white dark:bg-gray-800 rounded-2xl shadow-lg p-6"
          >
            <h2 className="text-2xl font-bold text-gray-800 dark:text-white mb-6">
              Quick Stats
            </h2>
            {isLoading ? (
              <div className="flex justify-center items-center py-8">
                <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
              </div>
            ) : (
              <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div className="bg-blue-50 dark:bg-blue-900/30 rounded-xl p-4">
                  <h3 className="text-lg font-semibold text-blue-600 dark:text-blue-400">
                    Total Products
                  </h3>
                  <p className="text-3xl font-bold text-blue-800 dark:text-blue-300 mt-2">
                    {stats.totalProducts}
                  </p>
                </div>
                <div className="bg-green-50 dark:bg-green-900/30 rounded-xl p-4">
                  <h3 className="text-lg font-semibold text-green-600 dark:text-green-400">
                    Active Categories
                  </h3>
                  <p className="text-3xl font-bold text-green-800 dark:text-green-300 mt-2">
                    {stats.activeCategories}
                  </p>
                </div>
                <div className="bg-purple-50 dark:bg-purple-900/30 rounded-xl p-4">
                  <h3 className="text-lg font-semibold text-purple-600 dark:text-purple-400">
                    Total Users
                  </h3>
                  <p className="text-3xl font-bold text-purple-800 dark:text-purple-300 mt-2">
                    {stats.totalUsers}
                  </p>
                </div>
              </div>
            )}
          </motion.div>
        )}
      </motion.div>
    </div>
  );
}

export default Dashboard;
