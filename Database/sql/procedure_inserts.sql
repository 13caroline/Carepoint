USE PI;

DROP PROCEDURE IF EXISTS createReview;

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