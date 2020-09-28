# mongodb-replicaset
Docker-compose tu deploy a mongodb cluster with 4 replicas

## Configuration and Credentials
Check the `.env` file to configure the cluster.
The secrets like the `MONGO_INITDB_ROOT_PASSWORD` it must be set on the host directly for security reasons. The cluster will read it directly from the host.
To generate it you can use this command `export MONGO_INITDB_ROOT_PASSWORD=$(pwgen -1s 20)`

Keep in mind that the root credentials set on `MONGO_INITDB_ROOT_USERNAME` and `MONGO_INITDB_ROOT_PASSWORD` are only used on the first time that you run the Cluster. The next times that you run the cluster, if there is an old database set on the volume it will take the old credentials.

## Initiate the cluster
On any of the 3 main replicas (the hidden doesn't have it because if you can not initiate from it) run the command:
```
docker exec -ti mongo-1 mongo \
 --host mongo-1 \
 -u root_username \
 -p current_password \
 --authenticationDatabase admin \
 initiate.js
```



## Check status
```
docker run -ti --rm --network mongodb-replicaset_default mongo:4.4 mongo \
  --host mongo-1 \
  -u root_username \
  -p current_password \
  --authenticationDatabase admin \
  --eval "printjson(rs.status())"
```
