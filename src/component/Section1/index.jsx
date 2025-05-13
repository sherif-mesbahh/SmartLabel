import React from "react";
import { Link } from "react-router-dom";

function Section1({ cats }) {
  return (
    <div className="bg-gradient-to-br from-white to-gray-50 dark:from-gray-800 dark:to-gray-900 rounded-xl shadow-lg p-6 border border-gray-100 dark:border-gray-700">
      <div className="text-center mb-8">
        <h2 className="text-3xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-indigo-800 dark:from-blue-400 dark:to-indigo-600 relative pb-2">
          Categories
          <div className="absolute bottom-0 left-1/2 transform -translate-x-1/2 w-20 h-1 bg-gradient-to-r from-blue-400 to-indigo-400 rounded-full"></div>
        </h2>
      </div>

      <ul className="space-y-3">
        {cats.map((item) => (
          <li key={item.id}>
            <Link
              to={`/category/${item.id}`}
              className="flex items-center space-x-4 p-4 rounded-lg transition-all duration-300 
                        hover:bg-gradient-to-r hover:from-blue-50 hover:to-indigo-50 dark:hover:from-gray-700 dark:hover:to-gray-800
                        hover:shadow-lg hover:-translate-y-0.5 hover:border hover:border-blue-400 dark:hover:border-blue-500
                        group bg-white dark:bg-gray-800"
            >
              <div className="relative">
                <img
                  className="w-14 h-14 rounded-full object-cover border-2 border-white dark:border-gray-700 shadow-md group-hover:border-blue-400 dark:group-hover:border-blue-500 transition-all duration-300"
                  src={`http://smartlabel1.runasp.net/Uploads/${item.imageUrl}`}
                  alt={item.name}
                />
                <div className="absolute inset-0 rounded-full bg-gradient-to-br from-blue-400/20 to-indigo-400/20 opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
              </div>
              <span className="font-medium text-gray-700 dark:text-gray-300 group-hover:text-blue-600 dark:group-hover:text-blue-400 transition-colors duration-300">
                {item.name}
              </span>
            </Link>
          </li>
        ))}
      </ul>

      <div className="mt-8 text-center">
        <Link
          to="/category"
          className="inline-flex items-center px-6 py-3 text-sm font-medium text-white 
                    bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-700 hover:to-indigo-700
                    dark:from-blue-500 dark:to-indigo-500 dark:hover:from-blue-600 dark:hover:to-indigo-600
                    rounded-lg border border-transparent
                    transition-all duration-300 hover:shadow-lg hover:scale-105"
        >
          View All Categories
          <svg className="w-5 h-5 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 8l4 4m0 0l-4 4m4-4H3" />
          </svg>
        </Link>
      </div>
    </div>
  );
}

export default Section1;
