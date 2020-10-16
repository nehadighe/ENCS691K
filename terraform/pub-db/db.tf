module "new-rds" {
  source                 = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/storage/rds"
  allocated-storage      = "${var.storage}" # optionals since we using snapshot identifier
  engine                 = "${var.engine}"
  storage-type           = "${var.storage-type}"
  db-identifier          = "encs691k-${terraform.workspace}"
  db-name                = "${var.db-name}"
  username               = "${var.username}"
  password               = "${var.password}"
  engine-version         = "${var.engine-version}"
  instance-class         = "${var.instance-class}"
  rds-name               = "${var.rds-name}-${terraform.workspace}-private"
  db-subnet-group        = "${aws_db_subnet_group.rds-subnet-group-private.id}"
  publicly-accessible    = "${var.publicly-accessible}"
  vpc-security-group-ids = "${split(",", aws_security_group.db-security-group.id)}"
  availability-zone      = "us-east-1b"
  db-port                = "${var.db-port}"
  maintenance-windows    = "Sun:00:00-Sun:03:00"
  final-snapshot         = "empty"
  skip-final             = "${var.skip-final-snapshot}"
  tags = {
    Name          = "pub-encs691k-${terraform.workspace}"
    Template      = "encs_691k"
    Environment   = "${terraform.workspace}"
    Application   = "auction_system"
    Purpose       = "Public MYSQL database set up for the auction application"
    Creation_Date = "September_25_2020"
  }
}

resource "aws_db_subnet_group" "rds-subnet-group-private" {
  name       = "${var.subnet-group-name}-encs_691k-${terraform.workspace}"
  subnet_ids = ["${element(element(data.terraform_remote_state.vpc.outputs.pub-subnet-id-a, 0), 0)}", "${element(element(data.terraform_remote_state.vpc.outputs.pub-subnet-id-b, 0), 0)}"]

  tags = {
    Name          = "Auction_System_SubnetGroups"
    Template      = "encs_691k"
    Environment   = "${terraform.workspace}"
    Application   = "auction_system"
    Purpose       = "setting up subnet groups for the MYSQL database"
    Creation_Date = "September_25_2020"
  }
}

resource "aws_route53_record" "db_record" {
  zone_id = "Z02263174XWJY3JJ7BCP"
  name    = "pubdb"
  type    = "CNAME"
  ttl     = "300"
  records = ["${module.new-rds.rds-address}"]
}