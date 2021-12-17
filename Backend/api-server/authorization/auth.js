const jwt = require('jsonwebtoken')

const jobOffer_controller = require('../controllers/joboffer')
const user_controller = require('../controllers/user')

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

//Verifica se token fornecido tem autorização de Admin.
Out.checkAdminLevel = (req, res, next) => {
    jwt.verify(req.body.token, 'Project_PI', (err, payload) => {
        if(!err){
            level = payload.level;
            if(level == 1){
                next()
            }else{
                res.status(401).jsonp({message: "No permission."})
            }
        }else{
            res.status(500).jsonp({ error: err })
        }
    })
}

//Verifica se token fornecido tem autorização de Admin ou Consumer ou Service Provider.
Out.checkAdminOrUserOrSP = (req, res, next) => {
    jwt.verify(req.body.token, 'Project_PI', (err,payload) => {
        if(!err){
            level = payload.level;
            if(level == 1 || level == 2 || level == 3){
                next()
            }else{
                res.status(401).jsonp({message: "No permission."})
            }
        }else{
            res.status(500).jsonp({ error: err })
        }
    })
}

//Verifica se token fornecido tem autorização de consumer.
Out.checkUserLevel = (req, res, next) => {
    jwt.verify(req.body.token, 'Project_PI', (err,payload) => {
        if(!err){
            level = payload.level;
            if(level == 1 || level == 3){
                next()
            }else{
                res.status(401).jsonp({message: "No permission."})
            }
        }else{
            res.status(500).jsonp({ error: err })
        }
    })
}

//Verifica se token fornecido tem autorização de company.
Out.checkCompanyLevel = (req, res, next) => {
    jwt.verify(req.body.token, 'Project_PI', (err,payload) => {
        if(!err){
            level = payload.level;
            if(level == 1 || level == 4){
                next()
            }else{
                res.status(401).jsonp({message: "No permission."})
            }
        }else{
            res.status(500).jsonp({ error: err })
        }
    })
}

//Verifica se token fornecido tem autorização de service provider.
Out.checkServiceProviderLevel = (req, res, next) => {
    jwt.verify(req.body.token, 'Project_PI', (err,payload) => {
        if(!err){
            level = payload.level;
            if(level == 1 || level == 2){
                next()
            }else{
                res.status(401).jsonp({message: "No permission."})
            }
        }else{
            res.status(500).jsonp({ error: err })
        }
    })
}

Out.checkOwnershipJobOffer = (req, res, next) => {
    jwt.verify(req.body.token, 'Project_PI', (err, payload) => {
        if(!err){
            level = payload.level;
            if(level == 2 || 3){
                jobOffer_controller.consultar_id(req.body.id_job_offer)
                .then((job) => {
                    user_controller.consult(payload.email)
                    .then((user) => {
                        if(user.idUser == job.idUser){
                            next()
                        }else{
                            res.status(401).jsonp({message: "No permission."})
                        }
                    })
                    .catch((error) => res.status(401).jsonp({message: "No permission: " + error}))
                })
                .catch((error) => res.status(401).jsonp({message: "No permission: " + error}))

            }else if(level == 1){
                next()
            }else{
                res.status(401).jsonp({message: "No permission."})
            }
        }else{
            res.status(500).jsonp({ error: err })
        }
    })
}