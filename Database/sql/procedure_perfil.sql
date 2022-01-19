USE PI;

DROP PROCEDURE IF EXISTS get_consumer_profile;
DROP PROCEDURE IF EXISTS get_reviews;
DROP PROCEDURE IF EXISTS get_sp_category_info;
DROP PROCEDURE IF EXISTS get_sp_only_category_info;
DROP PROCEDURE IF EXISTS get_sp_horarios;
DROP PROCEDURE IF EXISTS get_average_rating;
DROP PROCEDURE IF EXISTS get_service_provider_profile;
DROP PROCEDURE IF EXISTS get_service_provider_profile_v2;
DROP PROCEDURE IF EXISTS get_company_profile;
DROP PROCEDURE IF EXISTS get_user_image;
DROP PROCEDURE IF EXISTS get_company_profile_2;


-- =============================================
-- Description: Calculate the average rating of a service provider, based on reviews received
-- Type: Procedure
-- Parameters:
--   @id - service provider identification number
-- Returns: Average rating or null if the person doesn't have reviews
-- =============================================

DELIMITER &&  
CREATE PROCEDURE get_average_rating (IN id INT)  
BEGIN  
    SELECT AVG(rating) FROM review WHERE id = review.idReceive;
END &&  
DELIMITER ;

-- =============================================
-- Description: Get all information about categories of a scpecific service provider
-- Type: Procedure
-- Parameters:
--   @id - service provider identification number
-- Returns: All information about categories that belongs to a specific service provider (name of category, experience, work schedule and price)
-- =============================================

DELIMITER &&
CREATE PROCEDURE get_sp_category_info (IN id INT)
BEGIN
	SELECT category.name, category_has_serviceprovider.experience, category_has_serviceprovider.workSchedule, 
		category_has_serviceprovider.price FROM user
	INNER JOIN category_has_serviceprovider ON user.idUser = category_has_serviceprovider.idServiceProvider
    INNER JOIN category ON category_has_serviceprovider.idCategory = category.idCategory WHERE id = user.idUser;
END &&
DELIMITER ;

-- =============================================
-- Description: Get all information about categories of a scpecific service provider, except work schedule
-- Type: Procedure
-- Parameters:
--   @id - service provider identification number
-- Returns: All information about categories that belongs to a specific service provider (name of category, experience and price), except work schedule
-- =============================================

DELIMITER &&
CREATE PROCEDURE get_sp_only_category_info (IN id INT)
BEGIN
	SELECT category.name, category_has_serviceprovider.experience, category_has_serviceprovider.price FROM user
	INNER JOIN category_has_serviceprovider ON user.idUser = category_has_serviceprovider.idServiceProvider
    INNER JOIN category ON category_has_serviceprovider.idCategory = category.idCategory WHERE id = user.idUser;
END &&
DELIMITER ;

-- =============================================
-- Description: Get work schedule information of a scpecific service provider
-- Type: Procedure
-- Parameters:
--   @id - service provider identification number
-- Returns: Work schedule and category name that belongs to a specific service provider 
-- =============================================

DELIMITER &&
CREATE PROCEDURE get_sp_horarios (IN id INT)
BEGIN
	SELECT category.name, category_has_serviceprovider.workSchedule FROM user
	INNER JOIN category_has_serviceprovider ON user.idUser = category_has_serviceprovider.idServiceProvider
    INNER JOIN category ON category_has_serviceprovider.idCategory = category.idCategory WHERE id = user.idUser;
END &&
DELIMITER ;

-- =============================================
-- Description: Get all reviews for a certain service provider
-- Type: Procedure
-- Parameters:
--   @id - service provider identification number
-- Returns: All reviews for a certain service provider
-- =============================================

DELIMITER &&  
CREATE PROCEDURE get_reviews (IN id INT)  
BEGIN  
    SELECT description,rating,postDate, user.name FROM review
    INNER JOIN user ON review.idGive = user.idUser WHERE id = review.idReceive;
END &&  
DELIMITER ;  


-- =============================================
-- Description: Get all information of a scpecific service provider, except categories information  
-- Type: Procedure
-- Parameters:
--   @id - service provider identification number
-- Returns: All information of a scpecific service provider, except categories information  
-- =============================================

DELIMITER &&  
CREATE PROCEDURE get_service_provider_profile (IN id INT)  
BEGIN  
    SELECT user.idUser, user.name, user.email, user.phoneNumber, user.sex, user.lastActivity, user.active, serviceprovider.description, serviceprovider.averageRating, 
		serviceprovider.dateOfBirth, serviceprovider.distance, serviceprovider.qualifications, location.name as locationName, location.cordsX, location.cordsY, file.image FROM user
    INNER JOIN location ON user.idLocation = location.idLocation
    INNER JOIN serviceprovider ON user.idUser = serviceprovider.idSP 
    INNER JOIN file ON user.idUser = file.idUser WHERE id = user.idUser;
