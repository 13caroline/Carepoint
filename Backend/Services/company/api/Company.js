const dbconfig = require("../../../Config/Database_Info");

const Company = dbconfig.sequelize.define('company', {
    idCompany: {
        type: dbconfig.Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
}, {
    freezeTableName: true,
    timestamps: false
  })

Company.sync()

module.exports = Company