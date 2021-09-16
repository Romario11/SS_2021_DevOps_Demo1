
variable "access_key" {
  default = "~/.ssh/aws_access_key"
}
variable "secret_key" {
  default = "~/.ssh/aws_secret_key"
}


variable "region" {
  default = "us-east-1"
}
variable "zone" {
  default = "us-east-1b"
}
variable "user_name" {
  default = "ubuntu"
}


variable "ssh_public_key" {
  default = "~/.ssh/public-aws"
}
variable "ssh_private_key" {
  default = "~/.ssh/my-aws-keys.pem"
}
variable "network_name" {
  default = "default"
}

variable "load_balancer_start_script" {
  default = "start-scripts/nginx-balancer-start.sh"
}

variable "redmine_start_script" {
  default = "start-scripts/redmine-ruby-start.sh"
}

variable "db_start_script" {
  default = "start-scripts/postgresql-start.sh"
}
//Database
variable "db_adapter" {
  default ="postgresql"
}
variable "db_name" {
  default ="redmine"
}
variable "db_user_name" {
  default ="redmine"
}
variable "db_password" {
  default ="my_password"
}
variable "ami_ubuntu" {
  default ="ami-09e67e426f25ce0d7"
}
