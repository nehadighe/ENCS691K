output "elb-security-group" {
  value = "${aws_security_group.elb-security-group.id}"
}

output "bastion-security-group" {
  value = "${aws_security_group.bastion-security-group.id}"
}

output "windows-security-group" {
  value = "${aws_security_group.windows-security-group.id}"
}

output "database-security-group" {
  value = "${aws_security_group.db-security-group.id}"
}

output "node-security-group" {
  value = "${aws_security_group.node-security-group.id}"
}