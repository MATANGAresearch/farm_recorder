import React, { useState } from 'react';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import axios from 'axios';

// Import generated API hooks
import { useGetApiV1Farms, usePostApiV1Farms } from '../../api/farms/farms';
import { useGetApiV1Locations, usePostApiV1Locations } from '../../api/locations/locations';
import { useGetApiV1Products, usePostApiV1Products } from '../../api/products/products';

// Worker interfaces and custom hooks
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

const createWorker = async (worker: Worker): Promise<Worker> => {
  const response = await axios.post('/api/v1/workers', worker);
  return response.data;
};

const deleteWorker = async (id: string): Promise<void> => {
  await axios.delete(`/api/v1/workers/${id}`);
};

interface FarmWorker {
  email: string;
  role: string;
}

const fetchFarmWorkers = async (farmId: string): Promise<FarmWorker[]> => {
  const response = await axios.get(`/api/v1/farms/${farmId}/workers`);
  return response.data;
};

const assignWorkerToFarm = async ({ farmId, email, role }: { farmId: string, email: string, role: string }) => {
  await axios.post(`/api/v1/farms/${farmId}/workers`, { email, role });
};

const unassignWorkerFromFarm = async ({ farmId, email }: { farmId: string, email: string }) => {
  await axios.delete(`/api/v1/farms/${farmId}/workers/${email}`);
};

const updateWorkerRole = async ({ farmId, email, role }: { farmId: string, email: string, role: string }) => {
  await axios.put(`/api/v1/farms/${farmId}/workers/${email}/role`, role);
};

const promoteWorkerToAdmin = async (email: string) => {
  await axios.post(`/api/v1/workers/${email}/promote`);
};


