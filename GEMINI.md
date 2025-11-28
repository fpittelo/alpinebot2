# AlpineBot - GEMINI Context

## 1. Project Overview

**AlpineBot.ch** is an AI-powered RAG (Retrieval-Augmented Generation) chatbot designed to provide accurate, grounded information about Switzerland. It acts as a digital "Sherpa," leveraging Azure OpenAI (GPT-4o) and a vector database (PostgreSQL with `pgvector`) to answer queries with Swiss precision.

**Key Attributes:**
- **Cloud-Native:** Hosted entirely on Azure (Switzerland North) via PaaS services.
- **Security-First:** Uses Managed Identities, Key Vault, and VNet Integration. No secrets in code.
- **Minimalist Design:** React frontend with Tailwind CSS, adhering to Swiss design principles.

## 2. Architecture & Tech Stack

### Frontend (`/frontend`)
- **Framework:** React (Vite)
- **Styling:** Tailwind CSS
- **Auth:** Google OAuth 2.0 (via custom implementation or library)
- **Hosting:** Azure App Service (Linux)

### Backend (`/backend`)
- **Runtime:** Python 3.11+
- **Framework:** Azure Functions (v2 Programming Model)
- **AI Integration:** OpenAI SDK (Azure OpenAI GPT-4o)
- **Database Driver:** `psycopg2` / `asyncpg`

### Infrastructure (`/infra`)
- **Tool:** Terraform
- **State:** Remote state in Azure Storage
- **Resources:** Azure App Service, Azure Functions, Postgres Flexible Server, Redis, Key Vault, Virtual Network.

### CI/CD
- **Platform:** GitHub Actions
- **Workflow:** No local deployments. All infra and code deployments go through the `.github/workflows/deploy.yaml` pipeline.
- **Stages:** Deploy Backend (TF State) -> Deploy Infra -> Deploy App Backend -> Deploy App Frontend.

## 3. Development Workflow

### Branching Strategy
- **`main`**: Production (Deploy trigger: Release Tag)
- **`qa`**: Staging/Testing (Deploy trigger: Manual)
- **`dev`**: Development (Deploy trigger: Push)
- **Feature Branches**: Create from `dev`, merge back to `dev` via PR.

### Environment Setup (Local)

**Frontend:**
```bash
cd frontend
npm install
npm run dev
# Runs on http://localhost:5173
```

**Backend:**
```bash
cd backend
python -m venv .venv
source .venv/bin/activate  # or .venv\Scripts\activate on Windows
pip install -r requirements.txt
func start
# Runs on http://localhost:7071
```

**Note:** Local development connects to cloud resources (like Azure OpenAI) using `DefaultAzureCredential`. Ensure you are logged in via `az login`.

## 4. Key Commands

| Scope | Command | Description |
| :--- | :--- | :--- |
| **Frontend** | `npm run dev` | Start local dev server |
| **Frontend** | `npm run build` | Build for production |
| **Frontend** | `npm run lint` | Run ESLint |
| **Backend** | `func start` | Start local Functions runtime |
| **Backend** | `pip install -r requirements.txt` | Install dependencies |
| **Infra** | `terraform fmt -recursive` | Format Terraform code |
| **Git** | `git checkout -b feature/name` | Start a new feature |

## 5. Project Conventions

- **Code Style:**
  - **Python:** Follow PEP 8.
  - **JavaScript/React:** Follow ESLint rules defined in `package.json`.
  - **Terraform:** Standard Terraform formatting conventions.
- **Documentation:** Update `README.md` and `CHANGELOG` when making significant changes.
- **Testing:**
  - Pragmatic testing approach. Focus on critical logic in Backend and specific UI components in Frontend.
- **Secrets:** NEVER commit secrets. Use Azure Key Vault and Managed Identities. Local secrets should be in `.env` files (gitignored) or `local.settings.json` (gitignored).

## 6. File Structure Highlights

- `backend/function_app.py`: Main entry point for Azure Functions.
- `frontend/src/App.jsx`: Main React application component.
- `frontend/vite.config.js`: Vite configuration.
- `infra/main.tf`: Entry point for Terraform modules.
- `.github/workflows/`: CI/CD definitions.
