resource "aws_lb_target_group" "my_tg" {
  name     = "mytg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 10
    matcher             = 200
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 3
    unhealthy_threshold = 2
  }
}
resource "aws_lb_target_group_attachment" "lb-tga" {
  count            = length(aws_instance.main_ec2)
  target_group_arn = aws_lb_target_group.my_tg.arn
  target_id        = element(aws_instance.main_ec2.*.id, count.index)
  port             = 80
}
resource "aws_lb_listener" "my_alb_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg.arn
  }
}
resource "aws_lb" "my_alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ec2_sg.id]
  subnets            = [for subnet in aws_subnet.public_subnet : subnet.id]

  enable_deletion_protection = false

  tags = {
    Environment = "my_alb"
  }
}