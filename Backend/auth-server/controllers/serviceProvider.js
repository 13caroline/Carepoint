const User = require('../models/user')
const ServiceProvider = require('../models/serviceProvider');
const dbconfig = require('../models/Config/Database_Info')

var Out = module.exports;

Out.adicionarSP = (body, id) => {
    return ServiceProvider.create({
        idSP: id,
        description: body.description,
        dateOfBirth: body.dateOfBirth,
        endSub: body.endSub,
        distance: body.distance,
        qualifications: body.qualifications,
        idSubscription: 1,
        averageRating: 0,
        solidarity: body.solidarity
    })
}

Out.adicionarSP_transaction = (body) => {
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
        }, {transaction: t}).then((user) => {
            return ServiceProvider.create({
                idSP: user.idUser,
                description: body.description,
                dateOfBirth: body.dateOfBirth,
                endSub: body.endSub,
                distance: body.distance,
                qualifications: body.qualifications,
                idSubscription: 1,
                averageRating: 0,
                solidarity: body.solidarity
            }, {transaction: t}).then(() => {
                t.commit();
                return this.addCategorias(body.categorias, user.idUser, body.experience)
            }).catch((err) => {          
                console.log(err);     
                return t.rollback();
            })
        })
    })
}

Out.addCategorias = (arr, id, experience) => {
    var cat_ids = (typeof arr === 'undefined') ? [] : arr;
    var query = "";
    for (let i = 0; i < cat_ids.length; i++) {
        query += ('CALL insert_categorias ('+id+','+cat_ids[i]+','+experience+',0'+'); ')
    }

    return dbconfig.sequelize.query(query);
}