var express = require('express');
var router = express.Router();

const User = require('../controllers/user')


/****************************************************************************************
 *                                   GET
 ****************************************************************************************/

// List all users given the query param
router.get('/', function(req, res, next) {
    // By access user's type
    if (req.query.type) {
        User.type(req.query.type)
            .then(data => res.status(200).jsonp(data))
            .catch(e => res.status(500).jsonp({ error: e }))
    }
    //By active
    else if (req.query.active) {
        User.active(req.query.active)
            .then(data => res.status(200).jsonp(data))
            .catch(e => res.status(500).jsonp({ error: e }))
    }
    // Default list
    else {
        User.list()
            .then(data => res.status(200).jsonp(data))
            .catch(e => res.status(500).jsonp({ error: e }))
    }
});


// Consult a user given his email address
router.get('/:id', function(req, res, next) {
    User.consult_id(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(500).jsonp({ error: e }))
});


// Consult a user given his email address
router.get('/email/:email', function(req, res, next) {
    User.consult(req.params.email)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(500).jsonp({ error: e }))
});


/****************************************************************************************
 *                                   POST
 ****************************************************************************************/


// Insert a new user
router.post('/', function(req, res) {

    let user = req.body;

    // Define registration date
    user.createdAt = new Date().toISOString();

    // Define number's
    user.active = 0

    User.insert(user)
        .then(data => { res.status(201).jsonp({ data: data }) })
        .catch(e => res.status(500).jsonp({ error: e }))
});


/****************************************************************************************
 *                                   PUT
 ****************************************************************************************/


// Update an user
router.put('/:id', function(req, res, next) {
    User.update(req.params.id, req.body)
        .then(data => res.status(201).jsonp({ data: data }))
        .catch(e => res.status(500).jsonp({ error: e }))
})


/****************************************************************************************
 *                                   DELETE
 ****************************************************************************************/


// Delete a user given is id address
router.delete('/:id', function(req, res, next) {
    User.remove(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(500).jsonp({ error: e }))
});

module.exports = router;