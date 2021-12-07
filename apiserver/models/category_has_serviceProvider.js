const dbconfig = require ("./Config/Database_Info");
const Category = require("./category");
const ServiceProvider = require("./serviceProvider");

const category_Has_ServiceProvider = dbconfig.sequelize.define('Category_has_ServiceProvider', {
    auxiliarID: {
        type: dbconfig.Sequelize.INTEGER,
        unique: true,
        allowNull: false
    },
    price : {
        type: dbconfig.Sequelize.DOUBLE,
        allowNull: true
    }
}, {
    freezeTableName: true,
    timestamps: false
});

//Preciso repetir duas vezes (acho, estava assim na documentação pelo menos)
Category.belongsToMany(ServiceProvider, { foreignKey: 'idCategory', through: category_Has_ServiceProvider});
ServiceProvider.belongsToMany(Category, { foreignKey: 'idServiceProvider',through: category_Has_ServiceProvider});

category_Has_ServiceProvider.sync()

category_Has_ServiceProvider.beforeCreate((category_Has_ServiceProvider, options) => { 
    return category_Has_ServiceProvider.max('auxiliarId').then((nID) => {
        console.log(nID)
        category_Has_ServiceProvider.auxiliarID=nID+1
    }).catch((err) =>{
        console.log(err)
    })
});

module.exports = category_Has_ServiceProvider;
