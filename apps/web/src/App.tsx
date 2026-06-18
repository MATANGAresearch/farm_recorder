import { Routes, Route, Link, useLocation, Navigate } from 'react-router-dom';
import FarmMap from './features/map/FarmMap';
import GapAuditReport from './features/audit/GapAuditReport';
import TaskManagement from './features/tasks/TaskManagement';
import ManagerDashboard from './features/manager/ManagerDashboard';
import AdminPanel from './features/admin/AdminPanel';
import Login from './features/auth/Login';
import { AuthProvider, useAuth } from './api/authContext';

function AppContent() {
  const { isAuthenticated, user, isLoading, logout } = useAuth();
  const location = useLocation();

  if (isLoading) {
    return (
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', height: '100vh', backgroundColor: '#08090d' }}>
        <div className="mono" style={{ color: '#94a3b8' }}>Loading secure session...</div>
      </div>
    );
  }

  if (!isAuthenticated || !user) {
    return <Login />;
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

      <main className="main-content">
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
