import React from 'react';
import { Navigate } from 'react-router-dom';

const AdminRoute = ({ children }) => {
    const userInfo = JSON.parse(localStorage.getItem('userInfo'));

    // Check if userInfo exists and has admin role
    if (!userInfo || !userInfo.data || userInfo.data.roles[0] !== 'Admin') {
        return <Navigate to="/login" replace />;
    }

    return children;
};

export default AdminRoute;

