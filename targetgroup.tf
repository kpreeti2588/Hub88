# Target Group Creation

resource "aws_lb_target_group" "tg" {
  name        = "TargetGroup"
  port        = 80
  target_type = "instance"
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id

  health_check{
    path = "/"
    port = 80
  }
}


# Target Group Attachment with Instance
resource "aws_alb_target_group_attachment" "tgattachment" {
  count            = length(aws_instance.hub88.*.id) == 3 ? 3 : 0
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = element(aws_instance.hub88.*.id, count.index)
}

