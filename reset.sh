COLOR_0="\e[36;41;4m"
COLOR_UnderLine_1="\e[36;4m"
YELLOW="\e[33;1m"
OFF="\e[m\n"
# printf "${YELLOW}hoge${COLOR_OFF}"

rm -rf app/ public/ vendor/ bin/ lib/ config storage/ log/ \
  test/ tmp/ package.json  db/ \
  Rakefile .gitattributes .gitignore  \
  .ruby-version config.ru mysql-data/  \
  yarn.lock  .browserslistrc  babel.config.js \
  postcss.config.js  node_modules/ vender/ .bundle/

echo "" > Gemfile.lock

#!/bin/bash
cat << EOT > Gemfile 
source 'https://rubygems.org'
gem 'rails', '~> 6'
EOT

# 停止コンテナ、タグ無しイメージ、未使用ボリューム、未使用ネットワークを一括削除できます。 基本的にこれで事足りるはずです。
docker ps -a
docker images
docker system prune 
# ＜none＞タグのイメージを一括削除する
# docker rmi $(docker images --filter "dangling=true" -q)
# sudo docker images | awk '{if ($2 ~ "<none>") print $3}' | xargs sudo docker rmi
docker rmi docker_rails_web
docker rmi mysql:8.0 
echo "==========================="
echo "= 🎉CLEEN UP🎉 🐳DOCKER🐳 ="
echo "==========================="
printf "${YELLOW}> docker ps -a${OFF}"
docker ps -a
sleep 2
printf "${YELLOW}> docker images -a${OFF}"
docker images -a

# sh setup.sh