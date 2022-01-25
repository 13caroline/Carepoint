const Message = require('../models/message')
const dbconfig = require('../models/Config/Database_Info')

var Out = module.exports;

//POST all users talked with by user ID
Out.getAllId = (idUser) => {
    return dbconfig.sequelize.query('CALL user_messages_with (:in_idUser)',
    {replacements: {
        in_idUser: idUser
    }});
}

//POST all messages between two users

Out.getAllMessagesBetween = (idUser1,idUser2) => {
    return dbconfig.sequelize.query('CALL all_messages_with (:in_idUser1, :in_idUser2)',
    {replacements: {
        in_idUser1: idUser1,
        in_idUser2: idUser2
    }});
}

//PUT add a new message

Out.addMessage = (content,idUser1,idUser2) => {
    return dbconfig.sequelize.query('CALL createMessage (:in_content, :in_idGive, :in_idReceive)',
    {replacements: {
        in_content: content,
        in_idGive: idUser1,
        in_idReceive: idUser2
    }});
}