module "vpc" {
  source = "../../modules/vpc"

  project_name   = var.project_name
  cidr_block     = "10.0.0.0/16"                
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  azs            = ["us-east-1a", "us-east-1b"] 
}


resource "aws_ecr_repository" "app" {
  name    = "gitops-app"
  force_delete = true

  tags = {
    Name = "${var.project_name}-app"
  }
}


module "iam" {
  source = "../../modules/iam"
  project_name = var.project_name
}


module "eks" {
  source = "../../modules/eks"

  cluster_name = "${var.project_name}-dev"
  cluster_role = module.iam.eks_cluster_role_arn
  node_role    = module.iam.eks_node_role_arn
  subnet_ids   = module.vpc.public_subnets

  depends_on = [module.iam]
}







# Same indexing pattern. Subnet 0 → us-east-1a, Subnet 1 → us-east-1b. This spreads subnets across AZs for high availability.
# One per module here, but you can create **multiple VPCs** in AWS
# Subnets (small networks) Can be: more than 2, Less than 2 (even 1) but cannot be empty
# **4. If you remove these, will it still work
# No VPC / subnets → nothing works
# EKS, EC2, etc. need a network
# Only 1 subnet / 1 AZ
