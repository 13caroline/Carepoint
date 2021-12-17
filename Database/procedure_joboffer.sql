USE PI;

DROP PROCEDURE IF EXISTS get_joboffer;


-- Returns: joboffers
DELIMITER &&  
CREATE PROCEDURE get_joboffer (IN id_category INT,IN id_location INT, IN price DOUBLE,IN limite INT, IN inicio INT)  
BEGIN  
    SELECT joboffer.idJobOffer, user.idUser, user.name, joboffer.description, joboffer.beginDate, joboffer.postDate, joboffer.price,joboffer.idCategory, joboffer.done, location.name AS location, location.cordsX, location.cordsY FROM joboffer
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
    ORDER BY joboffer.idJobOffer DESC LIMIT limite OFFSET inicio;
END &&  
DELIMITER ;


