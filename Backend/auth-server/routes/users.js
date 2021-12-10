const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const passport = require('passport');
const axios = require('axios');
const config = require('../models/Config/API_info')
const User = require('../controllers/user');

/* GET users listing. */
router.get('/', function (req, res, next) {
  res.send('respond with a resource');
});

router.post('/register', (req, res) => {
  user = User.newUser(req.body.name, req.body.email, req.body.password)
  if (user) {
    axios.post(config['auth-host'] + ':' + config['auth-port'] + '/users/login', {
      email: req.body.email,
      password: req.body.password
    }).then(data => {
      res.status(201).jsonp({token: data.data.token})
    }).catch(e => {
      res.status(500).jsonp({error: e})
    })
  } else {
    res.status(500).jsonp({ error: "Failed creation of user" })
  }
})

//Type :: 1 = admin -- 2 = consumer -- 3 = SP -- 4 = company 
router.post('/login', passport.authenticate('local'), (req, res, next) => {
  jwt.sign({ email: req.user.email, level: req.user.type }, 'Project_PI', { expiresIn: '1h' }, (e, token) => {
    if (e) {
      res.status(500).jsonp({ error: "Error within token generation: " + e })
    } else {
      res.status(200).jsonp({ token: token })
    }
  })
})

router.get('/logout', (req, res) => {
  req.logOut()

  delete req.session;

  //res.status(200).clearCookie('connect.sid', {path: '/'}).json({status: "Success"});
})

module.exports = router;
