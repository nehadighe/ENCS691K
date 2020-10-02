const pool = require("../config/db.config");

module.exports = {
  create: (data, callBack) =>{
    pool.query(
      `insert into users(username,firstName,lastName,email,password)
      values(?,?,?,?,?) `,
      [
        data.username,
        data.firstName,
        data.lastName,
        data.email,
        data.password
      ],
      (error,results,fields)=>{
        if(error){
          return callBack(error);
        }
        return callBack(null, results);
      }
    );
  }
};


// module.exports = (sequelize, Sequelize) => {
//     const user = sequelize.define("user", {
//       username: {
//         type: Sequelize.STRING
//       },
//       firstName: {
//         type: Sequelize.STRING
//       },
//       lastName: {
//         type: Sequelize.STRING
//       },
//       email: {
//         type: Sequelize.STRING
//       },
//       password: {
//         type: Sequelize.STRING
//       }
//     });
  
//     return user;
//   };