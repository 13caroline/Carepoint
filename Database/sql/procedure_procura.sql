USE PI;

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

-- Returns: get max values
DELIMITER &&  
CREATE PROCEDURE get_max_values ()  
BEGIN  

	SET @price = (SELECT MAX(category_has_serviceprovider.price) FROM serviceprovider
		INNER JOIN category_has_serviceprovider ON serviceprovider.idSP = category_has_serviceprovider.idServiceProvider);
        
	SET @distance = (SELECT MAX(serviceprovider.distance) FROM serviceprovider);
    
    SET @rating = (SELECT MAX(serviceprovider.averageRating) FROM serviceprovider);
    
    SELECT @price as price, @distance as distance, @rating as rating;
    
END &&  
DELIMITER ;

    
-- Returns: get all locations
CREATE VIEW get_locations 
AS  
    SELECT location.idLocation, location.name FROM location;
    
-- Returns: get all categories
CREATE VIEW get_categories
AS  
    SELECT category.idCategory, category.name FROM category;


-- Returns: get all job offers for given consumer
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

-- Returns: service providers
DELIMITER &&  
CREATE PROCEDURE get_service_providers (IN id_category INT, IN id_location INT, IN experience INT, IN price DOUBLE, IN rating DOUBLE, IN in_sex VARCHAR(1),IN limite INT, IN inicio INT)  
BEGIN  

    SELECT user.idUser, user.name,user.lastActivity,user.active,user.sex,serviceprovider.description,location.name AS location, location.cordsX, location.cordsY,serviceprovider.endSubVip, serviceprovider.averageRating,category_has_serviceprovider.experience,category_has_serviceprovider.price ,file.image FROM user
    INNER JOIN location ON user.idLocation = location.idLocation
    INNER JOIN file ON user.idUser = file.idUser
    INNER JOIN serviceprovider ON user.idUser = serviceprovider.idSP 
	INNER JOIN category_has_serviceprovider ON serviceprovider.idSP = category_has_serviceprovider.idServiceProvider 
	WHERE user.type = 3 AND serviceprovider.idSubscription != 1 AND serviceprovider.averageRating >= rating AND category_has_serviceprovider.experience >= experience
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


-- Returns: companies
DELIMITER &&  
CREATE PROCEDURE get_companies (IN id INT,IN limite INT, IN inicio INT)  
BEGIN  
    SELECT user.idUser, user.name,company.link,company.firm,company.nipc,PI.add.description,location.name AS location,location.cordsX, location.cordsY, file.image FROM user
    INNER JOIN company ON user.idUser = company.idCompany 
    INNER JOIN PI.add ON user.idUser = PI.add.idCompany
    INNER JOIN location ON user.idLocation = location.idLocation
    INNER JOIN file ON user.idUser = file.idUser WHERE user.type = 4 AND company.idSubscription != 1 
		AND CASE WHEN id IS NOT NULL
					THEN user.idLocation = id
				ELSE 1
                END
    ORDER BY company.endSubVip DESC LIMIT limite OFFSET inicio;
END &&  
DELIMITER ;

-- Returns: count companies
DELIMITER &&  
CREATE PROCEDURE get_companies_count (IN id INT)  
BEGIN  
	
    SELECT COUNT(*) AS number_companies FROM (
    SELECT user.idUser FROM user
    INNER JOIN company ON user.idUser = company.idCompany 
    INNER JOIN PI.add ON user.idUser = PI.add.idCompany
    INNER JOIN location ON user.idLocation = location.idLocation
    INNER JOIN file ON user.idUser = file.idUser WHERE user.type = 4 AND company.idSubscription != 1 
		AND CASE WHEN id IS NOT NULL
					THEN user.idLocation = id
				ELSE 1
                END
    ) AS aux_companies;
END &&  
DELIMITER ;


-- Returns: service providers
DELIMITER &&  
CREATE PROCEDURE get_service_providers_v2 (IN id_category INT, IN id_location INT, IN experience INT, IN price DOUBLE, IN rating DOUBLE, IN in_sex VARCHAR(1),IN limite INT, IN inicio INT)  
BEGIN  

    SELECT (SELECT count(*) FROM review WHERE user.idUser = review.idReceive) as nr_reviews ,
		user.idUser, user.name,user.lastActivity,user.active,user.sex,serviceprovider.description,location.name AS location, location.cordsX, location.cordsY,serviceprovider.endSubVip, serviceprovider.averageRating,category_has_serviceprovider.experience,category_has_serviceprovider.price ,file.image FROM user
    INNER JOIN location ON user.idLocation = location.idLocation
    INNER JOIN file ON user.idUser = file.idUser
    INNER JOIN serviceprovider ON user.idUser = serviceprovider.idSP 
	INNER JOIN category_has_serviceprovider ON serviceprovider.idSP = category_has_serviceprovider.idServiceProvider 
	WHERE user.type = 3 AND serviceprovider.idSubscription != 1 
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


