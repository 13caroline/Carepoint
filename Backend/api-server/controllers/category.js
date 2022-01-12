// Controller for the category model


const Category = require('../models/category');
const dbconfig = require('../models/Config/Database_Info');

var Out = module.exports;

//GET by name
Out.consult = (name) => {
    return Category.findOne({ where: { 'name': name } });
}

//GET by id
Out.consult_id = (id) => {
    return Category.findOne({ where: { 'idCategory': id } });
}

//GET all Categories
Out.list = () => {
    return dbconfig.sequelize.query('SELECT * FROM pi.get_categories');
}

//Creates a new Category
Out.insert = (category) => {
    return Category.create({
        idCategory: category.idCategory,
        name: category.name,
        idArea: category.idArea
    });
}

// Update Category
Out.update = (id, category) => {
    return Category.update({ name: category.name, idArea: category.idArea }, {
        where: { 'idCategory': id },
        returning: true,
    });
}

//Delete Category by id
Out.remove = (id) => {
    return Category.destroy({ where: { 'idCategory': id } });
}