// Controller for the subscription model


const Subscription = require('../models/subscription')

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