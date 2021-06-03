/* Task 2.2 to 2.4            */
/* Primary keys for student is a combination of major initials and year group */
/* Primary keys for Faculty is a combination of academic rank and year employed */
/* Primary keys for Course code is a combination of course name initials and year  */
/* Primary key for University is universityID which is a combination of university name and year founded */
/* Paper name was made unique because it was a table merged with courses and it was a primary key. Two tables cant have a primary key so it was made unique */ 
drop schema if exists examination_database;
create schema examination_database;
use examination_database;

create table if not exists Users (
User_ID varchar(30),
username char(20),
email varchar(30),
primary key(User_ID)
);

create table if not exists Faculty ( 
User_ID varchar(30),
department_room_number varchar(20),
year_employed integer,
salary decimal(5,1),
academic_rank char(25),
PRIMARY KEY (User_ID),
FOREIGN KEY (User_ID) REFERENCES Users(User_ID) ON UPDATE CASCADE);

create table if not exists University (
 university_name char(35),
 university_ID varchar(20),
 location char(20),
 student_capacity integer,
 faculty_capacity integer,
 address varchar(35),
 year_founded integer,
 maximum_number_of_courses_offered integer,
 PRIMARY KEY (university_ID)
 );
 create table if not exists Student (
User_ID varchar(30),
username char(20),
email varchar(21),
mobile integer,
hostel_number integer,
name_of_parent char(35),
year_group integer,
major char(30),
university_ID varchar(20),
PRIMARY KEY (User_ID),
FOREIGN KEY (university_ID) REFERENCES University(university_ID),
FOREIGN KEY (User_ID) REFERENCES Users(User_ID) ON UPDATE CASCADE
);
create table if not exists UniversityFaculty (
 university_ID varchar(20),
 User_ID varchar(30),
 FOREIGN KEY (User_ID) REFERENCES Users(User_ID),
 FOREIGN KEY (university_ID) REFERENCES University(university_ID)
);

create table if not exists Courses (
course_code varchar(10),
course_name varchar(30),
course_type char(15),
course_year integer,
course_description varchar(130),
student_course_capacity integer,
paper_name varchar(35) unique,
start_time time,
end_time time,
date_of_exam date,
type_description varchar(70),
number_of_scripts integer,
university_ID varchar(20),
PRIMARY KEY (course_code),
FOREIGN KEY (university_ID) REFERENCES University(university_ID)
 );
 
create table if not exists StudentCourses (
User_ID varchar(30),
course_code varchar(10),
FOREIGN KEY (User_ID) REFERENCES Users(User_ID),
FOREIGN KEY (course_code) REFERENCES Courses(course_code)
);

create table if not exists Marks (
course_code varchar(10),
score decimal(4,1),
type_of_score varchar(15),
User_ID varchar(30),
FOREIGN KEY (course_code) REFERENCES Courses(course_code),
FOREIGN KEY (User_ID) REFERENCES Users(User_ID)
);

