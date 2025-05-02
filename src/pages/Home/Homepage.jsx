import React, { useEffect, useState } from "react";
import { getAll, getAllCat, getBanners } from "../../services/foodServices";
import Section1 from "../../component/Section1";
import NewProducts from "../../component/Section2";
import Section3 from "../../component/Section3";

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

  return (
    <div className="max-w-7xl mx-auto px-4 my-10 space-y-10">
      {/* Top Part: Section1 + Section3 side by side */}
      <div className="flex gap-6 animate-fadeIn">
        {/* Left Side: Section1 */}
        <div className="w-1/4">
          <div className="transition-all duration-300 hover:translate-x-1">
            <Section1 cats={cats} />
          </div>
        </div>

        {/* Right Side: Section3 */}
        <div className="w-3/4 animate-slideInUp">
          <Section3 banners={banners} />
        </div>
      </div>

      {/* Bottom Part: NewProducts */}
      <div className="animate-slideInUp delay-100">
        <NewProducts food={food} />
      </div>
    </div>
  );
}

export default Homepage;
