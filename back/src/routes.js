const UserController = require('./controllers/UserController')
const ItemController = require('./controllers/ItemController')

module.exports = (app) => {
    app.get('/', (req, res) => {
        res.send({
            message: 'Hello World'
        })
    }) // hello world

    // User Routes
    app.post('/users/register', UserController.registerUser) // register a user

    app.get('/users/:username', UserController.getUser)

    app.get('/users', UserController.getAllUsers) // get all the users

    // Product Routes
    app.post('/items/addItem', ItemController.addItem)

    app.get('/items/getItemById/:ItemID', ItemController.getItemById)

    app.get('/items/getAllUserItems/:username', ItemController.getAllUserItems)

    app.get('/items/getAllItems', ItemController.getAllItems)

}