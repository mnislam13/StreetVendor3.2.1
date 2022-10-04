SET SERVEROUTPUT ON;
SET VERIFY OFF;

DECLARE
	
	runningboard int;
	
	amount int;
	amount2 int;
	
	stat server_boards.status%TYPE;
	

BEGIN
	SELECT MAX(bid) into runningboard FROM server_boards;
	SELECT bet into amount2 FROM server_boards WHERE bid=runningboard;
	SELECT bet into amount FROM site_boards@site61 WHERE bid=runningboard;
	
	SELECT status into stat FROM server_boards WHERE bid=runningboard;
	IF stat='win' THEN
		DBMS_OUTPUT.PUT_LINE('You won the board and earned '||amount||'.');
	ELSE
		DBMS_OUTPUT.PUT_LINE('You lose the board and lost '||amount2||'.');
	END IF;
	
	DBMS_OUTPUT.PUT_LINE('SHUFFLE AGAIN to play another board of this special game.');
	
END;
/