const dbconfig = require ("../../../Config/Database_Info");
const User = require ("../../login/api/user")
const Category = require ("../../category/api/category")
const Location = require ("../../location/api/location")

const JobOffer = dbconfig.sequelize.define('JobOffer', {
    idJobOffer: {
        type: dbconfig.Sequelize.INTEGER,
        autoIncrement: true,
        primaryKey: true,
        allowNull: false
    },
    description: {
        type: dbconfig.Sequelize.STRING(2000),
        allowNull: false
    },
    beginDate: {
        type: dbconfig.Sequelize.DATEONLY,
        allowNull: false
    },
    postDate: {
        type: dbconfig.Sequelize.DATE,
        allowNull: false
    },
    price: {
        type: dbconfig.Sequelize.DOUBLE,
        allowNull: true
    },
    done: {
        type: dbconfig.Sequelize.BOOLEAN,
        allowNull: true
    },
    endDate: {
        type: dbconfig.Sequelize.DATEONLY,
        allowNull: true
    }
}, {
        freezeTableName: true,
        timestamps: false
})

JobOffer.belongsTo(User, {onDelete: 'CASCADE', foreignKey: {name : 'idUser',allowNull: false}, targetKey: 'idUser'})
Category.hasMany(JobOffer, {onDelete: 'CASCADE', foreignKey: {name: 'idCategory', allowNull: false}, targetKey: 'idCategory'})
Location.hasMany(JobOffer, {onDelete: 'CASCADE', foreignKey: {name: 'idLocation', allowNull: false}, targetKey: 'idLocation'})

JobOffer.sync()

module.exports = JobOffer
