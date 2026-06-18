import { useState } from 'react';
import { useQueryClient, useQuery } from '@tanstack/react-query';
import { format } from 'date-fns';
import axios from 'axios';
import {
  useGetApiV1TasksFarmFarmId,
  usePostApiV1Tasks
} from '../../api/tasks/tasks';
import { Task } from '../../api/schemas/task';

interface Worker {
  id?: string;
  username: string;
  fullName: string;
  applicatorLicense?: string;
}

const fetchWorkers = async (): Promise<Worker[]> => {
  const response = await axios.get('/api/v1/workers');
  return response.data;
};

const DEFAULT_FARM_ID = '019ecc19-b6be-76d9-b997-5e89f6c0e35a';

export default function TaskManagement() {
  const [showForm, setShowForm] = useState(false);
  const [newTask, setNewTask] = useState({
    title: '',
    assignedTo: '',
    description: '',
    dueDate: ''
  });

  const queryClient = useQueryClient();

  const { data: workers = [] } = useQuery<Worker[]>({
    queryKey: ['workers'],
    queryFn: fetchWorkers,
  });

  // Fetch tasks dynamically from live backend
  const { data: tasksResponse, isLoading } = useGetApiV1TasksFarmFarmId(DEFAULT_FARM_ID);
  const tasks = tasksResponse?.data || [];

  const createTaskMutation = usePostApiV1Tasks();

  const handleCreateTask = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      const payload: Task = {
        farmId: DEFAULT_FARM_ID,
        title: newTask.title,
        assignedTo: newTask.assignedTo,
        description: newTask.description,
        status: 'PENDING',
        dueDate: newTask.dueDate ? new Date(newTask.dueDate).toISOString() : undefined
      };

      await createTaskMutation.mutateAsync({ data: payload });
      setShowForm(false);
      setNewTask({ title: '', assignedTo: '', description: '', dueDate: '' });
      queryClient.invalidateQueries({ queryKey: [`/api/v1/tasks/farm/${DEFAULT_FARM_ID}`] });
    } catch (err) {
      alert('Failed to assign task: ' + err);
    }
  };

  if (isLoading) {
    return <div style={{ padding: '40px', textAlign: 'center' }}>Loading tasks...</div>;
  }

  return (
    <div>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
        <div>
          <h1>Task Management</h1>
          <p className="subtitle">Assign farm activities and follow up on execution compliance.</p>
        </div>
        <button 
          onClick={() => setShowForm(!showForm)}
          className="btn btn-primary"
        >
          {showForm ? 'Cancel' : '+ Create New Task'}
        </button>
      </div>

      {showForm && (
        <div className="glass-card">
          <h3>Assign New Task</h3>
          <form onSubmit={handleCreateTask} style={{ marginTop: '20px' }}>
            <div className="form-row">
              <div className="form-group">
                <label className="form-label">Task Title *</label>
                <input 
                  required
                  type="text" 
                  className="form-control"
                  placeholder="e.g. Spray plot A with Neem Oil"
                  value={newTask.title}
                  onChange={(e) => setNewTask({...newTask, title: e.target.value})}
                />
              </div>
              <div className="form-group">
                <label className="form-label">Assign To *</label>
                <select 
                  required
                  className="form-control"
                  value={newTask.assignedTo}
                  onChange={(e) => setNewTask({...newTask, assignedTo: e.target.value})}
                >
                  <option value="">-- Select Worker --</option>
                  {workers.map(w => (
                    <option key={w.username} value={w.username}>
                      {w.fullName} ({w.username})
                    </option>
                  ))}
                </select>
              </div>
            </div>
            <div className="form-group">
              <label className="form-label">Description / Instructions *</label>
              <textarea 
                required
                className="form-control"
                placeholder="Include safety precautions, dilution rates, and required protective gear..."
                value={newTask.description}
                onChange={(e) => setNewTask({...newTask, description: e.target.value})}
                rows={3}
              />
            </div>
            <div className="form-group">
              <label className="form-label">Due Date *</label>
              <input 
                required
                type="datetime-local" 
                className="form-control"
                value={newTask.dueDate}
                onChange={(e) => setNewTask({...newTask, dueDate: e.target.value})}
                style={{ width: 'fit-content' }}
              />
            </div>
            <button type="submit" className="btn btn-primary">
              Assign Task
            </button>
          </form>
        </div>
      )}

      <div className="table-wrapper">
        <table className="data-table">
          <thead>
            <tr>
              <th>Task Title</th>
              <th>Assigned To</th>
              <th>Due Date</th>
              <th>Status</th>
              <th style={{ textAlign: 'right' }}>Evidence</th>
            </tr>
          </thead>
          <tbody>
            {tasks.length === 0 ? (
              <tr>
                <td colSpan={5} style={{ textAlign: 'center', color: 'var(--text-muted)' }}>
                  No tasks assigned yet. Click "+ Create New Task" to assign one.
                </td>
              </tr>
            ) : (
              tasks.map(task => (
                <tr key={task.id}>
                  <td>
                    <strong>{task.title}</strong>
                    <div style={{ fontSize: '13px', color: 'var(--text-secondary)', marginTop: '4px' }}>{task.description}</div>
                  </td>
                  <td><span className="mono">{task.assignedTo}</span></td>
                  <td>{task.dueDate ? format(new Date(task.dueDate), 'MMM dd, yyyy HH:mm') : 'N/A'}</td>
                  <td>
                    <span className={`badge ${
                      task.status === 'COMPLETED' 
                        ? 'badge-warning' 
                        : task.status === 'REVIEWED' 
                        ? 'badge-success' 
                        : 'badge-info'
                    }`}>
                      {task.status}
                    </span>
                  </td>
                  <td style={{ textAlign: 'right' }}>
                    {task.status === 'COMPLETED' || task.status === 'REVIEWED' ? (
                      <button className="btn btn-secondary" style={{ padding: '6px 12px', fontSize: '13px' }}>
                        View Evidence (Images/Voice)
                      </button>
                    ) : (
                      <span style={{ color: 'var(--text-muted)', fontSize: '13px' }}>Pending Completion</span>
                    )}
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
