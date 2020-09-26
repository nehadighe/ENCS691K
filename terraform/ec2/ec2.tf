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

module "windows-server" {
  source        = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/compute/ec2"
  ami           = "ami-0eb7fbcc77e5e6ec6"
  instance-type = "t2.micro"
  key-name      = "encs691k_keys"
  public-ip     = "true"
  sourceCheck   = "false"
  subnet-ids = "${element(
    element(data.terraform_remote_state.vpc.outputs.pub-subnet-id-a, 0),
    0,
  )}"
  security-group-ids = "${split(",", data.terraform_remote_state.security.outputs.ec2-security-group)}"
  tags = {
    Name          = "RDP_windows_server_a"
    Template      = "encs_691k"
    Environment   = "${terraform.workspace}"
    Application   = "auction_system"
    Purpose       = "Windows server to RDP to the DB"
    Creation_Date = "September_26_2020"
  }
}

module "private-routes" {
  source       = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/network/route-tables/route"
  routeTableId = "${element(data.terraform_remote_state.vpc.outputs.private-rt-id, 1)}"
  instanceId   = "${module.windows-server.ec2-id}"
  destination  = "0.0.0.0/0"
}