const AdminPanel: React.FC = () => {
  const queryClient = useQueryClient();
  const [activeTab, setActiveTab] = useState<'farms' | 'locations' | 'products' | 'workers'>('farms');

  // React Query queries and mutations
  const { data: farmsResponse, isLoading: isLoadingFarms, refetch: refetchFarms } = useGetApiV1Farms();
  const farms = farmsResponse?.data || [];

  const { data: locationsResponse, isLoading: isLoadingLocations, refetch: refetchLocations } = useGetApiV1Locations();
  const locations = locationsResponse?.data || [];

  const { data: productsResponse, isLoading: isLoadingProducts, refetch: refetchProducts } = useGetApiV1Products();
  const products = productsResponse?.data || [];

  const { data: workers = [], isLoading: isLoadingWorkers } = useQuery<Worker[]>({
    queryKey: ['workers'],
    queryFn: fetchWorkers,
  });

  // Generated Mutations
  const createFarmMutation = usePostApiV1Farms({
    mutation: {
      onSuccess: () => {
        refetchFarms();
        setFarmName('');
      },
    },
  });

  const createLocationMutation = usePostApiV1Locations({
    mutation: {
      onSuccess: () => {
        refetchLocations();
        setLocationGln('');
        setLocationName('');
        setLocationType('FIELD');
        setLocationGeoJson('');
      },
    },
  });

  const createProductMutation = usePostApiV1Products({
    mutation: {
      onSuccess: () => {
        refetchProducts();
        setProdName('');
        setProdGtin('');
        setProdVariety('');
        setProdType('CROP');
        setProdEpaReg('');
        setProdIngredients('');
        setProdRei(0);
        setProdPhi(0);
        setProdPrice('');
        setProdNotes('');
      },
    },
  });

  // Custom Mutations for Workers
  const createWorkerMutation = useMutation({
    mutationFn: createWorker,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['workers'] });
      setWorkerUsername('');
      setWorkerFullName('');
      setWorkerLicense('');
    },
  });

  const deleteWorkerMutation = useMutation({
    mutationFn: deleteWorker,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['workers'] });
    },
  });

  // Farm worker state and mutations
  const [selectedFarmId, setSelectedFarmId] = useState<string>('');

  const { data: assignedWorkers = [], refetch: refetchAssignedWorkers } = useQuery<FarmWorker[]>({
    queryKey: ['farmWorkers', selectedFarmId],
    queryFn: () => fetchFarmWorkers(selectedFarmId),
    enabled: !!selectedFarmId,
  });

  const assignWorkerMutation = useMutation({
    mutationFn: assignWorkerToFarm,
    onSuccess: () => {
      refetchAssignedWorkers();
    },
  });

  const updateWorkerRoleMutation = useMutation({
    mutationFn: updateWorkerRole,
    onSuccess: () => {
      refetchAssignedWorkers();
    },
  });

  const unassignWorkerMutation = useMutation({
    mutationFn: unassignWorkerFromFarm,
    onSuccess: () => {
      refetchAssignedWorkers();
    },
  });

  const promoteWorkerMutation = useMutation({
    mutationFn: promoteWorkerToAdmin,
    onSuccess: () => {
      alert('Worker promoted to Admin successfully!');
    },
    onError: (err: any) => {
      alert('Failed to promote worker: ' + (err.response?.data?.error || err.message));
    },
  });

  // Form states
  const [farmName, setFarmName] = useState('');

  const [locationGln, setLocationGln] = useState('');
  const [locationName, setLocationName] = useState('');
  const [locationType, setLocationType] = useState('FIELD');
  const [locationGeoJson, setLocationGeoJson] = useState('');

  const [prodGtin, setProdGtin] = useState('');
  const [prodName, setProdName] = useState('');
  const [prodVariety, setProdVariety] = useState('');
  const [prodType, setProdType] = useState('CROP');
  const [prodEpaReg, setProdEpaReg] = useState('');
  const [prodIngredients, setProdIngredients] = useState('');
  const [prodRei, setProdRei] = useState<number>(0);
  const [prodPhi, setProdPhi] = useState<number>(0);
  const [prodPrice, setProdPrice] = useState('');
  const [prodNotes, setProdNotes] = useState('');

  const [workerUsername, setWorkerUsername] = useState('');
  const [workerFullName, setWorkerFullName] = useState('');
  const [workerLicense, setWorkerLicense] = useState('');

  // Submit handlers
  const handleFarmSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!farmName.trim()) return;
    createFarmMutation.mutate({
      data: {
        name: farmName,
        ownerId: '', // Filled in backend from security token
      },
    });
  };

  const handleLocationSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!locationGln.trim() || !locationName.trim()) return;
    createLocationMutation.mutate({
      data: {
        gln: locationGln,
        name: locationName,
        type: locationType,
        geoJsonPolygon: locationGeoJson || undefined,
      },
    });
  };

  const handleProductSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!prodGtin.trim() || !prodName.trim()) return;
    createProductMutation.mutate({
      data: {
        gtin: prodGtin,
        name: prodName,
        variety: prodVariety || undefined,
        type: prodType,
        epaRegistrationNumber: prodEpaReg || undefined,
        activeIngredients: prodIngredients || undefined,
        reiHours: prodRei || undefined,
        phiDays: prodPhi || undefined,
        defaultUnitPrice: prodPrice ? parseFloat(prodPrice) : undefined,
        adminNotes: prodNotes || undefined,
        isLocalOnly: false,
      },
    });
  };

  const handleWorkerSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!workerUsername.trim() || !workerFullName.trim()) return;
    createWorkerMutation.mutate({
      username: workerUsername,
      fullName: workerFullName,
      applicatorLicense: workerLicense || undefined,
    });
  };

  return (
    <div>
      <h1>⚙️ Admin Panel</h1>
      <p className="subtitle">Configure core entities, manage product catalogs, and register farm workers</p>

      <div className="tab-container">
        <button
          onClick={() => setActiveTab('farms')}
          className={`tab-btn ${activeTab === 'farms' ? 'active' : ''}`}
        >
          🏢 Farms
        </button>
        <button
          onClick={() => setActiveTab('locations')}
          className={`tab-btn ${activeTab === 'locations' ? 'active' : ''}`}
        >
          📍 Locations
        </button>
        <button
          onClick={() => setActiveTab('products')}
          className={`tab-btn ${activeTab === 'products' ? 'active' : ''}`}
        >
          📦 Product Catalog
        </button>
        <button
          onClick={() => setActiveTab('workers')}
          className={`tab-btn ${activeTab === 'workers' ? 'active' : ''}`}
        >
          👷 Workers
        </button>
      </div>

      {/* Farms Tab */}
      {activeTab === 'farms' && (
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 2fr', gap: '30px' }}>
          <div className="glass-card">
            <h3>Add New Farm</h3>
            <form onSubmit={handleFarmSubmit} style={{ marginTop: '20px' }}>
              <div className="form-group">
                <label className="form-label">Farm Name</label>
                <input
                  type="text"
                  className="form-control"
                  placeholder="e.g. Matanga Research Plot A"
                  value={farmName}
                  onChange={(e) => setFarmName(e.target.value)}
                  required
                />
              </div>
              <button
                type="submit"
                className="btn btn-primary"
                style={{ width: '100%' }}
                disabled={createFarmMutation.isPending}
              >
                {createFarmMutation.isPending ? 'Saving...' : 'Create Farm'}
              </button>
            </form>
          </div>

          <div className="glass-card">
            <h3>Registered Farms</h3>
            <div style={{ marginTop: '20px' }}>
              {isLoadingFarms ? (
                <p>Loading farms...</p>
              ) : farms.length === 0 ? (
                <p style={{ color: '#64748b' }}>No farms registered yet.</p>
              ) : (
                <div className="table-wrapper">
                  <table className="data-table">
                    <thead>
                      <tr>
                        <th>Farm ID</th>
                        <th>Name</th>
                        <th>Owner ID</th>
                      </tr>
                    </thead>
                    <tbody>
                      {farms.map((farm: any) => (
                        <tr key={farm.id}>
                          <td className="mono">{farm.id}</td>
                          <td><strong>{farm.name}</strong></td>
                          <td>{farm.ownerId}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              )}
            </div>
          </div>

          {farms.length > 0 && (
            <div className="glass-card" style={{ gridColumn: 'span 2', marginTop: '30px' }}>
              <h3>Manage Farm Worker Assignments</h3>
              <div style={{ display: 'flex', gap: '20px', alignItems: 'center', marginTop: '15px' }}>
                <div className="form-group" style={{ margin: 0, flex: 1 }}>
                  <label className="form-label">Select Farm</label>
                  <select
                    className="form-control"
                    value={selectedFarmId}
                    onChange={(e) => setSelectedFarmId(e.target.value)}
                  >
                    <option value="">-- Choose Farm --</option>
                    {farms.map((f: any) => (
                      <option key={f.id} value={f.id}>{f.name}</option>
                    ))}
                  </select>
                </div>
                {selectedFarmId && (
                  <div style={{ display: 'flex', gap: '10px', alignItems: 'flex-end', flex: 1 }}>
                    <div className="form-group" style={{ margin: 0, flex: 2 }}>
                      <label className="form-label">Assign Worker</label>
                      <select
                        className="form-control"
                        id="worker-assign-select"
                      >
                        <option value="">-- Choose Worker --</option>
                        {workers.map((w) => (
                          <option key={w.username} value={w.username}>{w.fullName} ({w.username})</option>
                        ))}
                      </select>
                    </div>
                    <div className="form-group" style={{ margin: 0, flex: 1 }}>
                      <label className="form-label">Role</label>
                      <select
                        className="form-control"
                        id="worker-role-select"
                        defaultValue="WORKER"
                      >
                        <option value="WORKER">Worker</option>
                        <option value="ADMIN">Admin</option>
                        <option value="READONLY">Read-Only</option>
                      </select>
                    </div>
                    <button
                      onClick={() => {
                        const select = document.getElementById('worker-assign-select') as HTMLSelectElement;
                        const roleSelect = document.getElementById('worker-role-select') as HTMLSelectElement;
                        const email = select?.value;
                        const role = roleSelect?.value || 'WORKER';
                        if (email) {
                          assignWorkerMutation.mutate({ farmId: selectedFarmId, email, role });
                        }
                      }}
                      className="btn btn-primary"
                      disabled={assignWorkerMutation.isPending}
                    >
                      Assign
                    </button>
                  </div>
                )}
              </div>

              {selectedFarmId && (
                <div style={{ marginTop: '20px' }}>
                  <h4>Assigned Workers ({assignedWorkers.length})</h4>
                  <div className="table-wrapper" style={{ marginTop: '10px' }}>
                    <table className="data-table">
                      <thead>
                        <tr>
                          <th>Worker Email</th>
                          <th>Role</th>
                          <th style={{ width: '100px', textAlign: 'right' }}>Action</th>
                        </tr>
                      </thead>
                      <tbody>
                        {assignedWorkers.length === 0 ? (
                          <tr>
                            <td colSpan={3} style={{ textAlign: 'center', color: '#64748b' }}>
                              No workers assigned to this farm yet.
                            </td>
                          </tr>
                        ) : (
                          assignedWorkers.map((fw) => (
                            <tr key={fw.email}>
                              <td>{fw.email}</td>
                              <td>
                                <select
                                  value={fw.role}
                                  onChange={(e) => {
                                    updateWorkerRoleMutation.mutate({ farmId: selectedFarmId, email: fw.email, role: e.target.value });
                                  }}
                                  className="form-control"
                                  style={{ padding: '4px 8px', fontSize: '13px', width: 'fit-content' }}
                                >
                                  <option value="WORKER">WORKER</option>
                                  <option value="ADMIN">ADMIN</option>
                                  <option value="READONLY">READONLY</option>
                                </select>
                              </td>
                              <td style={{ textAlign: 'right' }}>
                                <button
                                  onClick={() => {
                                    if (window.confirm(`Unassign ${fw.email}?`)) {
                                      unassignWorkerMutation.mutate({ farmId: selectedFarmId, email: fw.email });
                                    }
                                  }}
                                  className="btn btn-danger"
                                  style={{ padding: '6px 12px', fontSize: '12px' }}
                                  disabled={unassignWorkerMutation.isPending}
                                >
                                  Unassign
                                </button>
                              </td>
                            </tr>
                          ))
                        )}
                      </tbody>
                    </table>
                  </div>
                </div>
              )}
            </div>
          )}
        </div>
      )}

      {/* Locations Tab */}
      {activeTab === 'locations' && (
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 2fr', gap: '30px' }}>
          <div className="glass-card">
            <h3>Add Location</h3>
            <form onSubmit={handleLocationSubmit} style={{ marginTop: '20px' }}>
              <div className="form-group">
                <label className="form-label">GS1 GLN (Global Location Number)</label>
                <input
                  type="text"
                  className="form-control mono"
                  placeholder="13-digit GLN (e.g. 5012345678900)"
                  value={locationGln}
                  onChange={(e) => setLocationGln(e.target.value)}
                  required
                />
              </div>

              <div className="form-group">
                <label className="form-label">Location Name</label>
                <input
                  type="text"
                  className="form-control"
                  placeholder="e.g. Field 1B (Maize)"
                  value={locationName}
                  onChange={(e) => setLocationName(e.target.value)}
                  required
                />
              </div>

              <div className="form-group">
                <label className="form-label">Type</label>
                <select
                  className="form-control"
                  value={locationType}
                  onChange={(e) => setLocationType(e.target.value)}
                >
                  <option value="FIELD">Field / Plot</option>
                  <option value="GREENHOUSE">Greenhouse</option>
                  <option value="FACILITY">Storage / Packaging Facility</option>
                </select>
              </div>

              <div className="form-group">
                <label className="form-label">GeoJSON Polygon Coordinates (Optional)</label>
                <textarea
                  className="form-control mono"
                  placeholder='{"type": "Polygon", "coordinates": [[[lng, lat], ...]]}'
                  rows={4}
                  value={locationGeoJson}
                  onChange={(e) => setLocationGeoJson(e.target.value)}
                />
              </div>

              <button
                type="submit"
                className="btn btn-primary"
                style={{ width: '100%' }}
                disabled={createLocationMutation.isPending}
              >
                {createLocationMutation.isPending ? 'Saving...' : 'Add Location'}
              </button>
            </form>
          </div>

          <div className="glass-card">
            <h3>Farm Fields & Facilities</h3>
            <div style={{ marginTop: '20px' }}>
              {isLoadingLocations ? (
                <p>Loading locations...</p>
              ) : locations.length === 0 ? (
                <p style={{ color: '#64748b' }}>No locations mapped yet.</p>
              ) : (
                <div className="table-wrapper">
                  <table className="data-table">
                    <thead>
                      <tr>
                        <th>GLN</th>
                        <th>Name</th>
                        <th>Type</th>
                        <th>Has GPS Polygon</th>
                      </tr>
                    </thead>
                    <tbody>
                      {locations.map((loc: any) => (
                        <tr key={loc.id}>
                          <td className="mono">{loc.gln}</td>
                          <td><strong>{loc.name}</strong></td>
                          <td>
                            <span className={`badge badge-${loc.type === 'FIELD' ? 'success' : loc.type === 'GREENHOUSE' ? 'info' : 'warning'}`}>
                              {loc.type}
                            </span>
                          </td>
                          <td>{loc.geoJsonPolygon ? '✅ GeoJSON Loaded' : '❌ No Boundary'}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              )}
            </div>
          </div>
        </div>
      )}

      {/* Products Tab */}
      {activeTab === 'products' && (
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 2fr', gap: '30px' }}>
          <div className="glass-card">
            <h3>Add Product</h3>
            <form onSubmit={handleProductSubmit} style={{ marginTop: '20px' }}>
              <div className="form-group">
                <label className="form-label">GS1 GTIN (Global Trade Item Number)</label>
                <input
                  type="text"
                  className="form-control mono"
                  placeholder="14-digit barcode GTIN"
                  value={prodGtin}
                  onChange={(e) => setProdGtin(e.target.value)}
                  required
                />
              </div>

              <div className="form-group">
                <label className="form-label">Product Name</label>
                <input
                  type="text"
                  className="form-control"
                  placeholder="e.g. Copper Hydroxide 50DF"
                  value={prodName}
                  onChange={(e) => setProdName(e.target.value)}
                  required
                />
              </div>

              <div className="form-group">
                <label className="form-label">Variety / Brand</label>
                <input
                  type="text"
                  className="form-control"
                  placeholder="e.g. Kocide 3000"
                  value={prodVariety}
                  onChange={(e) => setProdVariety(e.target.value)}
                />
              </div>

              <div className="form-row">
                <div className="form-group">
                  <label className="form-label">Type</label>
                  <select
                    className="form-control"
                    value={prodType}
                    onChange={(e) => setProdType(e.target.value)}
                  >
                    <option value="CROP">Crop Produce</option>
                    <option value="CHEMICAL">Chemical</option>
                    <option value="FERTILIZER">Fertilizer</option>
                    <option value="PESTICIDE">Pesticide</option>
                    <option value="TOOL">Equipment / Tool</option>
                  </select>
                </div>

                <div className="form-group">
                  <label className="form-label">Default Price ($)</label>
                  <input
                    type="number"
                    step="0.01"
                    className="form-control"
                    placeholder="e.g. 45.00"
                    value={prodPrice}
                    onChange={(e) => setProdPrice(e.target.value)}
                  />
                </div>
              </div>

              {/* Chemical related fields */}
              {(prodType === 'CHEMICAL' || prodType === 'PESTICIDE' || prodType === 'FERTILIZER') && (
                <div style={{ borderTop: '1px solid rgba(255,255,255,0.05)', paddingTop: '15px', marginTop: '15px' }}>
                  <div className="form-group">
                    <label className="form-label">EPA Registration Number</label>
                    <input
                      type="text"
                      className="form-control"
                      placeholder="e.g. 352-692"
                      value={prodEpaReg}
                      onChange={(e) => setProdEpaReg(e.target.value)}
                    />
                  </div>

                  <div className="form-group">
                    <label className="form-label">Active Ingredients</label>
                    <input
                      type="text"
                      className="form-control"
                      placeholder="e.g. Copper Hydroxide (46.1%)"
                      value={prodIngredients}
                      onChange={(e) => setProdIngredients(e.target.value)}
                    />
                  </div>

                  <div className="form-row">
                    <div className="form-group">
                      <label className="form-label">REI (Re-entry Interval Hours)</label>
                      <input
                        type="number"
                        className="form-control"
                        placeholder="e.g. 24"
                        value={prodRei}
                        onChange={(e) => setProdRei(parseInt(e.target.value) || 0)}
                      />
                    </div>

                    <div className="form-group">
                      <label className="form-label">PHI (Pre-harvest Interval Days)</label>
                      <input
                        type="number"
                        className="form-control"
                        placeholder="e.g. 14"
                        value={prodPhi}
                        onChange={(e) => setProdPhi(parseInt(e.target.value) || 0)}
                      />
                    </div>
                  </div>
                </div>
              )}

              <div className="form-group">
                <label className="form-label">Admin Notes</label>
                <textarea
                  className="form-control"
                  placeholder="Notes on usage, certifications required, safety etc."
                  rows={2}
                  value={prodNotes}
                  onChange={(e) => setProdNotes(e.target.value)}
                />
              </div>

              <button
                type="submit"
                className="btn btn-primary"
                style={{ width: '100%' }}
                disabled={createProductMutation.isPending}
              >
                {createProductMutation.isPending ? 'Saving...' : 'Add Catalog Item'}
              </button>
            </form>
          </div>

          <div className="glass-card">
            <h3>Global Product Catalog</h3>
            <div style={{ marginTop: '20px' }}>
              {isLoadingProducts ? (
                <p>Loading products...</p>
              ) : products.length === 0 ? (
                <p style={{ color: '#64748b' }}>No products in catalog yet.</p>
              ) : (
                <div className="table-wrapper">
                  <table className="data-table">
                    <thead>
                      <tr>
                        <th>GTIN</th>
                        <th>Name</th>
                        <th>Type</th>
                        <th>REI/PHI</th>
                        <th>EPA Reg #</th>
                      </tr>
                    </thead>
                    <tbody>
                      {products.map((p: any) => (
                        <tr key={p.id}>
                          <td className="mono">{p.gtin}</td>
                          <td>
                            <strong>{p.name}</strong>
                            {p.variety && <div style={{ fontSize: '12px', color: '#94a3b8' }}>{p.variety}</div>}
                          </td>
                          <td>
                            <span className={`badge badge-${p.type === 'CROP' ? 'success' : p.type === 'PESTICIDE' ? 'danger' : 'info'}`}>
                              {p.type}
                            </span>
                          </td>
                          <td>
                            {p.reiHours !== undefined || p.phiDays !== undefined ? (
                              <div style={{ fontSize: '13px' }}>
                                ⏱️ REI: {p.reiHours ?? 0}h <br />
                                🌾 PHI: {p.phiDays ?? 0}d
                              </div>
                            ) : '-'}
                          </td>
                          <td className="mono">{p.epaRegistrationNumber || '-'}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              )}
            </div>
          </div>
        </div>
      )}

      {/* Workers Tab */}
      {activeTab === 'workers' && (
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 2fr', gap: '30px' }}>
          <div className="glass-card">
            <h3>Register Farm Worker</h3>
            <p style={{ fontSize: '13px', color: '#94a3b8', margin: '5px 0 20px 0', lineHeight: '1.4' }}>
              Link a user account created in Firebase to their worker profile and attach pesticide applicator licenses.
            </p>
            <form onSubmit={handleWorkerSubmit}>
              <div className="form-group">
                <label className="form-label">Firebase Email Address (Username)</label>
                <input
                  type="email"
                  className="form-control"
                  placeholder="e.g. worker@domain.com (must match Firebase)"
                  value={workerUsername}
                  onChange={(e) => setWorkerUsername(e.target.value)}
                  required
                />
              </div>

              <div className="form-group">
                <label className="form-label">Full Name</label>
                <input
                  type="text"
                  className="form-control"
                  placeholder="e.g. John Doe"
                  value={workerFullName}
                  onChange={(e) => setWorkerFullName(e.target.value)}
                  required
                />
              </div>

              <div className="form-group">
                <label className="form-label">Applicator License Number (Optional)</label>
                <input
                  type="text"
                  className="form-control mono"
                  placeholder="e.g. LIC-98765-CHEM"
                  value={workerLicense}
                  onChange={(e) => setWorkerLicense(e.target.value)}
                />
              </div>

              <button
                type="submit"
                className="btn btn-primary"
                style={{ width: '100%' }}
                disabled={createWorkerMutation.isPending}
              >
                {createWorkerMutation.isPending ? 'Registering...' : 'Register Worker'}
              </button>
            </form>
          </div>

          <div className="glass-card">
            <h3>Registered Team Members</h3>
            <div style={{ marginTop: '20px' }}>
              {isLoadingWorkers ? (
                <p>Loading workers...</p>
              ) : workers.length === 0 ? (
                <p style={{ color: '#64748b' }}>No workers registered yet.</p>
              ) : (
                <div className="table-wrapper">
                  <table className="data-table">
                    <thead>
                      <tr>
                        <th>Email / Username</th>
                        <th>Full Name</th>
                        <th>Applicator License</th>
                        <th style={{ width: '220px', textAlign: 'right' }}>Actions</th>
                      </tr>
                    </thead>
                    <tbody>
                      {workers.map((w) => (
                        <tr key={w.id}>
                          <td><strong>{w.username}</strong></td>
                          <td>{w.fullName}</td>
                          <td>
                            {w.applicatorLicense ? (
                              <span className="badge badge-info mono">{w.applicatorLicense}</span>
                            ) : (
                              <span style={{ color: '#64748b', fontSize: '13px' }}>None</span>
                            )}
                          </td>
                          <td style={{ textAlign: 'right' }}>
                            <div style={{ display: 'flex', gap: '8px', justifyContent: 'flex-end' }}>
                              <button
                                onClick={() => {
                                  if (w.id && window.confirm(`Remove worker ${w.fullName}?`)) {
                                    deleteWorkerMutation.mutate(w.id);
                                  }
                                }}
                                className="btn btn-danger"
                                style={{ padding: '6px 12px', fontSize: '12px', borderRadius: '6px' }}
                                disabled={deleteWorkerMutation.isPending}
                              >
                                Remove
                              </button>
                              <button
                                onClick={() => {
                                  if (window.confirm(`Promote worker ${w.fullName} (${w.username}) to SaaS Admin?`)) {
                                    promoteWorkerMutation.mutate(w.username);
                                  }
                                }}
                                className="btn btn-secondary"
                                style={{ padding: '6px 12px', fontSize: '12px', borderRadius: '6px', backgroundColor: 'var(--accent)', color: 'white' }}
                                disabled={promoteWorkerMutation.isPending}
                              >
                                Promote to Admin
                              </button>
                            </div>
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              )}
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default AdminPanel;
