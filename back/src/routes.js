const UserController = require('./controllers/UserController')
const ItemController = require('./controllers/ItemController')

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
    app.post('/items/addItem', ItemController.addItem)

    app.get('/items/getItemById/:ItemID', ItemController.getItemById)

    app.get('/items/getAllUserItems/:username', ItemController.getAllUserItems)

    app.get('/items/getAllItems', ItemController.getAllItems)

}