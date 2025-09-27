import React, { useState } from 'react';
import axios from 'axios';
import { useNavigate, Link } from 'react-router-dom';
import './AuthPage.css';

const Login = ({ setIsLoggedIn }) => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [message, setMessage] = useState('');
  const navigate = useNavigate();

  const handleLogin = async (e) => {
    e.preventDefault();
    try {
      const res = await axios.post('http://localhost:8081/api/users/login', {
        email,
        password
      });

      if (res.data === 'Login successful!') {
        setIsLoggedIn(true);
        localStorage.setItem('userEmail', email);  // Store the email
        navigate('/dashboard');
      } else {
        setMessage(res.data);
      }
    } catch (err) {
      console.error(err);
      if (err.response && err.response.data) {
        setMessage(err.response.data);
      } else {
        setMessage('Login failed.');
      }
    }
  };

  return (
    <div className="auth-container">
      <div className="auth-box">
        <h2>Login</h2>
        {message && <div className={message.includes('successful') ? 'success-message' : 'error-message'}>{message}</div>}
        <form onSubmit={handleLogin}>
          <div className="input-group">
            <label>Email</label>
            <input type="email" value={email} onChange={e => setEmail(e.target.value)} required />
          </div>
          <div className="input-group">
            <label>Password</label>
            <input type="password" value={password} onChange={e => setPassword(e.target.value)} required />
          </div>
          <button className="auth-button">Login</button>
        </form>
        <p>Don't have an account? <Link to="/register">Register here</Link></p>
      </div>
    </div>
  );
};

export default Login;
