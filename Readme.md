Pre-requisites 

1. git
2. Terraform


This terraform code creates the following in AWS Singapore region

1. VPCs and Subnets
	- a VPC with 10.0.0.0/16 network
	- a public subnet test with 10.0.0.0/24 network


2. Instances
	- an Test01 instance to act as a web server with associated eip

Assumptions: 1. Works only in AWS Singapore region 2. Uses t2.micro instances to spin up all instances except the NAT01 instance 3. Uses Ubuntu 16.04 as the base OS 4. AWS user has full EC2 and VPC permissions 5. You have already created an key-pair in AWS EC2 consolea 6. The 10.0.0.0/16 subnet is not used in existing VPCs. If yes, change it network settings in variables.tf accordingly

Inputs Needed: You need to add the following variables to the file terraform.tfvars 1. AWS access_key - access key of aws user with appropriate permissions 2. AWS secret_key - secret key of access key 3. aws_key_path - path to the private key of the aws key-pair on your local machine 4. aws_key_name - name of the aws key-pair

How to run the code: 

git clone  https://github.com/Shravan6488/Terraform.git

1. You will see 4 files - terraform.tf (the code) - variables.tf (the variables defined) - terraform.tfvars (where you input your variables) - README (this file) 
2. Download and Install the terraform binary. 
3. CD to the directory from 1. 
4. Run 'terraform init' to show the changes that will be made 
5. Run 'terraform plan' to show the changes that will be made 
6. Run 'terraform apply' to bring up the setup 


How to ssh to the instances 1. For Test01 a, ssh as ubuntu user with the aws private key to their respective EIP.


To Clean up all the instance run 'terraform destroy' command.
