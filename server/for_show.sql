
SET SERVEROUTPUT ON;
SET VERIFY OFF;

CREATE OR REPLACE FUNCTION topcard(c1 IN int, c2 IN int, c3 IN int)
RETURN int
IS

BEGIN
	IF c1>c2 and c1>c3 THEN
		RETURN c1;
	ELSIF c2>c3 and c2>c1 THEN
		RETURN c2;
	ELSE
		RETURN c3;
	END IF;
	
END topcard;
/


CREATE OR REPLACE FUNCTION runornot(c1 IN int, c2 IN int, c3 IN int)
RETURN int
IS


BEGIN
	IF c1>c2 and c1>c3 THEN
		IF c2=c1-1 and c3=c1-2 THEN
			RETURN 1;
		ELSIF c2=c1-2 and c3=c1-1 THEN
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
	ELSIF c2>c3 and c2>c1 THEN
		IF c1=c2-1 and c3=c2-2 THEN
			RETURN 1;
		ELSIF c1=c2-2 and c3=c2-1 THEN
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
	ELSE
		IF c1=c3-1 and c2=c3-2 THEN
			RETURN 1;
		ELSIF c1=c3-2 and c2=c3-1 THEN
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
	END IF;
	
END runornot;
/

DECLARE
	ID int;
	temp int;
	runningboard int;
	
	ch1 int;
	ch2 int;
	ch3 int;
	ch4 int;
	ch5 int;
	ch6 int;
	
	cc1 int;
	cc2 int;
	cc3 int;
	cc4 int;
	cc5 int;
	cc6 int;
	
	scard1 VARCHAR2(20);
	scard2 VARCHAR2(20);
	scard3 VARCHAR2(20);
	scard4 VARCHAR2(20);
	scard5 VARCHAR2(20);
	scard6 VARCHAR2(20);
	
	valueserver1 int;
	valueserver2 int;
	
	valuesite1 int;
	valuesite2 int;
	
	betamount int;
	cal int;
	
	r int;
	
