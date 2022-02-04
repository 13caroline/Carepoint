USE PI;

DROP PROCEDURE IF EXISTS createReview;
DROP PROCEDURE IF EXISTS get_joboffer;
DROP PROCEDURE IF EXISTS get_joboffer_count;
DROP VIEW IF EXISTS count_sps;
DROP VIEW IF EXISTS count_sps_fakeish;
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
DROP PROCEDURE IF EXISTS get_max_values;
DROP VIEW IF EXISTS get_locations;
DROP VIEW IF EXISTS get_categories;
DROP PROCEDURE IF EXISTS get_consumers_joboffers;
DROP PROCEDURE IF EXISTS get_service_providers;
DROP PROCEDURE IF EXISTS get_companies;
DROP PROCEDURE IF EXISTS get_service_providers_v2;
DROP PROCEDURE IF EXISTS get_service_providers_v3;
DROP PROCEDURE IF EXISTS get_service_providers_v2_count;
DROP PROCEDURE IF EXISTS get_companies_count;
DROP TRIGGER IF EXISTS default_pic;
DROP TRIGGER IF EXISTS update_averageRating;
DROP PROCEDURE IF EXISTS update_consumer;
DROP PROCEDURE IF EXISTS update_file;
DROP PROCEDURE IF EXISTS update_serviceProvider;
DROP PROCEDURE IF EXISTS update_company;
DROP PROCEDURE IF EXISTS update_serviceProvider_endSub;
DROP PROCEDURE IF EXISTS update_company_endSub;
DROP PROCEDURE IF EXISTS update_joboffer;
DROP PROCEDURE IF EXISTS update_serviceProvider_vip;
DROP PROCEDURE IF EXISTS update_company_vip;
DROP PROCEDURE IF EXISTS update_last_activity;
DROP PROCEDURE IF EXISTS update_averageRating;
DROP PROCEDURE IF EXISTS user_messages_with;
DROP PROCEDURE IF EXISTS all_messages_with;
DROP PROCEDURE IF EXISTS createMessage;
DROP PROCEDURE IF EXISTS add_slot;
DROP PROCEDURE IF EXISTS remove_workSchedule_slot;
DROP PROCEDURE IF EXISTS add_workSchedule_slot;
DROP PROCEDURE IF EXISTS insert_categorias;
DROP PROCEDURE IF EXISTS remove_slot;
DROP PROCEDURE IF EXISTS get_service_provider_by_name;
DROP PROCEDURE IF EXISTS get_service_provider_by_name_count;
DROP PROCEDURE IF EXISTS get_companies_by_name;
DROP PROCEDURE IF EXISTS get_companies_by_name_count;
DROP PROCEDURE IF EXISTS get_service_providers_v3_count;
DROP PROCEDURE IF EXISTS info_requested_slots;
DROP PROCEDURE IF EXISTS info_requested_slots_v2;
DROP PROCEDURE IF EXISTS remove_categoria;
DROP PROCEDURE IF EXISTS verify_slot;
DROP PROCEDURE IF EXISTS verify_ws;

-- =============================================
-- Description: Insert review
-- Type: Procedure
-- Parameters:
--   @in_description -  description of the review
--   @in_rating - rating of the review
--   @in_give -  person that gives the review
--   @in_receive - person that gets the review
-- Returns: Nothing
-- =============================================

DELIMITER &&  
CREATE PROCEDURE createReview (IN in_description VARCHAR(2000), IN in_rating INT, IN in_give INT, IN in_receive INT)  
BEGIN  

	INSERT INTO review (description, rating, postDate, idGive, idReceive)
    VALUES (in_description, in_rating, now(), in_give, in_receive);
        
END &&  
DELIMITER ;

-- =============================================
-- Description: Get a limited amount of job offers
-- Type: Procedure
-- Parameters:
--   @id_category - category to be searched
--   @id_location - location to be searched
--   @price - price limit
--   @limite - number of job offers to return
--   @inicio - value for the pagination, represents the page
-- Returns: Job offers that meet the conditions, ordered by the primary key 
-- =============================================

DELIMITER &&  
CREATE PROCEDURE get_joboffer (IN id_category INT,IN id_location INT, IN price DOUBLE,IN limite INT, IN inicio INT)  
BEGIN  
    SELECT joboffer.idJobOffer, user.idUser, user.name, user.lastActivity, joboffer.description, joboffer.beginDate, joboffer.postDate, joboffer.endDate, joboffer.price, joboffer.idCategory, joboffer.done, category.name as category, location.name AS location, location.cordsX, location.cordsY FROM joboffer
    INNER JOIN user ON joboffer.idUser = user.idUser
    INNER JOIN location ON joboffer.idLocation = location.idLocation
	INNER JOIN category ON joboffer.idCategory = category.idCategory
    WHERE joboffer.done != 1 AND CASE WHEN id_category IS NOT NULL AND id_location IS NOT NULL AND price IS NOT NULL 
					THEN joboffer.idLocation = id_location AND joboffer.idCategory = id_category AND (joboffer.price <= price OR joboffer.price IS NULL)
				WHEN id_category IS NOT NULL AND id_location IS NOT NULL AND price IS NULL 
					THEN joboffer.idLocation = id_location AND joboffer.idCategory = id_category
				WHEN id_category IS NOT NULL AND id_location IS NULL AND price IS NOT NULL 
					THEN joboffer.idCategory = id_category AND (joboffer.price <= price OR joboffer.price IS NULL)
				WHEN id_category IS NULL AND id_location IS NOT NULL AND price IS NOT NULL 
					THEN joboffer.idLocation = id_location AND (joboffer.price <= price OR joboffer.price IS NULL)
				WHEN id_category IS NOT NULL AND id_location IS NULL AND price IS NULL 
					THEN joboffer.idCategory = id_category 
				WHEN id_category IS NULL AND id_location IS NOT NULL AND price IS NULL 
					THEN joboffer.idLocation = id_location
				WHEN id_category IS NULL AND id_location IS NULL AND price IS NOT NULL 
					THEN (joboffer.price <= price OR joboffer.price IS NULL)
				ELSE 1
                END
    ORDER BY joboffer.idJobOffer DESC LIMIT limite OFFSET inicio;
END &&  
DELIMITER ;

-- =============================================
-- Description: Get number of job offers that meet conditions
-- Type: Procedure
-- Parameters:
--   @id_category - category to be searched
--   @id_location - location to be searched
--   @price - price limit
-- Returns: Number of job offers that meet conditions
-- =============================================

DELIMITER &&  
CREATE PROCEDURE get_joboffer_count (IN id_category INT,IN id_location INT, IN price DOUBLE)  
BEGIN  
	SELECT COUNT(*) AS number_offers FROM (
    SELECT joboffer.idJobOffer FROM joboffer
    INNER JOIN user ON joboffer.idUser = user.idUser
    INNER JOIN location ON joboffer.idLocation = location.idLocation 
    WHERE joboffer.done != 1 AND CASE WHEN id_category IS NOT NULL AND id_location IS NOT NULL AND price IS NOT NULL 
					THEN joboffer.idLocation = id_location AND joboffer.idCategory = id_category AND (joboffer.price <= price OR joboffer.price IS NULL)
				WHEN id_category IS NOT NULL AND id_location IS NOT NULL AND price IS NULL 
					THEN joboffer.idLocation = id_location AND joboffer.idCategory = id_category
				WHEN id_category IS NOT NULL AND id_location IS NULL AND price IS NOT NULL 
					THEN joboffer.idCategory = id_category AND (joboffer.price <= price OR joboffer.price IS NULL)
				WHEN id_category IS NULL AND id_location IS NOT NULL AND price IS NOT NULL 
					THEN joboffer.idLocation = id_location AND (joboffer.price <= price OR joboffer.price IS NULL)
				WHEN id_category IS NOT NULL AND id_location IS NULL AND price IS NULL 
					THEN joboffer.idCategory = id_category 
				WHEN id_category IS NULL AND id_location IS NOT NULL AND price IS NULL 
					THEN joboffer.idLocation = id_location
				WHEN id_category IS NULL AND id_location IS NULL AND price IS NOT NULL 
					THEN (joboffer.price <= price OR joboffer.price IS NULL)
				ELSE 1
                END
    ) AS aux_offers;
END &&  
DELIMITER ;

-- =============================================
-- Description: Count service providers that can see job offers
-- Type: View
-- Returns: Number of service providers that can see job offers
-- =============================================

CREATE VIEW count_sps AS 
  SELECT COUNT(*) FROM pi.serviceprovider WHERE serviceprovider.idSubscription = 3 OR serviceprovider.idSubscription = 4 
	OR serviceprovider.idSubscription = 6 OR serviceprovider.idSubscription = 7;
    
-- =============================================
-- Description: Count service providers that can see job offers version 2
-- Type: View
-- Returns: Number of service providers that can see job offers
-- =============================================

CREATE VIEW count_sps_fakeish AS 
  SELECT COUNT(*) FROM pi.serviceprovider WHERE serviceprovider.idSubscription = 3 OR serviceprovider.idSubscription = 4 
	OR serviceprovider.idSubscription = 6 OR serviceprovider.idSubscription = 7 OR DATE_SUB(serviceprovider.endSub,INTERVAL 3 MONTH) >= now();
    
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
-- Returns: All information about categories that belongs to a specific service provider (name of category, experience, work schedule, occupied schedule and price)
-- =============================================

DELIMITER &&
CREATE PROCEDURE get_sp_category_info (IN id INT)
BEGIN
	SELECT category.name, category_has_serviceprovider.experience,  serviceprovider.workSchedule,serviceprovider.occupiedSchedule, category_has_serviceprovider.price FROM user
	INNER JOIN category_has_serviceprovider ON user.idUser = category_has_serviceprovider.idServiceProvider
    INNER JOIN category ON category_has_serviceprovider.idCategory = category.idCategory 
    INNER JOIN serviceprovider ON user.idUser = serviceprovider.idSP WHERE id = user.idUser;
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
	SELECT category.idCategory, category.name, category_has_serviceprovider.experience, category_has_serviceprovider.price FROM user
	INNER JOIN category_has_serviceprovider ON user.idUser = category_has_serviceprovider.idServiceProvider
    INNER JOIN category ON category_has_serviceprovider.idCategory = category.idCategory WHERE id = user.idUser;
END &&
DELIMITER ;

-- =============================================
-- Description: Get work schedule and occupied schedule of a scpecific service provider
-- Type: Procedure
-- Parameters:
--   @id - service provider identification number
-- Returns: Work schedule, occupied schedule that belongs to a specific service provider 
-- =============================================

DELIMITER &&
CREATE PROCEDURE get_sp_horarios (IN id INT)
BEGIN
	
    DECLARE os JSON DEFAULT '[]';
    DECLARE sorted_os JSON DEFAULT '[]';
    
    -- get the occupied schedule
    SET os = (SELECT serviceprovider.occupiedSchedule FROM serviceprovider WHERE id = serviceprovider.idSP);
    
    -- sort occupied shcedule
    SET sorted_os = (SELECT JSON_ARRAYAGG(object)
		FROM (
			SELECT object
				FROM JSON_TABLE(os,
                    '$[*]' COLUMNS (object JSON PATH '$',
                                    date_requested DATETIME PATH '$.date_requested')) jsontable
		ORDER BY date_requested LIMIT 18446744073709551615
		) parsed);

	SELECT serviceprovider.workSchedule, sorted_os AS occupiedSchedule FROM serviceprovider WHERE id = serviceprovider.idSP;
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
    SELECT user.idUser, user.name, user.email, user.phoneNumber, user.sex, user.lastActivity, user.active, serviceprovider.solidarity, serviceprovider.description, serviceprovider.averageRating, 
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
    SELECT user.idUser, user.name, user.email, user.phoneNumber, user.sex, user.lastActivity, user.active, user.freeTrial, serviceprovider.solidarity, serviceprovider.description, serviceprovider.endSub, serviceprovider.endSubVip, 
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
	SELECT user.idUser, user.name, user.email, user.phoneNumber, user.sex, user.type, user.createdAt, user.lastActivity, user.active, user.freeTrial, location.name as locationName, location.cordsX, location.cordsY,
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
	SELECT user.idUser, user.name, user.email, user.phoneNumber, user.sex, user.type, user.createdAt, user.lastActivity, user.active, user.freeTrial, location.name as locationName, location.cordsX, location.cordsY,
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

-- =============================================
-- Description: Get the maximum values like: maximum price, maximum experience and maximum rating
-- Type: Procedure
-- Parameters: None
-- Returns: Maximum price, maximum experience and maximum rating
-- =============================================
 
