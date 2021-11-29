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

    const Sqlize = require("sequelize") 	
    const sqliz = new Sqlize(connection.dbName, connection.user.username, connection.user.password, connection.options)
        
    //Autenticação no SQL para ter a certeza que ligação foi feita!
    sqliz.authenticate().then( () => {
        console.log("Connected to the DB")
    }).catch((err) => {
        console.log("Connection Failed. " + err)
    })

    /*
    const conn = new Sqlize(
        connection.dbName,
        connection.user.username,
        connection.user.password,
        connection.options
    )
    conn.authenticate((err, client) => {
        if (err) return console.log(err);

        console.log(client)
        module.exports.conn = client;

        return;
    })*/
};

function simpleExecute() {

}