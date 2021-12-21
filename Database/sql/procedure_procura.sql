USE PI;

DROP PROCEDURE IF EXISTS get_service_providers;
DROP PROCEDURE IF EXISTS get_companies;


-- Returns: service providers
DELIMITER &&  
CREATE PROCEDURE get_service_providers (IN id_category INT, IN id_location INT, IN experience INT, IN price DOUBLE,IN limite INT, IN inicio INT)  
BEGIN  
    SELECT user.idUser, user.name,user.lastActivity,user.active,serviceprovider.description,location.name AS location, location.cordsX, location.cordsY, file.image FROM user
    INNER JOIN location ON user.idLocation = location.idLocation
    INNER JOIN file ON user.idUser = file.idUser
    INNER JOIN serviceprovider ON user.idUser = serviceprovider.idSP 
	INNER JOIN category_has_serviceprovider ON serviceprovider.idSP = category_has_serviceprovider.idServiceProvider 
	WHERE user.type = 3 AND serviceprovider.idSubscription != 1
        AND CASE WHEN id_category IS NOT NULL AND id_location IS NOT NULL AND experience IS NOT NULL AND price IS NOT NULL
					THEN user.idLocation = id_location AND category_has_serviceprovider.idCategory = id_category 
						AND (category_has_serviceprovider.price <= price OR category_has_serviceprovider.price IS NULL) AND category_has_serviceprovider.experience >= experience
				WHEN id_category IS NOT NULL AND id_location IS NOT NULL AND experience IS NOT NULL AND price IS NULL
					THEN user.idLocation = id_location AND category_has_serviceprovider.idCategory = id_category AND category_has_serviceprovider.experience >= experience
				WHEN id_category IS NOT NULL AND id_location IS NOT NULL AND experience IS NULL AND price IS NOT NULL
					THEN user.idLocation = id_location AND category_has_serviceprovider.idCategory = id_category 
						AND (category_has_serviceprovider.price <= price OR category_has_serviceprovider.price IS NULL)
				WHEN id_category IS NOT NULL AND id_location IS NULL AND experience IS NOT NULL AND price IS NOT NULL
					THEN category_has_serviceprovider.idCategory = id_category 
						AND (category_has_serviceprovider.price <= price OR category_has_serviceprovider.price IS NULL) AND category_has_serviceprovider.experience >= experience
				WHEN id_category IS NULL AND id_location IS NOT NULL AND experience IS NOT NULL AND price IS NOT NULL
					THEN user.idLocation = id_location 
						AND (category_has_serviceprovider.price <= price OR category_has_serviceprovider.price IS NULL) AND category_has_serviceprovider.experience >= experience
				WHEN id_category IS NOT NULL AND id_location IS NOT NULL AND experience IS NULL AND price IS NULL
					THEN user.idLocation = id_location AND category_has_serviceprovider.idCategory = id_category 
				WHEN id_category IS NOT NULL AND id_location IS NULL AND experience IS NULL AND price IS NOT NULL
					THEN category_has_serviceprovider.idCategory = id_category AND (category_has_serviceprovider.price <= price OR category_has_serviceprovider.price IS NULL)
				WHEN id_category IS NOT NULL AND id_location IS NULL AND experience IS NOT NULL AND price IS NULL
					THEN category_has_serviceprovider.idCategory = id_category AND category_has_serviceprovider.experience >= experience
				WHEN id_category IS NULL AND id_location IS NOT NULL AND experience IS NULL AND price IS NOT NULL
					THEN user.idLocation = id_location AND (category_has_serviceprovider.price <= price OR category_has_serviceprovider.price IS NULL)
				WHEN id_category IS NULL AND id_location IS NULL AND experience IS NOT NULL AND price IS NOT NULL
					THEN (category_has_serviceprovider.price <= price OR category_has_serviceprovider.price IS NULL) AND category_has_serviceprovider.experience >= experience
				WHEN id_category IS NULL AND id_location IS NOT NULL AND experience IS NOT NULL AND price IS NULL
					THEN user.idLocation = id_location AND category_has_serviceprovider.experience >= experience
				WHEN id_category IS NOT NULL AND id_location IS NULL AND experience IS NULL AND price IS NULL
					THEN category_has_serviceprovider.idCategory = id_category 
				WHEN id_category IS NULL AND id_location IS NOT NULL AND experience IS NULL AND price IS NULL
					THEN user.idLocation = id_location
				WHEN id_category IS NULL AND id_location IS NULL AND experience IS NOT NULL AND price IS NULL
					THEN category_has_serviceprovider.experience >= experience
				WHEN id_category IS NULL AND id_location IS NULL AND experience IS NULL AND price IS NOT NULL
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

