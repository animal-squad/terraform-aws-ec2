resource "aws_instance" "ec2" {
  instance_type = var.instance_type
  ami           = var.ami

  availability_zone           = var.az
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids      = var.security_group_ids

  key_name = var.key_name


  iam_instance_profile = var.role_name == null ? null : aws_iam_instance_profile.profile[0].name
  user_data            = var.user_data

  tags = {
    Name = "${var.name_prefix}-ec2"
  }
}

// NOTE: Instance Role

resource "aws_iam_instance_profile" "profile" {
  count = var.role_name == null ?  0 : 1

  name = "${var.name_prefix}_profile"
  role = var.role_name
}
