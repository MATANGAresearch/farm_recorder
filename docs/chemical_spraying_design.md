# Chemical Spraying, Barcode Scanning, & Verification Design (GAP Compliance)

This document outlines the end-to-end design for barcode scanning, chemical application logging, environmental tracking, and supervisor verification workflows to meet GAP (Good Agricultural Practices) audit requirements.

---

## 1. Understanding Summary

*   **Goal**: Simplify pesticide/chemical logging for field operators while ensuring strict audit compliance for lot numbers, active ingredients, REI (Re-Entry Interval), PHI (Pre-Harvest Interval), weather (wind speed/direction, temperature), and applicator certification.
*   **Target Users**: Field applicators (workers) recording spray activities and farm administrators (supervisors) managing approvals and auditing logs.
*   **Key Capabilities**:
    *   Offline GS1 barcode parsing (extracting GTIN, Lot, and Expiration) via mobile camera.
    *   Offline safety alerts (REI/PHI) populated from a local cache of expected chemicals.
    *   Asynchronous weather backfilling via background GPS and time-based API lookups.
    *   Administrative override suite (correcting scanned items, lot numbers, weather parameters).
    *   Supervisor verification cycle (auto-creating verification tasks for supervisor sign-offs).
    *   Local barcode generation (with printable QR/Barcode labels) for inputs lacking standard GTINs.

---

## 2. Decision Log

| ID | Decision | Alternatives Considered | Rationale |
| :--- | :--- | :--- | :--- |
| **DEC-01** | **Extend Product Entity** | Create separate `Chemical` entity | Extending the existing `Product` entity with a `type` enum and chemical columns allows maximum code/contract reuse with minimal schema complexity (YAGNI). |
| **DEC-02** | **Hybrid Client-Server Weather** | Real-time mobile lookup only | Performing weather lookups as a background job on the backend using GPS and timestamp handles offline/spotty signal field conditions cleanly. |
| **DEC-03** | **Offline GS1 Parsing** | Server-side parsing only | Parsing GS1 application identifiers locally on-device enables instant offline validation and field worker safety warnings (REI/PHI). |
| **DEC-04** | **Supervisor Verification Tasks**| Generic emails or manual audit checklists | Automating supervisor task assignment upon employee spray completions integrates verification directly into the existing mobile/web dashboard tasks workflow. |
| **DEC-05** | **Private GS1 Prefix Generator** | Custom arbitrary text identifiers only | Standardizing on auto-generated private-range GS1 GTINs keeps the local scanning utility consistent with global GS1 container parsing. |

---

## 3. Assumptions & Non-Functional Requirements

*   **Role Security**: Administrative endpoints (overrides, chemical registry edits, local barcode generation) are secured in the backend by `@RolesAllowed("ADMIN")` roles. Standard operators (`FARM_WORKER`) can only submit and view logs.
*   **Resiliency**: If a background weather fetch fails, the log remains in a `PENDING` validation state with an alarm flag, allowing manual entry by the administrator.
*   **Cache Strategy**: The mobile app caches approved chemicals linked to current tasks during sync to ensure offline warning availability.

---

## 4. Final Design Specification

### 4.1 Database Schema Extensions

#### `products` Table Extensions
*   `type`: VARCHAR (e.g., `CROP`, `PESTICIDE`, `HERBICIDE`, `FUNGICIDE`, `FERTILIZER`).
*   `epa_registration_number`: VARCHAR (EPA/regulatory identity).
*   `active_ingredients`: VARCHAR (active chemicals & percentages).
*   `rei_hours`: INTEGER (safety Re-Entry Interval in hours).
*   `phi_days`: INTEGER (safety Pre-Harvest Interval in days).
*   `is_local_only`: BOOLEAN (flag for admin-generated custom chemicals).
*   `admin_notes`: TEXT (general instructions/comments).

#### `activity_logs` Table Extensions
*   `chemical_lot_number`: VARCHAR (parsed lot/batch).
*   `chemical_expiration_date`: TIMESTAMP (parsed expiration).
*   `application_rate`: VARCHAR (dosage details).
*   `total_quantity_applied`: NUMERIC (volume/mass used).
*   `weather_wind_speed`: NUMERIC (wind speed in km/h or mph).
*   `weather_wind_direction`: VARCHAR (wind direction cardinal string).
*   `weather_temperature`: NUMERIC (temp value).
*   `applicator_license`: VARCHAR (certification reference).
*   `is_manual_input`: BOOLEAN (records if barcode scan was bypassed).
*   `manual_input_comments`: TEXT (reasons for manual input).
*   `verification_status`: VARCHAR (`PENDING`, `VERIFIED`, `AUDITED`).
*   `verified_by` / `verified_at`: VARCHAR / TIMESTAMP (audit signature).
*   `rei_end_time`: TIMESTAMP (calculated `timestamp + rei_hours`).

---

### 4.2 Barcode Scanning & Local GS1 Parser

```
Raw Scan ──► Gs1Parser ──► Extract AIs:
                              ├── AI 01: GTIN (14 chars)
                              ├── AI 10: Lot/Batch (variable)
                              └── AI 17: Expiration (YYMMDD)
```

1.  **Scanning**: Captured via the camera using the Flutter `mobile_scanner` plugin.
2.  **Decoding**: The `Gs1Parser` decodes GS1 Application Identifiers (`01`, `10`, `17`).
3.  **Local Resolution**:
    *   The app checks `CachedChemical` (Isar DB) for the parsed GTIN.
    *   If matched, details (Name, Ingredients, EPA Reg, Warnings) populate automatically in the UI.
    *   If unmatched (or local-only chemical), user is alerted, lot/expiration is still filled, and manual entry/search options are offered.

---

### 4.3 Asynchronous Weather Backfilling

*   If the mobile device is offline during spray submission, weather fields are left blank.
*   Once synced, the backend schedules a Quarkus reactive background job:
    1. Queries the Open-Meteo Historical Weather API using the log's `gpsLat`, `gpsLng`, and `timestamp`.
    2. Maps wind speed, wind direction, and temperature to the `ActivityLogEntity`.
    3. Saves coordinates and logs weather outcomes. If the API fails, the log triggers a verification warning for manual correction.

---

### 4.4 Verification Workflow & Admin Overrides

#### Supervisor Tasks
*   When a worker completes a `SPRAYING` log, the log is marked `PENDING`.
*   An event handler creates a verification `Task` assigned to supervisors.
*   Supervisor approval closes the task and marks the log as `VERIFIED`.

#### Supervisor Direct Logging
*   If a supervisor is logging on behalf of an employee:
    *   They can select the specific operator from a dropdown.
    *   They can toggle the "Auto-Verify" switch (or let the app auto-verify based on their `ADMIN` role), skipping task creation.

#### Administrative Overrides
*   Administrators can edit completed logs in the admin dashboard:
    *   Correct chemical/lot details (scanner error recovery).
    *   Override API weather figures with local sensors.
    *   Adjust calculated REI/PHI lockout windows.
    *   All administrative modifications are logged with an audit trail (`modified_by`, `modification_timestamp`).
