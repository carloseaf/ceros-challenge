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

# Docker
Ansible used for orchestration. 
Resources:
 - Dockerfile: Install common packages, Install aws cli and Install Ansible
 - aws_templates: Contains ec2.yml, cloudformation script to create AWS stack deploying EC2
 - assets:
   - aws: AWS credentials file
   - keys: rsa private key
   - playbook: Contains build, deploy, deploy_ec2, test, undeploy and upgrade files

## Containerization
### Ceros ski
Two instances of Ceros-ski web application.

### Nginx
One instance of Nginx acting as a Load Balancer for web application instances.

## Build process
build.yml:
 - Download ceros ski project from Git
 - Docker build ceros-ski-web
 - Docker build ngninx

## Deploy process
deploy.yml:
 - Create and start 2 instances of ceros-ski web application(ceros-ski-web-1 and ceros-ski-web-2)
 - Create and start 1 instance of nginx and link both web applications

## Update process
upgrade.yml:
 - Download ceros ski project from Git
 - Docker build ceros-ski-web
 - Remove ceros-ski-web-1
 - Deploy ceros-ski-web [1]
 - Remove ceros-ski-web-2
 - Deploy ceros-ski-web [2] 
 
 Nginx acts as a load balancer, avoiding downtime when updates to ceros-ski are done.
 Important to mention that the correct process should be via CI/CD process. Jenkins jobs for example.
 
## Undeploy process
undeploy.yml:
 - Remove Ceros ski instances and Nginx instance


# IoT

## Cloudformation
CloudFormation used for EC2 provisioning. CloudFormation offers support for different resources, is easy to use, is flexible and declarative. It also permits Customisation through Parameters.

### Structure
Resources created:
  - EC2 instance
  - Security Group
  - InstanceProfile
  - Policy
  - Role
  
  Security Group allows SSH and HTTP to the EC2. Policy created and associated to the EC2 denies any type of access to EC2 resources.

# CI/CD process
...describe here how this process should be, using jenkins, ecs, ecr, etc.

