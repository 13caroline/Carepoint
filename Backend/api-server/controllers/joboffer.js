const jobOffer_model = require('../models/joboffer')
const dbconfig = require('../models/Config/Database_Info')

Out = module.exports;

Out.consultar_id = ((job_id) => {
    return jobOffer_model.findOne({where: { 'idJobOffer' : job_id}});
})

Out.newJob = ((body, id_user) => {
    return jobOffer_model.create({
        description: body.description,
        beginDate: body.beginDate,
        postDate: new Date(),
        price: body.price,
        done: 0,
        endDate: body.endDate,
        idUser: id_user,
        idCategory: body.idCategory,
        idLocation: body.idLocation
    })
})

Out.getOwnJobs = (email) => {
    return dbconfig.sequelize.query('CALL get_consumers_joboffers (:em)',
        {replacements: {
            em: email
        }})
}

Out.get_JobOffers = (cat_id, id_loc, price, limit, offset) => {
    return dbconfig.sequelize.query('CALL get_joboffer (:idC, :idL, :prc, :lm, :off)',
        {replacements: {
            idC: cat_id,
            idL: id_loc,
            prc: price,
            lm: limit,
            off: offset
        }})
}

Out.concludeJob = (job_id) => {
    return jobOffer_model.update(
        {done: 1},
        {where: { 'idJobOffer' : job_id}}
    )
}