const dbconfig = require ("../../../Config/Database_Info");
const Category = require("../../category/api/category");
const ServiceProvider = require("../../serviceProvider/api/serviceProvider");

const category_Has_ServiceProvider = dbconfig.sequelize.define('Category_has_ServiceProvider', {
    price : {
        type: dbconfig.Sequelize.DOUBLE,
        allowNull: true
    }
}, {
    freezeTableName: true,
    timestamps: false
});

//Preciso repetir duas vezes (acho, estava assim na documentação pelo menos)
Category.belongsToMany(ServiceProvider, { through: category_Has_ServiceProvider});
ServiceProvider.belongsToMany(Category, { through: category_Has_ServiceProvider});

category_Has_ServiceProvider.sync()

module.exports = category_Has_ServiceProvider;