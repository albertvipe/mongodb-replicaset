#!/bin/bash

mongo <<EOF
  var cfg =
  {
    _id: "rs0",
    version: 1,
    members: [
      {
        "_id" : 0,
        "host" : "mongo-1:27017",
        "hidden" : false,
        "priority" : 2,
      },
      {
        "_id" : 1,
        "host" : "mongo-2:27017",
        "hidden" : false,
        "priority" : 0.5,
      },
      {
        "_id" : 2,
        "host" : "mongo-3:27017",
        "hidden" : false,
        "priority" : 0.5,
      },
      {
        "_id" : 3,
        "host" : "mongo-hidden:27017",
        "hidden" : true,
        "priority" : 0,
      }
    ]
  };
  rs.initiate(cfg);
  rs.status();
EOF

echo "Waiting while ReplicaSet configuration is being applied"
sleep 20

mongo <<EOF
   use admin;
   admin = db.getSiblingDB("admin");
   admin.createUser(
     {
	      user: "admin",
        pwd: "$MONGO_ADMIN_PASSWORD",
        roles: [ { role: "root", db: "admin" } ]
     });
     db.getSiblingDB("admin").auth("admin", "$MONGO_ADMIN_PASSWORD");
EOF
