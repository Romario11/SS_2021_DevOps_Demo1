#!/bin/bash
sudo apt update -y
sudo apt upgrade -y
sudo apt install ruby-full ruby-railties git curl autoconf bison build-essential libssl-dev libyaml-dev libreadline-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev libpq-dev -y
sudo gem install bundler
sudo gem install rails
sudo bash -c 'curl -o /home/romario/redmine-4.2.2.tar.gz https://www.redmine.org/releases/redmine-4.2.2.tar.gz'
sudo tar xvf home/romario/redmine-4.2.2.tar.gz -C /home/romario/
sudo cp home/romario/database.yml /home/romario/redmine-4.2.2/config/
sudo cp home/romario/configuration.yml /home/romario/redmine-4.2.2/config/
cd home/romario/redmine-4.2.2
bundle install --without development test
RAILS_ENV=production bundle exec rake db:migrate
echo en | RAILS_ENV=production bundle exec rake redmine:load_default_data
sudo mkdir -p tmp tmp/pdf public/plugin_assets
sudo chown -R romario:romario files log tmp public/plugin_assets
sudo chmod -R 755 files log tmp public/plugin_assets
bundle exec  rails server webrick -e production