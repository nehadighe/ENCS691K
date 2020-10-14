# module "elb" {
#   source         = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/compute/load-balancer/elb"
#   elb-name       = "${var.elb-name}"
#   internal-elb   = "${var.internal-elb}"
#   elb-type       = "${var.elb-type}"
#   security-group = "${split(",", data.terraform_remote_state.security.outputs.elb-security-group)}"
#   subnet-ids = ["${element(
#     element(data.terraform_remote_state.vpc.outputs.pub-subnet-id-a, 1),
#     1,
#     )}", "${element(
#     element(data.terraform_remote_state.vpc.outputs.pub-subnet-id-b, 1),
#     1,
#   )}"]
#   bucket-name = "${var.bucket-name}"
#   tags = {
#     Name          = "encs691_load_balancer"
#     Template      = "encs_691k"
#     Environment   = "${terraform.workspace}"
#     Application   = "auction_system"
#     Purpose       = "Load Balance requests coming into application layer"
#     Creation_Date = "October_13_2020"
#   }
# }

# module "target-group" {
#   source         = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/compute/load-balancer/tg"
#   vpc-id         = "${element(data.terraform_remote_state.vpc.outputs.vpc-id, 1)}"
#   elb-tg-name    = "${var.elb-tg-name}"
#   tg-port        = "${var.tg-port}"
#   deregistration = "${var.tg-deregister}"
#   tg-protocol    = "HTTP"
#   tg-target-type = "${var.tg-target-type}"
# }

# module "listener" {
#   source            = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/compute/load-balancer/listener"
#   elb-arn           = "${module.elb.elb-arn}"
#   listener-port     = "${var.tg-port}"
#   target-group-arn  = "${module.target-group.target-arn}"
#   listener-protocol = "HTTP"
# }

# # module "listener" {
# #   source            = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/compute/load-balancer/listener"
# #   elb-arn           = "${module.elb.elb-arn}"
# #   listener-port     = "${var.tg-port}"
# #   target-group-arn  = "${module.target-group.target-arn}"
# #   ssl-policy        = "ELBSecurityPolicy-2016-08"
# #   listener-protocol = "HTTPS"
# #   certificate-arn   = "arn:aws:acm:us-east-1:109139691401:certificate/97031fb3-bc26-4123-8e1d-f1b395204461"
# # }

# resource "aws_s3_bucket" "s3" {
#   bucket        = "${var.bucket-name}"
#   acl           = "${var.acl}"
#   force_destroy = "${var.destroy}"

#   policy = <<POLICY
# {
#   "Id": "Policy1566872708101",
#   "Version": "2012-10-17",
#   "Statement": [
#       {
#           "Sid": "Stmt1566872706748",
#           "Action": [
#               "s3:PutObject"
#           ],
#           "Effect": "Allow",
#           "Resource": "arn:aws:s3:::${var.bucket-name}/AWSLogs/${var.account-id}/*",
#           "Principal": {
#               "AWS": [
#                   "127311923021"
#               ]
#           }
#       }
#   ]
# }
# POLICY

#   tags = {
#     Name          = "encs691_elb_logs_bucket"
#     Template      = "encs_691k"
#     Environment   = "${terraform.workspace}"
#     Application   = "auction_system"
#     Purpose       = "Load Balance requests coming into application layer"
#     Creation_Date = "October_13_2020"
#   }
# }

# # resource "aws_route53_record" "elb_record" {
# #   zone_id = "Z02263174XWJY3JJ7BCP"
# #   name    = "elb"
# #   type    = "A"
# #   alias {
# #     name = "${module.elb.elb-dns-name}"

# #     # name                   = "${aws_elb.main.dns_name}"
# #     zone_id = "${module.elb.elb-zone-id}"

# #     # zone_id                = "${aws_elb.main.zone_id}"
# #     evaluate_target_health = true
# #   }
# # }
