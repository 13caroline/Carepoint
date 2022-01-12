var express = require('express');
var router = express.Router();

const Review = require('../controllers/review')
const auth = require('../authorization/auth');
const User = require('../controllers/user');


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


// Create a new review
router.post('/', auth.validToken, (req, res) => {

    token = req.body.token;
    email = auth.getEmailFromJWT(token);
    receivingId = parseInt(req.body.receivingId)

    User.consult(email)
    .then((user) => {
        if(user.idUser != receivingId){
            Review.reviewExists(user.idUser, receivingId)
            .then((value) => {
                console.log(value)
                if( value ){
                    Review.addNewReview(req.body.description, req.body.rating, user.idUser, receivingId)
                    .then((res) => res.status(200).jsonp({message: "Review adicionada com sucesso."}))
                    .catch((err) => res.status(500).jsonp({error: err}))
                }else{
                    res.status(500).jsonp({error: "Já existe review com este par de ID's"})
                }
            })
            .catch((err) => res.status(500).jsonp({error: err}))
        }else{
            res.status(500).jsonp({error: "Cannot give a review to yourself!"})
        }
    })
    .catch((err) => res.status(500).jsonp({error: err}))
}); 


/****************************************************************************************
 *                                   PUT
 ****************************************************************************************/

router.put('/edit', auth.matchReview, (req, res, next) => {
    Review.update(req.body)
    .then((dt1) => {
        Review.atualizarRating(req.body.idReceive)
        .then((dt) => res.status(200).jsonp({message: "Review editada com sucesso."}))
        .catch((err) => res.status(500).jsonp({error: err}))
    })
    .catch((err) => res.status(500).jsonp({error: err}))
})

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