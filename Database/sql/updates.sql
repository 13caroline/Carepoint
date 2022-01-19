USE PI;

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
	IN in_description VARCHAR(2000), IN in_distance INT, IN in_qualifications VARCHAR(1000))  
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
	-- end date of the vip subscription
	SET @last_endSubVip = (SELECT serviceprovider.endSubVip FROM serviceprovider WHERE serviceprovider.idSP = id);
    -- price per day
    SET @price_per_day = 0.07;
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
        SET @new_endSubVip = (SELECT serviceprovider.endSubVip FROM serviceprovider WHERE serviceprovider.idSP = id);
        
        IF @last_endSubVip IS NULL THEN SELECT DATEDIFF(@new_endSubVip,now())*@price_per_day;
        ELSE SELECT DATEDIFF(@new_endSubVip,@last_endSubVip)*@price_per_day;
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
	-- end date of the vip subscription
	SET @last_endSubVip = (SELECT company.endSubVip FROM company WHERE company.idCompany = id);
    -- price per day
    SET @price_per_day = 0.12;
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
        SET @new_endSubVip = (SELECT company.endSubVip FROM company WHERE company.idCompany = id);
        
        IF @last_endSubVip IS NULL THEN SELECT DATEDIFF(@new_endSubVip,now())*@price_per_day;
        ELSE SELECT DATEDIFF(@new_endSubVip,@last_endSubVip)*@price_per_day;
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
	-- new average rating
	SET @new_avg = (SELECT AVG(rating) FROM review WHERE review.idReceive = in_idUser);
	UPDATE pi.serviceprovider SET serviceprovider.averageRating = @new_avg WHERE serviceprovider.idSP = in_idUser;
        
END &&  
DELIMITER ;