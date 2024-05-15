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

# Data source to fetch details about the VPC
data "aws_vpc" "example_vpc" {
  id = "vpc-0a0acf0ecf627f980"  
}
# Data source to fetch details about subnets in the specified VPC
data "aws_subnet" "example_subnets" {
  vpc_id = "vpc-0a0acf0ecf627f980"  # Replace with the ID of your VPC
}

# Output the subnet IDs
output "subnet_ids" {
  value = data.aws_subnet.example_subnets[*].id
}

# Output the subnet CIDR blocks
output "subnet_cidr_blocks" {
  value = data.aws_subnet.example_subnets[*].cidr_block
}


# Data source to fetch details about route tables associated with the VPC
data "aws_route_tables" "example_route_tables" {
  vpc_id = data.aws_vpc.example_vpc.id
}

# Data source to fetch details about NAT gateways associated with the VPC
data "aws_nat_gateway" "example_nat_gateways" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.example_vpc.id]
  }
}

# Output the route table IDs
output "route_table_ids" {
  value = data.aws_route_tables.example_route_tables[*].id  # Use [*] to access all route table IDs
}

# Output the NAT gateway IDs
output "nat_gateway_ids" {
  value = data.aws_nat_gateway.example_nat_gateways[*].id  # Use [*] to access all NAT gateway IDs
}

# Output the ARN and DNS name of the ALB associated with the target group in table format
output "alb_details" {
  value = format(
    "| %-20s | %-20s |\n|----------------------|----------------------|\n| %-20s | %-20s |",
    "ALB ARN", "ALB DNS Name",
    data.aws_lb.example_alb.arn, data.aws_lb.example_alb.dns_name
  )
}

# Output the network details in table format
output "network_details" {
  value = format(
    "| %-20s | %-20s |\n|----------------------|----------------------|\n| %-20s | %-20s |\n| %-20s | %-20s |\n| %-20s | %-20s |\n| %-20s | %-20s |",
    "Subnet ID", "CIDR Block",
    join(", ", data.aws_subnet.example_subnets[*].id),  # Corrected attribute to "id"
    join(", ", data.aws_subnet.example_subnets[*].cidr_block),  # Corrected attribute to "cidr_block"
    "Route Table IDs", "",
    join(", ", data.aws_route_tables.example_route_tables[*].id),  # Use [*] to access all route table IDs
    "NAT Gateway IDs", "",
    join(", ", data.aws_nat_gateway.example_nat_gateways[*].id)  # Use [*] to access all NAT gateway IDs
  )
}
