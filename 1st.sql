create table branch(branch_id varchar(10) primary key, b_name varchar(10), hod varchar(10));
insert into branch values('M.tech03','M.tech','Dharshan');
insert into branch values('MBA02','MBA','vignesh');
insert into branch values('MCA01','MCA','Ashishkuma');
select * from branch;



create table student(usn varchar(10) primary key,name varchar(10),address varchar(10),branch_id varchar(10),sem  int(5),foreign key(branch_id) references branch(branch_id));
insert into student values('12mtech','Yogesh','Banglore','M.tech03',4);
insert into student values('13mtech03','Krishna','Banglore','M.tech03',3);
insert into student values('15mca16','Manjo','Banglore','MCA01',2);
insert into student values('16mba15','Ashish','Banglore','MBA02',4);
insert into student values('16mba16','Raju','Banglore','MBA02',4);
insert into student values('16mca02','Gopal','Banglore','MCA01',2);
insert into student values('16mca14','Harish','Banglore','MCA01',2);
select * from student;




create table author(author_id varchar(5) primary key,author_name varchar(10),country varchar(5),age int(3));
insert into author values('A001','ramachandr','INDIA',50);
insert into author values('A002','prakash','INDIA',60);
insert into author values('A003','bala guru','INDIA',65);
insert into author values('A004','peterson','USA',60);
insert into author values('A005','alex','UK',75);
select * from author;




create table book(book_id varchar(5) primary key,book_name varchar(10),author_id varchar(5),publisher varchar(10),branch_id varchar(10),foreign key(branch_id) references branch(branch_id),foreign key(author_id) references author(author_id));
insert into book values('B001','HTML','A001','THAKUR','MCA01');
insert into book values('B002','MICROBIO','A004','THAKUR','M.tech03');
insert into book values('B003','COBOL','A005','PEARSON','M.tech03');
insert into book values('B006','JAVA','A001','THAKUR','MCA01');
insert into book values('B007','PYTHON','A001','THAKUR','MCA01');
insert into book values('B008','CPROGRAM','A003','THAKUR','MCA01');
select * from book;





create table barrow(usn varchar(10),book_id varchar(5),barrow_date varchar(10),foreign key(book_id) references book(book_id),foreign key(usn) references student(usn));
insert into barrow values('16mca02','B001','01-Dec-16');
insert into barrow values('16mca02','B002','06-Dec-16');
insert into barrow values('16mca14','B003','03-Dec-16');
insert into barrow values('16mca02','B007','19-Dec-16');
insert into barrow values('16mba15','B008','01-Dec-16');
select * from barrow;





Queries:-
i. List the details of Students who are all studying in 2nd sem MCA.

select * from student,branch where student.branch_id=branch.branch_id and b_name='MCA' and sem='2';



ii.List the students who are not borrowed any books.

select distinct name from student,book,barrow where student.usn not in(select barrow.usn from student,barrow where student.usn=barrow.usn);



iii. Display the USN, Student name, Branch_name, Book_name, Author_name, Books_Borrowed_Date of 2nd sem MCA Students who borrowed books.

select distinct student.usn,name,b_name,book_name,author_name,barrow_date from student,branch, book,author,barrow where student.usn=barrow.usn and branch.branch_id=student.branch_id and barrow.book_id=book.book_id and author.author_id=book.author_id and branch.b_name='MCA' and sem='2';





iv. Display the number of books written by each Author.

select count(author.author_id),author_name from book,author where book.author_id=author.author_id group by author_name;


v.Display the student details who borrowed more than two books.

select name,address,branch_id,sem,count(barrow.usn) from student,barrow where barrow.usn=student.usn group by name,address,branch_id, sem having count(barrow.usn)>2;




vi.Display the student details who borrowed books of more than one Author. 

select * from student where exists(select barrow.usn from barrow ,book where barrow.book_id=book.book_id and barrow.usn=student.usn group by usn having count(distinct author_id)>1);



vii.Display the Book names in descending order of their names.

select * from book order by book_name desc;



viii.List the details of students who borrowed the books which are all published by the same publisher.

select name,student.usn,address,publisher from book,student,barrow where book.book_id=barrow.book_id and barrow.usn=student.usn group by publisher,name,student.usn,address having count(publisher)>1;

