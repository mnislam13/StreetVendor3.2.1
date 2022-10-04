
SET SERVEROUTPUT ON;
SET VERIFY OFF;


ACCEPT Y NUMBER PROMPT "Enter choice seencall_1_show_2_pack_3: "

DECLARE
	ID int;
	temp int;
	runningboard int;
	presentbet int;
	c1 deckofcards.name%TYPE;
	c2 deckofcards.name%TYPE;
	c3 deckofcards.name%TYPE;
	Invalid_Value EXCEPTION;

BEGIN
	--dbms_output.put_line('Your cards: * * *');
	SELECT MAX(bid) into runningboard FROM server_boards;
	
	showcards(runningboard);
	
	ID := &Y;
	IF ID = 1 THEN --seen call
		SELECT bet into presentbet FROM server_boards WHERE bid = runningboard;
		presentbet := presentbet +2;
		dbms_output.put_line('increased bet: '||presentbet);
		UPDATE server_boards SET bet = presentbet WHERE bid=runningboard;
		commit;
		IF presentbet > 20 THEN
			DBMS_OUTPUT.PUT_LINE('Run show.sql file after site call.');
		END IF;
	ELSIF ID = 2 THEN --show
		SELECT bet into presentbet FROM server_boards WHERE bid = runningboard;
		presentbet := presentbet +2;
		dbms_output.put_line('increased bet: '||presentbet);
		UPDATE server_boards SET bet = presentbet WHERE bid=runningboard;
		commit;
		DBMS_OUTPUT.PUT_LINE('Run for_show.sql file.');
	ELSIF ID = 3 THEN --pack cards
		--pack cards procedure
		packcards(runningboard);
	ELSE
		RAISE Invalid_Value;
		
	END IF;
	

EXCEPTION
	WHEN Invalid_Value THEN
		DBMS_OUTPUT.PUT_LINE('choice should be in between 1 to 3.');
		DELETE FROM server_boards WHERE bid = runningboard;
		DELETE FROM site_boards@site61 WHERE bid = runningboard;
		commit;
		dbms_output.put_line('Board dismissed');

	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Unknown Error.');
	
END;
/


