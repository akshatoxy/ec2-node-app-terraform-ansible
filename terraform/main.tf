provider "aws" {
    region = "us-east-1"
}

module "myapp-network" {
    source = "./modules/network"
    vpc_cidr = "${var.vpc_cidr}"
    subnet_cidr = "${var.subnet_cidr}"
    subnet_az = "${var.subnet_az}"
}

module "myapp-webserver" {
    source = "./modules/webserver"
    vpc_id = "${module.myapp-network.vpc.id}"
    ami_name = "${var.ami_name}"
    public_key = "${var.public_key}"
    subnet_id = "${module.myapp-network.subnet.id}"
}