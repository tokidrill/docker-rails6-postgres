DOCKER_COMPOSE=docker-compose
RUN_WEB=$(DOCKER_COMPOSE) run --rm web
DATABASE_YAML_COPY_FROM=database.postgres.yml
DATABASE_YAML_COPY_TO=config/database.yml

all:
	@make new --no-print-directory
	@make build --no-print-directory
	@make copy-config --no-print-directory
	@make db-create --no-print-directory
	@make up --no-print-directory
	@echo "Yay! You're on Rails !!" && echo "Open in web browser http://localhost:3000"

# Create a rails project
new:
	@$(RUN_WEB) rails new . --force --no-deps --database=postgresql --skip-test --webpacker

# Build Dockerfile
build:
	@$(DOCKER_COMPOSE) build --no-cache

# Copy postgres connection settings
copy-config:
	@$(RUN_WEB) cp -b $(DATABASE_YAML_COPY_FROM) $(DATABASE_YAML_COPY_TO)

# Create a database
db-create:
	@$(RUN_WEB) bundle exec rake db:create

# Create and start a docker container
up:
	@$(DOCKER_COMPOSE) up -d

# Close container
down:
	@$(DOCKER_COMPOSE) down

# Delete all containers, images, volumes, and networks
remove-all:
	@$(DOCKER_COMPOSE) down --rmi all --volumes
