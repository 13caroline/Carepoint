var express = require('express');
var router = express.Router();

const Add = require('../controllers/add')


/****************************************************************************************
 *                                   GET
 ****************************************************************************************/

// List all adds
router.get('/', function(req, res, next) {
    Add.list()
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(400).jsonp({ error: e }))
});

// Consult an Add given its id
router.get('/:id', function(req, res, next) {
    Add.consult_id(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(400).jsonp({ error: e }))
});


/****************************************************************************************
 *                                   POST
 ****************************************************************************************/


// Insert a new Add
router.post('/', function(req, res) {
    console.log(req.body)
    Add.insert(req.body)
        .then(data => { res.status(201).jsonp({ data: data }) })
        .catch(e => res.status(400).jsonp({ error: e }))
});


/****************************************************************************************
 *                                   PUT
 ****************************************************************************************/


// Update an Add
router.put('/:id', function(req, res, next) {
    Add.update(req.params.id, req.body)
        .then(data => res.status(201).jsonp({ data: data }))
        .catch(e => res.status(400).jsonp({ error: e }))
})


/****************************************************************************************
 *                                   DELETE
 ****************************************************************************************/


// Delete an Add given its id
router.delete('/:id', function(req, res, next) {
    Add.remove(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(400).jsonp({ error: e }))
});

module.exports = router;