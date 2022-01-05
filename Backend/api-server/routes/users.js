const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs')

const multer  = require('multer')
const storage = multer.memoryStorage();
const upload = multer({ dest: 'uploads/', storage: storage })

const Blob = require('node-blob');

const User = require('../controllers/user');
const auth = require('../authorization/auth');


/****************************************************************************************
 *                                   GET
 ****************************************************************************************/
router.post('/perfil', (req, res, next) => {
    var token = req.body.token
    var email = auth.getEmailFromJWT(token)
    User.getPerfil(email)
    .then((data) => {console.log(data); res.status(200).jsonp({perfil: data})})
    .catch((err) => res.status(500).jsonp({error: err}))
})

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
        
        case '3':
            User.updateServiceProvider(req.body)
            .then((user) => res.status(201).jsonp(user))
            .catch((err) => res.status(500).jsonp("Error updating user: " + err))

        case '4':
            User.updateCompany(req.body)
            .then((user) => res.status(201).jsonp(user))
            .catch((err) => res.status(500).jsonp("Error updating user: " + err))

        default:
            break;
    }
})

router.put('/updatePassword', auth.matchUsers, (req, res, next) => {
    User.consult_id(req.body.idUser)
    .then((user) => {
        if(bcrypt.compareSync(req.body.repeatPassword1, user.password)){
            if(bcrypt.compareSync(req.body.repeatPassword2, user.password)){
                bcrypt.hash(req.body.newPassword, 10)
                .then((cryptPass) => {
                    User.updatePassword(req.body.idUser, cryptPass)
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
router.put('/updatePhoto', upload.single('image'), (req, res, next) => {
    User.updatePhoto(req.body.idUser, [req.file.buffer])
    .then((user) => res.status(201).jsonp(user))
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