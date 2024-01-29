# INTRODUCTION
## The objective of this project is simple: Provisioning a base networking layer (vpc + subnet + firewall rules) and a simple webserver on top with an Infrasctructure As Code(IAC) called Terraform in the Cloud(AWS).
# PREREQUISITES
1. An AWS Account(IAM user preferably)
2. Terraform installed on your local machine. You can follow the guide [here](https://developer.hashicorp.com/terraform/install)

## Before we get started you will need to create the following files in your code editor:
**main.tf**  
**network.tf**  
**security.tf**  
**variables.tf**  
**server.tf**  
**terraform.tfvars**  

# Provider
 Inside the **main.tf** file we declared the AWS provider with the desired region,the iam account secret key and access key using a variable.

# Variable 
 Inside the **variables.tf** file we will create the necessary variables for configuration, including the  AWS secret key,AWS access key and AWS region.

**Note**: I created another file called **terraform.tvars**, we'll store the values of secret_key and access_key that was obtained from our AWS IAM user account,this file contains sensitive information that allows terraform communicate with AWS to create our infrastructure.

# Network
  Inside the **network.tf** file we will create our VPC and subnet resources.
  In AWS, a Virtual Private Cloud (VPC) contains one or more subnets. Subnets are logical subdivisions of a VPC, and they are used to further organize and isolate resources within the VPC. Each subnet can be associated with different availability zones within a region, allowing you to distribute resources geographically for high availability and fault tolerance. Subnets are where you deploy your actual compute resources like EC2 instances, and they inherit the network settings and security rules defined at the VPC level.In this project we set the availability zone to **us-east-1a**.

# Security
## Security groups in AWS are needed to control inbound and outbound network traffic to and from your AWS resources, providing a fundamental layer of security to protect your infrastructure from unauthorized access and potential threats.

 Inside the **security.tf** file we can specify which ports are to open, we will define the rules in the security group resource here. We used a dynamic “ingress” block using the ```for_each ```meta-argument to create multiple security group rules for allowing incoming network traffic on specific ports (22, 80 and 433) over TCP from any source IP address ("0.0.0.0/0").
 We also defined an “egress” block for a security group rule. This egress rule allows all outbound network traffic (any protocol, any port) from the AWS resources associated with this security group to any destination, represented by the CIDR block “0.0.0.0/0.”

# Create EC2 Instance 
 Before we can SSH into the instance we are about to create,we need to have SSH key-pair so that we can login via SSH to the ec2 instance.In the **server.tf** file, we defined a resource to generate a new private key and another resource to save the private key on our local system so we can use this new public key to generate an AWS key pair for our newly created instance

## Next I am creating an AWS EC2 instance resource named **“my_server”** using a specified Amazon Machine Image (AMI), instance type, subnet, security group, and SSH key pair.I also defined the user data script.Inside the user_data field,we are performing the following steps:
1. Updating all the installed Linux Packages
2. Installing Apache2
3. Showing the completion of the installation of apache2
4. Enabling on boot the Apache2 service 

# Conclusion
## With the setup complete and all our configuration defined,you can try it yourself by running the following commands.

**terraform init** to set up the backend for Terraform to use.

 **terraform plan** to see what the resources will be created.
You should see this kind of output in your terminal in the image below.
![Terraform plan](/images/plan.png)

**terraform apply** to deploy the environment designed in the code.
You should see this kind of output in your terminal in the image below.
![Terraform apply](/images/apply.png)

## Let's look into the AWS console together to confirm our infrastructure was deployed right.
![AWS Console](/images/console.png)
You can see above in the image that all the resources were created by terraform successfully 

## Let's also confirm the apache2 page is active in our server. Copy the public ip adddress to your browser.You should see something like this in the image below
![BROWSER](/images/verify.png)

## Let's also confirm we can connect to the EC2 instance via SSH from our local computer using the command below
```ssh -i "<pem file name>" ubuntu@ec2-<public ip of the instance>.compute-1.amazonaws.com```
![SSH](/images/ssh.png)

### **terraform destroy** to delete the environment after you no longer need it.
You should see this output in the image below
![Terraform Destroy](/images/destroy.png)

















