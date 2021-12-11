USE PI;

DROP PROCEDURE IF EXISTS get_reviews;
DROP PROCEDURE IF EXISTS get_average_rating;
DROP VIEW IF EXISTS get_service_providers;
DROP PROCEDURE IF EXISTS get_service_providers_location;
DROP VIEW IF EXISTS get_companies;
DROP PROCEDURE IF EXISTS get_companies_location;
DROP PROCEDURE IF EXISTS get_service_providers_category;
DROP PROCEDURE IF EXISTS get_service_providers_location_category;

-- Returns: returns all the reviews for a specific user
DELIMITER &&  
CREATE PROCEDURE get_reviews (IN id INT)  
BEGIN  
    SELECT description,rating,postDate FROM review WHERE id = review.idReceive;
END &&  
DELIMITER ;  

-- Returns: average rating or null if no reviews
DELIMITER &&  
CREATE PROCEDURE get_average_rating (IN id INT)  
BEGIN  
    SELECT AVG(rating) FROM review WHERE id = review.idReceive;
END &&  
DELIMITER ;

-- Returns: all service providers
CREATE VIEW get_service_providers AS
    SELECT user.idUser, user.name,user.lastActivity,serviceprovider.description,location.name AS location,location.cordsX, location.cordsY, file.image FROM user
    INNER JOIN serviceprovider ON user.idUser = serviceprovider.idSP 
    INNER JOIN location ON user.idLocation = location.idLocation
    INNER JOIN file ON user.idUser = file.idUser WHERE user.type = 3;


-- Returns: service providers in given location
DELIMITER &&  
CREATE PROCEDURE get_service_providers_location (IN id INT)  
BEGIN  
    SELECT user.idUser, user.name,user.lastActivity,serviceprovider.description,location.name, location.cordsX, location.cordsY, file.image FROM user
    INNER JOIN serviceprovider ON user.idUser = serviceprovider.idSP 
    INNER JOIN location ON user.idLocation = location.idLocation
    INNER JOIN file ON user.idUser = file.idUser WHERE user.type = 3 AND user.idLocation = id;
END &&  
DELIMITER ;

-- Returns: service providers in given category
DELIMITER &&  
CREATE PROCEDURE get_service_providers_category (IN id INT)  
BEGIN  
    SELECT user.idUser, user.name,user.lastActivity,serviceprovider.description,location.name, location.cordsX, location.cordsY FROM user
    INNER JOIN location ON user.idLocation = location.idLocation
    INNER JOIN serviceprovider ON user.idUser = serviceprovider.idSP 
	INNER JOIN category_has_serviceprovider ON serviceprovider.idSP = category_has_serviceprovider.idServiceProvider WHERE user.type = 3 AND category_has_serviceprovider.idCategory = id;
END &&  
DELIMITER ;

-- Returns: service providers in given location and category
DELIMITER &&  
CREATE PROCEDURE get_service_providers_location_category (IN id_category INT, IN id_location INT)  
BEGIN  
    SELECT user.idUser, user.name,user.lastActivity,serviceprovider.description,location.name, location.cordsX, location.cordsY, file.image FROM user
    INNER JOIN location ON user.idLocation = location.idLocation
    INNER JOIN file ON user.idUser = file.idUser
    INNER JOIN serviceprovider ON user.idUser = serviceprovider.idSP 
	INNER JOIN category_has_serviceprovider ON serviceprovider.idSP = category_has_serviceprovider.idServiceProvider 
		WHERE user.type = 3 AND user.idLocation = id_location AND category_has_serviceprovider.idCategory = id_category;
END &&  
DELIMITER ;

-- Returns: all companies
CREATE VIEW get_companies AS
    SELECT user.idUser, user.name,company.link,company.firm,company.nipc,PI.add.description,location.name AS location,location.cordsX, location.cordsY FROM user
    INNER JOIN company ON user.idUser = company.idCompany
    INNER JOIN PI.add ON user.idUser = PI.add.idCompany
    INNER JOIN location ON user.idLocation = location.idLocation;
    

-- Returns: companies in given location
DELIMITER &&  
CREATE PROCEDURE get_companies_location (IN id INT)  
BEGIN  
    SELECT user.idUser, user.name,company.link,company.firm,company.nipc,PI.add.description,location.name AS location,location.cordsX, location.cordsY, file.image FROM user
    INNER JOIN company ON user.idUser = company.idCompany 
    INNER JOIN PI.add ON user.idUser = PI.add.idCompany
    INNER JOIN location ON user.idLocation = location.idLocation
    INNER JOIN file ON user.idUser = file.idUser WHERE user.type = 4 AND user.idLocation = id;
END &&  
DELIMITER ;






