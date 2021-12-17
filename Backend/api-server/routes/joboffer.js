const express = require('express');
const router = express.Router();
const axios = require('axios');
const config = require('../models/Config/API_info'); 

const auth = require('../authorization/auth');

const jobOffer_controller = require('../controllers/joboffer');
const user_controller = require('../controllers/user')

router.get('/', (req, res, next) => {
    
    var page = req.query.page;
    if(page === undefined){page = 1;}

    var limit = 10; // possível alterar depois
    var offset = (page * limit) - limit

    var cat_id = (typeof req.query.category === 'undefined') ? null : req.query.category;
    var loc_id = (typeof req.query.location === 'undefined') ? null : req.query.location;
    var price = (typeof req.query.price === 'undefined') ? null : req.query.price;

    jobOffer_controller.get_JobOffers(cat_id,loc_id,price,limit,offset)
    .then(jobs => {res.status(200).jsonp({jobs});})
    .catch((err) => res.status(500).jsonp("Error obtaining Jobs: " + err));
})

router.post('/new', auth.checkAdminOrUserOrSP, (req, res, next) => {
    
    email = auth.getEmailFromJWT(req.body.token)
    user_controller.consult(email)
    .then((user) => {
        jobOffer_controller.newJob(req.body, user.idUser)
        .then((job) => {
            jobOffer_controller.get_JobOffers(null,null,null,10,0)
            .then(jobs => {res.status(200).jsonp({jobs});})
            .catch((err) => res.status(500).jsonp("Job inserted successfully, but error retrieving jobs: " + err));
        })
        .catch((err) => res.status(500).jsonp("Failure inserting job: " + err));
    })
    .catch((err) => res.status(500).jsonp("Failure inserting job: " + err))
})

module.exports = router;