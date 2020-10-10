module.exports = (sequelize, DataTypes) => 
  sequelize.define('User',{
    username: {
      type: DataTypes.STRING, 
      unique: true
    },
    firstName: {
      type: DataTypes.STRING
    },
    lastName: {
      type: DataTypes.STRING
    },
    email: {
      type: DataTypes.STRING
    },
    password: {
      type: DataTypes.STRING
    }
  })
  

