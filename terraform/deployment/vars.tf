variable "AWS_REGIONS" {
  default = "us-east-1"
}

variable "template" {
  type    = "string"
  default = "encs_691k"
}

variable "created-on" {
  type    = "string"
  default = "October_11_2020"
}

variable "application" {
  type    = "string"
  default = "auction_system"
}

# S3
  variable "bucket-name" {
    type    = "string"
    default = "encs691k.edgardoreinoso.com"
  }

  variable "acl" {
    type    = "string"
    default = "public-read"
  }

  variable "destroy" {
    type    = "string"
    default = "true"
  }

  variable "account-id" {
    type    = "string"
    default = "109139691401" # your account ID
  }
