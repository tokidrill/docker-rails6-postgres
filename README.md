# docker-rails6-postgres

## How to buildup environment
### rails new
Create Rails project with PostgreSQL.

```
$ docker-compose run web rails new . --force --no-deps --databse=postgres --skip-test --webpacker
```

### Build Docker image

```
$ docker-compose build --no-cache
```

### Modify your database configulation and create database.

Modify ```database.yml``` .

```config/database.yml

default: &default
  adapter: postgresql
  encoding: utf8

  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  host: <%= ENV.fetch('DATABASE_HOST') {'db'} %>
  port: <%= ENV.fetch('DATABASE_PORT') {'5432'} %>
  username: <%= ENV.fetch('DATABASE_USER') {'postgres'} %>
  password: <%= ENV.fetch('DATABASE_PASSWORD') {'password'} %>

development:
  <<: *default
  database: test_development

test:
  <<: *default
  database: test_test

production:
  <<: *default
  database: test_production
  username: test
  password: <%= ENV['TEST_DATABASE_PASSWORD'] %>

```

Then, run migrate for initialize.

```
$docker-compose run web rake db:create
```

## Up Docker container

```
$docker-compose up -d
```

## Yay! You're on Rails !!
Access http://localhost:3000 .
