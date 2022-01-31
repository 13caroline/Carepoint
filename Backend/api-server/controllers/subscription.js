// Controller for the subscription model

const dbconfig = require('../models/Config/Database_Info')
const Subscription = require('../models/subscription')
const ServiceProvider = require('../models/serviceProvider')
const Company = require('../models/company')

var Out = module.exports;

//GET by type
Out.type = (type) => {
    return Subscription.findAll({ where: { 'type': type } });
}


//GET by value
Out.value = (value) => {
    return Subscription.findAll({ where: { 'value': value } });
}


//GET by duration
Out.duration = (duration) => {
    return Subscription.findAll({ where: { 'duration': duration } });
}


//GET by id
Out.consult_id = (id) => {
    return Subscription.findOne({ where: { 'idSubscription': id } });
}

//GET all Subscriptions
Out.list = () => {
    return Subscription.findAll();
}

//Creates a new Subscription
Out.insert = (subscription) => {
    return Subscription.create({
        idSubscription: subscription.idSubscription,
        type: subscription.type,
        value: subscription.value,
        duration: subscription.duration
    });
}

// Update Subscription
Out.update = (id, subscription) => {
    return Subscription.update({
        type: subscription.type,
        value: subscription.value,
        duration: subscription.duration
    }, {
        where: { 'idSubscription': id },
        returning: true,
    });
}

//Delete Subscription by id
Out.remove = (id) => {
    return Subscription.destroy({ where: { 'idSubscription': id } });
}

Out.activateSubscriptionNormal_SP = (idUser, normal) => {
    return dbconfig.sequelize.query('CALL update_serviceProvider_endSub (:idSP, :tipo_sub)',
        {replacements: {
            idSP: idUser,
            tipo_sub: normal,
        }});
}

Out.activateSubscriptionVisibility_SP = (idUser, visibility) => {
    return dbconfig.sequelize.query('CALL update_serviceProvider_vip (:idSP, :tipo)',
        {replacements: {
            idSP: idUser,
            tipo: visibility,
        }});
}

Out.activateSubscriptionNormal_CP = (idUser, normal) => {
    return dbconfig.sequelize.query('CALL update_company_endSub (:idSP, :tipo_sub)',
        {replacements: {
            idSP: idUser,
            tipo_sub: normal,
        }});
}

Out.activateSubscriptionVisibility_CP = (idUser, visibility) => {
    return dbconfig.sequelize.query('CALL update_company_vip (:idSP, :tipo)',
        {replacements: {
            idSP: idUser,
            tipo: visibility,
        }});
}

Out.terminateSubSP = (id) => {
    return ServiceProvider.update(
        {idSubscription: 1,
         endSub: null,
         endSubVip: null},
        {where: { 'idSP' : id}}
    )
}

Out.terminateSubCP = (id) => {
    return Company.update(
        {idSubscription: 1,
         endSub: null,
         endSubVip: null},
        {where: { 'idSP' : id}}
    )
}