output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.cra_vpc.id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value = [
    aws_subnet.cra_pub_subnet1.id,
    aws_subnet.cra_pub_subnet2.id,
    aws_subnet.cra_pub_subnet3.id,
    aws_subnet.cra_pub_subnet4.id
  ]
}


output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.cra_igw.id
}


output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.cra_sg.id
}

output "instance_id" {
  description = "The ID of the EC2 instance"
  value = [
    aws_instance.cra_Srv1.id,
    aws_instance.cra_Srv2.id,
    aws_instance.cra_Srv3.id,
    aws_instance.cra_Srv4.id
  ]
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value = [
    aws_instance.cra_Srv1.public_ip,
    aws_instance.cra_Srv2.public_ip,
    aws_instance.cra_Srv3.public_ip,
    aws_instance.cra_Srv4.public_ip
  ]
}


output "instance_availability_zone" {
  description = "The Availability Zone of the EC2 instance"
  value = [
    aws_instance.cra_Srv1.availability_zone,
    aws_instance.cra_Srv2.availability_zone,
    aws_instance.cra_Srv3.availability_zone,
    aws_instance.cra_Srv4.availability_zone
  ]
}

output "load_balancer_dns_name" {
  description = "DNS name of the ALB"
  value       = [aws_lb.cra_lb1.dns_name,
  aws_lb.cra_lb2.dns_name]
}


output "target_group_arn" {
  description = "ARN of the Target Group"
  value       = [aws_lb_target_group.cra_lb1_tg.arn,
  aws_lb_target_group.cra_lb2_tg.arn]
}

