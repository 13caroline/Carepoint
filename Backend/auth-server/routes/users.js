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

//Type :: 1 = admin -- 2 = consumer -- 3 = SP -- 4 = company
router.post('/register', (req, res) => {
  User.adicionarUser(req.body)                                                                //Tenta inserir um user
  .then((user) => {                                                                           //Se tiver sucesso, procede a fazer login, ou inserir 
    switch (req.body.type){                                                                   //informação adicional necessária
      case '2':
        axios.post(config['auth-host'] + ':' + config['auth-port'] + '/users/login', {
          email: req.body.email,                                                              //Tenta fazer login
          password: req.body.password                               
        }).then(data => {                                                                     //Se tiver sucesso (1)
          res.status(201).jsonp({token: data.data.token})                                     //Envia o token como resposta
        }).catch(e => {                                                                       //Se falhar o sucesso (1)
          res.status(500).jsonp({error: e})                                                   //Retorna o Erro
        })
        break;

      case '3':
        console.log(3)
        ServiceProvider.adicionarSP(req.body, user.idUser)                                    //Adiciona o SP
        .then((SP) => {                                                                       //Se tiver sucesso (1)
          ServiceProvider.addCategorias(req.body.categorias, user.idUser, req.body.experience)
          .then((SPc) => {
            axios.post(config['auth-host'] + ':' + config['auth-port'] + '/users/login', {      
              email: req.body.email,                                                            //Tenta fazer login
              password: req.body.password
            }).then(data => {                                                                   //Se tiver sucesso (2)
              res.status(201).jsonp({token: data.data.token})                                   //Envia o token come resposta
            }).catch(e => {                                                                     //Se falhar o sucesso (2)
              res.status(500).jsonp({error: e})                                                 //Retorna o erro
            })  
          })
          .catch((err) => res.status(401).jsonp({error:err}))
        })
        .catch((err) => res.status(401).jsonp({error:err}))                                   //Se falhar o sucesso (1), retorna o erro
        break;

      case '4':
        console.log(4)
        Company.adicionarCP(req.body, user.idUser)                                            //Adiciona Company
        .then((CP) => {                                                                       //Se tiver sucesso (1)
          Ad.adicionarAdd(req.body.description, CP.idCompany)                                 //Adiciona a Ad da company
          .then((info) => {                                                                   //Se tiver sucesso (2)
            axios.post(config['auth-host'] + ':' + config['auth-port'] + '/users/login', {    
              email: req.body.email,                                                          //Tenta fazer login
              password: req.body.password
            }).then(data => {                                                                 //Se tiver sucesso (3)
              res.status(201).jsonp({token: data.data.token})                                 //Envia o token como resposta
            }).catch(e => {                                                                   //Se falhar o sucesso (3)
              res.status(500).jsonp({error: e})                                               //Retorna o Erro
            })
          })
          .catch((err) => res.status(401).jsonp({error:err}))                                 //Falhar o sucesso (2), retorna erro
        })
        .catch((err) => res.status(401).jsonp({error:err}))                                   //Falhar o sucesso (1), retorna erro
        break;
        
      default:
        break;
    }
  })
  .catch((err) => res.status(401).jsonp({error:err}))                                         //Se falhar a inserção de um novo user, retorna o erro
})

//Type :: 1 = admin -- 2 = consumer -- 3 = SP -- 4 = company 
router.post('/login', passport.authenticate('local'), (req, res, next) => {
  jwt.sign({ email: req.user.email, level: req.user.type }, 'Project_PI', { expiresIn: '12h' }, (e, token) => {
    if (e) {
      res.status(500).jsonp({ error: "Error within token generation: " + e })
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
    res.status(500).jsonp({error: "No JWT Token Provided!!!!"});
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
