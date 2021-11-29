const dbconfig = require("../../../Config/Database_Info");
const Company = require("../../../Services/company/api/Company")

const Add = dbconfig.sequelize.define('add', {
    idAdd: {
        type: dbconfig.Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    description: {
        type: dbconfig.Sequelize.STRING(200),
        required: true
    }
}, {
    freezeTableName: true,
    timestamps: false
  })

Add.belongsTo(Company, {foreignKey: 'idCompany', targetKey: 'idCompany'})

Add.sync()

module.exports = Add