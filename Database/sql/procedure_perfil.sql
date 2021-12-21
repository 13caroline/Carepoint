USE PI;

DROP PROCEDURE IF EXISTS get_reviews;
DROP PROCEDURE IF EXISTS get_average_rating;
DROP PROCEDURE IF EXISTS get_service_provider_profile;

-- Returns: average rating or null if no reviews
DELIMITER &&  
CREATE PROCEDURE get_average_rating (IN id INT)  
BEGIN  
    SELECT AVG(rating) FROM review WHERE id = review.idReceive;
END &&  
DELIMITER ;


-- Returns: returns all the reviews for a specific user
DELIMITER &&  
CREATE PROCEDURE get_reviews (IN id INT)  
BEGIN  
    SELECT description,rating,postDate, file.image, user.name FROM review
    INNER JOIN file ON review.idGive = file.idUser
    INNER JOIN user ON review.idGive = user.idUser WHERE id = review.idReceive;
END &&  
DELIMITER ;  


-- Returns: returns information for a specific service provider
DELIMITER &&  
CREATE PROCEDURE get_service_provider_profile (IN id INT)  
BEGIN  
    SELECT user.name, user.email, user.phoneNumber, user.lastActivity,user.active, serviceprovider.description,
		category_has_serviceprovider.idCategory, category_has_serviceprovider.experience, category_has_serviceprovider.workSchedule ,file.image FROM user
    INNER JOIN serviceprovider ON user.idUser = serviceprovider.idSP 
    INNER JOIN file ON user.idUser = file.idUser
    INNER JOIN category_has_serviceprovider ON user.idUser = category_has_serviceprovider.idServiceProvider WHERE id = user.idUser;
END &&  
DELIMITER ; 
