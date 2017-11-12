#!/bin/sh

# --build: Build images before starting containers.
# --abort-on-container-exit: Stops all containers if any container is stopped
docker-compose -f "docker-compose.yml" -f "docker-compose.ci.yml" up --abort-on-container-exit
docker-compose run --rm web bundle
docker-compose run --rm web rails db:create
docker-compose run --rm web rails db:migrate
docker-compose run --rm web rspec