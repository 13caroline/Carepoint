var express = require('express');
var router = express.Router();

const Company = require('../controllers/company')


/****************************************************************************************
 *                                   GET
 ****************************************************************************************/

router.get('/specific', (req, res) => {
    Company.getPerfilCompany_2(req.body.id)
    .then((data) => res.status(200).jsonp(data))
    .catch(e => res.status(500).jsonp({ error: e }))
})

// List all Companies given the query param
router.get('/', function(req, res, next) {
    Company.list()
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(500).jsonp({ error: e }))
});

// Consult a Company given its id
router.get('/:id', function(req, res, next) {
    console.log(req.body)
    console.log(req.params.id)
    Company.consult_id(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(500).jsonp({ error: e }))
});


// Consult a Company given its nipc
router.get('/nipc/:nipc', function(req, res, next) {
    Company.consult_nipc(req.params.nipc)
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