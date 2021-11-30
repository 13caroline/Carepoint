const dbconfig = require("../../../Config/Database_Info");
const Company = require("../../company/api/company")

const Add = dbconfig.sequelize.define('add', {
    idAdd: {
        type: dbconfig.Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false
    },
    description: {
        type: dbconfig.Sequelize.STRING(2000),
        allowNull: false
    }
}, {
    freezeTableName: true,
    timestamps: false
  })

//Add.belongsTo(Company, {foreignKey: 'idCompany', targetKey: 'idCompany'})
Add.belongsTo(Company, {onDelete: 'CASCADE', foreignKey: {name : 'idCompany',allowNull: false},  targetKey: 'idCompany'})

Add.sync()

module.exports = Add