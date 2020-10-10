const {User} = require('../models')

module.exports = {
    async register(re,res){
        try{
            const user = await User.create(req.body)
            res.send(user.toJSON())
        }
        catch(err){
            res.status(400).send({
                error: 'Username already in use.'   
            })
        }
    }
}
