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

Out.addCategorias = (arr, id, experience) => {
    var cat_ids = (typeof arr === 'undefined') ? [] : arr;
    var query = "";
    for (let i = 0; i < cat_ids.length; i++) {
        query += ('CALL insert_categorias ('+id+','+cat_ids[i]+','+experience+'); ')
    }

    return dbconfig.sequelize.query(query);
}