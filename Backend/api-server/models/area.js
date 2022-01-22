const dbconfig = require("./Config/Database_Info")

const Area = dbconfig.sequelize.define('Area', {
    idArea: {
        type: dbconfig.Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false
    },
    name: {
        type: dbconfig.Sequelize.STRING(45),
        allowNull: false
    }
}, {
    freezeTableName: true,
    timestamps: false
})

Area.sync()

module.exports = Area