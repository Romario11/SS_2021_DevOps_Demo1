resource "aws_instance" "load_balancer" {
  instance_type = "t3.small"
  key_name      = aws_key_pair.public_key.key_name
  ami           = data.aws_ami.ubuntu.id
  //subnet_id = aws_subnet.main.id

  user_data = templatefile(var.load_balancer_start_script,{USER_NAME=var.user_name})
  vpc_security_group_ids = [aws_security_group.load-balancer_firewall.id]
  //vpc_security_group_ids = [aws_security_group.main_firewall.id]

  provisioner "file" {
    source      = "${path.module}/configs/nginx.conf"
    destination = "/home/${var.user_name}/nginx.conf"
    connection {
      type        = "ssh"
      user        = var.user_name
      host        = self.public_ip
      private_key = file(var.ssh_private_key)
    }
  }

  depends_on = [local_file.load_balancer_config]
  tags = {
    "Name"    = "NGINX_load_balancer",
    "Project" = "Redmine"
  }
}

resource "local_file" "load_balancer_config" {
  content = templatefile("${path.module}/configs/nginx.conf.template", {
    REDMINE_SERVER1 = aws_instance.back_end_server_1.private_ip,
    REDMINE_SERVER2 = aws_instance.back_end_server_2.private_ip
  })
  filename = "${path.module}/configs/nginx.conf"
}

