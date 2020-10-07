## AMI ##

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["self"]

  filter {
    name = "name"
    values = [
      "NAT_amazon_linux",
    ]
  }
}

data "aws_ami" "windows" {
  most_recent = true

  owners = ["self"]

  filter {
    name = "name"
    values = [
      "windows-ami",
    ]
  }
}

## EC2 BASTION ##
module "bastion-server" {
  source        = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/compute/ec2"
  ami           = "${data.aws_ami.amazon_linux.id}"
  instance-type = "t2.micro"
  key-name      = "encs691k_keys"
  public-ip     = "true"
  sourceCheck   = "" # emtpy values signifiy false
  subnet-ids = "${element(
    element(data.terraform_remote_state.vpc.outputs.pub-subnet-id-b, 0),
    0,
  )}"
  security-group-ids = "${split(",", data.terraform_remote_state.security.outputs.bastion-security-group)}"
  tags = {
    Name          = "SSH_linux_bastion_b"
    Template      = "encs_691k"
    Environment   = "${terraform.workspace}"
    Application   = "auction_system"
    Purpose       = "SSH Bastion"
    Creation_Date = "October_5_2020"
  }
}

## EC2 NODE ##
module "web-server" {
  source             = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/compute/ec2"
  ami                = "${var.ami}"
  instance-type      = "t2.micro"
  key-name           = "encs691k_keys"
  public-ip          = "" # emtpy values signifiy false
  sourceCheck        = "true"
  user-data          = "${file("file.sh")}"
  security-group-ids = "${split(",", data.terraform_remote_state.security.outputs.node-security-group)}"
  subnet-ids = "${element(
    element(data.terraform_remote_state.vpc.outputs.pri-subnet-id-b, 1),
    0,
  )}"
  #   user-data = "${file("build.sh")}"
  tags = {
    Name          = "NodeJs_server_a"
    Template      = "encs_691k"
    Environment   = "${terraform.workspace}"
    Application   = "auction_system"
    Purpose       = "Backend server for auction system"
    Creation_Date = "October_5_2020"
  }
}

## EC2 WINDOWS ##
# module "windows-server" {
#   #   ami           = "ami-0eb7fbcc77e5e6ec6"
#   source        = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/compute/ec2"
#   ami           = "${data.aws_ami.windows.id}"
#   instance-type = "t2.micro"
#   key-name      = "encs691k_keys"
#   public-ip     = "true"
#   sourceCheck   = "true"
#   subnet-ids = "${element(
#     element(data.terraform_remote_state.vpc.outputs.pub-subnet-id-a, 0),
#     0,
#   )}"
#   security-group-ids = "${split(",", data.terraform_remote_state.security.outputs.windows-security-group)}"
#   tags = {
#     Name          = "RDP_windows_server_a"
#     Template      = "encs_691k"
#     Environment   = "${terraform.workspace}"
#     Application   = "auction_system"
#     Purpose       = "Windows server to RDP to the DB"
#     Creation_Date = "September_26_2020"
#   }
# }

module "private-routes-bastion" {
  source       = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/network/route-tables/route"
  routeTableId = "${element(data.terraform_remote_state.vpc.outputs.private-rt-id, 1)}"
  instanceId   = "${module.bastion-server.ec2-id}"
  destination  = "0.0.0.0/0"
}
