resource "aws_autoscaling_policy" "eks_scaling" {
  name                   = "eks-autoscaling-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown              = 300
  autoscaling_group_name = module.eks.node_groups["general"].asg_names[0]
}

