const ServiceProvider = require('../models/serviceProvider');

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