import * as signalR from "@microsoft/signalr";
import Toastify from "toastify-js";
import "toastify-js/src/toastify.css";

const API_URL = "https://smartlabel1.runasp.net";

class NotificationService {
    constructor() {
        console.log("Initializing NotificationService...");
        this.connection = new signalR.HubConnectionBuilder()
            .withUrl(`${API_URL}/Notify`, {
                accessTokenFactory: () => this.getToken(),
                withCredentials: true,
                skipNegotiation: true,
                transport: signalR.HttpTransportType.WebSockets
            })
            .withAutomaticReconnect([0, 2000, 5000, 10000, 20000])
            .configureLogging(signalR.LogLevel.Debug)
            .build();

        // Listen for notifications
        this.connection.on("ReceiveNotification", (message, notificationId) => {
            console.log("SignalR received notification:", { message, notificationId });
            this.handleNotification(message, notificationId);
        });

        // Connection state handlers
        this.connection.onreconnecting((error) => {
            console.log("SignalR reconnecting:", error);
        });

        this.connection.onreconnected((connectionId) => {
            console.log("SignalR reconnected:", connectionId);
        });

        this.connection.onclose((error) => {
            console.log("SignalR connection closed:", error);
        });

        this.startConnection();
    }

    async startConnection() {
        try {
            console.log("Attempting to start SignalR connection...");
            const token = this.getToken();
            if (!token) {
                console.error("No authentication token available");
                return;
            }

            this.connection.headers = {
                'Authorization': `Bearer ${token}`
            };

            await this.connection.start();
            console.log("SignalR Connected Successfully");
        } catch (err) {
            console.error("SignalR Connection Error:", err);
            if (this.connection.state !== signalR.HubConnectionState.Reconnecting) {
                console.log("Retrying connection in 5 seconds...");
                setTimeout(() => this.startConnection(), 5000);
            }
        }
    }

    getToken() {
        try {
            const user = localStorage.getItem("user");
            if (user) {
                const parsedUser = JSON.parse(user);
                const token = parsedUser.data.accessToken;
                if (!token) {
                    console.error("No access token found in user data");
                    return null;
                }
                return token;
            }
            return null;
        } catch (error) {
            console.error("Error getting token:", error);
            return null;
        }
    }

    handleNotification(message, notificationId) {
        console.log("Processing notification:", {
            message,
            notificationId,
            timestamp: new Date().toISOString(),
            connectionState: this.connection.state
        });

        // Show toast notification
        this.showToastNotification(message, notificationId);

        // Emit event for NotificationProvider with current timestamp
        const event = new CustomEvent('newNotification', {
            detail: {
                id: notificationId,
                message,
                createdAt: new Date().toISOString(),
                read: false,
                timestamp: Date.now() // Add timestamp for sorting
            }
        });
        window.dispatchEvent(event);
    }

    showToastNotification(message, notificationId) {
        const toast = Toastify({
            text: message,
            duration: 5000,
            close: true,
            gravity: "top",
            position: "right",
            backgroundColor: "linear-gradient(to right, #4b6cb7, #182848)",
            onClick: () => {
                if (notificationId) {
                  this.fetchNotificationDetails(notificationId);
                }
            },
        }).showToast();
    }

    async fetchNotifications() {
        try {
            const response = await fetch(`${API_URL}/api/Notifications/me`, {
                headers: {
                    'Authorization': `Bearer ${this.getToken()}`
                }
            });
            const data = await response.json();
            if (data.success) {
                // Sort notifications by date in descending order (newest first)
                return data.data
                    .map(notification => ({
                        ...notification,
                        read: false
                    }))
                    .sort((a, b) => new Date(b.createdAt) - new Date(a.createdAt));
            }
            return [];
        } catch (error) {
            console.error('Error fetching notifications:', error);
            return [];
        }
    }

    async fetchNotificationDetails(notificationId) {
        try {
            const response = await fetch(`${API_URL}/api/Notifications/${notificationId}`, {
                headers: {
                    'Authorization': `Bearer ${this.getToken()}`
                }
            });
            const data = await response.json();
            if (data.success) {
                return data.data;
            }
            return null;
        } catch (error) {
            console.error('Error fetching notification details:', error);
            return null;
        }
    }

    async markNotificationAsRead(notificationId) {
        try {
            const response = await fetch(`${API_URL}/api/Notifications/${notificationId}`, {
                method: 'PUT',
                headers: {
                    'Authorization': `Bearer ${this.getToken()}`,
                    'Content-Type': 'application/json'
                }
            });
            const data = await response.json();
            return data.success;
        } catch (error) {
            console.error('Error marking notification as read:', error);
            return false;
        }
    }
}

export const notificationService = new NotificationService();