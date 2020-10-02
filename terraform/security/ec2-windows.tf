## EC2 PRIVATE SG
resource "aws_security_group" "ec2-security-group" {
  name        = "${var.sg-name-ec2-pri}-${terraform.workspace}-mysql"
  description = "MYSQL security group for ${terraform.workspace} environment"
  vpc_id      = "${element(data.terraform_remote_state.vpc.outputs.vpc-id, 1)}"

  tags = {
    Name          = "${var.sg-name-ec2-pri}-${terraform.workspace}-rdp"
    Environment   = "${terraform.workspace}"
    Template      = "encs_691k"
    Application   = "auction_system"
    Purpose       = "security group for database"
    Creation_Date = "September_24_2020"
  }
}

resource "aws_security_group_rule" "ec2-security-group-rule-01" {
  type              = "ingress"
  from_port         = 3389
  to_port           = 3389
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  # cidr_blocks       = "${split(",", var.ips)}"
  security_group_id = "${aws_security_group.ec2-security-group.id}"
}

resource "aws_security_group_rule" "ec2-security-group-rule-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ec2-security-group.id}"
}
