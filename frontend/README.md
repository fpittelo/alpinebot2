# Frontend

This directory contains the **React** frontend application, built with **Vite**.

## Tech Stack

- **Framework**: React 18
- **Build Tool**: Vite
- **Styling**: Tailwind CSS
- **Language**: JavaScript (ES Modules)

## Getting Started

### Prerequisites

- Node.js (LTS version recommended)
- npm

### Installation

```bash
npm install
```

### Development

Start the development server:

```bash
npm run dev
```

The application will be available at `http://localhost:5173` (by default).

### Build

Build for production:

```bash
npm run build
```

The output will be in the `dist` directory.

### Deployment

This application is deployed to an **Azure Web App** (Linux) via GitHub Actions.
The build artifact (`dist` folder) is zipped and deployed to the web app.
