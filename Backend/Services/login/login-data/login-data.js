var express = require('express')
var assert = require('assert');
var bodyParser = require('body-parser');
const bcrypt = require("bcryptjs")
const dbconfig = require("../../../config/Database_Info");
const { json } = require('express');


function StartupLogin(app) {
    return new Promise((resolve, reject) => {
        try {
            app.get("/login", (req,res) => {
                Users.findOne({where: {"username" : req.body.username}}).then((usr) => {
                    //console.log(usr)
                    //console.log(usr.password)
                    var result = bcrypt.compareSync(req.body.password, usr.password);
            
                    if(result){
                        req.flash("succ_msg","Login done!")
                        res.redirect("/")
                    }else{
                        req.flash("error_msg","Failed the login.")
                        res.redirect("/")
                    }
                })
            });


            app.get('/operator/add', async(req, res) => {


            });




        } catch (err) {
            next(err);
        }
    });
}

module.exports.StartupLogin = StartupLogin;