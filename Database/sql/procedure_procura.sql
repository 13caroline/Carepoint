USE PI;

DROP PROCEDURE IF EXISTS get_service_providers;
DROP PROCEDURE IF EXISTS get_companies;
DROP PROCEDURE IF EXISTS get_service_providers_v2;

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


-- Returns: service providers
DELIMITER &&  
CREATE PROCEDURE get_service_providers_v2 (IN id_category INT, IN id_location INT, IN experience INT, IN price DOUBLE, IN rating DOUBLE, IN in_sex VARCHAR(1),IN limite INT, IN inicio INT)  
BEGIN  

    SELECT user.idUser, user.name,user.lastActivity,user.active,user.sex,serviceprovider.description,location.name AS location, location.cordsX, location.cordsY,serviceprovider.endSubVip, serviceprovider.averageRating,category_has_serviceprovider.experience,category_has_serviceprovider.price ,file.image FROM user
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