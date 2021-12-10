const jwt = require('jsonwebtoken')

var Out = module.exports;

Out.checkAdminLevel = (req, res, next) => {
    jwt.verify(req.body.token,'Project_PI', (err, payload) => {
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
    jwt.verify(token, 'JWT_Test', (e,payload) => {
        if(e) console.log('Erro a verificar token: ' + e)
        else console.log('Decoded: ' + JSON.stringify(payload))
    })
}