data "aws_ami" "amazon-linux-2" {
    most_recent = true
    owners = ["amazon"]

    filter {
        name   = "name"
        values = [ "${var.ami_name}" ]
    }
}

resource "aws_security_group" "dev-sg" {
    vpc_id = "${var.vpc_id}"

    ingress {
        from_port = 3000
        to_port = 3000
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = {
        Name = "dev-sg"
    }
}

resource "aws_key_pair" "dev-kp" {
    key_name = "dev-server-key"
    public_key = file("${var.public_key}")
}

resource "aws_instance" "dev-server" {
    ami = "${data.aws_ami.amazon-linux-2.id}"
    instance_type = "t2.micro"
    associate_public_ip_address = true
    subnet_id = "${var.subnet_id}"
    vpc_security_group_ids = [ "${aws_security_group.dev-sg.id}" ]
    key_name = "${aws_key_pair.dev-kp.key_name}"

    tags = {
        Name = "dev-server"
    }
}