const dbconfig = require ("../../../Config/Database_Info");
const Location = require ("../../location/api/location")
const bcrypt = require("bcryptjs")

const User = dbconfig.sequelize.define('User', {
    idUser: {
        type: dbconfig.Sequelize.INTEGER,
        autoIncrement: true,
        primaryKey: true,
        allowNull: false
    },
    name: {
        type: dbconfig.Sequelize.STRING(100),
        allowNull: false
    },
    password: {
        type: dbconfig.Sequelize.STRING(90),
        allowNull: false
    },
    email: {
        type: dbconfig.Sequelize.STRING(90),
        allowNull: false
    },
    phoneNumber: {
        type: dbconfig.Sequelize.STRING(45),
        allowNull: true
    },
    sex: {
        type: dbconfig.Sequelize.STRING(1),
        allowNull: false
    },
    type: {
        type: dbconfig.Sequelize.STRING(45),
        defaultValue: '0',
        allowNull: false
    },
    createdAt: {
        type: dbconfig.Sequelize.DATE,
        allowNull: false
    },
    lastActivity: {
        type: dbconfig.Sequelize.DATE,
        allowNull: false
    },
    active: {
        type: dbconfig.Sequelize.BOOLEAN,
        allowNull: true
    }
}, {
        freezeTableName: true,
        timestamps: false
})

//User.belongsTo(Location, {onDelete: 'CASCADE', foreignKey: {name : 'idLocation',allowNull: false}})

//Uma location tem um user, vai meter uma foreign key de uma Location em User
//Location.hasOne(User, {onDelete: 'CASCADE', foreignKey: {name : 'idLocation',allowNull: false}, targetKey: 'idLocation'})
Location.hasMany(User, {onDelete: 'CASCADE', foreignKey: {name : 'idLocation',allowNull: false}, targetKey: 'idLocation'})
//User.belongsTo(Location, {onDelete: 'CASCADE', foreignKey: {name : 'idLocation',allowNull: false}, targetKey: 'idLocation'})


User.beforeCreate((user, options) => { 
    return bcrypt.hash(user.password, 10)
        .then(hash => {
            user.password = hash;
        })
        .catch(err => { 
            throw new Error(); 
        });
});

User.sync()

module.exports = User