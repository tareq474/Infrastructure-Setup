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

