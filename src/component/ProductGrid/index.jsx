import React, { useState } from "react";
import ProductCard from "../ProductCard";

function ProductGrid({ food }) {
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 8;

  const startIndex = (currentPage - 1) * itemsPerPage;
  const currentItems = food.slice(startIndex, startIndex + itemsPerPage);

  return (
    <div className="mb-12">
      <div className="max-w-7xl mx-auto px-4 grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
        {currentItems.map((item) => (
          <ProductCard key={item.id} item={item} />
        ))}
      </div>

      {food.length > itemsPerPage && (
        <div className="flex justify-center mt-10">
          <ul className="inline-flex space-x-2 bg-white p-2 rounded-lg shadow-md">
            {Array.from(
              { length: Math.ceil(food.length / itemsPerPage) },
              (_, i) => (
                <li key={i}>
                  <button
                    onClick={() => setCurrentPage(i + 1)}
                    className={`px-4 py-2 rounded-md border text-sm font-medium transition-all duration-200
                      ${
                        currentPage === i + 1
                          ? "bg-gradient-to-r from-[#10EAF0] to-[#24009C] text-white border-transparent"
                          : "text-[#0028FF] border-[#0028FF] hover:bg-[#0028FF] hover:text-white"
                      }`}
                  >
                    {i + 1}
                  </button>
                </li>
              )
            )}
          </ul>
        </div>
      )}
    </div>
  );
}

export default ProductGrid;
