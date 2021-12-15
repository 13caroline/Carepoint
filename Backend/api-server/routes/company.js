var express = require('express');
var router = express.Router();

const Company = require('../controllers/company')


/****************************************************************************************
 *                                   GET
 ****************************************************************************************/

// List all Companies given the query param
router.get('/', function(req, res, next) {
    Company.list()
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(500).jsonp({ error: e }))
});


// Consult a Company given its name
router.get('/:name', function(req, res, next) {
    Company.consult(req.params.name)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(500).jsonp({ error: e }))
});


// Consult a Company given its id
router.get('/:id/id', function(req, res, next) {
    console.log(req.body)
    Company.consult_id(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(500).jsonp({ error: e }))
});

/****************************************************************************************
 *                                   POST
 ****************************************************************************************/


// Insert a new Company
router.post('/', function(req, res) {
    console.log(req.body)
    Company.insert(req.body)
        .then(data => { res.status(201).jsonp({ data: data }) })
        .catch(e => res.status(500).jsonp({ error: e }))
});


/****************************************************************************************
 *                                   PUT
 ****************************************************************************************/


// Update an Company
router.put('/:id', function(req, res, next) {
    //console.log(req.params.id, req.body)
    Company.update(req.params.id, req.body)
        .then(data => res.status(201).jsonp({ data: data }))
        .catch(e => res.status(500).jsonp({ error: e }))
})


/****************************************************************************************
 *                                   DELETE
 ****************************************************************************************/


// Delete a Company given its id
router.delete('/:id', function(req, res, next) {
    Company.remove(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(500).jsonp({ error: e }))
});

module.exports = router;