DELIMITER &&  
CREATE PROCEDURE get_max_values ()  
BEGIN  
	DECLARE price DOUBLE DEFAULT 0.0;
    DECLARE experience INT DEFAULT 0;
    DECLARE rating DOUBLE DEFAULT 0.0;
    
    -- calculate maximum price
	SET price = (SELECT MAX(category_has_serviceprovider.price) FROM serviceprovider
		INNER JOIN category_has_serviceprovider ON serviceprovider.idSP = category_has_serviceprovider.idServiceProvider);
	
    -- calculate maximum experience   
	SET experience = (SELECT MAX(category_has_serviceprovider.experience) FROM serviceprovider
		INNER JOIN category_has_serviceprovider ON serviceprovider.idSP = category_has_serviceprovider.idServiceProvider);
    
     -- calculate maximum rating 
    SET rating = (SELECT MAX(serviceprovider.averageRating) FROM serviceprovider);
    
    SELECT price, experience , rating;
    
END &&  
DELIMITER ;

    
-- =============================================
-- Description: Get all the locations
-- Type: View
-- Parameters: None
-- Returns: All locations
-- =============================================

CREATE VIEW get_locations 
AS  
    SELECT location.idLocation, location.name FROM location;
    
-- =============================================
-- Description: Get all the categories
-- Type: View
-- Parameters: None
-- Returns: All categories
-- =============================================

CREATE VIEW get_categories
AS  
    SELECT category.idCategory, category.name FROM category;


-- =============================================
-- Description: Get all job offers of a scpecific user
-- Type: Procedure
-- Parameters:
--   @in_email - email of the user
-- Returns:  All job offers of a scpecific user, ordered by post date
-- =============================================

DELIMITER &&  
CREATE PROCEDURE get_consumers_joboffers (IN in_email VARCHAR(90))  
BEGIN  

    SELECT joboffer.idJobOffer, joboffer.description, joboffer.beginDate, joboffer.postDate, joboffer.price, joboffer.done, joboffer.endDate,
		joboffer.idUser, category.idCategory, category.name as categoryName, location.idLocation, location.name as locationName FROM user 
	INNER JOIN joboffer ON user.idUser = joboffer.idUser
	INNER JOIN category ON joboffer.idCategory = category.idCategory
    INNER JOIN location ON joboffer.idLocation = location.idLocation 
    WHERE user.email = in_email
    ORDER BY joboffer.postDate DESC;
    
END &&  
DELIMITER ;

-- =============================================
-- Description: Get service providers that meet conditions
-- Type: Procedure
-- Parameters:
--   @id_category - category to be searched
--   @id_location - location to be searched
--   @experience - experience to be searched
--   @price - price to be searched
--   @rating - rating to be searched
--   @in_sex - sex to be searched
--   @limite - number of service providers to return
--   @inicio - value for the pagination, represents the page
-- Returns: All service providers that meet conditions, ordered by end date of the vip subscription 
-- =============================================

DELIMITER &&  
CREATE PROCEDURE get_service_providers (IN id_category INT, IN id_location INT, IN experience INT, IN price DOUBLE, IN rating DOUBLE, IN in_sex VARCHAR(1),IN limite INT, IN inicio INT)  
BEGIN  

    SELECT user.idUser, user.name,user.lastActivity,user.active,user.sex,serviceprovider.description,location.name AS location, location.cordsX, location.cordsY,serviceprovider.endSubVip, serviceprovider.averageRating,category_has_serviceprovider.experience,category_has_serviceprovider.price ,file.image FROM user
    INNER JOIN location ON user.idLocation = location.idLocation
    INNER JOIN file ON user.idUser = file.idUser
    INNER JOIN serviceprovider ON user.idUser = serviceprovider.idSP 
	INNER JOIN category_has_serviceprovider ON serviceprovider.idSP = category_has_serviceprovider.idServiceProvider 
	WHERE user.type = 3 AND (serviceprovider.idSubscription != 1 OR user.freeTrial IS NOT NULL) AND serviceprovider.averageRating >= rating AND category_has_serviceprovider.experience >= experience
        AND CASE WHEN id_category IS NOT NULL AND id_location IS NOT NULL AND in_sex IS NOT NULL AND price IS NOT NULL
					THEN user.idLocation = id_location AND category_has_serviceprovider.idCategory = id_category 
						AND (category_has_serviceprovider.price <= price OR category_has_serviceprovider.price IS NULL) AND (user.sex = in_sex OR user.sex = 'I')
				WHEN id_category IS NOT NULL AND id_location IS NOT NULL AND in_sex IS NOT NULL AND price IS NULL
					THEN user.idLocation = id_location AND category_has_serviceprovider.idCategory = id_category AND (user.sex = in_sex OR user.sex = 'I')
				WHEN id_category IS NOT NULL AND id_location IS NOT NULL AND in_sex IS NULL AND price IS NOT NULL
					THEN user.idLocation = id_location AND category_has_serviceprovider.idCategory = id_category 
						AND (category_has_serviceprovider.price <= price OR category_has_serviceprovider.price IS NULL)
				WHEN id_category IS NOT NULL AND id_location IS NULL AND in_sex IS NOT NULL AND price IS NOT NULL
					THEN category_has_serviceprovider.idCategory = id_category 
						AND (category_has_serviceprovider.price <= price OR category_has_serviceprovider.price IS NULL) AND (user.sex = in_sex OR user.sex = 'I')
				WHEN id_category IS NULL AND id_location IS NOT NULL AND in_sex IS NOT NULL AND price IS NOT NULL
					THEN user.idLocation = id_location 
						AND (category_has_serviceprovider.price <= price OR category_has_serviceprovider.price IS NULL) AND (user.sex = in_sex OR user.sex = 'I')
				WHEN id_category IS NOT NULL AND id_location IS NOT NULL AND in_sex IS NULL AND price IS NULL
					THEN user.idLocation = id_location AND category_has_serviceprovider.idCategory = id_category 
				WHEN id_category IS NOT NULL AND id_location IS NULL AND in_sex IS NULL AND price IS NOT NULL
					THEN category_has_serviceprovider.idCategory = id_category AND (category_has_serviceprovider.price <= price OR category_has_serviceprovider.price IS NULL)
				WHEN id_category IS NOT NULL AND id_location IS NULL AND in_sex IS NOT NULL AND price IS NULL
					THEN category_has_serviceprovider.idCategory = id_category AND (user.sex = in_sex OR user.sex = 'I')
				WHEN id_category IS NULL AND id_location IS NOT NULL AND in_sex IS NULL AND price IS NOT NULL
					THEN user.idLocation = id_location AND (category_has_serviceprovider.price <= price OR category_has_serviceprovider.price IS NULL)
				WHEN id_category IS NULL AND id_location IS NULL AND in_sex IS NOT NULL AND price IS NOT NULL
					THEN (category_has_serviceprovider.price <= price OR category_has_serviceprovider.price IS NULL) AND (user.sex = in_sex OR user.sex = 'I')
				WHEN id_category IS NULL AND id_location IS NOT NULL AND in_sex IS NOT NULL AND price IS NULL
					THEN user.idLocation = id_location AND (user.sex = in_sex OR user.sex = 'I')
				WHEN id_category IS NOT NULL AND id_location IS NULL AND in_sex IS NULL AND price IS NULL
					THEN category_has_serviceprovider.idCategory = id_category 
				WHEN id_category IS NULL AND id_location IS NOT NULL AND in_sex IS NULL AND price IS NULL
					THEN user.idLocation = id_location
				WHEN id_category IS NULL AND id_location IS NULL AND in_sex IS NOT NULL AND price IS NULL
					THEN (user.sex = in_sex OR user.sex = 'I')
				WHEN id_category IS NULL AND id_location IS NULL AND in_sex IS NULL AND price IS NOT NULL
					THEN (category_has_serviceprovider.price <= price OR category_has_serviceprovider.price IS NULL)
				ELSE 1
                END
    GROUP BY user.idUser
    ORDER BY serviceprovider.endSubVip DESC LIMIT limite OFFSET inicio;
END &&  
DELIMITER ;


-- =============================================
-- Description: Get companies that meet conditions
-- Type: Procedure
-- Parameters:
--   @id - location to be searched
--   @limite - number of companies to return
--   @inicio - value for the pagination, represents the page
-- Returns: All companies that meet conditions, ordered by end date of the vip subscription 
-- =============================================

DELIMITER &&  
CREATE PROCEDURE get_companies (IN id INT,IN limite INT, IN inicio INT)  
BEGIN  
    SELECT user.idUser, user.name,company.link,company.firm,company.nipc,PI.add.description,location.name AS location,location.cordsX, location.cordsY, file.image FROM user
    INNER JOIN company ON user.idUser = company.idCompany 
    INNER JOIN PI.add ON user.idUser = PI.add.idCompany
    INNER JOIN location ON user.idLocation = location.idLocation
    INNER JOIN file ON user.idUser = file.idUser WHERE user.type = 4 AND (company.idSubscription != 1 OR user.freeTrial IS NOT NULL)
		AND CASE WHEN id IS NOT NULL
					THEN user.idLocation = id
				ELSE 1
                END
    ORDER BY company.endSubVip DESC LIMIT limite OFFSET inicio;
END &&  
DELIMITER ;

-- =============================================
-- Description: Get number of companies that meet conditions
-- Type: Procedure
-- Parameters:
--   @id - location to be searched
--   @limite - number of companies to return
--   @inicio - value for the pagination, represents the page
-- Returns: Number of companies that meet conditions
-- =============================================

DELIMITER &&  
CREATE PROCEDURE get_companies_count (IN id INT)  
BEGIN  
	
    SELECT COUNT(*) AS number_companies FROM (
    SELECT user.idUser FROM user
    INNER JOIN company ON user.idUser = company.idCompany 
    INNER JOIN PI.add ON user.idUser = PI.add.idCompany
    INNER JOIN location ON user.idLocation = location.idLocation
    INNER JOIN file ON user.idUser = file.idUser WHERE user.type = 4 AND (company.idSubscription != 1 OR user.freeTrial IS NOT NULL)
		AND CASE WHEN id IS NOT NULL
					THEN user.idLocation = id
				ELSE 1
                END
    ) AS aux_companies;
END &&  
DELIMITER ;


-- =============================================
-- Description: Get number of service providers that meet conditions
-- Type: Procedure
-- Parameters:
--   @id_category - category to be searched
--   @id_location - location to be searched
--   @experience - experience to be searched
--   @price - price to be searched
--   @rating - rating to be searched
--   @in_sex - sex to be searched
--   @limite - number of service providers to return
--   @inicio - value for the pagination, represents the page
-- Returns: Number of service providers that meet conditions
-- =============================================

DELIMITER &&  
CREATE PROCEDURE get_service_providers_v2 (IN id_category INT, IN id_location INT, IN experience INT, IN price DOUBLE, IN rating DOUBLE, IN in_sex VARCHAR(1),IN limite INT, IN inicio INT)  
BEGIN  

    SELECT (SELECT count(*) FROM review WHERE user.idUser = review.idReceive) as nr_reviews ,
		user.idUser, user.name,user.lastActivity,user.active,user.sex,serviceprovider.description,location.name AS location, location.cordsX, location.cordsY,serviceprovider.endSubVip, serviceprovider.averageRating,category_has_serviceprovider.experience,category_has_serviceprovider.price ,file.image FROM user
    INNER JOIN location ON user.idLocation = location.idLocation
    INNER JOIN file ON user.idUser = file.idUser
    INNER JOIN serviceprovider ON user.idUser = serviceprovider.idSP 
	INNER JOIN category_has_serviceprovider ON serviceprovider.idSP = category_has_serviceprovider.idServiceProvider 
	WHERE user.type = 3 AND (serviceprovider.idSubscription != 1 OR user.freeTrial IS NOT NULL) 
		AND CASE WHEN id_category IS NOT NULL
				THEN category_has_serviceprovider.idCategory = id_category
                ELSE 1
                END
		AND CASE WHEN id_location IS NOT NULL
				THEN user.idLocation = id_location
                ELSE 1
                END 
		AND CASE WHEN experience IS NOT NULL
				THEN category_has_serviceprovider.experience >= experience
                ELSE 1
                END
		AND CASE WHEN price IS NOT NULL
				THEN (category_has_serviceprovider.price <= price OR category_has_serviceprovider.price IS NULL)
                ELSE 1
                END
		AND CASE WHEN rating IS NOT NULL
				THEN serviceprovider.averageRating >= rating
                ELSE 1
                END
		AND CASE WHEN in_sex IS NOT NULL
				THEN (user.sex = in_sex OR user.sex = 'I')
                ELSE 1
                END
	GROUP BY user.idUser
    ORDER BY serviceprovider.endSubVip DESC LIMIT limite OFFSET inicio;
END &&  
DELIMITER ;


-- =============================================
-- Description: Get service providers that meet conditions
-- Type: Procedure
-- Parameters:
--   @id_category - category to be searched
--   @id_location - location to be searched
--   @experience - experience to be searched
--   @price - price to be searched
--   @rating - rating to be searched
--   @in_sex - sex to be searched
--   @limite - number of service providers to return
--   @inicio - value for the pagination, represents the page
-- Returns: All service providers that meet conditions, ordered by end date of the vip subscription 
-- =============================================

