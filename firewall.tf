resource "aws_default_vpc" "redmine_default_vpc" {
  tags = {
    Name = "Redmine default vpc",
    Project= "Redmine"
  }
}

resource "aws_default_subnet" "default_subnet" {
  availability_zone = var.zone
  tags = {
    Name = "Default subnet for redmine"
  }
}

resource "aws_security_group" "db_firewall" {
  name        = "db_firewall"
  description = "Allow inbound traffic in vpc"
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [aws_default_vpc.redmine_default_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "Redmine db firewall",
    Project= "Redmine"
  }
}

resource "aws_security_group" "file_store_firewall" {
  name        = "file_store_firewall"
  description = "Allow inbound traffic in file store"
  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [aws_default_subnet.default_subnet.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "Redmine file store firewall",
    Project= "Redmine"
  }
}

resource "aws_security_group" "load-balancer_firewall" {
  name        = "load-balancer_firewall"
  description = "Allow inbound traffic in vpc for load-balancer"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "Redmine load balancer firewall",
    Project= "Redmine"
  }
}

resource "aws_security_group" "redmine_server_firewall" {
  name        = "redmine_server_firewall"
  description = "Allow inbound traffic in vpc for redmine servers"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [aws_default_vpc.redmine_default_vpc.cidr_block]
   // cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "Redmine redmine servers firewall",
    Project= "Redmine"
  }
}


/*
resource "aws_security_group" "main_firewall" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
 vpc_id = aws_vpc.redmine_vpc.id
   dynamic "ingress" {
     for_each = ["80","443","5432","8080","3000","22"]
     content {
       from_port   = ingress.value
       to_port     = ingress.value
       protocol    = "0"
       cidr_blocks = ["0.0.0.0/0"]
     }
   }
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
*/
