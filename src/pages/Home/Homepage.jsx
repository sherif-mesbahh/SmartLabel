import React, { useEffect, useReducer, useState } from "react";

import {
  search,
  getAll,
  getAllTags,
  getAllByTags,
  getBanners,
} from "../../services/foodServices";

import Section1 from "../../component/Section1";

import NewProducts from "../../component/Section2";
import Section3 from "../../component/Section3";

function Homepage() {
  const [food, setfood] = useState([]);
  const [tags, settag] = useState([]);
  const [banners, setBanners] = useState([]);
  useEffect(() => {
    getAll().then((food) => setfood(food.data));
    getAllTags().then((tag) => settag(tag.data));
    getBanners().then((banner) => setBanners(banner.data.data));
  }, []);

  return (
    <>
      <Section1 tags={tags} />
      <Section3 banners={banners} />
      <NewProducts food={food} />
    </>
  );
}

export default Homepage;