DELIMITER &&  
CREATE PROCEDURE get_service_providers_v2_count (IN id_category INT, IN id_location INT, IN experience INT, IN price DOUBLE, IN rating DOUBLE, IN in_sex VARCHAR(1))  
BEGIN  

    SELECT COUNT(*) AS number_sps FROM (SELECT user.idUser FROM user
    INNER JOIN location ON user.idLocation = location.idLocation
    INNER JOIN file ON user.idUser = file.idUser
    INNER JOIN serviceprovider ON user.idUser = serviceprovider.idSP 
	INNER JOIN category_has_serviceprovider ON serviceprovider.idSP = category_has_serviceprovider.idServiceProvider 
	WHERE user.type = 3 AND (serviceprovider.idSubscription != 1 OR user.freeTrial IS NOT NULL)
		AND CASE WHEN id_category IS NOT NULL
				THEN category_has_serviceprovider.idCategory = id_category
                ELSE 1
                END
		AND CASE WHEN id_location IS NOT NULL
				THEN user.idLocation = id_location
                ELSE 1
                END 
		AND CASE WHEN experience IS NOT NULL
				THEN category_has_serviceprovider.experience >= experience
                ELSE 1
                END
		AND CASE WHEN price IS NOT NULL
				THEN (category_has_serviceprovider.price <= price OR category_has_serviceprovider.price IS NULL)
                ELSE 1
                END
		AND CASE WHEN rating IS NOT NULL
				THEN serviceprovider.averageRating >= rating
                ELSE 1
                END
		AND CASE WHEN in_sex IS NOT NULL
				THEN (user.sex = in_sex OR user.sex = 'I')
                ELSE 1
                END
	GROUP BY user.idUser) AS aux;
    

END &&  
DELIMITER ;

-- =============================================
-- Description: Get service providers that meet conditions version 3 (this one uses more than one category)
-- Type: Procedure
-- Parameters:
--   @id_category - category to be searched
--   @id_location - location to be searched
--   @experience - experience to be searched
--   @price - price to be searched
--   @rating - rating to be searched
--   @in_sex - sex to be searched
--   @limite - number of service providers to return
--   @inicio - value for the pagination, represents the page
-- Returns: All service providers that meet conditions, ordered by end date of the vip subscription 
-- =============================================

DELIMITER &&  
CREATE PROCEDURE get_service_providers_v3 (IN categories JSON, IN id_location INT, IN experience INT, IN price DOUBLE, IN rating DOUBLE, IN in_sex VARCHAR(1),IN limite INT, IN inicio INT)  
BEGIN  
	
    DECLARE category1 VARCHAR(20) DEFAULT NULL;
    DECLARE category2 VARCHAR(20) DEFAULT NULL;
    DECLARE category3 VARCHAR(20) DEFAULT NULL;
    DECLARE category4 VARCHAR(20) DEFAULT NULL;
    DECLARE category5 VARCHAR(20) DEFAULT NULL;
    DECLARE category6 VARCHAR(20) DEFAULT NULL;
    
    SET category1 = IF (categories LIKE '%1%', '1',NULL);
    SET category2 = IF (categories LIKE '%2%', '2',NULL);
    SET category3 = IF (categories LIKE '%3%', '3',NULL);
    SET category4 = IF (categories LIKE '%4%', '4',NULL);
    SET category5 = IF (categories LIKE '%5%', '5',NULL);
    SET category6 = IF (categories LIKE '%6%', '6',NULL);
    
    -- @category1 ,@category2,@category3,@category4,@category5,@category6 TESTE
    
    SELECT (SELECT count(*) FROM review WHERE user.idUser = review.idReceive) as nr_reviews,
    user.idUser, user.name,user.lastActivity,user.active,user.sex,serviceprovider.description,location.name AS location, location.cordsX, location.cordsY,serviceprovider.endSubVip, serviceprovider.averageRating,category_has_serviceprovider.experience,category_has_serviceprovider.price ,file.image, category_has_serviceprovider.idCategory FROM user
    INNER JOIN location ON user.idLocation = location.idLocation
    INNER JOIN file ON user.idUser = file.idUser
    INNER JOIN serviceprovider ON user.idUser = serviceprovider.idSP 
	INNER JOIN category_has_serviceprovider ON serviceprovider.idSP = category_has_serviceprovider.idServiceProvider 
	WHERE user.type = 3 AND (serviceprovider.idSubscription != 1 OR user.freeTrial IS NOT NULL) 
		AND CASE WHEN id_location IS NOT NULL
				THEN user.idLocation = id_location
                ELSE 1
                END 
		AND CASE WHEN experience IS NOT NULL
				THEN category_has_serviceprovider.experience >= experience
                ELSE 1
                END
		AND CASE WHEN price IS NOT NULL
				THEN (category_has_serviceprovider.price <= price OR category_has_serviceprovider.price IS NULL)
                ELSE 1
                END
		AND CASE WHEN rating IS NOT NULL
				THEN serviceprovider.averageRating >= rating
                ELSE 1
                END
		AND CASE WHEN in_sex IS NOT NULL
				THEN (user.sex = in_sex OR user.sex = 'I')
                ELSE 1
                END
		AND CASE WHEN category1 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 1) IS NOT NULL THEN 1
				WHEN category1 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 1) IS NULL THEN 0
				ELSE 1
        END
        AND CASE WHEN category2 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 2) IS NOT NULL THEN 1
				WHEN category2 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 2) IS NULL THEN 0
				ELSE 1
        END
        AND CASE WHEN category3 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 3) IS NOT NULL THEN 1
				WHEN category3 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 3) IS NULL THEN 0
				ELSE 1
        END
        AND CASE WHEN category4 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 4) IS NOT NULL THEN 1
				WHEN category4 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 4) IS NULL THEN 0
				ELSE 1
        END
        AND CASE WHEN category5 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 5) IS NOT NULL THEN 1
				WHEN category5 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 5) IS NULL THEN 0
				ELSE 1
        END
        AND CASE WHEN category6 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 6) IS NOT NULL THEN 1
				WHEN category6 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 6) IS NULL THEN 0
				ELSE 1
        END
	GROUP BY user.idUser
    ORDER BY serviceprovider.endSubVip DESC LIMIT limite OFFSET inicio;
END &&  
DELIMITER ;

-- =============================================
-- Description: Insert default profile picture after inserting a new user in user table
-- Type: Trigger
-- Parameters: None
-- Returns: None
-- =============================================

