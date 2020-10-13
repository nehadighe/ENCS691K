variable "AWS_REGIONS" {
  default = "us-east-1"
}


### VPC ###
variable "vpc-cidr" {
  type = "map"

  default = {
    dev = "10.0.0.0/24"
  }
}

variable "vpc-dns-hostname" {
  type    = "string"
  default = true
}

variable "vpc-dns-support" {
  type    = "string"
  default = true
}

### Flow logs ###
variable "flow-logs-name" {
  type    = "string"
  default = ""
}

variable "log-destination" {
  type    = "string"
  default = "/vpc/encs691/flow-logs" #for now this would be example
}

variable "traffic-type" {
  type    = "string"
  default = "ALL"
}

variable "role-policy-name" {
  type    = "string"
  default = "flow-logs-policy"
}

variable "role-name" {
  type    = "string"
  default = "flow-logs-roles"
}

variable "max-aggregation-interval" {
  type    = "string"
  default = "600"
}

### INTERNET GATEWAY ###
variable "igw-name" {
  type    = "string"
  default = "encs_691k_igw"
}

### SUBNETS ###
# SUBNETS: PUBLIC #
variable "public-type" {
  type    = "string"
  default = "public"
}

variable "public-subnet-cidr-1-a" {
  type = "map"

  default = {
    dev = "10.0.0.0/27"
  }
}

variable "public-subnet-name-1-a" {
  type = "map"

  default = {
    dev = "public-subnet-01-a"
  }
}

variable "public-subnet-cidr-1-b" {
  type = "map"

  default = {
    dev = "10.0.0.32/27"
  }
}

variable "public-subnet-name-1-b" {
  type = "map"

  default = {
    dev = "public-subnet-01-b"
  }
}

# SUBNETS: PRIVATE #
variable "private-type" {
  type    = "string"
  default = "private"
}

variable "main-subnet" {
  type    = "string"
  default = "main-subnet"
}

variable "private-subnet-cidr-1-a" {
  type = "map"

  default = {
    dev = "10.0.0.64/27,10.0.0.96/27"
  }
}

variable "private-subnet-name-1-a" {
  type = "map"

  default = {
    dev = "private-app-subnet-01-a,private-db-subnet-01-a"
  }
}

variable "private-subnet-cidr-1-b" {
  type = "map"

  default = {
    dev = "10.0.0.128/27,10.0.0.160/27"
  }
}

variable "private-subnet-name-1-b" {
  type = "map"

  default = {
    dev = "private-app-subnet-01-b,private-db-subnet-01-b"
  }
}

### ROUTE TABLES ###
variable "public-route-table" {
  type    = "string"
  default = "public-route-table"
}

variable "private-route-table" {
  type    = "string"
  default = "private-route-table"
}

variable "destinationRoute" {
  type    = "string"
  default = "0.0.0.0/0"
}
