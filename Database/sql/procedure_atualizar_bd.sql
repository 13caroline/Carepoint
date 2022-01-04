USE PI;
DROP PROCEDURE IF EXISTS update_first_avg;

-- Update: service provider info
DELIMITER &&  
CREATE PROCEDURE update_first_avg (IN idUser INT)  
BEGIN  

	SET @avg_rating = (SELECT AVG(rating) FROM review WHERE idUser = review.idReceive);
    
    SET foreign_key_checks = 0;
	UPDATE  serviceprovider SET
		 serviceprovider.averageRating= CASE
					WHEN @avg_rating IS NOT NULL
                    THEN @avg_rating
                    ELSE serviceprovider.averageRating
                    END
		WHERE serviceprovider.idSP = idUser;
        SET foreign_key_checks = 1;
        
        
END &&  
DELIMITER ;

CALL update_first_avg(51);
CALL update_first_avg(52);
CALL update_first_avg(53);
CALL update_first_avg(54);
CALL update_first_avg(55);
CALL update_first_avg(56);
CALL update_first_avg(57);
CALL update_first_avg(58);
CALL update_first_avg(59);
CALL update_first_avg(60);
CALL update_first_avg(61);
CALL update_first_avg(62);
CALL update_first_avg(63);
CALL update_first_avg(64);
CALL update_first_avg(65);
CALL update_first_avg(66);
CALL update_first_avg(67);
CALL update_first_avg(68);
CALL update_first_avg(69);
CALL update_first_avg(70);
CALL update_first_avg(71);
CALL update_first_avg(72);
CALL update_first_avg(73);
CALL update_first_avg(74);
CALL update_first_avg(75);
CALL update_first_avg(76);
CALL update_first_avg(77);
CALL update_first_avg(78);
CALL update_first_avg(79);
CALL update_first_avg(80);
CALL update_first_avg(81);
CALL update_first_avg(82);
CALL update_first_avg(83);
CALL update_first_avg(84);
CALL update_first_avg(85);
CALL update_first_avg(86);
CALL update_first_avg(87);
CALL update_first_avg(88);
CALL update_first_avg(89);
CALL update_first_avg(90);
CALL update_first_avg(91);
CALL update_first_avg(92);
CALL update_first_avg(93);
CALL update_first_avg(94);
CALL update_first_avg(95);
CALL update_first_avg(96);
CALL update_first_avg(97);
CALL update_first_avg(98);
CALL update_first_avg(99);
CALL update_first_avg(100);
CALL update_first_avg(101);
CALL update_first_avg(102);
CALL update_first_avg(103);
CALL update_first_avg(104);
CALL update_first_avg(105);
CALL update_first_avg(106);
CALL update_first_avg(107);
CALL update_first_avg(108);
CALL update_first_avg(109);
CALL update_first_avg(110);
CALL update_first_avg(111);
CALL update_first_avg(112);
CALL update_first_avg(113);
CALL update_first_avg(114);
CALL update_first_avg(115);
CALL update_first_avg(116);
CALL update_first_avg(117);
CALL update_first_avg(118);
CALL update_first_avg(119);
CALL update_first_avg(120);
CALL update_first_avg(121);
CALL update_first_avg(122);
CALL update_first_avg(123);
CALL update_first_avg(124);
CALL update_first_avg(125);
CALL update_first_avg(126);
CALL update_first_avg(127);
CALL update_first_avg(128);
CALL update_first_avg(129);
CALL update_first_avg(130);
CALL update_first_avg(131);
CALL update_first_avg(132);
CALL update_first_avg(133);
CALL update_first_avg(134);
CALL update_first_avg(135);
CALL update_first_avg(136);
CALL update_first_avg(137);
CALL update_first_avg(138);
CALL update_first_avg(139);
CALL update_first_avg(140);
CALL update_first_avg(141);
CALL update_first_avg(142);
CALL update_first_avg(143);
CALL update_first_avg(144);
CALL update_first_avg(145);
CALL update_first_avg(146);
CALL update_first_avg(147);
CALL update_first_avg(148);
CALL update_first_avg(149);
CALL update_first_avg(150);