# Backend

This directory contains the Python Azure Functions backend application.

## Dependency Management

Dependencies are managed in `requirements.txt`. All dependencies are pinned to specific version ranges to ensure reproducible builds and prevent unexpected breaking changes.

When adding or updating a dependency:

1.  Check for the latest stable version.
2.  Update `requirements.txt` with a version constraint (e.g., `>=X.Y.Z,<(X+1).0.0`).
3.  Test the application locally to ensure compatibility.
