import React, { useEffect, useState } from "react";
import { Link, useLocation } from "react-router-dom";

function Sidebar({ tags = [] }) {
  return (
    <aside className="w-64 p-4 border-r">
      <h2 className="text-lg font-bold mb-4">CATEGORIES</h2>
      <ul>
        {tags.map((cat, i) => (
          <li key={i} className="flex items-center space-x-2">
            <input type="checkbox" className=" text-blue-600" />
            <Link to={`/tags/category=${cat.name}`}>{cat.name}</Link>
          </li>
        ))}
      </ul>
    </aside>
  );
}

export default Sidebar;
