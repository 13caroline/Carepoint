// Controller for the company model


const Company = require('../models/company')

var Out = module.exports;

//GET by name
Out.consult = (firm) => {
    return Company.findOne({ where: { 'firm': firm } });
}

//GET by id
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
        idUser: company.idUser
    });
}

// Update Company
Out.update = (id, company) => {
    //TODO: falta update dos adds e o nipc não me parece que deva ser possível alterar
    return Company.update({ firm: company.firm, link: company.link, endSub: company.endSub }, {
        where: { 'idCompany': id },
        returning: true,
    });
}

//Delete Company by id
Out.remove = (id) => {
    return Company.destroy({ where: { 'idCompany': id } });
}