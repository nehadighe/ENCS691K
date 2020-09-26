### SECURITY GROUPS ###
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-state-concordia"
    key    = "env:/dev/network/terraform.tfstate"
    region = "us-east-1"
  }
}

## DATABASE PRIVATE SG
resource "aws_security_group" "db-security-group" {
  name        = "${var.sg-name-db-pri}-${terraform.workspace}-mysql"
  description = "MYSQL security group for ${terraform.workspace} environment"
  vpc_id      = "${element(data.terraform_remote_state.vpc.outputs.vpc-id, 1)}"

  tags = {
    Name          = "${var.sg-name-db-pri}-${terraform.workspace}-mysql"
    Environment   = "${terraform.workspace}"
    Template      = "encs_691k"
    Application   = "auction_system"
    Purpose       = "security group for database"
    Creation_Date = "September_24_2020"
  }
}

resource "aws_security_group_rule" "db-security-group-rule-01" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.ec2-security-group.id}"
  security_group_id        = "${aws_security_group.db-security-group.id}"
}

resource "aws_security_group_rule" "db-security-group-rule-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.db-security-group.id}"
}
