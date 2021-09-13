
resource "aws_security_group" "main_firewall" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
 // vpc_id = aws_vpc.redmine_vpc.id
  /* dynamic "ingress" {
     for_each = ["80","443","5432","8080","3000","22"]
     content {
       from_port   = ingress.value
       to_port     = ingress.value
       protocol    = "0"
       cidr_blocks = ["0.0.0.0/0"]
     }
   }*/
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "allow_all"
  }
}