DELIMITER &&  
CREATE TRIGGER default_pic AFTER INSERT ON pi.user
	FOR EACH ROW
    BEGIN
		
        DECLARE last_id_in_user INT DEFAULT 0;
        
		-- Identification of the new user inserted in user
        SET last_id_in_user = NEW.idUser;
		INSERT INTO pi.file(idFile,image,idUser) VALUES (0,x'89504e470d0a1a0a0000000d4948445200000200000002000803000000c3a624c8000002fd504c54450000000000007f7f7f5555557f7f7f6666665555556d6d6d5f5f5f5555556666665c5c5c6a6a6a6262625b5b5b6666665f5f5f5a5a5a6363635d5d5d6666666161615c5c5c6363635f5f5f5b66666262625e5e5e6464646060605d5d5d6262625f5f5f5c64646161615e5e5e6363636060605d5d5d6262625f5f5f5d63636161615e5e5e6262626060605e5e5e6161615f5f5f5d62626060605f5f5f6262626060605e63636161615f5f5f5d62626060605f5f5f6161616060605e62626161615f5f5f5e62626060605f5f5f6161616060605e62626060605f5f5f5e61616060605f62626161616060605e62626060605f5f5f5e61616060605f62626161616060605e61616060605f5f5f6161616060605f62626161615f5f5f5e61616060605f62626161616060605f61616060605f5f5f5f61616060605f62626161616060605f61616060605f5f5f5f61616060605f61616161616060605f61616060605f62625f61616060605f61616060606060605f61616060605f61615f61616060605f61616060606060605f61616060605f61615f61615f61616060606060605f61616060605f61615f60606060605f61616060606061615f61616060605f61615f60606060605f61616060606061615f61616060605f61615f60606060605f61616060606061615f60606060605f61615f60606061615f61616060606061615f60606060605f61616060606061615f61616060605f61615f60606060605f61616060606061615f61616060605f61615f60606061615f61616060606061615f60606060605f61615f60606061615f61616060606061615f60606060605f61615f60606061615f61616060606061615f60606060605f61615f60606061615f60606060606061615f60606061615f61615f60606061615f60606060606061615f60606061615f61615f60606061615f60606060606061615f60606061615f60605f60606061615f60606061616061615f60606061615f60605f60606061615f60606061616061615f60606061615f60605f60606061615f6060606161606161a7c5f5b2000000fe74524e53000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f303132333435363738393a3b3c3d3e3f404142434445464748494a4b4c4d4e4f505152535455565758595a5b5c5d5e5f606162636465666768696a6b6c6d6e6f707172737475767778797a7b7c7d7e7f8081828384858688898a8b8c8d8e8f909192939495969798999a9b9c9d9e9fa0a1a2a3a4a5a6a7a8a9aaabacadaeafb0b1b2b3b4b5b6b7b8b9babbbcbdbebfc0c1c2c3c4c5c6c7c8c9cacbcccdcecfd0d1d2d3d4d5d6d7d8d9dadbdcdddedfe0e1e2e3e4e5e6e7e8e9eaebecedeeeff0f1f2f3f4f5f6f7f8f9fafbfcfdfefa94f2ca000012b8494441547801edc109b45575a106f0efdc09192e970b3c667108440619447100514444247c0e5c875232544a535010c821bbf64cf25986a6e52b72c00cd1b064d42b3d51d242653040051410ee65122e8370e7f3add66a55cb01f6ffbfcfdefbecbdcff97e3f888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888887c495e7187e38f6f5b9c03c922853d47de78ff336f6cd8b187ff56bfa7e2c33f3f75ef75c34e6c0cc9601d4695ceada0a38ab9a5a3da42324eeec07b17eea0a5cd73a6f449403246db92a7f7d0a51db3c7b5836480de3f798fa9a97febae6321b1d661c23bf4e49d09ad2131d5b8646e1d3dab9e5b5200899fb6a5bbe9936da5c59078e93abd8a3eda3fbd33243e06cd4dd267b5b30740e2e1d4d71888b95d21d177ccd34906a4f6f1b690686b39ad9a013a30ad1924baf226ef65c0b67c031255bd96310d161c0d89a2fca9354c8b7d13722091d37739d3e6f51320d19237ad9e69f4d94d9028e9f806d36c4e112432ced9c6b4fbf024483424a6d6330487c642a2a0d54286e4978d20a13bee4386e6ad5690909d54ce10ade90c09d5d07d0c55791f4888aeae65c82a0743423339c9d0555d0209c9ad8c82fa1248286e6634d48c8484e0da0646c4a12190b41b5dcfc838781624cd2eae6384ec3d059256836a98bae447731f9e38faec5eed8b9b024d8bdbf73abb64e2c3f33e4a32753b8e81a451e71d4cd1d6e7c69f5188c32a3c73c2ec72a668455348da345dc154542d9c70020cbaddbaa89aa97821014993c46cba5733f79ae6b05234665e2ddd2b85a4c93d746dddd4b670a1ed84d5742b7905242d2e4ed2a5574724e052e2c2c574e9b3be9034e8b487ae24e7f4454a4efe6392aeac6d02095cce62bab2a03f5276ca22baf20b48e06ea71b1f8c8427e7fd9d2e24474202d6bb9af60e4ecc8347f9530ed15e456b48a01abd477b65c7c3075d16d3de1c48a07e4a6b876e4ec017890955b4f66d4880fad5d3d6aa9ef0cd49ab696b776b4860124b68ebd9a6f051e32769eb5790c05c4d4bf5b7c267931a68a7a13f242085e5b45373397c774915edbc998004e37f69e7c0f908c0907db433061288aed5b4b2fd6404a2ff0e5ad95e0409c29f6865631704a4eb465af93124007d93b4b1b31b02f3b56db4b1af25c47f7fa08d7d272340bd2b69a314e2bb1e0db450330c811a524d0b7b5b40fc368b161a4a10b08beb69e16e88cf4e6ca0855b11b829b4f06921c45f3369e119042f318f16a6427cd5ae9666ab9a200d5a7d42b32db9103fdd41b3aa939016a7d5d26c14c44789f534bb19693295662f417c3494666509a449e2351ad57782f867168d0e7e0d69d3a396463f80f8a675358d26228d1ea0d1a61c885f26d2686d3ed2a8c9261a8d80f865258d2e405a8da6d1ef203ee94aa30548b35769b2ff28883feea449f254a4d99934ba08e28f7769320769b784264f417cd1214993be48bbf369b23307e287b13429430896d1e454881f9ea7c90508c1c534b907e283c41e1aac4b2004890d347803e2831e34998250dc4983ea4610efaea7416d3b84a25d2d0d4e83783783062f21240b69702bc4bbb534b81a21b99606cf413c2b6ea0b3aae608498b1a3afb04e2d9081a2c4468ca68d009e255290d2620341369301ae2d52c1a7445687ad0e02e8857efd2d95684a882ce9e8478b597ce6621442fd0d95288476d68301e21ba8dce76403c1a48833310a28134288278732d9d353443888a9274d61fe2cd7d74b601a1da44675742bc9941672f21540be8ec36883773e86c3a42f5189dfd08e2cdffd3d944846a329d3d0cf166399d8d46a82ea7b399106f36d1d960846a089dcd8378b397ce7a2254bde96c29c4939c063a6b8f5075a4b335104f0a69d002a12aa6b3cd104f9ad2a03142d584ce3e867872140d7211aa5c3a5b0ff1249f06b908552e9dbd0ff12487068d11aa2674b61ae24d92ce8a10aa623a5b05f1a68ece3a20549de86c39c49b2a3aeb8550f5a6b3bf41bc29a7b37310aaa174b600e2cd723a1b8d505d4e674f42bc5948671311aa2974f61388374fd2d9c308d563743611e2cd03743617a15a4867d740bc9944671f21549fd0d930883757d359b210216a91a4b33e106f06d2e04c8468109d259b43bc6941830908d1243afb04e255059dcd4688e6d0d92288576574568e106da3b39f42bcfa390d4e40687ad2e03a8857e3683001a1b99d06a743bc1a44834508cdab3428827855584767d5450849710d9d6d8078f7360dc6202463693003e2dd8334988790bc4c836f41bc1b4583baf60845bb5a1a1c0bf1aea89e0653118abb68b005e2871534589f4008121fd16026c40fd369722142308a263740fc3092268b11822534390ee287467b697232d2ee349abc03f1c73334f923d26e3e4dbe0ff1c725341a80343b3549936e107f343e40934548b3c5345909f1cb7334ba106975058dee86f8e5721aad2f401a156ea55177885f9a54d2680ad2e8a7347a07e29f876874a80bd2a6672d8dc642fcd32d49a3c509a449ceeb34aa6c02f1d1ab349b8034b993663f83f8e9329a55f7415a9c5e4ba36437889ff2b6d26c7553a441eb2d347b15e2af7b6861168297b380162e85f8abf57e5a9884c0dd410befe7427cf6635a68b80201bbb28116ae84f8ad45252dd40e47a0ceada685353910dffd8836f6f747804e39401b2510ff15eda18d5ddd1098af6da78dbfe74002f0435ad9d81501e9ba89562e8504a16827adece88f409cb2935696252081f836ed1c188e009cbb8f561a4e830423f11aedd45c09df5d5a453bbf8404a5771ded344c49c057893b1a6867574b48601ea2adb2b6f051ebf9b43516129cc2adb4b565107c3360236d2dcb8104e80a5aab9b92802f72eea8a3adba7e90403d4b7baff5840f4e7a9df6ee8204ab6823edd54d2f84474d4a6b68eff55c48c006d6d385f231f064d466ba50790c2470a574e5d5b390b2d317d3951248f0f2fe4277960c474a06cca73b3320e9705c255d5af6df09b89418b5842e7dd00c9216c3eae8d627d33ac385f65337d0ad3d2740d2e426ba57b7f0da16b052fced457574ad7628246d1e662a6a5e99d803063d2795d53015df81a44fde22a668db0bb70d2cc261150dbaed0fdb99a28720e954b4861e6c5cf0e8e42b86f4ee585c08141677ec3de4cac98f2ddc440fe6e742d2eaf8ad8c90779a43d2ac6b392363652b48da9d50c18878af352404276e63247cd00e128adebb18011fb68784a4dfa70cdd07ed21a1e9be99217bbb0d2444ed5731548b9b4342d5f2cf0cd113059090e53dc2b0244b2111f030437223247447959425199286b292024898fa3fbe9fa1daf3785f48489addb49611f0e655f990f43b6eda6e46c4f6691d21e975ee8b0d8c90ea274f86a44d62d45f19394b4741d222a7640d236979490212b446dffd9891b5eaaa5c4890724a3e62a4ad2d49400273de2a46deb25190609cf7366361e95910fff5789971919cd519e2afe269358c9143d30a21fec91bb79331533e2e07e293c1ab19436ff681f8a1c5f406c652ddf46610cf466d656c7d7c01c49be31632d6e67684a42e31ee0063aef21a48aadacd650698dd1a92926f563258c93d7b76edd8b3a78ec1aa180971aff50bf45feda6d7674ebb7decc5837b7528c6e7346fd77de0a86fddf63f4f2e5e5f4dfffdba10e2d2e0adf453fdfa17efffe6c08eb9306b3fe0f2d2d9ab6be8a70ffb42dcc8b9bb9e7e39f8fa8357f56d0497f2bb8fbeef95bdf44bd5f720f6da95d11f6b668ceb938794254e1cf38b771be88b175a402c0ddd461f7cf2c4d5ede18396973df6017df0f100888dc4e47a7a55bde0c613e0a34ed73e7f805e555f07313bea297af4d9dc3145f0dd51e74d2fa7478f17400c8e5b494ff6ce38bf0001c919f8f3edf4e48d761047c33ea50775f3ae688c40e55df8ec217ab06500c4c177eb98ba95e3db200d9a5fbb84a9ab2a811c49a29429ab997d1ed2a6dbb43d4c55b21472788d9e65aaca4bdb20ad0ac7ad62aa7e930f398cd64b99a26597e622fdce7d85299adf0cf215c7ae636aca86222427cf6e604a96b7817c498fad4c45c3f3a720445d7f5dcd547cd819f205fd77321565fd10b2a31faf630a2a7a413e67f03ea660e96044c089b393746ff700c87f7cfd10dd5b761e22a2ff22bab77710e45f4654d3b58a7139888ea1abe9dac121907fbaa09a6ed54e6f8e48c99fb0976e1d3c0702607815dd2aeb81c86935bd812e7d763604c3abe8d2d68b104967aea14bfbcf40d61b7a88ee247f5584886a746f2dddd9771ab2dca907e8ce47431161bdfe4a772afb20ab75df4557ea7fd21891963bf1105dd9720cb258a74d7465f3d988bceecbe9cafab6c85aadd7d295e75b22061a4d6ba01b2b5b204b355d4637f68d414c9c5f41375e2d4056ca994337de3e1eb1d17a3eddf82db2d20374e3e9c68891c4d406ba7007b2d058ba503d0e31336237ed25af42d6195c437b9f9c86d8397a19ed559d812cd36d0fed2d6e85186afc3bdadbde1959a5d96ada7ba200b194989aa4b5158d914512cfd15ab214b1757915ad3d8d2c3295d6aabf89183b7327ad7d075963683d6d7d7a2662adeb06daaa3e1d59a2f32eda2aef89986bff1e6d6d6983ac90b794b6367641ec15ff85b61625900d7e445b6b3b2203347d99b626210b9c554f4b6fb7464628789e966a4f47c62bde4c4b6f354786c8fd3d2d6d688e4cf7222dad68898c91ff475a7a0e19ee065a5ad11219a4d17c5aba0a19edd8fdb4f37e5b649482f9b453d909192cb198763e68830cd3e435da790919ec16daa9381619a7f90adab91619ebf803b4b2af1f3250874db4b2b7333254ce1bb452732e32528fddb4b210196a1cad24af41863aed20ad5c898cd46637ad4c46c61a9da48d6d2d908966d2ca4c64b0525a791419e8ec246dbcdb04192cf11c6d349c818c53b09636b67542466bb68a36decb47a6b99336aacf40863b6e176d8c4786697f8036ae47c63bb79e1676b7446679823666210bfc9036a623a3f46ba08575cd910572ca68a1ae2732c9125aa8ea87acd0b68216e623838ca68d71c812c31a6861383246de3a5a780e59e37e5a5899834c71032d54b444d6c87b8716ae408628d8480b97208bf4a9a1d9ba3c648609b4300359e52e5a188b8cd0743bcdb61623abe4fd8d669b1b21137c9f66c961c832ddab68361e19a0c94e9a3d81acf3039a6d2d40fcdd4ab3dd6d90750adea7d9f588bdfccd34bb0159e8ec248d36e422eeaea3d9b21c64a367697639622ef7431ad5f743566a5b49a39509c45b09cda6234b8da7d908c4db5f6954d90a592a6f2d8d5e41acf5a7d9edc85a97d0ac17e26c268d361e85ecf53a8d1e458cfd57158dbe812c36204993832d115ff7d068450eb2d92c1a4d446ce597d36818b25a973a9a6cc8415c5d4aa3b790e59ea2d1f988ab79341a8e2cd7a58e26b31053edea68f24e02d9ee199ad4b4463cdd49a30b91f5bad6d3643ce2e97d9abc9b80fc9e26ef219606d3e83208fad0a83fe2e83734d9980b01fe4c93e988a1fcdd3499080170114db6e5227ebe4e93fd451000890f683204f1339326d321ff349e26bf42ec1cb59706c96e907f2adc4b835df9889b8b69b210f22f8fd06438e2e677342981fc4b3f9acc40cce455d2e0d346907f5b4e831d39889721347908f21fb7d0e474c4cbcf68d207f21f2dab68701fe2651d0d96413e67160d562256bad1e466c8e78ca04967c4c9241a3474807c4ec11e1adc84387985064b205ff05b1abc881829f88c06b740be60040d2a73111f8369d0d011f205f9bb69702ae2a394066f40bee4091a4c457c2ca1c16d902f19498397111b4daa69d00df2258d0fd1d9c146888ba134f818f2152fd36010e2e20734780cf2159368301971318f061741bea2270d5e404c2476d1594d21e4ab36d3593962a20b0d16430ee3ff68d009f170350dee861cc65534b80cf1f0080d86400ea3230d1e403cbc496775cd2087b399ce16231612fbe86c19e4b09ea5b35d88856369f010e4b0be4783f688835134180d39acbe34188e38b893061d218795bb9fce6e471cfc9ece76428e60299d3d8538f83b9d95418ee0513a5b8e18c83944670f428ee03b74762081e83b9a06d7408ee0741ab445f49d4383de902368da40676722faaea7b39a02c891aca3b36b107df7d3d91ac811bd4867f722fa66d3d99f2047f4209d3d83e87b9bce7e0e39a21be9ec2f88be0a3abb057244c3e96c13222fb79ece46428ea80b9dd5241075ed69d01d7244797574d60a5177329d251b438eec633aeb85a81b4909d03044ddf594008d41d4dd4109d0ed88ba072801ba0f51f73825408f20ea665102341351b79012a09710756f5202b40451b79612a09588ba8d9400ad47d4955302b41951b79312a00a445d2525409f22ea3ea304681fa2ae8612a02a445d032540f5883a4aa01075944021ea288142d4510285a8a3040a51470914a28e1228441d2550883a4aa01075944021ea288142d4510285a8a3040a51470914a28e1228441d25501011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111191c0fd034c66f84aabc99a180000000049454e44ae426082',last_id_in_user);
	END &&  
DELIMITER ;


-- =============================================
-- Description: Update average rating of a service provider, after he gets a new review
-- Type: Trigger
-- Parameters: None
-- Returns: None
-- =============================================

DELIMITER &&  
CREATE TRIGGER update_averageRating AFTER INSERT ON pi.review
	FOR EACH ROW
    BEGIN
    
		DECLARE last_id_review INT DEFAULT 0;
        DECLARE get_idReceive INT DEFAULT 0;
        DECLARE new_avg DOUBLE DEFAULT 0.0;
        
		-- Identification of the new review inserted in review
        SET last_id_review = NEW.idReview;
        -- Get the service provider that gets the review
        SET get_idReceive = (SELECT review.idReceive FROM review WHERE review.idReview = last_id_review);
        -- Calculate the new average rating for the service provider with identification = get_idReceive
        SET new_avg = (SELECT AVG(rating) FROM review WHERE review.idReceive = get_idReceive);
        
        UPDATE pi.serviceProvider SET serviceProvider.averageRating = new_avg WHERE serviceProvider.idSP = get_idReceive;
        
	END &&  
DELIMITER ;

-- =============================================
-- Description: Update information of a consumer
-- Type: Procedure
-- Parameters: 
--   @idUser - consumer identification number
--   @in_name - updated name
--   @in_email - updated email
--   @in_location - updated location
--   @in_phoneNumber - updated phone number
-- Returns: None
-- =============================================

DELIMITER &&  
CREATE PROCEDURE update_consumer (IN idUser INT, IN in_name VARCHAR(100), IN in_email VARCHAR(90), IN in_location INT, IN in_phoneNumber VARCHAR(45))  
BEGIN  
	
    SET foreign_key_checks = 0;
	UPDATE pi.user SET
		user.name= CASE 
					WHEN in_name IS NOT NULL 
                    THEN in_name
                    ELSE user.name -- This works because MySQL doesn't update the row, if there is no change, as mentioned in docs
                    END
		, user.email= CASE
					WHEN in_email IS NOT NULL AND (select COUNT(*) = 0 from (
													select * from pi.user where user.email = in_email
												   ) as t)
                    THEN in_email
                    ELSE user.email
					END
		, user.idLocation= CASE
					WHEN in_location IS NOT NULL
                    THEN in_location
                    ELSE user.idLocation
                    END
		, user.phoneNumber= CASE
					WHEN in_phoneNumber IS NOT NULL
                    THEN in_phoneNumber
                    ELSE user.phoneNumber
                    END
		WHERE user.idUser = idUser AND user.type = 2;
        SET foreign_key_checks = 1;
        
        
