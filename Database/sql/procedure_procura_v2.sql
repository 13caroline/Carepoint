USE PI;

DROP PROCEDURE IF EXISTS get_service_providers_v2;

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