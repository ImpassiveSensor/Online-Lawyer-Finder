SET SERVEROUTPUT ON;
SET VERIFY OFF;

accept X number prompt "Enter the case id which you want to mark as done = "

declare
	id int;
	b int;
	
begin
	id := &X;
	update cases set results = -2 where case_id = id;
	DBMS_OUTPUT.PUT_LINE('Case is marked as done. Please wait for the rating');
end;
/

commit;