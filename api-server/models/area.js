const dbconfig = require("./Config/Database_Info")
const Category = require ("./category")

const Area = dbconfig.sequelize.define('area',{
    idArea: {
        type: dbconfig.Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
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