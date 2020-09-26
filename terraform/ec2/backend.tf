terraform {
  backend "s3" {
    bucket         = "terraform-state-concordia"
    dynamodb_table = "terraform-state-lock-ddb"
    region         = "us-east-1"
    key            = "ec2/terraform.tfstate" # this would come to be the name of the file
  }
}

