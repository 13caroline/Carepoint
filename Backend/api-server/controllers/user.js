const User = require('../models/user')

var Out = module.exports;

//GET
Out.consultar = (email) => {
    return User.findOne({where:{'email': email}});
}

Out.consultar_id = (id) => {
    return User.findOne({where:{'idUser': id}});
}