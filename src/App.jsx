import { useEffect, useState } from "react";
import Header from "./component/Header";
import AppRoute from "./AppRoute";
import Loading from "./component/Loading";
import SetLoadingInterceptors from "./interceptors/Loadinginterceptors";
import { useLoading } from "./hooks/useLoading";
import Footer from "./component/Footer";
import ScrollToTop from "./component/ScrollToTop";
import { ThemeProvider } from "./context/ThemeContext";
import "swiper/css";
import "swiper/css/pagination";

// import "./../node_modules/bootstrap/dist/css/bootstrap.min.css";
function App() {
  const { hideLoading, showLoading } = useLoading();
  useEffect(() => {
    SetLoadingInterceptors({ hideLoading, showLoading });
  }, []);
  return (
    <ThemeProvider>
      <div className="min-h-screen bg-white dark:bg-gray-900 transition-colors duration-200">
        <ScrollToTop />
        <Loading />
        <Header />
        <div className="pt-20">
          <AppRoute />
        </div>
        <Footer />
      </div>
    </ThemeProvider>
  );
}

export default App;
