SET SERVEROUTPUT ON;
SET VERIFY OFF;

drop table newTable;
create table newTable as
select * from lawyer
union
select * from lawyer@site2;

select S.C_id, B.L_id, B.lawyer_name, B.win, B.loss, B.percentage
from cases@site2 S inner join newTable B
on S.L_id = B.L_id where S.results = -2;

accept X number prompt "Enter a case id = "
accept Y number prompt "Enter the lawyer id = "
accept Z number prompt "Press 1 for WIN and 0 for LOSS = "

declare
	caseId int;
	lawId int;
	w int;
	b int;
	c int;
	f1 float;
	f2 float;
	res float;
	a1 int;
	a2 int;
	a3 float;
begin
	caseId := &X;
	lawId := &Y;
	w := &Z;
	select win into b from newTable where L_id = lawId;
	select loss into c from newTable where L_id = lawId;
	if w = 1 then
		b := b+1;
	else
		c := c+1;
	end if;
	f1 := b*1.0;
	f2 := (b+c)*1.0;
	res := (f1/f2)*100.0;
	if lawId < 7 then 
		update lawyer@site2 set win = b, loss = c, percentage = res where L_id = lawId;
	else
		update lawyer set win = b, loss = c, percentage = res where L_id = lawId;
	end if;
	delete from cases@site2 where case_id = caseId;
	DBMS_OUTPUT.PUT_LINE('Thanks for your rating');
	if lawId < 7 then 
		select win, loss into a1, a2  from lawyer@site2 where L_id = lawId;
	else
		select win, loss into a1, a2  from lawyer where L_id = lawId;
	end if;
	DBMS_OUTPUT.PUT_LINE('Current Win : '||a1);
	DBMS_OUTPUT.PUT_LINE('Current loss : '||a2);
	DBMS_OUTPUT.PUT_LINE('Current Percentage : '||a3);
end;
/

commit;