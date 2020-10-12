module.exports = (sequelize, DataTypes) =>
    sequelize.define('Item', {
        ItemID: {
            type: DataTypes.STRING,
            unique: true
        },
        ItemName: {
            type: DataTypes.STRING
        },
        ItemCategory: {
            type: DataTypes.STRING
        },
        ItemDescription: {
            type: DataTypes.STRING
        },
        ItemAvailability: {
            type: DataTypes.STRING
        },
        ItemBasePrice: {
            type: DataTypes.STRING
        },
        StartingBidTime: {
            type: DataTypes.STRING
        },
        UserID: {
            type: DataTypes.STRING
        }
    })