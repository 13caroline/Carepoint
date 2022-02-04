const dbconfig = require('../models/Config/Database_Info')
const User = require('../models/user')
const Company = require('../models/company');
const Add = require('../models/add')

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

Out.adicionarCP_transaction = (body) => {
    return dbconfig.sequelize.transaction().then( (t) => {
        return User.create({
            name: body.name,
            password: body.password,
            email: body.email,
            phoneNumber: body.phoneNumber,
            sex: body.sex,
            type: body.type,
            createdAt: new Date(),
            lastActivity: new Date(),
            active: 0,
            idLocation: body.location
        }, {transaction: t}).then( (user) => {
            return Company.create({
                idCompany: user.idUser,
                link: body.link,
                firm: body.firm,
                nipc: body.nipc,
                endSub: body.endSub,
                idSubscription: 1
            }, {transaction: t}).then( (company) => {
                return Add.create({
                    description: body.description,
                    idCompany: user.idUser
                }, {transaction: t}).then(() => {                   
                    return t.commit();
                }).catch((err) => {  
                    console.log(err);             
                    return t.rollback();
                })
            })    
        })
    })
}