-- Returns: count service providers
DELIMITER &&  
CREATE PROCEDURE get_service_providers_v2_count (IN id_category INT, IN id_location INT, IN experience INT, IN price DOUBLE, IN rating DOUBLE, IN in_sex VARCHAR(1))  
BEGIN  

    SELECT COUNT(*) AS number_sps FROM (SELECT user.idUser FROM user
    INNER JOIN location ON user.idLocation = location.idLocation
    INNER JOIN file ON user.idUser = file.idUser
    INNER JOIN serviceprovider ON user.idUser = serviceprovider.idSP 
	INNER JOIN category_has_serviceprovider ON serviceprovider.idSP = category_has_serviceprovider.idServiceProvider 
	WHERE user.type = 3 AND serviceprovider.idSubscription != 1 
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

-- Returns: service providers
DELIMITER &&  
CREATE PROCEDURE get_service_providers_v3 (IN categories JSON, IN id_location INT, IN experience INT, IN price DOUBLE, IN rating DOUBLE, IN in_sex VARCHAR(1),IN limite INT, IN inicio INT)  
BEGIN  
	
    SET @category1 = IF (categories LIKE '%1%', '1',NULL);
    SET @category2 = IF (categories LIKE '%2%', '2',NULL);
    SET @category3 = IF (categories LIKE '%3%', '3',NULL);
    SET @category4 = IF (categories LIKE '%4%', '4',NULL);
    SET @category5 = IF (categories LIKE '%5%', '5',NULL);
    SET @category6 = IF (categories LIKE '%6%', '6',NULL);
    
    -- @category1 ,@category2,@category3,@category4,@category5,@category6 TESTE
    
    SELECT (SELECT count(*) FROM review WHERE user.idUser = review.idReceive) as nr_reviews,
    user.idUser, user.name,user.lastActivity,user.active,user.sex,serviceprovider.description,location.name AS location, location.cordsX, location.cordsY,serviceprovider.endSubVip, serviceprovider.averageRating,category_has_serviceprovider.experience,category_has_serviceprovider.price ,file.image, category_has_serviceprovider.idCategory FROM user
    INNER JOIN location ON user.idLocation = location.idLocation
    INNER JOIN file ON user.idUser = file.idUser
    INNER JOIN serviceprovider ON user.idUser = serviceprovider.idSP 
	INNER JOIN category_has_serviceprovider ON serviceprovider.idSP = category_has_serviceprovider.idServiceProvider 
	WHERE user.type = 3 AND serviceprovider.idSubscription != 1 
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
		AND CASE WHEN @category1 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 1) IS NOT NULL THEN 1
				WHEN @category1 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 1) IS NULL THEN 0
				ELSE 1
        END
        AND CASE WHEN @category2 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 2) IS NOT NULL THEN 1
				WHEN @category2 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 2) IS NULL THEN 0
				ELSE 1
        END
        AND CASE WHEN @category3 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 3) IS NOT NULL THEN 1
				WHEN @category3 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 3) IS NULL THEN 0
				ELSE 1
        END
        AND CASE WHEN @category4 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 4) IS NOT NULL THEN 1
				WHEN @category4 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 4) IS NULL THEN 0
				ELSE 1
        END
        AND CASE WHEN @category5 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 5) IS NOT NULL THEN 1
				WHEN @category5 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 5) IS NULL THEN 0
				ELSE 1
        END
        AND CASE WHEN @category6 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 6) IS NOT NULL THEN 1
				WHEN @category6 IS NOT NULL AND (SELECT category_has_serviceprovider.idServiceProvider FROM category_has_serviceprovider 
			WHERE user.idUser = category_has_serviceprovider.idServiceProvider AND category_has_serviceprovider.idCategory = 6) IS NULL THEN 0
				ELSE 1
        END
	GROUP BY user.idUser
    ORDER BY serviceprovider.endSubVip DESC LIMIT limite OFFSET inicio;
END &&  
DELIMITER ;