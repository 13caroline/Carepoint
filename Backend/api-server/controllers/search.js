const dbconfig = require('../models/Config/Database_Info');
const dbViewsPath = '../../../Database/';

var Out = module.exports;

// ****************************************************************************************************************************************** //
// ****************************************************************************************************************************************** //
//                                                           4 Parameters                                                                     //
// ****************************************************************************************************************************************** //
// ****************************************************************************************************************************************** //

/*
* params: Categoria, Location, Experience, Price
* Usado para os casos: 1111, 1110, 1101
*
* returns: Todos os Service Providers que se encontram dentro dessas limitações
*/
Out.get_allParameters = (category, location, experience, price) => {
    return dbconfig.sequelize.query('CALL get_service_providers_all_parameters (:idC, :idL, :exp, :prc)',
        {replacements: {
            idC: category,
            idL: location,
            exp: experience,
            prc: price
            }})
}

// ****************************************************************************************************************************************** //
// ****************************************************************************************************************************************** //
//                                                           3 Parameters                                                                     //
// ****************************************************************************************************************************************** //
// ****************************************************************************************************************************************** //

/*
* params: Categoria, Experience, Price
* Usado para os casos: 1011
*
* returns: Todos os Service Providers que se encontram dentro dessas limitações
*/
Out.get_noLocation = (category, experience, price) => {
    return dbconfig.sequelize.query('CALL get_service_providers_without_location (:idC, :exp, :prc)',
        {replacements: {
            idC: category,
            exp: experience,
            prc: price
        }})
}

/*
* params: Location, Experience, Price
* Usado para os casos: 0111
*
* returns: Todos os Service Providers que se encontram dentro dessas limitações
*/
Out.get_noCategory = (location, experience, price) => {
    return dbconfig.sequelize.query('CALL get_service_providers_without_location (:idL, :exp, :prc)',
        {replacements: {
            idL: location,
            exp: experience,
            prc: price
        }})
}

// ****************************************************************************************************************************************** //
// ****************************************************************************************************************************************** //
//                                                           2 Parameters                                                                     //
// ****************************************************************************************************************************************** //
// ****************************************************************************************************************************************** //

/*
* params: Categoria, Location
* Usado para os casos: 1100
*
* returns: Todos os Service Providers que se encontram dentro dessas limitações
*/
Out.get_categoryANDlocation = (category, location) => {
    return dbconfig.sequelize.query('CALL get_service_providers_location_caregory (:idC, :idL)',
        {replacements: {
            idC: category,
            idL: location
        }})
}

/*
* params: Categoria, price
* Usado para os casos: 1001
*
* returns: Todos os Service Providers que se encontram dentro dessas limitações
*/
Out.get_categoryANDprice = (category, price) => {
    return dbconfig.sequelize.query('CALL get_service_providers_category_price (:idC, :prc)',
        {replacements: {
            idC: category,
            prc: price
        }})
}

/*
* params: Categoria, experience
* Usado para os casos: 1010
*
* returns: Todos os Service Providers que se encontram dentro dessas limitações
*/
Out.get_categoryANDexperience = (category, experience) => {
    return dbconfig.sequelize.query('CALL get_service_providers_category_experience (:idC, :exp)',
        {replacements: {
            idC: category,
            exp: experience
        }})
}

/*
* params: Location, Price
* Usado para os casos: 0101
*
* returns: Todos os Service Providers que se encontram dentro dessas limitações
*/
Out.get_locationANDprice = (location, price) => {
    return dbconfig.sequelize.query('CALL get_service_providers_location_price (:idL, :prc)',
        {replacements: {
            idL: location,
            prc: price
        }})
}

/*
* params: Location, Experience
* Usado para os casos: 0110
*
* returns: Todos os Service Providers que se encontram dentro dessas limitações
*/
Out.get_locationANDexperience = (location, experience) => {
    return dbconfig.sequelize.query('CALL get_service_providers_location_experience (:idL, :exp)',
        {replacements: {
            idL: location,
            exp: experience
        }})
}

/*
* params: Experience, Price
* Usado para os casos: 0011
*
* returns: Todos os Service Providers que se encontram dentro dessas limitações
*/
Out.get_experienceANDprice = (experience, price) => {
    return dbconfig.sequelize.query('CALL get_service_providers_location_price (:exp, :prc)',
        {replacements: {
            exp: experience,
            prc: price
        }})
}

// ****************************************************************************************************************************************** //
// ****************************************************************************************************************************************** //
//                                                           1 Parameter                                                                      //
// ****************************************************************************************************************************************** //
// ****************************************************************************************************************************************** //

/*
* params: Categoria
* Usado para os casos: 1000
*
* returns: Todos os Service Providers que se encontram dentro dessas limitações
*/
Out.get_category = (category) => {
    return dbconfig.sequelize.query('CALL get_service_providers_category (:idC)',
        {replacements: {
            idC: category
        }})
}

/*
* params: Location
* Usado para os casos: 0100
*
* returns: Todos os Service Providers que se encontram dentro dessas limitações
*/
Out.get_location = (location) => {
    return dbconfig.sequelize.query('CALL get_service_providers_location (:idL)',
        {replacements: {
            idL: location
        }})
}

/*
* params: Experience
* Usado para os casos: 0010
*
* returns: Todos os Service Providers que se encontram dentro dessas limitações
*/
Out.get_experience = (experience) => {
    return dbconfig.sequelize.query('CALL get_service_providers_experience (:exp)',
        {replacements: {
            exp: experience
        }})
}

/*
* params: Price
* Usado para os casos: 0001
*
* returns: Todos os Service Providers que se encontram dentro dessas limitações
*/
Out.get_money = (price) => {
    return dbconfig.sequelize.query('CALL get_service_providers_price (:prc)',
        {replacements: {
            prc: price
        }})
}

// ****************************************************************************************************************************************** //
// ****************************************************************************************************************************************** //
//                                                           0 Parameters                                                                     //
// ****************************************************************************************************************************************** //
// ****************************************************************************************************************************************** //

/*
* params: -- Empty -- (Logo é VIEW em vez de procedure)
* Usado para os casos: 0000
*
* returns: Todos os Service Providers que se encontram dentro dessas limitações
*/
Out.get_noParams = (limit, offset) => {
    return dbconfig.sequelize.query('CALL get_service_providers (:lm, :off)',
        {replacements: {
            lm: limit,
            off: offset
        }})
}

// ****************************************************************************************************************************************** //
// ****************************************************************************************************************************************** //
//                                                           Companies                                                                        //
// ****************************************************************************************************************************************** //
// ****************************************************************************************************************************************** //

/*
* params: Location
* Usado para os casos: 1111, 1110, 1101, 0111, 1100, 0101, 0110, 0100
*
* returns: Todos os Service Providers que se encontram dentro dessas limitações
*/
Out.get_CompaniesLocation = (location) => {
    return dbconfig.sequelize.query('CALL get_companies_location (:idL)',
        {replacements: {
            idL: location
        }})
}

/*
* params: -- Empty -- (Logo é VIEW em vez de procedure)
* Usado para os casos: 1011, 1001, 1010, 0011, 1000, 0010, 0001, 0000
*
* returns: Todos os Service Providers que se encontram dentro dessas limitações
*/
Out.get_noParamsCompany = () => {
    return dbconfig.sequelize.query('SELECT * FROM get_companies')
}