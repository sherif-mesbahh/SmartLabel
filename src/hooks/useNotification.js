import { useState, useEffect, useCallback } from "react";
import { notificationService } from "../services/notificationService";
import { useNavigate } from "react-router-dom";

export const useNotification = () => {
  const [notifications, setNotifications] = useState([]);
  const [unreadCount, setUnreadCount] = useState(0);
  const [isOpen, setIsOpen] = useState(false);
  const navigate = useNavigate();

  // Get viewed notifications from localStorage
  const getViewedNotifications = useCallback(() => {
    try {
      const viewed = localStorage.getItem("viewedNotifications");
      return viewed ? JSON.parse(viewed) : [];
    } catch (error) {
      console.error("Error reading from localStorage:", error);
      return [];
    }
  }, []);

  // Save viewed notification to localStorage
  const saveViewedNotification = useCallback(
    (notificationId) => {
      try {
        const viewed = getViewedNotifications();
        if (!viewed.includes(notificationId)) {
          viewed.push(notificationId);
          localStorage.setItem("viewedNotifications", JSON.stringify(viewed));
        }
      } catch (error) {
        console.error("Error saving to localStorage:", error);
      }
    },
    [getViewedNotifications]
  );

  // Check if notification has been viewed
  const isNotificationViewed = useCallback(
    (notificationId) => {
      const viewed = getViewedNotifications();
      return viewed.includes(notificationId);
    },
    [getViewedNotifications]
  );

  // Fetch notifications
  const fetchNotifications = useCallback(async () => {
    try {
      const fetchedNotifications =
        await notificationService.fetchNotifications();
      const viewedNotifications = getViewedNotifications();

      // Filter out viewed notifications
      const unviewedNotifications = fetchedNotifications.filter(
        (notification) => !viewedNotifications.includes(notification.id)
      );

      setNotifications(unviewedNotifications);
      setUnreadCount(unviewedNotifications.length);
    } catch (error) {
      console.error("Error fetching notifications:", error);
    }
  }, [getViewedNotifications]);

  // Handle new notification
  const handleNewNotification = useCallback(
    (event) => {
      const newNotification = event.detail;

      // Only show if not viewed before
      if (!isNotificationViewed(newNotification.id)) {
        // Add new notification at the beginning of the array
        setNotifications((prev) => {
          const updatedNotifications = [newNotification, ...prev];
          // Sort by timestamp to ensure newest first
          return updatedNotifications.sort((a, b) => 
            (b.timestamp || new Date(b.createdAt).getTime()) - 
            (a.timestamp || new Date(a.createdAt).getTime())
          );
        });
        setUnreadCount((prev) => prev + 1);
      }
    },
    [isNotificationViewed]
  );

  // Toggle dropdown
  const toggleDropdown = useCallback(() => {
    setIsOpen((prev) => !prev);
  }, []);

  // Handle notification click and navigation
  const handleNotificationClick = useCallback(
    async (notification) => {
      try {
        // Mark notification as read on the server
        await notificationService.markNotificationAsRead(notification.id);

        // Save to viewed notifications immediately
        saveViewedNotification(notification.id);

        setNotifications((prev) =>
          prev.filter((n) => n.id !== notification.id)
        );
        setUnreadCount((prev) => Math.max(0, prev - 1));

        // Fetch notification details
        const notificationDetails =
          await notificationService.fetchNotificationDetails(notification.id);

        if (notificationDetails) {
          // Navigate based on notification type
          switch (notificationDetails.type) {
            case 1: // Product
              navigate(`/product/${notificationDetails.typeId}`);
              break;
            case 2: // Banner
              navigate(`/banner/${notificationDetails.typeId}`);
              break;
            default:
              console.warn(
                "Unknown notification type:",
                notificationDetails.type
              );
          }
        }
      } catch (error) {
        console.error("Error handling notification click:", error);
      }
    },
    [saveViewedNotification, navigate]
  );

  // Initialize notifications
  useEffect(() => {
    fetchNotifications();

    // Listen for new notifications
    window.addEventListener("newNotification", handleNewNotification);
    return () =>
      window.removeEventListener("newNotification", handleNewNotification);
  }, [fetchNotifications, handleNewNotification]);

  return {
    notifications,
    unreadCount,
    isOpen,
    toggleDropdown,
    handleNotificationClick,
  };
};
