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
        averageRating: 0
    })
}

Out.addCategorias = (arr, id) => {
    var cat_ids = (typeof arr === 'undefined') ? [] : arr;
    return dbconfig.sequelize.query('CALL insert_categorias (:idm :cats)',
        { replacements: {
            id: id,
            cats: cat_ids
        }})
}