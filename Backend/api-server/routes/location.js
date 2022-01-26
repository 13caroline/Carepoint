var express = require('express');
var router = express.Router();

const Location = require('../controllers/location')


/****************************************************************************************
 *                                   GET
 ****************************************************************************************/

// List all Locations
router.get('/', function(req, res, next) {
    Location.list()
    .then(data => res.status(200).jsonp(data[0]))
    .catch(e => res.status(400).jsonp({ error: e }))
});


// Consult a Location given its id
router.get('/:id', function(req, res, next) {
    console.log(req.body)
    Location.consult_id(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(400).jsonp({ error: e }))
});


// Consult a Location given its name
router.get('/name/:name', function(req, res, next) {
    Location.consult(req.params.name)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(400).jsonp({ error: e }))
});




/****************************************************************************************
 *                                   POST
 ****************************************************************************************/


// Insert a new Location
router.post('/', function(req, res) {
    console.log(req.body)
    Location.insert(req.body)
        .then(data => { res.status(201).jsonp({ data: data }) })
        .catch(e => res.status(400).jsonp({ error: e }))
});


/****************************************************************************************
 *                                   PUT
 ****************************************************************************************/


// Update an Location
router.put('/:id', function(req, res, next) {
    Location.update(req.params.id, req.body)
        .then(data => res.status(201).jsonp({ data: data }))
        .catch(e => res.status(400).jsonp({ error: e }))
})


/****************************************************************************************
 *                                   DELETE
 ****************************************************************************************/


// Delete a Location given its id
router.delete('/:id', function(req, res, next) {
    Location.remove(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(400).jsonp({ error: e }))
});

module.exports = router;