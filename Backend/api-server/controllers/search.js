const dbconfig = require('../models/Config/Database_Info');
const dbViewsPath = '../../../Database/';

var Out = module.exports;

Out.get_allParameters = (category, location, experience, money) => {
    dbconfig.sequelize.query('CALL get_service_providers_all_parameters (:idC, :idL, :exp, :m)',
        {replacements: {
            idC: category,
            idL: location,
            exp: experience,
            m: money
            }})
    .then((data) => {return data})
    .catch((error) => {return "Erro a obter ServiceProviders";})
}

Out.get_categoryANDlocation = (category, location) => {
    dbconfig.sequelize.query('CALL get_service_providers_location_caregory (:idC, :idL)',
        {replacements: {
            idC: category,
            idL: location
        }})
    .then((data) => {return data;})
    .catch((error) => {return "Erro a obter ServiceProviders";})
}

Out.get_category = (category) => {
    dbconfig.sequelize.query('CALL get_service_providers_category (:idC)',
        {replacements: {
            idC: category
        }})
    .then((data) => {return data;})
    .catch((error) => {return "Erro a obter ServiceProviders";})
}

Out.get_location = (location) => {
    dbconfig.sequelize.query('CALL get_service_providers_location (:idL)',
        {replacements: {
            idL: location
        }})
    .then((data) => {return data;})
    .catch((error) => {return "Erro a obter ServiceProviders";})
}

Out.get_noParams = () => {
    dbconfig.sequelize.query('SELECT * FROM get_service_providers')
    .then((data) => {return data;})
    .catch((error) => {return "Erro a obter ServiceProviders";})
}