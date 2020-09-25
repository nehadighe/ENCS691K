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

module "new-rds" {
  source                 = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/storage/rds"
  allocated-storage      = "${var.storage}" # optionals since we using snapshot identifier
  engine                 = "${var.engine}"
  storage-type           = "${var.storage-type}"
  db-identifier          = "encs691k-${terraform.workspace}"
  db-name                = "${var.db-name}"
  username               = "${var.username}"
  password               = "${var.password}" # need to have a secure way of keeping this
  engine-version         = "${var.engine-version}"
  instance-class         = "${var.instance-class}"
  rds-name               = "${var.rds-name}-${terraform.workspace}-private"
  db-subnet-group        = "${aws_db_subnet_group.rds-subnet-group-private.id}"
  publicly-accessible    = "${var.publicly-accessible}"
  vpc-security-group-ids = "${split(",", data.terraform_remote_state.security.outputs.db-security-group)}"
  availability-zone      = "us-east-1a"
  db-port                = "${var.db-port}"
  final-snapshot         = "${var.final-snapshot}-${formatdate("MMMM-DD-YYYY-hh-mm-ss", timestamp())}"
  skip-final             = "${var.skip-final-snapshot}"
  tags = {
    Name          = "encs691k-${terraform.workspace}"
    Template      = "encs_691k"
    Environment   = "${terraform.workspace}"
    Application   = "auction_system"
    Purpose       = "MYSQL database set up for the auction application"
    Creation_Date = "September_25_2020"
  }
}

resource "aws_db_subnet_group" "rds-subnet-group-private" {
  name       = "encs_691k-${var.subnet-group-name}-${terraform.workspace}"
  subnet_ids = ["${element(element(data.terraform_remote_state.vpc.outputs.pri-subnet-id-a, 1), 1)}", "${element(element(data.terraform_remote_state.vpc.outputs.pri-subnet-id-b, 1), 1)}"]

  tags = {
    Name          = "Auction_System_SubnetGroups"
    Template      = "encs_691k"
    Environment   = "${terraform.workspace}"
    Application   = "auction_system"
    Purpose       = "setting up subnet groups for the MYSQL database"
    Creation_Date = "September_25_2020"
  }
}