INSERT INTO Users (user_ID,username,email) VALUES
('CE2022','Jojo Fynn Mensah','jojofynnmensah@gmail.com'),
('CS2012','Kofi Appiah','KofiAppiah@gmail.com'),
('EE2023','David Sampah','davidsampah@gmail.com'),
('MIS2019','Vera Bordah','verabordah@gmail.com'),
('ME2021','Deborah Date','deborahdate@gmail.com'),
('Adjunct2012','Mary Domfeh','marydomfeh@gmail.com'),
('Dean2015','Hillary Mensah','hillarymensah@gmail.com'),
('Associate2018','Philip Mensah','philipmensah@gmail.com'),
('Lecturer2017','Vera Ashong','veraashong@gmail.com'),
('Professor2019','madeleine mensah','madeleine@gmail.com');
INSERT INTO Student (user_id,mobile,hostel_number, name_of_parent,year_group,major) VALUES
('CE2022', 0545101647, 1309, 'Ismael Waheed', '2022', 'Computer Engineering'),
('CS2012', 0543450914, 1230, 'Hamed Yoris', '2012', 'Computer Science'),
('EE2023', 0528550914, 1130, 'Sarah Amankwaa', '2023', 'Electrical Engineering'),
('MIS2019',0543450814, 1430, 'Joseph Amtwi', '2019', 'Management Information Systems'),
('ME2021',0243450914, 4130, 'Kyem Quansah', '2021', 'Mechanical Engineering');
INSERT INTO Faculty (user_id,department_room_number,year_employed,salary,academic_rank) VALUES
('Adjunct2012','EE2345', 5000.0, 2012,'Adjunct Lecturer'),
('Dean2015','CE2345', 15000.0, 2015,'Dean of Engineering'),
('Associate2018','ME2315', 12000.0, 2018,'Associate Professor'),
('Lecturer2017','CS2145', 18000.0, 2017,'Lecturer'),
('Professor2019','MIS2845', 20000.0, 2019,'Adjunct Professor');
INSERT INTO University (university_name,university_ID, location,student_capacity, faculty_capacity,address,year_founded, maximum_number_of_courses_offered) VALUES
('Ashesi University', 'Ashesi2000','Berekuso', 1000, 650, '1 Berekuso Street P.O. box 1248', 2000, 56),
('Legon University', 'Legon1979','Legon', 4000, 1000, '1 Legon Street P.O. box 1358', 1979, 66),
('Kwame Nkruamah University', 'KwameNkrumah1982','Kumasi', 3000, 500, '1 Kumasi Street P.O. box 3358', 1982, 23),
('Central University', 'Central2005','Legon', 2000, 900, '1 Accra Street P.O. box 1158', 2005, 31),
('University of Mines', 'Mines1985','Tamale', 300, 200, '1 Tamale Street P.O. box 1033', 1985, 40);
INSERT INTO UniversityFaculty (user_ID,university_ID) VALUES
('Adjunct2012','Ashesi2000'),
('Dean2015','Legon1979'),
('Associate2018','KwameNkrumah1982'),
('Lecturer2017','Central2005'),
('Professor2019','Mines1985');
INSERT INTO Courses (course_code,course_name,course_type,course_year,course_description,student_course_capacity,paper_name,start_time,end_time,date_of_exam,type_description,number_of_scripts,university_ID) VALUES
('MD2022','Mechanical Design','Full credit', 2022, 'This course teaches students the concepts in engineeering design', 20, 'Mechanical Design Final Exam', '12:30:00','15:30:00', '2022-03-06', 'This final exams is 40% of students grade',20,'Ashesi2000'),
('CS2021','Control System','Half credit', 2021, 'This course teaches students how to use control systems to model', 15, 'Control System Final Exam', '13:30:00','18:30:00', '2021-03-06', 'This final exams is 30% of students grade',15,'Ashesi2000'),
('SD2023','System Dynamics','Full credit', 2023, 'This course teaches students how to use mathematical equations to model', 12, 'System Dynamics Final Exam', '14:30:00','16:30:00', '2023-03-06', 'This final exams is 18% of students grade',12,'Legon1979'),
('DBMS2020','Database Management System','Half credit', 2020, 'This course teaches students how to create databases', 100, 'Databases Final Exam', '12:30:00','13:30:00', '2020-03-06', 'This final exams is 49% of students grade',100,'Legon1979'),
('DM2019','Discrete Math','Full credit', 2019, 'This course teaches students how to use discrete mathematics', 28, 'Discrete Math Final Exam', '11:30:00','15:30:00', '2019-03-06', 'This final exams is 23% of students grade',28,'KwameNkrumah1982'),
('DS2012','Data Structures','Half credit', 2012, 'This course teaches students how to use data structures and Algorithms', 54, 'Data Structures Final Exam', '15:30:00','19:30:00', '2012-03-06', 'This final exams is 18% of students grade',54,'KwameNkrumah1982'),
('CE2024','Circuits and Electronics','Full credit', 2024, 'This course teaches students how to design and implement circuits and electronics', 45, 'Circuits and Electronics Final Exam', '14:30:00','16:30:00', '2024-03-06', 'This final exams is 24% of students grade',45,'Central2005'),
('ML2020','Machine Learning','Half credit', 2020, 'This course teaches students concepts in Machine Learning', 29, 'Machine Learning Final Exam', '20:30:00','22:30:00', '2020-03-07', 'This final exams is 98% of students grade',29,'Central2005'),
('DSD2021','Digital systems Design','Full credit', 2021, 'This course teaches students how to understand and implement digital logic', 40, 'Digital Systems Design Final Exam', '10:30:00','14:30:00', '2021-03-18', 'This final exams is 44% of students grade',40,'Mines1985'),
('POE2024','Principles of Economics','Half credit', 2024, 'This course teaches students principles in micro and macro-economics', 31, 'Principles of Economics Final Exam', '12:30:00','13:30:00', '2024-03-021', 'This final exams is 18% of students grade',31,'Mines1985');
INSERT INTO StudentCourses (user_ID,course_code) VALUES
('CE2022','MD2022'),
('CS2012','CS2021'),
('EE2023','DBMS2020'),
('MIS2019','SD2023'),
('ME2021','DM2019'),
('CE2022','DS2012'),
('CS2012','CE2024'),
('EE2023','ML2020'),
('MIS2019','DSD2021'),
('ME2021','POE2024');
INSERT INTO Marks (course_code,score,type_of_score,user_ID) VALUES
('MD2022',30.0, 'low', 'CE2022'),
('MD2022',30.0, 'low', 'Adjunct2012'),
('CS2021',60.0, 'high', 'CS2012'),
('CS2021',60.0, 'high', 'Dean2015'),
('DBMS2020',97.0, 'high', 'EE2023'),
('DBMS2020',97.0, 'high', 'Associate2018'),
('DM2019',20.0, 'low', 'MIS2019'),
('DM2019',20.0, 'low', 'Lecturer2017'),
('DS2012',55.0, 'high', 'ME2021'),
('DS2012',55.0, 'high', 'Professor2019'),
('CE2024',100.0, 'high', 'CE2022'),
('CE2024',100.0, 'high', 'Adjunct2012'),
('ML2020',94.0, 'high', 'CS2012'),
('ML2020',94.0, 'high', 'Dean2015'),
('DSD2021',29.0, 'low', 'EE2023'),
('DSD2021',29.0, 'low', 'Associate2018'),
('POE2024',75.0, 'high', 'ME2021'),
('POE2024',75.0, 'high','Lecturer2017'),
('SD2023',19.0, 'low', 'MIS2019'),
('SD2023',19.0, 'low', 'Professor2019');
