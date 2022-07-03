output "public_ip" {
    value = "${module.myapp-webserver.server.public_ip}"
}