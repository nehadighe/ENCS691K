const RegisterUserController = require('../src/controllers/RegisterUserController')

module.exports = (app) => {
     app.get('/', (req, res) => {
         res.send({
             message: 'Hello World'
         })
     })

    app.post('/register', RegisterUserController.register)
}
