USE PI;

DROP PROCEDURE IF EXISTS createReview;

-- Update: image
DELIMITER &&  
CREATE PROCEDURE createReview (IN in_description VARCHAR(2000), IN in_rating INT, IN in_give INT, IN in_receive INT)  
BEGIN  

	INSERT INTO review (description, rating, postDate, idGive, idReceive)
    VALUES (in_description, in_rating, now(), in_give, in_receive);
        
END &&  
DELIMITER ;