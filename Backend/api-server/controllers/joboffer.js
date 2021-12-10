const jobOffer_model = require('../models/joboffer')
const user_controller = require('../controllers/user')
const auth = require('../authorization/auth')

Out = module.exports;

Out.newJob = ((body) => {

    email = auth.getEmailFromJWT(body.token);

    user_controller.consultar(email).then((user) => {
        if (user) {
            jobOffer_model.create({
                description: body.description,
                beginDate: new Date(), //body.beginDate,
                postDate: new Date(),
                price: body.price,
                done: 0,
                endDate: new Date(), //body.endDate,
                idUser: user.idUser,
                idCategory: body.idCategory,
                idLocation: body.idLocation,
            })
            return jobOffer_model;

        } else {
            return null;
        }
    }).catch((e) => {
        console.log(e);
        return null;
    })
})