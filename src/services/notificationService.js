import * as signalR from "@microsoft/signalr";
import Toastify from 'toastify-js';
import "toastify-js/src/toastify.css";

const API_URL = "http://smartlabel1.runasp.net";

class NotificationService {
    constructor() {
        this.connection = new signalR.HubConnectionBuilder()
        .withUrl(`${API_URL}/Notify`, {
            accessTokenFactory: () => this.getToken(),
            skipNegotiation: true,
            transport: signalR.HttpTransportType.WebSockets,
            withCredentials: true
        })
            .configureLogging(signalR.LogLevel.None)
            .build();

        this.connection.on("ReceiveNotification", (message, notificationId) => {
            this.handleNotification(message, notificationId);
        });

        this.startConnection();
    }

    async startConnection() {
        try {
            await this.connection.start();
        } catch (err) {
            setTimeout(() => this.startConnection(), 5000);
        }
    }

    getToken() {
        const user = localStorage.getItem('user');
        if (user) {
            const parsedUser = JSON.parse(user);
            return parsedUser.data.accessToken;
        }
        return null;
    }

    handleNotification(message, notificationId) {
        this.showToastNotification(message, notificationId);
    }

    showToastNotification(message, notificationId) {
        const toast = Toastify({
            text: message,
            duration: 5000,
            close: true,
            gravity: "top",
            position: "right",
            backgroundColor: "linear-gradient(to right, #00b09b, #96c93d)",
            onClick: () => {
                // Handle notification click
                if (notificationId) {
                    // Navigate to specific notification
                    window.open(`${API_URL}/api/Notifications/${notificationId}`, '_blank');
                } else {
                    // Navigate to notifications list
                    window.open(`${API_URL}/api/Notifications/me`, '_blank');
                }
            }
        }).showToast();
    }
}

export const notificationService = new NotificationService(); 