const jobOffer_model = require('../models/joboffer')
const user_controller = require('../controllers/user')
const auth = require('../authorization/auth')

Out = module.exports;

Out.newJob = ((body) => {

    email = auth.getEmailFromJWT(body.token);

    user_controller.consult(email)
    .then((user) => {
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
            return "err";
        }
    }).catch((e) => {
        console.log(e);
        return "err";
    })
})

// ****************************************************************************************************************************************** //
// ****************************************************************************************************************************************** //
//                                                           3 Parameters                                                                     //
// ****************************************************************************************************************************************** //
// ****************************************************************************************************************************************** //

/*
* params: Categoria, Location,  Price
* Usado para os casos: 111, 110
*
* returns: Todos as Job Offers que se encontram dentro dessas limitações
*/
Out.get_allParameters = (var1, var2, var3, limit, offset) => {
    return dbconfig.sequelize.query('CALL get_job_offer_all_parameters (:arg1, :arg2, :arg3, :lm, :off)',
        {replacements: {
            arg1: var1,
            arg2: var2,
            arg3: var3,
            lm: limit,
            off: offset
            }})
}

// ****************************************************************************************************************************************** //
// ****************************************************************************************************************************************** //
//                                                           2 Parameters                                                                     //
// ****************************************************************************************************************************************** //
// ****************************************************************************************************************************************** //

/*
* params: Categoria,  Price
* Usado para os casos: 101
*
* returns: Todos as Job Offers que se encontram dentro dessas limitações
*/
Out.get_categoryANDprice = (var1, var2, limit, offset) => {
    return dbconfig.sequelize.query('CALL get_job_offer_without_location (:arg1, :arg2, :lm, :off)',
        {replacements: {
            arg1: var1,
            arg2: var2,
            lm: limit,
            off: offset
            }})
}

/*
* params: Location,  Price
* Usado para os casos: 011
*
* returns: Todos as Job Offers que se encontram dentro dessas limitações
*/
Out.get_locationANDprice = (var1, var2, limit, offset) => {
    return dbconfig.sequelize.query('CALL get_job_offer_without_category (:arg1, :arg2, :lm, :off)',
        {replacements: {
            arg1: var1,
            arg2: var2,
            lm: limit,
            off: offset
            }})
}

// ****************************************************************************************************************************************** //
// ****************************************************************************************************************************************** //
//                                                           1 Parameter                                                                      //
// ****************************************************************************************************************************************** //
// ****************************************************************************************************************************************** //

/*
* params: Category
* Usado para os casos: 100
*
* returns: Todos as Job Offers que se encontram dentro dessas limitações
*/
Out.get_category = (var1, limit, offset) => {
    return dbconfig.sequelize.query('CALL get_job_offer_category (:arg1, :lm, :off)',
        {replacements: {
            arg1: var1,
            lm: limit,
            off: offset
            }})
}

/*
* params: Location
* Usado para os casos: 010
*
* returns: Todos as Job Offers que se encontram dentro dessas limitações
*/
Out.get_category = (var1, limit, offset) => {
    return dbconfig.sequelize.query('CALL get_job_offer_location (:arg1, :lm, :off)',
        {replacements: {
            arg1: var1,
            lm: limit,
            off: offset
            }})
}

/*
* params: Price
* Usado para os casos: 001
*
* returns: Todos as Job Offers que se encontram dentro dessas limitações
*/
Out.get_price = (var1, limit, offset) => {
    return dbconfig.sequelize.query('CALL get_job_offer_price (:arg1, :lm, :off)',
        {replacements: {
            arg1: var1,
            lm: limit,
            off: offset
            }})
}

// ****************************************************************************************************************************************** //
// ****************************************************************************************************************************************** //
//                                                           0 Parameters                                                                     //
// ****************************************************************************************************************************************** //
// ****************************************************************************************************************************************** //

/*
* params: Just the standard limit and offset
* Usado para os casos: 000
*
* returns: Todos as Job Offers que se encontram dentro dessas limitações
*/
Out.get_price = (limit, offset) => {
    return dbconfig.sequelize.query('CALL get_job_offer (:lm, :off)',
        {replacements: {
            lm: limit,
            off: offset
            }})
}