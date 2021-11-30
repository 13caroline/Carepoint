const dbconfig = require("../../../Config/Database_Info")

const Subscription = dbconfig.sequelize.define('subscription',{
    idSubscription: {
        type: dbconfig.Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    type: {
        type: dbconfig.Sequelize.INTEGER,
        allowNull: false
    },
    value: {
        type: dbconfig.Sequelize.DOUBLE,
        allowNull: false
    },
    duration: {
        type: dbconfig.Sequelize.DATE,
        allowNull: false
    }
}, {
    freezeTableName: true,
    timestamps: false
  })

Subscription.sync()

module.exports = Subscription