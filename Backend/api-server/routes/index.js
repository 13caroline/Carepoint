const express = require('express');
const router = express.Router();
const axios = require('axios')
const config = require('../models/Config/API_info') 

const auth = require('../authorization/auth')

/* GET home page. */
router.get('/', function(req, res, next) {
    res.send("Empty location")
});

router.post('/login', (req,res) => {
    axios.post(config['auth-host'] + ':' + config['auth-port'] + '/users/login', req.body)
})

router.get('/auth_test', auth.checkAdminLevel, (req, res, next) => {
    res.send('Congrats!')
})

module.exports = router;
