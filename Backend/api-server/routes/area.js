var express = require('express');
var router = express.Router();

const Area = require('../controllers/area')


/****************************************************************************************
 *                                   GET
 ****************************************************************************************/

// List all Areas given the query param
router.get('/', function(req, res, next) {
    Area.list()
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(400).jsonp({ error: e }))
});


// Consult a Area given its id
router.get('/:id', function(req, res, next) {
    console.log(req.body)
    Area.consult_id(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(400).jsonp({ error: e }))
});


// Consult a Area given its name
router.get('/name/:name', function(req, res, next) {
    Area.consult(req.params.name)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(400).jsonp({ error: e }))
});




/****************************************************************************************
 *                                   POST
 ****************************************************************************************/


// Insert a new Area
router.post('/', function(req, res) {
    console.log(req.body)
    Area.insert(req.body)
        .then(data => { res.status(201).jsonp({ data: data }) })
        .catch(e => res.status(400).jsonp({ error: e }))
});


/****************************************************************************************
 *                                   PUT
 ****************************************************************************************/


// Update an Area
router.put('/:id', function(req, res, next) {
    Area.update(req.params.id, req.body)
        .then(data => res.status(201).jsonp({ data: data }))
        .catch(e => res.status(400).jsonp({ error: e }))
})


/****************************************************************************************
 *                                   DELETE
 ****************************************************************************************/


// Delete a Area given its id
router.delete('/:id', function(req, res, next) {
    Area.remove(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(400).jsonp({ error: e }))
});

module.exports = router;