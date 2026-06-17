import { Routes, Route, Link, useLocation } from 'react-router-dom';
import FarmMap from './features/map/FarmMap';
import GapAuditReport from './features/audit/GapAuditReport';
import TaskManagement from './features/tasks/TaskManagement';
import ManagerDashboard from './features/manager/ManagerDashboard';

function App() {
  const location = useLocation();

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
        </ul>
      </nav>
      <main className="main-content">
        <Routes>
          <Route path="/" element={<FarmMap />} />
          <Route path="/manager" element={<ManagerDashboard />} />
          <Route path="/tasks" element={<TaskManagement />} />
          <Route path="/audit" element={<GapAuditReport />} />
        </Routes>
      </main>
    </div>
  );
}

export default App;
