const dbconfig = require ("./Config/Database_Info");
const User = require ("./user")
const Subscription = require ("./subscription")

const ServiceProvider = dbconfig.sequelize.define('ServiceProvider', {
    idSP: {
        type: dbconfig.Sequelize.INTEGER,
        autoIncrement: true,
        primaryKey: true,
        allowNull: false
    },
    description: {
        type: dbconfig.Sequelize.STRING(2000),
        allowNull: false
    },
    dateOfBirth: {
        type: dbconfig.Sequelize.DATEONLY,
        allowNull: true
    },
    endSub: {
        type: dbconfig.Sequelize.DATE,
        allowNull: true
    },
    endSubVip: {
        type: dbconfig.Sequelize.DATE,
        allowNull: true
    },
    distance: {
        type: dbconfig.Sequelize.INTEGER,
        allowNull: true
    },
    qualifications: {
        type: dbconfig.Sequelize.STRING(1000),
        allowNull: true
    },
    averageRating: {
        type: dbconfig.Sequelize.DOUBLE,
        allowNull: false
    },
    workSchedule : {
        type: dbconfig.Sequelize.JSON,
        allowNull: true
    },
    occupiedSchedule : {
        type: dbconfig.Sequelize.JSON,
        allowNull: true
    },
    solidarity : {
        type: dbconfig.Sequelize.BOOLEAN,
        allowNull: false
    }
}, {
        freezeTableName: true,
        timestamps: false
})

// A chave de ServiceProvider é o ID 
ServiceProvider.belongsTo(User, {foreignKey: 'idSP', targetKey:'idUser'})
// Meter a FK de subscription em ServiceProvider
Subscription.hasMany(ServiceProvider, { foreignKey: {name: 'idSubscription', allowNull: false }, onDelete: 'CASCADE', targetKey: 'idSubscription'})

ServiceProvider.sync()

module.exports = ServiceProvider