const dbconfig = require ("../../../Config/Database_Info");
const Area = require ("../../area/api/Area")

const Category = dbconfig.sequelize.define('Category', {
    idCategory: {
        type: dbconfig.Sequelize.INTEGER,
        autoIncrement: true,
        primaryKey: true,
        allowNull: false
    },
    name: {
        type: dbconfig.Sequelize.STRING(45),
        allowNull: false
    }
}, {
        freezeTableName: true,
        timestamps: false
})

Category.belongsTo(Area, {onDelete: 'CASCADE', foreignKey: {name : 'Area_idArea',allowNull: false}})
Category.sync({force : true})

module.exports = Category