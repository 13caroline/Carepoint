const express = require('express');
const router = express.Router();

const auth = require('../authorization/auth')
const user_controller = require('../controllers/user')
const Subscription_controller = require('../controllers/subscription')

function getSubscriptionType(n) {
    var ret = 0;

    switch (n){
        case '0':
            ret = 1;
            break;

        case '1':
            ret = 2;
            break;
            
        case '3':
            ret = 3;
            break;
            
        case '6':
            ret = 4;
            break;
            
        default:
            console.log("Entered default case on switch")
            break;
    }

    return ret;
}

function getVisibilityType(n) {
    var ret = 0;

    switch (n){
        case '1':
            ret = 1;
            break;

        case '3':
            ret = 2;
            break;
            
        case '6':
            ret = 3;
            break;
            
        case '10':
            ret = 4;
            break;
            
        default:
            console.log("Entered default case on switch")
            break;
    }

    return ret;
}

/****************************************************************************************
 *                                   GET
 ****************************************************************************************/

// Initial purchase of subscription
router.get('/', (req, res, next) => {
    
    var token = req.body.token;
    var normalSub = req.body.subscription;
    var visiSub = req.body.visibility;

    var email = auth.getEmailFromJWT(token);

    if(normalSub===undefined || visiSub===undefined){
        res.status(401).jsonp({error: "Campos da query vazios!"})
    }else{
        
        var normal = getSubscriptionType(normalSub);
        var visibility = getVisibilityType(visiSub);

        user_controller.consult(email)
        .then((user) => {

            Subscription_controller.activateSubscriptionNormal(user.idUser, normal)
            .then((dt) => {

                if(visiSub != '0'){
                    
                    Subscription_controller.activateSubscriptionVisibility(user.idUser, visibility)
                    .then((dt2) => res.status(200).jsonp({message: "Sucesso na adição da subscrição!"}))
                    .catch((err) => res.status(500).jsonp({error: err}))

                }else{
                    res.status(200).jsonp({message: "Sucesso na adição da subscrição!"})
                }
            })
            .catch((err1) => res.status(500).jsonp({error: err1}))
        })
        .catch((erro) => res.status(500).jsonp({error: erro}))
    }
});


// Consult a subscription given his email address
router.get('/:id', function(req, res, next) {
    Subscription_controller.consult_id(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(500).jsonp({ error: e }))
});



/****************************************************************************************
 *                                   POST
 ****************************************************************************************/


// Insert a new subscription
router.post('/', function(req, res) {
    Subscription_controller.insert(req.body)
        .then(data => { res.status(201).jsonp({ data: data }) })
        .catch(e => res.status(500).jsonp({ error: e }))
});


/****************************************************************************************
 *                                   PUT
 ****************************************************************************************/


// Update an subscription
router.put('/:id', function(req, res, next) {
    Subscription_controller.update(req.params.id, req.body)
        .then(data => res.status(201).jsonp({ data: data }))
        .catch(e => res.status(500).jsonp({ error: e }))
})


/****************************************************************************************
 *                                   DELETE
 ****************************************************************************************/


// Delete a subscription given is id address
router.delete('/:id', function(req, res, next) {
    Subscription_controller.remove(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(500).jsonp({ error: e }))
});

module.exports = router;