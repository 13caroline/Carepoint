var express = require('express')
var assert = require('assert');
var bodyParser = require('body-parser');

const Location = require("../../location/api/location");
const dbconfig = require("../../../config/Database_Info");
const auth = require("../../shared/auth")

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