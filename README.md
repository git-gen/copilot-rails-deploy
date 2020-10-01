# copilot-rails-deploy

copilotでECS FargateにRailsアプリをデプロイする

## 初期設定

rails の database.yml に RDS の設定を追記してください(Mysql)

```ruby
# ror/config/database.yml

default: &default
  adapter: mysql2
  encoding: utf8
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  database: ## RDS database ##
  host: ## RDS host ##
  username: ## RDS username ##
  password: ## RDS password ##

development:
  <<: *default

test:
  <<: *default

production:
  <<: *default
```

ビルドしてコンテナを作ります

```bash
$ docker-compose build

$ docker-compose up -d
```

http://localhost:3000

## copilotデプロイ手順

```bash
# アプリの作成
$ copilot app init

# 環境の作成
$ copilot env init

# サービス追加
$ copilot svc init

# デプロイ
$ copilot deploy
```

![ss](https://github.com/git-gen/copilot-rails-deploy/blob/master/readme_ss/screenshot.png)
