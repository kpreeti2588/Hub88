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
    command = "echo ${self.public_ip} username=Server${count.index+1} >> ansible/inventory"   #Creating ansible inventory from this command 
  }

  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ip.txt"
  }
}

#resource "time_sleep" "wait_2_min" {  ##Commented out since its making terraform to wait for 2 minutes since EC2 provsioning is taking (1-2 mins) time to execute 
#  depends_on = [aws_lb.lb]   # It is useful when we want ansible command also runs along with terraform script. It is giving time to instances for warm up

#  create_duration = "120s"
#}

resource "null_resource" "test-ans"{
	depends_on = [aws_lb.lb]   ## this is the last thing gets created in terraform graph. So, Ansible command is dependent on this 
#	depends_on= [time_sleep.wait_2_min]  
	
	provisioner "local-exec" {
		command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook ansible/install_docker.yaml ansible/install_nginx.yaml -i ansible/inventory --private-key '${file(var.PATH_TO_PRIVATE_KEY)}' -e 'log_group=${var.log_group_name} ansible_user=ubuntu' "
	}
}
