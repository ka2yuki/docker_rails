# 1. Docker Install

# !! docker-machine command check. if When you use it excute below.
# if type 'docker-machine' > /dev/null 2>&1; then
#   echo "Exist docker-machine cmd."
# else
#   echo "docker-machine INSTALL"
#   echo $OSTYPE
#   case ${OSTYPE} in
#     darwin*)
#       # mac
#       curl -L https://github.com/docker/machine/releases/download/v0.12.2/docker-machine-`uname -s`-`uname -m` >/usr/local/bin/docker-machine && \
#         chmod +x /usr/local/bin/docker-machine
#       ;;
#     linux*)
#       curl -L https://github.com/docker/machine/releases/download/v0.12.2/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine &&
#         chmod +x /tmp/docker-machine &&
#         sudo cp /tmp/docker-machine /usr/local/bin/docker-machine
#       ;;
#   esac
#   docker-machine
# fi

# 2. docker-compose command check. Use frequently base-command.
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

# gem update --system
# bundler update
# gem install bundler
# gem install bundler -v 1.17.3
# bundle update --bundler
# echo "bundle update --bundler"
# sleep 2

# ============================
# Avoid Sql error below.
# bundle config --local build.mysql2 "--with-ldflags=-L/usr/local/opt/openssl/lib --with-cppflags=-I/usr/local/opt/openssl/include"
# bundle install --path=vendor/bundle
# bundle show | grep mysql2

# patarn2 
# gem install mysql2 -v '0.5.2' --source 'https://rubygems.org/' -- --with-cppflags=-I/usr/local/opt/openssl/include --with-ldflags=-L/usr/local/opt/openssl/lib
# avoid error :=> Could not find gem 'mysql2 (~> 0.5)' in any of the gem sources listed in your Gemfile.
# ============================

# プロジェクトのビルド. 引数別.
# docker-compose run web rails new . --force --database=mysql
# docker-compose run web rails new . --force --no-deps --database=mysql --skip-test --webpacker
docker-compose run web rails new . --force --database=mysql --skip-test --webpacker
# web: docker-compose.yml SERVICE Name.
# rails new: rubyOnRails basic CLI command.
# --webpacker: with webpacker install. Rails6以降は webpack のインストールも実行
# --force: ??
ls -l
# ファイル一覧が表示されている: ls -l を機能させるポイントは、 web or ruby の image 削除する。
# further more DOCUMENT: https://docs.docker.jp/compose/rails.html

# git remote remove origin
sudo chown -R $USER:$USER .
echo ==========================
echo "🚀 docker-compose build"
echo ==========================
sleep 2
docker-compose build
# docker build -t my_project/rails .

#!/bin/bash
# cat << EOT > config/database.yml
# default: &default
#   adapter: postgresql
#   encoding: unicode
#   host: db
#   username: postgres
#   password:
#   pool: 5

# development:
#   <<: *default
#   database: myapp_development

# test:
#   <<: *default
#   database: myapp_test
# EOT

#!/bin/bash
cat << EOT > config/database.yml
default: &default
  adapter: mysql2
  encoding: utf8mb4
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: <%= ENV.fetch("MYSQL_USERNAME", "root") %>
  password: <%= ENV.fetch("MYSQL_PASSWORD", "password") %>
  host: <%= ENV.fetch("MYSQL_HOST", "db") %>

development:
  <<: *default
  database: myapp_development

test:
  <<: *default
  database: myapp_test

production:
  <<: *default
  database: myapp_production
  username: myapp
  password: <%= ENV['MYAPP_DATABASE_PASSWORD'] %>
EOT
# 📌 user, pass, host の 一致は MUST!! 
# (database-compose.yml == database.yml)

docker-compose run --rm web rails db:create
# docker-compose run web bin/rake db:create db:migrate db:seed
docker-compose up 
# docker-machine ip MACHINE_VM