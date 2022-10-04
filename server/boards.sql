clear screen;
drop table server_boards;

create table server_boards(
bid 		integer, 
card1 		integer, 
card2 		integer, 
card3 		integer, 
crit1 		integer, 
crit2 		integer, 
bet 		integer, 
status 		varchar2(20), 
earnings 	integer,
			PRIMARY KEY (bid)
);


--Insert data into the server_boards database
insert into server_boards values(1,1,14,27,100,39,7,'win',5);


commit;

select * from server_boards;