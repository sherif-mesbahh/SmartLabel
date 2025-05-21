import React, { useEffect, useState } from "react";
import { getAll, getAllCat, getBanners } from "../../services/foodServices";
import Section1 from "../../component/Section1";
import NewProducts from "../../component/Section2";
import Section3 from "../../component/Section3";
import { motion } from "framer-motion";

function Homepage() {
  const [food, setFood] = useState([]);
  const [cats, setCats] = useState([]);
  const [banners, setBanners] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const [foodData, tagData, bannerData] = await Promise.all([
          getAll(),
          getAllCat(),
          getBanners(),
        ]);
        setFood(foodData.data);
        setCats(tagData.data);
        setBanners(bannerData.data.data);
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    };

    fetchData();
  }, []);

  const containerVariants = {
    hidden: { opacity: 0 },
    visible: {
      opacity: 1,
      transition: {
        staggerChildren: 0.2,
        delayChildren: 0.3,
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
    <motion.div
      initial="hidden"
      animate="visible"
      variants={containerVariants}
      className="min-h-[100dvh] sm:min-h-screen bg-gradient-to-br from-blue-50 via-white to-purple-50 dark:from-gray-900 dark:via-gray-800 dark:to-gray-900"
    >
      {/* Hero Section with Banner */}
      <motion.div variants={itemVariants} className="w-full py-8  ">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="rounded-2xl overflow-hidden shadow-xl">
            <Section3 banners={banners} />
          </div>
        </div>
      </motion.div>

      {/* Main Content */}
      <div className="max-w-7xl mx-auto px-4 py-12 space-y-16">
        {/* Categories and Featured Products Section */}
        <motion.div
          variants={itemVariants}
          className="flex flex-col lg:flex-row gap-8"
        >
          {/* Categories Sidebar */}
          <div className="w-full lg:w-1/4">
            <motion.div
              initial={{ opacity: 0, x: -20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ duration: 0.35, delay: 0.2 }}
              className="sticky top-24"
            >
              <Section1 cats={cats} />
            </motion.div>
          </div>

          {/* Featured Products */}
          <div className="w-full lg:w-3/4">
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.5, delay: 0.4 }}
            >
              <NewProducts food={food} />
            </motion.div>
          </div>
        </motion.div>

        {/* Call to Action Section */}
        <motion.div
          variants={itemVariants}
          className="bg-gradient-to-r from-blue-600 to-purple-600 dark:from-blue-700 dark:to-purple-700 rounded-3xl p-12 text-center text-white shadow-xl"
        >
          <h2 className="text-4xl font-bold mb-4">Ready to Explore More?</h2>
          <p className="text-xl mb-8 opacity-90">
            Discover our complete collection of products and exclusive deals
          </p>
          <a
            href="/allproducts"
            className="inline-block bg-white dark:bg-gray-800 text-blue-600 dark:text-blue-400 font-semibold px-8 py-4 rounded-full hover:bg-opacity-90 dark:hover:bg-gray-700 transition-all duration-300 transform hover:scale-105 shadow-lg"
          >
            Browse All Products
          </a>
        </motion.div>
      </div>
    </motion.div>
  );
}

export default Homepage;
