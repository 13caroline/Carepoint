const dbconfig = require ("../../../Config/Database_Info");
const File = require ("../../file/api/file")
const Subscription = require ("../../subscription/api/Subscription")

const Company = dbconfig.sequelize.define('Company', {
    idCompany: {
        type: dbconfig.Sequelize.INTEGER,
        autoIncrement: true,
        primaryKey: true,
        allowNull: false
    },
    link: {
        type: dbconfig.Sequelize.STRING(1000),
        allowNull: false
    },
    firm: {
        type: dbconfig.Sequelize.INTEGER,
        allowNull: true
    },
    nipc: {
        type: dbconfig.Sequelize.INTEGER,
        allowNull: false
    }
}, {
        freezeTableName: true,
        timestamps: false
})

Company.belongsTo(File, {onDelete: 'CASCADE', foreignKey: {name : 'idFile',allowNull: false}})
Company.belongsTo(Subscription, {onDelete: 'CASCADE', foreignKey: {name : 'idSubscription',allowNull: false}})
Company.sync({force : true})

module.exports = Company