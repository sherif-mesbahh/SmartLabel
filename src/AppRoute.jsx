import React from "react";
import { Route, Routes } from "react-router-dom";
import Homepage from "./pages/Home/Homepage";
import FoodPage from "./pages/Food/FoodPage";
import CartPage from "./pages/Cart/CartPage";
import Loginpage from "./pages/login/Loginpage";
import RegisterPage from "./pages/Register/RegisterPage";

import ProfilePage from "./pages/Profile/ProfilePage";
import Dashboard from "./pages/Dashboard/Dashboard";
import AdminRouteExport from "./component/AdminRoute";
import FoodsAdminPage from "./pages/FoodsAdmin/FoodsAdminPage";
import FoodEditPage from "./pages/FoodEdit/FoodEditPage";

import CategoriesAdminPage from "./pages/CategoriesAdmin/CategoriesAdminPage";
import CategoryEditPage from "./pages/CategoriesEdit/CategoryEditPage";
import Tags from "./pages/tags/tags";
import BannerPage from "./pages/Banner/BannerPage";
import AllProductPage from "./pages/allProduct/AllProductPage";
import BannerAdminPage from "./pages/BannerAdmin/BannerAdminPage";
import BannerEditPage from "./pages/BannerEditPage/BannerEditPage";
import UsersAdminPage from "./pages/UsersAdminPage/UsersAdminPage";

function AppRoute() {
  return (
    <Routes>
      <Route path="/" element={<Homepage />} />
      <Route path="/Search/:searchTerm" element={<Homepage />} />

      <Route path="/category/:id?" element={<Tags />} />
      <Route path="/product/:id" element={<FoodPage />} />
      <Route path="/fav" element={<CartPage />} />
      <Route path="/login" element={<Loginpage />} />
      <Route path="/register" element={<RegisterPage />} />
      <Route path="/banner/:id" element={<BannerPage />} />
      <Route path="/allproducts" element={<AllProductPage />} />

      <Route path="/profile" element={<ProfilePage />} />

      <Route path="/dashboard" element={<Dashboard />} />
      <Route
        path="/admin/products/:searchTerm?"
        element={
          <AdminRouteExport>
            <FoodsAdminPage />
          </AdminRouteExport>
        }
      />
      <Route
        path="/admin/categories/:searchTerm?"
        element={
          <AdminRouteExport>
            <CategoriesAdminPage />
          </AdminRouteExport>
        }
      />
      <Route
        path="/admin/banners/:searchTerm?"
        element={
          <AdminRouteExport>
            <BannerAdminPage />
          </AdminRouteExport>
        }
      />
      <Route
        path="/admin/addfood/:categoryId"
        element={
          <AdminRouteExport>
            <FoodEditPage />
          </AdminRouteExport>
        }
      />
      <Route
        path="/admin/editfood/:foodId"
        element={
          <AdminRouteExport>
            <FoodEditPage />
          </AdminRouteExport>
        }
      />
      <Route
        path="/admin/addcategory"
        element={
          <AdminRouteExport>
            <CategoryEditPage />
          </AdminRouteExport>
        }
      />
      <Route
        path="/admin/editcategory/:foodId"
        element={
          <AdminRouteExport>
            <CategoryEditPage />
          </AdminRouteExport>
        }
      />
      <Route
        path="/admin/addbanner"
        element={
          <AdminRouteExport>
            <BannerEditPage />
          </AdminRouteExport>
        }
      />
      <Route
        path="/admin/editbanner/:bannerId"
        element={
          <AdminRouteExport>
            <BannerEditPage />
          </AdminRouteExport>
        }
      />
      <Route
        path="/admin/dashboard"
        element={
          <AdminRouteExport>
            <UsersAdminPage />
          </AdminRouteExport>
        }
      />
    </Routes>
  );
}

export default AppRoute;
