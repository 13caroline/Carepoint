// Controller for the company model

const Company = require('../models/company')

var Out = module.exports;

//GET Company by nipc
Out.consult_nipc = (nipc) => {
    return Company.findOne({ where: { 'nipc': nipc } });
}

//GET Company by id
Out.consult_id = (id) => {
    return Company.findOne({ where: { 'idCompany': id } });
}

//GET all Camponies
Out.list = () => {
    return Company.findAll();
}

//Creates a new Company
//Quando se insere uma company não deve ainda haver adds, certo?
Out.insert = (company) => {
    return Company.create({
        idCompany: company.idCompany,
        link: company.link,
        firm: company.firm,
        nipc: company.nipc,
        endSub: company.endSub,
        idUser: company.idUser,
        idSubscription: company.idSubscription
    });
}

// Update Company
Out.update = (id, company) => {
    return Company.update({
        firm: company.firm,
        link: company.link,
        nipc: company.nipc,
        endSub: company.endSub,
        idSubscription: company.idSubscription
    }, {
        where: { 'idCompany': id },
        returning: true,
    });
}

//Delete Company by id
Out.remove = (id) => {
    return Company.destroy({ where: { 'idCompany': id } });
}