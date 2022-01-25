USE PI;

DROP PROCEDURE IF EXISTS get_joboffer;
DROP PROCEDURE IF EXISTS get_joboffer_count;
DROP VIEW IF EXISTS count_sps;
DROP VIEW IF EXISTS count_sps_fakeish;

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





