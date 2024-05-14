# Data source to fetch details about the target group
data "aws_lb_target_group" "example_target_group" {
  name = "terra-ALB-Tg"
}

# Data source to fetch details about the load balancer associated with the target group
data "aws_lb" "example_alb" {
  arn = element(tolist(data.aws_lb_target_group.example_target_group.load_balancer_arns), 0)

}

# Output the ARN and DNS name of the ALB associated with the target group
output "alb_arn" {
  value = data.aws_lb.example_alb.arn
}

output "alb_dns_name" {
  value = data.aws_lb.example_alb.dns_name
}
