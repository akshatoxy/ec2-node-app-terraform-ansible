output "vpc" {
    value = "${aws_vpc.dev-vpc}"
}

output "subnet" {
    value = "${aws_subnet.dev-subnet}"
}