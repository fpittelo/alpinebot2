# Backend

This directory contains the **Python** backend application, hosted on **Azure Functions**.

## Tech Stack

- **Runtime**: Python 3.11
- **Framework**: Azure Functions (v2 Programming Model)
- **AI**: Azure OpenAI (GPT-4o) via `openai` SDK
- **Database**: Azure Database for PostgreSQL (pgvector) via `psycopg2` / `asyncpg`

## Getting Started

### Prerequisites

- Python 3.11+
- Azure Functions Core Tools (`func`)
- Azure CLI (`az`)

### Installation

1.  Create a virtual environment:

    ```bash
    python -m venv .venv
    source .venv/bin/activate  # Linux/macOS
    # or
    .venv\Scripts\activate     # Windows
    ```

2.  Install dependencies:
    ```bash
    pip install -r requirements.txt
    ```

### Development

Start the local Functions runtime:

```bash
func start
```

### Dependency Management

Dependencies are managed in `requirements.txt`. All dependencies are pinned to specific version ranges to ensure reproducible builds.

When adding or updating a dependency:

1.  Check for the latest stable version.
2.  Update `requirements.txt` with a version constraint.
3.  Test locally.

### Deployment

This application is deployed to an **Azure Function App** (Linux Consumption Plan) via GitHub Actions.
The build process uses Oryx to build the Python dependencies during deployment.
