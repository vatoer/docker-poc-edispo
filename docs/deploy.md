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

## SETUP env

update `.env.fileserver`

```sh
openssl rand -hex 32
```

isikan pada `JWT_SECRET_KEY`

- Setup password
  
```ps
.\hashpassword.ps1
```

 set password yang akan digunakan untuk mengisi `USER_SECRET_KEY`
