variable "AWS_REGIONS" {
  default = "us-east-1"
}

variable "sg-name-db-pri" {
  type    = "string"
  default = "database-sg-private"
}

variable "ips" {
  type    = "string"
  default = "24.60.137.153/32"
}
