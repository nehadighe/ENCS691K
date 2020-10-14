variable "AWS_REGIONS" {
  default = "us-east-1"
}

## ELB ##

  variable "elb-name" {
    type    = "string"
    default = "encs691k"
  }

  variable "elb-type" {
    type    = "string"
    default = "application"
  }

  variable "internal-elb" {
    type    = "string"
    default = "false"
  }

  variable "elb-tg-name" {
    type = "string"
    default = "auction-system-tg"
  }

  variable "tg-port" {
    type    = "string"
    default = "8081"
  }

  variable "tg-protocol" {
    type    = "string"
    default = "HTTPS"
  }

  variable "tg-target-type" {
    type    = "string"
    default = "ip"
  }

  variable "tg-deregister" {
    type = "string"

    # monitor for change
    default = "400"
  }

## S3 ##
  variable "bucket-name" {
    type    = "string"
    default = "encs691-elb-logs"
  }

  variable "acl" {
    type    = "string"
    default = "private"
  }

  variable "destroy" {
    type    = "string"
    default = "true"
  }

  variable "account-id" {
    type    = "string"
    default = "109139691401" # your account ID
  }


## EC2 ##

  variable "ami" {
    type    = "string"
    default = "ami-0947d2ba12ee1ff75"
  }

  variable "nat-custom-ami" {
    type    = "string"
    default = "ami-0f4ed5dc032b76164"
  }
  
  variable "windows-custom-ami" {
    type    = "string"
    default = "ami-03441dbf099a77606"
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
    default = "encs691k!"
  }

## SUBNET GROUPS ##

  variable "subnet-group-name" {
    type    = "string"
    default = "subnet-group"
  }