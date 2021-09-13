resource "aws_efs_file_system" "common_file_storage" {
  creation_token         = "my-product"
  availability_zone_name = var.zone

  tags = {
    Name = "Redmine file"
  }
}

resource "aws_efs_mount_target" "redmine_target" {
  file_system_id  = aws_efs_file_system.common_file_storage.id
  subnet_id       = aws_default_subnet.default_subnet.id
  security_groups = [aws_security_group.main_firewall.id]
}

resource "aws_default_subnet" "default_subnet" {
  availability_zone = var.zone

  tags = {
    Name = "Default subnet for redmine"
  }
}


