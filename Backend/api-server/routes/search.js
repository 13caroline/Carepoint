const express = require('express');
const router = express.Router();
const axios = require('axios');
const config = require('../models/Config/API_info'); 

const auth = require('../authorization/auth');

const search_controller = require('../controllers/search')

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
    var experience = req.query.experience;
    var price = req.query.price;

    var valueString = isUndefined(cat_id) + isUndefined(location_id) + isUndefined(experience) + isUndefined(price);

    console.log("Value String: " + valueString)

    switch (valueString) {
        case '1111':
            search_controller.get_allParameters(cat_id,location_id,experience,price, limit, offset)
            .then(sp => {
                search_controller.get_CompaniesLocation(location_id)
                .then(cp => {
                    res.status(200).jsonp({
                        ServiceProviders: sp,
                        Companies: cp
                    });
                })
                .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            })
            .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            break;
        
        case '1110':
            search_controller.get_allParameters(cat_id,location_id,experience,1000)
            .then(sp => {
                search_controller.get_CompaniesLocation(location_id)
                .then(cp => {
                    res.status(200).jsonp({
                        ServiceProviders: sp,
                        Companies: cp
                    });
                })
                .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            })
            .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            break;
        
        case '1101':
            search_controller.get_allParameters(cat_id,location_id,0,price)
            .then(sp => {
                search_controller.get_CompaniesLocation(location_id)
                .then(cp => {
                    res.status(200).jsonp({
                        ServiceProviders: sp,
                        Companies: cp
                    });
                })
                .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            })
            .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            break;

        case '1011':
            search_controller.get_noLocation(cat_id,experience,price)
            .then(sp => {
                search_controller.get_noParamsCompany()
                .then(cp => {
                    res.status(200).jsonp({
                        ServiceProviders: sp,
                        Companies: cp
                    });
                })
                .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            })
            .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            break;

        case '0111':
            search_controller.get_noCategory(location_id,experience,price)
            .then(sp => {
                search_controller.get_CompaniesLocation(location_id)
                .then(cp => {
                    res.status(200).jsonp({
                        ServiceProviders: sp,
                        Companies: cp
                    });
                })
                .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            })
            .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            break;

        case '1100':
            search_controller.get_categoryANDlocation(cat_id,location_id)
            .then(sp => {
                search_controller.get_CompaniesLocation(location_id)
                .then(cp => {
                    res.status(200).jsonp({
                        ServiceProviders: sp,
                        Companies: cp
                    });
                })
                .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            })
            .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            break;
        
        case '1001':
            search_controller.get_categoryANDprice(cat_id, price)
            .then(sp => {
                search_controller.get_noParamsCompany()
                .then(cp => {
                    res.status(200).jsonp({
                        ServiceProviders: sp,
                        Companies: cp
                    });
                })
                .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            })
            .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            break;
        
        case '1010':
            search_controller.get_categoryANDexperience(cat_id,experience)
            .then(sp => {
                search_controller.get_noParamsCompany()
                .then(cp => {
                    res.status(200).jsonp({
                        ServiceProviders: sp,
                        Companies: cp
                    });
                })
                .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            })
            .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            break;

        case '0101':
            search_controller.get_locationANDprice(location_id, price)
            .then(sp => {
                search_controller.get_CompaniesLocation(location_id)
                .then(cp => {
                    res.status(200).jsonp({
                        ServiceProviders: sp,
                        Companies: cp
                    });
                })
                .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            })
            .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            break;

        case '0011':
            search_controller.get_experienceANDprice(experience,price)
            .then(sp => {
                search_controller.get_noParamsCompany()
                .then(cp => {
                    res.status(200).jsonp({
                        ServiceProviders: sp,
                        Companies: cp
                    });
                })
                .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            })
            .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            break;
        
        case '0110':
            search_controller.get_locationANDexperience(location_id,experience)
            .then(sp => {
                search_controller.get_CompaniesLocation(location_id)
                .then(cp => {
                    res.status(200).jsonp({
                        ServiceProviders: sp,
                        Companies: cp
                    });
                })
                .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            })
            .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            break;

        case '1000':
            search_controller.get_category(cat_id)
            .then(sp => {
                search_controller.get_noParamsCompany()
                .then(cp => {
                    res.status(200).jsonp({
                        ServiceProviders: sp,
                        Companies: cp
                    });
                })
                .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            })
            .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            break;

        case '0100':
            search_controller.get_location(location_id)
            .then(sp => {
                search_controller.get_CompaniesLocation(location_id)
                .then(cp => {
                    res.status(200).jsonp({
                        ServiceProviders: sp,
                        Companies: cp
                    });
                })
                .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            })
            .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            break;

        case '0010':
            search_controller.get_experience(experience)
            .then(sp => {
                search_controller.get_noParamsCompany()
                .then(cp => {
                    res.status(200).jsonp({
                        ServiceProviders: sp,
                        Companies: cp
                    });
                })
                .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            })
            .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            break;
        
        case '0001':
            search_controller.get_money(price)
            .then(sp => {
                search_controller.get_noParamsCompany()
                .then(cp => {
                    res.status(200).jsonp({
                        ServiceProviders: sp,
                        Companies: cp
                    });
                })
                .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            })
            .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            break;

        default:
            search_controller.get_noParams(limit, offset)
            .then(sp => {
                search_controller.get_noParamsCompany()
                .then(cp => {
                    res.status(200).jsonp({
                        ServiceProviders: sp,
                        Companies: "void"//cp
                    });
                })
                .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            })
            .catch((err) => res.status(500).jsonp("Error obtaining Providers"));
            break;
    }
})

router.get('/', (req, res, next) => {
    res.send("void")
})

module.exports = router;