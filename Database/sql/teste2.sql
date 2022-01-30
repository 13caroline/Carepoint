USE PI;
DROP PROCEDURE IF EXISTS teste;
DROP PROCEDURE IF EXISTS teste2;


    -- =============================================
-- Description: get information about a requested slot
-- Type: Procedure
-- Parameters: 
--   @in_idUser - service provider identification number
-- Returns: Information about the request slot
-- =============================================


DELIMITER &&  
CREATE PROCEDURE teste (IN in_idUser INT)  
BEGIN  
	
    DECLARE os JSON DEFAULT '[]';

    
    -- get the occupied schedule
    SET os = (SELECT serviceprovider.occupiedSchedule FROM serviceprovider 
			WHERE serviceprovider.idSP = in_idUser );
	
    SET os = IF (os IS NULL, '[]', os);
    
	select json_extract(j1, '$.id') AS id, user.name, json_extract(j1, '$.date_begin') AS date_begin, json_extract(j1, '$.date_end') AS date_end, 
		json_extract(j1, '$.idCategory') AS categories, json_extract(j1, '$.date_requested') AS date_requested from json_table(os, '$[*]' columns ( j1 json path '$')) as jt 
		inner join user ON json_extract(j1, '$.id') = user.idUser
		where json_extract(j1, '$.occupied') = "0";

	
END &&  
DELIMITER ;

DELIMITER &&  
CREATE PROCEDURE teste2 (IN in_idUser INT)  
BEGIN  
	
    DECLARE os JSON DEFAULT '[]';

    
    -- get the occupied schedule
    SET os = (SELECT serviceprovider.occupiedSchedule FROM serviceprovider 
			WHERE serviceprovider.idSP = in_idUser );
	
    SET os = IF (os IS NULL, '[]', os);
    
	select user.name, j1 from json_table(os, '$[*]' columns ( j1 json path '$')) as jt 
		inner join user ON json_extract(j1, '$.id') = user.idUser
		where json_extract(j1, '$.occupied') = "0";

	
END &&  
DELIMITER ;

-- CALL teste(53);
CALL teste2(53);
CALL info_requested_slots_v2(53);
-- CALL info_requested_slots(53);