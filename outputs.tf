output "region1_instance_ips" {
  value = aws_instance.instance1.*.public_ip
}

output "region1_vpc_id" {
  value = aws_vpc.vpc1.id
}

output "region1_load-balancer_url" {
  value = aws_lb.load_balancer1.dns_name
}

output "region1_database_url" {
  value = aws_db_instance.instance1.address
}

output "region2_instance_ips" {
  value = aws_instance.instance2.*.public_ip
}

output "region2_vpc_id" {
  value = aws_vpc.vpc2.id
}

output "region2_load-balancer_url" {
  value = aws_lb.load_balancer2.dns_name
}

output "region2_database_url" {
  value = aws_db_instance.instance2.address
}