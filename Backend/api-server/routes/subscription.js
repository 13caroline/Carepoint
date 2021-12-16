var express = require('express');
var router = express.Router();

const Subscription = require('../controllers/subscription')


/****************************************************************************************
 *                                   GET
 ****************************************************************************************/

// List all subscriptions given the query param
router.get('/', function(req, res, next) {
    // By access subscription's type
    if (req.query.type) {
        Subscription.type(req.query.type)
            .then(data => res.status(200).jsonp(data))
            .catch(e => res.status(500).jsonp({ error: e }))
    }
    //By value
    else if (req.query.value) {
        Subscription.value(req.query.value)
            .then(data => res.status(200).jsonp(data))
            .catch(e => res.status(500).jsonp({ error: e }))
    }
    //By duration
    else if (req.query.duration) {
        Subscription.duration(req.query.duration)
            .then(data => res.status(200).jsonp(data))
            .catch(e => res.status(500).jsonp({ error: e }))
    }
    // Default list
    else {
        Subscription.list()
            .then(data => res.status(200).jsonp(data))
            .catch(e => res.status(500).jsonp({ error: e }))
    }
});


// Consult a subscription given his email address
router.get('/:id', function(req, res, next) {
    Subscription.consult_id(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(500).jsonp({ error: e }))
});



/****************************************************************************************
 *                                   POST
 ****************************************************************************************/


// Insert a new subscription
router.post('/', function(req, res) {
    Subscription.insert(req.body)
        .then(data => { res.status(201).jsonp({ data: data }) })
        .catch(e => res.status(500).jsonp({ error: e }))
});


/****************************************************************************************
 *                                   PUT
 ****************************************************************************************/


// Update an subscription
router.put('/:id', function(req, res, next) {
    Subscription.update(req.params.id, req.body)
        .then(data => res.status(201).jsonp({ data: data }))
        .catch(e => res.status(500).jsonp({ error: e }))
})


/****************************************************************************************
 *                                   DELETE
 ****************************************************************************************/


// Delete a subscription given is id address
router.delete('/:id', function(req, res, next) {
    Subscription.remove(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(500).jsonp({ error: e }))
});

module.exports = router;