#!/bin/bash
              sudo apt update 
              sudo apt upgrade
              cd /tmp
              wget https://s3.amazonaws.com/ansible.wordpress/Ansible.zip
              sudo apt install unzip
              unzip Ansible.zip
              cd Ansible
              sudo apt install curl ansible -y
              sudo add-apt-repository ppa:ondrej/php -y
              sudo apt-get update
              sudo ansible-playbook wordpress.yml --extra-vars "wp_db_name=${wp_db_name} wp_db_username=${wp_username} wp_db_password=${wp_user_password} wp_db_host=${wp_db_host} session_save_path=''"
              # Add Docker's official GPG key:
              sudo apt-get update
              sudo apt-get install ca-certificates curl
              sudo install -m 0755 -d /etc/apt/keyrings
              sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
              # Add the repository to Apt sources:
              echo \
                "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
                $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
                sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
              sudo apt-get update
              sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
              docker run -d --rm --network=host  -v $(pwd)/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus
              # node exporter
              wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz
              tar xvfz node_exporter-1.5.0.linux-amd64.tar.gz
              cd node_exporter-1.5.0.linux-amd64/
              ./node_exporter