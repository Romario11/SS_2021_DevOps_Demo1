#!/bin/bash
sudo apt update -y
sudo apt upgrade -y
sudo apt install nginx -y
sudo cp /home/${USER_NAME}/nginx.conf /etc/nginx/
sudo systemctl reload nginx.service