BEGIN
	SELECT MAX(bid) into runningboard FROM server_boards;
	
	
	SELECT card1 into temp FROM server_boards WHERE bid=runningboard;
	SELECT highness into ch1 FROM deckofcards WHERE cid=temp;
	SELECT colortype into cc1 FROM deckofcards WHERE cid=temp;
	SELECT name into scard1 FROM deckofcards WHERE cid=temp;
	SELECT card2 into temp FROM server_boards WHERE bid=runningboard;
	SELECT highness into ch2 FROM deckofcards WHERE cid=temp;
	SELECT colortype into cc2 FROM deckofcards WHERE cid=temp;
	SELECT name into scard2 FROM deckofcards WHERE cid=temp;
	SELECT card3 into temp FROM server_boards WHERE bid=runningboard;
	SELECT highness into ch3 FROM deckofcards WHERE cid=temp;
	SELECT colortype into cc3 FROM deckofcards WHERE cid=temp;
	SELECT name into scard3 FROM deckofcards WHERE cid=temp;
	
	SELECT card1 into temp FROM site_boards@site61 WHERE bid=runningboard;
	SELECT highness into ch4 FROM deckofcards WHERE cid=temp;
	SELECT colortype into cc4 FROM deckofcards WHERE cid=temp;
	SELECT name into scard4 FROM deckofcards WHERE cid=temp;
	SELECT card2 into temp FROM site_boards@site61 WHERE bid=runningboard;
	SELECT highness into ch5 FROM deckofcards WHERE cid=temp;
	SELECT colortype into cc5 FROM deckofcards WHERE cid=temp;
	SELECT name into scard5 FROM deckofcards WHERE cid=temp;
	SELECT card3 into temp FROM site_boards@site61 WHERE bid=runningboard;
	SELECT highness into ch6 FROM deckofcards WHERE cid=temp;
	SELECT colortype into cc6 FROM deckofcards WHERE cid=temp;
	SELECT name into scard6 FROM deckofcards WHERE cid=temp;
	
	dbms_output.put_line('Your cards: '||scard1||' '||scard2||' '||scard3);
	dbms_output.put_line('Site cards: '||scard4||' '||scard5||' '||scard6);
	
	r := runornot(ch1, ch2, ch3);
	--criteria(runningboard,ch1,ch2,ch3,cc1,cc2,cc3);
	IF (ch1=ch2) and (ch1=ch3) THEN --TRIO
		cal := ch1+ch2+ch3;
		UPDATE server_boards SET crit1 = 100 WHERE bid=runningboard;
		UPDATE server_boards SET crit2=cal WHERE bid=runningboard;
	ELSIF ch1 = ch2 THEN --PAIR
		cal := ch1+ch2;
		UPDATE server_boards SET crit1 = cal WHERE bid=runningboard;
		UPDATE server_boards SET crit2=ch3 WHERE bid=runningboard;
	ELSIF ch1 = ch3 THEN --PAIR
		cal := ch1+ch3;
		UPDATE server_boards SET crit1 = cal WHERE bid=runningboard;
		UPDATE server_boards SET crit2=ch2 WHERE bid=runningboard;
	ELSIF ch2 = ch3 THEN --PAIR
		cal := ch2+ch3;
		UPDATE server_boards SET crit1 = cal WHERE bid=runningboard;
		UPDATE server_boards SET crit2=ch1 WHERE bid=runningboard;
	ELSIF cc1 = cc2 and cc1 = cc3 THEN --FLASH
		cal := topcard(ch1, ch2, ch3);
		UPDATE server_boards SET crit1 = 70 WHERE bid=runningboard;
		UPDATE server_boards SET crit2=cal WHERE bid=runningboard;
	ELSIF r=1 THEN --run/running
		cal := ch1+ch2+ch3;
		IF (cc1 = cc2) and (cc1 = cc3) THEN --RUNNING
			UPDATE server_boards SET crit1 = 90 WHERE bid=runningboard;
			UPDATE server_boards SET crit2=cal WHERE bid=runningboard;
		ELSE  --RUN
			UPDATE server_boards SET crit1 = 80 WHERE bid=runningboard;
			UPDATE server_boards SET crit2=cal WHERE bid=runningboard;
		END IF;
	ELSE --HIGH CARDS
		cal := topcard(ch1, ch2, ch3);
		UPDATE server_boards SET crit1 = 0 WHERE bid=runningboard;		
		UPDATE server_boards SET crit2=cal WHERE bid=runningboard;		
	END IF;
	commit;
	
	r := runornot(ch4, ch5, ch6);
	--criteria_site(runningboard,ch4,ch5,ch6,cc4,cc5,cc6);
	IF (ch4 = ch5) and (ch4 = ch6) THEN --TRIO
		cal := ch4+ch5+ch6;
		UPDATE site_boards@site61 SET crit1 = 100 WHERE bid=runningboard;
		UPDATE site_boards@site61 SET crit2=cal WHERE bid=runningboard;
	ELSIF ch4 = ch5 THEN --PAIR
		cal := ch4+ch5;
		UPDATE site_boards@site61 SET crit1 = cal WHERE bid=runningboard;
		UPDATE site_boards@site61 SET crit2=ch6 WHERE bid=runningboard;
	ELSIF ch4 = ch6 THEN --PAIR
		cal := ch4+ch6;
		UPDATE site_boards@site61 SET crit1 = cal WHERE bid=runningboard;
		UPDATE site_boards@site61 SET crit1 = cal, crit2=ch5 WHERE bid=runningboard;
	ELSIF ch5 = ch6 THEN --PAIR
		cal := ch5+ch6;
		UPDATE site_boards@site61 SET crit1 = cal WHERE bid=runningboard;
		UPDATE site_boards@site61 SET crit2=ch4 WHERE bid=runningboard;
	ELSIF (cc4 = cc5) and (cc4 = cc6) THEN --FLASH
		cal := topcard(ch4, ch5, ch6);
		UPDATE site_boards@site61 SET crit1 = 70 WHERE bid=runningboard;
		UPDATE site_boards@site61 SET crit2=cal WHERE bid=runningboard;
	ELSIF r=1 THEN --run/running
		cal := ch4+ch5+ch6;
		IF (cc4 = cc5) and (cc4 = cc6) THEN --RUNNING
			UPDATE site_boards@site61 SET crit1 = 90 WHERE bid=runningboard;
			UPDATE site_boards@site61 SET crit2=cal WHERE bid=runningboard;
		ELSE  --RUN
			UPDATE site_boards@site61 SET crit1 = 80 WHERE bid=runningboard;
			UPDATE site_boards@site61 SET crit2=cal WHERE bid=runningboard;
		END IF;
	ELSE --HIGH CARDS
		cal := topcard(ch4, ch5, ch6);
		UPDATE site_boards@site61 SET crit1 = 0 WHERE bid=runningboard;		
		UPDATE site_boards@site61 SET crit2=cal WHERE bid=runningboard;		
	END IF;
	commit;
	
	
	FOR R IN (SELECT crit1, crit2 FROM server_boards WHERE bid=runningboard) LOOP
		valueserver1 := R.crit1;
		valueserver2 := R.crit2;
	END LOOP;
	FOR R IN (SELECT crit1, crit2 FROM site_boards@site61 WHERE bid=runningboard) LOOP
		valuesite1 := R.crit1;
		valuesite2 := R.crit2;
	END LOOP;
	
	IF valueserver1=valuesite1 THEN
		IF (valueserver2=valuesite2) or (valuesite2>valueserver2) THEN
			dbms_output.put_line('you lose');
			UPDATE server_boards SET status = 'lose', earnings=0 WHERE bid=runningboard;
			SELECT bet into betamount FROM server_boards WHERE bid=runningboard;
			UPDATE site_boards@site61 SET status = 'win', earnings=betamount WHERE bid=runningboard;
		ELSE 
			dbms_output.put_line('you win');
			SELECT bet into betamount FROM site_boards@site61 WHERE bid=runningboard;
			UPDATE server_boards SET status = 'win', earnings=betamount WHERE bid=runningboard;
			UPDATE site_boards@site61 SET status = 'lose', earnings=0 WHERE bid=runningboard;
		END IF;
	ELSIF valueserver1>valuesite1 THEN
		dbms_output.put_line('you win');
		SELECT bet into betamount FROM site_boards@site61 WHERE bid=runningboard;
		UPDATE server_boards SET status = 'win', earnings=betamount WHERE bid=runningboard;
		UPDATE site_boards@site61 SET status = 'lose', earnings=0 WHERE bid=runningboard;
	ELSE
		dbms_output.put_line('you lose');
		UPDATE server_boards SET status = 'lose', earnings=0 WHERE bid=runningboard;
		SELECT bet into betamount FROM server_boards WHERE bid=runningboard;
		UPDATE site_boards@site61 SET status = 'win', earnings=betamount WHERE bid=runningboard;
	END IF;
	commit;
	
	
END;
/


