CREATE DATABASE Trip__Planner_App_Database;
USE Trip__Planner_App_Database;

-- USER Table
CREATE TABLE user (
    User_id VARCHAR(45) NOT NULL,
    Guid_id VARCHAR(45),
    First_Name VARCHAR(255) NOT NULL,
    Last_Name VARCHAR(255) NOT NULL,
    Gender VARCHAR(45) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    Profile_picture MEDIUMBLOB,
    PRIMARY KEY (User_id)
);

CREATE TABLE userEmail (
    Email VARCHAR(255) NOT NULL,
    Pwd VARCHAR(255) NOT NULL,
    PRIMARY KEY (Email),
    CONSTRAINT fk_userEmail_user FOREIGN KEY (Email) REFERENCES user(Email) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE userAge (
    User_id VARCHAR(45) NOT NULL,
    DOB DATE NOT NULL,
    Age INT NOT NULL,
    CONSTRAINT fk_userAge_user FOREIGN KEY (User_id) REFERENCES user(User_id) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE userPhone (
    User_id VARCHAR(45) NOT NULL,
    Phone_number VARCHAR(45),
    CONSTRAINT fk_userPhone_user FOREIGN KEY (User_id) REFERENCES user(User_id) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE tripUser (
    User_id VARCHAR(45) NOT NULL,
    Trip_id VARCHAR(45) NOT NULL,
    PRIMARY KEY (Trip_id),
    CONSTRAINT fk_tripUser_user FOREIGN KEY (User_id) REFERENCES user(User_id) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE trip (
    Trip_id VARCHAR(45) NOT NULL,
    Start_date DATE NOT NULL,
    End_date DATE NOT NULL,
    Status VARCHAR(45) NOT NULL,
    Description VARCHAR(255),
    -- PRIMARY KEY (Trip_id),
    CONSTRAINT fk_trip_tripUser FOREIGN KEY (Trip_id) REFERENCES tripUser(Trip_id) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE tripAccommodation (
    Trip_id VARCHAR(45) NOT NULL,
    Acco_id VARCHAR(45) NOT NULL,
    PRIMARY KEY (Acco_id),
    CONSTRAINT fk_tripAccommodation_trip FOREIGN KEY (Trip_id) REFERENCES trip(Trip_id) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE accommodation (
    Acco_id VARCHAR(45) NOT NULL,
    Acco_name VARCHAR(255) NOT NULL,
    Acco_state VARCHAR(45) NOT NULL,
    Acco_city VARCHAR(45),
    PRIMARY KEY (Acco_id),
    CONSTRAINT fk_tripAccommodation_accommodation FOREIGN KEY (Acco_id) REFERENCES tripAccommodation(Acco_id) ON DELETE NO ACTION ON UPDATE CASCADE
    -- INDEX idx_accommodation (Acco_id)
);

CREATE TABLE accomoPhone (
    Acco_id VARCHAR(45) NOT NULL,
    Phone_number VARCHAR(45),
    CONSTRAINT fk_accoPhone_accommodation FOREIGN KEY (Acco_id) REFERENCES accommodation(Acco_id) ON DELETE NO ACTION ON UPDATE CASCADE
);    

CREATE TABLE review (
    User_id VARCHAR(45) NOT NULL,
    Acco_id VARCHAR(45) NOT NULL,
    Comments VARCHAR(255),
    Rating ENUM('0', '1', '2', '3', '4', '5'),
    CONSTRAINT fk_review_user FOREIGN KEY (User_id) REFERENCES user(User_id),
    CONSTRAINT fk_review_accommodation FOREIGN KEY (Acco_id) REFERENCES accommodation(Acco_id) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE tripDestination (
    Trip_id VARCHAR(45) NOT NULL,
    Destination_id VARCHAR(45) NOT NULL,
    PRIMARY KEY (Destination_id),
    CONSTRAINT fk_tripDestination_trip FOREIGN KEY (Trip_id) REFERENCES trip(Trip_id) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE destination (
    Destination_id VARCHAR(45) NOT NULL,
    Longitude VARCHAR(45),
    Latitude VARCHAR(45),
    Destination_name VARCHAR(255) NOT NULL,
    Description VARCHAR(255),
	CONSTRAINT fk_destination_tripDestination FOREIGN KEY (Destination_id) REFERENCES tripDestination(Destination_id) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE activity (
    Destination_id VARCHAR(45) NOT NULL,
    Activity_name VARCHAR(255) NOT NULL,
    Activity_time TIME,
    CONSTRAINT fk_activity_destination FOREIGN KEY (Destination_id) REFERENCES destination(Destination_id) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE tripExpenses (
    Expense_id VARCHAR(45) NOT NULL,
    Trip_id VARCHAR(45) NOT NULL,
    PRIMARY KEY (Expense_id),
    CONSTRAINT fk_tripExpenses_trip FOREIGN KEY (Trip_id) REFERENCES trip(Trip_id) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE expenses (
    Expense_id VARCHAR(45) NOT NULL,
    Note VARCHAR(255),
    Amount DECIMAL(15, 3) NOT NULL,
    Category VARCHAR(45) NOT NULL,
    CONSTRAINT fk_expenses_tripExpenses FOREIGN KEY (Expense_id) REFERENCES tripExpenses(Expense_id) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE tripTransportation (
    Trip_id VARCHAR(45) NOT NULL,
    Trans_id VARCHAR(45) NOT NULL,
    PRIMARY KEY (Trans_id),
    CONSTRAINT fk_tripTransportation_trip FOREIGN KEY (Trip_id) REFERENCES trip(Trip_id) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE transportation (
    Trans_id VARCHAR(45) NOT NULL,
    Arrival_date DATETIME NOT NULL,
    Departure_date DATETIME NOT NULL,
    Location VARCHAR(255) NOT NULL,
    Mode VARCHAR(45) NOT NULL,
	CONSTRAINT fk_transportation_tripTransportation FOREIGN KEY (Trans_id) REFERENCES tripTransportation(Trans_id) ON DELETE NO ACTION ON UPDATE CASCADE
);

-- Insert 6 rows into the user table
INSERT INTO user (User_id, Guid_id, First_Name, Last_Name, Gender, Email, Profile_picture) VALUES
('user001', 'guid001', 'John', 'Doe', 'Male', 'john.doe@example.com', NULL),
('user002', 'guid002', 'Jane', 'Smith', 'Female', 'jane.smith@example.com', NULL),
('user003', 'guid003', 'Bob', 'Johnson', 'Male', 'bob.johnson@example.com', NULL),
('user004', 'guid004', 'Alice', 'Williams', 'Female', 'alice.williams@example.com', NULL),
('user005', 'guid005', 'Tom', 'Brown', 'Male', 'tom.brown@example.com', NULL),
('user006', 'guid006', 'Sara', 'Davis', 'Female', 'sara.davis@example.com', NULL);

-- Insert 6 rows into the userEmail table
INSERT INTO userEmail (Email, Pwd) VALUES
('john.doe@example.com', 'password1'),
('jane.smith@example.com', 'password2'),
('bob.johnson@example.com', 'password3'),
('alice.williams@example.com', 'password4'),
('tom.brown@example.com', 'password5'),
('sara.davis@example.com', 'password6');

-- Insert 6 rows into the userAge table
INSERT INTO userAge (User_id, DOB, Age) VALUES
('user001', '1990-05-15', 33),
('user002', '1985-11-22', 38),
('user003', '1992-03-08', 31),
('user004', '1988-07-01', 35),
('user005', '1995-12-28', 28),
('user006', '1982-09-10', 41);

-- Insert 6 rows into the userPhone table
INSERT INTO userPhone (User_id, Phone_number) VALUES
('user001', '1234567890'),
('user002', '9876543210'),
('user003', '5555555555'),
('user004', '1112223333'),
('user005', '4445556666'),
('user006', '7778889999');

-- Insert 6 rows into the tripUser table
INSERT INTO tripUser (User_id, Trip_id) VALUES
('user001', 'trip001'),
('user002', 'trip002'),
('user003', 'trip003'),
('user004', 'trip004'),
('user005', 'trip005'),
('user006', 'trip006');

-- Insert 6 rows into the trip table
INSERT INTO trip (Trip_id, Start_date, End_date, Status, Description) VALUES
('trip001', '2023-06-01', '2023-06-15', 'Planned', 'Summer vacation'),
('trip002', '2023-09-15', '2023-09-22', 'Planned', 'Fall getaway'),
('trip003', '2023-12-20', '2024-01-05', 'Planned', 'Winter holidays'),
('trip004', '2024-03-01', '2024-03-10', 'Planned', 'Spring break'),
('trip005', '2024-07-01', '2024-07-15', 'Planned', 'Summer adventure'),
('trip006', '2024-10-01', '2024-10-08', 'Planned', 'Fall foliage tour');

-- Insert 6 rows into the tripAccommodation table
INSERT INTO tripAccommodation (Trip_id, Acco_id) VALUES
('trip001', 'acco001'),
('trip002', 'acco002'),
('trip003', 'acco003'),
('trip004', 'acco004'),
('trip005', 'acco005'),
('trip006', 'acco006');

-- Insert 6 rows into the accommodation table
INSERT INTO accommodation (Acco_id, Acco_name, Acco_state, Acco_city) VALUES
('acco001', 'Beach Resort', 'Florida', 'Miami'),
('acco002', 'Mountain Lodge', 'Colorado', 'Aspen'),
('acco003', 'City Hotel', 'New York', 'New York City'),
('acco004', 'Countryside Inn', 'Vermont', 'Stowe'),
('acco005', 'Lake Cabin', 'Oregon', 'Bend'),
('acco006', 'Historic B&B', 'Massachusetts', 'Boston');

-- Insert 6 rows into the accomoPhone table
INSERT INTO accomoPhone (Acco_id, Phone_number) VALUES
('acco001', '1234567890'),
('acco002', '9876543210'),
('acco003', '5555555555'),
('acco004', '1112223333'),
('acco005', '4445556666'),
('acco006', '7778889999');

-- Insert 6 rows into the review table
INSERT INTO review (User_id, Acco_id, Comments, Rating) VALUES
('user001', 'acco001', 'Great beachfront location', '5'),
('user002', 'acco002', 'Beautiful mountain views', '4'),
('user003', 'acco003', 'Convenient location in the city', '3'),
('user004', 'acco004', 'Peaceful and cozy', '5'),
('user005', 'acco005', 'Lovely cabin by the lake', '4'),
('user006', 'acco006', 'Charming historic building', '3');

-- Insert 6 rows into the tripDestination table
INSERT INTO tripDestination (Trip_id, Destination_id) VALUES
('trip001', 'dest001'),
('trip002', 'dest002'),
('trip003', 'dest003'),
('trip004', 'dest004'),
('trip005', 'dest005'),
('trip006', 'dest006');

-- Insert 6 rows into the destination table
INSERT INTO destination (Destination_id, Longitude, Latitude, Destination_name, Description) VALUES
('dest001', '-80.1918', '25.7617', 'Miami Beach', 'Sunny beach destination'),
('dest002', '-106.8246', '39.1911', 'Aspen', 'Ski resort in the Rocky Mountains'),
('dest003', '-73.9865', '40.7306', 'New York City', 'Vibrant city with attractions'),
('dest004', '-72.7317', '44.4759', 'Stowe', 'Quaint New England town'),
('dest005', '-121.3153', '44.0582', 'Bend', 'Outdoor adventure hub'),
('dest006', '-71.0589', '42.3601', 'Boston', 'Historic city with rich culture');

-- Insert 6 rows into the activity table
INSERT INTO activity (Destination_id, Activity_name, Activity_time) VALUES
('dest001', 'Beach activities', '10:00:00'),
('dest002', 'Skiing', '09:00:00'),
('dest003', 'Museum tour', '13:00:00'),
('dest004', 'Hiking', '11:00:00'),
('dest005', 'Kayaking', '14:00:00'),
('dest006', 'Walking tour', '15:00:00');

-- Insert 6 rows into the tripExpenses table
INSERT INTO tripExpenses (Expense_id, Trip_id) VALUES
('exp001', 'trip001'),
('exp002', 'trip002'),
('exp003', 'trip003'),
('exp004', 'trip004'),
('exp005', 'trip005'),
('exp006', 'trip006');

-- Insert 6 rows into the expenses table
INSERT INTO expenses (Expense_id, Note, Amount, Category) VALUES
('exp001', 'Hotel stay', 1000.00, 'Accommodation'),
('exp002', 'Rental car', 500.00, 'Transportation'),
('exp003', 'Broadway show tickets', 200.00, 'Entertainment'),
('exp004', 'Hiking gear rental', 75.00, 'Activities'),
('exp005', 'Kayak rental', 50.00, 'Activities'),
('exp006', 'Tour guide fee', 100.00, 'Activities');

-- Insert 6 rows into the tripTransportation table
INSERT INTO tripTransportation (Trip_id, Trans_id) VALUES
('trip001', 'trans001'),
('trip002', 'trans002'),
('trip003', 'trans003'),
('trip004', 'trans004'),
('trip005', 'trans005'),
('trip006', 'trans006');

-- Insert 6 rows into the transportation table
INSERT INTO transportation (Trans_id, Arrival_date, Departure_date, Location, Mode) VALUES
('trans001', '2023-06-01 10:00:00', '2023-06-15 16:00:00', 'Miami, FL', 'Airplane'),
('trans002', '2023-09-15 08:00:00', '2023-09-22 20:00:00', 'Aspen, CO', 'Car'),
('trans003', '2023-12-20 12:00:00', '2024-01-05 18:00:00', 'New York City, NY', 'Train'),
('trans004', '2024-03-01 09:00:00', '2024-03-10 15:00:00', 'Stowe, VT', 'Car'),
('trans005', '2024-07-01 11:00:00', '2024-07-15 17:00:00', 'Bend, OR', 'Airplane'),
('trans006', '2024-10-01 14:00:00', '2024-10-08 11:00:00', 'Boston, MA', 'Bus');

-- Update 2 rows in the user table
UPDATE user SET First_Name = 'Johnny', Last_Name = 'Appleseed' WHERE User_id = 'user001';

-- error
UPDATE user SET Email = 'jane.doe@example.com' WHERE User_id = 'user002';

-- Update 2 rows in the userEmail table
UPDATE userEmail SET Pwd = 'newpassword1' WHERE Email = 'john.doe@example.com';
UPDATE userEmail SET Pwd = 'newpassword2' WHERE Email = 'jane.smith@example.com';

-- Update 2 rows in the userAge table
UPDATE userAge SET Age = 34 WHERE User_id = 'user001';
UPDATE userAge SET DOB = '1984-06-15' WHERE User_id = 'user002';

-- Update 2 rows in the userPhone table
UPDATE userPhone SET Phone_number = '9998887777' WHERE User_id = 'user001';
UPDATE userPhone SET Phone_number = '6667778888' WHERE User_id = 'user002';

-- Update 2 rows in the trip table
UPDATE trip SET Status = 'In Progress' WHERE Trip_id = 'trip001';
UPDATE trip SET Description = 'Family vacation' WHERE Trip_id = 'trip002';

-- Update 2 rows in the accommodation table
UPDATE accommodation SET Acco_city = 'Tampa' WHERE Acco_id = 'acco001';
UPDATE accommodation SET Acco_name = 'Mountain Resort' WHERE Acco_id = 'acco002';

-- Update 2 rows in the accomoPhone table
UPDATE accomoPhone SET Phone_number = '5555551234' WHERE Acco_id = 'acco001';
UPDATE accomoPhone SET Phone_number = '9876541230' WHERE Acco_id = 'acco002';

-- Update 2 rows in the review table
UPDATE review SET Comments = 'Excellent service' WHERE User_id = 'user001' AND Acco_id = 'acco001';
UPDATE review SET Rating = '4' WHERE User_id = 'user002' AND Acco_id = 'acco002';

-- Update 2 rows in the destination table
UPDATE destination SET Destination_name = 'South Beach' WHERE Destination_id = 'dest001';
UPDATE destination SET Description = 'World-class ski resort' WHERE Destination_id = 'dest002';

-- Update 2 rows in the activity table
UPDATE activity SET Activity_name = 'Surfing lessons' WHERE Destination_id = 'dest001';
UPDATE activity SET Activity_time = '10:00:00' WHERE Destination_id = 'dest002';

-- Update 2 rows in the expenses table
UPDATE expenses SET Amount = 1200.00 WHERE Expense_id = 'exp001';
UPDATE expenses SET Category = 'Food' WHERE Expense_id = 'exp002';

-- Update 2 rows in the transportation table
UPDATE transportation SET Mode = 'Cruise' WHERE Trans_id = 'trans001';
UPDATE transportation SET Location = 'Denver, CO' WHERE Trans_id = 'trans002';

DELETE FROM review WHERE User_id = 'user006' AND Acco_id = 'acco006';

DELETE FROM accomoPhone WHERE Acco_id = 'acco006';

DELETE FROM accommodation WHERE Acco_id = 'acco006';

DELETE FROM tripAccommodation WHERE Acco_id = 'acco006';

DELETE FROM activity WHERE Destination_id = 'dest006';

DELETE FROM destination WHERE Destination_id = 'dest006';

DELETE FROM tripDestination WHERE Destination_id = 'dest006';

DELETE FROM expenses WHERE Expense_id = 'exp006';

DELETE FROM tripExpenses WHERE Expense_id = 'exp006';

DELETE FROM transportation WHERE Trans_id = 'trans006';

DELETE FROM tripTransportation WHERE Trans_id = 'trans006';

DELETE FROM trip WHERE Trip_id = 'trip006';

DELETE FROM tripUser WHERE Trip_id = 'trip006';

DELETE FROM userPhone WHERE User_id = 'user006';

DELETE FROM userAge WHERE User_id = 'user006';

DELETE FROM userEmail WHERE Email = 'sara.davis@example.com';

DELETE FROM user WHERE User_id = 'user006';


-- simple queries

SELECT * FROM user; 

SELECT * FROM accomophone;

SELECT First_Name, Last_Name FROM user; 

SELECT u.First_Name, a.Acco_name FROM user u, accommodation a; 

CREATE VIEW user_profile AS SELECT User_id, First_Name, Last_Name, Email FROM user; 

SELECT u.First_Name AS FirstName, u.Last_Name AS LastName FROM user u; 

SELECT AVG(Amount) AS AverageExpense FROM expenses; 

SELECT * FROM user WHERE Email LIKE '%example.com'; 


--------------------------------------

-- basic set operation union

select destination_id, longitude, latitude,destination_name, description
from destination
union
select null as destination_id, null as longitude, null as latitude, acco_name as destination_name, 'Accommodation' as description
from accommodation
where acco_city = 'New York City';

-- basic set operation intersection

select d.destination_id,d.longitude, d.latitude, d.destination_name, d.description, a.acco_id, a.acco_name, a.acco_state,a.acco_city
from destination as d
join accommodation as a on d.destination_name = a.acco_name
where d.destination_id in (
		select destination_id
        from destination
        where acco_state='florida'
);

-- set difference

select destination_id,longitude,latitude,destination_name,description, null as Acco_id, null as Acco_name, null as Acco_state, null as Acco_city
from destination
where destination_name not in(
		select Acco_name
        from accommodation
        where Acco_city in('Miami','orlando')
);

-- division

select u.user_id, u.Guid_id,u.First_name, u.Last_name,u.Gender,u.Email, u.profile_picture
from user as u
where u.Gender='Male'
and not exists (
		select a.Acco_id 
        from accommodation a
        left join review as r on a.acco_id
        where r.Acco_id is null
);

-- inner join 

select u.user_id, u.guid_id,u.First_name,u.Last_name,u.gender,u.Email, u.profile_picture,tu.trip_id,t.start_date,t.end_date,t.status,t.description
from user as u
inner join tripuser as tu on u.user_id=tu.user_id
inner join trip as t on tu.trip_id=t.trip_id
where t.start_date>='2024.01.01' and t.end_date<='2024.12.31';

-- natural join

select u.user_id, u.Guid_id, u.First_Name, u.Last_Name, u.Gender, u.Email,ta.trip_id,a.Acco_id, a.Acco_name,a.Acco_state,a.Acco_city
from user as u
natural join tripuser as tu
natural join trip as t
natural join tripAccommodation as ta
natural join accommodation as a
where a.Acco_city ='New York City';

-- left outer join

select u.user_id, u.First_Name,u.Last_Name, u.Email,coalesce(r.comments,'No review') as Review
from user as u
left join review as r on u.user_id=r.user_id
where r.rating>='4';

-- Right outer join

select r.user_id,r.Acco_id,r.comments,r.Rating,a.Acco_name,a.Acco_state,a.Acco_city
from review as r
right join accommodation as a on r.Acco_id=a.Acco_id
where a.Acco_state ='colorado';

-- full outer join

select 
coalesce(u.user_id, 'No user') as user_id, 
coalesce(u.Guid_id, 'No user')As Guid_id, 
coalesce(u.First_name,'No user') As First_name,
 coalesce(u.Last_name,'No user')as Last_name, 
 coalesce(u.Gender,'No user')as Gender,
 coalesce(u.Email,'No user')as Email,
 coalesce(u.profile_picture,'No user')as profile_picture,
 coalesce(r.comments,'No review')as comments,
coalesce(r.Rating,'No review')as Rating
from user as u
left join review as r on u.user_id=r.user_id

union

select 
coalesce(u.user_id, 'No user') as user_id, 
coalesce(u.Guid_id, 'No user')As Guid_id, 
coalesce(u.First_name,'No user') As First_name,
 coalesce(u.Last_name,'No user')as Last_name, 
 coalesce(u.Gender,'No user')as Gender,
 coalesce(u.Email,'No user')as Email,
 coalesce(u.profile_picture,'No user')as profile_picture,
 coalesce(r.comments,'No review')as comments,
coalesce(r.Rating,'No review')as Rating
from user as u
right join review as r on u.user_id=r.user_id;

-- outer join

select Acco_id,Acco_name, Acco_state,Acco_city
from accommodation
where Acco_state='Florida'
union
select Acco_id,Acco_name,Acco_state,Acco_city
from accommodation
where Acco_state='colorado';

-- nested query with subquery

select u.user_id,u.First_name,u.Last_name,u.Email,up.Phone_number
from user as u
join userEmail as ue on u.Email=ue.Email
join userphone as up on u.User_id =up.User_id
where exists(
		select 1
        from review as r
        where r.user_id=u.user_id
);

-- nested query with aggregate function

select a.Acco_id,a.Acco_name,count(r.Acco_id)as review_count,avg(r.rating)as Avg_Rating
from accommodation as a
left join review as r on a.Acco_id=r.Acco_id
group by a.Acco_id,a.Acco_name
order by Review_count desc;

-- nested query with subquery and conditional count

select u.user_id,u.First_name,u.Last_name,count(tu.Trip_id)as Trip_count
from user as u
left join tripUser as tu on u.user_id=tu.user_id
group by u.user_id,u.First_name,u.last_name
having Trip_count>0;

-- tuning queries

-- 1)

-- Revised query

-- original query explain
EXPLAIN 
SELECT destination_id, longitude, latitude, destination_name, description
FROM destination
UNION
SELECT NULL AS destination_id, NULL AS longitude, NULL AS latitude, acco_name AS destination_name, 'Accommodation' AS description
FROM accommodation
WHERE acco_city = 'New York City';

-- tuned query 
EXPLAIN 
SELECT destination_id, longitude, latitude, destination_name, description
FROM (
    SELECT destination_id, longitude, latitude, destination_name, description
    FROM destination
    
    UNION ALL
    
    SELECT NULL AS destination_id, NULL AS longitude, NULL AS latitude, acco_name AS destination_name, 'Accommodation' AS description
    FROM accommodation
    WHERE acco_city = 'New York City'
) AS combined_data;

-- 2)

-- explain original query
EXPLAIN
SELECT destination_id, longitude, latitude, destination_name, description, 
       NULL as Acco_id, NULL as Acco_name, NULL as Acco_state, NULL as Acco_city
FROM destination
WHERE destination_name NOT IN (
    SELECT Acco_name
    FROM accommodation
    WHERE Acco_city IN ('Miami', 'Orlando')
);

-- explain tuned
EXPLAIN
SELECT d.destination_id, d.longitude, d.latitude, d.destination_name, d.description, 
       NULL as Acco_id, NULL as Acco_name, NULL as Acco_state, NULL as Acco_city
FROM destination d
LEFT JOIN accommodation a ON d.destination_name = a.Acco_name AND a.Acco_city IN ('Miami', 'Orlando')
WHERE a.Acco_name IS NULL;

-- 3)

-- explain original
EXPLAIN
SELECT u.user_id, u.guid_id, u.First_name, u.Last_name, u.gender, u.Email, u.profile_picture, 
       tu.trip_id, t.start_date, t.end_date, t.status, t.description
FROM user AS u
INNER JOIN tripuser AS tu ON u.user_id = tu.user_id
INNER JOIN trip AS t ON tu.trip_id = t.trip_id
WHERE t.start_date >= '2024-01-01' AND t.end_date <= '2024-12-31';

-- tuned explain
Explain
SELECT u.user_id, u.guid_id, u.First_name, u.Last_name, u.gender, u.Email, u.profile_picture, 
       tu.trip_id, t.start_date, t.end_date, t.status, t.description
FROM user AS u
INNER JOIN tripuser AS tu ON u.user_id = tu.user_id
INNER JOIN trip AS t ON tu.trip_id = t.trip_id
WHERE t.start_date >= '2024-01-01' AND t.end_date <= '2024-12-31';

-- 4)

-- explain original
EXPLAIN
SELECT 
    u.user_id, u.Guid_id, u.First_Name, u.Last_Name, u.Gender, u.Email,
    ta.trip_id,
    a.Acco_id, a.Acco_name,a.Acco_state,a.Acco_city
FROM 
    user AS u
NATURAL JOIN tripuser AS tu
NATURAL JOIN trip AS t
NATURAL JOIN tripAccommodation AS ta
NATURAL JOIN accommodation AS a
WHERE 
    a.Acco_city = 'New York City';


-- explain tuned
EXPLAIN
SELECT 
    u.user_id, 
    u.Guid_id, 
    u.First_Name, 
    u.Last_Name, 
    u.Gender, 
    u.Email,
    ta.trip_id,
    a.Acco_id, 
    a.Acco_name,
    a.Acco_state,
    a.Acco_city
FROM 
    user AS u
JOIN 
    tripuser AS tu ON u.user_id = tu.user_id
JOIN 
    trip AS t ON tu.trip_id = t.trip_id
JOIN 
    tripAccommodation AS ta ON t.trip_id = ta.trip_id
JOIN 
    accommodation AS a ON ta.Acco_id = a.Acco_id
WHERE 
    a.Acco_city = 'New York City';
    
-- 5)

-- explain original
EXPLAIN
SELECT 
	u.user_id, 
    u.First_Name,
    u.Last_Name,
    u.Email,
    COALESCE(r.comments,'No review') as Review
FROM user as u
LEFT JOIN review as r ON u.user_id=r.user_id AND r.rating>='4';

-- explain tuned
EXPLAIN
SELECT 
    u.user_id, 
    u.First_Name,
    u.Last_Name, 
    u.Email,
    COALESCE(r.Review, 'No review') AS Review
FROM 
    user AS u
LEFT JOIN 
    (SELECT user_id, comments AS Review FROM review WHERE rating >= 4) r ON u.user_id = r.user_id;

-- 6)

-- explain original
EXPLAIN
SELECT r.user_id, r.Acco_id, r.comments, r.Rating, a.Acco_name, a.Acco_state, a.Acco_city
FROM review AS r
RIGHT JOIN accommodation AS a ON r.Acco_id = a.Acco_id
WHERE a.Acco_state = 'Colorado';

-- explain tuned
EXPLAIN
SELECT 
    r.user_id, 
    r.Acco_id, 
    r.comments, 
    r.Rating, 
    a.Acco_name, 
    a.Acco_state, 
    a.Acco_city
FROM 
    (SELECT * FROM accommodation WHERE Acco_state = 'Colorado') AS a
LEFT JOIN 
    review AS r ON a.Acco_id = r.Acco_id;

-- 7)

-- explain original
Explain
select 
coalesce(u.user_id, 'No user') as user_id, 
coalesce(u.Guid_id, 'No user')As Guid_id, 
coalesce(u.First_name,'No user') As First_name,
 coalesce(u.Last_name,'No user')as Last_name, 
 coalesce(u.Gender,'No user')as Gender,
 coalesce(u.Email,'No user')as Email,
 coalesce(u.profile_picture,'No user')as profile_picture,
 coalesce(r.comments,'No review')as comments,
coalesce(r.Rating,'No review')as Rating
from user as u
left join review as r on u.user_id=r.user_id

union

select 
coalesce(u.user_id, 'No user') as user_id, 
coalesce(u.Guid_id, 'No user')As Guid_id, 
coalesce(u.First_name,'No user') As First_name,
 coalesce(u.Last_name,'No user')as Last_name, 
 coalesce(u.Gender,'No user')as Gender,
 coalesce(u.Email,'No user')as Email,
 coalesce(u.profile_picture,'No user')as profile_picture,
 coalesce(r.comments,'No review')as comments,
coalesce(r.Rating,'No review')as Rating
from user as u
right join review as r on u.user_id=r.user_id;

-- explain tuned
Explain
SELECT 
    COALESCE(u.user_id, 'No user') AS user_id, 
    COALESCE(u.Guid_id, 'No user') AS Guid_id, 
    COALESCE(u.First_name, 'No user') AS First_name,
    COALESCE(u.Last_name, 'No user') AS Last_name, 
    COALESCE(u.Gender, 'No user') AS Gender,
    COALESCE(u.Email, 'No user') AS Email,
    COALESCE(u.profile_picture, 'No user') AS profile_picture,
    COALESCE(r.comments, 'No review') AS comments,
    COALESCE(r.Rating, 'No review') AS Rating
FROM user AS u
LEFT JOIN review AS r ON u.user_id = r.user_id
UNION ALL
SELECT 
    'No user', 
    'No user', 
    'No user',
    'No user', 
    'No user',
    'No user',
    'No user',
    COALESCE(r.comments, 'No review'),
    COALESCE(r.Rating, 'No review')
FROM review AS r
WHERE NOT EXISTS (
    SELECT 1 FROM user WHERE user_id = r.user_id
);

-- 8)

-- explain original
Explain
select Acco_id,Acco_name, Acco_state,Acco_city
from accommodation
where Acco_state='Florida'
union
select Acco_id,Acco_name,Acco_state,Acco_city
from accommodation
where Acco_state='colorado';

-- explain tuned
Explain
SELECT Acco_id, Acco_name, Acco_state, Acco_city
FROM accommodation
WHERE Acco_state IN ('Florida', 'Colorado');

-- 9)

-- explain original
Explain
select u.user_id,u.First_name,u.Last_name,u.Email,up.Phone_number
from user as u
join userEmail as ue on u.Email=ue.Email
join userphone as up on u.User_id =up.User_id
where exists(
		select 1
        from review as r
        where r.user_id=u.user_id
);

-- explain tuned
Explain
SELECT u.user_id, u.First_name, u.Last_name, u.Email, up.Phone_number
FROM user AS u
INNER JOIN review AS r ON u.user_id = r.user_id
INNER JOIN userEmail AS ue ON u.Email = ue.Email
INNER JOIN userphone AS up ON u.user_id = up.User_id
GROUP BY u.user_id, u.First_name, u.Last_name, u.Email, up.Phone_number;


-- 10)

-- explain original
Explain
select a.Acco_id,a.Acco_name,count(r.Acco_id)as review_count,avg(r.rating)as Avg_Rating
from accommodation as a
left join review as r on a.Acco_id=r.Acco_id
group by a.Acco_id,a.Acco_name
order by Review_count desc;


-- exolain tuned
Explain
SELECT 
    a.Acco_id,
    a.Acco_name,
    COUNT(r.Acco_id) AS review_count,
    AVG(r.rating) AS Avg_Rating
FROM 
    accommodation AS a
LEFT JOIN 
    review AS r ON a.Acco_id = r.Acco_id
GROUP BY 
    a.Acco_id, a.Acco_name
ORDER BY 
    review_count DESC;


-- 11)

-- explain original
Explain
select u.user_id,u.First_name,u.Last_name,count(tu.Trip_id)as Trip_count
from user as u
left join tripUser as tu on u.user_id=tu.user_id
group by u.user_id,u.First_name,u.last_name
having Trip_count>0;

-- explain tuned
Explain
SELECT 
    u.user_id,
    u.First_name,
    u.Last_name,
    COUNT(tu.Trip_id) AS Trip_count
FROM 
    user AS u
LEFT JOIN 
    tripUser AS tu ON u.user_id = tu.user_id
WHERE 
    tu.user_id IS NOT NULL  -- Only consider users who have at least one trip
GROUP BY 
    u.user_id, u.First_name, u.Last_name;