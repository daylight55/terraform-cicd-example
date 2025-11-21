resource "aws_instance" "my_web_app" {
  ami = "ami-005e54dee72cc1d00"

  instance_type = "m3.xlarge"
  root_block_device {
    volume_size = 1000
  }
}
