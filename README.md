# CueZilla_CRM

# env

- Ruby: 3.0.2
- Rails: 6
- Mysql: 8.0.27

# 動作チェック
- [x] MacOS
- [x] Win(WSL)

# 基本コマンド
```sh
docker-compose run web bundle install
docker-compose run web rails db:create
docker-compose run web rails db:migrate
docker-compose run web rails webpacker:install
docker-compose up -d
```