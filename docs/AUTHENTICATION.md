# Authentication & Keycloak Setup

This document explains how authentication, authorization, and JWT validation are implemented in the Farm Recorder system.

## 1. Technology Stack
- **Identity Provider**: Keycloak 24 (running in Docker on port `8181`)
- **Protocol**: OpenID Connect (OIDC)
- **Token Format**: JWT (RS256 signed by Keycloak)
- **Backend Validation**: Quarkus OIDC extension (`quarkus-oidc`)

## 2. Authentication Flow

### Mobile / Web Login Flow (Direct Grant)
1. The client (Flutter/React) sends a `POST` request to the backend proxy:
   ```http
   POST /api/auth/login
   Content-Type: application/json
   
   {
     "username": "farmuser",
     "password": "farmpass"
   }
   ```
2. The Quarkus `AuthResource` proxies this request to Keycloak's token endpoint using the `password` grant type.
3. Keycloak validates the credentials and returns an `access_token` (JWT), `refresh_token`, and `expires_in`.
4. The backend forwards this response to the client.
5. The client stores the `access_token` securely (e.g., `SharedPreferences` in Flutter, memory/secure storage in React).

### API Request Flow
1. The client attaches the token to every request:
   ```http
   Authorization: Bearer <access_token>
   ```
2. Quarkus OIDC intercepts the request, validates the JWT signature against Keycloak's public keys, and checks the `iss` (issuer) and `exp` (expiration).
3. If valid, the request proceeds. The authenticated username is extracted from the `upn` claim and made available via `SecurityContext.getUserPrincipal().getName()`.

## 3. Role-Based Access Control (RBAC)

All core API endpoints are protected by both `@Authenticated` and `@RolesAllowed` annotations:

```java
@Path("/api/v1/activity-logs")
@Authenticated
@RolesAllowed({"FARM_WORKER", "ADMIN"})
public class ActivityLogResource { ... }
```

### Configuring Roles in Keycloak
For the `@RolesAllowed` check to pass, Keycloak must include the role in the JWT's `realm_access.roles` or `resource_access.<client_id>.roles` array.

**To assign the `FARM_WORKER` role to the test user:**
1. Log in to Keycloak Admin Console: `http://localhost:8181` (admin / admin).
2. Select the **`farm-recorder`** realm.
3. Go to **Users** → **`farmuser`** → **Role mapping** tab.
4. Click **Assign role** → **Filter by clients** → select **`farm-recorder-backend`**.
5. Check the **`FARM_WORKER`** role (create it under Client Roles if it doesn't exist) and click **Assign**.

*Alternatively, for rapid local development, you can use a Keycloak "Hardcoded Role" mapper on the client scope to automatically inject the `FARM_WORKER` role into every token issued for this client.*

## 4. Backend Configuration

Quarkus is configured to validate tokens via `application.properties`:

```properties
quarkus.oidc.auth-server-url=http://localhost:8181/realms/farm-recorder
quarkus.oidc.client-id=farm-recorder-backend
quarkus.oidc.credentials.secret=your-client-secret-here
quarkus.oidc.application-type=service
```

## 5. Live AKS & Keycloak Provisioning

In the AKS production environment (`https://farmrecorder.matangaresearch.com`), Keycloak has been provisioned with the realm `farm-recorder` and client `farm-recorder-backend` containing secret `your-client-secret-here`.

The system comes pre-configured with two user accounts for testing:
- **Administrator**:
  - **Username**: `admin`
  - **Password**: `admin`
  - **Role**: `ADMIN` (granted access to `/admin` panel, Farms, Locations, Products, and Workers CRUD)
- **Farm Worker**:
  - **Username**: `worker_john`
  - **Password**: `workerpass`
  - **Role**: `FARM_WORKER` (granted access to Map, Tasks, Audit log, and status updates)

## 6. Worker Profile Registration (Binding)

Users created inside Keycloak represent credentials. To attach rich attributes like their legal full name and pesticide applicator license numbers:
1. Log in to the Admin Panel as `admin`.
2. Navigate to the **Workers** tab.
3. Register the worker by specifying their Keycloak username, their full name, and their applicator license number.
4. Once registered, their full name will automatically populate in the task assignment dropdowns and EPCIS activity log headers.

## 7. Troubleshooting Auth Issues

- **`401 Unauthorized`**: The token is missing, expired, or the signature is invalid. Check Keycloak logs and ensure the client system clock is synchronized.
- **`403 Forbidden`**: The token is valid, but the user lacks the required role (e.g., `FARM_WORKER`). Verify the role mapping in Keycloak and inspect the decoded JWT at [jwt.io](https://jwt.io) to confirm the role is present in the payload.
- **CORS Issues**: Ensure Keycloak's "Valid Redirect URIs" and "Web Origins" are configured correctly if building a production web app.
