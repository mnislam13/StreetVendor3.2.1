clear screen;
drop table deckofcards;

create table deckofcards(
cid 		integer,
name 		varchar2(20),
color 		varchar2(20), 
colortype 	integer, 
highness 	integer,
			PRIMARY KEY (cid)
);


--Insert data into the deckofcards database
insert into deckofcards values(1,'A_hearts','red',1,13);
insert into deckofcards values(2,'K_hearts','red',1,12);
insert into deckofcards values(3,'Q_hearts','red',1,11);
insert into deckofcards values(4,'J_hearts','red',1,10);
insert into deckofcards values(5,'10_hearts','red',1,9);
insert into deckofcards values(6,'9_hearts','red',1,8);
insert into deckofcards values(7,'8_hearts','red',1,7);
insert into deckofcards values(8,'7_hearts','red',1,6);
insert into deckofcards values(9,'6_hearts','red',1,5);
insert into deckofcards values(10,'5_hearts','red',1,4);
insert into deckofcards values(11,'4_hearts','red',1,3);
insert into deckofcards values(12,'3_hearts','red',1,2);
insert into deckofcards values(13,'2_hearts','red',1,1);

insert into deckofcards values(14,'A_spades','black',2,13);
insert into deckofcards values(15,'K_spades','black',2,12);
insert into deckofcards values(16,'Q_spades','black',2,11);
insert into deckofcards values(17,'J_spades','black',2,10);
insert into deckofcards values(18,'10_spades','black',2,9);
insert into deckofcards values(19,'9_spades','black',2,8);
insert into deckofcards values(20,'8_spades','black',2,7);
insert into deckofcards values(21,'7_spades','black',2,6);
insert into deckofcards values(22,'6_spades','black',2,5);
insert into deckofcards values(23,'5_spades','black',2,4);
insert into deckofcards values(24,'4_spades','black',2,3);
insert into deckofcards values(25,'3_spades','black',2,2);
insert into deckofcards values(26,'2_spades','black',2,1);

insert into deckofcards values(27,'A_diamonds','red',3,13);
insert into deckofcards values(28,'K_diamonds','red',3,12);
insert into deckofcards values(29,'Q_diamonds','red',3,11);
insert into deckofcards values(30,'J_diamonds','red',3,10);
insert into deckofcards values(31,'10_diamonds','red',3,9);
insert into deckofcards values(32,'9_diamonds','red',3,8);
insert into deckofcards values(33,'8_diamonds','red',3,7);
insert into deckofcards values(34,'7_diamonds','red',3,6);
insert into deckofcards values(35,'6_diamonds','red',3,5);
insert into deckofcards values(36,'5_diamonds','red',3,4);
insert into deckofcards values(37,'4_diamonds','red',3,3);
insert into deckofcards values(38,'3_diamonds','red',3,2);
insert into deckofcards values(39,'2_diamonds','red',3,1);

insert into deckofcards values(40,'A_clubs','black',4,13);
insert into deckofcards values(41,'K_clubs','black',4,12);
insert into deckofcards values(42,'Q_clubs','black',4,11);
insert into deckofcards values(43,'J_clubs','black',4,10);
insert into deckofcards values(44,'10_clubs','black',4,9);
insert into deckofcards values(45,'9_clubs','black',4,8);
insert into deckofcards values(46,'8_clubs','black',4,7);
insert into deckofcards values(47,'7_clubs','black',4,6);
insert into deckofcards values(48,'6_clubs','black',4,5);
insert into deckofcards values(49,'5_clubs','black',4,4);
insert into deckofcards values(50,'4_clubs','black',4,3);
insert into deckofcards values(51,'3_clubs','black',4,2);
insert into deckofcards values(52,'2_clubs','black',4,1);


commit;

select * from deckofcards;