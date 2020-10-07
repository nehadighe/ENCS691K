// console.log('Hello World')

const express = require('express')
const bodyParser = require('body-parser')
const cors = require('cors')
const morgan = require('morgan')
const db = require('./models')
const config = require('./config/config')

const app = express()
app.use(morgan('combined')) // log about device
app.use(bodyParser.json())
app.use(cors())

require('./routes')(app)

db.sequelize.sync()
    // sequelize.sync()
    .then(() => {
        app.listen(config.port)
        console.log(`Server started on port ${config.port}`)
    })