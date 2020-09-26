variable "AWS_REGIONS" {
  default = "us-east-1"
}

variable "sg-name-db-pri" {
  type    = "string"
  default = "database-sg-private"
}

variable "sg-name-ec2-pri" {
  type    = "string"
  default = "ec2-sg-private"
}

variable "ips" {
  type    = "string"
  default = "24.60.137.153/32,142.122.59.149/32,67.68.223.202/32"
}
