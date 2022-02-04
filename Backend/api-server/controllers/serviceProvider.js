// Controller for the serviceProvider model

const Category = require('../models/category');
const dbconfig = require('../models/Config/Database_Info');
const ServiceProvider = require('../models/serviceProvider')
const Cat_has_SP = require('../models/category_has_serviceProvider')


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

Out.get_only_categories = (id) => {
    return dbconfig.sequelize.query('CALL get_sp_only_category_info (:id)',
    {replacements: {
        id: id
    }})
}

Out.get_horarios = (id) => {
    return dbconfig.sequelize.query('CALL get_sp_horarios (:id)',
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

Out.getPerfilUser = (email) => {
    return dbconfig.sequelize.query('CALL get_service_provider_profile_v2 (:em)',
    {replacements: {
        em: email
    }})
}

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

Out.addCategorias = (arr, id, experience) => {
    var cat_ids = (typeof arr === 'undefined') ? [] : arr;
    var query = "";
    for (let i = 0; i < cat_ids.length; i++) {
        query += ('CALL insert_categorias ('+id+','+cat_ids[i]+','+experience+',0'+'); ')
    }

    return dbconfig.sequelize.query(query);
}

Out.addCategoria = (id, cat, experience, price) => {
    return dbconfig.sequelize.query('CALL insert_categorias (:id, :cat, :exp, :prc)',
        {replacements : {
            id: id,
            cat: cat, 
            exp: experience,
            prc: price
        }})
}

Out.remCategoria = (id, cat) => {
    return dbconfig.sequelize.query('CALL remove_categoria (:id, :cat)',
        {replacements : {
            id: id,
            cat: cat
        }})
}

Out.updateCategoria = (id, cat, price) => {
    return Cat_has_SP.update(
        {price: price},
        {where: { 'idCategory' : cat, 'idServiceProvider': id}}
    )
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

Out.addHorario = (id, jsonObj) => {
    return dbconfig.sequelize.query('CALL add_workSchedule_slot (:id, :slot)',
        {replacements : {
            id: id,
            slot: jsonObj
        }})
}

Out.addSlot = (id, jsonObj) => {
    return dbconfig.sequelize.query('CALL add_slot (:id, :slot)',
        {replacements : {
            id: id,
            slot: jsonObj
        }})
}

Out.remHorario = (id, jsonObj) => {
    return dbconfig.sequelize.query('CALL remove_workSchedule_slot (:id, :slot)',
        {replacements : {
            id: id,
            slot: jsonObj
        }})
}

Out.remSlot = (id, jsonObj) => {
    return dbconfig.sequelize.query('CALL remove_slot (:id, :slot)',
        {replacements : {
            id: id,
            slot: jsonObj
        }})
}

Out.getRequestedSlots = (id) => {
    return dbconfig.sequelize.query('CALL info_requested_slots (:id)',
        {replacements: {
            id: id
        }})
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
