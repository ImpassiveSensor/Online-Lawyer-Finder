clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;

drop table newTable;
create table newTable as
	select * from lawyer
		union
	select * from lawyer@site1;

create or replace view myView(ID, NAME, PERCENTAGE, Sector, AREA) as
	select L_id, lawyer_name, percentage, lawyer_type, lawyer_address
	from newTable order by percentage desc;
	
begin
	DBMS_OUTPUT.PUT_LINE('TOP 5 LAWYERS OF OUR COMPANY');
end;
/
	
select NAME, Sector, PERCENTAGE, AREA from myview where rownum <= 5;

accept Y char prompt "Enter Type = "

declare
	lType lawyer.lawyer_type%type;
	a int;
begin
	lType := '&Y';
	DBMS_OUTPUT.PUT_LINE('The '||lType||' types lawyers are : ');
	for i in (select ID, NAME, PERCENTAGE, AREA from myview where Sector like lType order by PERCENTAGE desc) loop
		DBMS_OUTPUT.PUT_LINE('ID: '||i.ID||'	Name: '||i.NAME||'		Percentage: '||i.PERCENTAGE||'		Area: '||i.AREA);
	end loop;
end;
/
commit;

@"D:\C\Semester 4.1\Distributed Database\Lab\Lab- 5\sendingRequest.sql"