END &&  
DELIMITER ;

-- =============================================
-- Description: Update user profile picture
-- Type: Procedure
-- Parameters: 
--   @id - user identification number
--   @in_photo - updated profile picture
-- Returns: None
-- =============================================

DELIMITER &&  
CREATE PROCEDURE update_file (IN id INT, IN in_photo MEDIUMBLOB)  
BEGIN  
	
	UPDATE pi.file SET file.image= CASE
					WHEN in_photo IS NOT NULL
                    THEN in_photo
                    ELSE file.image
                    END
		WHERE file.idUser = id;
        
END &&  
DELIMITER ;


-- =============================================
-- Description: Update information of a service provider
-- Type: Procedure
-- Parameters: 
--   @idUser - service provider identification number
--   @in_name - updated name
--   @in_email - updated email
--   @in_location - updated location
--   @in_phoneNumber - updated phone number
--   @in_description - updated description
--   @in_distance - updated distance
--   @in_qualifications - updated qualifications
-- Returns: None
-- =============================================

DELIMITER &&  
CREATE PROCEDURE update_serviceProvider (IN idUser INT, IN in_name VARCHAR(100), IN in_email VARCHAR(90), IN in_location INT, IN in_phoneNumber VARCHAR(45), 
	IN in_description VARCHAR(2000), IN in_distance INT, IN in_qualifications VARCHAR(1000), IN in_solidarity TINYINT)  
BEGIN  
    SET foreign_key_checks = 0;
	UPDATE pi.user INNER JOIN serviceprovider ON user.idUser = serviceprovider.idSP SET
		user.name= CASE 
					WHEN in_name IS NOT NULL 
                    THEN in_name
                    ELSE user.name 
                    END
		, user.email= CASE
					WHEN in_email IS NOT NULL AND (select COUNT(*) = 0 from (
													select * from pi.user where user.email = in_email
												   ) as t)
                    THEN in_email
                    ELSE user.email
					END
		, user.idLocation= CASE
					WHEN in_location IS NOT NULL
                    THEN in_location
                    ELSE user.idLocation
                    END
		, user.phoneNumber= CASE
					WHEN in_phoneNumber IS NOT NULL
                    THEN in_phoneNumber
                    ELSE user.phoneNumber
                    END
		, serviceprovider.description= CASE
					WHEN in_description IS NOT NULL
                    THEN in_description
                    ELSE serviceprovider.description
                    END
		, serviceprovider.distance= CASE
					WHEN in_distance IS NOT NULL
                    THEN in_distance
                    ELSE serviceprovider.distance
                    END
		, serviceprovider.qualifications= CASE
					WHEN in_qualifications IS NOT NULL
                    THEN in_qualifications
                    ELSE serviceprovider.qualifications
                    END
		, serviceprovider.solidarity= CASE
					WHEN in_solidarity IS NOT NULL
                    THEN in_solidarity
                    ELSE serviceprovider.solidarity
                    END
		WHERE user.idUser = idUser AND user.type = 3;
        SET foreign_key_checks = 1;
        
        
END &&  
DELIMITER ;


-- =============================================
-- Description: Update information of a company
-- Type: Procedure
-- Parameters: 
--   @idUser - company identification number
--   @in_name - updated name
--   @in_email - updated email
--   @in_phoneNumber - updated phone number
--   @in_location - updated location
--   @in_link - updated link
--   @in_firm - updated firm
--   @in_nipc - updated nipc
--   @in_description - updated description
-- Returns: None
-- =============================================

DELIMITER &&  
CREATE PROCEDURE update_company (IN idUser INT, IN in_name VARCHAR(100), IN in_email VARCHAR(90),IN in_phoneNumber VARCHAR(45), IN in_location INT, 
	IN in_link VARCHAR(1000), IN in_firm VARCHAR(100), IN in_nipc INT, IN in_description VARCHAR(2000))  
BEGIN  
    SET foreign_key_checks = 0;
	UPDATE pi.user INNER JOIN company ON user.idUser = company.idCompany SET
		user.name= CASE 
					WHEN in_name IS NOT NULL 
                    THEN in_name
                    ELSE user.name 
                    END
		, user.email= CASE
					WHEN in_email IS NOT NULL AND (select COUNT(*) = 0 from (
													select * from pi.user where user.email = in_email
												   ) as t)
                    THEN in_email
                    ELSE user.email
					END
		, user.idLocation= CASE
					WHEN in_location IS NOT NULL
                    THEN in_location
                    ELSE user.idLocation
                    END
		, user.phoneNumber= CASE
					WHEN in_phoneNumber IS NOT NULL
                    THEN in_phoneNumber
                    ELSE user.phoneNumber
                    END
		, company.link= CASE
					WHEN in_link IS NOT NULL
                    THEN in_link
                    ELSE company.link
                    END
		, company.firm= CASE
					WHEN in_firm IS NOT NULL
                    THEN in_firm
                    ELSE company.firm
                    END
		, company.nipc= CASE
					WHEN in_nipc IS NOT NULL
                    THEN in_nipc
                    ELSE company.nipc
                    END
		WHERE user.idUser = idUser AND user.type = 4;
        SET foreign_key_checks = 1;
        
        SET foreign_key_checks = 0;
        
	UPDATE pi.user INNER JOIN pi.add ON user.idUser = pi.add.idCompany SET
		pi.add.description= CASE 
					WHEN in_description IS NOT NULL 
                    THEN in_description
                    ELSE pi.add.description
                    END
		WHERE user.idUser = idUser AND user.type = 4;
        SET foreign_key_checks = 1;
END &&  
DELIMITER ;

-- =============================================
-- Description: Update subscription of a service provider
-- Type: Procedure
-- Parameters: 
--   @id - service provider identification number
--   @in_subscription - updated subscription
		-- 1 - end subscription
        -- 2 - one month subscription without vip
		-- 3 - three months subscription without vip
        -- 4 - six months subscription without vip
        -- 5 - one month subscription with vip
		-- 6 - three months subscription with vip
        -- 7 - six months subscription with vip
-- Returns: None
-- =============================================

DELIMITER &&  
CREATE PROCEDURE update_serviceProvider_endSub (IN id INT, IN in_subscription INT)  
BEGIN  

	SET foreign_key_checks = 0;
	UPDATE pi.serviceprovider SET serviceprovider.endSub= CASE
					WHEN in_subscription = 1 THEN NULL
                    WHEN in_subscription = 2 AND serviceprovider.endSub IS NOT NULL THEN DATE_ADD(serviceprovider.endSub,INTERVAL 1 MONTH)
                    WHEN in_subscription = 3 AND serviceprovider.endSub IS NOT NULL THEN DATE_ADD(serviceprovider.endSub,INTERVAL 3 MONTH)
                    WHEN in_subscription = 4 AND serviceprovider.endSub IS NOT NULL THEN DATE_ADD(serviceprovider.endSub,INTERVAL 6 MONTH)
                    WHEN in_subscription = 5 AND serviceprovider.endSub IS NOT NULL THEN DATE_ADD(serviceprovider.endSub,INTERVAL 1 MONTH)
                    WHEN in_subscription = 6 AND serviceprovider.endSub IS NOT NULL THEN DATE_ADD(serviceprovider.endSub,INTERVAL 3 MONTH)
                    WHEN in_subscription = 7 AND serviceprovider.endSub IS NOT NULL THEN DATE_ADD(serviceprovider.endSub,INTERVAL 6 MONTH)
                    WHEN in_subscription = 2 AND serviceprovider.endSub IS NULL THEN DATE_ADD(now(),INTERVAL 1 MONTH)
                    WHEN in_subscription = 3 AND serviceprovider.endSub IS NULL THEN DATE_ADD(now(),INTERVAL 3 MONTH)
                    WHEN in_subscription = 4 AND serviceprovider.endSub IS NULL THEN DATE_ADD(now(),INTERVAL 6 MONTH)
                    WHEN in_subscription = 5 AND serviceprovider.endSub IS NULL THEN DATE_ADD(now(),INTERVAL 1 MONTH)
                    WHEN in_subscription = 6 AND serviceprovider.endSub IS NULL THEN DATE_ADD(now(),INTERVAL 3 MONTH)
                    WHEN in_subscription = 7 AND serviceprovider.endSub IS NULL THEN DATE_ADD(now(),INTERVAL 6 MONTH)
                    ELSE serviceprovider.endSub
                    END
		, serviceprovider.endSubVip= CASE
					WHEN in_subscription = 1 THEN NULL
                    WHEN in_subscription = 5 AND serviceprovider.endSubVip IS NOT NULL THEN DATE_ADD(serviceprovider.endSubVip,INTERVAL 1 MONTH)
                    WHEN in_subscription = 6 AND serviceprovider.endSubVip IS NOT NULL THEN DATE_ADD(serviceprovider.endSubVip,INTERVAL 3 MONTH)
                    WHEN in_subscription = 7 AND serviceprovider.endSubVip IS NOT NULL THEN DATE_ADD(serviceprovider.endSubVip,INTERVAL 6 MONTH)
                    WHEN in_subscription = 5 AND serviceprovider.endSubVip IS NULL THEN DATE_ADD(now(),INTERVAL 1 MONTH)
                    WHEN in_subscription = 6 AND serviceprovider.endSubVip IS NULL THEN DATE_ADD(now(),INTERVAL 3 MONTH)
                    WHEN in_subscription = 7 AND serviceprovider.endSubVip IS NULL THEN DATE_ADD(now(),INTERVAL 6 MONTH)
                    ELSE serviceprovider.endSubVip
                    END
		, serviceprovider.idSubscription= CASE
					WHEN in_subscription IS NOT NULL AND in_subscription < 8
                    THEN in_subscription
                    ELSE serviceprovider.idSubscription
                    END		
		WHERE serviceprovider.idSP = id;
        
        
        UPDATE pi.user SET user.freeTrial = NULL WHERE user.idUser = id;
        
        SET foreign_key_checks = 1;
        
END &&  
DELIMITER ;

-- =============================================
-- Description: Update subscription of a company
-- Type: Procedure
-- Parameters: 
--   @id - company identification number
--   @in_subscription - updated subscription
		-- 1 - end subscription
        -- 8 - one month subscription without vip
		-- 9 - three months subscription without vip
        -- 10 - six months subscription without vip
        -- 11 - one month subscription with vip
		-- 12 - three months subscription with vip
        -- 13 - six months subscription with vip
-- Returns: None
-- =============================================

DELIMITER &&  
CREATE PROCEDURE update_company_endSub (IN id INT, IN in_subscription INT)  
BEGIN  

	SET foreign_key_checks = 0;
	UPDATE pi.company SET company.endSub= CASE
					WHEN in_subscription = 1 THEN NULL
                    WHEN in_subscription = 8 AND company.endSub IS NOT NULL THEN DATE_ADD(company.endSub,INTERVAL 1 MONTH)
                    WHEN in_subscription = 9 AND company.endSub IS NOT NULL THEN DATE_ADD(company.endSub,INTERVAL 3 MONTH)
                    WHEN in_subscription = 10 AND company.endSub IS NOT NULL THEN DATE_ADD(company.endSub,INTERVAL 6 MONTH)
                    WHEN in_subscription = 11 AND company.endSub IS NOT NULL THEN DATE_ADD(company.endSub,INTERVAL 1 MONTH)
                    WHEN in_subscription = 12 AND company.endSub IS NOT NULL THEN DATE_ADD(company.endSub,INTERVAL 3 MONTH)
                    WHEN in_subscription = 13 AND company.endSub IS NOT NULL THEN DATE_ADD(company.endSub,INTERVAL 6 MONTH)
                    WHEN in_subscription = 8 AND company.endSub IS NULL THEN DATE_ADD(now(),INTERVAL 1 MONTH)
                    WHEN in_subscription = 9 AND company.endSub IS NULL THEN DATE_ADD(now(),INTERVAL 3 MONTH)
                    WHEN in_subscription = 10 AND company.endSub IS NULL THEN DATE_ADD(now(),INTERVAL 6 MONTH)
                    WHEN in_subscription = 11 AND company.endSub IS NULL THEN DATE_ADD(now(),INTERVAL 1 MONTH)
                    WHEN in_subscription = 12 AND company.endSub IS NULL THEN DATE_ADD(now(),INTERVAL 3 MONTH)
                    WHEN in_subscription = 13 AND company.endSub IS NULL THEN DATE_ADD(now(),INTERVAL 6 MONTH)
                    ELSE company.endSub
                    END
		, company.endSubVip= CASE
					WHEN in_subscription = 1 THEN NULL
                    WHEN in_subscription = 11 AND company.endSubVip IS NOT NULL THEN DATE_ADD(company.endSubVip,INTERVAL 1 MONTH)
                    WHEN in_subscription = 12 AND company.endSubVip IS NOT NULL THEN DATE_ADD(company.endSubVip,INTERVAL 3 MONTH)
                    WHEN in_subscription = 13 AND company.endSubVip IS NOT NULL THEN DATE_ADD(company.endSubVip,INTERVAL 6 MONTH)
                    WHEN in_subscription = 11 AND company.endSubVip IS NULL THEN DATE_ADD(now(),INTERVAL 1 MONTH)
                    WHEN in_subscription = 12 AND company.endSubVip IS NULL THEN DATE_ADD(now(),INTERVAL 3 MONTH)
                    WHEN in_subscription = 13 AND company.endSubVip IS NULL THEN DATE_ADD(now(),INTERVAL 6 MONTH)
                    ELSE company.endSubVip
                    END
		, company.idSubscription= CASE
					WHEN in_subscription IS NOT NULL AND ((in_subscription > 7 AND in_subscription < 14) OR in_subscription = 1)
                    THEN in_subscription
                    ELSE company.idSubscription
                    END		
		WHERE company.idCompany = id;
        
        UPDATE pi.user SET user.freeTrial = NULL WHERE user.idUser = id;
        
        SET foreign_key_checks = 1;
        
