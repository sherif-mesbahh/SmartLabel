import React, { useState } from "react";
import { useAuth } from "../../hooks/useAuth";
import { toast } from "react-toastify";

function ProfilePage() {
  const { user, updateProfile, changePassword } = useAuth();
  const [name, setName] = useState(user.name);

  const [address, setAddress] = useState(user.address);
  const [currentpassword, setCurrentPassword] = useState("");
  const [newpassword, setnewPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await updateProfile({ name: name, address: address });
    } catch (error) {
      console.error("Error updating profile:", error);
    }

    // Update user name and address in database

    // Update user profile
  };
  const handlePasswordSubmit = async (e) => {
    e.preventDefault();
    let valid = true;
    if (newpassword.length < 6) {
      toast.error("new password must be at least 6 characters long");
      valid = false;
    }
    if (newpassword !== confirmPassword) {
      toast.error("Passwords do not match");
      valid = false;
    }
    if (!valid) {
      return;
    }
    try {
      changePassword({ currentpassword, newpassword });
    } catch (error) {
      toast.error(error.response.data);
    }
  };

  return (
    <div className="max-w-xl mx-auto mt-10">
      {/* Update Profile Section */}
      <div className="bg-white shadow-lg rounded-lg p-6 mb-6">
        <h1 className="text-2xl font-semibold mb-4 text-gray-700">
          Update Profile
        </h1>
        <form onSubmit={handleSubmit} className="space-y-4">
          <input
            type="text"
            placeholder="Name"
            defaultValue={name}
            onChange={(e) => setName(e.target.value)}
            className="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
          <input
            type="text"
            placeholder="Address"
            defaultValue={address}
            onChange={(e) => setAddress(e.target.value)}
            className="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
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
        <form onSubmit={handlePasswordSubmit} className="space-y-4">
          <input
            type="password"
            placeholder="Current Password"
            onChange={(e) => setCurrentPassword(e.target.value)}
            className="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
          <input
            type="password"
            placeholder="New Password"
            onChange={(e) => setnewPassword(e.target.value)}
            className="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
          <input
            type="password"
            placeholder="Confirm Password"
            onChange={(e) => setConfirmPassword(e.target.value)}
            className="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
          <button
            type="submit"
            className=" mx-52 bg-red-500 text-white py-2 px-4 rounded-md hover:bg-red-600 transition duration-300"
          >
            Change
          </button>
        </form>
      </div>
    </div>
  );
}

export default ProfilePage;
