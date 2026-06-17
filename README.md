# Farm Recorder

A comprehensive, GAP-certified farm activity recording and traceability system. This monorepo contains a Quarkus backend, a React web dashboard, and a Flutter mobile app, all designed to work seamlessly offline and online while maintaining strict GS1 EPCIS compliance.

## 🚀 Quick Start

### Prerequisites
- **Docker & Docker Compose** (for PostgreSQL, MinIO, and Keycloak)
- **Node.js** (v18+) & **npm**
- **Java 17+** (or let the Maven wrapper handle it)
- **Flutter** (v3.x+) for mobile development

### 1. Start Infrastructure
```bash
npm run infra:up
```
*This starts PostgreSQL (port 5433), MinIO (ports 9000/9001), and Keycloak (port 8181).*

### 2. Start the Backend
```bash
npm run backend:dev
```
*Quarkus will start in dev mode on `http://localhost:8082`. Swagger UI is available at `http://localhost:8082/swagger-ui`.*

### 3. Generate API Clients
Once the backend is running, generate the strongly-typed API clients for the frontend apps:
```bash
npm run generate:clients
```

### 4. Start the Web Dashboard
```bash
cd apps/web && npm run dev
```
*Access the dashboard at `http://localhost:3000`.*

### 5. Start the Mobile App
```bash
cd apps/mobile && flutter run
```

---

## 🏗️ Architecture Overview

This project follows a **Hexagonal Architecture (Ports and Adapters)** pattern in the backend, ensuring core business logic is isolated from framework and infrastructure concerns.

- **Backend**: Quarkus (Java 17), Hibernate Panache, Liquibase, SmallRye OpenAPI, Quarkus OIDC (Keycloak), AWS SDK S3 (MinIO).
- **Database**: PostgreSQL 17 with PostGIS extension for spatial data (GPS coordinates, field boundaries).
- **Storage**: MinIO (S3-compatible) for secure, presigned URL media uploads.
- **Identity**: Keycloak 24 for OIDC authentication, JWT issuance, and Role-Based Access Control (RBAC).
- **Web**: React 18, Vite, TypeScript, Leaflet (maps), `@tanstack/react-query`.
- **Mobile**: Flutter, Isar (offline-first database), Dio (HTTP), Geolocator.
- **Monorepo**: Managed by Nx for coordinated builds and OpenAPI code generation.

For detailed architecture, see [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md).

---

## 🔐 Authentication & Security

The system uses **Keycloak** for centralized identity management. 
- **Login Flow**: Mobile/Web apps send credentials to `/api/auth/login`, which proxies a Direct Grant request to Keycloak and returns a JWT.
- **API Security**: All `/api/v1/*` endpoints are protected by `@Authenticated` and `@RolesAllowed({"FARM_WORKER", "ADMIN"})`.
- **Token Validation**: Quarkus OIDC automatically validates the JWT signature and extracts the `upn` (username) claim to attribute actions securely.

For setup and RBAC configuration, see [docs/AUTHENTICATION.md](docs/AUTHENTICATION.md).

---

## 🌾 GAP Compliance & EPCIS Traceability

Every activity logged in the system (Planting, Spraying, Harvesting, Cleaning, Inspection) is automatically mapped to a **GS1 EPCIS 2.0 `ObjectEvent`**. 
- **Read Point**: Mapped to the Location's GLN (Global Location Number).
- **Business Step**: Mapped to the activity type (e.g., `urn:epcglobal:cbv:bizstep:spraying`).
- **Extensions**: Custom EPCIS extensions capture GPS coordinates and GAP compliance notes for auditability.

For the EPCIS mapping logic and GAP audit workflows, see [docs/GAP_EPCIS.md](docs/GAP_EPCIS.md).

---

## 📚 Documentation Index

- [Architecture & Monorepo Structure](docs/ARCHITECTURE.md)
- [Authentication & Keycloak Setup](docs/AUTHENTICATION.md)
- [GAP Compliance & EPCIS Mapping](docs/GAP_EPCIS.md)
- [Development & Troubleshooting Guide](docs/DEVELOPMENT.md)

---

## 📝 License

Proprietary. All rights reserved.
