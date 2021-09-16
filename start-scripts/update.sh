#!/bin/bash
sudo rm -rf /home/ubuntu/redmine/{,.}*
sudo tar xvf /home/ubuntu/redmine.tar.gz -C /home/ubuntu/redmine/
sudo cp /home/ubuntu/configuration.yml /home/ubuntu/redmine/config
sudo cp /home/ubuntu/database.yml /home/ubuntu/redmine/config
sudo reboot