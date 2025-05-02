import React from "react";
import { Link } from "react-router-dom";

function Section1({ cats }) {
  return (
    <div className="bg-gradient-to-br from-white to-gray-50 rounded-xl shadow-lg p-6 border border-gray-100">
      <h2 className="text-2xl font-bold mb-6 text-center text-gray-800 relative pb-2">
        Categories
        <span className="absolute bottom-0 left-1/2 transform -translate-x-1/2 w-16 h-1 bg-gradient-to-r from-[#10EAF0] to-[#24009C] rounded-full"></span>
      </h2>

      <ul className="space-y-2">
        {cats.map((item) => (
          <li key={item.id}>
            <Link
              to={`/category/${item.id}`}
              className="flex items-center space-x-4 p-3 rounded-lg transition-all duration-300 
                        hover:bg-gradient-to-r hover:from-orange-50 hover:to-pink-50 
                        hover:shadow-md hover:-translate-y-0.5 hover:border hover:border-blue-400
                        group"
            >
              <div className="relative">
                <img
                  className="w-12 h-12 rounded-full object-cover border-2 border-white shadow-sm group-hover:border-blue-400 transition-all"
                  src={`http://smartlabel1.runasp.net/Uploads/${item.imageUrl}`}
                  alt={item.name}
                />
              </div>
              <span className="font-medium text-gray-700 group-hover:text-[#0028FF] transition-colors">
                {item.name}
              </span>
            </Link>
          </li>
        ))}
      </ul>

      <div className="mt-6 text-center">
        <Link
          to="/category"
          className="inline-block px-4 py-2 text-sm font-medium text-[#10EAF0] hover:text-white 
                    bg-white hover:bg-gradient-to-r from-[#10EAF0] to-[#24009C] 
                    rounded-full border border-blue-400 hover:border-transparent
                    transition-all duration-300 hover:shadow-lg"
        >
          View All Categories
        </Link>
      </div>
    </div>
  );
}

export default Section1;
