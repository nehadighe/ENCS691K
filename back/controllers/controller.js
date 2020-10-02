const { create } = require("../models/model");

module.exports = {
  createUser: (req, res)=>{
    const body = req.body;
    create(body, (err, results)=>{
      if(err){
        console.log(err);
        return res.status(500).json({
          success:0,
          message: "Database connection error"
        });
      }
      return res.status(200).json({
        success:1,
        data: results
      });
    });
  }
};


// const db = require("../models");
// const signup = db.user;
// const Op = db.Sequelize.Op;

// // Create and Save a new sign up
// exports.create = (req, res) => {
//     // Validate request
//     if (!req.body.username) {
//         res.status(400).send({
//           message: "Content can not be empty!"
//         });
//         return;
//       }

//      // Create a user
//   const user = {
//     username: req.body.username,
//     firstName: req.body.firstName,
//     lastName: req.body.lastName,
//     email:req.body.email,
//     password:req.body.password
//   };

//     // Save user in the database
//     signup.create(user)
//     .then(data => {
//       res.send(data);
//     })
//     .catch(err => {
//       res.status(500).send({
//         message:
//           err.message || "Some error occurred while creating the user."
//       });
//     });
// };

// // Retrieve all users from the database.
// exports.findAll = (req, res) => {
  
// };

// // Find a single user with an id
// exports.findOne = (req, res) => {
  
// };

// // Update a user by the id in the request
// exports.update = (req, res) => {
  
// };

// // Delete a user with the specified id in the request
// exports.delete = (req, res) => {
  
// };

// // Delete all users from the database.
// exports.deleteAll = (req, res) => {
  
// };
