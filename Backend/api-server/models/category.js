const dbconfig = require("./Config/Database_Info");
const Area = require("./area");
const { INTEGER } = require("sequelize/dist");

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

Category.belongsTo(Area, { onDelete: 'CASCADE', foreignKey: { name: 'idArea', allowNull: false, type: INTEGER }, targetKey: 'idArea' })

Category.sync()

module.exports = Category