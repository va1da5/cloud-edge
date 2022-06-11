resource "aws_instance" "main" {
  ami           = local.ami[var.AMI_NAME]
  instance_type = local.size[var.INSTANCE_SIZE]

  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = ["${aws_security_group.ssh.id}"]

  key_name = aws_key_pair.local.id

  root_block_device {
    delete_on_termination = var.KEEP_DATA == false
    volume_size           = var.ROOT_STORAGE_SIZE
    volume_type           = "gp2"
  }

  # ebs_block_device {
  #   delete_on_termination = false
  #   # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/device_naming.html
  #   device_name = "/dev/xvdb"
  #   volume_size = 10
  #   volume_type = "gp3"
  # }

  tags = {
    "Name" = "cloud-edge-vm"
  }
}


resource "aws_key_pair" "local" {
  key_name   = "loaded-key-pair"
  public_key = file(pathexpand(var.PUBLIC_KEY_PATH))
}
