import { useState } from 'react';
import { useQueryClient, useQuery } from '@tanstack/react-query';
import { format } from 'date-fns';
import axios from 'axios';
import {
  useGetApiV1TasksFarmFarmId,
  usePostApiV1Tasks
} from '../../api/tasks/tasks';
import { Task } from '../../api/schemas/task';
import { useAuth } from '../../api/authContext';

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

export default function TaskManagement() {
  const { activeFarmId } = useAuth();
  const [showForm, setShowForm] = useState(false);
  const [bulkMode, setBulkMode] = useState(false);
  const [newTask, setNewTask] = useState({
    title: '',
    assignedTo: '',
    description: '',
    dueDate: ''
  });
  const [bulkTasks, setBulkTasks] = useState<Array<{ title: string; assignedTo: string; description: string; dueDate: string }>>([
    { title: '', assignedTo: '', description: '', dueDate: '' }
  ]);

  const queryClient = useQueryClient();

  const { data: workers = [] } = useQuery<Worker[]>({
    queryKey: ['workers'],
    queryFn: fetchWorkers,
  });

  // Fetch tasks dynamically from live backend using activeFarmId
  const { data: tasksResponse, isLoading } = useGetApiV1TasksFarmFarmId(activeFarmId || '');
  const tasks = tasksResponse?.data || [];

  const createTaskMutation = usePostApiV1Tasks();

  const handleCreateTask = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!activeFarmId) {
      alert('No active farm context selected.');
      return;
    }
    try {
      const payload: Task = {
        farmId: activeFarmId,
        title: newTask.title,
        assignedTo: newTask.assignedTo,
        description: newTask.description,
        status: 'PENDING',
        dueDate: newTask.dueDate ? new Date(newTask.dueDate).toISOString() : undefined
      };

      await createTaskMutation.mutateAsync({ data: payload });
      setShowForm(false);
      setNewTask({ title: '', assignedTo: '', description: '', dueDate: '' });
      queryClient.invalidateQueries({ queryKey: [`/api/v1/tasks/farm/${activeFarmId}`] });
    } catch (err) {
      alert('Failed to assign task: ' + err);
    }
  };

  const handleAddBulkRow = () => {
    setBulkTasks([...bulkTasks, { title: '', assignedTo: '', description: '', dueDate: '' }]);
  };

  const handleRemoveBulkRow = (index: number) => {
    const list = [...bulkTasks];
    list.splice(index, 1);
    setBulkTasks(list);
  };

  const handleBulkChange = (index: number, field: string, value: string) => {
    const list = [...bulkTasks];
    list[index] = { ...list[index], [field]: value };
    setBulkTasks(list);
  };

  const handleCreateBulkTasks = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!activeFarmId) {
      alert('No active farm context selected.');
      return;
    }
    
    // Filter empty tasks
    const validTasks = bulkTasks.filter(t => t.title.trim() && t.assignedTo.trim());
    if (validTasks.length === 0) {
      alert('Please fill out at least one task with a title and assignee.');
      return;
    }

    try {
      const payload: Task[] = validTasks.map(t => ({
        farmId: activeFarmId,
        title: t.title,
        assignedTo: t.assignedTo,
        description: t.description,
        status: 'PENDING',
        dueDate: t.dueDate ? new Date(t.dueDate).toISOString() : undefined
      }));

      await axios.post('/api/v1/tasks/bulk', payload);
      
      setShowForm(false);
      setBulkMode(false);
      setBulkTasks([{ title: '', assignedTo: '', description: '', dueDate: '' }]);
      queryClient.invalidateQueries({ queryKey: [`/api/v1/tasks/farm/${activeFarmId}`] });
      alert('Tasks successfully assigned in bulk!');
    } catch (err: any) {
      alert('Failed to bulk assign tasks: ' + (err.response?.data?.error || err.message));
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
          onClick={() => {
            setShowForm(!showForm);
            if (!showForm) {
              setBulkMode(false);
              setBulkTasks([{ title: '', assignedTo: '', description: '', dueDate: '' }]);
            }
          }}
          className="btn btn-primary"
        >
          {showForm ? 'Cancel' : '+ Create New Task'}
        </button>
      </div>

      {showForm && (
        <div className="glass-card">
          <div style={{ display: 'flex', gap: '16px', marginBottom: '20px', borderBottom: '1px solid var(--border-color)', paddingBottom: '12px' }}>
            <button 
              type="button" 
              className={`tab-btn ${!bulkMode ? 'active' : ''}`}
              onClick={() => setBulkMode(false)}
            >
              Single Task Assignment
            </button>
            <button 
              type="button" 
              className={`tab-btn ${bulkMode ? 'active' : ''}`}
              onClick={() => setBulkMode(true)}
            >
              Bulk Tasks Import
            </button>
          </div>

          {!bulkMode ? (
            <form onSubmit={handleCreateTask}>
              <h3>Assign New Task</h3>
              <div style={{ marginTop: '20px' }}>
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
              </div>
            </form>
          ) : (
            <form onSubmit={handleCreateBulkTasks}>
              <h3>Bulk Tasks Assignment</h3>
              <div style={{ marginTop: '20px', display: 'flex', flexDirection: 'column', gap: '16px', marginBottom: '20px' }}>
                {bulkTasks.map((t, idx) => (
                  <div key={idx} style={{ padding: '16px', border: '1px solid var(--border-color)', borderRadius: '12px', background: 'rgba(255,255,255,0.01)', position: 'relative' }}>
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '10px' }}>
                      <strong style={{ color: 'var(--text-secondary)' }}>Task #{idx + 1}</strong>
                      {bulkTasks.length > 1 && (
                        <button 
                          type="button" 
                          className="btn btn-danger" 
                          style={{ padding: '4px 10px', fontSize: '12px' }}
                          onClick={() => handleRemoveBulkRow(idx)}
                        >
                          Remove
                        </button>
                      )}
                    </div>
                    
                    <div className="form-row">
                      <div className="form-group" style={{ marginBottom: '12px' }}>
                        <label className="form-label">Task Title *</label>
                        <input 
                          required
                          type="text" 
                          className="form-control"
                          placeholder="e.g. Clean storage crates"
                          value={t.title}
                          onChange={(e) => handleBulkChange(idx, 'title', e.target.value)}
                        />
                      </div>
                      <div className="form-group" style={{ marginBottom: '12px' }}>
                        <label className="form-label">Assign To *</label>
                        <select 
                          required
                          className="form-control"
                          value={t.assignedTo}
                          onChange={(e) => handleBulkChange(idx, 'assignedTo', e.target.value)}
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

                    <div className="form-row">
                      <div className="form-group" style={{ margin: 0, flex: 2 }}>
                        <label className="form-label">Description / Instructions</label>
                        <input 
                          type="text" 
                          className="form-control"
                          placeholder="Instructions..."
                          value={t.description}
                          onChange={(e) => handleBulkChange(idx, 'description', e.target.value)}
                        />
                      </div>
                      <div className="form-group" style={{ margin: 0, flex: 1 }}>
                        <label className="form-label">Due Date</label>
                        <input 
                          type="datetime-local" 
                          className="form-control"
                          value={t.dueDate}
                          onChange={(e) => handleBulkChange(idx, 'dueDate', e.target.value)}
                        />
                      </div>
                    </div>
                  </div>
                ))}
              </div>
              
              <div style={{ display: 'flex', gap: '12px' }}>
                <button type="button" className="btn btn-secondary" onClick={handleAddBulkRow}>
                  + Add Task Row
                </button>
                <button type="submit" className="btn btn-primary">
                  Assign All Tasks
                </button>
              </div>
            </form>
          )}
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
