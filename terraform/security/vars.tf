variable "AWS_REGIONS" {
  default = "us-east-1"
}

variable "sg-mysql-rds" {
  type    = "string"
  default = "database-sg"
}

variable "sg-windows-ec2" {
  type    = "string"
  default = "windows-sg"
}

variable "sg-nodejs-ec2" {
  type    = "string"
  default = "nodejs-sg"
}

variable "sg-bastion-ec2" {
  type    = "string"
  default = "bastion-sg"
}

variable "sg-elb" {
  type    = "string"
  default = "elb-sg"
}

variable "ips" {
  type    = "string"
  default = "24.60.137.153/32,142.122.59.149/32,67.68.223.202/32"
}
