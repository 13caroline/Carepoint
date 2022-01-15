const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs')

const multer  = require('multer')
const storage = multer.memoryStorage();
const upload = multer({ dest: 'uploads/', storage: storage })

const User = require('../controllers/user');
const ServiceProvider = require('../controllers/serviceProvider');
const Auth_ServiceProvider = require('../../auth-server/controllers/serviceProvider')
const Company = require('../controllers/company');
const auth = require('../authorization/auth');

const axios = require('axios');
const config = require('../models/Config/API_info');

/****************************************************************************************
 *                                   GET
 ****************************************************************************************/

// List all users given the query param
router.get('/', function(req, res, next) {
    // By access user's type
    if (req.query.type) {
        User.type(req.query.type)
            .then(data => res.status(200).jsonp(data))
            .catch(e => res.status(500).jsonp({ error: e }))
    }
    //By active
    else if (req.query.active) {
        User.active(req.query.active)
            .then(data => res.status(200).jsonp(data))
            .catch(e => res.status(500).jsonp({ error: e }))
    }
    // Default list
    else {
        User.list()
            .then(data => res.status(200).jsonp(data))
            .catch(e => res.status(500).jsonp({ error: e }))
    }
});


// Consult a user given his email address
router.get('/:id', function(req, res, next) {
    User.consult_id(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(500).jsonp({ error: e }))
});


// Consult a user given his email address
router.get('/email/:email', function(req, res, next) {
    User.consult(req.params.email)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(500).jsonp({ error: e }))
});

/****************************************************************************************
 *                                   POST
 ****************************************************************************************/


//Devolve o perfil do Utilizador, quer seja Consumer / Service Provider / Company
router.post('/perfil', (req, res, next) => {
    var token = req.body.token
    var email = auth.getEmailFromJWT(token)
    var type = auth.getTypeFromJWT(token)

    switch (type) {
        case 2:
            User.getPerfil(email)
            .then((data) => res.status(200).jsonp({perfil: data}))
            .catch((err) => res.status(500).jsonp({error: err}))
            break;

        case 3:
            ServiceProvider.getPerfilUser(email)
            .then((perfil) => {
                ServiceProvider.get_reviews(perfil[0].idUser)
                .then((reviews) => {
                    ServiceProvider.get_categories(perfil[0].idUser)
                    .then((categories) => {
                        res.status(200).jsonp({
                            perfil: perfil,
                            reviews: reviews,
                            categories: categories
                        })
                    })
                    .catch((err) => res.status(500).jsonp({error: err}))
                })
                .catch((err) => res.status(500).jsonp({error: err}))
            })
            .catch((err) => res.status(500).jsonp({error: err}))
            break;
        
        case 4:
            Company.getPerfilCompany(email)
            .then((data) => res.status(200).jsonp({perfil: data}))
            .catch((err) => res.status(500).jsonp({error: err}))        
            break;

        default:
            res.status(200).jsonp({message: "Tipo indefinido ou Admin."})
            break;
    }
})

/*
Rota Usada para transformar um Consumer (type 2) num Service Provider (type 3)
**/
router.post('/upgrade', auth.matchPasswords, (req,res) => {
    email = auth.getEmailFromJWT(req.body.token)
    type = auth.getTypeFromJWT(req.body.token)

    if(type == 2){
        User.consult(email)
        .then((usr) => {
            User.changeType(email)
            .then((unimportant) => {
                Auth_ServiceProvider.adicionarSP(req.body, usr.idUser)
                .then((sp) => {
                    axios.post(config['auth-host'] + ':' + config['auth-port'] + '/users/login', {    
                        email: email,                                                                   //Tenta fazer login
                        password: req.body.password
                      }).then(data => {                                                                 //Se tiver sucesso (3)
                        res.status(201).jsonp({token: data.data.token})                                 //Envia o token como resposta
                      }).catch(e => {                                                                   //Se falhar o sucesso (3)
                        res.status(500).jsonp({error: e})                                               //Retorna o Erro
                      })
                })
                .catch((err) => res.status(500).jsonp({error: err})) 
            })
            .catch((err) => res.status(500).jsonp({error: err})) 
        })
        .catch((err) => res.status(500).jsonp({error: err}))    
    }else{
        res.status(500).jsonp({message:"You are not a consumer!"})
    }
})

// Insert a new user
router.post('/', function(req, res) {

    let user = req.body;

    // Define registration date
    user.createdAt = new Date().toISOString();

    // Define number's
    user.active = 0

    User.insert(user)
        .then(data => { res.status(201).jsonp({ data: data }) })
        .catch(e => res.status(500).jsonp({ error: e }))
});

/****************************************************************************************
 *                                   PUT
 ****************************************************************************************/


// Update an user
/*
router.put('/:id', function(req, res, next) {
    User.update(req.params.id, req.body)
        .then(data => res.status(201).jsonp({ data: data }))
        .catch(e => res.status(500).jsonp({ error: e }))
})
*/

router.put('/update', auth.matchUsers, (req, res, next) => {
    switch (req.body.type){
        case '2':
            User.updateConsumer(req.body)
            .then((user) => res.status(201).jsonp(user))
            .catch((err) => res.status(500).jsonp("Error updating user: " + err))
            break;
        
        case '3':
            User.updateServiceProvider(req.body)
            .then((user) => res.status(201).jsonp(user))
            .catch((err) => res.status(500).jsonp("Error updating user: " + err))
            break;

        case '4':
            User.updateCompany(req.body)
            .then((user) => res.status(201).jsonp(user))
            .catch((err) => res.status(500).jsonp("Error updating user: " + err))
            break;

        default:
            break;
    }
})

router.put('/updatePassword', auth.validToken, (req, res, next) => {
    var email = auth.getEmailFromJWT(req.body.token)
    User.consult(email)
    .then((user) => {
        if(bcrypt.compareSync(req.body.repeatPassword1, user.password)){
            if(bcrypt.compareSync(req.body.repeatPassword2, user.password)){
                bcrypt.hash(req.body.newPassword, 10)
                .then((cryptPass) => {
                    User.updatePassword(email, cryptPass)
                    .then((user) => res.status(201).jsonp(user))
                    .catch((err) => res.status(500).jsonp("Error updating user: " + err))
                })
                .catch((err) => res.status(500).jsonp("Failure changing password: " + err))
            }else{
                res.status(400).jsonp("Repeat Password 2 errada.")
            }
        }else{
            res.status(400).jsonp("Repeat Password 1 errada.")
        }
    })
})

//auth.matchUsers,
router.put('/updatePhoto', upload.single('image'), auth.validToken,(req, res, next) => {
    var email = auth.getEmailFromJWT(req.body.token)
    User.consult(email)
    .then((usr) => {
        User.updatePhoto(usr.idUser, [req.file.buffer])
        .then((user) => res.status(201).jsonp(user))
        .catch((err) => res.status(500).jsonp("Error updating user: " + err))
    })
    .catch((err) => res.status(500).jsonp("Error updating user: " + err))
})

/****************************************************************************************
 *                                   DELETE
 ****************************************************************************************/


// Delete a user given is id address
router.delete('/:id', function(req, res, next) {
    User.remove(req.params.id)
        .then(data => res.status(200).jsonp(data))
        .catch(e => res.status(500).jsonp({ error: e }))
});

module.exports = router;