#  Node.js Static HTML App Deployment to AWS ECS  

This project demonstrates deploying a **Node.js application (static HTML serving)** to **AWS ECS** using **Terraform** for infrastructure and **GitHub Actions** for CI/CD automation.  

---

## 🔧 How It Works  

1. **Terraform** provisions AWS infrastructure:  
   - ECS Cluster & Service  
   - ECR Repository  
   - Networking (VPC, Subnets, etc.)  

2. **GitHub Actions** workflow (`.github/workflows/deploy.yml`) automates deployment on every push to `main`:  
   - Configures AWS credentials via OIDC (no static keys).  
   - Runs `terraform init`, `plan`, and `apply`.  
   - Builds Docker image of the app and pushes it to Amazon ECR.  
   - Forces ECS service to pull the new image and redeploy.  

---

## 📂 Repository Structure  

```
.
├── Application/      # Node.js static app + Dockerfile
├── Terraform/        # IaC for ECS, ECR, networking
└── .github/workflows # GitHub Actions pipeline
```

---

## ⚙️ Required Setup  

### GitHub → **Variables**  
- `AWS_REGION` – AWS region (e.g., `ap-south-1`)  
- `ECR_REPOSITORY` – ECR repo name  
- `ECS_CLUSTER` – ECS cluster name  
- `ECS_SERVICE` – ECS service name  

### GitHub → **Secrets**  
- `AWS_ROLE_TO_ASSUME` – IAM role with ECS/ECR/Terraform permissions  

---

## 🐳 Run Locally  

```bash
cd Application
docker build -t myapp .
docker run -p 8080:8080 myapp
```

---

## ✅ Highlights  

- **Infrastructure as Code** with Terraform  
- **Secure CI/CD** with GitHub Actions + AWS OIDC  
- **Immutable Deployments** using Git commit SHA tags  
- **Zero-downtime updates** with ECS rolling deployments  

---

## 🎯 Why This Approach  

- **Terraform** → ensures infra is consistent and version-controlled.  
- **ECS + ECR** → fully managed container orchestration with easy scaling.  
- **GitHub Actions with OIDC** → eliminates static AWS credentials, improving security.  
- **SHA-based image tagging** → guarantees reproducible and traceable deployments.  
