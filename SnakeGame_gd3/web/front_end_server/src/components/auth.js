import React, { useEffect, useState } from "react";
import { Link, Navigate, Outlet, useNavigate } from "react-router-dom";

export class LoginControl {
  constructor() {
    this.state = ({isLoggedIn: false});
  }

  handleLogin() {
    this.state = ({isLoggedIn: true});
  }

  handleLogout() {
    this.state = ({isLoggedIn: false});
  }
}

export const Login = () => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const navigate = useNavigate();
  const handleSubmit = (e) => {
    e.preventDefault();
  
    const userData = {
      username,
      password,
    };
  
    fetch('http://localhost:4000/api/login', { 
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(userData),
    })
    .then(response => {
      if (!response.ok) {
        // If the response status code is not OK, throw an error to catch it later
        throw new Error('Invalid username or password');
      }
      return response.json();
    })
    .then(data => {
      isLoggedIn.handleLogin();
      console.log("Login successful");
      alert("Login successful!"); // You might want to redirect the user or save the login state
      navigate('/game'); // Adjust the navigation as per your application's flow
    })
    .catch((error) => {
      console.error('Error:', error);
      alert(error.message);
    });
  };

  return (
    <div className="container mt-5">
      <h2>Login</h2>
      <form onSubmit={handleSubmit}>
        <div className="mb-3">
          <label htmlFor="username" className="form-label">Username</label>
          <input
            type="text"
            className="form-control"
            id="username"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
          />
        </div>
        <div className="mb-3">
          <label htmlFor="password" className="form-label">Password</label>
          <input
            type="password"
            className="form-control"
            id="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />
        </div>
        <button type="submit" className="btn btn-primary">Submit</button>
      </form>
    </div>
  );
};

export const Register = () => {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const [confirmPassword, setConfirmPassword] = useState('');
    const [usernames, setUsernames] = useState([]);
    const navigate = useNavigate();

    // Fetch usernames when the component mounts
    useEffect(() => {
      fetch('http://127.0.0.1:4000/api/usernames')
        .then(response => response.json())
        .then(data => setUsernames(data))
        .catch(error => console.error('Error fetching usernames:', error));
    }, []);

    const handleSubmit = (e) => {
      e.preventDefault();

      if (password !== confirmPassword) {
        alert("Passwords don't match.");
        return;
      }

      if (usernames.includes(username)) {
        alert("Username already exists.");
        return;
      }

    const userData = {
        username,
        password,
        high_score: 0,
        highest_length: 0,
        highest_number_of_kills: 0,
        master_volume: 1,
        sound_effect_volume: 1,
        snake_skin: 4,
        achievement: '{f, f, f}',
        background_theme: 2,
    };

    fetch('http://localhost:4000/api/register', { 
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(userData),
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
        console.log("Registration successful! User details:", data.user); // Log the newly added user's details
        alert("Registration successful!");
        navigate('/login');
    })
    .catch((error) => {
        console.error('Error:', error);
        alert("Registration failed.");
    });
  };

    return (
      <div className="container mt-5">
        <h2>Register</h2>
        <form onSubmit={handleSubmit}>
          <div className="mb-3">
            <label htmlFor="username" className="form-label">Username</label>
            <input
              type="text"
              className="form-control"
              id="username"
              value={username}
              onChange={(e) => setUsername(e.target.value)}
            />
          </div>
          <div className="mb-3">
            <label htmlFor="password" className="form-label">Password</label>
            <input
              type="password"
              className="form-control"
              id="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
            />
          </div>
          <div className="mb-3">
            <label htmlFor="confirmPassword" className="form-label">Confirm Password</label>
            <input
              type="password"
              className="form-control"
              id="confirmPassword"
              value={confirmPassword}
              onChange={(e) => setConfirmPassword(e.target.value)}
            />
          </div>
          <button type="submit" className="btn btn-success">Register</button>
        </form>
      </div>
    );
  };
