module.exports = {
    port: 8081,
    db: {
        database: 'auctionsystem',
        user: 'admin',
        password: 'encs691k!',
        options: {
            dialect: 'mysql',
            host: 'encs691k-dev.ccyynx7z7er3.us-east-1.rds.amazonaws.com' // development
            // host: 'db.encs691k.edgardoreinoso.com' // production
            // host: 'encs691k-prod.ccyynx7z7er3.us-east-1.rds.amazonaws.com' // production
        }
    },
}