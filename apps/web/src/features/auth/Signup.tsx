import React, { useState } from 'react';
import { useAuth } from '../../api/authContext';
import axios from 'axios';

interface SignupProps {
  onNavigateToLogin: () => void;
}

const Signup: React.FC<SignupProps> = ({ onNavigateToLogin }) => {
  const { signup } = useAuth();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [farmName, setFarmName] = useState('');
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);

    if (password !== confirmPassword) {
      setError('Passwords do not match.');
      return;
    }

    if (password.length < 6) {
      setError('Password should be at least 6 characters.');
      return;
    }

    setLoading(true);

    try {
      // 1. Sign up user via Firebase Auth (this also sets the token in context & axios header)
      await signup(email, password);

      // 2. Register their initial Farm
      try {
        await axios.post('/api/v1/farms', {
          name: farmName
        });
      } catch (farmErr: any) {
        console.error('Failed to create farm:', farmErr);
        // Farm creation failed, but user is created. We inform the user.
        setError('Account created, but failed to initialize your farm. Please contact support or retry.');
      }
    } catch (err: any) {
      console.error(err);
      const errMsg = err.response?.data?.error?.message || 'Failed to create account. Please check your credentials.';
      setError(errMsg);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="login-container">
      <div className="login-card">
        <div className="login-header">
          <div className="login-logo">🚜</div>
          <h1>Join Farm Recorder</h1>
          <p>Create your account & initialize your farm portal</p>
        </div>

        <form onSubmit={handleSubmit} className="login-form">
          {error && <div className="login-error">{error}</div>}

          <div className="form-group">
            <label htmlFor="farmName">Farm Name</label>
            <input
              type="text"
              id="farmName"
              value={farmName}
              onChange={(e) => setFarmName(e.target.value)}
              placeholder="e.g. Sunny Valley Farms"
              required
              disabled={loading}
            />
          </div>

          <div className="form-group">
            <label htmlFor="email">Email Address</label>
            <input
              type="email"
              id="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="Enter your email"
              required
              disabled={loading}
              autoComplete="email"
            />
          </div>

          <div className="form-group">
            <label htmlFor="password">Password</label>
            <input
              type="password"
              id="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="Min. 6 characters"
              required
              disabled={loading}
              autoComplete="new-password"
            />
          </div>

          <div className="form-group">
            <label htmlFor="confirmPassword">Confirm Password</label>
            <input
              type="password"
              id="confirmPassword"
              value={confirmPassword}
              onChange={(e) => setConfirmPassword(e.target.value)}
              placeholder="Re-enter your password"
              required
              disabled={loading}
              autoComplete="new-password"
            />
          </div>

          <button type="submit" className="login-btn" disabled={loading}>
            {loading ? 'Registering...' : 'Sign Up'}
          </button>
        </form>

        <div className="login-footer">
          <p>
            Already have an account?{' '}
            <button
              type="button"
              onClick={onNavigateToLogin}
              style={{
                background: 'none',
                border: 'none',
                color: '#3b82f6',
                cursor: 'pointer',
                padding: 0,
                textDecoration: 'underline',
                font: 'inherit'
              }}
            >
              Sign In
            </button>
          </p>
        </div>
      </div>
    </div>
  );
};

export default Signup;
