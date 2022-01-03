// Controller for the serviceProvider model

const dbconfig = require('../models/Config/Database_Info');
const ServiceProvider = require('../models/serviceProvider')


var Out = module.exports;

//GET Service Provider by id
Out.consult_id = (id) => {
    return ServiceProvider.findOne({ where: { 'idSP': id } });
}

//GET all Service Providers
Out.list = () => {
    return ServiceProvider.findAll();
}

Out.sp_profile = (id) => {
    return dbconfig.sequelize.query('CALL get_service_provider_profile (:id)',
    {replacements: {
        id: id
    }})
}

Out.get_reviews = (id) => {
    return dbconfig.sequelize.query('CALL get_reviews (:id)',
    {replacements: {
        id: id
    }})
}

Out.get_categories = (id) => {
    return dbconfig.sequelize.query('CALL get_sp_category_info (:id)',
    {replacements: {
        id: id
    }})
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

// Update a ServiceProvider
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

//Delete a ServiceProvider by id
Out.remove = (id) => {
    return ServiceProvider.destroy({ where: { 'idSP': id } });
}