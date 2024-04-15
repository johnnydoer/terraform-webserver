# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
# Define an Application Load Balancer (ALB) resource
resource "aws_lb" "ec2_alb" {
  name               = var.name                               # Name of the ALB, obtained from variables
  load_balancer_type = "application"                          # Type of load balancer
  security_groups    = [var.alb_sg_id]                        # Security groups associated with the ALB
  subnets            = [for id in var.public_subnet_ids : id] # Subnets where the ALB will be deployed
}

# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
# Define a target group for the ALB to forward traffic to EC2 instances
resource "aws_lb_target_group" "ec2_alb_target_group" {
  name        = "webserver-ec2-alb-target-group" # Name of the target group
  port        = 80                               # Port on which the EC2 instances will receive traffic
  protocol    = "HTTP"                           # Protocol used for communication
  target_type = "instance"                       # Target type for the target group
  vpc_id      = var.vpc_id                       # ID of the VPC where the target group is created

  # Define health check configuration for the target group
  health_check {
    healthy_threshold = 2  # Number of consecutive successful health checks required
    interval          = 10 # Interval between health checks
    # matcher =                                      # (Optional) Health check matcher configuration
  }
}

# Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
# Define a listener for the ALB to route traffic to the target group
resource "aws_lb_listener" "ec2_alb_listener_HTTP" {
  load_balancer_arn = aws_lb.ec2_alb.arn # ARN of the ALB
  port              = "80"               # Port on which the ALB listens for incoming traffic
  protocol          = "HTTP"             # Protocol used for communication
  # Define default action to forward incoming requests to the target group
  default_action {
    type = "redirect" # Action type to forward requests

    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "ec2_alb_listener_HTTPS" {
  load_balancer_arn = aws_lb.ec2_alb.arn # ARN of the ALB
  port              = "443"              # Port on which the ALB listens for incoming traffic
  protocol          = "HTTPS"            # Protocol used for communication
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.certificate_arn

  # Define default action to forward incoming requests to the target group
  default_action {
    type             = "forward"                                    # Action type to forward requests
    target_group_arn = aws_lb_target_group.ec2_alb_target_group.arn # ARN of the target group to forward traffic to
  }
}


# Resource to attach EC2 instances to the target group (currently commented out)
# resource "aws_lb_target_group_attachment" "ec2_alb_tg_attachment" {
#   for_each = {
#     for k, v in aws_instance.example :
#     k => v
#   }

#   target_group_arn = aws_lb_target_group.ec2_alb_target_group.arn
#   target_id        = aws_instance.test.id
#   port             = 80
# }
