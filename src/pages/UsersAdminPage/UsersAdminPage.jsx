import React, { useEffect, useState } from "react";
import { Link, useParams } from "react-router-dom";
import { getAll } from "../../services/userServices";
import { toggleBlock } from "../../services/userServices";
import NotFound from "../../component/NotFound";
import Search from "../../component/Search";

function UsersAdminPage() {
  const { searchTerm } = useParams();
  const [users, setUsers] = useState();
  useEffect(() => {
    loadUsers(searchTerm);
  }, [searchTerm]);

  const loadUsers = async () => {
    const users = await getAll(searchTerm);
    setUsers(users);
  };
  const handletoggleBlock = async (userId) => {
    const isBlocked = await toggleBlock(userId);
    setUsers((oldusers) =>
      oldusers.map((user) =>
        user._id === userId ? { ...user, isBlocked } : user
      )
    );
  };
  return (
    <div className="container mx-auto p-8">
      <h2 className="text-2xl font-semibold mb-6 text-center">Manage Users</h2>
      <div className="overflow-x-auto">
        <Search
          SearchRoute={"/admin/users/"}
          defaultRoute={"/admin/users"}
          placeholder={" Search For User"}
        />

        <table className="min-w-full border border-gray-200 shadow-lg">
          <thead className="bg-gray-100">
            <tr>
              <th className="py-3 px-6 text-left text-gray-700 font-medium">
                Name
              </th>
              <th className="py-3 px-6 text-left text-gray-700 font-medium">
                Email
              </th>
              <th className="py-3 px-6 text-left text-gray-700 font-medium">
                Address
              </th>
              <th className="py-3 px-6 text-center text-gray-700 font-medium">
                Admin
              </th>
              <th className="py-3 px-6 text-center text-gray-700 font-medium">
                Actions
              </th>
            </tr>
          </thead>
          {!users ? (
            <NotFound message={"not users found"} />
          ) : (
            users.map((user) => (
              <tbody key={user._id}>
                {" "}
                <tr className="border-b border-gray-200">
                  <td className="py-3 px-6 text-gray-800">{user.name}</td>
                  <td className="py-3 px-6 text-gray-800">{user.email}</td>
                  <td className="py-3 px-6 text-gray-800">{user.address}</td>
                  {user.isAdmin ? (
                    <td className="py-3 px-6 text-center">
                      <span className="text-green-500">✓</span>
                    </td>
                  ) : (
                    <td className="py-3 px-6 text-center">
                      <span className="text-red-500">✗</span>
                    </td>
                  )}
                  <td className="py-3 px-6 text-center">
                    <Link
                      to={`/admin/editUser/${user._id}`}
                      className="text-blue-600 hover:underline mr-4"
                    >
                      Edit
                    </Link>
                    {!user.isAdmin && (
                      <Link
                        onClick={() => handletoggleBlock(user._id)}
                        className="text-purple-600 hover:underline"
                      >
                        {user.isBlocked ? "Unblock" : "block"}
                      </Link>
                    )}
                  </td>
                </tr>
              </tbody>
            ))
          )}
        </table>
      </div>
    </div>
  );
}

export default UsersAdminPage;
