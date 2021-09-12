SET SERVEROUTPUT ON;
SET VERIFY OFF;

CREATE OR REPLACE PACKAGE myCases AS

	FUNCTION yesOrNo(A1 IN NUMBER)
	RETURN NUMBER;
	
	PROCEDURE finding(B1 IN NUMBER);
END myCases;
/

CREATE OR REPLACE PACKAGE BODY myCases AS

	FUNCTION yesOrNo(A1 IN NUMBER)
	RETURN NUMBER
	IS 
	counter int;
	BEGIN
		select count(L_id) into counter from cases where L_id = A1;
		return counter;
	END yesOrNo;
	
	PROCEDURE finding(B1 IN NUMBER)
	IS
	b int;
	ch varchar2(20);
	ch2 varchar2(20);
	BEGIN
		DBMS_OUTPUT.PUT_LINE('Your current cases are:');
		for i in (select * from cases where L_id = B1 and results = -1) loop
			b := i.C_id;
			select client_name, client_phone into ch, ch2 from newTable2 where C_id = b;
			DBMS_OUTPUT.PUT_LINE('CASE ID: '||i.case_id||'	Name: '||ch||'		Phone: '||ch2);
		end loop;
	END finding;
	
END myCases;
/


accept X number prompt "Enter your Lawyer ID = "

declare
	id int;
	b int;
begin
	id := &X;
	b := myCases.yesOrNo(id);
	if b = 0 then
		DBMS_OUTPUT.PUT_LINE('You have no cases now.');
	else
		myCases.finding(id);
	end if;
end;
/

commit;

@"D:\C\Semester 4.1\Distributed Database\Lab\Lab- 5\markAsDone.sql"