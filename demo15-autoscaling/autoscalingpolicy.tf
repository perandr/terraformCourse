resource "aws_autoscaling_policy" "cpu-policy-scaleup" {
    name = "cpu-policy-scaleup" 
    autoscaling_group_name = "${aws_autoscaling_group.t2_micro_autoscaling.name}"
    adjustment_type = "ChangeInCapacity"
    scaling_adjustment = "1"
    cooldown = "300"
    policy_type = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "cpu-alarm-scaleup" {
    alarm_name = "cpu-alarm-scaleup"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    namespace = "AWS/EC2"
    metric_name = "CPUUtilization"
    evaluation_periods = "2"
    period = "120"
    statistic = "Average"
    threshold = "30"

    dimensions = {
        "AutoScalingGroupName" = "${aws_autoscaling_group.t2_micro_autoscaling.name}"
    }

    actions_enabled = true
    alarm_actions = ["${aws_autoscaling_policy.cpu-policy-scaleup.arn}"]
  
}

# SCALE INSTACES DOWN
resource "aws_autoscaling_policy" "cpu-policy-scaledown" {
    name = "cpu-policy-scaledown" 
    autoscaling_group_name = "${aws_autoscaling_group.t2_micro_autoscaling.name}"
    adjustment_type = "ChangeInCapacity"
    scaling_adjustment = "-1"
    cooldown = "300"
    policy_type = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "cpu-alarm-scaledown" {
    alarm_name = "cpu-alarm-scaledown"
    comparison_operator = "LessThanOrEqualToThreshold"
    namespace = "AWS/EC2"
    metric_name = "CPUUtilization"
    evaluation_periods = "2"
    period = "120"
    statistic = "Average"
    threshold = "5"

    dimensions = {
        "AutoScalingGroupName" = "${aws_autoscaling_group.t2_micro_autoscaling.name}"
    }

    actions_enabled = true
    alarm_actions = ["${aws_autoscaling_policy.cpu-policy-scaledown.arn}"]
  
}