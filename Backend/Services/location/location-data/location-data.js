var express = require('express')
var assert = require('assert');
var bodyParser = require('body-parser');

const Location = require("../../location/api/location");
const dbconfig = require("../../../config/Database_Info");

function StartupLocation(app) {
    return new Promise((resolve, reject) => {
        try {
            app.get("/location", (req,res) => {
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