const fs = require('fs')
const path = require('path')
// Sequelize
const Sequelize = require('sequelize')
const config = require('../config/config')
const db = {}


const sequelize = new Sequelize(
    config.db.database,
    config.db.user,
    config.db.password,
    config.db.options
)

// Need to find what this is for
fs
    .readdirSync(__dirname) // array of different files
    .filter((file) =>
        file !== 'index.js' // anything that but the index
    )
    .forEach((file) => { 
        const model = require(path.join(__dirname, file))(sequelize, Sequelize.DataTypes)
        //const model = sequelize.import(path.join(__dirname, file)) // for each file, declare a model
        //db[model.name] = model
        db.User = model
    })

db.sequelize = sequelize
db.Sequelize = Sequelize

module.exports = db