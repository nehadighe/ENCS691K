const { User } = require('../models')

module.exports = {
    async registerUser(req, res) {
        try {
            const user = await User.create(req.body)
            res.send(user.toJSON())
        }
        catch (err) {
            res.status(400).send({
                error: 'Username already in use.'
            })
        }
    },

    async getUser(req, res) {
        await User.findOne({ // findOne would only return one
            where: {
                username: req.params.username
            }
        }).then(user => {
            res.json(user)
        })
    },

    async getAllUsers(req, res) {
        await User.findAll().then(user => res.json(user))
    }
}

