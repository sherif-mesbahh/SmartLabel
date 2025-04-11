import React from "react";
import { Link } from "react-router-dom";

function Section1({ tags }) {
  console.log(tags);
  return (
    <div className="my-12">
      <div className="max-w-7xl mx-auto px-4 ">
        <h1 className=" text-3xl font-bold uppercase mb-2 text-center pb-5 ">
          {" "}
          Category
        </h1>
        <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-6 gap-6">
          {tags.map((item) => (
            <Link
              to={`/tags`}
              key={item.id}
              className="bg-gray-100 rounded-lg p-4 shadow-md"
            >
              <div className="flex flex-col items-center">
                <div className="w-20 h-20 flex items-center justify-center">
                  <img
                    className="w-full h-full object-cover rounded-lg"
                    src={`http://smartlabel1.runasp.net/Uploads/${item.imageUrl}`}
                    alt={item.name}
                  />
                </div>
                <div className="text-center mt-3">
                  <h3 className="text-lg font-semibold ">
                    {item.name} <br />
                  </h3>
                </div>
              </div>
            </Link>
          ))}
        </div>
      </div>
    </div>
  );
}

export default Section1;
