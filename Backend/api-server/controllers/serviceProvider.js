// Controller for the serviceProvider model

const ServiceProvider = require('../models/serviceProvider')


var Out = module.exports;

//GET by id
Out.consult_id = (id) => {
    return ServiceProvider.findOne({ where: { 'idSP': id } });
}

//GET all Service Providers
Out.list = () => {
    return ServiceProvider.findAll();
}

//Creates a new ServiceProvider
Out.insert = (serviceProvider) => {
    return ServiceProvider.create({
        idSP: serviceProvider.idSP,
        description: serviceProvider.description,
        dateOfBirth: serviceProvider.dateOfBirth,
        endSub: serviceProvider.endSub,
        distance: serviceProvider.distance,
        qualifications: serviceProvider.qualifications,
        idUser: serviceProvider.idUser,
        idSubscription: serviceProvider.idSubscription
    });
}

// Update ServiceProvider
Out.update = (id, serviceProvider) => {
    return ServiceProvider.update({
        description: serviceProvider.description,
        dateOfBirth: serviceProvider.dateOfBirth,
        endSub: serviceProvider.endSub,
        distance: serviceProvider.distance,
        qualifications: serviceProvider.qualifications,
        idSubscription: serviceProvider.idSubscription
    }, {
        where: { 'idSP': id },
        returning: true,
    });
}

//Delete ServiceProvider by id
Out.remove = (id) => {
    return ServiceProvider.destroy({ where: { 'idSP': id } });
}