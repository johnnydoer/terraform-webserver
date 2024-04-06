resource "aws_lb" "ec2_alb" {
  name               = var.name
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = [for id in var.public_subnet_ids : id]

}

resource "aws_lb_target_group" "ec2_alb_target_group" {
  name        = "webserver-ec2-alb-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold = 2
    interval          = 10
    # matcher = 
  }
}

resource "aws_lb_listener" "ec2_alb_listener" {
  load_balancer_arn = aws_lb.ec2_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ec2_alb_target_group.arn
  }
}

# resource "aws_lb_target_group_attachment" "ec2_alb_tg_attachment" {
#   for_each = {
#     for k, v in aws_instance.example :
#     k => v
#   }

#   target_group_arn = aws_lb_target_group.ec2_alb_target_group.arn
#   target_id        = aws_instance.test.id
#   port             = 80
# }

