output "db-security-group" {
  value = "${aws_security_group.db-security-group.id}"
}

output "ec2-security-group" {
  value = "${aws_security_group.ec2-security-group.id}"
}