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


var error = rs.initiate(cfg);

printjson(error);
