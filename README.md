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
