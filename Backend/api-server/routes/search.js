const express = require('express');
const router = express.Router();
const axios = require('axios');
const config = require('../models/Config/API_info'); 

const auth = require('../authorization/auth');

const search_controller = require('../controllers/search')

router.get('/', (req, res, next) => {
    
    var page = req.query.page;
    if(page === undefined){page = 1;}

    var limit = 10; // possível alterar depois
    var offset = (page * limit) - limit

    var cat_id = (typeof req.query.category === 'undefined') ? null : req.query.category;
    var loc_id = (typeof req.query.location === 'undefined') ? null : req.query.location;
    var experience = (typeof req.query.experience === 'undefined') ? null : req.query.experience;
    var price = (typeof req.query.price === 'undefined') ? null : req.query.price;

    search_controller.getServiceProviders(cat_id, loc_id, experience, price, limit, offset)
    .then((sp) => {
        search_controller.getCompanies(loc_id, limit, offset)
        .then(cp => {
            res.status(200).jsonp({
                ServiceProviders: sp,
                Companies: cp
            });
        })
        .catch((err) => res.status(500).jsonp("Error obtaining Providers:" + err));
    })
    .catch((err) => res.status(500).jsonp("Error obtaining Providers:" + err));

})

module.exports = router;