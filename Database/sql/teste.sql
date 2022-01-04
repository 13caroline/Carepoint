-- CALL get_service_providers(NULL, NULL, NULL, NULL, 20,0);
-- CALL get_companies(NULL,50,0);
-- CALL get_average_rating(55);
-- CALL get_reviews(55);
-- CALL get_service_provider_profile(55);
-- CALL get_joboffer(4,471,18, 10, 0);

-- CALL update_company_endSub(151,13);
-- CALL update_joboffer(4, 'teste', '2026-08-11', 10, '2026-08-14', 6, 180);

-- CALL update_company_endSub(151,9);
 -- CALL update_company_vip(151,3);
 
 USE PI;
 insert into pi.user VALUES(0, 'Trigger test','test','trigger@gmail.com',NULL,'M',2,NOW(),NOW(),0,3);
 
 DELETE FROM pi.user WHERE idUser = 207; 