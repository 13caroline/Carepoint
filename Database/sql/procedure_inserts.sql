USE PI;

DROP PROCEDURE IF EXISTS createReview;
DROP PROCEDURE IF EXISTS createMessage;

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
-- Description: Insert message
-- Type: Procedure
-- Parameters:
--   @in_content -  content of the message
--   @in_idGive -  person that gives the review
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