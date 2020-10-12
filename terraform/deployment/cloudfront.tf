resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.s3.bucket_regional_domain_name
    origin_id   = "S3-encs691k.edgardoreinoso.com"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "encs691k distribution for frontend"
  default_root_object = "index.html"

  aliases = ["encs691k.edgardoreinoso.com"]

  # Behaviors
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-encs691k.edgardoreinoso.com"
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "redirect-to-https"
    # optionals
    min_ttl                = 1
    default_ttl            = 86400
    max_ttl                = 31536000
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  price_class = "PriceClass_All"

  tags = {
    Name          = "encs691_distribution"
    Environment   = "${terraform.workspace}"
    Template      = "${var.template}"
    Application   = "${var.application}"
    Creation_Date = "${var.created-on}"
    Purpose       = "Distribution for the frontend"
  }

  # Certifications
  viewer_certificate {
    cloudfront_default_certificate = true
    acm_certificate_arn            = ""
    ssl_support_method             = "sni-only" # AWS Console - Custom SSL Client Support
  }
}
