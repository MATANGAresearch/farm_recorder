import { useState } from 'react';
import { useQueryClient, useQuery, useMutation } from '@tanstack/react-query';
import { format } from 'date-fns';
import axios from 'axios';
import {
  useGetApiV1Products,
  usePostApiV1Products,
  usePutApiV1Products
} from '../../api/products/products';
import {
  useGetApiV1InputBatches,
  usePostApiV1InputBatches
} from '../../api/input-batches/input-batches';
import {
  useGetApiV1TasksFarmFarmId,
  usePatchApiV1TasksIdStatus
} from '../../api/tasks/tasks';
import {
  usePostApiV1ActivityLogs,
  usePutApiV1ActivityLogs,
  useGetApiV1ActivityLogsId,
  useGetApiV1ActivityLogsTaskTaskId
} from '../../api/activity-logs/activity-logs';
import { useGetApiV1Locations } from '../../api/locations/locations';
import { useGetApiV1MediaActivityActivityLogId } from '../../api/media/media';
import { Product } from '../../api/schemas/product';
import { InputBatch } from '../../api/schemas/inputBatch';
import { ActivityLog } from '../../api/schemas/activityLog';

import { useAuth } from '../../api/authContext';

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

export default function ManagerDashboard() {
  const { activeFarmId, activeFarm, user } = useAuth();
  const queryClient = useQueryClient();
  const [activeTab, setActiveTab] = useState<'inventory' | 'chemicals' | 'reviews' | 'log-activity' | 'members'>('inventory');
  
  // Farm members management state
  const [inviteEmail, setInviteEmail] = useState('');
  const [inviteRole, setInviteRole] = useState('WORKER');

  // React Query Hooks
  const { data: productsResponse, isLoading: productsLoading } = useGetApiV1Products();
  const products = productsResponse?.data || [];

  const { data: batchesResponse, isLoading: batchesLoading } = useGetApiV1InputBatches();
  const batches = batchesResponse?.data || [];

  const { data: tasksResponse, isLoading: tasksLoading } = useGetApiV1TasksFarmFarmId(activeFarmId || '');
  const tasks = tasksResponse?.data || [];

  const { data: locationsResponse } = useGetApiV1Locations();
  const locations = locationsResponse?.data || [];

  // Fetch farm workers
  const { data: farmWorkers = [], refetch: refetchFarmWorkers } = useQuery<FarmWorker[]>({
    queryKey: ['farmWorkers', activeFarmId],
    queryFn: () => fetchFarmWorkers(activeFarmId || ''),
    enabled: !!activeFarmId,
  });

  const currentUserEmail = user?.username || '';
  const currentUserMember = farmWorkers.find(fw => fw.email === currentUserEmail);
  const isFarmAdmin = activeFarm?.ownerId === currentUserEmail || currentUserMember?.role === 'ADMIN';

  // Mutations
  const createProductMutation = usePostApiV1Products();
  const updateProductMutation = usePutApiV1Products();
  const createInputBatchMutation = usePostApiV1InputBatches();
  const createActivityLogMutation = usePostApiV1ActivityLogs();

  const assignWorkerMutation = useMutation({
    mutationFn: assignWorkerToFarm,
    onSuccess: () => {
      refetchFarmWorkers();
    },
    onError: (err: any) => {
      alert('Failed to assign worker: ' + (err.response?.data?.error || err.message));
    }
  });

  const updateWorkerRoleMutation = useMutation({
    mutationFn: updateWorkerRole,
    onSuccess: () => {
      refetchFarmWorkers();
    },
    onError: (err: any) => {
      alert('Failed to update role: ' + (err.response?.data?.error || err.message));
    }
  });

  const unassignWorkerMutation = useMutation({
    mutationFn: unassignWorkerFromFarm,
    onSuccess: () => {
      refetchFarmWorkers();
    },
    onError: (err: any) => {
      alert('Failed to unassign worker: ' + (err.response?.data?.error || err.message));
    }
  });

  // Local state for forms
  const [showProductForm, setShowProductForm] = useState(false);
  const [editingProduct, setEditingProduct] = useState<Product | null>(null);
  const [newProduct, setNewProduct] = useState<Partial<Product>>({
    name: '',
    gtin: '',
    variety: '',
    batchPrefix: '',
    type: 'CROP',
    epaRegistrationNumber: '',
    activeIngredients: '',
    reiHours: 0,
    phiDays: 0,
    isLocalOnly: false,
    adminNotes: '',
    defaultUnitPrice: 0
  });

  const [showBatchForm, setShowBatchForm] = useState(false);
  const [newBatch, setNewBatch] = useState<Partial<InputBatch>>({
    gtin: '',
    lotNumber: '',
    productId: '',
    initialQuantity: 0,
    remainingQuantity: 0,
    expirationDate: '',
    unit: 'Liters'
  });

  const [newActivity, setNewActivity] = useState<Partial<ActivityLog>>({
    type: 'SPRAYING',
    locationId: '',
    productId: '',
    userId: 'supervisor',
    notes: '',
    gpsLat: 32.05,
    gpsLng: 35.05,
    quantity: undefined,
    chemicalLotNumber: '',
    chemicalExpirationDate: '',
    applicationRate: '',
    totalQuantityApplied: undefined,
    weatherWindSpeed: undefined,
    weatherWindDirection: '',
    weatherTemperature: undefined,
    applicatorLicense: '',
    isManualInput: false,
    verificationStatus: 'VERIFIED'
  });

  // Actions
  const handleGenerateLocalGtin = (isEditing: boolean) => {
    const localGtin = '999' + Date.now().toString();
    if (isEditing) {
      setEditingProduct(prev => prev ? { ...prev, gtin: localGtin } : null);
    } else {
      setNewProduct(prev => ({ ...prev, gtin: localGtin }));
    }
  };

  const handleSaveProduct = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      if (editingProduct) {
        await updateProductMutation.mutateAsync({ data: editingProduct });
        setEditingProduct(null);
      } else {
        await createProductMutation.mutateAsync({ data: newProduct as Product });
        setShowProductForm(false);
        setNewProduct({
          name: '',
          gtin: '',
          variety: '',
          batchPrefix: '',
          type: 'CROP',
          epaRegistrationNumber: '',
          activeIngredients: '',
          reiHours: 0,
          phiDays: 0,
          isLocalOnly: false,
          adminNotes: '',
          defaultUnitPrice: 0
        });
      }
      queryClient.invalidateQueries({ queryKey: [`/api/v1/products`] });
    } catch (err) {
      alert('Failed to save product: ' + err);
    }
  };

  const handleRegisterInputBatch = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      // Find productId from the selected GTIN to ensure linkage
      const product = products.find(p => p.gtin === newBatch.gtin);
      if (!product) {
        alert('Invalid GTIN selected.');
        return;
      }
      const payload: InputBatch = {
        gtin: newBatch.gtin || '',
        lotNumber: newBatch.lotNumber || '',
        productId: product.id || '',
        initialQuantity: Number(newBatch.initialQuantity) || 0,
        remainingQuantity: Number(newBatch.initialQuantity) || 0,
        expirationDate: newBatch.expirationDate ? new Date(newBatch.expirationDate).toISOString() : '',
        unit: newBatch.unit || 'Liters'
      };

      await createInputBatchMutation.mutateAsync({ data: payload });
      setShowBatchForm(false);
      setNewBatch({
        gtin: '',
        lotNumber: '',
        productId: '',
        initialQuantity: 0,
        remainingQuantity: 0,
        expirationDate: '',
        unit: 'Liters'
      });
      queryClient.invalidateQueries({ queryKey: [`/api/v1/input-batches`] });
    } catch (err) {
      alert('Failed to register inventory batch: ' + err);
    }
  };


  const handleSaveActivity = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      const payload: ActivityLog = {
        ...newActivity,
        timestamp: new Date().toISOString(),
        chemicalExpirationDate: newActivity.chemicalExpirationDate ? new Date(newActivity.chemicalExpirationDate).toISOString() : undefined,
        quantity: newActivity.quantity ? Number(newActivity.quantity) : undefined,
        totalQuantityApplied: newActivity.totalQuantityApplied ? Number(newActivity.totalQuantityApplied) : undefined,
        weatherWindSpeed: newActivity.weatherWindSpeed ? Number(newActivity.weatherWindSpeed) : undefined,
        weatherTemperature: newActivity.weatherTemperature ? Number(newActivity.weatherTemperature) : undefined,
        gpsLat: Number(newActivity.gpsLat) || 32.05,
        gpsLng: Number(newActivity.gpsLng) || 35.05,
        isManualInput: true,
        manualInputComments: 'Recorded directly by supervisor from dashboard'
      };

      await createActivityLogMutation.mutateAsync({ data: payload });
      alert('Activity log successfully recorded.');
      setNewActivity({
        type: 'SPRAYING',
        locationId: '',
        productId: '',
        userId: 'supervisor',
        notes: '',
        gpsLat: 32.05,
        gpsLng: 35.05,
        quantity: undefined,
        chemicalLotNumber: '',
        chemicalExpirationDate: '',
        applicationRate: '',
        totalQuantityApplied: undefined,
        weatherWindSpeed: undefined,
        weatherWindDirection: '',
        weatherTemperature: undefined,
        applicatorLicense: '',
        isManualInput: false,
        verificationStatus: 'VERIFIED'
      });
      queryClient.invalidateQueries({ queryKey: [`/api/v1/tasks/farm/${activeFarmId}`] });
    } catch (err) {
      alert('Failed to record activity log: ' + err);
    }
  };

  if (productsLoading || batchesLoading || tasksLoading) {
    return <div style={{ padding: '40px', textAlign: 'center' }}>Loading manager portal data...</div>;
  }

  return (
    <div>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
        <div>
          <h1>Manager Dashboard</h1>
          <p className="subtitle">Track input inventories, override chemical specifications, and verify field activities.</p>
        </div>
        
        <div className="tab-container">
          <button
            onClick={() => setActiveTab('inventory')}
            className={`tab-btn ${activeTab === 'inventory' ? 'active' : ''}`}
          >
            📦 Input Inventory
          </button>
          <button
            onClick={() => setActiveTab('chemicals')}
            className={`tab-btn ${activeTab === 'chemicals' ? 'active' : ''}`}
          >
            🧪 Chemical Catalog
          </button>
          <button
            onClick={() => setActiveTab('reviews')}
            className={`tab-btn ${activeTab === 'reviews' ? 'active' : ''}`}
          >
            ✅ Task Reviews ({tasks.filter(t => t.status === 'COMPLETED' || (t.assignedTo === 'supervisor' && t.status === 'PENDING')).length})
          </button>
          <button
            onClick={() => setActiveTab('log-activity')}
            className={`tab-btn ${activeTab === 'log-activity' ? 'active' : ''}`}
          >
            📝 Log Activity
          </button>
          <button
            onClick={() => setActiveTab('members')}
            className={`tab-btn ${activeTab === 'members' ? 'active' : ''}`}
          >
            👥 Farm Members
          </button>
        </div>
      </div>

      {/* TABS 1: Inventory Management */}
      {activeTab === 'inventory' && (
        <div>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '20px' }}>
            <h2>Active Input Lots & Batches</h2>
            <button className="btn btn-primary" onClick={() => setShowBatchForm(!showBatchForm)}>
              {showBatchForm ? 'Close Form' : '+ Register Inventory Lot'}
            </button>
          </div>

          {showBatchForm && (
            <div className="glass-card">
              <h3>Register Chemical / Fertilizer Lot</h3>
              <form onSubmit={handleRegisterInputBatch} style={{ marginTop: '20px' }}>
                <div className="form-row">
                  <div className="form-group">
                    <label className="form-label">Approved Product *</label>
                    <select
                      className="form-control"
                      value={newBatch.gtin}
                      onChange={(e) => setNewBatch({ ...newBatch, gtin: e.target.value })}
                      required
                    >
                      <option value="">-- Select Product (GTIN) --</option>
                      {products
                        .filter(p => ['PESTICIDE', 'HERBICIDE', 'FERTILIZER', 'CHEMICAL'].includes(p.type || ''))
                        .map(p => (
                          <option key={p.id} value={p.gtin}>
                            {p.name} ({p.gtin})
                          </option>
                        ))}
                    </select>
                  </div>
                  <div className="form-group">
                    <label className="form-label">Lot Number *</label>
                    <input
                      type="text"
                      className="form-control"
                      placeholder="e.g. LOT-CHEM-2026"
                      value={newBatch.lotNumber}
                      onChange={(e) => setNewBatch({ ...newBatch, lotNumber: e.target.value })}
                      required
                    />
                  </div>
                </div>

                <div className="form-row">
                  <div className="form-group">
                    <label className="form-label">Initial Quantity *</label>
                    <input
                      type="number"
                      step="0.01"
                      className="form-control"
                      placeholder="e.g. 150.00"
                      value={newBatch.initialQuantity || ''}
                      onChange={(e) => setNewBatch({ ...newBatch, initialQuantity: Number(e.target.value) })}
                      required
                    />
                  </div>
                  <div className="form-group">
                    <label className="form-label">Unit *</label>
                    <select
                      className="form-control"
                      value={newBatch.unit}
                      onChange={(e) => setNewBatch({ ...newBatch, unit: e.target.value })}
                      required
                    >
                      <option value="Liters">Liters</option>
                      <option value="Grams">Grams</option>
                      <option value="Kilograms">Kilograms</option>
                      <option value="Gallons">Gallons</option>
                    </select>
                  </div>
                  <div className="form-group">
                    <label className="form-label">Expiration Date *</label>
                    <input
                      type="date"
                      className="form-control"
                      value={newBatch.expirationDate}
                      onChange={(e) => setNewBatch({ ...newBatch, expirationDate: e.target.value })}
                      required
                    />
                  </div>
                </div>

                <button type="submit" className="btn btn-primary">Save to Inventory</button>
              </form>
            </div>
          )}

          <div className="table-wrapper">
            <table className="data-table">
              <thead>
                <tr>
                  <th>GTIN</th>
                  <th>Product</th>
                  <th>Lot Number</th>
                  <th>Expiration Date</th>
                  <th style={{ textAlign: 'right' }}>Initial Qty</th>
                  <th style={{ textAlign: 'right' }}>Remaining Stock</th>
                  <th>Unit</th>
                </tr>
              </thead>
              <tbody>
                {batches.length === 0 ? (
                  <tr>
                    <td colSpan={7} style={{ textAlign: 'center', color: 'var(--text-muted)' }}>
                      No inventory batches registered. Click "+ Register Inventory Lot" to add one.
                    </td>
                  </tr>
                ) : (
                  batches.map(b => {
                    const prod = products.find(p => p.gtin === b.gtin);
                    const isLowStock = (b.remainingQuantity || 0) < 15;
                    return (
                      <tr key={`${b.gtin}-${b.lotNumber}`}>
                        <td className="mono">{b.gtin}</td>
                        <td><strong>{prod?.name || 'Unrecognized Product'}</strong></td>
                        <td className="mono">{b.lotNumber}</td>
                        <td>{b.expirationDate ? format(new Date(b.expirationDate), 'yyyy-MM-dd') : 'N/A'}</td>
                        <td style={{ textAlign: 'right' }}>{b.initialQuantity?.toFixed(2)}</td>
                        <td style={{ textAlign: 'right', fontWeight: 'bold', color: isLowStock ? 'var(--color-danger)' : 'var(--accent-primary)' }}>
                          {b.remainingQuantity?.toFixed(2)}
                        </td>
                        <td>{b.unit}</td>
                      </tr>
                    );
                  })
                )}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {/* TABS 2: Chemicals Catalog (Override approved chemicals) */}
      {activeTab === 'chemicals' && (
        <div>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '20px' }}>
            <h2>Approved Chemical & Fertilizer Catalog</h2>
            <button className="btn btn-primary" onClick={() => { setEditingProduct(null); setShowProductForm(!showProductForm); }}>
              {showProductForm ? 'Close Form' : '+ Add New Product'}
            </button>
          </div>

          {(showProductForm || editingProduct) && (
            <div className="glass-card">
              <h3>{editingProduct ? 'Override Product Specifications' : 'Add New Agricultural Input'}</h3>
              <form onSubmit={handleSaveProduct} style={{ marginTop: '20px' }}>
                <div className="form-row">
                  <div className="form-group">
                    <label className="form-label">Product Name *</label>
                    <input
                      type="text"
                      className="form-control"
                      placeholder="e.g. CropShield Neem Oil"
                      value={editingProduct ? editingProduct.name : newProduct.name}
                      onChange={(e) => editingProduct 
                        ? setEditingProduct({ ...editingProduct, name: e.target.value })
                        : setNewProduct({ ...newProduct, name: e.target.value })}
                      required
                    />
                  </div>
                  <div className="form-group">
                    <label className="form-label">Type *</label>
                    <select
                      className="form-control"
                      value={editingProduct ? editingProduct.type : newProduct.type}
                      onChange={(e) => editingProduct
                        ? setEditingProduct({ ...editingProduct, type: e.target.value })
                        : setNewProduct({ ...newProduct, type: e.target.value })}
                      required
                    >
                      <option value="CROP">Crop (Harvestable)</option>
                      <option value="PESTICIDE">Pesticide</option>
                      <option value="HERBICIDE">Herbicide</option>
                      <option value="FERTILIZER">Fertilizer</option>
                      <option value="CHEMICAL">General Chemical</option>
                    </select>
                  </div>
                </div>

                <div className="form-row">
                  <div className="form-group">
                    <label className="form-label">GTIN *</label>
                    <div style={{ display: 'flex', gap: '10px' }}>
                      <input
                        type="text"
                        className="form-control"
                        placeholder="14-digit Global Trade Item Number"
                        value={editingProduct ? editingProduct.gtin : newProduct.gtin}
                        onChange={(e) => editingProduct
                          ? setEditingProduct({ ...editingProduct, gtin: e.target.value })
                          : setNewProduct({ ...newProduct, gtin: e.target.value })}
                        required
                      />
                      <button
                        type="button"
                        className="btn btn-secondary"
                        style={{ whiteSpace: 'nowrap' }}
                        onClick={() => handleGenerateLocalGtin(!!editingProduct)}
                      >
                        Generate Local GTIN
                      </button>
                    </div>
                  </div>
                  <div className="form-group">
                    <label className="form-label">Variety / Brand</label>
                    <input
                      type="text"
                      className="form-control"
                      placeholder="e.g. Premium Concentrated"
                      value={(editingProduct ? editingProduct.variety : newProduct.variety) || ''}
                      onChange={(e) => editingProduct
                        ? setEditingProduct({ ...editingProduct, variety: e.target.value })
                        : setNewProduct({ ...newProduct, variety: e.target.value })}
                    />
                  </div>
                </div>

                {/* Chemical specific fields */}
                {['PESTICIDE', 'HERBICIDE', 'FERTILIZER', 'CHEMICAL'].includes((editingProduct ? editingProduct.type : newProduct.type) || '') && (
                  <>
                    <div className="form-row">
                      <div className="form-group">
                        <label className="form-label">EPA Registration Number</label>
                        <input
                          type="text"
                          className="form-control"
                          placeholder="e.g. 12345-67-89"
                          value={(editingProduct ? editingProduct.epaRegistrationNumber : newProduct.epaRegistrationNumber) || ''}
                          onChange={(e) => editingProduct
                            ? setEditingProduct({ ...editingProduct, epaRegistrationNumber: e.target.value })
                            : setNewProduct({ ...newProduct, epaRegistrationNumber: e.target.value })}
                        />
                      </div>
                      <div className="form-group">
                        <label className="form-label">Active Ingredients</label>
                        <input
                          type="text"
                          className="form-control"
                          placeholder="e.g. Azadirachtin 4.5%"
                          value={(editingProduct ? editingProduct.activeIngredients : newProduct.activeIngredients) || ''}
                          onChange={(e) => editingProduct
                            ? setEditingProduct({ ...editingProduct, activeIngredients: e.target.value })
                            : setNewProduct({ ...newProduct, activeIngredients: e.target.value })}
                        />
                      </div>
                    </div>

                    <div className="form-row">
                      <div className="form-group">
                        <label className="form-label">Re-Entry Interval (REI Hours)</label>
                        <input
                          type="number"
                          className="form-control"
                          value={(editingProduct ? editingProduct.reiHours : newProduct.reiHours) ?? 0}
                          onChange={(e) => editingProduct
                            ? setEditingProduct({ ...editingProduct, reiHours: Number(e.target.value) })
                            : setNewProduct({ ...newProduct, reiHours: Number(e.target.value) })}
                        />
                      </div>
                      <div className="form-group">
                        <label className="form-label">Pre-Harvest Interval (PHI Days)</label>
                        <input
                          type="number"
                          className="form-control"
                          value={(editingProduct ? editingProduct.phiDays : newProduct.phiDays) ?? 0}
                          onChange={(e) => editingProduct
                            ? setEditingProduct({ ...editingProduct, phiDays: Number(e.target.value) })
                            : setNewProduct({ ...newProduct, phiDays: Number(e.target.value) })}
                        />
                      </div>
                      <div className="form-group">
                        <label className="form-label">Local Only (No Global Registry)</label>
                        <select
                          className="form-control"
                          value={(editingProduct ? editingProduct.isLocalOnly : newProduct.isLocalOnly) ? 'true' : 'false'}
                          onChange={(e) => editingProduct
                            ? setEditingProduct({ ...editingProduct, isLocalOnly: e.target.value === 'true' })
                            : setNewProduct({ ...newProduct, isLocalOnly: e.target.value === 'true' })}
                        >
                          <option value="false">No (Synced to global)</option>
                          <option value="true">Yes (Local only)</option>
                        </select>
                      </div>
                    </div>
                  </>
                )}

                <div className="form-group">
                  <label className="form-label">Admin Override Notes</label>
                  <textarea
                    className="form-control"
                    rows={2}
                    value={(editingProduct ? editingProduct.adminNotes : newProduct.adminNotes) || ''}
                    onChange={(e) => editingProduct
                      ? setEditingProduct({ ...editingProduct, adminNotes: e.target.value })
                      : setNewProduct({ ...newProduct, adminNotes: e.target.value })}
                  />
                </div>

                <div style={{ display: 'flex', gap: '10px' }}>
                  <button type="submit" className="btn btn-primary">Save Specifications</button>
                  <button type="button" className="btn btn-secondary" onClick={() => { setEditingProduct(null); setShowProductForm(false); }}>
                    Cancel
                  </button>
                </div>
              </form>
            </div>
          )}

          <div className="table-wrapper">
            <table className="data-table">
              <thead>
                <tr>
                  <th>GTIN</th>
                  <th>Product Name</th>
                  <th>Type</th>
                  <th>EPA Registration</th>
                  <th>REI (Hrs)</th>
                  <th>PHI (Days)</th>
                  <th>Active Ingredients</th>
                  <th>Origin</th>
                  <th style={{ textAlign: 'right' }}>Actions</th>
                </tr>
              </thead>
              <tbody>
                {products.map(p => (
                  <tr key={p.id}>
                    <td className="mono">{p.gtin}</td>
                    <td>
                      <strong>{p.name}</strong>
                      {p.variety && <div style={{ fontSize: '12px', color: 'var(--text-secondary)' }}>{p.variety}</div>}
                    </td>
                    <td>
                      <span className={`badge ${p.type === 'CROP' ? 'badge-info' : 'badge-warning'}`}>
                        {p.type}
                      </span>
                    </td>
                    <td>{p.epaRegistrationNumber || 'N/A'}</td>
                    <td>{p.reiHours ?? 0} hrs</td>
                    <td>{p.phiDays ?? 0} days</td>
                    <td style={{ maxWidth: '180px', textOverflow: 'ellipsis', overflow: 'hidden', whiteSpace: 'nowrap' }}>
                      {p.activeIngredients || 'N/A'}
                    </td>
                    <td>
                      <span className={`badge ${p.isLocalOnly ? 'badge-danger' : 'badge-success'}`}>
                        {p.isLocalOnly ? 'Local' : 'Global'}
                      </span>
                    </td>
                    <td style={{ textAlign: 'right' }}>
                      <button className="btn btn-secondary" style={{ padding: '6px 12px', fontSize: '13px' }} onClick={() => setEditingProduct(p)}>
                        Override / Edit
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {/* TABS 4: Log Activity Directly */}
      {activeTab === 'log-activity' && (
        <div>
          <h2>Record Farm Activity Directly</h2>
          <p className="subtitle" style={{ marginBottom: '20px' }}>Log worker or supervisor activities directly to ensure complete traceability.</p>

          <div className="glass-card">
            <h3>Record Activity Details</h3>
            <form onSubmit={handleSaveActivity} style={{ marginTop: '20px' }}>
              <div className="form-row">
                <div className="form-group">
                  <label className="form-label">Activity Type *</label>
                  <select
                    className="form-control"
                    value={newActivity.type}
                    onChange={(e) => setNewActivity({ ...newActivity, type: e.target.value as any })}
                    required
                  >
                    <option value="SPRAYING">Spraying (Pesticide/Herbicide)</option>
                    <option value="HARVESTING">Harvesting</option>
                    <option value="PLANTING">Planting</option>
                    <option value="INSPECTION">Inspection</option>
                    <option value="CLEANING">Cleaning / Sanitation</option>
                    <option value="DIRECT_SALE">Direct Sale</option>
                  </select>
                </div>
                <div className="form-group">
                  <label className="form-label">Location / Plot *</label>
                  <select
                    className="form-control"
                    value={newActivity.locationId}
                    onChange={(e) => setNewActivity({ ...newActivity, locationId: e.target.value })}
                    required
                  >
                    <option value="">-- Select Location --</option>
                    {locations.map((loc) => (
                      <option key={loc.id} value={loc.id}>
                        {loc.name} ({loc.gln})
                      </option>
                    ))}
                  </select>
                </div>
              </div>

              <div className="form-row">
                <div className="form-group">
                  <label className="form-label">Operator (Worker username) *</label>
                  <input
                    type="text"
                    className="form-control"
                    placeholder="e.g. worker_1 or supervisor"
                    value={newActivity.userId}
                    onChange={(e) => setNewActivity({ ...newActivity, userId: e.target.value })}
                    required
                  />
                </div>
                <div className="form-group">
                  <label className="form-label">GPS Latitude</label>
                  <input
                    type="number"
                    step="0.000001"
                    className="form-control"
                    value={newActivity.gpsLat ?? ''}
                    onChange={(e) => setNewActivity({ ...newActivity, gpsLat: Number(e.target.value) })}
                  />
                </div>
                <div className="form-group">
                  <label className="form-label">GPS Longitude</label>
                  <input
                    type="number"
                    step="0.000001"
                    className="form-control"
                    value={newActivity.gpsLng ?? ''}
                    onChange={(e) => setNewActivity({ ...newActivity, gpsLng: Number(e.target.value) })}
                  />
                </div>
              </div>

              {/* Chemical Spraying Specific Fields */}
              {newActivity.type === 'SPRAYING' && (
                <div style={{ padding: '15px', border: '1px solid var(--border-color)', borderRadius: '8px', background: 'rgba(255,255,255,0.01)', marginBottom: '20px' }}>
                  <h4 style={{ color: 'var(--accent-primary)', marginBottom: '15px' }}>Spraying Details</h4>
                  <div className="form-row">
                    <div className="form-group">
                      <label className="form-label">Chemical Product *</label>
                      <select
                        className="form-control"
                        value={newActivity.productId}
                        onChange={(e) => setNewActivity({ ...newActivity, productId: e.target.value })}
                        required
                      >
                        <option value="">-- Select Product --</option>
                        {products
                          .filter((p) => ['PESTICIDE', 'HERBICIDE', 'CHEMICAL'].includes(p.type || ''))
                          .map((p) => (
                            <option key={p.id} value={p.id}>
                              {p.name} (GTIN: {p.gtin})
                            </option>
                          ))}
                      </select>
                    </div>
                    <div className="form-group">
                      <label className="form-label">Lot Number *</label>
                      <input
                        type="text"
                        className="form-control"
                        placeholder="e.g. LOT-AB-12"
                        value={newActivity.chemicalLotNumber}
                        onChange={(e) => setNewActivity({ ...newActivity, chemicalLotNumber: e.target.value })}
                        required
                      />
                    </div>
                    <div className="form-group">
                      <label className="form-label">Expiration Date *</label>
                      <input
                        type="date"
                        className="form-control"
                        value={newActivity.chemicalExpirationDate}
                        onChange={(e) => setNewActivity({ ...newActivity, chemicalExpirationDate: e.target.value })}
                        required
                      />
                    </div>
                  </div>

                  <div className="form-row">
                    <div className="form-group">
                      <label className="form-label">Application Rate (e.g. 2L/Acre)</label>
                      <input
                        type="text"
                        className="form-control"
                        placeholder="e.g. 1.5 Liters/Acre"
                        value={newActivity.applicationRate}
                        onChange={(e) => setNewActivity({ ...newActivity, applicationRate: e.target.value })}
                      />
                    </div>
                    <div className="form-group">
                      <label className="form-label">Total Quantity Applied (Liters) *</label>
                      <input
                        type="number"
                        step="0.01"
                        className="form-control"
                        placeholder="e.g. 50"
                        value={newActivity.totalQuantityApplied ?? ''}
                        onChange={(e) => setNewActivity({ ...newActivity, totalQuantityApplied: Number(e.target.value) })}
                        required
                      />
                    </div>
                    <div className="form-group">
                      <label className="form-label">Applicator License</label>
                      <input
                        type="text"
                        className="form-control"
                        placeholder="e.g. EPA-LIC-9988"
                        value={newActivity.applicatorLicense}
                        onChange={(e) => setNewActivity({ ...newActivity, applicatorLicense: e.target.value })}
                      />
                    </div>
                  </div>

                  <div className="form-row">
                    <div className="form-group">
                      <label className="form-label">Wind Speed (km/h)</label>
                      <input
                        type="number"
                        step="0.1"
                        className="form-control"
                        placeholder="e.g. 12.5"
                        value={newActivity.weatherWindSpeed ?? ''}
                        onChange={(e) => setNewActivity({ ...newActivity, weatherWindSpeed: Number(e.target.value) })}
                      />
                    </div>
                    <div className="form-group">
                      <label className="form-label">Wind Direction</label>
                      <input
                        type="text"
                        className="form-control"
                        placeholder="e.g. NNW"
                        value={newActivity.weatherWindDirection}
                        onChange={(e) => setNewActivity({ ...newActivity, weatherWindDirection: e.target.value })}
                      />
                    </div>
                    <div className="form-group">
                      <label className="form-label">Temperature (°C)</label>
                      <input
                        type="number"
                        step="0.1"
                        className="form-control"
                        placeholder="e.g. 24.5"
                        value={newActivity.weatherTemperature ?? ''}
                        onChange={(e) => setNewActivity({ ...newActivity, weatherTemperature: Number(e.target.value) })}
                      />
                    </div>
                  </div>
                </div>
              )}

              {/* Harvesting / Direct Sale specific fields */}
              {['HARVESTING', 'DIRECT_SALE'].includes(newActivity.type || '') && (
                <div style={{ padding: '15px', border: '1px solid var(--border-color)', borderRadius: '8px', background: 'rgba(255,255,255,0.01)', marginBottom: '20px' }}>
                  <h4 style={{ color: 'var(--accent-primary)', marginBottom: '15px' }}>Crop / Sale Details</h4>
                  <div className="form-row">
                    <div className="form-group">
                      <label className="form-label">Harvested Crop Product *</label>
                      <select
                        className="form-control"
                        value={newActivity.productId}
                        onChange={(e) => setNewActivity({ ...newActivity, productId: e.target.value })}
                        required
                      >
                        <option value="">-- Select Product --</option>
                        {products
                          .filter((p) => p.type === 'CROP')
                          .map((p) => (
                            <option key={p.id} value={p.id}>
                              {p.name} ({p.variety || 'N/A'})
                            </option>
                          ))}
                      </select>
                    </div>
                    <div className="form-group">
                      <label className="form-label">Quantity *</label>
                      <input
                        type="number"
                        className="form-control"
                        placeholder="e.g. 100"
                        value={newActivity.quantity ?? ''}
                        onChange={(e) => setNewActivity({ ...newActivity, quantity: Number(e.target.value) })}
                        required
                      />
                    </div>
                  </div>

                  {newActivity.type === 'DIRECT_SALE' && (
                    <>
                      <div className="form-row">
                        <div className="form-group">
                          <label className="form-label">Unit Price ($) *</label>
                          <input
                            type="number"
                            step="0.01"
                            className="form-control"
                            value={newActivity.unitPrice ?? ''}
                            onChange={(e) => setNewActivity({ ...newActivity, unitPrice: Number(e.target.value) })}
                            required
                          />
                        </div>
                        <div className="form-group">
                          <label className="form-label">Total Price ($) *</label>
                          <input
                            type="number"
                            step="0.01"
                            className="form-control"
                            value={newActivity.totalPrice ?? ''}
                            onChange={(e) => setNewActivity({ ...newActivity, totalPrice: Number(e.target.value) })}
                            required
                          />
                        </div>
                      </div>

                      <div className="form-row">
                        <div className="form-group">
                          <label className="form-label">Customer Name</label>
                          <input
                            type="text"
                            className="form-control"
                            value={newActivity.customerName || ''}
                            onChange={(e) => setNewActivity({ ...newActivity, customerName: e.target.value })}
                          />
                        </div>
                        <div className="form-group">
                          <label className="form-label">Customer Phone</label>
                          <input
                            type="text"
                            className="form-control"
                            value={newActivity.customerPhone || ''}
                            onChange={(e) => setNewActivity({ ...newActivity, customerPhone: e.target.value })}
                          />
                        </div>
                        <div className="form-group">
                          <label className="form-label">Customer Email</label>
                          <input
                            type="email"
                            className="form-control"
                            value={newActivity.customerEmail || ''}
                            onChange={(e) => setNewActivity({ ...newActivity, customerEmail: e.target.value })}
                          />
                        </div>
                      </div>
                    </>
                  )}
                </div>
              )}

              <div className="form-group">
                <label className="form-label">Notes / Instructions</label>
                <textarea
                  className="form-control"
                  rows={3}
                  placeholder="Enter notes, GAP compliance comments, etc..."
                  value={newActivity.notes}
                  onChange={(e) => setNewActivity({ ...newActivity, notes: e.target.value })}
                />
              </div>

              {/* Toggles */}
              <div className="form-row" style={{ alignItems: 'center', marginBottom: '20px' }}>
                <div className="form-group" style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                  <input
                    type="checkbox"
                    id="require-verification"
                    style={{ width: '20px', height: '20px', cursor: 'pointer' }}
                    checked={newActivity.verificationStatus === 'PENDING'}
                    onChange={(e) => setNewActivity({
                      ...newActivity,
                      verificationStatus: e.target.checked ? 'PENDING' : 'VERIFIED'
                    })}
                  />
                  <label htmlFor="require-verification" style={{ cursor: 'pointer', fontWeight: 'bold' }}>
                    Requires Supervisor Verification (Triggers Review Task)
                  </label>
                </div>
              </div>

              <button type="submit" className="btn btn-primary">Save Activity Log</button>
            </form>
          </div>
        </div>
      )}

      {/* TABS 3: Task Reviews (Supervisor signing activities) */}
      {activeTab === 'reviews' && (
        <div>
          <h2>Supervisor Verification Tasks</h2>
          <p className="subtitle" style={{ marginBottom: '20px' }}>Review, sign, and verify spraying activities logged by farm workers.</p>

          {tasks.filter(t => t.status === 'COMPLETED' || (t.assignedTo === 'supervisor' && t.status === 'PENDING')).length === 0 ? (
            <div className="glass-card" style={{ textAlign: 'center', color: 'var(--text-muted)' }}>
              No tasks currently pending supervisor verification.
            </div>
          ) : (
            <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
              {tasks
                .filter(t => t.status === 'COMPLETED' || (t.assignedTo === 'supervisor' && t.status === 'PENDING'))
                .map(task => (
                  <TaskReviewCard
                    key={task.id}
                    task={task}
                    onRefresh={() => queryClient.invalidateQueries({ queryKey: [`/api/v1/tasks/farm/${activeFarmId}`] })}
                  />
                ))}
            </div>
          )}
        </div>
      )}

      {/* TABS 5: Farm Members Management */}
      {activeTab === 'members' && (
        <div style={{ display: 'grid', gridTemplateColumns: isFarmAdmin ? '1fr 2fr' : '1fr', gap: '30px' }}>
          {isFarmAdmin && (
            <div className="glass-card">
              <h3>Invite Member</h3>
              <form onSubmit={async (e) => {
                e.preventDefault();
                if (!inviteEmail.trim() || !activeFarmId) return;
                await assignWorkerMutation.mutateAsync({ farmId: activeFarmId, email: inviteEmail, role: inviteRole });
                setInviteEmail('');
              }} style={{ marginTop: '20px' }}>
                <div className="form-group">
                  <label className="form-label">Email Address</label>
                  <input
                    type="email"
                    className="form-control"
                    placeholder="e.g. member@domain.com"
                    value={inviteEmail}
                    onChange={(e) => setInviteEmail(e.target.value)}
                    required
                  />
                </div>
                <div className="form-group">
                  <label className="form-label">Role</label>
                  <select
                    className="form-control"
                    value={inviteRole}
                    onChange={(e) => setInviteRole(e.target.value)}
                  >
                    <option value="WORKER">Worker</option>
                    <option value="ADMIN">Admin</option>
                    <option value="READONLY">Read-Only</option>
                  </select>
                </div>
                <button type="submit" className="btn btn-primary" style={{ width: '100%' }} disabled={assignWorkerMutation.isPending}>
                  {assignWorkerMutation.isPending ? 'Inviting...' : 'Invite to Farm'}
                </button>
              </form>
            </div>
          )}

          <div className="glass-card">
            <h3>Farm Members List</h3>
            <div style={{ marginTop: '20px' }}>
              <div className="table-wrapper">
                <table className="data-table">
                  <thead>
                    <tr>
                      <th>Email / Username</th>
                      <th>Role</th>
                      {isFarmAdmin && <th style={{ textAlign: 'right' }}>Actions</th>}
                    </tr>
                  </thead>
                  <tbody>
                    {farmWorkers.length === 0 ? (
                      <tr>
                        <td colSpan={isFarmAdmin ? 3 : 2} style={{ textAlign: 'center', color: '#64748b' }}>
                          No members registered.
                        </td>
                      </tr>
                    ) : (
                      farmWorkers.map((fw) => {
                        const isOwner = activeFarm?.ownerId === fw.email;
                        return (
                          <tr key={fw.email}>
                            <td>
                              <strong>{fw.email}</strong>
                              {isOwner && <span className="badge badge-info" style={{ marginLeft: '10px' }}>Owner</span>}
                            </td>
                            <td>
                              {isFarmAdmin && !isOwner ? (
                                <select
                                  value={fw.role}
                                  onChange={(e) => {
                                    updateWorkerRoleMutation.mutate({ farmId: activeFarmId || '', email: fw.email, role: e.target.value });
                                  }}
                                  className="form-control"
                                  style={{ padding: '4px 8px', fontSize: '13px', width: 'fit-content' }}
                                >
                                  <option value="WORKER">WORKER</option>
                                  <option value="ADMIN">ADMIN</option>
                                  <option value="READONLY">READONLY</option>
                                </select>
                              ) : (
                                <span className={`badge ${fw.role === 'ADMIN' ? 'badge-danger' : fw.role === 'READONLY' ? 'badge-success' : 'badge-info'}`}>
                                  {fw.role}
                                </span>
                              )}
                            </td>
                            {isFarmAdmin && (
                              <td style={{ textAlign: 'right' }}>
                                {!isOwner && (
                                  <button
                                    onClick={() => {
                                      if (window.confirm(`Remove ${fw.email} from this farm?`)) {
                                        unassignWorkerMutation.mutate({ farmId: activeFarmId || '', email: fw.email });
                                      }
                                    }}
                                    className="btn btn-danger"
                                    style={{ padding: '6px 12px', fontSize: '12px' }}
                                    disabled={unassignWorkerMutation.isPending}
                                  >
                                    Remove
                                  </button>
                                )}
                              </td>
                            )}
                          </tr>
                        );
                      })
                    )}
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

function TaskReviewCard({ task, onRefresh }: { task: any; onRefresh: () => void }) {
  // 1. Check if description has Activity Log ID
  const activityLogIdMatch = task.description?.match(/Activity Log ID:\s*([a-f0-9-]{36})/i);
  const parsedActivityId = activityLogIdMatch ? activityLogIdMatch[1] : null;

  // 2. Fetch Activity Log by parsed UUID (if supervisor task) or by taskId (if worker task)
  const activityLogQuery = useGetApiV1ActivityLogsId(parsedActivityId || '', {
    query: { enabled: !!parsedActivityId } as any
  });

  const taskActivityQuery = useGetApiV1ActivityLogsTaskTaskId(task.id || '', {
    query: { enabled: !parsedActivityId && !!task.id } as any
  });

  const activityLog = parsedActivityId ? activityLogQuery.data?.data : taskActivityQuery.data?.data;
  const isActivityLoading = parsedActivityId ? activityLogQuery.isLoading : taskActivityQuery.isLoading;

  // 3. Fetch Media for the activity log
  const mediaQuery = useGetApiV1MediaActivityActivityLogId(activityLog?.id || '', {
    query: { enabled: !!activityLog?.id } as any
  });
  const mediaList = mediaQuery.data?.data || [];

  // Mutations
  const updateTaskStatusMutation = usePatchApiV1TasksIdStatus();
  const updateActivityLogMutation = usePutApiV1ActivityLogs();

  const handleReview = async (status: 'REVIEWED' | 'PENDING') => {
    try {
      // Step A: Update current task status (e.g. supervisor task or worker task)
      await updateTaskStatusMutation.mutateAsync({
        id: task.id!,
        params: { status }
      });

      // Step B: Update corresponding Activity Log status to VERIFIED or keep PENDING/REJECTED
      if (activityLog) {
        await updateActivityLogMutation.mutateAsync({
          data: {
            ...activityLog,
            verificationStatus: status === 'REVIEWED' ? 'VERIFIED' : 'PENDING',
            verifiedBy: 'supervisor',
            verifiedAt: new Date().toISOString()
          }
        });

        // Step C: If this was a supervisor verification task and there is a linked worker task, update worker task to REVIEWED as well!
        if (activityLog.taskId && activityLog.taskId !== task.id) {
          await updateTaskStatusMutation.mutateAsync({
            id: activityLog.taskId,
            params: { status }
          });
        }
      }

      alert(`Activity successfully marked as ${status === 'REVIEWED' ? 'Approved' : 'Pending'}.`);
      onRefresh();
    } catch (err) {
      alert('Failed to update review status: ' + err);
    }
  };

  return (
    <div className="glass-card" style={{ marginBottom: '16px' }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '12px' }}>
        <div>
          <h3>{task.title}</h3>
          <p style={{ color: 'var(--text-secondary)', fontSize: '14px', marginTop: '4px' }}>
            Assigned To: <strong>{task.assignedTo}</strong> | Due Date: {task.dueDate ? format(new Date(task.dueDate), 'MMM dd, yyyy') : 'N/A'}
          </p>
        </div>
        <span className={`badge ${task.status === 'COMPLETED' ? 'badge-warning' : 'badge-success'}`}>
          {task.status}
        </span>
      </div>

      <div style={{ background: 'rgba(255,255,255,0.02)', padding: '16px', borderRadius: '8px', border: '1px solid var(--border-color)', marginBottom: '16px' }}>
        <strong>Task Description:</strong>
        <p style={{ marginTop: '6px', color: 'var(--text-primary)', fontSize: '14px' }}>{task.description}</p>
      </div>

      {isActivityLoading && <div style={{ color: 'var(--text-secondary)' }}>Loading activity log details...</div>}

      {activityLog && (
        <div style={{ background: 'rgba(255,255,255,0.01)', padding: '16px', borderRadius: '8px', border: '1px solid var(--border-color)', marginBottom: '16px' }}>
          <h4 style={{ marginBottom: '10px', color: 'var(--accent-primary)' }}>Logged Farm Activity Details</h4>
          <div className="form-row" style={{ fontSize: '14px', gap: '20px', display: 'flex' }}>
            <div><strong>Type:</strong> {activityLog.type}</div>
            <div><strong>Recorded By:</strong> {activityLog.userId}</div>
            <div><strong>Timestamp:</strong> {activityLog.timestamp ? format(new Date(activityLog.timestamp), 'yyyy-MM-dd HH:mm') : 'N/A'}</div>
          </div>
          <div className="form-row" style={{ fontSize: '14px', marginTop: '8px', gap: '20px', display: 'flex' }}>
            <div><strong>GPS Lat/Lng:</strong> {activityLog.gpsLat?.toFixed(6)}, {activityLog.gpsLng?.toFixed(6)}</div>
            {activityLog.chemicalLotNumber && <div><strong>Lot Number:</strong> {activityLog.chemicalLotNumber}</div>}
            {activityLog.totalQuantityApplied !== undefined && <div><strong>Qty Applied:</strong> {activityLog.totalQuantityApplied} liters</div>}
          </div>
          {activityLog.weatherWindSpeed !== undefined && (
            <div className="form-row" style={{ fontSize: '14px', marginTop: '8px', gap: '20px', display: 'flex' }}>
              <div><strong>Wind:</strong> {activityLog.weatherWindSpeed} km/h {activityLog.weatherWindDirection}</div>
              <div><strong>Temp:</strong> {activityLog.weatherTemperature}°C</div>
            </div>
          )}
          {activityLog.notes && (
            <div style={{ marginTop: '10px', fontSize: '14px' }}>
              <strong>Worker Notes:</strong> {activityLog.notes}
            </div>
          )}

          {/* Media Evidence Render */}
          <div style={{ marginTop: '16px' }}>
            <strong>Evidence Attachment:</strong>
            {mediaList.length === 0 ? (
              <p style={{ color: 'var(--text-muted)', fontSize: '13px', marginTop: '4px' }}>No photo/video evidence attached.</p>
            ) : (
              <div style={{ display: 'flex', gap: '12px', flexWrap: 'wrap', marginTop: '8px' }}>
                {mediaList.map((media: any) => (
                  <div key={media.id} style={{ border: '1px solid var(--border-color)', borderRadius: '8px', padding: '8px', background: 'rgba(255,255,255,0.02)', maxWidth: '240px' }}>
                    {media.mediaType === 'IMAGE' ? (
                      <img src={media.mediaUrl} alt="Evidence photo" style={{ width: '100%', height: '150px', objectFit: 'cover', borderRadius: '4px' }} />
                    ) : (
                      <video src={media.mediaUrl} controls style={{ width: '100%', height: '150px', borderRadius: '4px' }} />
                    )}
                    <div style={{ fontSize: '11px', color: 'var(--text-secondary)', marginTop: '6px' }}>
                      Captured: {media.timestamp ? format(new Date(media.timestamp), 'yyyy-MM-dd HH:mm') : 'N/A'}<br/>
                      GPS: {media.capturedGpsLat?.toFixed(4)}, {media.capturedGpsLng?.toFixed(4)}
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>
        </div>
      )}

      <div style={{ display: 'flex', justifyContent: 'flex-end', gap: '10px' }}>
        <button
          className="btn btn-secondary"
          onClick={() => handleReview('PENDING')}
        >
          Reject / Request Re-record
        </button>
        <button
          className="btn btn-primary"
          onClick={() => handleReview('REVIEWED')}
        >
          Sign Off & Approve
        </button>
      </div>
    </div>
  );
}

