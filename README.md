# docker-rails6-postgres

## Run the following command

```bash
$ make all
```

That's all.  


## How to buildup environment

### Clone This Repository

```bash
$ git clone https://github.com/tokidrill/docker-rails6-postgres.git
```

### Run rails new

Create Rails project with PostgreSQL.

#### run rails new

```
$ docker-compose run --rm web rails new . --force --no-deps --database=postgresql --skip-test --webpacker
```

#### alias

```bash
$ make new
```

### Build Docker image

```bash
$ docker-compose build --no-cache
```

#### alias

```bash
$ make build
```

### Modify your database configulation and create database

#### Modify ```database.yml``` .

config/database.yml
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

#### Or execute the command

```bash
make copy-config
```

#### Then, run migrate for initialize.

```bash
$ docker-compose run web rake db:create
```

## Up Docker container

```bash
$ docker-compose up -d
```

#### alias

```bash
$ make up
```

## Yay! You're on Rails !!
Access http://localhost:3000 .  
Congratulations !! Now, you're on Rails !!  

#### Other commands

[See Makefile](./Makefile)