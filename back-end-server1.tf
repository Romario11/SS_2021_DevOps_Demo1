resource "aws_instance" "back_end_server_1" {
  instance_type     = "t3.small"
  key_name          = aws_key_pair.public_key.key_name
  ami               = data.aws_ami.ubuntu.id
  availability_zone = var.zone


  user_data = templatefile(var.redmine_start_script, { USER_NAME = var.user_name, DNS_EFS = aws_efs_file_system.common_file_storage.dns_name })

  vpc_security_group_ids = [aws_security_group.main_firewall.id]

  provisioner "file" {
    source      = "${path.module}/configs/database.yml"
    destination = "/home/${var.user_name}/database.yml"
    connection {
      type        = "ssh"
      user        = var.user_name
      host        = self.public_ip
      private_key = file(var.ssh_private_key)
    }
  }
  provisioner "file" {
    source      = "${path.module}/configs/configuration.yml"
    destination = "/home/${var.user_name}/configuration.yml"
    connection {
      type        = "ssh"
      user        = var.user_name
      host        = self.public_ip
      private_key = file(var.ssh_private_key)
    }
  }
  depends_on = [local_file.db_config_redmine,aws_efs_file_system.common_file_storage]
  tags = {
    "Name"    = "Redmine_server_1",
    "Project" = "Redmine"
  }
}


resource "local_file" "db_config_redmine" {
  content = templatefile("${path.module}/configs/database.yml.template", {
   // DB_HOST     = aws_instance.postgres_db.private_ip
    DB_HOST     = aws_db_instance.redmine_rds_db.address
    DB_USER     = var.db_user_name,
    DB_PASSWORD = var.db_password,
    DB_NAME     = var.db_name,
    DB_ADAPTER  = var.db_adapter
  })
  filename = "${path.module}/configs/database.yml"
}

