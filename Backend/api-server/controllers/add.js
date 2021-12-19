// Controller for the add model

const Add = require('../models/add')


var Out = module.exports;

//GET by id
Out.consult_id = (id) => {
    return Add.findOne({ where: { 'idAdd': id } });
}

//GET all adds
Out.list = () => {
    return Add.findAll();
}

//Creates a new Add
Out.insert = (add) => {
    return Add.create({
        idAdd: add.idAdd,
        description: add.description,
        idCompany: add.idCompany
    });
}

// Update an Add
Out.update = (id, add) => {
    return Add.update({
        description: add.description,
        idCompany: add.idCompany
    }, {
        where: { 'idAdd': id },
        returning: true,
    });
}

//Delete an Add by id
Out.remove = (id) => {
    return Add.destroy({ where: { 'idAdd': id } });
}