import React from "react";
import { Link } from "react-router-dom";
function NotFound({ message }) {
  return (
    <div className="flex items-center justify-center h-screen bg-gray-100 mt-5 w-full">
      <div className="text-center">
        <h1 className="text-6xl font-bold text-gray-800 mb-8">{message} </h1>

        <Link
          to="/"
          className="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600"
        >
          Go Back Home
        </Link>
      </div>
    </div>
  );
}

export default NotFound;
