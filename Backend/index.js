var express = require('express')
var cors = require('cors');
var app = express();
app.use(cors());
var bodyParser = require('body-parser');
app.use(bodyParser.json());


const dbconfig = require("./config/Database_Info");
const apiconfig = require("./config/API_Info");
const login = require("./Services/login/login-data/login-data");
//const location = require("./Services/location/location-data/location-data");
const auth = require("./Services/shared/auth")

//Para testar!!!
const Location = require("./Services/location/api/Location");
const User = require("./Services/login/api/user");

const Message = require("./Services/message/api/message")
const Review = require("./Services/review/api/review")

const File = require("./Services/file/api/file");
const Subscription = require("./Services/subscription/api/subscription");
const Company = require("./Services/company/api/company");
const Add = require("./Services/add/api/add");

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
    auth.StartupAuth(app);
    console.log('Starting Regist Module');
    //location.StartupLocation(app);
}


startupWebServer();