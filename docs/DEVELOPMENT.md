# Development & Troubleshooting Guide

This guide provides instructions for daily development, testing, and troubleshooting the Farm Recorder monorepo.

## 1. Daily Development Workflow

### Starting the Stack
Always start the infrastructure first, then the backend, then the frontend/mobile apps.

```bash
# 1. Start Docker containers (Postgres, MinIO, Keycloak)
npm run infra:up

# 2. Start Quarkus backend in dev mode (hot reload enabled)
npm run backend:dev

# 3. In a new terminal, generate API clients (run this whenever backend endpoints change)
npm run generate:clients

# 4. Start React web dashboard
cd apps/web && npm run dev

# 5. Start Flutter mobile app
cd apps/mobile && flutter run
```

### Stopping the Stack
```bash
npm run infra:down
```

## 2. Integration Testing Script

To verify the full mobile-to-backend flow without launching the Flutter app, you can use this `curl` script. It simulates the exact sequence a mobile device would perform:

```bash
#!/bin/bash
echo "=== Farm Recorder Integration Test ==="

# 1. Login and get JWT
echo "1. Authenticating..."
RESPONSE=$(curl -s -X POST http://localhost:8082/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username": "farmuser", "password": "farmpass"}')

TOKEN=$(echo $RESPONSE | grep -o '"access_token":"[^"]*"' | cut -d'"' -f4)
if [ -z "$TOKEN" ]; then
  echo "❌ Login failed. Check Keycloak status."
  exit 1
fi
echo "✅ Login successful. Token: ${TOKEN:0:50}..."

# 2. Create a Location (requires FARM_WORKER role)
echo "2. Creating a test location..."
LOC_RESPONSE=$(curl -s -w "\n%{http_code}" -X POST http://localhost:8082/api/v1/locations \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"gln": "9876543210987", "name": "Test Field", "type": "FIELD", "geoJsonPolygon": "{\"type\":\"Polygon\",\"coordinates\":[[[35.0,32.0],[35.1,32.0],[35.1,32.1],[35.0,32.1],[35.0,32.0]]]}"}')

LOC_CODE=$(echo "$LOC_RESPONSE" | tail -n1)
if [ "$LOC_CODE" == "201" ]; then
  echo "✅ Location created successfully."
  LOC_ID=$(echo "$LOC_RESPONSE" | head -n1 | grep -o '"id":"[^"]*"' | cut -d'"' -f4)
else
  echo "❌ Failed to create location. HTTP $LOC_CODE"
  echo "$LOC_RESPONSE"
fi

# 3. Create an Activity Log (triggers EPCIS mapping)
echo "3. Creating an activity log..."
curl -s -w "\nHTTP Status: %{http_code}\n" -X POST http://localhost:8082/api/v1/activity-logs \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d "{\"timestamp\": \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\", \"locationId\": \"$LOC_ID\", \"type\": \"INSPECTION\", \"notes\": \"GAP compliance check passed\", \"gpsLat\": 32.05, \"gpsLng\": 35.05}"

echo "=== Test Complete ==="
```
*Save this as `test-integration.sh`, make it executable (`chmod +x test-integration.sh`), and run it.*

## 3. Troubleshooting Common Issues

### Quarkus fails to start with `Liquibase validation failed`
**Cause**: You changed a Liquibase changelog file after it was already executed.
**Fix**: Clear the checksums in the database:
```bash
docker exec farm-recorder-db psql -U farmuser -d farmrecorder -c "DELETE FROM public.databasechangelog;"
```
Then restart Quarkus. It will re-apply the migrations.

### `401 Unauthorized` on API requests
**Cause**: The JWT is missing, expired, or lacks the required role.
**Fix**: 
1. Verify the token is being sent: `Authorization: Bearer <token>`
2. Decode the token at [jwt.io](https://jwt.io) and check the `exp` claim.
3. Ensure the user has the `FARM_WORKER` role assigned in Keycloak (see [AUTHENTICATION.md](AUTHENTICATION.md)).

### Flutter app cannot connect to backend
**Cause**: Android emulator uses `10.0.2.2` instead of `localhost` to reach the host machine.
**Fix**: Update `baseUrl` in `MediaService` and `SyncService` to `http://10.0.2.2:8082/api/v1` when running on the Android emulator. (iOS Simulator can still use `localhost`).

### Map not rendering in React
**Cause**: Leaflet CSS is missing or container has no height.
**Fix**: Ensure `import 'leaflet/dist/leaflet.css';` is present in `main.tsx` and the map container has an explicit `height` (e.g., `height: 80vh`).

## 4. Code Generation

Whenever you add or modify a REST endpoint in Quarkus:
1. Ensure Quarkus is running (`npm run backend:dev`).
2. Run `npm run generate:clients`.
3. Commit the generated files in `apps/web/src/api/` and `apps/mobile/lib/api/generated/`.

*Never manually edit the generated API client files, as they will be overwritten.*
