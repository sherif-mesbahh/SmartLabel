import { StrictMode } from "react";
import { createRoot } from "react-dom/client";

import App from "./App.jsx";
import "./index.css";
import "@fortawesome/fontawesome-free/css/all.min.css";

import { BrowserRouter } from "react-router-dom";
import CartProvider from "./hooks/useCart.jsx";
import "./axiosconfig.js";
import AuthProvider from "./hooks/useAuth.jsx";
import { ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import { LoadingProvider } from "./hooks/useLoading.jsx";
import "./interceptors/authinterceptors";
import { ThemeProvider } from "./context/ThemeContext";
import FavoritesProvider from "./hooks/useFavorites.jsx";

createRoot(document.getElementById("root")).render(
  <StrictMode>
    <BrowserRouter>
      <ThemeProvider>
        <CartProvider>
          <FavoritesProvider>
            <LoadingProvider>
              <AuthProvider>
                <App />
                <ToastContainer
                  position="bottom-right"
                  autoClose={5000}
                  hideProgressBar={false}
                  newestOnTop={false}
                  closeOnClick
                  rtl={false}
                  pauseOnFocusLoss
                  draggable
                  pauseOnHover
                  theme="light"
                />
              </AuthProvider>
            </LoadingProvider>
          </FavoritesProvider>
        </CartProvider>
      </ThemeProvider>
    </BrowserRouter>
  </StrictMode>
);
