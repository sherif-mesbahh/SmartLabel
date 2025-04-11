import React from "react";
import { useAuth } from "../../hooks/useAuth";
import { useLocation, Navigate } from "react-router-dom";

function AuthRoute({ children }) {
  const { user } = useAuth();
  const location = useLocation();

  return user ? (
    children
  ) : (
    <Navigate to={`/login?redirect_to=${location.pathname}`} replace />
  );
}

export default AuthRoute;
