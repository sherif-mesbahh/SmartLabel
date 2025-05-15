import * as signalR from "@microsoft/signalr";
import Toastify from "toastify-js";
import "toastify-js/src/toastify.css";

const API_URL = "https://smartlabel1.runasp.net";

class NotificationService {
  constructor() {
    this.connection = new signalR.HubConnectionBuilder()
      .withUrl(`${API_URL}/Notify`, {
        accessTokenFactory: () => this.getToken(),
        withCredentials: true,
        skipNegotiation: true,
        transport: signalR.HttpTransportType.WebSockets
      })
      .withAutomaticReconnect()
      .configureLogging(signalR.LogLevel.Debug)
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
      if (err.message) {
        console.error("Error message:", err.message);
      }
      if (err.stack) {
        console.error("Error stack:", err.stack);
      }
      setTimeout(() => this.startConnection(), 5000);
    }
  }

  getToken() {
    const user = localStorage.getItem("user");
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
        if (notificationId) {
          window.open(
            `${API_URL}/api/Notifications/${notificationId}`,
            "_blank"
          );
        } else {
          window.open(`${API_URL}/api/Notifications/me`, "_blank");
        }
      },
    }).showToast();
  }
}

export const notificationService = new NotificationService();
