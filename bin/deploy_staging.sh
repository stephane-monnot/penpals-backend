#!/bin/sh

# --build: Build images before starting containers.
# --abort-on-container-exit: Stops all containers if any container is stopped
docker-compose -f "docker-compose.yml" -f "docker-compose.staging.yml" up -d
docker-compose -f "docker-compose.yml" -f "docker-compose.staging.yml" run --rm web rails db:create
docker-compose -f "docker-compose.yml" -f "docker-compose.staging.yml" run --rm web rails db:migrate
