import { useEffect, useState } from "react";
import Header from "./component/Header";
import AppRoute from "./AppRoute";
import Loading from "./component/Loading";
import SetLoadingInterceptors from "./interceptors/Loadinginterceptors";
import { useLoading } from "./hooks/useLoading";
import Footer from "./component/Footer";
import "swiper/css";
import "swiper/css/pagination";

// import "./../node_modules/bootstrap/dist/css/bootstrap.min.css";
function App() {
  const { hideLoading, showLoading } = useLoading();
  useEffect(() => {
    SetLoadingInterceptors({ hideLoading, showLoading });
  }, []);
  return (
    <>
      <Loading />
      <Header />

      <AppRoute />
      <Footer />
    </>
  );
}

export default App;
