# deploy

## CLONOE DOCKER

```sh
git clone https://github.com/vatoer/docker-poc-edispo.git
```

## SETUP

```sh
cd docker-poc-edispo
```

```sh
clone.bat
```

```sh
clone.sh
```


## SETUP env


update `.env.fileserver`

```sh
openssl rand -hex 32
```

isikan pada `JWT_SECRET_KEY`

set password untuk bisa generate JWT via /login.php

- Setup password
  
```ps1
.\hashpassword.ps1
```

```sh
./hashpassword.sh
```

 set password yang akan digunakan untuk mengisi `USER_SECRET_KEY`

### generate JWT dengan shell

 untuk inisiasi generate JWT bisa juga langsung menggunakan `generateJWT.sh`

 ```sh
 ./generateJWT.sh
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
docker compose up --build
```
