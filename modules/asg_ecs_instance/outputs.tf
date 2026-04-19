output "asg_name" {
  value = aws_autoscaling_group.ecs_instance.name
}


output "security_group_id" {
  value = aws_security_group.ecs_instance.id
}
