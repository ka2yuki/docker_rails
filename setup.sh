# 1. Docker Install

echo "Docker-Compose INSTALL"
sudo curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# プロジェクトのビルド
docker-compose run web rails new . --force --database=postgresql
# DOCUMENT: https://docs.docker.jp/compose/rails.html

git remote remove origin


ls -l
sudo chown -R $USER:$USER .
docker-compose build


#!/bin/bash
cat << EOT > config/database.yml
default: &default
  adapter: postgresql
  encoding: unicode
  host: db
  username: postgres
  password:
  pool: 5

development:
  <<: *default
  database: myapp_development


test:
  <<: *default
  database: myapp_test
EOT


docker-compose up
docker-compose run web rake db:create
docker-machine ip MACHINE_VM