
SET SERVEROUTPUT ON;
SET VERIFY OFF;

CREATE OR REPLACE TRIGGER mytrig211
AFTER UPDATE 
OF bet
ON server_boards
FOR EACH ROW
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('Call has been taken.');
END;
/

CREATE OR REPLACE TRIGGER mytrig212
AFTER UPDATE 
OF status
ON server_boards
FOR EACH ROW
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('Result declared. Run after_stat on site.');
END;
/

CREATE OR REPLACE PROCEDURE showcards(board IN int)
IS

temp int;
c1 VARCHAR2(20);
c2 VARCHAR2(20);
c3 VARCHAR2(20);

BEGIN
	--dbms_output.put_line('Your cards: * * *');
	--SELECT MAX(bid) into runningboard FROM server_boards;
	
	SELECT card1 into temp FROM server_boards WHERE bid=board;
	SELECT name into c1 FROM deckofcards WHERE cid=temp;
	
	SELECT card2 into temp FROM server_boards WHERE bid=board;
	SELECT name into c2 FROM deckofcards WHERE cid=temp;
	
	SELECT card3 into temp FROM server_boards WHERE bid=board;
	SELECT name into c3 FROM deckofcards WHERE cid=temp;
	
	dbms_output.put_line('Your cards: '||c1||' '||c2||' '||c3);
	--DBMS_OUTPUT.PUT_LINE('Run seencall_show_pack.sql file.');

END showcards;
/


CREATE OR REPLACE PROCEDURE packcards(board IN int)
IS

betamount int;

BEGIN
	--SELECT MAX(bid) into runningboard FROM server_boards;
	SELECT bet into betamount FROM server_boards WHERE bid=board;
	
	UPDATE server_boards SET status = 'lose', earnings=0 WHERE bid=board;
	UPDATE site_boards@site61 SET status = 'win', earnings=betamount WHERE bid=board;
	
	commit;
	
	DBMS_OUTPUT.PUT_LINE('Run after_stat.sql file on both.');

END packcards;
/


DECLARE
	input_v int := &blindcall_1_seecards_2_pack_3;
	t int;
	runningboard int;
	presentbet int;
	
	Invalid_Value EXCEPTION;

BEGIN
	dbms_output.put_line('Your cards: * * *');
	SELECT MAX(bid) into runningboard FROM server_boards;
	--dbms_output.put_line(runningboard);
	
	IF input_v = 1 THEN --blind call
		SELECT bet into presentbet FROM server_boards WHERE bid = runningboard;
		presentbet := presentbet+1;
		dbms_output.put_line('increased bet: '||presentbet);
		UPDATE server_boards SET bet = presentbet WHERE bid=runningboard;
		commit;
		IF presentbet > 4 THEN
			--see cards procedure
			showcards(runningboard);
		END IF;
	ELSIF input_v = 2 THEN --see cards
		showcards(runningboard);
	ELSIF input_v = 3 THEN --pack cards
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


