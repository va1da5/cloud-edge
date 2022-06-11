locals {
  ami = {
    "amazon-linux2" = "ami-0022f774911c1d690" # Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
    "rhel8"         = "ami-0b0af3577fe5e3532" # Red Hat Enterprise Linux 8 (HVM), SSD Volume Type
    "ubuntu2204"    = "ami-09d56f8956ab235b3" # Ubuntu Server 22.04 LTS (HVM), SSD Volume Type
    "ubuntu2004"    = "ami-0c4f7023847b90238" # Ubuntu Server 20.04 LTS (HVM), SSD Volume Type
  }

  users = {
    "amazon-linux2" = "ec2-user"
    "rhel8"         = "ec2-user"
    "ubuntu2204"    = "ubuntu"
    "ubuntu2004"    = "ubuntu"
  }

  size = {
    #                                          Prices for "us-east-1" region
    "xxs" = "t3.nano"    # 2vCPU,   0.5GB RAM    0.0052 USD/hr
    "xs"  = "t3.micro"   # 2vCPU,     1GB RAM    0.0104 USD/hr
    "s"   = "t3.small"   # 2vCPU,     2GB RAM    0.0208 USD/hr
    "m"   = "t3.medium"  # 2vCPU,     4GB RAM    0.0416 USD/hr
    "l"   = "t3.large"   # 2vCPU,     8GB RAM    0.0832 USD/hr
    "xl"  = "t3.xlarge"  # 4vCPU,    16GB RAM    0.1664 USD/hr
    "xxl" = "t3.2xlarge" # 8vCPU,    32GB RAM    0.3328 USD/hr
  }
}


