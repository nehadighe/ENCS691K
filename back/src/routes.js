// initial method

module.exports = (app) => {
    app.get('/', (req, res) => {
        res.send({
            message: 'Hello World'
        })
    })
}


// create a user
// app.post('/api/users', (req, res) => {
//     User.create(req.body)
//         .then(user => res.json(user))
// })
// // get all users
// app.get('/api/users', (req, res) => {
//     User.findAll().then(users => res.json(users))
// })