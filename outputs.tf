output "external_ip_load_balancer" {
  value = aws_instance.load_balancer.public_ip
}

output "dns_name_for_EFS" {
  value = aws_efs_file_system.common_file_storage.dns_name
}

output "RDS_db_adress" {
  value = aws_db_instance.redmine_rds_db.address
}

output "RDS_db_endpoint" {
  value =aws_db_instance.redmine_rds_db.endpoint
}
