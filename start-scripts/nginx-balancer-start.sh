#!/bin/bash
sudo apt update -y
sudo apt upgrade -y
sudo apt install nginx -y
sudo cp /home/romario/nginx.conf /etc/nginx/
sudo systemctl reload nginx.service
