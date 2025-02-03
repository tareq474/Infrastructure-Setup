# Infrastructure-Setup
Deplyment Infrastructure on aws using Terraform
Step1:  Provider & Backend Configuration
Create a main.tf file

Step2: VPC, Subnets & Networking
Create a vpc.tf file:


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "eks-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-southeast-1a", "ap-southeast-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true
}
Step3: EKS Cluster Setup
Create an eks.tf file:

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "flightstorebd-cluster"
  cluster_version = "1.27"
  subnet_ids      = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  enable_irsa = true # For IAM Roles for Service Accounts

  node_groups = {
    general = {
      desired_capacity = 2
      max_capacity     = 4
      min_capacity     = 1

      instance_types = ["t3.medium"]
      key_name       = "my-eks-keypair"
    }
  }
}

Step4:  IAM Roles for EKS
Create an iam.tf file:


data "aws_iam_policy_document" "eks_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_role" {
  name               = "eks-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role.json
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

Step5:  Autoscaling (HPA & Cluster Autoscaler)
Create an autoscaling.tf file:

resource "aws_autoscaling_policy" "eks_scaling" {
  name                   = "eks-autoscaling-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown              = 300
  autoscaling_group_name = module.eks.node_groups["general"].asg_names[0]
}

Step6:  Kubernetes Config & Output
Create a outputs.tf file:


output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_kubeconfig" {
  value = module.eks.kubeconfig_filename
}
Deployment Steps

Initialize Terraform

terraform init

Plan Deployment

terraform plan
Apply Changes

terraform apply -auto-approve

Update Kubeconfig

aws eks update-kubeconfig --region ap-southeast-1 --name flightstorebd-cluster

Verify EKS Cluster

kubectl get nodes
