var express = require('express');
var router = express.Router();

const Category = require('../controllers/category')


/****************************************************************************************
 *                                   GET
 ****************************************************************************************/

// List all Categorys given the query param
router.get('/', function(req, res, next) {
    Category.list()
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(500).jsonp({ error: e }))
});


// Consult a Category given its name
router.get('/:name', function(req, res, next) {
    Category.consult(req.params.name)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(500).jsonp({ error: e }))
});


// Consult a Category given its id
router.get('/:id/id', function(req, res, next) {
    console.log(req.body)
    Category.consult_id(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(500).jsonp({ error: e }))
});

/****************************************************************************************
 *                                   POST
 ****************************************************************************************/


// Insert a new Category
router.post('/', function(req, res) {
    //console.log(req.body)
    Category.insert(req.body)
        .then(data => { res.status(201).jsonp({ data: data }) })
        .catch(e => res.status(500).jsonp({ error: e }))
});


/****************************************************************************************
 *                                   PUT
 ****************************************************************************************/


// Update an Category
router.put('/:id', function(req, res, next) {
    console.log(req.params.id, req.body)
    Category.update(req.params.id, req.body)
        .then(data => res.status(201).jsonp({ data: data }))
        .catch(e => res.status(500).jsonp({ error: e }))
})


/****************************************************************************************
 *                                   DELETE
 ****************************************************************************************/


// Delete a Category given its id
router.delete('/:id', function(req, res, next) {
    Category.remove(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(500).jsonp({ error: e }))
});

module.exports = router;