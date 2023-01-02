terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.48"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  region  = "us-west-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0ecc74eca1d66d8a6"
  instance_type = "t2.micro"
  key_name      = "iac-wallison"
  user_data     = <<-EOF
                #!/bin/bash
                cd /home/ubuntu
                echo "<h1>Feito com Terraform</h1>" > index.html
                nohup busybox httpd -f -p 8080 & 
                    EOF
  user_data_replace_on_change = true

  tags = {
    Name = "NOVO AWS"
  }
}
