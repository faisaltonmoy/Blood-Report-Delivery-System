SET SERVEROUTPUT ON;
SET VERIFY OFF;
clear screen;
SET linesize 300;
SET pagesize 200;


DECLARE

BEGIN
	DBMS_OUTPUT.PUT_LINE('Enter the following number to execute corresponding operation:');
	DBMS_OUTPUT.PUT_LINE(CHR(9));
	DBMS_OUTPUT.PUT_LINE('1. Get information of a patient');
	DBMS_OUTPUT.PUT_LINE('2. Get information of a patient''s Blood Report');
	DBMS_OUTPUT.PUT_LINE('3. Check if a patient''s Blood Report is delivered to him or not');
	DBMS_OUTPUT.PUT_LINE('4. Get names of those patients whose Blood Reports are yet to deliver');
	DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------');

END;
/

