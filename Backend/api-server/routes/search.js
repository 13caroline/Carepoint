const express = require('express');
const router = express.Router();
const axios = require('axios');
const config = require('../models/Config/API_info'); 

const auth = require('../authorization/auth');

function isUndefined(t){
    if(t === undefined){
        return "0";
    }

    return "1";
}

router.get('/', (req, res, next) => {
    var cat_id = req.query.category;
    var location_id = req.query.location;
    var experience = req.query.experience;
    var price = req.query.price;

    var valueString = isUndefined(cat_id) + isUndefined(location_id) + isUndefined(experience) + isUndefined(price);

    switch (valueString) {

    }

    res.send("ok")
})

router.get('/:category/:location?', (req, res, next) => {
    var cat_id = req.params.category;
    var loc_id = req.params.location;

    console.log(cat_id)
    console.log(loc_id)

    if(!loc_id){
        // chamar a view para ter todos os serviceProviders e empresas
        dbconfig.sequelize.query('CALL get_service_providers_category (:id)',
            {replacements: {id: cat_id}})
        .then((serviceProviders) => {

            dbconfig.sequelize.query('SELECT * FROM get_companies')
            .then((companies) => { 
                res.status(200).jsonp({
                    SP: serviceProviders,
                    CP: companies
                });
            })
            .catch((e) => res.status(500).jsonp({error: e}))
        })
        .catch((e) => res.status(500).jsonp({error: e}))
        
    }else{
        // chamar a view para ter todos os serviceProviders e empresas dependendo da localização
        res.status(200).jsonp({message: "SP's and Comps com Location"})
    }
})

router.get('/', (req, res, next) => {
    res.send("void")
})

module.exports = router;