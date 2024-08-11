
resource "aws_security_group" "app_sg" {
  name_prefix = "app_sg_"

  ingress {
    from_port   = 80
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app_server" {
  ami             = var.ami # Amazon Linux 2 AMI
  instance_type   = var.instance_type
  security_groups = [aws_security_group.app_sg.name]

  tags = {
    Name = "AppServer"
  }
}

resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.app_sg.id]
  subnets            = ["subnet-0123456789abcdef0"] # Replace with your subnet ID

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "app_tg" {
  name     = "app-tg"
  port     =  443
  protocol = "HTTPS"
  vpc_id   = "vpc-09393bb3e5c12e8bb" # Replace with your VPC ID

  health_check {
    path     = "/"
    port     = "traffic-port"
    protocol = "HTTPS"
  }
}

resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy      = "ELBSecurityPolicy-2016-08"
  certificate_arn = var.cert

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "app_attachment" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.app_server.id
  port             =  443
}

