# CI/CD plan

## High level overview of proposal

- Use GitHub Actions with OpenID Connect (OIDC) to authenticate directly with GCP
- Build Docker image and push to Artifact Registry with immutable SHA tag
- Apply a canary Kubernetes Deployment (e.g. label version "canary") and sets its image to the new SHA. The stable deployment remains untouched.
- Run smoke-test.sh - e.g. simple liveness/readiness probe check.
- If smoke test passes, run promote.sh script to patch service to point to new deployment.
- If smoke test fails, run rollback.sh script to repoint service to stable deployment and delete canary.
