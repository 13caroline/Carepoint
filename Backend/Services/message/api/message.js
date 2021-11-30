const dbconfig = require ("../../../Config/Database_Info");
const User = require ("../../login/api/user")

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

Message.belongsTo(User, {onDelete: 'CASCADE', foreignKey: {name : 'idGive',allowNull: false}})
Message.belongsTo(User, {onDelete: 'CASCADE', foreignKey: {name : 'idReceive',allowNull: false}})
Message.sync({force : true})

module.exports = Message