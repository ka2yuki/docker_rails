# 1. Docker Install

if type 'docker-machine' > /dev/null 2>&1; then
  echo "Exist docker-machine cmd."
  sleep 2
else
  echo "docker-machine INSTALL"
  sleep 2
  echo $OSTYPE
  case ${OSTYPE} in
    darwin*)
      # mac
      curl -L https://github.com/docker/machine/releases/download/v0.12.2/docker-machine-`uname -s`-`uname -m` >/usr/local/bin/docker-machine && \
        chmod +x /usr/local/bin/docker-machine
      ;;
    linux*)
      curl -L https://github.com/docker/machine/releases/download/v0.12.2/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine &&
        chmod +x /tmp/docker-machine &&
        sudo cp /tmp/docker-machine /usr/local/bin/docker-machine
      ;;
  esac
  docker-machine
fi


if type 'docker-compose' > /dev/null 2>&1; then
  echo "Exist docker-compose cmd."
  sleep 2
else
  echo "Docker-Compose INSTALL"
  sleep 2
  sudo curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  docker-compose
fi
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

docker-compose config # check.
docker-compose up
docker-compose run web rake db:create
docker-machine ip MACHINE_VM