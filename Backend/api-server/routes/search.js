const express = require('express');
const router = express.Router();

const search_controller = require('../controllers/search')

router.get('/', (req, res, next) => {
    
    var page = req.query.page;
    if(page === undefined){page = 1;}

    var limit = 9; // possível alterar depois
    var offset = (page * limit) - limit

    var cat_id = (typeof req.query.category === 'undefined') ? null : req.query.category;
    var loc_id = (typeof req.query.location === 'undefined') ? null : req.query.location;
    var experience = (typeof req.query.experience === 'undefined') ? 0 : req.query.experience;
    var price = (typeof req.query.price === 'undefined') ? null : req.query.price;
    var rating = (typeof req.query.rating === 'undefined') ? 0 : req.query.rating;
    var sex = (typeof req.query.sex === 'undefined' || req.query.sex == 'N') ? null : req.query.sex;

    search_controller.getServiceProviders(cat_id, loc_id, experience, price, rating, sex, limit, offset)
    .then((sp) => {
        search_controller.getCompanies(loc_id, limit, offset)
        .then((cp) => {
            search_controller.getSPSum(cat_id, loc_id, experience, price, rating, sex)
            .then((spCount) => {
                search_controller.getCPSum(loc_id)
                .then((cpCount) => {
                    res.status(200).jsonp({
                        ServiceProviders: sp,
                        Companies: cp,
                        ServiceProviders_Sum: spCount,
                        Companies_Sum: cpCount
                    });
                })
                .catch((err) => res.status(400).jsonp("Error obtaining Providers:" + err));
            })
            .catch((err) => res.status(400).jsonp("Error obtaining Providers:" + err));
        })
        .catch((err) => res.status(400).jsonp("Error obtaining Providers:" + err));
    })
    .catch((err) => res.status(400).jsonp("Error obtaining Providers:" + err));
})

router.get('/serviceProviders', (req, res) => {
    var page = req.query.page;
    if(page === undefined){page = 1;}

    var limit = 9; // possível alterar depois
    var offset = (page * limit) - limit

    var cat_id = (typeof req.query.category === 'undefined') ? null : req.query.category;
    var loc_id = (typeof req.query.location === 'undefined') ? null : req.query.location;
    var experience = (typeof req.query.experience === 'undefined') ? 0 : req.query.experience;
    var price = (typeof req.query.price === 'undefined') ? null : req.query.price;
    var rating = (typeof req.query.rating === 'undefined') ? 0 : req.query.rating;
    var sex = (typeof req.query.sex === 'undefined' || req.query.sex == 'N') ? null : req.query.sex;

    search_controller.getServiceProviders(cat_id, loc_id, experience, price, rating, sex, limit, offset)
    .then((sp) => {
        search_controller.getSPSum(cat_id, loc_id, experience, price, rating, sex)
        .then((spCount) => {
            res.status(200).jsonp({
                ServiceProviders: sp,
                ServiceProviders_Sum: spCount,
                });
        })
        .catch((err) => res.status(400).jsonp({error: "Error obtaining Service Providers:" + err}));
    })
    .catch((err) => res.status(400).jsonp({error: "Error obtaining Service Providers:" + err}));
})

router.get('/companies', (req, res) => {
    var page = req.query.page;
    if(page === undefined){page = 1;}

    var limit = 9; // possível alterar depois
    var offset = (page * limit) - limit

    var loc_id = (typeof req.query.location === 'undefined') ? null : req.query.location;

    search_controller.getCompanies(loc_id, limit, offset)
    .then((cp) => {
        search_controller.getCPSum(loc_id)
        .then((cpCount) => {
            res.status(200).jsonp({
                Companies: cp,
                Companies_Sum: cpCount
            });
        })
        .catch((err) => res.status(400).jsonp({error: "Error obtaining Colective Providers:" + err}));
    })
    .catch((err) => res.status(400).jsonp({error: "Error obtaining Colective Providers:" + err}));
})

router.get('/BySpName', (req, res) => {
    var page = req.query.page;
    if(page === undefined){page = 1;}

    var limit = 9; // possível alterar depois
    var offset = (page * limit) - limit

    var name = (typeof req.query.name === 'undefined') ? null : req.query.name;

    search_controller.getServiceProviders_name(name, limit, offset)
    .then((sp) => {
        search_controller.getSPSum_name(name)
        .then((spCount) => {
            res.status(200).jsonp({
                ServiceProviders: sp,
                ServiceProviders_Sum: spCount,
                });
        })
        .catch((err) => res.status(400).jsonp({error: "Error obtaining Service Providers:" + err}));
    })
    .catch((err) => res.status(400).jsonp({error: "Error obtaining Service Providers:" + err}));
})

router.get('/ByCompanyName', (req, res) => {
    var page = req.query.page;
    if(page === undefined){page = 1;}

    var limit = 9; // possível alterar depois
    var offset = (page * limit) - limit

    var name = (typeof req.query.name === 'undefined') ? null : req.query.name;

    search_controller.getCompanies_name(name, limit, offset)
    .then((cp) => {
        search_controller.getCPSum_name(name)
        .then((cpCount) => {
            res.status(200).jsonp({
                Companies: cp,
                Companies_Sum: cpCount
            });
        })
        .catch((err) => res.status(400).jsonp({error: "Error obtaining Colective Providers:" + err}));
    })
    .catch((err) => res.status(400).jsonp({error: "Error obtaining Colective Providers:" + err}));
})

router.get('/max', (req, res) => {
    search_controller.getMaxValues()
    .then(data => res.status(200).jsonp(data))
    .catch((err) => res.status(400).jsonp({error: err}));
})

module.exports = router;