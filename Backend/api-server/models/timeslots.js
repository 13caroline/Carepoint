const dbconfig = require("./Config/Database_Info")

const Timeslots = dbconfig.sequelize.define('timeslots',{
    idTimeSlots: {
        type: dbconfig.Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    day: {
        type: dbconfig.Sequelize.STRING(45),
        allowNull: false
    },
    begin: {
        type: dbconfig.Sequelize.TIME,
        allowNull: false
    },
    end: {
        type: dbconfig.Sequelize.TIME,
        allowNull: false
    }
} , {
    freezeTableName: true,
    timestamps: false
  })

Timeslots.sync()

module.exports = Timeslots