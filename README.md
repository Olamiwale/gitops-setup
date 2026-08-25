Developer
   │
   │ git push
   ▼
GitHub
   │
   ▼

│       GitHub Actions CI       │
│                               │
│  1. Checkout                  │
│  2. Install dependencies      │
│  3. Lint                      │
│  4. Unit tests                │
│  5. Build application         │
│  6. Security / dependency scan│
│  7. Build Docker image        │
│  8. Container scan (Trivy)    │
└───────────────┬───────────────┘
                │
                ▼
       Container Registry
          myapp:v2
                │
                ▼
        ┌───────────────┐
        │      DEV      │
        │ Kubernetes    │
        │ RollingUpdate │
        └───────┬───────┘
                │
          Integration tests
                │
                ▼
        ┌───────────────┐
        │    STAGING    │
        │ Kubernetes    │
        │ RollingUpdate │
        └───────┬───────┘
                │
          Validation/tests
                │
                ▼
          Manual Approval
                │
                ▼
        ┌───────────────┐
        │  PRODUCTION   │
        │ Kubernetes    │
        │ RollingUpdate │
        └───────────────┘


        PR
 ↓
Lint
 ↓
Tests
 ↓
SAST
 ↓
Dependency scan
 ↓
Secrets scan
 ↓
Docker build
 ↓
Trivy
 ↓
SBOM
 ↓
Image signing
 ↓
Registry