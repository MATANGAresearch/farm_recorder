import { MapContainer, TileLayer, Polygon, Marker, Popup } from 'react-leaflet';
import { useGetApiV1Locations } from '../../api/locations/locations';
import { useGetApiV1ActivityLogsLocationLocationId } from '../../api/activity-logs/activity-logs';
import { LatLngExpression } from 'leaflet';

// Helper to parse GeoJSON polygon coordinates to Leaflet [lat, lng] format
const parsePolygon = (geoJson: string): LatLngExpression[] => {
  try {
    const parsed = JSON.parse(geoJson);
    return parsed.coordinates[0].map((coord: number[]) => [coord[1], coord[0]]);
  } catch {
    return [];
  }
};

export default function FarmMap() {
  // Fetch locations from live backend
  const { data: locationsResponse, isLoading: locationsLoading } = useGetApiV1Locations();
  const locations = locationsResponse?.data;

  // For demonstration, we fetch activities for the first location
  const firstLocationId = locations?.[0]?.id || '';
  const { data: activitiesResponse } = useGetApiV1ActivityLogsLocationLocationId(
    firstLocationId,
    { query: { enabled: !!firstLocationId } as any }
  );
  const activities = activitiesResponse?.data;

  if (locationsLoading) return <div>Loading map data...</div>;

  return (
    <div style={{ height: '80vh', width: '100%' }}>
      <MapContainer center={[32.05, 35.05]} zoom={13} style={{ height: '100%', width: '100%' }}>
        <TileLayer
          attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        />
        
        {locations?.map(loc => (
          <Polygon 
            key={loc.id} 
            pathOptions={{ color: 'green', fillColor: 'green', fillOpacity: 0.2 }} 
            positions={loc.geoJsonPolygon ? parsePolygon(loc.geoJsonPolygon) : []}
          >
            <Popup>
              <strong>{loc.name}</strong><br/>
              GLN: {loc.gln}<br/>
              Type: {loc.type}
            </Popup>
          </Polygon>
        ))}

        {activities?.map(act => (
          act.gpsLat && act.gpsLng && (
            <Marker key={act.id} position={[act.gpsLat, act.gpsLng]}>
              <Popup>
                <strong>{act.type}</strong><br/>
                {act.timestamp ? new Date(act.timestamp).toLocaleString() : ''}<br/>
                {act.notes}
              </Popup>
            </Marker>
          )
        ))}
      </MapContainer>
    </div>
  );
}
