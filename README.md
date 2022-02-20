# Hub88

- Need to generate Key Pair first <br />
   ssh-keygen -f mykeypair   <br />
   
- Create terraform.tfvars file. Place AWS Access Key and Secret Access Key in it       <br />
AWS_ACCESS_KEY = "AXXXXXXXXXXXXXXXC"                            <br />
AWS_SECRET_KEY = "ZXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXZ"                       <br />

- Run terraform init to download the required providers     <br />

- Run terraform plan to see the changes  planned to execute in the infra.       <br />

- Run terraform apply --auto-approve or terraform apply(Enter yes at prompt)      <br /> 
  It will create all the resources and copy the IP details to **ansible/inventory** file. After creation of instances ansible-playbook command will run to install required software like python, docker and create **dynamic index.html** file for each EC2 instance. Ansible will create nginx container on every instance with different index.html.<br />

- **Please use Terraform aws provider ~>3.0.**   <br /> 















_**REFERENCES:**_  <br />

https://registry.terraform.io/providers/hashicorp/kubernetes/2.8.0    <br />
For Terraform certification peparation, I referred few udemy courses:  <br />
https://www.udemy.com/course/hashicorp-certified-terraform-associate-step-by-step/    <br />
https://www.udemy.com/course/learn-devops-infrastructure-automation-with-terraform/     <br />


_**Lecturer's GitHub Code: **_     
    
https://github.com/wardviaene/terraform-course          <br />
https://github.com/stacksimplify/hashicorp-certified-terraform-associate  <br />
