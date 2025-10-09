import React, { useEffect, useState } from 'react';
import type { User } from '../api/userApi';
import { fetchUsers } from '../api/userApi';


const UserList: React.FC = () => {
  const [users, setUsers] = useState<User[]>([]);
  const [loading, setLoading] = useState<boolean>(true);

  useEffect(() => {
    const getUsers = async () => {
      try {
        const data = await fetchUsers();
        setUsers(data);
        console.log('Fetched users:', data); // 控制台调试
      } catch (error) {
        console.error('Failed to fetch users', error);
      } finally {
        setLoading(false);
      }
    };
    getUsers();
  }, []);

  if (loading) return <p>Loading users...</p>;

  return (
    <ul>
      {users.map(user => (
        <li key={user.id}>
          {user.name} ({user.email})
        </li>
      ))}
    </ul>
  );
};

export default UserList;
