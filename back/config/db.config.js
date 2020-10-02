const { createPool } = require("mysql");

const pool = createPool({
  port:3306,
  host:"localhost",
  user:"root",
  password:"",
  database:"test",
  connectionLimit: 10
})

module.exports = pool;


// module.exports = {
//     HOST: "localhost",
//     USER: "root",
//     PASSWORD: "123456",
//     DB: "testdb",
//     dialect: "mysql",
//     pool: {
//       max: 5,
//       min: 0,
//       acquire: 30000,
//       idle: 10000
//     }
//   };