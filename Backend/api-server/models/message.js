const dbconfig = require ("./Config/Database_Info");
const User = require ("./user")

const Message = dbconfig.sequelize.define('Message', {
    idMessage: {
        type: dbconfig.Sequelize.INTEGER,
        autoIncrement: true,
        primaryKey: true,
        allowNull: false
    },
    date: {
        type: dbconfig.Sequelize.DATE,
        allowNull: false
    },
    content: {
        type: dbconfig.Sequelize.STRING(200),
        allowNull: false
    }
}, {
        freezeTableName: true,
        timestamps: false
})

Message.belongsTo(User, {onDelete: 'CASCADE', foreignKey: {name : 'idGive',allowNull: false}, targetKey: 'idUser'})
Message.belongsTo(User, {onDelete: 'CASCADE', foreignKey: {name : 'idReceive',allowNull: false}, targetKey: 'idUser'})
Message.sync()

module.exports = Message