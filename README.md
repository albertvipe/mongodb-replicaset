# mongodb-replicaset
Docker-compose tu deploy a mongodb cluster with 4 replicas

## Configuration and Credentials
### `.env` file
If you still don't have it, copy the `.env.example` and update it with your desired values.

### Secrets
The secrets like the `MONGO_ADMIN_PASSWORD` should never be defined on the `.env` file for security reasons. Is better to configure it directly on the host and avoid have it published.
To generate it you can use this command `export MONGO_ADMIN_PASSWORD=$(pwgen -1s 20)`

### Key file
Is high recommended having a MongoDB cluster with [ReplicaSet with enforced authentication between members](https://docs.mongodb.com/manual/tutorial/deploy-replica-set-with-keyfile-access-control/#deploy-replica-set-with-keyfile-authentication).
Because of that, on our (docker-compose.yml)[docker-compose.yml] we have a volume to map a keyfile. If you don't have any key file, generate one where you have set the `${DATA_PATH}` on the `.env` file:
```
openssl rand -base64 756 > ${DATA_PATH}/mongo-key/rs.key
chmod 400 ${DATA_PATH}/mongo-key/rs.key
```
Probably, you should grant ownership to user with id 999 `chown 999:999 ${DATA_PATH}/mongo-key/rs.key` to the key file to avoid permissions issues.


## Initiate the cluster
On the container named `mongo-1` run the [`initiate.sh`](config/replication/initiate.sh) script to configure the replicaset:
```
docker exec -ti mongo-1 sh initiate.sh
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
