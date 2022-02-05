var express = require('express');
var router = express.Router();
const email = require('../controllers/email')

router.post('/', function(req, res, next) {
    email.sendMail(req.body.email, req.body.assunto, req.body.message)
    .then(() => res.status(200).jsonp("success"))
    .catch((err) => res.status(400).jsonp({error: err}))
});

module.exports = router;