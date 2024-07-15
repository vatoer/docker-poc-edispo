# README

## CLONE DOCKER

```sh
git clone https://github.com/vatoer/docker-poc-edispo.git
```

## CLONE SOURCE

- edispo lama = legacy-edispo
- bridge file dengan edispo lama = poc-mini-fileserver
- edispo baru = eoffice

```sh
cd docker-poc-edispo
```

```sh
./clone.ps1
```

```sh
./clone.sh
```

## SETUP env

update `.env.fileserver`

```sh
openssl rand -hex 32
```

isikan pada `JWT_SECRET_KEY`

### set password untuk bisa generate JWT via /login.php

- Setup password

```ps1
.\hashpassword.ps1
```

```sh
./hashpassword.sh
```

set password yang akan digunakan untuk mengisi `USER_SECRET_KEY`

### generate JWT dengan shell

(mac/linux)
untuk inisiasi generate JWT bisa juga langsung menggunakan `generateJWT.sh`

```sh
./generateJWT.sh
```

(poweshell)

- generate

```sh
./JWT-generate.ps1
```

- validate

```sh
./JWT-validate.ps1
```

isi JWT_SECRET_KEY sesuai dengan yg digenerate sebelumnya

hasil generate JWT simpan di `env.nextjs`
`FILESERVER_JWT=`

#### check JWT yg digenerate

```sh
checkJWT.sh
```

isi JWT_SECRET_KEY sesuai dengan yg digenerate sebelumnya

## build docker

```sh
docker compose -f docker-compose.prod.yml --build -d mysql
docker compose -f docker-compose.prod.yml--build -d php-fpm
docker compose -f docker-compose.prod.yml --build -d nextjs
docker compose -f docker-compose.prod.yml --build -d nginx
```

akses dengan localhost:3000

## untuk simulasi pararel dengan edispo

edispo dapat diakses dengan localhost:8001
fileserver sebagai bridge dapat di akses di localhost:8000

untuk selanjutnya jika sudah pernah build tinggal up saja

```sh
docker compose -f docker-compose.prod.yml -d mysql
docker compose -f docker-compose.prod.yml -d php-fpm
docker compose -f docker-compose.prod.yml -d nextjs
```

pastikan ketiganya sudah jalan baru up nginx

```sh
docker compose -f docker-compose.prod.yml -d nginx
```
