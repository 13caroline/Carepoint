var express = require('express')
var cors = require('cors');
var app = express();
app.use(cors());
var bodyParser = require('body-parser');
app.use(bodyParser.json());


const dbconfig = require("./config/Database_Info");
const apiconfig = require("./config/API_Info");
const login = require("./Services/login/login-data/login-data");

//const Location = require("./Services/location/api/Location");
//const Add = require("./Services/add/api/Add");

var port = apiconfig.Port;

app.listen(port, () => console.log(`Listening on port ${port}!`));

async function startupWebServer() {
    try {
        console.log('Connection Started');
        await dbconfig.startConnection();

        console.log('Services Started');
        await startServices(app);
    } catch (err) {
        console.error(err);
    }
}

async function startServices(app) {
    console.log('Starting Login Module');
    login.StartupLogin(app);
    console.log('Starting Regist Module');
    //regist.StartupRegist(app);
}


startupWebServer();