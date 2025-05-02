import React, { useEffect, useState } from "react";
import { editUser, getAll } from "../../services/userServices";
import NotFound from "../../component/NotFound";

function UsersAdminPage() {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    loadUsers();
  }, []);

  const loadUsers = async () => {
    try {
      const res = await getAll();
      setUsers(res.data.data || []);
    } catch {}
  };

  const handleSubmit = async (email, currentRole) => {
    const newRole = currentRole === "Admin" ? "user" : "Admin";
    await editUser(email, newRole);
    loadUsers();
  };

  return (
    <div className="container mx-auto p-6">
      <h2 className="text-3xl font-bold text-indigo-700 text-center mb-8">
        Manage Users
      </h2>
      <div className="overflow-x-auto bg-white rounded-lg shadow-md">
        <table className="min-w-full border-collapse">
          <thead className="bg-indigo-50">
            <tr>
              <th className="py-4 px-6 text-left text-indigo-700 font-semibold border-b">
                Name
              </th>
              <th className="py-4 px-6 text-left text-indigo-700 font-semibold border-b">
                Email
              </th>
              <th className="py-4 px-6 text-center text-indigo-700 font-semibold border-b">
                Admin
              </th>
              <th className="py-4 px-6 text-center text-indigo-700 font-semibold border-b">
                Action
              </th>
            </tr>
          </thead>
          <tbody>
            {users.length === 0 ? (
              <tr>
                <td colSpan="4">
                  <NotFound message="No users found" />
                </td>
              </tr>
            ) : (
              users.map((user, idx) => (
                <tr key={idx} className="hover:bg-indigo-50 transition">
                  <td className="py-3 px-6 text-gray-800 border-b">
                    {user.firstName}
                  </td>
                  <td className="py-3 px-6 text-gray-800 border-b">
                    {user.email}
                  </td>
                  <td className="py-3 px-6 text-center border-b">
                    {user.roles[0] === "Admin" ? (
                      <span className="text-green-600 font-bold">✓</span>
                    ) : (
                      <span className="text-red-500 font-bold">✗</span>
                    )}
                  </td>
                  <td className="py-3 px-6 text-center border-b">
                    <button
                      onClick={() => handleSubmit(user.email, user.roles[0])}
                      className={`px-4 py-1 rounded text-white font-medium transition ${
                        user.roles[0] === "Admin"
                          ? "bg-red-500 hover:bg-red-600"
                          : "bg-blue-500 hover:bg-blue-600"
                      }`}
                    >
                      {user.roles[0] === "Admin"
                        ? "Revoke Admin"
                        : "Make Admin"}
                    </button>
                  </td>
                </tr>
              ))
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
}

export default UsersAdminPage;
