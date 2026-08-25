Developer
   │
   │ git push
   ▼
GitHub
   │
   ▼

GitHub Actions CI

Checkout               
Install dependencies   
Lint                   
Unit tests             
Build application      
Security / dependency scan
Build Docker image        
Container scan (Trivy)    

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