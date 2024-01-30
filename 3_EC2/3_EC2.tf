variable "stack_id_test" {
  type        = string
  description = "Etiqueta para control de facturación"
  default     = "cdata_crm_dev"
}


locals {
    common_tags_test = {
    stack_id_test         = var.stack_id_test
  }
}

resource "aws_vpc" "vpc_test" {
  cidr_block = "172.16.0.0/16"
  tags = local.common_tags_test
}

resource "aws_subnet" "subnet_test" {
  vpc_id            = aws_vpc.vpc_test.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-east-2"

  tags = local.common_tags_test
}

resource "aws_security_group" "security_group_test" {
  name        = "test-security-group-anderson"
  description = "Permite trafico entrante en el puerto 80"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "test_instance_example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_test.id
  monitoring    = true

  root_block_device {
    volume_type = "gp2"
    volume_size = 30
  }

  vpc_security_group_ids = [aws_security_group.security_group_test.id]
  tags = local.common_tags_test
}