END &&  
DELIMITER ; 

-- =============================================
-- Description: Get all information of a scpecific consumer
-- Type: Procedure
-- Parameters:
--   @em - consumer email
-- Returns: All information of a scpecific consumer
-- =============================================

DELIMITER &&  
CREATE PROCEDURE get_consumer_profile (IN em VARCHAR(90))
BEGIN
	SELECT user.idUser, user.name, user.email, user.phoneNumber, user.sex, user.type, user.createdAt, user.lastActivity, user.active, location.name as locationName, location.cordsX, location.cordsY, file.image FROM user
	INNER JOIN location ON user.idLocation = location.idLocation
    INNER JOIN file ON user.idUser = file.idUser WHERE em = user.email;
END &&
DELIMITER ;

-- =============================================
-- Description: Get all information of a scpecific service provider, including subscription information, except categories information  
-- Type: Procedure
-- Parameters:
--   @em - service provider email
-- Returns: All information of a scpecific service provider, including subscription information, except categories information  
-- =============================================

DELIMITER &&  
CREATE PROCEDURE get_service_provider_profile_v2 (IN em VARCHAR(90))  
BEGIN  
    SELECT user.idUser, user.name, user.email, user.phoneNumber, user.sex, user.lastActivity,user.active, serviceprovider.description, serviceprovider.endSub, serviceprovider.endSubVip, 
		serviceprovider.averageRating, serviceprovider.dateOfBirth, serviceprovider.distance, serviceprovider.qualifications, location.name as locationName, location.cordsX, location.cordsY, 
        subscription.type as subType, subscription.duration as subDuration, subscription.value as subValue, file.image FROM user
	INNER JOIN location ON user.idLocation = location.idLocation
    INNER JOIN serviceprovider ON user.idUser = serviceprovider.idSP
    INNER JOIN  subscription ON serviceprovider.idSubscription = subscription.idSubscription
    INNER JOIN file ON user.idUser = file.idUser WHERE em = user.email;
END &&  
DELIMITER ;

-- =============================================
-- Description: Get all information of a scpecific company, including subscription information
-- Type: Procedure
-- Parameters:
--   @em - Company email
-- Returns: All information of a scpecific company, including subscription information
-- =============================================

DELIMITER &&
CREATE PROCEDURE get_company_profile (IN em VARCHAR(90))
BEGIN
	SELECT user.idUser, user.name, user.email, user.phoneNumber, user.sex, user.type, user.createdAt, user.lastActivity, user.active, location.name as locationName, location.cordsX, location.cordsY,
		   company.link, company.firm, company.nipc, company.endSub, company.endSubVip, pi.add.description, subscription.type as subType, subscription.duration as subDuration, subscription.value as subValue, file.image FROM user
	INNER JOIN location ON user.idLocation = location.idLocation
    INNER JOIN company ON user.idUser = company.idCompany
    INNER JOIN pi.add ON pi.add.idCompany = company.idCompany
    INNER JOIN  subscription ON company.idSubscription = subscription.idSubscription
    INNER JOIN file ON user.idUser = file.idUser WHERE em = user.email;
END &&
DELIMITER ;

-- =============================================
-- Description: Get all information of a scpecific company, except subscription information
-- Type: Procedure
-- Parameters:
--   @id - Company identification number
-- Returns: All information of a scpecific company, except subscription information
-- =============================================

DELIMITER &&
CREATE PROCEDURE get_company_profile_2 (IN id INT)
BEGIN
	SELECT user.idUser, user.name, user.email, user.phoneNumber, user.sex, user.type, user.createdAt, user.lastActivity, user.active, location.name as locationName, location.cordsX, location.cordsY,
		   company.link, company.firm, company.nipc, pi.add.description, file.image FROM user
	INNER JOIN location ON user.idLocation = location.idLocation
    INNER JOIN company ON user.idUser = company.idCompany
    INNER JOIN pi.add ON pi.add.idCompany = company.idCompany
    INNER JOIN file ON user.idUser = file.idUser WHERE id = user.idUser;
END &&
DELIMITER ;

-- =============================================
-- Description: Get user profile picture
-- Type: Procedure
-- Parameters:
--   @em - user email
-- Returns: Profile picture of the user
-- =============================================

DELIMITER &&
CREATE PROCEDURE get_user_image (IN em VARCHAR(90))
BEGIN
	SELECT file.image FROM user
    INNER JOIN file ON user.idUser = file.idUser WHERE em = user.email;
END &&
DELIMITER ;