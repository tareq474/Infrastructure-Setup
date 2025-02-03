# Infrastructure-Setup on aws using Terraform

Step1:  Provider & Backend Configuration
Create a main.tf file

Step2: VPC, Subnets & Networking
Create a vpc.tf file:

Step3: EKS Cluster Setup
Create an eks.tf file:

Step4:  IAM Roles for EKS
Create an iam.tf file:

Step5:  Autoscaling (HPA & Cluster Autoscaler)
Create an autoscaling.tf file:

Step6:  Kubernetes Config & Output
Create a outputs.tf file:

Step 7: Deployment Steps

# terraform init

Step 8: Plan Deployment

#terraform plan

Step 9: Apply Changes

# terraform apply -auto-approve

Step 10: Update Kubeconfig

# aws eks update-kubeconfig --region ap-southeast-1 --name flightstorebd-cluster

Step 11: Verify EKS Cluster

# kubectl get nodes
