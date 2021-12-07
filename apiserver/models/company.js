const dbconfig = require ("./Config/Database_Info");
const User = require ("./user")
const Subscription = require ("./subscription")

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
        type: dbconfig.Sequelize.STRING(100),
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

// A chave de Company é o ID 
Company.belongsTo(User, {foreignKey: 'idCompany', targetKey:'idUser'})
// Meter a FK de subscription em Company
Subscription.hasMany(Company, { foreignKey: {name: 'idSubscription', allowNull: false }, onDelete: 'CASCADE', targetKey: 'idSubscription'})

Company.sync()

module.exports = Company