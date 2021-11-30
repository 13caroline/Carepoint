const dbconfig = require ("../../../Config/Database_Info");
const User = require ("../../login/api/user")

const Review = dbconfig.sequelize.define('Review', {
    idReview: {
        type: dbconfig.Sequelize.INTEGER,
        autoIncrement: true,
        primaryKey: true,
        allowNull: false
    },
    description: {
        type: dbconfig.Sequelize.STRING(2000),
        allowNull: false
    },
    rating: {
        type: dbconfig.Sequelize.INTEGER,
        allowNull: false
    },
    postDate: {
        type: dbconfig.Sequelize.DATE,
        allowNull: false
    }
}, {
        freezeTableName: true,
        timestamps: false
})

Review.belongsTo(User, {onDelete: 'CASCADE', foreignKey: {name : 'idGive',allowNull: false}})
Review.belongsTo(User, {onDelete: 'CASCADE', foreignKey: {name : 'idReceive',allowNull: false}})
Review.sync({force : true})

module.exports = Review