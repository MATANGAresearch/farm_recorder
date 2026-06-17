# GAP Compliance & EPCIS Mapping

This document details how the Farm Recorder system maps internal farm activities to **GS1 EPCIS 2.0** standards for supply chain traceability and GAP (Good Agricultural Practices) certification audits.

## 1. The Traceability Data Model

Every action recorded in the system is stored as an `ActivityLog`. When an activity is saved, the `ActivityLogService` automatically triggers the `EpcisGatewayPort` to generate and publish an EPCIS event.

## 2. EPCIS `ObjectEvent` Mapping

The system generates an EPCIS 2.0 `ObjectEvent` for each activity. Here is how internal data maps to GS1 standards:

| Internal Field | EPCIS 2.0 Element | GS1 Standard / Value |
|----------------|-------------------|----------------------|
| `timestamp` | `eventTime` | ISO 8601 format (e.g., `2024-03-15T10:00:00Z`) |
| N/A | `eventTimeZoneOffset` | Hardcoded to `+02:00` (configurable per farm region) |
| `type` (e.g., SPRAYING) | `bizStep` | `urn:epcglobal:cbv:bizstep:spraying` |
| N/A | `disposition` | `urn:epcglobal:cbv:disp:in_progress` |
| `locationId` (linked to GLN) | `readPoint.id` | `urn:epc:id:sgln:<company_prefix>.<location_ref>.<check_digit>` |
| `productId` (linked to GTIN) | `epcList` | `urn:epc:id:sgtin:<company_prefix>.<item_ref>.<serial>` |
| `gpsLat`, `gpsLng`, `notes` | `extension` | Custom EPCIS 2.0 extension fields for GAP audit evidence |

### Example Generated Payload
```json
{
  "type": "ObjectEvent",
  "eventTime": "2024-03-15T10:00:00Z",
  "eventTimeZoneOffset": "+02:00",
  "bizStep": { "type": "urn:epcglobal:cbv:bizstep:harvesting" },
  "disposition": { "type": "urn:epcglobal:cbv:disp:in_progress" },
  "readPoint": { "id": "urn:epc:id:sgln:0614141.49c546d757e4.0" },
  "extension": {
    "gpsLat": 32.06,
    "gpsLng": 35.06,
    "gapNotes": "Harvested batch #A123, GAP compliant"
  },
  "epcList": [
    "urn:epc:id:sgtin:0614141.1234567890123.0"
  ]
}
```

## 3. GAP Audit Workflow

1. **Field Worker** records an activity (e.g., pesticide application) via the Flutter mobile app, including GPS coordinates and a photo.
2. **Mobile App** uploads the photo to MinIO via a presigned URL and queues the activity log.
3. **Backend** saves the log to PostgreSQL and immediately generates the EPCIS event.
4. **Auditor** logs into the React Web Dashboard, filters activities by date and location (GLN), and exports a CSV report.
5. **Verification**: The CSV report includes GPS coordinates, timestamps, and links to the stored media, providing immutable proof of GAP compliance.

## 4. Future Enhancements

- **Transformation Events**: When harvesting, generate an EPCIS `TransformationEvent` to link the input (bulk crop in the field) to the output (packed cases with SSCC labels).
- **Sensor Data**: Integrate IoT soil/weather sensors and map their readings to EPCIS `SensorElement` extensions.
- **OpenEPCIS Integration**: Uncomment the OpenEPCIS container in `docker-compose.yml` and configure the `EPcis_URL` environment variable to push events to a live traceability network.
