const jwt = require('jsonwebtoken')
const user_controller = require('../controllers/user');
const bcrypt = require('bcryptjs')

var Out = module.exports;

//Obtem o email do JWT
Out.getEmailFromJWT = (token) => {
    email = null;

    jwt.verify(token, 'Project_PI', (err, payload) => {
        if(!err){
            email = payload.email;
        }else{
            console.log(err);
        }
    })

    return email;
}

//Obtem o type do JWT
Out.getTypeFromJWT = (token) => {
    type = null;

    jwt.verify(token, 'Project_PI', (err, payload) => {
        if(!err){
            type = payload.level;
        }else{
            console.log(err);
        }
    })

    return type;
}

Out.matchPasswords = (req, res, next) => {
    jwt.verify(req.body.token, 'Project_PI', (err, payload) => {
        if(!err){
            user_controller.consultar(payload.email)
            .then((user) => {
                if (bcrypt.compareSync(req.body.password, user.password)) {
                    next()
                } else {
                    res.status(400).jsonp({error: "Password Inválida"})
                }
            })
            .catch((err) => res.status(400).jsonp({ error: err }))
        }else{
            res.status(400).jsonp({ error: err })
        }
    })
}