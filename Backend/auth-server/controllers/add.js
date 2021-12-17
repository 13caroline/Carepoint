const Add = require('../models/add')

var Out = module.exports;

Out.adicionarAdd = (description, id) => {
    return Add.create({
        description: description,
        idCompany: id
    })
}