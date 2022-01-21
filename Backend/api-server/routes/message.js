const express = require('express');
const router = express.Router();

const auth = require('../authorization/auth')
const message_controller = require('../controllers/message');
const User = require('../controllers/user');

router.get('/:id', function(req, res, next) {
    console.log(req.body)
    console.log(req.params.id)
    message_controller.getAllId(req.params.id)
    .then(data => res.status(200).jsonp(data))
    .catch(e => res.status(500).jsonp({ error: e }))
})

router.get('/', auth.validToken, function(req, res, next) {
    token = req.body.token;
    email = auth.getEmailFromJWT(token);
    idUser2 = parseInt(req.body.idUser2)

    User.consult(email).then((user) => {
        message_controller.getAllMessagesBetween(user.idUser,idUser2)
        .then((dt) => res.status(200).jsonp(dt))
        .catch((err) => res.status(500).jsonp({error: err}))
    });

})

module.exports = router;