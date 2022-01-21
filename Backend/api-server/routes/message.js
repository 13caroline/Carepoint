const express = require('express');
const router = express.Router();

const auth = require('../authorization/auth')
const message_controller = require('../controllers/message');
const User = require('../controllers/user');

router.post('/seeUsers', function(req, res, next) {
    token = req.body.token;
    email = auth.getEmailFromJWT(token);

    User.consult(email).then((user) => {
        message_controller.getAllId(user.idUser)
        .then((dt) => res.status(200).jsonp(dt))
        .catch((err) => res.status(500).jsonp({error: err}))
    })
})

router.post('/addMessage', auth.validToken, function(req, res, next) {
    token = req.body.token;
    email = auth.getEmailFromJWT(token);
    idUser2 = parseInt(req.body.idUser2);
    console.log(req.body.content);

    User.consult(email).then((user) => {
        message_controller.addMessage(req.body.content,user.idUser,idUser2)
        .then((dt) => res.status(200).jsonp(dt))
        .catch((err) => res.status(500).jsonp({error: err}))
    });
})

router.post('/seeMessages', auth.validToken, function(req, res, next) {
    token = req.body.token;
    email = auth.getEmailFromJWT(token);
    idUser2 = parseInt(req.body.idUser2);

    User.consult(email).then((user) => {
        message_controller.getAllMessagesBetween(user.idUser,idUser2)
        .then((dt) => res.status(200).jsonp(dt))
        .catch((err) => res.status(500).jsonp({error: err}))
    });
})

module.exports = router;