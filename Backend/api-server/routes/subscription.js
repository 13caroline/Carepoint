const express = require('express');
const router = express.Router();

const auth = require('../authorization/auth')
const user_controller = require('../controllers/user')
const Subscription_controller = require('../controllers/subscription')

function getSubscriptionType_SP(n) {
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

function getVisibilityType_SP(n) {
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

function getSubscriptionType_CP(n) {
    var ret = 0;

    switch (n){
        case '0':
            ret = 1;
            break;

        case '1':
            ret = 8;
            break;
            
        case '3':
            ret = 9;
            break;
            
        case '6':
            ret = 10;
            break;
            
        default:
            console.log("Entered default case on switch")
            break;
    }

    return ret;
}

function getVisibilityType_CP(n) {
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
            
        default:
            ret = 4;
            console.log("Entered default case on switch")
            break;
    }

    return ret;
}

/****************************************************************************************
 *                                   GET
 ****************************************************************************************/

// Consult a subscription given his email address
router.get('/:id', function(req, res, next) {
    Subscription_controller.consult_id(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(400).jsonp({ error: e }))
});



/****************************************************************************************
 *                                   POST
 ****************************************************************************************/
//terminate sub
router.post('/terminate', auth.validToken, (req, res) => {
    var email = auth.getEmailFromJWT(req.body.token)
    var type = auth.getTypeFromJWT(req.body.token)
    user_controller.consult(email)
    .then((usr) => {
        var id = usr.idUser;
        if(type==3){
            Subscription_controller.terminateSubSP(id)
            .then((upd) => res.status(200).jsonp({message: "success"}))
            .catch((err) => res.status(400).jsonp({error: err}))
        }else{
            Subscription_controller.terminateSubSP(id)
            .then((upd) => res.status(200).jsonp({message: "success"}))
            .catch((err) => res.status(400).jsonp({error: err}))
        }
    })
})

// Initial purchase of subscription
router.post('/', (req, res, next) => {
    
    var token = req.body.token;
    var normalSub = req.body.subscription;
    var visiSub = req.body.visibility;

    var email = auth.getEmailFromJWT(token);
    var type = auth.getTypeFromJWT(token);

    if(normalSub===undefined || visiSub===undefined){
        res.status(401).jsonp({error: "Campos da query vazios!"})
    }else{
        
        if(type == 3){
            var normal = getSubscriptionType_SP(normalSub);
            var visibility = getVisibilityType_SP(visiSub);
            
            user_controller.consult(email)
            .then((user) => {

                if(normal == 1){
                    Subscription_controller.activateFreeTrial(user.idUser)
                    .then((dt) => {res.status(200).jsonp({message: "Sucesso na ativação do free trial!"})})
                    .catch((err) => {res.status(400).jsonp({error: err})})
                }else{
                    Subscription_controller.activateSubscriptionNormal_SP(user.idUser, normal)
                    .then((dt) => {

                        if(visiSub != '0'){
                    
                            Subscription_controller.activateSubscriptionVisibility_SP(user.idUser, visibility)
                            .then((dt2) => res.status(200).jsonp({message: "Sucesso na adição da subscrição!"}))
                            .catch((err) => res.status(400).jsonp({error: err}))

                        }else{
                            res.status(200).jsonp({message: "Sucesso na adição da subscrição!"})
                        }
                })
                .catch((err1) => res.status(400).jsonp({error: err1}))
                }
            })
            .catch((erro) => res.status(400).jsonp({error: erro}))
        }else{
            var normal = getSubscriptionType_CP(normalSub);
            var visibility = getVisibilityType_CP(visiSub);

            user_controller.consult(email)
            .then((user) => {

                if(normal == 1){
                    Subscription_controller.activateFreeTrial(user.idUser)
                    .then((dt) => {res.status(200).jsonp({message: "Sucesso na ativação do free trial!"})})
                    .catch((err) => {res.status(400).jsonp({error: err})})
                }else{
                    Subscription_controller.activateSubscriptionNormal_CP(user.idUser, normal)
                    .then((dt) => {

                        if(visiSub != '0'){
                    
                            Subscription_controller.activateSubscriptionVisibility_CP(user.idUser, visibility)
                            .then((dt2) => res.status(200).jsonp({message: "Sucesso na adição da subscrição!"}))
                            .catch((err) => res.status(400).jsonp({error: err}))

                        }else{
                            res.status(200).jsonp({message: "Sucesso na adição da subscrição!"})
                        }
                })
                .catch((err1) => res.status(400).jsonp({error: err1}))
                }
            })
            .catch((erro) => res.status(400).jsonp({error: erro}))
        }
    }
});



/****************************************************************************************
 *                                   PUT
 ****************************************************************************************/


// Update an subscription
router.put('/:id', function(req, res, next) {
    Subscription_controller.update(req.params.id, req.body)
        .then(data => res.status(201).jsonp({ data: data }))
        .catch(e => res.status(400).jsonp({ error: e }))
})


/****************************************************************************************
 *                                   DELETE
 ****************************************************************************************/

// Delete a subscription given is id address
router.delete('/:id', function(req, res, next) {
    Subscription_controller.remove(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(400).jsonp({ error: e }))
});

module.exports = router;