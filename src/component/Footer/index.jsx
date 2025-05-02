import React from "react";
import { Link } from "react-router-dom";

function Footer() {
  return (
    <footer className="bg-white py-12">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="lg:text-center">
          <h2 className="text-3xl font-extrabold tracking-tight text-gray-900 sm:text-4xl">
            About SmartLabel Solutions
          </h2>
          <p className="mt-4 max-w-2xl text-xl text-gray-500 lg:mx-auto">
            Revolutionizing product identification with intelligent labeling
            technology
          </p>
        </div>

        <div className="mt-10">
          <div className="bg-[#f9fafb] rounded-xl p-8 shadow-sm">
            <div className="grid md:grid-cols-2 gap-8">
              <div>
                <h3 className="text-lg font-medium text-gray-900">Our Story</h3>
                <p className="mt-4 text-gray-600">
                  Founded in 2023, SmartLabel Solutions emerged from a simple
                  idea: product labeling should be smarter, more dynamic, and
                  seamlessly integrated with the digital world. Our team of
                  engineers and designers came together to create electronic
                  labels that bridge the physical and digital retail spaces.
                </p>
              </div>
              <div>
                <h3 className="text-lg font-medium text-gray-900">
                  Our Technology
                </h3>
                <p className="mt-4 text-gray-600">
                  Our proprietary e-ink smartLabel technology combines ultra-low
                  power consumption with real-time update capabilities. Whether
                  it's pricing, promotions, or product information, our labels
                  ensure your shelves are always accurate and engaging.
                </p>
              </div>
            </div>

            <div className="mt-8 pt-8 border-t border-gray-200">
              <h3 className="text-lg font-medium text-gray-900">
                Why Choose Us
              </h3>
              <div className="mt-6 grid grid-cols-1 gap-6 sm:grid-cols-3">
                <div className="p-4 bg-white rounded-lg shadow-xs">
                  <div className="text-[#2563eb] font-semibold">Innovation</div>
                  <p className="mt-2 text-gray-600 text-sm">
                    Pioneering the next generation of retail technology with
                    cutting-edge solutions.
                  </p>
                </div>
                <div className="p-4 bg-white rounded-lg shadow-xs">
                  <div className="text-[#2563eb] font-semibold">
                    Reliability
                  </div>
                  <p className="mt-2 text-gray-600 text-sm">
                    Labels that work when you need them, with 99.9% uptime
                    guarantee.
                  </p>
                </div>
                <div className="p-4 bg-white rounded-lg shadow-xs">
                  <div className="text-[#2563eb] font-semibold">
                    Sustainability
                  </div>
                  <p className="mt-2 text-gray-600 text-sm">
                    Reducing paper waste with reusable digital solutions.
                  </p>
                </div>
              </div>
            </div>
          </div>

          <div className="mt-10 text-center">
            <Link
              to="tel:01093518092"
              className="inline-flex items-center px-6 py-3 border border-transparent text-base font-medium rounded-md shadow-sm text-white bg-[#2563eb] hover:bg-[#1e40af] transition-colors"
            >
              Call Us: 010-9351-8092
            </Link>
            <p className="mt-4 text-sm text-gray-500">
              Ready to transform your retail experience? Get in touch today.
            </p>
          </div>
        </div>
      </div>

      <div className="mt-12 border-t border-gray-200 pt-8">
        <p className="text-base text-gray-400 text-center">
          &copy; {new Date().getFullYear()} SmartLabel Solutions. All rights
          reserved.
        </p>
      </div>
    </footer>
  );
}

export default Footer;
