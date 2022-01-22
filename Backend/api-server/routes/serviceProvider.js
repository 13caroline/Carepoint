const express = require('express');
const router = express.Router();

const ServiceProvider = require('../controllers/serviceProvider');


/****************************************************************************************
 *                                   GET
 ****************************************************************************************/

//Obter os horários de um serviceProvider especifico com o ID
 router.get('/horarios', (req, res) => {
    var iden = req.query.id;

    ServiceProvider.get_horarios(iden)
    .then((categories) => res.status(200).jsonp({categories: categories}))
    .catch((err) => res.status(500).jsonp("Error obtaining Provider: " + err));
 })

// List a Service Provider given it's id
router.get('/', (req, res, next) => {
    
    var iden = req.query.id;

    ServiceProvider.sp_profile(iden)
    .then((profile) => {
        ServiceProvider.get_reviews(iden)
        .then((reviews) => {
            ServiceProvider.get_only_categories(iden)
            .then((categories) => {
                res.status(200).jsonp({
                    ServiceProvider: profile,
                    reviews: reviews,
                    categories: categories
                })
            })
            .catch((err) => res.status(500).jsonp("Error obtaining Provider: " + err));
        })
        .catch((err) => res.status(500).jsonp("Error obtaining Provider: " + err));
    })
    .catch((err) => res.status(500).jsonp("Error obtaining Provider: " + err));
})

// Consult a ServiceProvider given its id
router.get('/:id', function(req, res, next) {
    console.log(req.body)
    console.log(req.params.id)
    ServiceProvider.consult_id(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(500).jsonp({ error: e }))
});

//Obter toda a informação referente a um service provider
/*router.get('/profile/', (req, res, next) => {
})
*/
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