3) qtn
create table team(tid  varchar(10)primary key,tname  varchar(10),city  varchar(15), coach varchar(10),captain_id  varchar(10));

insert into team values('T001','INDIA','MUMBAI','CLARK','PA01');
insert into team values('T002','PAKISTHAN','GULF','MULLA','PB01');
insert into team values('T003','AFRICA','GERF','SMITH','PA02');
insert into team values('T004','AUSTRALIA','DENMARK','SAMMY','PA03');
insert into team values('T009','KXIP ','PUNJAB','NULL','PB02');





create table player (pid varchar(10) primary key,  pname varchar(10),  age int(3),  tid varchar(10),  foreign key (tid) references team(tid));

insert into player values('PA01','KHOLI',25,'T001');
insert into player values('PA02','YURAJ',29,'T001');
insert into player values('PA03','ISHANT',32,'T001');
insert into player values('PB01','SMARK',29,'T002');
insert into player values('PB02','SMITH',25,'T002');
insert into player values('PB03','BAHU',21,'T003');

select * from player;

create table playerphone1(pid varchar(10),phone INT(10),foreign key(pid) references player(pid));
insert into playerphone1 values('PA01','946572311');
insert into playerphone1 values('PA02','946117568');
insert into playerphone1 values('PB01','946532467');
insert into playerphone1 values('PB02','863451311');
insert into playerphone1 values('PA03','941563248');

select * from playerphone1;


create table stadium(stid varchar(10) primary key,stname varchar(10),city varchar(10), area varchar(10),pin varchar(6));
insert into stadium values('S001','INDIA','MUMBAI','SAHPA','509103');
insert into stadium values('S002','AFRICA','GERF','OCEAN','579621');
insert into stadium values('S003','AUSTRALIA','DENMARK','OCEAN','579212');

select * from stadium;



create table matches(mid varchar(10) primary key,mdate varchar(10),time int(5),stid varchar(10),tid1 varchar(10),tid2 varchar(10),mom varchar(10),winnerid varchar(10),foreign key(stid) references stadium(stid),foreign key(tid1) references team(tid),foreign key(tid2) references team(tid),foreign key(winnerid) references team(tid),foreign key(mom) references player(pid));
insert into matches values('M1','11-DEC-16',3,'S001','T001','T002','PA01','T001');
insert into matches values('M2','16-DEC-16',4,'S002','T003','T001','PB01','T003');
insert into matches values('M3','24-DEC-16',12,'S001','T001','T003','PB03','T001');
insert into matches values('M4','25-DEC-16',10,'S003','T002','T003','PA02','T002');
insert into matches values('M5','29-DEC-16',12,'S001','T004','T002','PB03','T002');

select * from matches;


Queries:-
i. Display the youngest player (in terms of age) Name, Team name, age in which he belongs of the
tournament.
select Tname,Pname,age from team,player where team.Tid=player.Tid and age in(select min(age) from player);


ii. List the details of the stadium where the maximum number of matches were played.
select * from stadium where stid in(select stid from matches group by stid having count(stid)=(select max(total) from (select count(stid) as total from matches group by stid) as result));



iii. List the details of the player who is not a captain but got the man_of _match award at least in two
matches.
select * from player where pid in(select mom from matches group by mom having count(mom) > 1 and mom not in(select captain_id from team));


iv. Display the Team details who won the maximum matches.
select * from team where tid in(select winnerid from matches group by winnerid having count(winnerid)=(select max(total) from (select count(winnerid) as total from matches group by winnerid) as result));

v. Display the team name where all its won matches played in the same stadium.
select tname from team where tid in(select winnerid from matches group by winnerid having count(distinct stid)=1);