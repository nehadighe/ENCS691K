const UserController = require('./controllers/UserController')

module.exports = (app) => {
    app.get('/', (req, res) => {
        res.send({
            message: 'Hello World'
        })
    })

    // User Routes
    app.post('/users/register', UserController.registerUser)

    app.get('/users/:username', UserController.getUser)

    app.get('/users', UserController.getAllUsers)

    // Product Routes
}