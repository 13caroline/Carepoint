var express = require('express');
var router = express.Router();

const ServiceProvider = require('../controllers/serviceProvider')


/****************************************************************************************
 *                                   GET
 ****************************************************************************************/

// List all Service Providers given
router.get('/', function(req, res, next) {
    ServiceProvider.list()
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(500).jsonp({ error: e }))
});

// Consult a ServiceProvider given its id
router.get('/:id', function(req, res, next) {
    console.log(req.body)
    console.log(req.params.id)
    ServiceProvider.consult_id(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(500).jsonp({ error: e }))
});


/****************************************************************************************
 *                                   POST
 ****************************************************************************************/


// Insert a new ServiceProvider
router.post('/', function(req, res) {
    console.log(req.body)
    ServiceProvider.insert(req.body)
        .then(data => { res.status(201).jsonp({ data: data }) })
        .catch(e => res.status(500).jsonp({ error: e }))
});


/****************************************************************************************
 *                                   PUT
 ****************************************************************************************/


// Update an ServiceProvider
router.put('/:id', function(req, res, next) {
    ServiceProvider.update(req.params.id, req.body)
        .then(data => res.status(201).jsonp({ data: data }))
        .catch(e => res.status(500).jsonp({ error: e }))
})


/****************************************************************************************
 *                                   DELETE
 ****************************************************************************************/


// Delete a ServiceProvider given its id
router.delete('/:id', function(req, res, next) {
    ServiceProvider.remove(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(500).jsonp({ error: e }))
});

module.exports = router;