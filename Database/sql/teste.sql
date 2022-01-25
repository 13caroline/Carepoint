USE PI;
--  CALL get_service_providers_v2 (NULL, NULL, NULL, NULL, 6, NULL,10,0);
 -- get_service_providers (IN id_category INT, IN id_location INT, IN experience INT, IN price DOUBLE, IN rating DOUBLE, IN in_sex VARCHAR(1),IN limite INT, IN inicio INT)
-- CALL get_companies(NULL,50,0);
-- CALL get_average_rating(55);
-- CALL get_reviews(55);
-- CALL get_service_provider_profile(55);
-- CALL get_joboffer(4,471,18, 10, 0);

-- CALL update_company_endSub(151,13);
-- CALL update_joboffer(4, 'teste', '2026-08-11', 10, '2026-08-14', 6, 180);
CALL get_max_values();
-- CALL update_company_endSub(151,9);
 -- CALL update_company_vip(151,3);
  CALL update_company_vip(153,2);
 -- CALL get_service_providers (1, NULL, NULL, NULL,10, 0) ;
 -- DELETE FROM pi.user WHERE idUser = 207; 
 CALL get_sp_category_info(51);
 CALL get_sp_horarios(51);
-- INSERT INTO Review(idReview,description,rating,postDate,idGive,idReceive)VALUES(0,'Teste.',2,'2022-03-18 10:27:16',17,51);
-- INSERT INTO Review(idReview,description,rating,postDate,idGive,idReceive)VALUES(0,'Teste.',3,'2022-03-18 10:27:16',17,52);
-- INSERT INTO Review(idReview,description,rating,postDate,idGive,idReceive)VALUES(0,'Teste.',4,'2022-03-18 10:27:16',17,52);
-- INSERT INTO Review(idReview,description,rating,postDate,idGive,idReceive)VALUES(0,'Teste.',7,'2022-03-18 10:27:16',17,55);
-- CALL update_last_activity(2);

-- UPDATE pi.review SET review.rating = 10 WHERE review.idReview = 75;
 CALL update_averageRating(51);

-- category , location, experience, price, rating, sex, limite, offset
  -- CALL get_service_providers_v2 (NULL, NULL, NULL, NULL,NULL, NULL,40,0);
  CALL get_service_providers_v2_count (NULL, NULL, NULL, NULL,NULL, NULL);
  CALL get_service_providers_v2_count (NULL, 159, NULL, NULL,NULL, NULL);
  CALL get_companies_count(713);
  CALL get_max_values();
-- '["1","5","3"]'
  CALL get_service_providers_v3 (NULL, NULL, NULL, NULL, NULL, NULL,40,0);
-- CALL get_consumers_joboffers("exvqvb@hotmail.com");
-- CALL get_service_providers_v3 ('["1","2"]', NULL, NULL, NULL, NULL, NULL,20,0);

CALL user_messages_with(1);
CALL all_messages_with(105,1);

CALL createMessage ( 'mensagem11',1,105);
CALL createMessage ( 'mensagem21',1,105);
CALL createMessage ( 'mensagem31',1,105);
CALL createMessage ( 'mensagem41',1,105);
CALL createMessage ( 'mensagem51',1,105);
CALL createMessage ( 'mensagem61',1,105);

CALL add_slot(51,'{"id": "69","date_end": "2022-01-03 11:00:00","occupied": "0","date_begin": "2022-01-03 08:30:00","idCategory": "1","date_requested": "2022-01-02 22:15:47"}');
        

CALL add_workSchedule_slot(51,'{"id": "69","date_end": "2022-01-03 11:00:00","occupied": "0","date_begin": "2022-01-03 08:30:00","idCategory": "1","date_requested": "2022-01-02 22:15:47"}');
CALL add_workSchedule_slot(51,'{"id": "69","date_end": "2022-01-03 11:00:00","date_begin": "2022-01-03 08:30:00","idCategory": "1","date_requested": "2022-01-02 22:15:47"}');
CALL add_workSchedule_slot(51,'{"id": "69","date_end": "2022-01-03 11:00:00","date_begin": "2022-01-03 08:30:00","idCategory": "1"}');
