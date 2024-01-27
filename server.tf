#Resource used to generate a new private key
resource "tls_private_key" "server_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


# Save the private key locally for SSH access
resource "local_file" "server_private_key" {
  content  = tls_private_key.server_key.private_key_pem
  filename = "${path.module}/server-key.pem"
  

}
#Create AWS key pair using the public key created
resource "aws_key_pair" "server_key" {
    key_name = "server-key"
    public_key = tls_private_key.server_key.public_key_openssh
}

#Resource to create the server spec and type 
resource "aws_instance" "my_server" {
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.micro"
  subnet_id = aws_default_subnet.default_az1.id
  vpc_security_group_ids = [aws_security_group.myserver_firewall.id]
  key_name = aws_key_pair.server_key.key_name
  

  user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo apt update -y
  sudo apt install apache2 -y
  echo "*** Completed Installing apache2"
  sudo systemctl enable apache2
  sudo systemctl start apache2
  EOF

 
}
  
