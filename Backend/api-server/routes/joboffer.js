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

    var limit = 9; // possível alterar depois
    var offset = (page * limit) - limit

    var cat_id = (typeof req.query.category === 'undefined') ? null : req.query.category;
    var loc_id = (typeof req.query.location === 'undefined') ? null : req.query.location;
    var price = (typeof req.query.price === 'undefined') ? null : req.query.price;

    jobOffer_controller.get_JobOffers(cat_id,loc_id,price,limit,offset)
    .then((jobs) => {
        jobOffer_controller.get_JobOffers_Count(cat_id,loc_id,price)
        .then((count) => {
            res.status(200).jsonp({
                JobOffers: jobs,
                Total: count
            });
        })
        .catch((err) => res.status(500).jsonp("Error obtaining Jobs: " + err));
    })
    .catch((err) => res.status(500).jsonp("Error obtaining Jobs: " + err));
})

router.post('/own', auth.validToken, (req, res) => {
    email = auth.getEmailFromJWT(req.body.token)
    jobOffer_controller.getOwnJobs(email)
    .then((jobs) => res.status(200).jsonp(jobs))
    .catch((err) => res.status(500).jsonp(err))
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

router.put('/conclude', auth.checkOwnershipJobOffer, (req, res, next) => {
    jobOffer_controller.concludeJob(req.body.id_job_offer)
    .then((job) => res.status(200).jsonp(job))
    .catch((err) =>  res.status(500).jsonp("Failure marking job as completed: " + err))
})

module.exports = router;