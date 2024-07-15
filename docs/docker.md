# RUNNING DOCKER

```sh
docker compose -f docker-compose.prod.yml  up --build mysql
docker compose -f docker-compose.prod.yml  up --build nextjs
docker compose -f docker-compose.prod.yml  up --build php-fpm
docker compose -f docker-compose.prod.yml  up --build nginx
```

```sh
docker compose -f docker-compose.prod.yml up -d mysql
docker compose -f docker-compose.prod.yml up -d nextjs
docker compose -f docker-compose.prod.yml up -d php-fpm
docker compose -f docker-compose.prod.yml up -d nginx
```
