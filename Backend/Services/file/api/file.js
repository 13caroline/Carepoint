const dbconfig = require ("../../../Config/Database_Info");
const User = require ("../../login/api/user")

const File = dbconfig.sequelize.define('File', {
    idFile: {
        type: dbconfig.Sequelize.INTEGER,
        autoIncrement: true,
        primaryKey: true,
        allowNull: false
    },
    image: {
        type: dbconfig.Sequelize.BLOB('medium'),
        allowNull: false
    }
}, {
        freezeTableName: true,
        timestamps: false
})

//Colocar FK de User em File
File.belongsTo(User, {onDelete: 'CASCADE', foreignKey: {name : 'idUser',allowNull: false}, targetKey: 'idUser'})

File.sync()

module.exports = File