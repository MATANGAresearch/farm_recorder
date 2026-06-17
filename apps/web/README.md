# Farm Recorder — Web Portal & Manager Dashboard

A premium, glassmorphic React administration dashboard for agricultural managers and supervisors. This dashboard provides global configuration, input inventory tracking, catalog overrides, and verification workflows for compliance with GAP and GS1 EPCIS standards.

## 🎨 Design System & Aesthetics

- **Styling**: Structured using HSL tailored dark-glass styling tokens and vanilla CSS (`src/index.css`), avoiding Tailwind dependencies.
- **Typography**: Uses modern sans-serif typefaces (e.g., Google Fonts Outfit/Inter) with dynamic spacing and micro-animations on interactive cards and tabs.
- **Responsive Layout**: Designed with a clean, collapsable sidebar navigation, flexible grids, and fluid container widths.

## 🚀 Key Features

### 1. Input Inventory Management (`📦 Input Inventory`)
- Register new chemical, fertilizer, or agricultural input batches by selected GTIN, specifying:
  - Lot Number
  - Initial and remaining quantities (safely tracked dynamically)
  - Unit (Liters, Grams, etc.)
  - Expiration Date
- Highlights low-stock lots in real-time to alert managers of required restocking.

### 2. Approved Chemical Catalog (`🧪 Chemical Catalog`)
- View registered crop and agricultural products.
- Override EPA Registration Numbers, active ingredients, Re-Entry Intervals (REI), Pre-Harvest Intervals (PHI), and local-only designations.
- **Local GTIN Generator**: Instantly generate prefix-compatible local GTINs (`999...`) for customized local farm mixtures.

### 3. Supervisor Verification Tasks (`✅ Task Reviews`)
- Displays completed worker tasks and pending supervisor sign-offs in a single queue.
- **Task Review Card**:
  - Automatically queries the linked `ActivityLog` (e.g., spraying or harvest batch details) and fetches uploaded photo/video media evidence from MinIO.
  - Renders image viewers and video players directly on the card.
  - On approval (**Sign Off & Approve**), it updates both the worker task and its corresponding activity log status to `REVIEWED`/`VERIFIED` concurrently.

### 4. Direct Activity Logging (`📝 Log Activity`)
- Allows supervisors to log farm activities directly from the dashboard.
- Includes a **"Requires Supervisor Verification" Toggle** to bypass review tasks when logged directly by the supervisor.
- Set **Operator (Worker username)** manually for precise tracking.
- Pre-populate wind speeds, temperatures, and application rates.

---

## 🛠️ Development & Commands

### Prerequisites
1. Ensure the Quarkus backend dev server is running on `http://localhost:8082` to answer API requests.
2. In the monorepo root, run `npm run generate:react-client` to update client typescript definitions.

### Commands
Run the dev server locally:
```bash
npm run dev
```

Build the production production bundle:
```bash
npm run build
```

Preview the production build:
```bash
npm run preview
```
