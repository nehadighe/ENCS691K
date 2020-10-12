const { Item } = require('../models')

module.exports = {
    async addItem(req, res) {
        try {
            const Item = await Item.create(req.body)
            res.send(item.toJSON())
        } catch (err) {
            res.status(400).send({
                error: 'Wrong Item'
            })
        }
    },

    async getItemById(req, res) {
        await Item.findOne({
            where: {
                ItemID: req.params.ItemID
            }
        }).then(item => {
            res.json(item)
        })
    },

    async getAllItems(req, res) {
        await item.findAll().then(item => res.json(item))
    },

    async getAllUserItems(req, res) {
        await Item.findOne({
            where: {
                UserID: req.params.UserID
            }
        }).then(item => {
            res.json(item)
        })
    }
}