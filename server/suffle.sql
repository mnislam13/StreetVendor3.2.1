--ACCEPT X NUMBER PROMPT "shuffling: "


DECLARE
	type cards IS VARRAY(6) OF INTEGER;
	c cards;
	
	temp pls_integer;
	i int := 1;
	
	lastboard int;
	runningboard int;
	
	--Negative_Value EXCEPTION;

BEGIN
	c := cards(0, 0, 0, 0, 0, 0);
	
	temp := dbms_random.value(1,53);
	c(i) := temp;
	--dbms_output.put_line('card '||i|| ': ' || c(i));
		
	WHILE i<6
	LOOP
		i := i+1;
		temp := dbms_random.value(1,53);
		IF (temp!=c(1) and temp!=c(2) and temp!=c(3) and temp!=c(4) and temp!=c(5) and temp!=c(6)) THEN
			c(i) := temp;
			--dbms_output.put_line('card '||i|| ': ' || c(i));
		ELSE
			i := i-1;
		END IF;
	END LOOP;
	
	
	SELECT MAX(bid) into lastboard FROM server_boards;
	runningboard := lastboard+1;
	
	insert into server_boards values(runningboard,c(1),c(2),c(3),null,null,1,null,0);
	insert into site_boards@site61 values(runningboard,c(4),c(5),c(6),null,null,1,null,0);
	
	commit;
	
END;
/

select * from server_boards;
select * from site_boards@site61;