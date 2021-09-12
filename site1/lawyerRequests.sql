SET SERVEROUTPUT ON;
SET VERIFY OFF;

accept X number prompt "Enter your Lawyer ID = "

drop table newTable2;
create table newTable2 as 
	select * from client 
		union
	select * from client@site1;

create or replace procedure seeCases(A in int)
is
b int := 0;
ch client.client_name%type;
mb varchar2(20);
begin
	DBMS_OUTPUT.PUT_LINE('Your have requests of:');
	for i in (select * from request where L_id = A and status = 0) loop
		b := i.C_id;
		select client_name, client_phone into ch, mb from newTable2 where C_id = b;
		DBMS_OUTPUT.PUT_LINE('REQ ID: '||i.req_id||'	Name: '||ch||'		Phone: '||mb);
	end loop;
end seeCases;
/

create or replace function clientRequest(A in number)
return int
is
flag int := 0;

begin
	select count(L_id) into flag  from request where L_id = A;
	return flag;
end clientRequest;
/

declare
	id int;
	j int;
begin
	id := &X;
	DBMS_OUTPUT.PUT_LINE('-------------------LAWYER SCETION-------------------');
	DBMS_OUTPUT.PUT_LINE('Welcome');
	j := clientRequest(id);
	if j = 0 then
		DBMS_OUTPUT.PUT_LINE('You have no request yet');
	else
		seeCases(id);
	end if;
end;
/
commit;
@"D:\C\Semester 4.1\Distributed Database\Lab\Lab- 5\acceptingRequest.sql"