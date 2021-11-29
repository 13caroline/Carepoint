const Sqlize = require("sequelize");

const connection = {

    dbName: 'AKProj',
    options: {
        host: 'localhost',
        dialect: 'mysql',
    },
    user: {
        username: 'root',
        password: 'th0ldana'
    }
};

module.exports = {
    connection,
    startConnection


};

function startConnection() {

    const conn = new Sqlize(
        connection.dbName,
        connection.user.username,
        connection.user.password,
        connection.options
    )
    conn.authenticate((err, client) => {
        if (err) return console.log(err);

        module.exports.conn = client;

    })
};

function simpleExecute() {

}