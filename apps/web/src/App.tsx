import { useState } from 'react';
import { Routes, Route, Link, useLocation, Navigate } from 'react-router-dom';
import FarmMap from './features/map/FarmMap';
import GapAuditReport from './features/audit/GapAuditReport';
import TaskManagement from './features/tasks/TaskManagement';
import ManagerDashboard from './features/manager/ManagerDashboard';
import AdminPanel from './features/admin/AdminPanel';
import Login from './features/auth/Login';
import Signup from './features/auth/Signup';
import { AuthProvider, useAuth } from './api/authContext';

function AppContent() {
  const { isAuthenticated, user, isLoading, logout, farms, activeFarmId, switchFarm } = useAuth();
  const location = useLocation();
  const [authMode, setAuthMode] = useState<'login' | 'signup'>('login');

  if (isLoading) {
    return (
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', height: '100vh', backgroundColor: '#08090d' }}>
        <div className="mono" style={{ color: '#94a3b8' }}>Loading secure session...</div>
      </div>
    );
  }

  if (!isAuthenticated || !user) {
    return authMode === 'login' 
      ? <Login onNavigateToSignup={() => setAuthMode('signup')} /> 
      : <Signup onNavigateToLogin={() => setAuthMode('login')} />;
  }

  const getLinkClass = (path: string) => {
    return `sidebar-link ${location.pathname === path ? 'active' : ''}`;
  };

  return (
    <div style={{ display: 'flex', minHeight: '100vh' }}>
      <nav className="sidebar">
        <h2>🚜 Farm Recorder</h2>
        <ul style={{ listStyle: 'none', padding: 0, margin: 0 }}>
          <li>
            <Link to="/" className={getLinkClass('/')}>
              <span>🗺️</span> Map View
            </Link>
          </li>
          <li>
            <Link to="/manager" className={getLinkClass('/manager')}>
              <span>📊</span> Manager Dashboard
            </Link>
          </li>
          <li>
            <Link to="/tasks" className={getLinkClass('/tasks')}>
              <span>📋</span> Task Management
            </Link>
          </li>
          <li>
            <Link to="/audit" className={getLinkClass('/audit')}>
              <span>📑</span> GAP Audit Report
            </Link>
          </li>
          {user.role === 'ADMIN' && (
            <li>
              <Link to="/admin" className={getLinkClass('/admin')}>
                <span>⚙️</span> Admin Panel
              </Link>
            </li>
          )}
        </ul>

        <div className="sidebar-footer">
          <div className="user-badge">
            <span className="username" title={user.username}>{user.username}</span>
            <span className="role">{user.role}</span>
          </div>
          <button onClick={logout} className="logout-link" style={{ width: '100%', border: 'none' }}>
            <span>🚪</span> Sign Out
          </button>
        </div>
      </nav>

      <main className="main-content" style={{ display: 'flex', flexDirection: 'column' }}>
        <header style={{ 
          display: 'flex', 
          justifyContent: 'flex-end', 
          alignItems: 'center', 
          marginBottom: '24px', 
          paddingBottom: '16px', 
          borderBottom: '1px solid var(--border-color)',
          minHeight: '50px'
        }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
            <span style={{ fontSize: '14px', color: 'var(--text-secondary)', fontWeight: 500 }}>Active Farm:</span>
            {farms.length > 0 ? (
              <select
                value={activeFarmId || ''}
                onChange={(e) => switchFarm(e.target.value)}
                style={{
                  padding: '8px 16px',
                  background: 'rgba(255, 255, 255, 0.05)',
                  border: '1px solid var(--border-color)',
                  borderRadius: '8px',
                  color: 'var(--text-primary)',
                  fontFamily: 'var(--font-sans)',
                  fontSize: '14px',
                  fontWeight: 600,
                  cursor: 'pointer',
                  outline: 'none'
                }}
              >
                {farms.map((farm) => (
                  <option key={farm.id} value={farm.id} style={{ background: '#0f111a', color: '#fff' }}>
                    {farm.name}
                  </option>
                ))}
              </select>
            ) : (
              <span style={{ fontSize: '14px', color: 'var(--text-muted)' }}>No farms registered</span>
            )}
          </div>
        </header>

        <div style={{ flex: 1 }}>
          <Routes>
            <Route path="/" element={<FarmMap />} />
            <Route path="/manager" element={<ManagerDashboard />} />
            <Route path="/tasks" element={<TaskManagement />} />
            <Route path="/audit" element={<GapAuditReport />} />
            <Route 
              path="/admin" 
              element={user.role === 'ADMIN' ? <AdminPanel /> : <Navigate to="/" replace />} 
            />
            <Route path="*" element={<Navigate to="/" replace />} />
          </Routes>
        </div>
      </main>
    </div>
  );
}

function App() {
  return (
    <AuthProvider>
      <AppContent />
    </AuthProvider>
  );
}

export default App;
