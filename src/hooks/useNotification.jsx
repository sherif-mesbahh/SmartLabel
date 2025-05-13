import React, { createContext, useContext, useState, useEffect } from "react";
import { notificationService } from "../services/notificationService";

const NotificationContext = createContext();

export function NotificationProvider({ children }) {
  const [notifications, setNotifications] = useState([]);
  const [unreadCount, setUnreadCount] = useState(0);

  useEffect(() => {
    // Listen for new notifications
    notificationService.connection.on(
      "ReceiveNotification",
      (message, type) => {
        setNotifications((prev) => [
          ...prev,
          {
            id: Date.now(),
            message,
            type,
            read: false,
          },
        ]);
        setUnreadCount((prev) => prev + 1);
      }
    );

    return () => {
      notificationService.connection.off("ReceiveNotification");
    };
  }, []);

  const markAsRead = () => {
    setNotifications((prev) => prev.map((notif) => ({ ...notif, read: true })));
    setUnreadCount(0);
  };

  const clearNotifications = () => {
    setNotifications([]);
    setUnreadCount(0);
  };

  return (
    <NotificationContext.Provider
      value={{
        notifications,
        unreadCount,
        markAsRead,
        clearNotifications,
      }}
    >
      {children}
    </NotificationContext.Provider>
  );
}

export const useNotification = () => useContext(NotificationContext);
