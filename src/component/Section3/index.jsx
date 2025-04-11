import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";

function Section3() {
  const [timeLeft, setTimeLeft] = useState({
    days: 2,
    hours: 10,
    mins: 34,
    secs: 60,
  });

  useEffect(() => {
    const timer = setInterval(() => {
      setTimeLeft((prevTime) => {
        let { days, hours, mins, secs } = prevTime;

        if (secs > 0) {
          secs -= 1;
        } else {
          secs = 59;
          if (mins > 0) {
            mins -= 1;
          } else {
            mins = 59;
            if (hours > 0) {
              hours -= 1;
            } else {
              hours = 23;
              if (days > 0) {
                days -= 1;
              } else {
                clearInterval(timer);
              }
            }
          }
        }
        return { days, hours, mins, secs };
      });
    }, 1000);

    return () => clearInterval(timer);
  }, []);

  return (
    <div className="section my-12 flex justify-center items-center mx-auto">
      <div className="container text-center p-6 bg-gray-100 rounded-lg shadow-lg">
        <div className="hot-deal">
          <ul className="flex justify-center space-x-6 mb-4">
            {Object.entries(timeLeft).map(([key, value]) => (
              <li key={key} className="text-center">
                <div className="bg-white p-4 rounded-lg shadow-md">
                  <h3 className="text-2xl font-bold">
                    {String(value).padStart(2, "0")}
                  </h3>
                  <span className="text-sm text-gray-500 uppercase">{key}</span>
                </div>
              </li>
            ))}
          </ul>
          <h2 className="text-3xl font-bold uppercase mb-2">
            Hot Deal This Week
          </h2>
          <p className="text-lg mb-4">New Collection Up to 50% OFF</p>
          <Link
            to="/allproduct"
            className="bg-red-500 text-white py-2 px-6 rounded-lg text-lg hover:bg-red-600 transition"
          >
            Shop Now
          </Link>
        </div>
      </div>
    </div>
  );
}

export default Section3;
