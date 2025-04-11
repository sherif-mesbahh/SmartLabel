import React, { useState, useEffect } from "react";
import { Link, useParams } from "react-router-dom";
import { trackOrderId } from "../../services/orderServices";
import OrderItemList from "../../component/OrderItemList";
import Map from "../../component/Map";
import DateTime from "../../component/DateTime";
function OrderTrackPage() {
  const { orderId } = useParams();
  const [order, setOrder] = useState();
  useEffect(() => {
    orderId && trackOrderId(orderId).then((data) => setOrder(data));
  }, []);

  return (
    order && (
      <div className="min-h-screen bg-gray-50">
        <div className="flex justify-between p-6">
          {/* Left Section (Order Details) */}
          <div className="w-1/2 p-4 bg-white shadow rounded-lg">
            <h2 className="text-2xl font-bold mb-4">Order #{order._id}</h2>
            <div className="space-y-2">
              <p>
                <strong>Date:</strong> <DateTime order={order} />
              </p>
              <p>
                <strong>Name:</strong> {order.name}
              </p>
              <p>
                <strong>Address:</strong> {order.address}
              </p>
              <p>
                <strong>State:</strong> {order.status}
              </p>
              <p>
                <strong>Payment ID:</strong> {order.paymentId}
              </p>
            </div>

            {/* Order Items */}
            <div className="mt-6">
              <h3 className="text-lg font-bold">Order Items:</h3>
              <div className="flex justify-between items-center border p-2 rounded-md mt-2">
                <OrderItemList order={order} />
              </div>
            </div>
          </div>

          {/* Right Section (Map Replacement) */}
          <div className="w-1/2 p-4 bg-white shadow rounded-lg flex items-center justify-center">
            <Map readonly={true} location={order.addressLatLng} />
          </div>
        </div>

        {/* Footer */}

        {order.status === "new" && (
          <footer className="p-6 w-full  bg-red-500 text-white text-center py-3 rounded-lg hover:bg-red-600 ">
            <Link to={"/payment"}>Go To Payment</Link>{" "}
          </footer>
        )}
      </div>
    )
  );
}

export default OrderTrackPage;
