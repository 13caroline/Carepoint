/*var express = require('express')
var assert = require('assert');
var bodyParser = require('body-parser');

const Location = require("../../location/api/location");
const dbconfig = require("../../../config/Database_Info");
const auth = require("../../shared/auth")
*/


// Controller for the location model


const Location = require('../models/location')

var Out = module.exports;

//GET by name
Out.consult = (name) => {
    return Location.findAll({ where: { 'name': name } });
}

//GET by id
Out.consult_id = (id) => {
    return Location.findOne({ where: { 'idLocation': id } });
}

//GET all Location
Out.list = () => {
    return Location.findAll();
}

//Creates a new Location
Out.insert = (location) => {
    return Location.create({
        idLocation: location.idLocation,
        name: location.name,
        cordsX: location.cordsX,
        cordsY: location.cordsY
    });
}

// Update Location
Out.update = (id, location) => {
    return Location.update({
        name: location.name,
        cordsX: location.cordsX,
        cordsY: location.cordsY
    }, {
        where: { 'idLocation': id },
        returning: true,
    });
}

//Delete Location by id
Out.remove = (id) => {
    return Location.destroy({ where: { 'idLocation': id } });
}

/*
function StartupLocation(app) {
    return new Promise((resolve, reject) => {
        try {
            app.get("/location", (req,res) => {
                let token = req.query.token;
                user = auth.verifyAuth(token);
                if (!user) {
                    res.writeHead(403, { 'Content-Type': 'application/json' });
                    res.write(JSON.stringify({ error: "Token not Verified" }));
                    res.end();
                    return;
                }

                Location.findAll().then((location) => {
                    res.send(location)
    
                })
            });

            app.get("/location/:id", (req,res) => {
                Location.findOne({where: {"idLocation" : req.params.id}}).then((location) => {
                    res.send(location)

                })
            });

        } catch (err) {
            next(err);
        }
    });
}

module.exports.StartupLocation = StartupLocation;

*/