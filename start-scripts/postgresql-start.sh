#!/bin/bash
sudo apt update -y
sudo apt upgrade -y
sudo apt install postgresql postgresql-contrib -y
sudo -u postgres bash -c "psql -c \"CREATE ROLE redmine LOGIN ENCRYPTED PASSWORD 'my_password' NOINHERIT VALID UNTIL 'infinity';\""
sudo -u postgres bash -c "psql -c \"CREATE DATABASE redmine WITH ENCODING='UTF8' OWNER=redmine;\""
sudo echo "host all all 0.0.0.0/0 md5" >> "/etc/postgresql/12/main/pg_hba.conf"
sudo echo "listen_addresses = '*'" >> "/etc/postgresql/12/main/postgresql.conf"
sudo echo "port = 5432" >> "/etc/postgresql/12/main/postgresql.conf"
sudo systemctl enable postgresql
sudo service postgresql restart