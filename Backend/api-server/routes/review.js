var express = require('express');
var router = express.Router();

const Review = require('../controllers/review')


/****************************************************************************************
 *                                   GET
 ****************************************************************************************/

// List all reviews
router.get('/', function(req, res, next) {
    Review.list()
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(500).jsonp({ error: e }))
});

// Consult a Review given its id
router.get('/:id', function(req, res, next) {
    Review.consult_id(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(500).jsonp({ error: e }))
});


/****************************************************************************************
 *                                   POST
 ****************************************************************************************/


// Insert a new Review
router.post('/', function(req, res) {
    console.log(req.body)
    Review.insert(req.body)
        .then(data => { res.status(201).jsonp({ data: data }) })
        .catch(e => res.status(500).jsonp({ error: e }))
});


/****************************************************************************************
 *                                   PUT
 ****************************************************************************************/


// Update a Review
router.put('/:id', function(req, res, next) {
    Review.update(req.params.id, req.body)
        .then(data => res.status(201).jsonp({ data: data }))
        .catch(e => res.status(500).jsonp({ error: e }))
})


/****************************************************************************************
 *                                   DELETE
 ****************************************************************************************/


// Delete a Review given its id
router.delete('/:id', function(req, res, next) {
    Review.remove(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(500).jsonp({ error: e }))
});

module.exports = router;