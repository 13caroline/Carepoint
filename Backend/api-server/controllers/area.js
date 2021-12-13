// Controller for the area model


const Area = require('../models/area')

var Out = module.exports;

//GET by name
Out.consult = (name) => {
    return Area.findOne({ where: { 'name': name } });
}

//GET by id
Out.consult_id = (id) => {
    return Area.findOne({ where: { 'idArea': id } });
}

//GET all Areas
Out.list = () => {
    console.log(Area.findAll())
    return Area.findAll();
}

//Creates a new Area
Out.insert = (area) => {
    return Area.create({
        idArea: area.idArea,
        name: area.name
    });
}

// Update Area
Out.update = (id, area) => {
    return Area.update({ name: area.name }, {
        where: { 'idArea': id },
        returning: true,
    });
}

//Delete Area by id
Out.remove = (id) => {
    return Area.destroy({ where: { 'idArea': id } });
}