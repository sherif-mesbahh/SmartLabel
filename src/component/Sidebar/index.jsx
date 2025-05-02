import React from "react";
import { Link, useLocation } from "react-router-dom";

function Sidebar({ cats = [] }) {
  const location = useLocation();
  const currentId = location.pathname.split("/").pop();

  return (
    <aside className="w-64 p-6 bg-gradient-to-b from-[#10EAF0] to-[#24009C] text-white rounded-r-xl shadow-lg min-h-screen">
      <h2 className="text-2xl font-bold mb-6 tracking-wide">CATEGORIES</h2>
      <ul className="space-y-4">
        {cats &&
          cats.map((cat) => (
            <li key={cat.id}>
              <Link
                to={`/category/${cat.id}`}
                className={`block px-4 py-2 rounded-lg transition-all duration-200 font-medium ${
                  currentId === String(cat.id)
                    ? "bg-white text-[#0028FF]"
                    : "hover:bg-white hover:text-[#0028FF]"
                }`}
              >
                {cat.name}
              </Link>
            </li>
          ))}
      </ul>
    </aside>
  );
}

export default Sidebar;
