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






# GitOps CI/CD Pipeline

A production-oriented GitOps CI/CD pipeline for a containerized Node.js application running on Kubernetes.


### Phase 1 — Application & Docker

* Node.js application built with Express.
* Application runs on port `3000`.
* Dockerized using Node.js Alpine.
* Production-oriented Dockerfile.
* Dependencies installed with `npm ci`.
* Container runs as a non-root user.
* Added `.dockerignore`.
* Docker image successfully builds and runs locally.

### Application Health Checks



## Phase 2 — GitHub Actions CI

Created:

```text
.github/workflows/ci.yml
```

The CI pipeline currently performs:

```text
Git Push / Pull Request
        ↓
Checkout
        ↓
Node.js Setup
        ↓
npm ci
        ↓
Lint
        ↓
Tests
```

Current CI status: **Passing**

---

## Phase 3 — Security

Security checks have been added to the pipeline:

### SAST

Using:

```text
GitHub CodeQL
```

Scans the JavaScript application for security vulnerabilities.

### Dependency Scanning

Using:

```text
Trivy
```

Scans application dependencies for known vulnerabilities.

### Secret Scanning

Using:

```text
Gitleaks
```

Detects accidentally committed secrets and credentials.

Current status:

```text
Code Quality       ✅
SAST               ✅
Dependency Scan    ✅
Secret Scan        ✅
```


## Repository Structure

```text
gitops-pipeline/
├── .github/
│   └── workflows/
│       ├── ci.yml
│       ├── dev.yml
│       ├── staging.yml
│       └── production.yml
│
├── app/
│   ├── app.js
│   ├── Dockerfile
│   ├── .dockerignore
│   ├── package.json
│   └── package-lock.json
│
├── k8s/
│   ├── base/
│   │   ├── deployment.yaml
│   │   ├── kustomization.yaml
│   │   └── service.yaml
│   │
│   └── environments/
│       ├── dev/
│       ├── staging/
│       └── production/
│
└── README.md
```

## Next Steps

### Phase 5 — Container Registry

* Create AWS ECR repository.
* Push validated Docker images to ECR.
* Use immutable commit SHA tags.
* Configure image signing with Cosign.
* Store and associate the SBOM with the image.

### Phase 6 — Kubernetes / GitOps

* Configure Kustomize environments.
* Configure Argo CD.
* Deploy to development.
* Promote to staging.
* Add production approval.
* Deploy to production.

### Later

* Kubernetes readiness/liveness probes
* Automatic rollback
* Prometheus
* Grafana
* Alerting
* Deployment audit trail
* Branch protection
* Production approvals
* Notifications
