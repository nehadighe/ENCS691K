const UserController = require('./controllers/UserController')

module.exports = (app) => {
      app.get('/', (req, res) => {
          res.send({
              message: 'Hello World'
          })
      })

    app.post('/users/register', UserController.registerUser)

    app.get('/users/:id',UserController.getUser)

    app.get('/users',UserController.getAllUsers)

}