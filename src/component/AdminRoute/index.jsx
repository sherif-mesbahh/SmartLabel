import React, { useEffect, useState } from "react";
import { useAuth } from "../../hooks/useAuth.jsx";
import NotFound from "../NotFound/index.jsx";
import { UserInfo } from "../../services/userServices.js";
function AdminRoute({ children }) {
  const { userInfo } = useAuth();

  return userInfo.data.roles[0] == "Admin" ? (
    <div>{children}</div>
  ) : (
    <NotFound message={"this page is only for Admins"} />
  );
}

function AdminRouteExport({ children }) {
  return <AdminRoute>{children}</AdminRoute>;
}
export default AdminRouteExport;
