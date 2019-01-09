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

docker run -e HOST_IP=$host_ip -it ansible ansible-playbook /etc/ansible/playbook/${playbook}.yml

