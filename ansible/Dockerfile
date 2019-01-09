FROM ubuntu:18.04

COPY assets /assets
COPY aws_templates /ceros-challenge/aws_templates

# Install common packages
RUN apt-get update && \
    apt-get install -y software-properties-common vim wget curl iputils-ping unzip python3-pip

# Install aws cli
RUN pip3 install awscli --upgrade --user && \
    ln -s /root/.local/bin/aws /bin/aws && \
    mkdir -p /root/.aws && \
    cp /assets/aws/* /root/.aws

# Install ansible
RUN apt-add-repository ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y ansible

RUN mkdir -p /root/.ssh/ /etc/ansible/playbook /etc/ansible/group_vars /etc/ansible/keys && \
    cp /assets/hosts /etc/ansible/. && \
    cp /assets/keys/* /etc/ansible/keys/. && \
    chmod 400 /etc/ansible/keys/* && \ 
    cp /assets/playbook/* /etc/ansible/playbook/. 

