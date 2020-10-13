module "elb" {
  source         = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/compute/load-balancer/elb"
  elb-name       = "${var.elb-name}"
  internal-elb   = "${var.internal-elb}"
  elb-type       = "${var.elb-type}"
  security-group = "${split(",", data.terraform_remote_state.security.outputs.elb-security-group)}"
  subnet-ids = ["${element(
    element(data.terraform_remote_state.vpc.outputs.pub-subnet-id-a, 1),
    1,
    )}", "${element(
    element(data.terraform_remote_state.vpc.outputs.pub-subnet-id-b, 1),
    1,
  )}"]
  bucket-name = "${var.bucket-name}"
  tags = {
    Name          = "encs691_load_balancer"
    Template      = "encs_691k"
    Environment   = "${terraform.workspace}"
    Application   = "auction_system"
    Purpose       = "Load Balance requests coming into application layer"
    Creation_Date = "October_13_2020"
  }
}

module "target-group" {
  source         = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/compute/load-balancer/tg"
  vpc-id         = "${element(data.terraform_remote_state.vpc.outputs.vpc-id, 1)}"
  elb-tg-name    = "${var.elb-tg-name}"
  tg-port        = "${var.tg-port}"
  deregistration = "${var.tg-deregister}"
  tg-protocol    = "${var.tg-protocol}"
  tg-target-type = "${var.tg-target-type}"
}

# module "target-group-attachment" {
#   source           = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/compute/load-balancer/tgAttachment"
#   tg-id            = "${module.web-server.ec2-id}"
#   target-group-arn = "${module.target-group.target-arn}"
#   port             = "${var.tg-port}"
# }

module "listener" {
  source            = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/compute/load-balancer/listener"
  elb-arn           = "${module.elb.elb-arn}"
  target-group-arn  = "${module.target-group.target-arn}"
  listener-port     = "${var.tg-port}"
  listener-protocol = "${var.tg-protocol}"
}

resource "aws_s3_bucket" "s3" {
  bucket        = "${var.bucket-name}"
  acl           = "${var.acl}"
  force_destroy = "${var.destroy}"

  policy = <<POLICY
{
  "Id": "Policy1566872708101",
  "Version": "2012-10-17",
  "Statement": [
      {
          "Sid": "Stmt1566872706748",
          "Action": [
              "s3:PutObject"
          ],
          "Effect": "Allow",
          "Resource": "arn:aws:s3:::${var.bucket-name}/AWSLogs/${var.account-id}/*",
          "Principal": {
              "AWS": [
                  "127311923021"
              ]
          }
      }
  ]
}
POLICY

  tags = {
    Name          = "encs691_elb_logs_bucket"
    Template      = "encs_691k"
    Environment   = "${terraform.workspace}"
    Application   = "auction_system"
    Purpose       = "Load Balance requests coming into application layer"
    Creation_Date = "October_13_2020"
  }
}
