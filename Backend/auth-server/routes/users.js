const express = require('express');
const router = express.Router();

const jwt = require('jsonwebtoken');
const passport = require('passport');
const axios = require('axios');

const config = require('../models/Config/API_info');

const ServiceProvider = require('../controllers/serviceProvider');
const User = require('../controllers/user');
const Company = require('../controllers/company');
const Ad = require('../controllers/Add');

const auth = require('../authorization/auth');


/* GET users listing. */
router.get('/', function (req, res, next) {
  res.send('respond with a resource');
});

/*
Rota Usada para transformar um Consumer (type 2) num Service Provider (type 3)
**/
router.post('/upgrade', auth.matchPasswords, (req,res) => {
  email = auth.getEmailFromJWT(req.body.token)
  type = auth.getTypeFromJWT(req.body.token)

  if(type == 2){
      User.consultar(email)
      .then((usr) => {
          User.changeType(email)
          .then((unimportant) => {
              ServiceProvider.adicionarSP(req.body, usr.idUser)
              .then((sp) => {
                  ServiceProvider.addCategorias(req.body.categories, usr.idUser, req.body.experience)
                  .then((sp2) => {
                      axios.post(config['auth-host'] + ':' + config['auth-port'] + '/users/login', {    
                          email: email,                                                                   //Tenta fazer login
                          password: req.body.password
                        }).then(data => {                                                                 //Se tiver sucesso (3)
                          res.status(201).jsonp({token: data.data.token})                                 //Envia o token como resposta
                        }).catch(e => {                                                                   //Se falhar o sucesso (3)
                          res.status(400).jsonp({error: e})                                               //Retorna o Erro
                        })
                  })
                  .catch((err) => res.status(400).jsonp({error: err})) 
              })
              .catch((err) => res.status(400).jsonp({error: err})) 
          })
          .catch((err) => res.status(400).jsonp({error: err})) 
      })
      .catch((err) => res.status(400).jsonp({error: err}))    
  }else{
      res.status(400).jsonp({message:"You already are a Service Provider or Company!"})
  }
})

router.post('/register', (req, res) => {
  switch (req.body.type){
    case '2':
      User.adicionarUser(req.body)
      .then((user) => {
        axios.post(config['auth-host'] + ':' + config['auth-port'] + '/users/login', {
          email: req.body.email,                                                             
          password: req.body.password                               
        }).then(data => {                                                                     
          res.status(201).jsonp({token: data.data.token})                                     
        }).catch(e => {                                                                       
          res.status(400).jsonp({error: e})                                                   
        })
      })
      .catch((err) => {res.status(400).jsonp({error: err})})
      break;

    case '3':
      ServiceProvider.adicionarSP_transaction(req.body)
      .then(() => {
        axios.post(config['auth-host'] + ':' + config['auth-port'] + '/users/login', {
          email: req.body.email,                                                             
          password: req.body.password                               
        }).then(data => {                                                                     
          res.status(201).jsonp({token: data.data.token})                                     
        }).catch(e => {                                                                       
          res.status(400).jsonp({error: e})                                                   
        })
      })
      .catch((err) => {res.status(400).jsonp({error: err})})
      break;
    
    case '4':
      Company.adicionarCP_transaction(req.body)
      .then(() => {
        axios.post(config['auth-host'] + ':' + config['auth-port'] + '/users/login', {
          email: req.body.email,                                                             
          password: req.body.password                               
        }).then(data => {                                                                     
          res.status(201).jsonp({token: data.data.token})                                     
        }).catch(e => {                                                                       
          res.status(400).jsonp({error: e})                                                   
        })
      })
      .catch((err) => {res.status(400).jsonp({error: err})})
      break;
    
    default:
        break;
  }
})

//Type :: 1 = admin -- 2 = consumer -- 3 = SP -- 4 = company 
router.post('/login', passport.authenticate('local'), (req, res, next) => {
  jwt.sign({ email: req.user.email, level: req.user.type }, 'Project_PI', { expiresIn: '12h' }, (e, token) => {
    if (e) {
      res.status(400).jsonp({ error: "Error within token generation: " + e })
    } else {
      User.activate(req.user.email)
      .then((dt) => {
        res.status(200).jsonp({ token: token,
                                type: req.user.type })
      })
      .catch((er) => {
        res.status(200).jsonp({ token: token,
                                type: req.user.type })
      })
    }
  })
})

router.post('/logout', (req, res) => {

  token = req.body.token
  if(token === undefined){
    res.status(400).jsonp({error: "No JWT Token Provided!!!!"});
  }
  else{
    email = auth.getEmailFromJWT(token)

    req.logOut()
    delete req.session;

    User.deactivate(email)
    .then((dt) => res.status(200).jsonp("Logged Out Successfully")) 
    .catch((er) => res.status(200).jsonp("Logged Out Successfully"))
  }
})

module.exports = router;
