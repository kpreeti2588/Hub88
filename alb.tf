# Application Load Balancer

resource "aws_lb" "lb" {
  name               = "ALB"
  security_groups    = [aws_security_group.allow-traffic.id ]
  subnets            = aws_subnet.public_subnet.*.id

  tags = {
    Name = "hub-alb"
  }
}

# Listener

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"
   
    default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}



