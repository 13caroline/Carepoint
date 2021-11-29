const dbconfig = require("../../../Config/Database_Info");

const Location = dbconfig.sequelize.define('location', {
    idLocation: {
        type: dbconfig.Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    name: {
        type: dbconfig.Sequelize.STRING(45),
        required: true
    },
    cordsX: {
        type: dbconfig.Sequelize.STRING(45),
        required: false
    },
    cordsY: {
        type: dbconfig.Sequelize.STRING(45),
        required: false
    }
}, {
    freezeTableName: true,
    timestamps: false
  })

Location.sync()

module.exports = Location