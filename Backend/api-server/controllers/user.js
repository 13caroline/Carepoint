const User = require('../models/user')

var Out = module.exports;

//GET by email
Out.consult = (email) => {
    return User.findOne({ where: { 'email': email } });
}

//GET by id
Out.consult_id = (id) => {
    return User.findOne({ where: { 'idUser': id } });
}

//GET all users
Out.list = () => {
    return User.findAll();
}

//GET all users of a type
Out.type = (type) => {
    return User.findAll({ where: { 'type': type } });
}

//GET all users of a type
Out.active = (active) => {
    return User.findAll({ where: { 'active': active } });
}

//Creates a new user
Out.insert = (user) => {
    return User.create({
        idUser: user.idUser,
        name: user.name,
        password: user.password,
        email: user.email,
        phoneNumber: user.phoneNumber,
        sex: user.sex,
        type: user.type,
        createdAt: user.createdAt,
        lastActivity: user.createdAt,
        active: user.active
    });
}

// Update user
Out.update = (user) => {
    return User.update({ returning: true, where: { 'idUser': user.idUser } });
}

//Delete user by email
Out.remove = (email) => {
    return User.destroy({ where: { 'email': email } });
}