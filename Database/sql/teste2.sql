USE PI;
DROP PROCEDURE IF EXISTS teste;
DROP PROCEDURE IF EXISTS teste2;
DROP PROCEDURE IF EXISTS add_slot_teste;


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
CALL teste2(147);
-- CALL info_requested_slots_v2(53);


 
DELIMITER &&  
CREATE PROCEDURE add_slot_teste (IN in_idUser INT, IN in_slot JSON)  
BEGIN  
	
    DECLARE os JSON DEFAULT '[]';
    -- get the occupied schedule
    SET os = (SELECT serviceprovider.occupiedSchedule FROM serviceprovider 
			WHERE serviceprovider.idSP = in_idUser );
   SET os = IF (os IS NULL, '[]', os);
    
	UPDATE pi.serviceprovider SET
		serviceprovider.occupiedSchedule= CASE 
					WHEN in_slot IS NOT NULL AND os IS NOT NULL
                    THEN JSON_MERGE_PRESERVE(os,in_slot)
                    ELSE serviceprovider.occupiedSchedule
                    END
	WHERE serviceprovider.idSP = in_idUser;
END &&  
DELIMITER ;

CALL add_slot_teste(59,  '{
        "id": "37",
        "date_end": "2022-01-08 18:00:00",
        "occupied": "1",
        "date_begin": "2022-01-08 17:30:00",
        "idCategory": "3",
        "date_requested": "2022-01-02 19:12:18"
    }');
    
    
    
    

CALL info_requested_slots(53);
CALL info_requested_slots(54);

SELECT LENGTH("[4]");

-- user 78 tem free trial e 1 id subscription e company 153
CALL update_serviceProvider_endSub(78,3);
CALL update_company_endSub(153,8);

-- "date_begin": "2022-01-09 05:00:00" || "date_end": "2022-01-09 12:30:00"
-- CASO 1: slot no meio
-- CASO 2: abaixo do begin e meio
-- CASO 3: meio e acima do end
-- CASO 4: abaixo do begin e acima do end
-- CASO 1
CALL add_workSchedule_slot(51,'{
        "date_end": "2022-01-09 12:19:00",
        "date_begin": "2022-01-09 05:30:00"
    }');

-- CASO 2
CALL add_workSchedule_slot(51,'{
        "date_end": "2022-01-09 12:19:00",
        "date_begin": "2022-01-09 04:00:00"
    }');

-- CASO 3
CALL add_workSchedule_slot(51,'{
        "date_end": "2022-01-09 12:50:00",
        "date_begin": "2022-01-09 05:30:00"
    }');

-- CASO 4
CALL add_workSchedule_slot(51,'{
        "date_end": "2022-01-09 17:50:00",
        "date_begin": "2022-01-09 04:00:00"
    }');

-- CASO 5 que tem de inserir
CALL add_workSchedule_slot(51,'{
        "date_end": "2022-01-09 12:32:00",
        "date_begin": "2022-01-09 12:30:00"
    }');
    
    
CALL verify_slot(51,'{
        "date_end": "2022-01-09 18:00:00",
        "date_begin": "2022-01-09 17:31:00"
    }');

-- CASO 2
CALL verify_slot(51,'{
        "date_end": "2022-01-09 17:40:00",
        "date_begin": "2022-01-09 17:10:00"
    }');

-- CASO 3
CALL verify_slot(51,'{
        "date_end": "2022-01-09 18:10:00",
        "date_begin": "2022-01-09 17:50:00"
    }');

-- CASO 4
CALL verify_slot(51,'{
        "date_end": "2022-01-09 18:10:00",
        "date_begin": "2022-01-09 17:20:00"
    }');
    
-- CASO 5 que tem de inserir
CALL verify_slot(51,'{
        "date_end": "2022-01-09 17:30:00",
        "date_begin": "2022-01-09 17:10:00"
    }');
CALL verify_slot(51,'{
        "date_end": "2022-01-09 17:29:00",
        "date_begin": "2022-01-09 17:10:00"
    }');
CALL verify_slot(51,'{
        "date_end": "2022-01-09 18:10:00",
        "date_begin": "2022-01-09 18:00:00"
    }');
    
CALL verify_ws(51,'{"date_end": "2022-01-09 12:30:00","date_begin": "2022-01-09 05:00:00"}');
CALL verify_ws(51,'{"date_end": "2022-01-09 12:30:00","date_begin": "2022-01-09 04:59:00"}');
CALL verify_ws(51,'{"date_end": "2022-01-09 12:20:00","date_begin": "2022-01-09 05:59:00"}');
CALL verify_ws(51,'{"date_end": "2022-01-09 12:31:00","date_begin": "2022-01-09 05:59:00"}');

-- slots do 51, 56 e 57
CALL remove_user(55);
CALL remove_user(12);
CALL remove_user(13);
CALL remove_user(151);

CALL remove_workSchedule_slot(70,'{
        "date_end": "2022-01-03 11:30:00",
        "date_begin": "2022-01-03 06:00:00"
    }');
    
    
    
    
SELECT category_has_serviceprovider.idCategory,category.name AS category, user.idLocation, location.name AS location , COUNT(*)FROM user
INNER JOIN category_has_serviceprovider ON user.idUser = category_has_serviceprovider.idServiceProvider
INNER JOIN category ON category_has_serviceprovider.idCategory = category.idCategory
INNER JOIN location ON user.idLocation = location.idLocation
GROUP BY category_has_serviceprovider.idCategory,user.idLocation ORDER BY COUNT(*) DESC;