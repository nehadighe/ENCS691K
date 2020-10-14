### SECURITY GROUPS ###
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-state-concordia"
    key    = "env:/dev/network/terraform.tfstate"
    region = "us-east-1"
  }
}

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
    Purpose       = "Security group for database"
    Creation_Date = "September_24_2020"
  }
}

resource "aws_security_group_rule" "db-security-group-rule-01" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.windows-security-group.id}"
  security_group_id        = "${aws_security_group.db-security-group.id}"
  description = "rules to allow MYSQL traffic from windows server"
}

resource "aws_security_group_rule" "db-security-group-rule-02" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion-security-group.id}"
  security_group_id        = "${aws_security_group.db-security-group.id}"
  description = "rules to allow MYSQL traffic from bastion NAT server"
}

resource "aws_security_group_rule" "db-security-group-rule-03" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.node-security-group.id}"
  security_group_id        = "${aws_security_group.db-security-group.id}"
  description = "rules to allow MYSQL traffic from cluster"
}

resource "aws_security_group_rule" "db-security-group-rule-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.db-security-group.id}"
}

##### EC2 PRIVATE SG #####
resource "aws_security_group" "windows-security-group" {
  name        = "${var.sg-windows-ec2}-${terraform.workspace}-rdp"
  description = "Windows security group for ${terraform.workspace} environment"
  vpc_id      = "${element(data.terraform_remote_state.vpc.outputs.vpc-id, 1)}"

  tags = {
    Name          = "${var.sg-windows-ec2}-${terraform.workspace}-rdp"
    Environment   = "${terraform.workspace}"
    Template      = "encs_691k"
    Application   = "auction_system"
    Purpose       = "Windows security group for database"
    Creation_Date = "September_24_2020"
  }
}

resource "aws_security_group_rule" "windows-security-group-rule-01" {
  type        = "ingress"
  from_port   = 3389
  to_port     = 3389
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  # cidr_blocks       = "${split(",", var.ips)}"
  security_group_id = "${aws_security_group.windows-security-group.id}"
}

resource "aws_security_group_rule" "windows-security-group-rule-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.windows-security-group.id}"
}

##### EC2 BASTION SG #####
resource "aws_security_group" "bastion-security-group" {
  name        = "${var.sg-bastion-ec2}-${terraform.workspace}-ssh"
  description = "Bastion security group for ${terraform.workspace} environment"
  vpc_id      = "${element(data.terraform_remote_state.vpc.outputs.vpc-id, 1)}"

  tags = {
    Name          = "${var.sg-bastion-ec2}-${terraform.workspace}-ssh"
    Environment   = "${terraform.workspace}"
    Template      = "encs_691k"
    Application   = "auction_system"
    Purpose       = "Bastion host security group"
    Creation_Date = "October_5_2020"
  }
}

resource "aws_security_group_rule" "bastion-security-group-rule-01" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks       = "${split(",", var.ips)}"
  description = "rules from our local ips"
  security_group_id = "${aws_security_group.bastion-security-group.id}"
}

resource "aws_security_group_rule" "bastion-security-group-rule-02" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["10.0.0.64/27", "10.0.0.128/27"]
  description = "rules to allow HTTP traffic flow to subnets - app a and b"
  security_group_id = "${aws_security_group.bastion-security-group.id}"
}

resource "aws_security_group_rule" "bastion-security-group-rule-03" {
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["10.0.0.64/27", "10.0.0.128/27"]
  security_group_id = "${aws_security_group.bastion-security-group.id}"
  description = "rules to allow HTTPS traffic flow to subnets - app a and b"
}

resource "aws_security_group_rule" "bastion-security-group-rule-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.bastion-security-group.id}"
}

##### EC2 SERVER SG #####
resource "aws_security_group" "node-security-group" {
  name        = "${var.sg-nodejs-ec2}-${terraform.workspace}"
  description = "NodeJS security group for ${terraform.workspace} environment"
  vpc_id      = "${element(data.terraform_remote_state.vpc.outputs.vpc-id, 1)}"

  tags = {
    Name          = "${var.sg-nodejs-ec2}-${terraform.workspace}"
    Environment   = "${terraform.workspace}"
    Template      = "encs_691k"
    Application   = "auction_system"
    Purpose       = "EC2 security group for database"
    Creation_Date = "October_5_2020"
  }
}

resource "aws_security_group_rule" "node-security-group-rule-01" {
  type                     = "ingress"
  from_port                = 8081
  to_port                  = 8081
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.elb-security-group.id}"
  security_group_id        = "${aws_security_group.node-security-group.id}"
  description = "rules to allow traffic from load balancer to the cluster"
}

resource "aws_security_group_rule" "node-security-group-rule-02" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion-security-group.id}"
  security_group_id        = "${aws_security_group.node-security-group.id}"
  description = "rules to allow traffic coming into the cluster through the NAT host"
}

resource "aws_security_group_rule" "node-security-group-rule-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.node-security-group.id}"
}

##### ELB SG #####
resource "aws_security_group" "elb-security-group" {
  name        = "${var.sg-elb}-${terraform.workspace}-http"
  description = "ELB security group for ${terraform.workspace} environment"
  vpc_id      = "${element(data.terraform_remote_state.vpc.outputs.vpc-id, 1)}"

  tags = {
    Name          = "${var.sg-elb}-${terraform.workspace}-http"
    Environment   = "${terraform.workspace}"
    Template      = "encs_691k"
    Application   = "auction_system"
    Purpose       = "ELB security group for database"
    Creation_Date = "October_5_2020"
  }
}

resource "aws_security_group_rule" "ec2-security-group-rule-01" {
  type              = "ingress"
  from_port         = 8081
  to_port           = 8081
  protocol          = "https"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb-security-group.id}"
  description = "rules to allow all incoming HTTP traffic to the load balancer"
}

resource "aws_security_group_rule" "ec2-security-group-rule-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb-security-group.id}"
}
