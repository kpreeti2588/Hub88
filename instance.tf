resource "aws_instance" "hub88" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = var.instance_type
  count = var.in_count
  
  # the VPC subnet
  subnet_id = element(aws_subnet.public_subnet.*.id, count.index)

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-traffic.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name
  
  # role:
  iam_instance_profile = aws_iam_instance_profile.test_profile.name

  tags = {
    Name = "Hub-Server-${count.index}"
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} username=Server${count.index+1} >> ansible/inventory"
  }

  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ip.txt"
  }
}

resource "time_sleep" "wait_2_min" {
  depends_on = [aws_lb.lb]

  create_duration = "60s"
}

resource "null_resource" "test-ans"{
    depends_on= [time_sleep.wait_2_min]
	
	provisioner "local-exec" {
		command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook ansible/install_docker.yaml ansible/install_nginx.yaml -i ansible/inventory --private-key '${file(var.PATH_TO_PRIVATE_KEY)}' -e log_group=${var.log_group_name} -e ansible_user=ubuntu"
	}
}
