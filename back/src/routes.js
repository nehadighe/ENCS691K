const RegisterUserController = require('./RegisterUserController')

module.exports = (app) => {
     app.get('/', (req, res) => {
         res.send({
             message: 'Hello World'
         })
     })

    app.post('/register', RegisterUserController.register)
}
