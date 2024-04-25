# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group
# Define an Auto Scaling Group (ASG) resource
resource "aws_autoscaling_group" "ec2_asg" {
  name                      = var.name               # Name of the Auto Scaling Group
  vpc_zone_identifier       = var.private_subnet_ids # List of private subnets for instances
  desired_capacity          = 2                      # Desired number of instances
  max_size                  = 6                      # Maximum number of instances
  min_size                  = 2                      # Minimum number of instances
  health_check_grace_period = 90                     # Grace period for health checks
  metrics_granularity       = "1Minute"              # Granularity of metrics

  # Launch template configuration for the Auto Scaling Group
  launch_template {
    id      = var.ec2_template_id # ID of the launch template
    version = "$Default"          # Default version of the launch template
  }
}

# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_traffic_source_attachment
# Define a traffic source attachment for the Auto Scaling Group
resource "aws_autoscaling_traffic_source_attachment" "example" {
  autoscaling_group_name = aws_autoscaling_group.ec2_asg.name # Name of the Auto Scaling Group

  traffic_source {
    identifier = var.ec2_alb_target_group.arn # ARN of the target group
    type       = "elbv2"                      # Type of traffic source (ELBv2)
  }
}

# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy
# Define an Auto Scaling Policy for the Auto Scaling Group
resource "aws_autoscaling_policy" "ec2_asg_policy" {
  name                      = "webserver-asg-policy"             # Name of the scaling policy
  autoscaling_group_name    = aws_autoscaling_group.ec2_asg.name # Name of the Auto Scaling Group
  policy_type               = "TargetTrackingScaling"            # Type of scaling policy
  estimated_instance_warmup = 60                                 # Warm-up time for newly launched instances

  target_tracking_configuration {
    target_value = 25 # Target value for the metric
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization" # Predefined metric type (average CPU utilization)
    }
  }
}