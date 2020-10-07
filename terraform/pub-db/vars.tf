variable "AWS_REGIONS" {
  default = "us-east-1"
}

## SG ##

variable "sg-mysql-rds" {
  type    = "string"
  default = "pub-database-sg"
}

variable "ips" {
  type    = "string"
  default = "24.60.137.153/32,142.122.59.149/32,67.68.223.202/32"
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
  default = "true"
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
  default = "true"
}

variable "db-name" {
  type    = "string"
  default = "auctionsystem"
}

variable "username" {
  type    = "string"
  default = ""
}

variable "password" {
  type    = "string"
  default = ""
}

## SUBNET GROUPS ##

variable "subnet-group-name" {
  type    = "string"
  default = "pub-subnet-group"
}
