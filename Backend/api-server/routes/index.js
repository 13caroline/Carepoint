var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
    res.send("Empty location")
});

router.post('/login', (req,res,next) => {
    res.send("Login area")
})

module.exports = router;
