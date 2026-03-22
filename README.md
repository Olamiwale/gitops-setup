# creating s3 bucket
aws s3api create-bucket --bucket olawalee-state-bucket --region us-east-1

# Enable versioning on it (best practice)
aws s3api put-bucket-versioning --bucket olawalee-state-bucket  --versioning-configuration Status=Enabled

# To delete the bucket, first empty then delete
aws s3 rm s3://olawalee-state-bucket --recursive
aws s3api delete-bucket --bucket olawalee-state-bucket --region us-east-1



## After setting up terraform, you connect the "kubectl to cluster"
aws eks update-kubeconfig --name project-name --region us-east-1


## Install ArgoCD - a GitOps tool that watches Github repository and automatically deploys whatever in it to the cluster, ArgoCD installation is done directly with `kubectl` commands

kubectl create namespace argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml



## show the pods running. (wait until all pods show Running)

kubectl get pods -n argocd -w

Expected output eventually:

argocd-server-xxxxxxxxx          1/1   Running 
argocd-repo-server-xxxxxxxxx     1/1   Running 
argocd-application-controller    1/1   Running 
argocd-dex-server-xxxxxxxxx      1/1   Running 
argocd-redis-xxxxxxxxx           1/1   Running 

## Get the initial admin password

kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 --decode


## Access the ArgoCD UI
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

## Then open browser
- Username: `admin`
- Password: output from the command above



`argocd-server`--- The UI and API 
`argocd-repo-server` --- Connects to GitHub 
`argocd-application-controller` --- Watches cluster state and syncs
`argocd-redis` --- Caching layer
`argocd-dex-server` --- Authentication 












## RoadMap
Developer pushes code to GitHub
            │
            ▼
GitHub Actions (Continues Integration)
├── Runs tests
├── Builds Docker image
└── Pushes image to ECR (Amazon container registry)
            │
            ▼
ArgoCD (Continues Deployment) watches GitHub repo
├── Detects change in Kubernetes manifests
└── Deploys updated app to EKS cluster
            │
            ▼
App running on EKS







Questions
what does terraform init do?
why must s3 bucket be created first?




terraform
app/Docker
kubernetes
github-ci
argocd
