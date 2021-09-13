#!/bin/bash
sudo apt update -y
sudo apt upgrade -y
sudo apt install ruby-full ruby-railties git curl autoconf bison build-essential libssl-dev libyaml-dev libreadline-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev libpq-dev -y
sudo gem install bundler
sudo gem install rails
sudo mkdir home/${USER_NAME}/redmine_file_storage
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${DNS_EFS}:/ home/${USER_NAME}/redmine_file_storage
sudo chmod 777 home/${USER_NAME}/redmine_file_storage
sudo bash -c 'curl -o /home/${USER_NAME}/redmine-4.2.2.tar.gz https://www.redmine.org/releases/redmine-4.2.2.tar.gz'
sudo tar xvf home/${USER_NAME}/redmine-4.2.2.tar.gz -C /home/${USER_NAME}/
sudo cp home/${USER_NAME}/database.yml /home/${USER_NAME}/redmine-4.2.2/config/
sudo cp home/${USER_NAME}/configuration.yml /home/${USER_NAME}/redmine-4.2.2/config/
cd home/${USER_NAME}/redmine-4.2.2
bundle install --without development test
RAILS_ENV=production bundle exec rake db:migrate
echo en | RAILS_ENV=production bundle exec rake redmine:load_default_data
sudo mkdir -p tmp tmp/pdf public/plugin_assets
sudo chown -R ${USER_NAME}:${USER_NAME} files log tmp public/plugin_assets
sudo chmod -R 755 files log tmp public/plugin_assets
sudo bash -c 'echo "@reboot root cd /home/ubuntu/redmine-4.2.2/ && bundle exec rails server webrick -e production" >> /etc/crontab'
bundle exec  rails server webrick -e production