END &&  
DELIMITER ;

-- =============================================
-- Description: Update information of a job offer
-- Type: Procedure
-- Parameters: 
--   @idJobOffer - job offer identification number
--   @in_description - updated description
--   @in_beginDate - updated begin date
--   @in_price - updated price
--   @in_endDate - updated end date
--   @in_idCategory - updated category
--   @in_idLocation - updated location
-- Returns: None
-- =============================================

DELIMITER &&  
CREATE PROCEDURE update_joboffer (IN idJobOffer INT, IN in_description VARCHAR(2000), IN in_beginDate DATE, IN in_price DOUBLE, IN in_endDate DATE, 
	IN in_idCategory INT, IN in_idLocation INT)  
BEGIN  
    SET foreign_key_checks = 0;
	UPDATE pi.jobOffer SET
		jobOffer.description= CASE 
					WHEN in_description IS NOT NULL 
                    THEN in_description
                    ELSE jobOffer.description 
                    END
		, jobOffer.beginDate= CASE
					WHEN in_beginDate IS NOT NULL AND in_endDate IS NULL AND jobOffer.endDate IS NULL THEN in_beginDate
                    WHEN in_beginDate IS NOT NULL AND in_endDate IS NULL AND jobOffer.endDate IS NOT NULL AND in_beginDate < jobOffer.endDate THEN in_beginDate
                    WHEN in_beginDate IS NOT NULL AND in_endDate IS NOT NULL AND in_beginDate < in_endDate THEN in_beginDate
                    ELSE jobOffer.beginDate 
                    END
		, jobOffer.price= CASE
					WHEN in_price IS NOT NULL
                    THEN in_price
                    ELSE jobOffer.price
                    END
		, jobOffer.endDate= CASE
					WHEN in_endDate IS NOT NULL AND in_beginDate IS NULL AND in_endDate > jobOffer.beginDate THEN in_endDate
                    WHEN in_endDate IS NOT NULL AND in_beginDate IS NOT NULL AND in_beginDate < in_endDate THEN in_endDate
                    ELSE jobOffer.endDate 
                    END
		, jobOffer.idCategory= CASE
					WHEN in_idCategory IS NOT NULL
                    THEN in_idCategory
                    ELSE jobOffer.idCategory
                    END
		, jobOffer.idLocation= CASE
					WHEN in_idLocation IS NOT NULL
                    THEN in_idLocation
                    ELSE jobOffer.idLocation
                    END
		WHERE jobOffer.idJobOffer = idJobOffer;
        SET foreign_key_checks = 1;
        
END &&  
DELIMITER ;


-- =============================================
-- Description: Update vip subscription of a service provider
-- Type: Procedure
-- Parameters: 
--   @id - service provider identification number
--   @in_type - updated vip subscription
		-- 1 - one month of vip
        -- 2 - three months of vip
		-- 3 - six months of vip
        -- 4 - vip the entire subscription time that's left
-- Returns: price to be paid by the service provider
-- =============================================

DELIMITER &&  
CREATE PROCEDURE update_serviceProvider_vip (IN id INT, IN in_type INT)  
BEGIN  
	
    DECLARE last_endSubVip DATETIME DEFAULT NULL;
    DECLARE new_endSubVip DATETIME DEFAULT NULL;
    DECLARE price_per_day DOUBLE DEFAULT 0.07;
    
	-- end date of the vip subscription
	SET last_endSubVip = (SELECT serviceprovider.endSubVip FROM serviceprovider WHERE serviceprovider.idSP = id);
    -- price per day
    SET price_per_day = 0.07;
	SET foreign_key_checks = 0;
    
	UPDATE pi.serviceprovider SET serviceprovider.endSubVip= CASE
					WHEN serviceprovider.endSubVip IS NULL AND in_type = 1 AND DATE_SUB(serviceprovider.endSub,INTERVAL 1 MONTH) >= now() THEN DATE_ADD(now(),INTERVAL 1 MONTH)
                    WHEN serviceprovider.endSubVip IS NULL AND in_type = 2 AND DATE_SUB(serviceprovider.endSub,INTERVAL 3 MONTH) >= now() THEN DATE_ADD(now(),INTERVAL 3 MONTH)
                    WHEN serviceprovider.endSubVip IS NULL AND in_type = 3 AND DATE_SUB(serviceprovider.endSub,INTERVAL 6 MONTH) >= now() THEN DATE_ADD(now(),INTERVAL 6 MONTH)
                    WHEN serviceprovider.endSubVip IS NULL AND in_type = 1 AND DATE_SUB(serviceprovider.endSub,INTERVAL 1 MONTH) < now() THEN serviceprovider.endSub
                    WHEN serviceprovider.endSubVip IS NULL AND in_type = 2 AND DATE_SUB(serviceprovider.endSub,INTERVAL 3 MONTH) < now() THEN serviceprovider.endSub
                    WHEN serviceprovider.endSubVip IS NULL AND in_type = 3 AND DATE_SUB(serviceprovider.endSub,INTERVAL 6 MONTH) < now() THEN serviceprovider.endSub
                    WHEN serviceprovider.endSubVip IS NULL AND in_type = 4  THEN serviceprovider.endSub
                    WHEN serviceprovider.endSubVip IS NOT NULL AND in_type = 1 AND DATE_SUB(serviceprovider.endSub,INTERVAL 1 MONTH) >= now() THEN DATE_ADD(serviceprovider.endSubVip,INTERVAL 1 MONTH)
                    WHEN serviceprovider.endSubVip IS NOT NULL AND in_type = 2 AND DATE_SUB(serviceprovider.endSub,INTERVAL 3 MONTH) >= now() THEN DATE_ADD(serviceprovider.endSubVip,INTERVAL 3 MONTH)
                    WHEN serviceprovider.endSubVip IS NOT NULL AND in_type = 3 AND DATE_SUB(serviceprovider.endSub,INTERVAL 6 MONTH) >= now() THEN DATE_ADD(serviceprovider.endSubVip,INTERVAL 6 MONTH)
                    WHEN serviceprovider.endSubVip IS NOT NULL AND in_type = 1 AND DATE_SUB(serviceprovider.endSub,INTERVAL 1 MONTH) < now() THEN serviceprovider.endSub
                    WHEN serviceprovider.endSubVip IS NOT NULL AND in_type = 2 AND DATE_SUB(serviceprovider.endSub,INTERVAL 3 MONTH) < now() THEN serviceprovider.endSub
                    WHEN serviceprovider.endSubVip IS NOT NULL AND in_type = 3 AND DATE_SUB(serviceprovider.endSub,INTERVAL 6 MONTH) < now() THEN serviceprovider.endSub
                    WHEN serviceprovider.endSubVip IS NOT NULL AND in_type = 4  THEN serviceprovider.endSub
                    ELSE serviceprovider.endSubVip
                    END
		WHERE serviceprovider.idSP = id;
        SET foreign_key_checks = 1;
        
        -- new end date of the vip subscription
        SET new_endSubVip = (SELECT serviceprovider.endSubVip FROM serviceprovider WHERE serviceprovider.idSP = id);
        
        IF last_endSubVip IS NULL THEN SELECT DATEDIFF(new_endSubVip,now())*price_per_day;
        ELSE SELECT DATEDIFF(new_endSubVip,last_endSubVip)*price_per_day;
        END IF;
	
END &&  
DELIMITER ;


-- =============================================
-- Description: Update vip subscription of a company
-- Type: Procedure
-- Parameters: 
--   @id - company identification number
--   @in_type - updated vip subscription
		-- 1 - one month of vip
        -- 2 - three months of vip
		-- 3 - six months of vip
        -- 4 - vip the entire subscription time that's left
-- Returns: price to be paid by the company
-- =============================================

DELIMITER &&  
CREATE PROCEDURE update_company_vip (IN id INT, IN in_type INT)  
BEGIN  

	DECLARE last_endSubVip DATETIME DEFAULT NULL;
    DECLARE new_endSubVip DATETIME DEFAULT NULL;
    DECLARE price_per_day DOUBLE DEFAULT 0.12;
    
	-- end date of the vip subscription
	SET last_endSubVip = (SELECT company.endSubVip FROM company WHERE company.idCompany = id);
    -- price per day
    SET price_per_day = 0.12;
	SET foreign_key_checks = 0;
    
	UPDATE pi.company SET company.endSubVip= CASE
					WHEN company.endSubVip IS NULL AND in_type = 1 AND DATE_SUB(company.endSub,INTERVAL 1 MONTH) >= now() THEN DATE_ADD(now(),INTERVAL 1 MONTH)
                    WHEN company.endSubVip IS NULL AND in_type = 2 AND DATE_SUB(company.endSub,INTERVAL 3 MONTH) >= now() THEN DATE_ADD(now(),INTERVAL 3 MONTH)
                    WHEN company.endSubVip IS NULL AND in_type = 3 AND DATE_SUB(company.endSub,INTERVAL 6 MONTH) >= now() THEN DATE_ADD(now(),INTERVAL 6 MONTH)
                    WHEN company.endSubVip IS NULL AND in_type = 1 AND DATE_SUB(company.endSub,INTERVAL 1 MONTH) < now() THEN company.endSub
                    WHEN company.endSubVip IS NULL AND in_type = 2 AND DATE_SUB(company.endSub,INTERVAL 3 MONTH) < now() THEN company.endSub
                    WHEN company.endSubVip IS NULL AND in_type = 3 AND DATE_SUB(company.endSub,INTERVAL 6 MONTH) < now() THEN company.endSub
                    WHEN company.endSubVip IS NULL AND in_type = 4  THEN company.endSub
                    WHEN company.endSubVip IS NOT NULL AND in_type = 1 AND DATE_SUB(company.endSub,INTERVAL 1 MONTH) >= now() THEN DATE_ADD(company.endSubVip,INTERVAL 1 MONTH)
                    WHEN company.endSubVip IS NOT NULL AND in_type = 2 AND DATE_SUB(company.endSub,INTERVAL 3 MONTH) >= now() THEN DATE_ADD(company.endSubVip,INTERVAL 3 MONTH)
                    WHEN company.endSubVip IS NOT NULL AND in_type = 3 AND DATE_SUB(company.endSub,INTERVAL 6 MONTH) >= now() THEN DATE_ADD(company.endSubVip,INTERVAL 6 MONTH)
                    WHEN company.endSubVip IS NOT NULL AND in_type = 1 AND DATE_SUB(company.endSub,INTERVAL 1 MONTH) < now() THEN company.endSub
                    WHEN company.endSubVip IS NOT NULL AND in_type = 2 AND DATE_SUB(company.endSub,INTERVAL 3 MONTH) < now() THEN company.endSub
                    WHEN company.endSubVip IS NOT NULL AND in_type = 3 AND DATE_SUB(company.endSub,INTERVAL 6 MONTH) < now() THEN company.endSub
                    WHEN company.endSubVip IS NOT NULL AND in_type = 4  THEN company.endSub
                    ELSE company.endSubVip
                    END
		WHERE company.idCompany = id;
        SET foreign_key_checks = 1;
        
        -- new end date of the vip subscription
        SET new_endSubVip = (SELECT company.endSubVip FROM company WHERE company.idCompany = id);
        
        IF last_endSubVip IS NULL THEN SELECT DATEDIFF(new_endSubVip,now())*price_per_day;
        ELSE SELECT DATEDIFF(new_endSubVip,last_endSubVip)*price_per_day;
        END IF;
	
END &&  
DELIMITER ;


-- =============================================
-- Description: Update last activity date of a user
-- Type: Procedure
-- Parameters: 
--   @in_idUser - user identification number
-- Returns: None
-- =============================================

DELIMITER &&  
CREATE PROCEDURE update_last_activity (IN in_idUser INT)  
BEGIN  
	
	UPDATE pi.user SET user.lastActivity = now() WHERE user.idUser = in_idUser;
        
