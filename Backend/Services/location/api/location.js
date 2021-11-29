const dbconfig = require("../../../Config/Database_Info");

const Location = dbconfig.sequelize.define('location', {
    idLocation: {
        type: dbconfig.Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    name: {
        type: dbconfig.Sequelize.STRING(45),
        allowNull: false
    },
    cordsX: {
        type: dbconfig.Sequelize.STRING(45),
        allowNull: true
    },
    cordsY: {
        type: dbconfig.Sequelize.STRING(45),
        allowNull: true
    }
}, {
    freezeTableName: true,
    timestamps: false
  })

Location.sync()

module.exports = Location