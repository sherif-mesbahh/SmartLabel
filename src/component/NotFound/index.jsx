import React from "react";
import { Link } from "react-router-dom";
import Lottie from 'lottie-react';
import emptyAnim from '../../assets/empty.json';

function NotFound({ message }) {
  return (
    <div className="flex items-end py-24   relative min-h-[60vh] xs:min-h-[75vh] justify-center shadow-xl  bg-gray-100  w-full">
      <div className="text-center">
  <Lottie animationData={emptyAnim} loop autoplay className="w-[100%] absolute mx-auto mb-[150px]  inset-0"/>

        <h1 className="sm:text-5xl text-4xl font-bold text-gray-800 mb-8">{message} </h1>

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
