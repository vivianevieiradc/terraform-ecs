
data "aws_ami" "ecs_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }
}

resource "aws_security_group" "ecs_instance" {
  name        = "${var.project_name}-ecs-instance-sg"
  description = "SG for ECS EC2 instances"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "ingress_from_alb_dynamic_ports" {
  count                    = var.alb_security_group_id == null ? 0 : 1
  type                     = "ingress"
  from_port                = var.dynamic_host_port_min
  to_port                  = var.dynamic_host_port_max
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ecs_instance.id
  source_security_group_id = var.alb_security_group_id
  description              = "Allow dynamic ECS host ports from ALB security group"
}

resource "aws_launch_template" "ecs_instance" {
  name_prefix   = "${var.project_name}-ecs-lt-"
  image_id      = data.aws_ami.ecs_ami.id
  instance_type = var.instance_type
  iam_instance_profile {
    name = var.instance_profile_name
  }
  vpc_security_group_ids = [aws_security_group.ecs_instance.id]
  user_data = base64encode(<<EOF
#!/bin/bash
echo ECS_CLUSTER=${var.ecs_cluster_name} >> /etc/ecs/ecs.config
EOF
  )

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project_name}-ecs-instance"
    }
  }
}

resource "aws_autoscaling_group" "ecs_instance" {
  name                = "${var.project_name}-asg"
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = var.subnet_ids
  launch_template {
    id      = aws_launch_template.ecs_instance.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "${var.project_name}-ecs-instance"
    propagate_at_launch = true
  }
  lifecycle {
    create_before_destroy = true
  }
}
