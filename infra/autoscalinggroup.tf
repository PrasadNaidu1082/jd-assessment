resource "aws_autoscaling_group" "jdoodle-asg" {
  desired_capacity     = 2
  max_size             = 5
  min_size             = 2
  launch_configuration = aws_launch_configuration.ubuntu-jdoodle.id
  health_check_type          = "EC2"
  health_check_grace_period  = 300 # 5 minutes

  vpc_zone_identifier  = [
    aws_subnet.public_ap_south_1a.id,
    aws_subnet.public_ap_south_1b.id
  ]

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "Jdoodle-Ubuntu-lC"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale_up"
  scaling_adjustment    = 1
  cooldown              = 300  # 300 seconds (5 minutes)
  adjustment_type       = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.jdoodle-asg.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale_down"
  scaling_adjustment    = -1
  cooldown              = 300  # 300 seconds (5 minutes)
  adjustment_type       = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.jdoodle-asg.name
}
