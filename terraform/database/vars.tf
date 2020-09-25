variable "AWS_REGIONS" {
  default = "us-east-1"
}

## RDS ##

variable "engine" {
  type    = "string"
  default = "mysql"
}

variable "storage" {
  type    = "string"
  default = "20"
}

variable "storage-type" {
  type    = "string"
  default = "gp2"
}

variable "engine-version" {
  type    = "string"
  default = "5.7.22"
}

variable "instance-class" {
  type    = "string"
  default = "db.t2.micro"
}

variable "rds-name" {
  type    = "string"
  default = "auction-system"
}

variable "publicly-accessible" {
  type    = "string"
  default = "false"
}

variable "db-port" {
  type    = "string"
  default = "3306"
}

variable "final-snapshot" {
  type    = "string"
  default = "terraform-final-snapshot"
}

variable "skip-final-snapshot" {
  type    = "string"
  default = "false"
}

variable "db-name" {
  type    = "string"
  default = "auctionsystem"
}

variable "username" {
  type    = "string"
  default = "admin"
}

variable "password" {
  type    = "string"
  default = "Encs691K"
}

## SUBNET GROUPS ##

variable "subnet-group-name" {
  type    = "string"
  default = "subnet-group"
}