END &&  
DELIMITER ;


-- =============================================
-- Description: Update average rating of a user
-- Type: Procedure
-- Parameters: 
--   @in_idUser - user identification number
-- Returns: None
-- =============================================

DELIMITER &&  
CREATE PROCEDURE update_averageRating (IN in_idUser INT)  
BEGIN  
	
    DECLARE new_avg DOUBLE DEFAULT 0.0;
    
	-- new average rating
	SET new_avg = (SELECT AVG(rating) FROM review WHERE review.idReceive = in_idUser);
    IF new_avg IS NOT NULL THEN
			UPDATE pi.serviceprovider SET serviceprovider.averageRating = new_avg WHERE serviceprovider.idSP = in_idUser;
	END IF;
    
END &&  
DELIMITER ;

-- =============================================
-- Description: Get all the users that a specific user has messages with
-- Type: Procedure
-- Parameters: 
--   @in_idUser - user identification number
-- Returns: identification number, name and profile picture of each user that @in_idUser has messages with
-- =============================================

DELIMITER &&  
CREATE PROCEDURE user_messages_with (IN in_idUser INT)  
BEGIN  
	
	SELECT user.idUser, user.name, file.image FROM message
    INNER JOIN user ON message.idReceive = user.idUser
    INNER JOIN file ON message.idReceive = file.idUser
    WHERE message.idGive = in_idUser
    UNION
    SELECT user.idUser, user.name, file.image FROM message
    INNER JOIN user ON message.idGive = user.idUser
	INNER JOIN file ON message.idGive = file.idUser
    WHERE message.idReceive = in_idUser
    GROUP BY user.idUser;
    
END &&  
DELIMITER ;

-- =============================================
-- Description: Get all the user messages with someone
-- Type: Procedure
-- Parameters: 
--   @in_idUser - user one identification number
--   @in_idUser2 - user two identification number
-- Returns: All the user messages with someone
-- =============================================

DELIMITER &&  
CREATE PROCEDURE all_messages_with (IN in_idUser INT, IN in_idUser2 INT)  
BEGIN  
	
	SELECT message.date, message.content, message.idGive, message.idReceive FROM message
    WHERE (message.idGive = in_idUser AND message.idReceive = in_idUser2) OR (message.idGive = in_idUser2 AND message.idReceive = in_idUser)
    ORDER BY message.date ASC;
    
END &&  
DELIMITER ;

-- =============================================
-- Description: Insert message
-- Type: Procedure
-- Parameters:
--   @in_content - content of the message
--   @in_idGive - person that gives the review
--   @in_idReceive - person that gets the review
-- Returns: Nothing
-- =============================================

DELIMITER &&  
CREATE PROCEDURE createMessage (IN in_content VARCHAR(200), IN in_idGive INT, IN in_idReceive INT)  
BEGIN  

	INSERT INTO message (idMessage, date, content, idGive, idReceive)
    VALUES (0, now(), in_content, in_idGive, in_idReceive);
        
END &&  
DELIMITER ;

-- =============================================
-- Description: Add a new occupied slot
-- Type: Procedure
-- Parameters: 
--   @in_idUser - service provider identification number
--   @in_slot - slot to be added
-- Returns: None
-- =============================================

DELIMITER &&  
CREATE PROCEDURE add_slot (IN in_idUser INT, IN in_slot JSON)  
BEGIN  
	
    DECLARE os JSON DEFAULT '[]';
    -- get the occupied schedule
    SET os = (SELECT serviceprovider.occupiedSchedule FROM serviceprovider 
			WHERE serviceprovider.idSP = in_idUser );
    SET os = IF (os IS NULL, '[]', os);
    
	UPDATE pi.serviceprovider SET
		serviceprovider.occupiedSchedule= CASE 
					WHEN in_slot IS NOT NULL AND os IS NOT NULL
                    THEN JSON_MERGE_PRESERVE(os,in_slot)
                    ELSE serviceprovider.occupiedSchedule
                    END
	WHERE serviceprovider.idSP = in_idUser;
END &&  
DELIMITER ;

-- =============================================
-- Description: Remove a work slot
-- Type: Procedure
-- Parameters: 
--   @in_idUser - service provider identification number
--   @in_slot - slot to be removed
-- Returns: None
-- =============================================

DELIMITER &&  
CREATE PROCEDURE remove_workSchedule_slot (IN in_idUser INT, IN in_slot JSON)  
BEGIN  
	
    DECLARE os JSON DEFAULT '[]';
    DECLARE new_os JSON DEFAULT '[]';
    
    -- get the work schedule
    SET os = (SELECT serviceprovider.workSchedule FROM serviceprovider 
			WHERE serviceprovider.idSP = in_idUser );
	
    SET os = IF (os IS NULL, '[]', os);
    
	SET new_os = (select json_arrayagg(j1) from json_table(os, '$[*]' columns ( j1 json path '$')) as jt 
		where json_extract(j1, '$.date_end') <> json_extract(in_slot, '$.date_end') and json_extract(j1, '$.date_begin') <> json_extract(in_slot, '$.date_begin'));

	-- SELECT os,new_os;
    
	UPDATE pi.serviceprovider SET
		serviceprovider.workSchedule= CASE 
					WHEN in_slot IS NOT NULL AND os IS NOT NULL AND new_os IS NOT NULL
                    THEN new_os
                    ELSE serviceprovider.workSchedule
                    END
	WHERE serviceprovider.idSP = in_idUser;
END &&  
DELIMITER ;

-- =============================================
-- Description: Add a new workschedule slot
-- Type: Procedure
-- Parameters: 
--   @in_idUser - service provider identification number
--   @in_slot - slot to be added
-- Returns: None
-- =============================================

DELIMITER &&  
CREATE PROCEDURE add_workSchedule_slot (IN in_idUser INT,IN in_slot JSON)  
BEGIN  
	
    DECLARE os JSON DEFAULT '[]';
    DECLARE can_add TINYINT DEFAULT 1;
    
    -- get the workSchedule schedule
    SET os =  (SELECT serviceprovider.workSchedule FROM serviceprovider 
			WHERE serviceprovider.idSP = in_idUser);
    
    SET os = IF (os IS NULL, '[]', os);
    
    -- CASO 1: slot no meio
    -- CASO 2: abaixo do begin e meio
    -- CASO 3: meio e acima do end
    -- CASO 4: abaixo do begin e acima do end
    SET can_add = (select IF (COUNT(*) > 0, 0, 1) from json_table(os, '$[*]' columns ( j1 json path '$')) as jt 
		where  (json_extract(j1, '$.date_begin') <= json_extract(in_slot, '$.date_begin') AND json_extract(j1, '$.date_end') >= json_extract(in_slot, '$.date_end')) OR
        (json_extract(j1, '$.date_begin') > json_extract(in_slot, '$.date_begin') AND json_extract(j1, '$.date_begin') < json_extract(in_slot, '$.date_end')) OR
        (json_extract(j1, '$.date_end') > json_extract(in_slot, '$.date_begin') AND json_extract(j1, '$.date_end') < json_extract(in_slot, '$.date_end')) OR
        (json_extract(j1, '$.date_begin') > json_extract(in_slot, '$.date_begin') AND json_extract(j1, '$.date_end') < json_extract(in_slot, '$.date_end')));
	SELECT can_add;
    
	UPDATE pi.serviceprovider SET
		serviceprovider.workSchedule= CASE 
					WHEN in_slot IS NOT NULL AND os IS NOT NULL AND can_add = 1
                    THEN JSON_MERGE_PRESERVE(os,in_slot)
                    ELSE serviceprovider.workSchedule
                    END
	WHERE serviceprovider.idSP = in_idUser;
END &&  
DELIMITER ;

-- =============================================
-- Description: Insert a new category for a certain Service Provider
-- Type: Procedure
-- Parameters:
--   @in_idUser - Identification number of the Service Provider in question
--   @in_idCat - Identification number of the Category to be added
--   @in_exp - Amount of years of experience the Service Provider has in the Category
-- Returns: Nothing
-- =============================================

DELIMITER &&
CREATE PROCEDURE insert_categorias (IN in_idUser INT, IN in_idCat INT, IN in_exp INT, IN in_price DOUBLE)
BEGIN

	INSERT INTO category_has_serviceprovider (price, experience, idCategory, idServiceProvider)
    VALUES (in_price, in_exp, in_idCat, in_idUser);

END &&
DELIMITER ;

-- =============================================
-- Description: Remove an occupied slot
-- Type: Procedure
-- Parameters: 
--   @in_idUser - service provider identification number
--   @in_slot - slot to be removed
-- Returns: None
-- =============================================

DELIMITER &&  
CREATE PROCEDURE remove_slot (IN in_idUser INT, IN in_slot JSON)  
BEGIN  
	
    DECLARE os JSON DEFAULT '[]';
    DECLARE new_os JSON DEFAULT '[]';
    
    -- get the work schedule
    SET os = (SELECT serviceprovider.occupiedSchedule FROM serviceprovider 
			WHERE serviceprovider.idSP = in_idUser );
            
	SET os = IF (os IS NULL, '[]', os);
    
	SET new_os = (
select json_pretty(json_arrayagg(os.js)) as new_os
from json_table(os, '$[*]' columns (js json path '$')) as os
where not exists (
  select 1
  from json_table(in_slot, '$' columns ( js json path '$')) as tst
  where json_extract(os.js, '$.id') = json_extract(tst.js, '$.id')
    and json_extract(os.js, '$.date_end') = json_extract(tst.js, '$.date_end')
    and json_extract(os.js, '$.date_begin') = json_extract(tst.js, '$.date_begin')
    and json_extract(os.js, '$.date_requested') = json_extract(tst.js, '$.date_requested')
    and json_extract(os.js, '$.idCategory') = json_extract(tst.js, '$.idCategory')
    and json_extract(os.js, '$.occupied') = json_extract(tst.js, '$.occupied')
));

	SELECT os,new_os;
    
	UPDATE pi.serviceprovider SET
		serviceprovider.occupiedSchedule= CASE 
					WHEN in_slot IS NOT NULL AND os IS NOT NULL AND new_os IS NOT NULL
                    THEN new_os
                    ELSE serviceprovider.occupiedSchedule
                    END
	WHERE serviceprovider.idSP = in_idUser;
END &&  

-- Description: Get a list of service providers that meet the conditions
-- Type: Procedure
-- Parameters:
--   @in_name - name of the service provider to search for
--   @limite - number of service providers to return
--   @inicio - value for the pagination, represents the page
-- Returns: A list of service providers where max_length = @limite
-- =============================================

DELIMITER &&
CREATE PROCEDURE get_service_provider_by_name (IN in_name VARCHAR(100), IN limite INT, IN inicio INT)
BEGIN

	SELECT (SELECT count(*) FROM review WHERE user.idUser = review.idReceive) as nr_reviews ,
		user.idUser, user.name,user.lastActivity,user.active,user.sex,serviceprovider.description,location.name AS location, location.cordsX, location.cordsY,serviceprovider.endSubVip, serviceprovider.averageRating,category_has_serviceprovider.experience,category_has_serviceprovider.price ,file.image FROM user
    INNER JOIN location ON user.idLocation = location.idLocation
    INNER JOIN file ON user.idUser = file.idUser
    INNER JOIN serviceprovider ON user.idUser = serviceprovider.idSP 
	INNER JOIN category_has_serviceprovider ON serviceprovider.idSP = category_has_serviceprovider.idServiceProvider 
	WHERE user.type = 3 AND (serviceprovider.idSubscription != 1 OR user.freeTrial IS NOT NULL) AND user.name LIKE Concat('%',in_name,'%')
	GROUP BY user.idUser
    ORDER BY serviceprovider.endSubVip DESC LIMIT limite OFFSET inicio;

END &&
DELIMITER ;

-- =============================================
-- Description: Get a list of companies that meet the conditions
-- Type: Procedure
-- Parameters:
--   @in_name - name of the company to search for
--   @limite - number of companies to return
--   @inicio - value for the pagination, represents the page
-- Returns: A list of companies where max_length = @limite
-- =============================================

DELIMITER &&
CREATE PROCEDURE get_companies_by_name (IN in_name VARCHAR(100), IN limite INT, IN inicio INT)
BEGIN

	SELECT user.idUser, user.name,company.link,company.firm,company.nipc,PI.add.description,location.name AS location,location.cordsX, location.cordsY, file.image FROM user
    INNER JOIN company ON user.idUser = company.idCompany 
    INNER JOIN PI.add ON user.idUser = PI.add.idCompany
    INNER JOIN location ON user.idLocation = location.idLocation
    INNER JOIN file ON user.idUser = file.idUser 
    WHERE user.type = 4 AND (company.idSubscription != 1 OR user.freeTrial IS NOT NULL) AND user.name LIKE Concat('%',in_name,'%')
    ORDER BY company.endSubVip DESC LIMIT limite OFFSET inicio;

END &&
DELIMITER ;

