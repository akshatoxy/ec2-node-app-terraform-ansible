resource "aws_vpc" "dev-vpc" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Name = "dev-vpc"
    }
}

resource "aws_internet_gateway" "dev-igw" {
    vpc_id = "${aws_vpc.dev-vpc.id}"

    tags = {
        Name = "dev-igw"
    }
}

resource "aws_route_table" "dev-rt" {
    vpc_id = "${aws_vpc.dev-vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.dev-igw.id}"
    }

    tags = {
        Name = "dev-rt"
    }
}

resource "aws_subnet" "dev-subnet" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    cidr_block = "${var.subnet_cidr}"
    availability_zone = "${var.subnet_az}"
    map_public_ip_on_launch = true

    tags = {
        Name = "dev-subnet"
    }
}

resource "aws_route_table_association" "dev-rta" {
    subnet_id = "${aws_subnet.dev-subnet.id}"
    route_table_id = "${aws_route_table.dev-rt.id}"
}