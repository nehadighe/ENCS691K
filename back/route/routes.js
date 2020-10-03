const { createUser } = require("../controllers/controller");

const router = require("express").Router();

router.post("/", createUser);


module.exports = router;



//     // Create a new user
//     router.post("/", users.create);

//     // Retrieve all users
//     router.get("/", users.findAll);


//     // Retrieve a single user with id
//     router.get("/:id", users.findOne);

//     // Update a user with id
//     router.put("/:id", users.update);

//     // Delete a user with id
//     router.delete("/:id", users.delete);

//     // Delete all users
//     router.delete("/", users.deleteAll);

//     app.use('/api/users', router);

// -------------------------- Item Routes --------------------------

//     // Create Item
//     router.post("/",item.create);

//     // Retrieve Items
//     router.get("/",item.getItems);

//     // Retrieve user items
//     router.get("/:id",item.getUserItems);

//     // Delete Item
//     router.post("/:id",item.deleteItems);

//     // Update Item
//     router.get("/:id",item.deleteItems);

//     app.use('/api/items', router);

// -------------------------- Item Routes --------------------------

//   };