const connection = {

    dbName: 'PI', //dbname here
    options: {
        host: 'localhost',
        dialect: 'mysql',
        logging: false, //disable logging;
        dialectOptions: {
            multipleStatements: true
        }
    },
    user: {
        username: 'root',
        password: 'root' //your pass here
    }
};

const Sequelize = require("sequelize");
const sequelize = new Sequelize(connection.dbName, connection.user.username, connection.user.password, connection.options);

module.exports = {
    connection,
    startConnection,
    Sequelize: Sequelize,
    sequelize: sequelize
};

function startConnection() {
    //Autenticação no SQL para ter a certeza que ligação foi feita!
    sequelize.authenticate().then(() => {
        console.log("Connected to the DB")
    }).catch((err) => {
        console.log("Connection Failed. " + err)
    })
};