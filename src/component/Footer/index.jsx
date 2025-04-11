import React from "react";

function Footer() {
  return (
    <>
      <div className="bg-gray-100 py-6">
        <div className="max-w-7xl mx-auto px-4 text-center">
          <p className="text-lg font-semibold">
            Sign Up for the <strong>NEWSLETTER</strong>
          </p>
          <form className="mt-4 flex justify-center">
            <input
              className="p-2 border border-gray-300 rounded-l-md focus:outline-none"
              type="email"
              placeholder="Enter Your Email"
            />
            <button className="bg-teal-400 text-white px-4 py-2 rounded-r-md hover:bg-teal-500 transition">
              <i className="fa fa-envelope"></i> Subscribe
            </button>
          </form>
          <div className="flex justify-center space-x-4 mt-4">
            <a href="#" className="text-gray-600 hover:text-blue-500">
              <i className="fab fa-facebook-f"></i>
            </a>
            <a href="#" className="text-gray-600 hover:text-blue-400">
              <i className="fab fa-twitter"></i>
            </a>
            <a href="#" className="text-gray-600 hover:text-pink-500">
              <i className="fab fa-instagram"></i>
            </a>
            <a href="#" className="text-gray-600 hover:text-red-500">
              <i className="fab fa-pinterest"></i>
            </a>
          </div>
        </div>
      </div>

      <footer className="bg-gray-900 text-white py-10">
        <div className="max-w-7xl mx-auto px-4 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
          <div>
            <h3 className="text-xl font-semibold text-teal-400">About Us</h3>
            <p className="mt-2 text-sm">
              Lorem ipsum dolor sit amet, consectetur adipisicing elit.
            </p>
            <ul className="mt-2 text-sm space-y-1">
              <li>
                <i className="fa fa-map-marker"></i> 1734 Stonecoal Road
              </li>
              <li>
                <i className="fa fa-phone"></i> +021-95-51-84
              </li>
              <li>
                <i className="fa fa-envelope"></i> email@email.com
              </li>
            </ul>
          </div>

          <div>
            <h3 className="text-xl font-semibold text-teal-400">Categories</h3>
            <ul className="mt-2 text-sm space-y-1">
              <li>
                <a href="#">Hot deals</a>
              </li>
              <li>
                <a href="#">Laptops</a>
              </li>
              <li>
                <a href="#">Smartphones</a>
              </li>
              <li>
                <a href="#">Cameras</a>
              </li>
              <li>
                <a href="#">Accessories</a>
              </li>
            </ul>
          </div>

          <div>
            <h3 className="text-xl font-semibold text-teal-400">Information</h3>
            <ul className="mt-2 text-sm space-y-1">
              <li>
                <a href="#">About Us</a>
              </li>
              <li>
                <a href="#">Contact Us</a>
              </li>
              <li>
                <a href="#">Privacy Policy</a>
              </li>
              <li>
                <a href="#">Orders and Returns</a>
              </li>
              <li>
                <a href="#">Terms & Conditions</a>
              </li>
            </ul>
          </div>

          <div>
            <h3 className="text-xl font-semibold text-teal-400">Service</h3>
            <ul className="mt-2 text-sm space-y-1">
              <li>
                <a href="#">My Account</a>
              </li>
              <li>
                <a href="#">View Cart</a>
              </li>
              <li>
                <a href="#">Wishlist</a>
              </li>
              <li>
                <a href="#">Track My Order</a>
              </li>
              <li>
                <a href="#">Help</a>
              </li>
            </ul>
          </div>
        </div>

        <div className="text-center mt-10 border-t border-gray-700 pt-4">
          <p className="text-sm">
            Copyright &copy; {new Date().getFullYear()} All rights reserved |
            Made with <i className="fa fa-heart text-red-500"></i> by Youssef
            Essam
          </p>
        </div>
      </footer>
    </>
  );
}

export default Footer;
