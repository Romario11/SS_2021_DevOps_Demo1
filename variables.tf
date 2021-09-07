variable "project" {
  default = "redmine-nginx-postgresql"
}

variable "credentials_file" {
  default = "../redmine-credentials.json"
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-a"
}
variable "user_name" {
  default = "romario"
}


variable "ssh_public_key" {
  default = "../gcp-key"
}
variable "ssh_private_key" {
  default = "~/.ssh/ssh_GCP_private_key"
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