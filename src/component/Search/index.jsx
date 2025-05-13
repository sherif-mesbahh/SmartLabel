import React, { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";

Search.defaultProps = {
  defaultRoute: "/allproducts/",
  placeholder: " Search Food ",
};

function Search({ defaultRoute, placeholder }) {
  const [term, setTerm] = useState("");
  const navigate = useNavigate();
  const { searchTerm } = useParams();

  const search = () => {
    term
      ? navigate(`${defaultRoute}?Search=${encodeURIComponent(term)}`)
      : navigate(defaultRoute);
  };

  useEffect(() => {
    setTerm(searchTerm ?? "");
  }, [searchTerm]);

  return (
    <div className="max-w-md mx-auto">
      <div className="relative">
        <input
          type="text"
          placeholder={placeholder}
          className="w-full px-4 py-3 rounded-xl border border-gray-200 focus:border-blue-500 focus:ring-2 focus:ring-blue-200 transition-all duration-200"
          onChange={(e) => setTerm(e.target.value)}
          onKeyUp={(e) => e.key === "Enter" && search()}
          value={term}
        />
        <svg
          className="absolute right-3 top-3.5 h-5 w-5 text-gray-400"
          fill="none"
          stroke="currentColor"
          viewBox="0 0 24 24"
        >
          <path
            strokeLinecap="round"
            strokeLinejoin="round"
            strokeWidth="2"
            d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
          />
        </svg>
      </div>
    </div>
  );
}

export default Search;
