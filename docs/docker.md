# RUNNING DOCKER

```sh
docker compose -f docker-compose.dev.yml up --build
docker compose -f docker-compose.dev.yml up

docker compose -f docker-compose.dev.yml build
docker compose -f docker-compose.dev.yml up -d

```

```sh
# Build prod
docker compose -f docker-compose.prod.yml build

# Up prod in detached mode
docker compose -f docker-compose.prod.yml up -d
```
