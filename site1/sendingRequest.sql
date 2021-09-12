SET SERVEROUTPUT ON;
SET VERIFY OFF;

accept X number prompt "Enter your ID = "
accept Y number prompt "Enter lawyer ID to request = "

declare
	choice int;
	id int;
	boro int;
	negativeError exception;
	zeroError exception;
begin
	id := &X;
	choice := &Y;
	if choice < 0 or id < 0 then
		raise negativeError;
	elsif choice = 0 or id = 0 then
		raise zeroError;
	end if;
	for i in (select * from request) loop
		boro := i.req_id;
	end loop;
	boro := boro+1;
	insert into request values(boro, choice, id, 0);
	DBMS_OUTPUT.PUT_LINE(' ');
	DBMS_OUTPUT.PUT_LINE('Your request is sent successfully');
	exception
		when negativeError then
			DBMS_OUTPUT.PUT_LINE('ID can not be negative');
		when zeroError then
			DBMS_OUTPUT.PUT_LINE('ID can not be zero');
		when others then
			DBMS_OUTPUT.PUT_LINE('Other errors');
	
end;
/
select * from request;
commit;

@"D:\C\Semester 4.1\Distributed Database\Lab\Lab- 5\lawyerRequests.sql"