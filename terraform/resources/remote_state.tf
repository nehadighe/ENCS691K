### EC2 ###
data "terraform_remote_state" "security" {
  backend = "s3"
  config = {
    bucket = "terraform-state-concordia"
    key    = "env:/dev/security/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-state-concordia"
    key    = "env:/dev/network/terraform.tfstate"
    region = "us-east-1"
  }
}
