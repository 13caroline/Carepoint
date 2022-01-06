// Controller for the review model

const Review = require('../models/review')


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
Out.update = (id, review) => {
    return Review.update({
        description: review.description,
        rating: review.rating,
        postDate: review.postDate,
        idGive: review.idGive,
        idReceive: review.idReceive,
    }, {
        where: { 'idReview': id },
        returning: true,
    });
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

//Delete a Review by id
Out.remove = (id) => {
    return Review.destroy({ where: { 'idReview': id } });
}