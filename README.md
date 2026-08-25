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





Developer
   │
   │ git push / Pull Request
   ▼
GitHub
   │
   ├── PR protection
   ├── Lint
   ├── Unit tests
   ├── SAST
   ├── Dependency scan
   ├── Secret scan
   └── Kubernetes manifest validation
   │
   ▼
Build Docker Image
   │
   ├── Trivy filesystem scan
   ├── Trivy image scan
   ├── SBOM generation
   └── Image signing
   │
   ▼
Container Registry
   │
   │ immutable image tag/digest
   ▼
DEV
   │
   └── Argo CD
   │
   ├── Deployment
   ├── Readiness probe
   ├── Liveness probe
   └── Integration tests
   │
   ▼
STAGING
   │
   └── Argo CD
   │
   ├── Deployment
   ├── Tests
   └── Monitoring
   │
   ▼
PRODUCTION APPROVAL
   │
   ▼
PRODUCTION
   │
   └── Argo CD
       │
       ├── Rolling deployment
       ├── Health checks
       ├── Monitoring
       └── Automatic rollback



app/
├── app.js
├── package.json
├── package-lock.json
└── Dockerfile
```


```bash
docker run -d --name gitops-app -p 3000:3000 gitops-app:test
```
```bash
docker ps
```

Then open:

```text
http://localhost:3000
```

If the application works, check the logs:

```bash
docker logs gitops-app
```
And clean it up:
```bash
docker stop gitops-app
docker rm gitops-app
```

1. Building docker container for the image and test manually

2. Github Action
   Developer
   │
   │ git push / Pull Request
   ▼
   GitHub Actions
   │
   ├── Install dependencies
   ├── Lint
   ├── Test
   ├── SAST
   ├── Dependency scan
   └── Secret scan 

3. 
