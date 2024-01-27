#VPC
resource "aws_default_vpc" "default" {
    tags = {
        name = "Default VPC"
    }
  
}

data "aws_availability_zone" "available" {
    name = "us-east-1a"

}
#Default subnet
resource "aws_default_subnet" "default_az1" {
    availability_zone = data.aws_availability_zone.available.name
    tags = {
        Name = "Default subnet for ${ data.aws_availability_zone.available.name}"
    }
}