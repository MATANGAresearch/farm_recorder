import { useState } from 'react';
import { format } from 'date-fns';
import { useGetApiV1Locations } from '../../api/locations/locations';
import { useGetApiV1ActivityLogsLocationLocationId } from '../../api/activity-logs/activity-logs';

export default function GapAuditReport() {
  const [startDate, setStartDate] = useState('');
  const [endDate, setEndDate] = useState('');
  const [selectedLocationId, setSelectedLocationId] = useState<string>('all');

  // Fetch all locations for the dropdown
  const { data: locationsResponse } = useGetApiV1Locations();
  const locations = locationsResponse?.data;

  // Fetch activities for the selected location
  const { data: activitiesResponse, isLoading } = useGetApiV1ActivityLogsLocationLocationId(
    selectedLocationId,
    { query: { enabled: selectedLocationId !== 'all' && selectedLocationId !== '' } as any }
  );
  const activities = activitiesResponse?.data;

  const filteredLogs = (activities || []).filter(log => {
    if (!log.timestamp) return false;
    const logDate = new Date(log.timestamp);
    const start = startDate ? new Date(startDate) : new Date('1970-01-01');
    const end = endDate ? new Date(endDate) : new Date('2099-12-31');
    return logDate >= start && logDate <= end;
  });

  const handleExport = () => {
    const csvContent = [
      ['Date', 'Location', 'Activity Type', 'GPS Lat', 'GPS Lng', 'GAP Notes'].join(','),
      ...filteredLogs.map(log => {
        const locName = locations?.find(l => l.id === log.locationId)?.name || 'Unknown';
        return [
          log.timestamp ? format(new Date(log.timestamp), 'yyyy-MM-dd HH:mm') : '',
          locName,
          log.type,
          log.gpsLat || '',
          log.gpsLng || '',
          `"${log.notes || ''}"`
        ].join(',');
      })
    ].join('\n');

    const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
    const url = URL.createObjectURL(blob);
    const link = document.createElement('a');
    link.href = url;
    link.setAttribute('download', `gap_audit_report_${format(new Date(), 'yyyy-MM-dd')}.csv`);
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  };

  if (isLoading) return <div>Loading audit data...</div>;

  return (
    <div>
      <h1>GAP Audit Report</h1>
      <p style={{ color: '#666', marginBottom: '20px' }}>
        Filter activities to generate a compliance report for GAP certification audits.
      </p>

      <div style={{ display: 'flex', gap: '15px', marginBottom: '20px', flexWrap: 'wrap' }}>
        <div>
          <label style={{ display: 'block', marginBottom: '5px', fontSize: '14px' }}>Start Date</label>
          <input 
            type="date" 
            value={startDate} 
            onChange={(e) => setStartDate(e.target.value)} 
            style={{ padding: '8px', border: '1px solid #ccc', borderRadius: '4px' }}
          />
        </div>
        <div>
          <label style={{ display: 'block', marginBottom: '5px', fontSize: '14px' }}>End Date</label>
          <input 
            type="date" 
            value={endDate} 
            onChange={(e) => setEndDate(e.target.value)} 
            style={{ padding: '8px', border: '1px solid #ccc', borderRadius: '4px' }}
          />
        </div>
        <div>
          <label style={{ display: 'block', marginBottom: '5px', fontSize: '14px' }}>Location</label>
          <select 
            value={selectedLocationId} 
            onChange={(e) => setSelectedLocationId(e.target.value)}
            style={{ padding: '8px', border: '1px solid #ccc', borderRadius: '4px', minWidth: '150px' }}
          >
            <option value="all">All Locations</option>
            {locations?.map(loc => (
              <option key={loc.id} value={loc.id}>{loc.name} ({loc.gln})</option>
            ))}
          </select>
        </div>
        <div style={{ display: 'flex', alignItems: 'flex-end' }}>
          <button 
            onClick={handleExport}
            disabled={filteredLogs.length === 0}
            style={{ 
              padding: '9px 16px', 
              background: filteredLogs.length === 0 ? '#ccc' : '#16a34a', 
              color: 'white', 
              border: 'none', 
              borderRadius: '4px', 
              cursor: filteredLogs.length === 0 ? 'not-allowed' : 'pointer',
              fontWeight: 'bold'
            }}
          >
            Export CSV
          </button>
        </div>
      </div>

      <table style={{ width: '100%', borderCollapse: 'collapse', marginTop: '10px' }}>
        <thead>
          <tr style={{ background: '#f4f4f5', textAlign: 'left' }}>
            <th style={{ padding: '12px', borderBottom: '2px solid #e4e4e7' }}>Date & Time</th>
            <th style={{ padding: '12px', borderBottom: '2px solid #e4e4e7' }}>Location</th>
            <th style={{ padding: '12px', borderBottom: '2px solid #e4e4e7' }}>Activity</th>
            <th style={{ padding: '12px', borderBottom: '2px solid #e4e4e7' }}>GPS Coordinates</th>
            <th style={{ padding: '12px', borderBottom: '2px solid #e4e4e7' }}>GAP Notes</th>
          </tr>
        </thead>
        <tbody>
          {selectedLocationId === 'all' || filteredLogs.length === 0 ? (
            <tr>
              <td colSpan={5} style={{ padding: '20px', textAlign: 'center', color: '#666' }}>
                {selectedLocationId === 'all' ? 'Please select a specific location to view activities.' : 'No activities found for the selected filters.'}
              </td>
            </tr>
          ) : (
            filteredLogs.map(log => {
              const locName = locations?.find(l => l.id === log.locationId)?.name || 'Unknown';
              return (
                <tr key={log.id} style={{ borderBottom: '1px solid #e4e4e7' }}>
                  <td style={{ padding: '12px' }}>{log.timestamp ? format(new Date(log.timestamp), 'yyyy-MM-dd HH:mm') : ''}</td>
                  <td style={{ padding: '12px' }}>{locName}</td>
                  <td style={{ padding: '12px' }}>
                    <span style={{ 
                      background: '#e0f2fe', 
                      color: '#0369a1', 
                      padding: '4px 8px', 
                      borderRadius: '4px',
                      fontSize: '12px',
                      fontWeight: 'bold'
                    }}>
                      {log.type}
                    </span>
                  </td>
                  <td style={{ padding: '12px', fontFamily: 'monospace', fontSize: '13px' }}>
                    {log.gpsLat?.toFixed(5)}, {log.gpsLng?.toFixed(5)}
                  </td>
                  <td style={{ padding: '12px', maxWidth: '300px', fontSize: '14px' }}>
                    {log.notes}
                  </td>
                </tr>
              );
            })
          )}
        </tbody>
      </table>
    </div>
  );
}
