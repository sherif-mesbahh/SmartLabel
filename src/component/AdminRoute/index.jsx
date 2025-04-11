import React from "react";
import { useAuth } from "../../hooks/useAuth.jsx";
import NotFound from "../NotFound/index.jsx";
import AuthRoute from "../AuthRoute/index.jsx";
function AdminRoute({ children }) {
  const { user } = useAuth();
  return user ? (
    <div>{children}</div>
  ) : (
    <NotFound message={"this page is only for Admins"} />
  );
}

function AdminRouteExport({ children }) {
  return (
    <AuthRoute>
      <AdminRoute>{children}</AdminRoute>
    </AuthRoute>
  );
}
export default AdminRouteExport;
