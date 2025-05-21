import React from 'react';
import { useNotification } from '../../hooks/useNotification';

function NotificationBell() {
    const {
        notifications,
        unreadCount,
        isOpen,
        toggleDropdown,
        handleNotificationClick
    } = useNotification();

    return (
        <div className="relative">
            <button
                onClick={toggleDropdown}
                className="relative p-2 transition-all duration-200 hover:text-yellow-300 hover:bg-white/10 rounded-full hover:scale-105 focus:outline-none"
            >
                <svg
                    xmlns="http://www.w3.org/2000/svg"
                    className="h-6 w-6"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                >
                    <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        strokeWidth="2"
                        d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"
                    />
                </svg>
                {unreadCount > 0 && (
                    <span className="absolute scale-[80%] top-0 right-0 inline-flex items-center justify-center px-2 py-1 text-xs font-bold leading-none text-white transform translate-x-1/2 translate-y-[20%] bg-red-500 rounded-full">
                        {unreadCount}
                    </span>
                )}
            </button>

            {isOpen && (
                <div className="absolute w-60 right-[-75px] xs:-right-6 mt-2 xs:w-80 bg-white rounded-lg shadow-xl z-50">
                    <div className="p-4 border-b">
                        <h3 className="text-lg font-semibold text-gray-900">Notifications</h3>
                    </div>
                    <div className="max-h-96 overflow-y-auto">
                        {notifications.length === 0 ? (
                            <div className="p-4 text-center text-gray-500">
                                No notifications
                            </div>
                        ) : (
                            notifications.map((notification) => (
                                <div
                                    key={notification.id}
                                    onClick={() => handleNotificationClick(notification)}
                                    className="p-4 border-b hover:bg-gray-50 cursor-pointer transition-colors duration-200"
                                >
                                    <div className="flex items-start gap-3">
                                        {notification.image && (
                                            <div className="flex-shrink-0 w-12 h-12 rounded-lg overflow-hidden">
                                                <img 
                                                    src={`http://smartlabel1.runasp.net/Uploads/${notification.image}`}
                                                    alt="Notification" 
                                                    className="w-full h-full object-cover"
                                                />
                                            </div>
                                        )}
                                        <div className="flex-1 min-w-0">
                                            <p className="text-sm font-medium text-gray-900 mb-1">
                                                {notification.message}
                                            </p>
                                            <p className="text-xs text-gray-500">
                                                {new Date(notification.createdAt).toLocaleString()}
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            ))
                        )}
                    </div>
                </div>
            )}
        </div>
    );
}

export default NotificationBell; 