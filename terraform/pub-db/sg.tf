##### DATABASE PRIVATE SG #####
resource "aws_security_group" "db-security-group" {
  name        = "${var.sg-mysql-rds}-${terraform.workspace}-mysql"
  description = "MYSQL security group for ${terraform.workspace} environment"
  vpc_id      = "${element(data.terraform_remote_state.vpc.outputs.vpc-id, 1)}"

  tags = {
    Name          = "${var.sg-mysql-rds}-${terraform.workspace}-mysql"
    Environment   = "${terraform.workspace}"
    Template      = "encs_691k"
    Application   = "auction_system"
    Purpose       = "Security group for public database"
    Creation_Date = "Octobe_7_2020"
  }
}

resource "aws_security_group_rule" "db-security-group-rule-01" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.db-security-group.id}"
}


resource "aws_security_group_rule" "db-security-group-rule-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.db-security-group.id}"
}
