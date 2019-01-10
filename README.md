# Code Challenge

Candidate: Carlos Eduardo
Email: fernandes.carloseduardo@gmail.com

# Challenge
Take the provided Nodejs application (ceros-ski), wrap it in one or more docker containers, spin up an EC2 server and deploy the docker container to that server.  After the deployment has run, the docker container should be web accessible.

## Requirements
 - Ceros-ski app is wrapped in a docker container
 - Ceros-ski container is deployed to free-tier ec2 server in an automated way
 - EC2 server, and any supporting services and configuration, is defined in code (cloudformation, terraform, etc)
 - Once deployed, ceros-ski is accessible from the web
 - Process of deploying the ceros-ski app container to ec2 is clearly documented


# Ceros ski application
Nodejs version of the classic Windows game SkiFree.

# Structure

## AWS
AWS is being used as the cloud provider, it hosts the EC2 instance. Also, a Security Group is 
being created opening port 22 used by Ansible and port 80 used by web application.
EC2 is using default VPC, no public subnet is being created.


## Docker
Docker is building and deploying web application and Nginx.
Resources:
 - Dockerfile: Install common packages, Install aws cli and Install Ansible
 - aws_templates: Contains ec2.yml, cloudformation script to create AWS stack deploying EC2
 - assets:
   - aws: AWS credentials file
   - keys: rsa private key
   - playbook: Contains init, build, deploy, deploy_ec2, test, undeploy, undeploy_ec2 and upgrade script files
   
IMPORTANT: Credentials file must be filled with aws_access_key_id and aws_secret_access_key,
it`s just for challenge purpose, forbidden to do that in real projects 

### Ceros ski
Two instances of Ceros-ski web application are being deployed.
Uses port 5000 defined on web.js.

### Nginx
Nginx is acting as a Load Balancer for web application instances, 
avoiding downtime when updates to ceros-ski are done.
These instances are linked to Nginx.
It uses port 80 mapped to port 5000 from Ceros Ski.

### Ansible
Ansible is used for orchestrate the app lifecycle.
It`s simple to understand, reliable and secure. 
Main file is run_playbook.sh
For AWS infrastructure creation: ./run_playbook.sh 0.0.0.0 deploy_ec2
For app initialization(build + deploy): ./run_playbook.sh 34.219.36.219 init

#### Build process
build.yml:
 - Download ceros ski project from Git
 - Docker build ceros-ski-web
 - Docker build ngninx

#### Deploy process
deploy.yml:
 - Create and start 2 instances of ceros-ski web application(ceros-ski-web-1 and ceros-ski-web-2)
 - Create and start 1 instance of nginx and link both web applications

#### Update process
upgrade.yml:
 - Download ceros ski project from Git
 - Docker build ceros-ski-web
 - Remove ceros-ski-web-1
 - Deploy ceros-ski-web [1]
 - Remove ceros-ski-web-2
 - Deploy ceros-ski-web [2]  

#### Deploy EC2 process
deploy_ec2.yml:
 - Creates AWS cloudformation stack
 
#### Undeploy EC2 process
undeploy_ec2.yml:
 - Deletes AWS cloudformation stack
 
#### Undeploy process
undeploy.yml:
 - Remove Ceros ski and Nginx instances


# IaC

## Cloudformation
CloudFormation used for EC2 provisioning. CloudFormation offers support for different resources, 
is easy to use, is flexible and declarative. It also permits Customisation through Parameters.

### Structure
Resources created:
  - EC2 instance
  - Security Group
  - InstanceProfile
  - Policy
  - Role
  
  Security Group allows SSH and HTTP to the EC2. Policy created and associated to the EC2 denies any type of access to EC2 resources.

# Future steps
Important to mention that the correct process should be via CI/CD process.
A complete pipeline for Ceros ski application that involves building the software, 
followed by the progress of these builds through multiple stages of testing and deployment.

