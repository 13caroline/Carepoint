// Controller for the review model

const Review = require('../models/review')
const dbconfig = require('../models/Config/Database_Info')

var Out = module.exports;

//GET review by id
Out.consult_id = (id) => {
    return Review.findOne({ where: { 'idReview': id } });
}

//GET all reviews
Out.list = () => {
    return Review.findAll();
}

//Creates a new Review
Out.insert = (review) => {
    return Review.create({
        idReview: review.idReview,
        description: review.description,
        rating: review.rating,
        postDate: review.postDate,
        idGive: review.idGive,
        idReceive: review.idReceive,

    });
}

// Update a Review
Out.update = (body) => {
    return Review.update(
        {description: body.description, rating: body.rating},
        {where: { 'idReview' : body.idReview}}
    )
}

Out.addNewReview = (description, rating, give, receive) => {
    return Review.create({
        description: description,
        rating: rating,
        postDate: new Date(),
        idGive: give,
        idReceive: receive,
    })
}

Out.atualizarRating = (rev) => {
    return dbconfig.sequelize.query('CALL update_averageRating (:id)',
    {replacements: {
        id: rev
    }})
}

//Delete a Review by id
Out.remove = (id) => {
    return Review.destroy({ where: { 'idReview': id } });
}