# Architecture & Monorepo Structure

This document details the architectural patterns and directory structure of the Farm Recorder project.

## 1. Hexagonal Architecture (Backend)

The Quarkus backend strictly follows the **Ports and Adapters** pattern to ensure testability and separation of concerns.

```text
apps/backend/src/main/java/com/farmrecorder/
├── domain/                  # Core business logic (Pure Java, no framework annotations)
│   ├── model/               # Immutable records (e.g., ActivityLog, Location, Product)
│   └── port/                # Interfaces defining contracts (e.g., ActivityLogRepositoryPort, EpcisGatewayPort)
├── application/             # Use cases / Orchestrators
│   └── ActivityLogService.java  # Implements business rules, calls domain ports
└── infrastructure/          # Framework & external system adapters
    ├── rest/                # Driving adapters: JAX-RS Resources (REST endpoints, OpenAPI annotations)
    ├── persistence/         # Driven adapters: Panache Entities, Repository implementations, MapStruct mappers
    ├── epcis/               # Driven adapters: OpenEPCIS HTTP client implementation
    └── storage/             # Driven adapters: MinIO/S3 presigned URL generation
```

### Key Principles:
- **Domain Independence**: The `domain` layer knows nothing about Quarkus, JPA, or HTTP.
- **Dependency Inversion**: High-level modules (`application`) depend on abstractions (`domain.port`), not concrete implementations.
- **Zero-Boilerplate Mapping**: MapStruct is used at compile time to translate between Domain Records and JPA Entities.

## 2. Monorepo Structure

The project is managed as a polyglot monorepo using **Nx** and **npm workspaces**.

```text
farm-recorder/
├── apps/
│   ├── backend/          # Quarkus Java application
│   ├── web/              # React + Vite + TypeScript dashboard
│   └── mobile/           # Flutter application (iOS/Android)
├── packages/
│   └── api-contracts/    # OpenAPI generator configurations (Orval for React, openapi-generator for Flutter)
├── infra/
│   └── docker-compose.yml # Local development infrastructure (Postgres, MinIO, Keycloak)
├── package.json          # Root workspace orchestrator and shared scripts
└── nx.json               # Nx workspace configuration
```

## 3. Automated API Contract Generation

To prevent backend-frontend integration drift, API clients are **never written manually**. They are generated from the live Quarkus OpenAPI specification (`/q/openapi.json`).

- **React**: Uses `orval` to generate `@tanstack/react-query` hooks and TypeScript interfaces.
  - Config: `packages/api-contracts/orval.config.ts`
  - Output: `apps/web/src/api/farmRecorder.ts`
- **Flutter**: Uses `openapi-generator-cli` to generate strongly-typed Dart models and Dio API clients.
  - Config: `packages/api-contracts/openapi-generator-config.json`
  - Output: `apps/mobile/lib/api/generated/`

Run `npm run generate:clients` after any backend endpoint changes.

## 4. Infrastructure Components

| Component | Port | Purpose |
|-----------|------|---------|
| **Quarkus Backend** | `8082` | Core API, business logic, EPCIS mapping |
| **Keycloak** | `8181` | OIDC Identity Provider, JWT issuance, RBAC |
| **PostgreSQL + PostGIS** | `5433` | Relational data, spatial queries (GeoJSON polygons) |
| **MinIO** | `9000` (API), `9001` (Console) | S3-compatible object storage for GAP compliance photos |

*Note: Ports are intentionally shifted (e.g., 5433 instead of 5432) to avoid conflicts with local developer machines.*
