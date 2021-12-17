const Company = require('../models/company');

var Out = module.exports;

Out.adicionarCP = (body, id) => {
    return Company.create({
        idCompany: id,
        link: body.link,
        firm: body.firm,
        nipc: body.nipc,
        endSub: body.endSub,
        idSubscription: 1
    })
}