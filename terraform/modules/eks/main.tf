# module/eks/main.tf
resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  role_arn = var.cluster_role
  version  = "1.29"

  vpc_config {
    subnet_ids = var.subnet_ids
  }
  depends_on = [var.cluster_role]
}



# Same pattern. Cluster name and role come from outside, keeping IAM/networking concerns out of EKS module.
