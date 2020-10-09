const Sequelize = require('sequelize')
const sequelize = require('../config/config') 

     const User = sequelize.define("user", {
       username: {
         type: Sequelize.STRING, 
        allowNull:false,  
        primaryKey:true
       },
       firstName: {
         type: Sequelize.STRING
       },
       lastName: {
         type: Sequelize.STRING
       },
       email: {
         type: Sequelize.STRING
       },
       password: {
         type: Sequelize.STRING
       },
       createdAt: Sequelize.DATE, 
       updatedAt: Sequelize.DATE,
     })

module.exports = User