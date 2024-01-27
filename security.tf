resource "aws_security_group" "myserver_firewall" {
  name = "web-server"
  vpc_id = aws_default_vpc.default.id
    dynamic "ingress"{
        for_each = [22, 80, 443]
        iterator = port
        content {
          from_port = port.value
          to_port = port.value
          protocol = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
        
    }
    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
}