-- =============================================
-- Description: Get the number of service providers that meet the conditions
-- Type: Procedure
-- Parameters:
--   @in_name - name of the company to search for
-- Returns: The number of service providers that meet the conditions
-- =============================================

DELIMITER &&
CREATE PROCEDURE get_service_provider_by_name_count (IN in_name VARCHAR(100))
BEGIN

	SELECT COUNT(*) AS number_sps FROM ( 
		SELECT user.idUser FROM user
		INNER JOIN serviceprovider ON user.idUser = serviceprovider.idSP 
		WHERE user.type = 3 AND (serviceprovider.idSubscription != 1 OR user.freeTrial IS NOT NULL) AND user.name LIKE Concat('%',in_name,'%')
		GROUP BY user.idUser
    ) AS aux;

END &&
DELIMITER ;

-- =============================================
-- Description: Get the number of companies that meet the conditions
-- Type: Procedure
-- Parameters:
--   @in_name - name of the company to search for
-- Returns: The number of companies that meet the conditions
-- =============================================

DELIMITER &&
CREATE PROCEDURE get_companies_by_name_count (IN in_name VARCHAR(100))
BEGIN

	SELECT COUNT(*) AS number_cps FROM ( 
		SELECT user.idUser FROM user
        INNER JOIN company ON user.idUser = company.idCompany 
		WHERE user.type = 4 AND (company.idSubscription != 1 OR user.freeTrial IS NOT NULL) AND user.name LIKE Concat('%',in_name,'%')
		GROUP BY user.idUser 
	) AS aux;

END &&
DELIMITER ;


-- =============================================
-- Description: Get number of service providers that meet conditions version 3 (this one uses more than one category)
-- Type: Procedure
-- Parameters:
--   @id_category - category to be searched
--   @id_location - location to be searched
--   @experience - experience to be searched
--   @price - price to be searched
--   @rating - rating to be searched
--   @in_sex - sex to be searched
-- Returns: Number of service providers that meet conditions
-- =============================================

DELIMITER &&  
CREATE PROCEDURE get_service_providers_v3_count (IN categories JSON, IN id_location INT, IN experience INT, IN price DOUBLE, IN rating DOUBLE, IN in_sex VARCHAR(1))  
BEGIN  
	
    DECLARE category1 VARCHAR(20) DEFAULT NULL;
    DECLARE category2 VARCHAR(20) DEFAULT NULL;
    DECLARE category3 VARCHAR(20) DEFAULT NULL;
    DECLARE category4 VARCHAR(20) DEFAULT NULL;
    DECLARE category5 VARCHAR(20) DEFAULT NULL;
    DECLARE category6 VARCHAR(20) DEFAULT NULL;
    
    SET category1 = IF (categories LIKE '%1%', '1',NULL);
    SET category2 = IF (categories LIKE '%2%', '2',NULL);
    SET category3 = IF (categories LIKE '%3%', '3',NULL);
    SET category4 = IF (categories LIKE '%4%', '4',NULL);
    SET category5 = IF (categories LIKE '%5%', '5',NULL);
    SET category6 = IF (categories LIKE '%6%', '6',NULL);
    
    -- @category1 ,@category2,@category3,@category4,@category5,@category6 TESTE
    
    SELECT COUNT(*) AS number_sps FROM (SELECT user.idUser FROM user
    INNER JOIN location ON user.idLocation = location.idLocation
    INNER JOIN file ON user.idUser = file.idUser
    INNER JOIN serviceprovider ON user.idUser = serviceprovider.idSP 
	INNER JOIN category_has_serviceprovider ON serviceprovider.idSP = category_has_serviceprovider.idServiceProvider 
	WHERE user.type = 3 AND (serviceprovider.idSubscription != 1 OR user.freeTrial IS NOT NULL) 
		AND CASE WHEN id_location IS NOT NULL
				THEN user.idLocation = id_location
                ELSE 1
                END 
		AND CASE WHEN experience IS NOT NULL
				THEN category_has_serviceprovider.experience >= experience
                ELSE 1
                END
		AND CASE WHEN price IS NOT NULL
				THEN (category_has_serviceprovider.price <= price OR category_has_serviceprovider.price IS NULL)
                ELSE 1
                END
		AND CASE WHEN rating IS NOT NULL
				THEN serviceprovider.averageRating >= rating
                ELSE 1
                END
		AND CASE WHEN in_sex IS NOT NULL
				THEN (user.sex = in_sex OR user.sex = 'I')
                ELSE 1
                END
		AND CASE WHEN category1 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 1) IS NOT NULL THEN 1
				WHEN category1 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 1) IS NULL THEN 0
				ELSE 1
        END
        AND CASE WHEN category2 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 2) IS NOT NULL THEN 1
				WHEN category2 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 2) IS NULL THEN 0
				ELSE 1
        END
        AND CASE WHEN category3 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 3) IS NOT NULL THEN 1
				WHEN category3 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 3) IS NULL THEN 0
				ELSE 1
        END
        AND CASE WHEN category4 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 4) IS NOT NULL THEN 1
				WHEN category4 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 4) IS NULL THEN 0
				ELSE 1
        END
        AND CASE WHEN category5 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 5) IS NOT NULL THEN 1
				WHEN category5 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 5) IS NULL THEN 0
				ELSE 1
        END
        AND CASE WHEN category6 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 6) IS NOT NULL THEN 1
				WHEN category6 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 6) IS NULL THEN 0
				ELSE 1
        END
	GROUP BY user.idUser) AS aux;
END &&  
DELIMITER ;

-- =============================================
-- Description: get information about a requested slot
-- Type: Procedure
-- Parameters: 
--   @in_idUser - service provider identification number
-- Returns: Information about the request slot
-- =============================================

DELIMITER &&  
CREATE PROCEDURE info_requested_slots (IN in_idUser INT)  
BEGIN  
	
    DECLARE os JSON DEFAULT '[]';

    -- get the occupied schedule
    SET os = (SELECT serviceprovider.occupiedSchedule FROM serviceprovider 
			WHERE serviceprovider.idSP = in_idUser );
	
    SET os = IF (os IS NULL, '[]', os);

	select CAST(json_extract(j1, '$.id') AS UNSIGNED) AS id, user.name, json_extract(j1, '$.date_begin') AS date_begin, json_extract(j1, '$.date_end') AS date_end, 
		CAST(REPLACE(json_extract(j1, '$.idCategory'),'"','') AS JSON) AS categories, json_extract(j1, '$.date_requested') AS date_requested, IF ( LENGTH(json_extract(j1, '$.idCategory')) <= 5, CAST(CONCAT('[',
         IF (json_extract(j1, '$.idCategory') LIKE '%1%', '"Apoio externo"',''),IF (json_extract(j1, '$.idCategory') LIKE '%2%', '"Cuidados de higiene e conforto pessoal"',''),
         IF (json_extract(j1, '$.idCategory') LIKE '%3%', '"Cuidados de lazer"',''),IF (json_extract(j1, '$.idCategory') LIKE '%4%', '"Cuidados médicos"',''),
         IF (json_extract(j1, '$.idCategory') LIKE '%5%', '"Fornecimento e apoio nas refeições"','') ,IF (json_extract(j1, '$.idCategory') LIKE '%6%', '"Higiene habitacional"',''),']') AS JSON),
          CAST(CONCAT('[',
         IF (json_extract(j1, '$.idCategory') LIKE '%1%', '"Apoio externo"',''),IF (json_extract(j1, '$.idCategory') LIKE '%2%', ',"Cuidados de higiene e conforto pessoal"',''),
         IF (json_extract(j1, '$.idCategory') LIKE '%3%', ',"Cuidados de lazer"',''),IF (json_extract(j1, '$.idCategory') LIKE '%4%', ',"Cuidados médicos"',''),
         IF (json_extract(j1, '$.idCategory') LIKE '%5%', ',"Fornecimento e apoio nas refeições"','') ,IF (json_extract(j1, '$.idCategory') LIKE '%6%', ',"Higiene habitacional"',''),']') AS JSON)) AS array_categories from json_table(os, '$[*]' columns ( j1 json path '$')) as jt 
		inner join user ON CAST(json_extract(j1, '$.id') AS UNSIGNED) = user.idUser
		where CAST(json_extract(j1, '$.occupied') AS UNSIGNED) = 0;

	
END &&  
DELIMITER ;

-- =============================================
-- Description: get information about a requested slot v2
-- Type: Procedure
-- Parameters: 
--   @in_idUser - service provider identification number
-- Returns: Information about the request slot
-- =============================================

DELIMITER &&  
CREATE PROCEDURE info_requested_slots_v2 (IN in_idUser INT)  
BEGIN  
	
    DECLARE os JSON DEFAULT '[]';

    -- get the occupied schedule
    SET os = (SELECT serviceprovider.occupiedSchedule FROM serviceprovider 
			WHERE serviceprovider.idSP = in_idUser );
	
    SET os = IF (os IS NULL, '[]', os);
    
	select CAST(json_extract(j1, '$.id') AS UNSIGNED) AS id, user.name, j1 from json_table(os, '$[*]' columns ( j1 json path '$')) as jt 
		inner join user ON CAST(json_extract(j1, '$.id') AS UNSIGNED) = user.idUser
		where CAST(json_extract(j1, '$.occupied') AS UNSIGNED) = 0;

	
END &&  
DELIMITER ;

-- =============================================
-- Description: remove category from service provider
-- Type: Procedure
-- Parameters: 
--   @in_idUser - service provider identification number
--   @in_idCategoria - category to be removed 
-- Return: Nothing
-- =============================================

DELIMITER &&
CREATE PROCEDURE remove_categoria (IN in_idUser INT, IN in_idCategoria INT)
BEGIN

	DELETE FROM category_has_serviceprovider WHERE (category_has_serviceprovider.idServiceProvider = in_idUser AND category_has_serviceprovider.idCategory = in_idCategoria);

END &&
DELIMITER ;

-- =============================================
-- Description: Verify if service provider can accept 
-- Type: Procedure
-- Parameters: 
--   @in_idUser - service provider identification number
--   @in_slot - slot to be verified
-- Returns: None
-- =============================================

DELIMITER &&  
CREATE PROCEDURE verify_slot (IN in_idUser INT,IN in_slot JSON)  
BEGIN  
	
    DECLARE os JSON DEFAULT '[]';
    DECLARE can_accept TINYINT DEFAULT 1;
    
    -- get the occupiedSchedule schedule
    SET os =  (SELECT serviceprovider.occupiedSchedule FROM serviceprovider 
			WHERE serviceprovider.idSP = in_idUser);
    
    SET os = IF (os IS NULL, '[]', os);
    
    -- CASO 1: slot no meio
    -- CASO 2: abaixo do begin e meio
    -- CASO 3: meio e acima do end
    -- CASO 4: abaixo do begin e acima do end
    SET can_accept = (select IF (COUNT(*) > 0, 0, 1) from json_table(os, '$[*]' columns ( j1 json path '$')) as jt 
		where CAST(json_extract(j1, '$.occupied') AS UNSIGNED) = 1 AND (json_extract(j1, '$.date_begin') <= json_extract(in_slot, '$.date_begin') AND json_extract(j1, '$.date_end') >= json_extract(in_slot, '$.date_end')) OR
        (json_extract(j1, '$.date_begin') > json_extract(in_slot, '$.date_begin') AND json_extract(j1, '$.date_begin') < json_extract(in_slot, '$.date_end')) OR
        (json_extract(j1, '$.date_end') > json_extract(in_slot, '$.date_begin') AND json_extract(j1, '$.date_end') < json_extract(in_slot, '$.date_end')) OR
        (json_extract(j1, '$.date_begin') > json_extract(in_slot, '$.date_begin') AND json_extract(j1, '$.date_end') < json_extract(in_slot, '$.date_end')));
	
    SELECT can_accept;
    
END &&  
DELIMITER ;


-- =============================================
-- Description: Verify if slot requested belongs to the service provider schedule
-- Type: Procedure
-- Parameters: 
--   @in_idUser - service provider identification number
--   @in_slot - slot to be verified
-- Returns: None
-- =============================================

DELIMITER &&  
CREATE PROCEDURE verify_ws (IN in_idUser INT,IN in_slot JSON)  
BEGIN  
	
    DECLARE os JSON DEFAULT '[]';
    DECLARE can_be_requested TINYINT DEFAULT 0;
    
    -- get the workSchedule schedule
    SET os =  (SELECT serviceprovider.workSchedule FROM serviceprovider 
			WHERE serviceprovider.idSP = in_idUser);
    
    SET os = IF (os IS NULL, '[]', os);
    
    SET can_be_requested = (select IF (COUNT(*) > 0, 1, 0) from json_table(os, '$[*]' columns ( j1 json path '$')) as jt 
		where (json_extract(j1, '$.date_begin') <= json_extract(in_slot, '$.date_begin') AND json_extract(j1, '$.date_end') >= json_extract(in_slot, '$.date_end')));
	
    SELECT can_be_requested;
    
END &&  
DELIMITER ;