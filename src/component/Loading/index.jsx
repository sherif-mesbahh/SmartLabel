import React, { useState, useEffect } from "react";
import { useLoading } from "../../hooks/useLoading";

function Loading() {
  const { isLoading } = useLoading();
  const [showLoading, setShowLoading] = useState(false);

  useEffect(() => {
    const timeout = setTimeout(() => {
      setShowLoading(true);
    }, 2000);

    return () => clearTimeout(timeout);
  }, []);

  if (!isLoading || !showLoading) return;

  return (
    <div className="fixed w-full h-full bg-white z-50 flex items-center justify-center">
      <div className="flex flex-col items-center">
        <div className="flex justify-center items-center h-screen">
          <div className="animate-spin rounded-full h-16 w-16 border-t-4 border-b-4 border-orange-500"></div>
        </div>
        <p className="text-lg font-medium mt-2">Loading...</p>
      </div>
    </div>
  );
}

export default Loading;
