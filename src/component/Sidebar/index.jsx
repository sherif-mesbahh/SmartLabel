import React from "react";
import { Link, useLocation } from "react-router-dom";

function Sidebar({ cats = [] }) {
  const location = useLocation();
  const currentId = location.pathname.split("/").pop();

  return (
    <aside className="w-64 p-6 bg-gradient-to-br from-blue-600 to-indigo-800 dark:from-gray-900 dark:to-gray-800 text-white rounded-r-xl shadow-lg min-h-screen">
      <div className="mb-8">
        <h2 className="text-2xl font-bold tracking-wide bg-clip-text text-transparent bg-gradient-to-r from-white to-blue-100">
          CATEGORIES
        </h2>
        <div className="mt-2 h-1 w-20 bg-gradient-to-r from-blue-400 to-indigo-400 rounded-full"></div>
      </div>
      
      <ul className="space-y-3">
        {cats &&
          cats.map((cat) => (
            <li key={cat.id}>
              <Link
                to={`/category/${cat.id}`}
                className={`block px-4 py-3 rounded-lg transition-all duration-300 font-medium ${
                  currentId === String(cat.id)
                    ? "bg-white text-indigo-600 dark:bg-gray-800 dark:text-indigo-400 shadow-lg transform scale-105"
                    : "hover:bg-white/10 hover:shadow-md hover:transform hover:scale-105"
                }`}
              >
                <div className="flex items-center">
                  <span className="flex-1">{cat.name}</span>
                  {currentId === String(cat.id) && (
                    <svg className="w-5 h-5 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" />
                    </svg>
                  )}
                </div>
              </Link>
            </li>
          ))}
      </ul>
    </aside>
  );
}

export default Sidebar;
