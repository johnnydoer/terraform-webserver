resource "aws_autoscaling_group" "ec2_asg" {
  name                      = var.name
  vpc_zone_identifier       = var.private_subnet_ids
  desired_capacity          = 2
  max_size                  = 6
  min_size                  = 2
  health_check_grace_period = 90
  metrics_granularity       = "1Minute"
  launch_template {
    id      = var.ec2_template_id
    version = "$Default"
  }
}

# # Create a new load balancer attachment
# resource "aws_autoscaling_attachment" "ec2_asg_alb_attachment" {
#   autoscaling_group_name = aws_autoscaling_group.ec2_asg.name
#   elb                    = var.ec2_alb_id
# }

resource "aws_autoscaling_traffic_source_attachment" "example" {
  autoscaling_group_name = aws_autoscaling_group.ec2_asg.name

  traffic_source {
    identifier = var.ec2_alb_target_group.arn
    type       = "elbv2"
  }
}

resource "aws_autoscaling_policy" "ec2_asg_policy" {
  name                      = "webserver-asg-policy"
  autoscaling_group_name    = aws_autoscaling_group.ec2_asg.name
  policy_type               = "TargetTrackingScaling"
  estimated_instance_warmup = 60
  target_tracking_configuration {
    target_value = 25
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
  }
}

