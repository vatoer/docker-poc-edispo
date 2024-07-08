## BACKUP AND RESTORE

```sh
docker ps
docker exec -it b0a2445897c9 sh 
mysql -u root -p poc_db_edisposisi < ./backups/dump-db_edisposisi-202406290926.sql'
```
