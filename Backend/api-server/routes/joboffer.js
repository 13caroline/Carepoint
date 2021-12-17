const express = require('express');
const router = express.Router();
const axios = require('axios');
const config = require('../models/Config/API_info'); 

const auth = require('../authorization/auth');

const jobOffer_controller = require('../controllers/joboffer');
const e = require('express');

function isUndefined(t){
    if(t === undefined){
        return "0";
    }

    return "1";
}

router.get('/', (req, res, next) => {
    var page = req.query.page;
    var limit = 10; // possível alterar depois
    var offset = (page * limit) - limit

    var cat_id = req.query.category;
    var location_id = req.query.location;
    var price = req.query.price;

    var valueString = isUndefined(cat_id) + isUndefined(location_id) + isUndefined(price);

    console.log("Value String: " + valueString)

    switch (valueString) {
        case '111':
            jobOffer_controller.get_allParameters(cat_id,location_id,price, limit, offset)
            .then(jobs => {res.status(200).jsonp({jobs});})
            .catch((err) => res.status(500).jsonp("Error obtaining Jobs"));
            break;
        case '110':
            jobOffer_controller.get_allParameters(cat_id,location_id,0,limit,offset)
            .then(jobs => {res.status(200).jsonp({jobs});})
            .catch((err) => res.status(500).jsonp("Error obtaining Jobs"));
            break;
        case '101':
            jobOffer_controller.get_categoryANDprice(cat_id,price,limit,offset)
            .then(jobs => {res.status(200).jsonp({jobs});})
            .catch((err) => res.status(500).jsonp("Error obtaining Jobs"));
            break;
        case '011':
            jobOffer_controller.get_locationANDprice(location_id,price,limit,offset)
            .then(jobs => {res.status(200).jsonp({jobs});})
            .catch((err) => res.status(500).jsonp("Error obtaining Jobs"));
            break;
        case '100':
            jobOffer_controller.get_category(cat_id, limit, offset)
            .then(jobs => {res.status(200).jsonp({jobs});})
            .catch((err) => res.status(500).jsonp("Error obtaining Jobs"));
            break;
        case '010':
            jobOffer_controller.get_location(location_id, limit, offset)
            .then(jobs => {res.status(200).jsonp({jobs});})
            .catch((err) => res.status(500).jsonp("Error obtaining Jobs"));
            break;
        case '001':
            jobOffer_controller.get_price(price, limit, offset)
            .then(jobs => {res.status(200).jsonp({jobs});})
            .catch((err) => res.status(500).jsonp("Error obtaining Jobs"));
            break;
        default:
            jobOffer_controller.get_noParams(10, 0)
            .then(jobs => {res.status(200).jsonp({jobs});})
            .catch((err) => res.status(500).jsonp("Error obtaining Jobs"));
            break;
    }
})

router.post('/new', auth.checkAdminOrUserOrSP, (req, res, next) => {
    return_value = jobOffer_controller.newJob(req.body)

    if(return_value === undefined){
        res.status(500).jsonp("Failure inserting job");
    }
    else{
        jobOffer_controller.get_noParams(10, 0)
        .then(jobs => {res.status(200).jsonp({jobs});})
        .catch((err) => res.status(500).jsonp("Job inserted successfully, but error retrieving jobs"));
    }
})

module.exports = router;