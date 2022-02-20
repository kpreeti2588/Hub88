# Hub88

***Pre-Requisites on Local Machine from where code is running:**  <br />
*pip3 install ansible   <br />
*ansible-galaxy collection install community.docker    <br />
*python3 -m pip list |grep docker    <br />

- Need to generate Key Pair first <br />
   **ssh-keygen -f mykeypair**   <br />
   
- Create terraform.tfvars file. Place AWS Access Key and Secret Access Key in it       <br />
AWS_ACCESS_KEY = "AXXXXXXXXXXXXXXXC"                            <br />
AWS_SECRET_KEY = "ZXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXZ"                       <br />

- Run **terraform init** to download the required providers     <br />

- Run **terraform plan** to see the changes  planned to execute in the infra.       <br />

- Run **terraform apply --auto-approve** or **terraform apply**(Enter yes at prompt)      <br /> 
  It will create all the resources and copy the IP details to **ansible/inventory** file. After creation of instances ansible-playbook command will run to install required software like python, docker and create **dynamic index.html** file for each EC2 instance using Jinja2. Ansible will create nginx container on every instance with different index.html.<br />
  
 - In case, ansible-playbook fails to run at the time of terraform apply, then run command from the code directory file (command prompt ) where instance.tf is placed:  <br />
**ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ansible/inventory ansible/install_docker.yaml ansible/install_nginx.yaml --private-key '/home/ubuntu/Hub88/mykeypair' -e log_group=docker_logs**   <br />
Where Hub88 is directory and my private key pair is mentioned at root path of the directory and need to mention the real value of variables for e.g. where I need to send my log in Cloudwatch Log Group. <br  />

- In case of running from the ansible folder, run below mentioned command:  <br />
**ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory install_docker.yaml install_nginx.yaml --private-key '/home/ubuntu/Hub88/mykeypair' -e log_group=docker_logs** <br />

  **Note**: I have pasted the sample template of inventory which will get generated from terraform. If you are destroying the created resource, please remove those Ips from inventory, otherwise, it will throw error while running ansible-playbook command.   <br />
  
- In case of container creation give error, then please check for the **correct IAM role creation** OR set **docker daemon connection with AWS** in your local or from remote machine. Either of the option will work.  <br />

- On Remote machine, all pre-requisites are fulfilled by ansible/install_nginx.yaml    <br />


- **Please use Terraform aws provider ~>3.0.**   <br /> 


- Since, this is a small task of ansible. I didn't create tree structure of ansible directory. Although, this is the proper format of ansible to run the ansible playbook. <br />
![image](https://user-images.githubusercontent.com/47385113/154835821-f9ec9075-ff52-407d-8512-5f2787dae7a2.png)    <br />

Added Ansible Directory structure for refernces. <br />















_**REFERENCES:**_  <br />

https://registry.terraform.io/providers/hashicorp/aws/latest/docs    <br />
https://docs.ansible.com/ansible/2.9/modules/docker_container_module.html   <br />
For Terraform certification peparation, I referred few udemy courses:  <br />
https://www.udemy.com/course/hashicorp-certified-terraform-associate-step-by-step/    <br />
https://www.udemy.com/course/learn-devops-infrastructure-automation-with-terraform/     <br />


_**Lecturer's GitHub Code: **_     
    
https://github.com/wardviaene/terraform-course          <br />
https://github.com/stacksimplify/hashicorp-certified-terraform-associate  <br />
