import React, { useEffect, useState } from "react";

import { useAuth } from "../../hooks/useAuth";
import NotFound from "../../component/NotFound";

function ProfilePage() {
  const { updateProfile, changePassword, userInfo } = useAuth();
  const [firstName, setFirstName] = useState("");
  const [lastName, setLastName] = useState("");
  const [email, setEmail] = useState("");
  const [currentPassword, setCurrentPassword] = useState("");
  const [newPassword, setNewPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");

  useEffect(() => {
    setEmail(userInfo?.data.email);
    setFirstName(userInfo?.data.firstName);
    setLastName(userInfo?.data.lastName);
  }, []);

  const handleProfileUpdate = async (e) => {
    e.preventDefault();
    await updateProfile({ firstName, lastName, email });
  };

  const handlePasswordChange = async (e) => {
    e.preventDefault();
    await changePassword({ currentPassword, newPassword, confirmPassword });
  };
  if (!userInfo) {
    return <NotFound message={"Please Login First ☺️"} />;
  }

  return (
    <div className="max-w-xl mx-auto mt-10">
      <div className="bg-white shadow-lg rounded-lg p-6 mb-6">
        <h1 className="text-2xl font-semibold mb-4 text-gray-700">
          Update Profile
        </h1>

        <form onSubmit={handleProfileUpdate} className="space-y-4">
          <input
            type="text"
            placeholder="First Name"
            value={firstName}
            onChange={(e) => setFirstName(e.target.value)}
            className="w-full p-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500"
          />
          <input
            type="text"
            placeholder="Last Name"
            value={lastName}
            onChange={(e) => setLastName(e.target.value)}
            className="w-full p-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500"
          />
          <input
            type="email"
            placeholder="Email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            className="w-full p-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500"
          />
          <button
            type="submit"
            className="mx-52 bg-teal-500 text-white py-2 px-4 rounded-md hover:bg-teal-600 transition duration-300"
          >
            Update
          </button>
        </form>
      </div>

      {/* Change Password Section */}
      <div className="bg-white shadow-lg rounded-lg p-6">
        <h1 className="text-2xl font-semibold mb-4 text-gray-700">
          Change Password
        </h1>
        <form onSubmit={handlePasswordChange} className="space-y-4">
          <input
            type="password"
            placeholder="Current Password"
            value={currentPassword}
            onChange={(e) => setCurrentPassword(e.target.value)}
            className="w-full p-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500"
          />
          <input
            type="password"
            placeholder="New Password"
            value={newPassword}
            onChange={(e) => setNewPassword(e.target.value)}
            className="w-full p-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500"
          />
          <input
            type="password"
            placeholder="Confirm Password"
            value={confirmPassword}
            onChange={(e) => setConfirmPassword(e.target.value)}
            className="w-full p-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500"
          />
          <button
            type="submit"
            className="mx-52 bg-red-500 text-white py-2 px-4 rounded-md hover:bg-red-600 transition duration-300"
          >
            Change
          </button>
        </form>
      </div>
    </div>
  );
}

export default ProfilePage;
