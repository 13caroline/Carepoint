var express = require('express')
var assert = require('assert');
var bodyParser = require('body-parser');

const dbconfig = require("../../../config/Database_Info");
const { json } = require('express');


function StartupLogin(app) {
    return new Promise((resolve, reject) => {
        try {
            app.get("/operators", (req,res) => {
                
            });


            app.get('/operator/add', async(req, res) => {


            });




        } catch (err) {
            next(err);
        }
    });
}

module.exports.StartupLogin = StartupLogin;