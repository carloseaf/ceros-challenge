#!/bin/bash

# usage
# ./run_ansible.sh <public ec2 ip> <command>
# Command:
# - init
# - build
# - deploy
# - undeploy
# - upgrade
# - deploy_ec2
# - undeploy_ec2

host_ip=$1
playbook=$2

docker run -e HOST_IP=$host_ip -e REGION=us-east-1 -e AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}" -e AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}" -e AWS_SESSION_TOKEN="${AWS_SESSION_TOKEN}" -it ansible ansible-playbook /etc/ansible/playbook/${playbook}.yml
