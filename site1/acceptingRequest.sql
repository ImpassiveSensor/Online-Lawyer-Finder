SET SERVEROUTPUT ON;
SET VERIFY OFF;

CREATE OR REPLACE TRIGGER accepted 
AFTER INSERT 
ON cases
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('Request accepted and case is generated(from trigger)');
END;
/

accept X number prompt "Enter your Lawyer ID = "
accept Y number prompt "Enter the request ID to accept = "

declare
	id int;
	req int;
	b int;
	c int;
begin
	id := &X;
	req := &Y;
	for i in (select * from request) loop
		c := i.C_id;
	end loop;
	for i in (select * from cases) loop
		b := i.case_id;
	end loop;
	b := b+1;
	insert into cases values(b, id, c, -1);
	delete from request where req_id = req;
end;
/

commit;

@"D:\C\Semester 4.1\Distributed Database\Lab\Lab- 5\currentCases.sql"