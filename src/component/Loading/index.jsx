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
  
  useEffect(()=>{
    if(isLoading && showLoading){
      document.body.style.overflowY = "hidden";
    }

    else{
      document.body.style.overflowY = "auto";
    }

    return ()=>{
      document.body.style.overflowY = "auto";
    }
  },[isLoading,showLoading])

  if (!isLoading || !showLoading) return ;

  return (
    <div className="sm:min-h-screen min-h-[100dvh] fixed inset-0 z-[9999] flex items-center justify-center bg-gradient-to-br from-blue-50 via-white to-purple-50 dark:from-gray-900 dark:via-gray-800 dark:to-gray-900">
      <div className="flex flex-col justify-center items-center ">
        <div className="w-20 h-20 border-4 border-blue-600 border-t-transparent rounded-full animate-spin m-auto"></div>
        <p className=" text-lg  font-medium text-gray-600 dark:text-gray-300 select-none">
          Loading...
        </p>
      </div>
    </div>
  );
}

export default Loading;
