resource "aws_s3_bucket" "s3" {
  bucket        = "${var.bucket-name}"
  acl           = "${var.acl}"
  force_destroy = "${var.destroy}"
  policy = file("policy.json")
  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    Name          = "encs691k_frontend_bucket"
    Template      = "${var.template}"
    Environment   = "${terraform.workspace}"
    Application   = "${var.application}"
    Purpose       = "Bucket to put the frontend code"
    Creation_Date = "${var.created-on}"
  }
}
