# Farm Recorder — Core Backend API

A highly scalable, secure Java backend powered by **Quarkus 3.x** and **Java 17**. The backend implements strict GAP (Good Agricultural Practices) auditing rules and publishes traceability records complying with the GS1 EPCIS 2.0 specification.

## 🏗️ Architecture & Directory Layout

The application adheres to **Hexagonal Architecture (Ports and Adapters)** principles to maintain clear separation between core business models and external frameworks/infrastructures.

```
src/main/java/com/farmrecorder/
├── application/             # Domain Services & Use Cases (Business workflows)
├── core/                    # Utilities & Core framework definitions
├── domain/                  
│   ├── model/               # Pure Domain Entities (InputBatch, Task, Product, ActivityLog)
│   └── port/                # Outbound Interface Ports (Repositories, Gateways)
└── infrastructure/          
    ├── persistence/         # Database Repository Adapters (Panache Entities, Postgres)
    ├── rest/                # HTTP REST Resources & MapStruct Mapper Components
    ├── storage/             # MinIO/S3 Storage Service Adapters
    └── opensearch/          # OpenSearch Traceability Indexer Adapters
```

---

## 🚀 REST API Capabilities

### 📦 Input Inventories & Stock Checks (`/api/v1/input-batches`)
- **`POST /`**: Register inventory batches by GTIN/Lot Number (restricted to `ADMIN`).
- **`GET /`**: Fetch active stock batches.
- **`GET /lookup`**: Look up batch stock levels using scanned GS1 barcodes.
- **Inline Stock Deductions**: Automatically decrements product quantities on logging matching spraying activities.

### 📋 Task Assignments (`/api/v1/tasks`)
- **`POST /`**: Assign activities to operators.
- **`GET /farm/{farmId}`**: Retrieve all tasks assigned under a farm.
- **`GET /my-tasks`**: Retrieve active tasks assigned to the authenticated user.
- **`PATCH /{id}/status`**: Mark tasks as `COMPLETED` or `REVIEWED`.

### 📑 Activity Records (`/api/v1/activity-logs`)
- **`POST /`**: Create activity logs (Planting, Harvesting, spraying, Direct Sale).
- **`GET /location/{locationId}`**: Fetch activities mapped to specific plots.
- **`GET /task/{taskId}`**: Fetch activity logs mapped to specific tasks.
- **`PUT /`**: Overwrite verification statuses (`VERIFIED` / `PENDING`).
- **Background Tasks**: Automatically triggers async wind-speed and weather lookups for spraying logs.

---

## 🔐 Security & RBAC Configuration

- **Centralized Authentication**: Integrated with Keycloak via **Quarkus OIDC**.
- **Role Permissions**: Enforces permissions using `@RolesAllowed({"FARM_WORKER", "ADMIN"})` and `@Authenticated`.
- **JWT Authorization**: Claims are validated automatically. The user identifier is derived from the verified token `upn` claim.

---

## 🛠️ Commands & Running Locally

### Development Mode
Runs the backend with Live Coding active on `http://localhost:8082`:
```bash
./mvnw quarkus:dev
```
- **Swagger UI**: Access endpoint docs at `http://localhost:8082/swagger-ui`.
- **OpenAPI Schema**: Spec is served at `http://localhost:8082/q/openapi.json`.

### Testing
Run the backend tests:
```bash
./mvnw clean test
```

### Packaging
Compile the production bundle:
```bash
./mvnw package
```
