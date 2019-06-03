CREATE DATABASE hotels;

CREATE TABLE hotelsList
(
	Id int NOT NULL PRIMARY KEY IDENTITY,
	HotelName nvarchar (50) NOT NULL,
	Foundation int NOT NULL,
	HotelAddress nvarchar (50) NOT NULL,
	IsActive varchar (20) NOT NULL check(IsActive IN('Active','Inactive')),
);

CREATE TABLE rooms
(
	RoomId int NOT NUll PRIMARY KEY IDENTITY,
	HotelId int NOT NULL, 
	FOREIGN KEY (HotelId) REFERENCES dbo.hotelsList(Id),
	Number int NOT NULL CHECK (Number>0),
	Price money NOT NULL,
	ComfortLevel int NOT NULL CHECK(ComfortLevel IN(1,2,3)),
	Capability int NOT NULL CHECK(Capability IN(1,2,3,4))
);

CREATE TABLE users
(
	UserId int NOT NULL PRIMARY KEY IDENTITY,
	FullName nvarchar(40) NOT NULL,
	Email varchar(30) NOT NULL 
);

CREATE TABLE reservations
(
	BookId int NOT NULL PRIMARY KEY IDENTITY,
	ClientId int NOT NULL FOREIGN KEY REFERENCES dbo.users(UserId),
	HotelAndRoomId int NOT NULL FOREIGN KEY REFERENCES dbo.rooms(RoomId),
	StartDateOfBooking date,
	EndDateOfBooking date
);



INSERT INTO dbo.hotelsList (HotelName,Foundation,HotelAddress,IsActive)
Values ('Турист','1987','вул. Червоноармійська 184','Inactive'),
		('Edelweiss','1990','вул. Головна 141','Active'),		
		('Bukovyna','1999','вул. Головна 46','Active');

SELECT * FROM hotelslist;

UPDATE hotelsList 
SET Foundation='1937'
WHERE Id='1'

DELETE FROM hotelsList
WHERE Id = '3';


INSERT INTO users (FullName,Email)
VALUES  ('Anton','anton1@gmail.com'),
		('Andrew','andrew1@gmail.com'),
		('Maksym','maksym1@gmail.com'),
		('Mykola','mykola1@gmail.com'),
		('Tetiana','tetiana1@gmail.com'),
		('Oleksii','oleksii1@gmail.com'),
		('Bohdan','bohdan1@gmail.com'),
		('Victor','victor1@gmail.com'),
		('Valentyna','valentyna1@gmail.com'),
		('Olha','olha1@gmail.com');

SELECT *FROM users
WHERE FullName like 'A%'


INSERT INTO rooms (HotelId,Number,Price,ComfortLevel,Capability)
VALUES  ('1','101','120','1','1'),
		('1','102','120','1','1'),
		('1','103','260','2','2'),
		('1','201','260','2','2'),
		('1','202','320','3','3'),
		('1','203','380','3','4'),
		('1','204','320','3','3'),
		('2','101','300','1','1'),
		('2','301','420','2','2'),
		('2','302','560','2','4');


SELECT * FROM rooms
ORDER BY Price;

SELECT rooms.Number, rooms.Price, hotelsList.HotelName FROM rooms, hotelsList
WHERE hotelsList.Id=rooms.HotelId AND hotelsList.HotelName='Edelweiss'
ORDER BY Price;

SELECT hotelsList.HotelName FROM rooms, hotelsList
WHERE hotelsList.Id = rooms.HotelId AND ComfortLevel = '3'
GROUP BY hotelsList.HotelName;

SELECT hotelsList.HotelName, rooms.Number FROM rooms, hotelsList
WHERE hotelsList.Id = rooms.HotelId AND ComfortLevel = '1';

SELECT HotelName, count(RoomId) AS NumberOfRooms 
FROM hotelslist inner join rooms on hotelslist.Id = HotelId 
GROUP BY hotelslist.HotelName;

Select users.FullName, rooms.Number, reservations.StartDateOfBooking, reservations.EndDateOfBooking
From reservations
INNER JOIN users ON users.UserId = reservations.ClientId
INNER JOIN rooms ON rooms.RoomID = reservations.HotelAndRoomID;