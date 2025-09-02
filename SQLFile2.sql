drop database if exists PetPals;

create database PetPals;
use PetPals;


create table Shelters
	(ShelterID int primary key,
	Name varchar(50),
	Location varchar(50)
	);

create table Pets
	(PetID int primary key,
	Name varchar(50),
	Age int CHECK (Age >= 0), 
	Breed varchar(50),
	Type varchar(50),
	AvailableForAdoption bit default 0,
	ShelterID int,
	foreign key (ShelterID) References Shelters(ShelterID)
	);

create table Donations
	(DonationID int primary key,
	DonorName varchar(50),
	DonationType varchar(50),
	DonationAmount Decimal(10,2),
	DonationItem varchar(50),
	DonationDate datetime default getdate(),
	ShelterID int,
	foreign key (ShelterID) references Shelters(ShelterID)
	);

create table AdoptionEvents
	(EventID int primary key,
	EventName varchar(50),
	EventDate datetime default getdate(),
	Location varchar(50),
	ShelterID int,
	foreign key (ShelterID) references Shelters(ShelterID)
	);

create table Participants
	(ParticipantID int primary key,
	ParticipantName varchar(100),
	ParticipantType varchar(50),
	EventID int,
	foreign key (EventID) references AdoptionEvents(EventID)
	);


-- Inserting data into Shelters table
INSERT INTO Shelters VALUES
(1, 'Pashu Seva Kendra', 'Mumbai'),
(2, ' Jeev Raksha Trust', 'Delhi'),
(3, 'Karuna Animal Shelter', 'Pune'),
(4, 'The Paw Project', 'Kolkata'),
(5, 'Prani Kalyan Sanstha', 'Chennai'),
(6, 'Pashupati Animal Shelter', 'Mumbai'),
(7, 'Sneha Animal Home', 'Ahmedabad'),
(8, 'Sai Ram Pet Care', 'Pune'),
(9, 'Jeev Daya Sangh', 'Lucknow'),
(10, 'Ahimsa Animal Rescue', 'Ahemdabad');

-- Inserting data into Pets table
INSERT INTO Pets VALUES
(101, 'Sheru', 3, 'Indian Street Dog', 'Dog', 1, 1),
(102, 'Billi', 2, 'Siamese', 'Cat', 1, 1),
(103, 'Tuffy', 5, 'Golden Retriever', 'Dog', 0, 2),
(104, 'Moti', 1, 'Labrador', 'Dog', 1, 3),
(105, 'Simba', 4, 'Domestic Shorthair', 'Cat', 1, 4),
(106, 'Kalu', 6, 'Poodle', 'Dog', 0, 5),
(107, 'Ladoo', 2, 'Tabby', 'Cat', 1, 6),
(108, 'Rocky', 1, 'Beagle', 'Dog', 1, 7),
(109, 'Polo', 3, 'Persian', 'Cat', 0, 8),
(110, 'Raja', 4, 'German Shepherd', 'Dog', 1, 9);



-- Inserting data into Donations table
INSERT INTO Donations VALUES
(201, 'Priya Sharma', 'Cash', 50.00, NULL, '2025-08-15 10:00:00', 1),
(202, 'Rahul Singh', 'Item', NULL, 'Dog Food', '2023-04-16 11:30:00', 2),
(203, 'Aisha Khan', 'Cash', 100.00, NULL, '2022-01-17 09:45:00', 3),
(204, 'Vikram Gupta', 'Item', NULL, 'Blankets', '2024-03-18 14:00:00', 4),
(205, 'Meera Patel', 'Cash', 25.50, NULL, '2025-08-19 16:20:00', 5),
(206, 'Arjun Reddy', 'Item', NULL, 'Cat Toys', '2024-08-20 08:50:00', 6),
(207, 'Shreya Desai', 'Cash', 75.00, NULL, '2023-04-21 12:15:00', 7),
(208, 'Kunal Mehta', 'Item', NULL, 'Leashes', '2023-04-22 17:30:00', 8),
(209, 'Anjali Roy', 'Cash', 200.00, NULL, '2025-08-23 10:45:00', 9),
(210, 'Sameer Jain', 'Item', NULL, 'Medical Supplies', '2025-08-24 13:00:00', 10);

-- Inserting data into AdoptionEvents table
INSERT INTO AdoptionEvents VALUES
(301, 'Jeev Daya Samaroh', '2025-09-01', 'Mumbai', 1),
(302, 'Pashu Mela', '2025-09-02', 'Delhi', 2),
(303, 'Dhanteras Pet Fair', '2025-09-03', 'Pune', 3),
(304, 'Kolkata Pet Expo', '2025-09-04', 'Maidan', 4),
(305, 'Chennai Adopt-a-thon', '2025-09-05', 'Chennai', 5),
(306, 'Hyderabad Pet Fest', '2025-09-06', 'Mumbai', 6),
(307, 'Ahmedabad Pet Lovers Meet', '2025-09-07', 'Pune', 7),
(308, 'Pune Pet Carnival', '2025-09-08', 'Delhi', 8),
(309, 'Lucknow Adopt-a-Pet Day', '2025-09-09', 'Ahemdabad', 9),
(310, 'Jaipur Pet Gala', '2025-09-10', 'Ahemdabad', 10);


-- Inserting data into Participants table
INSERT INTO Participants VALUES
(401, 'Indian Animal Welfare', 'Shelter', 301),
(402, 'Adopter Ravi', 'Adopter', 301),
(403, 'Street Dogs of India', 'Shelter', 302),
(404, 'Adopter Simran', 'Adopter', 302),
(405, 'Animal Aid Unlimited', 'Shelter', 303),
(406, 'Adopter Rohan', 'Adopter', 303),
(407, 'Canine Friends India', 'Shelter', 304),
(408, 'Adopter Kriti', 'Adopter', 304),
(409, 'Paws for a Cause', 'Shelter', 305),
(410, 'Adopter Ishaan', 'Adopter', 305);


--5
select Name, Age, Breed, Type from Pets 
where AvailableForAdoption = 1;


--6
Declare @EventID int = 301;
select p.ParticipantName, p.ParticipantType, ae.EventName
from Participants p
join AdoptionEvents ae on ae.EventID = p.EventID
where p.EventID = @EventID;


--7
create procedure updateShelterInfo
@ShelterID int,
@sname varchar(50),
@slocation varchar(50)
AS
begin
	if exists(select 1 from Shelters where ShelterID = @ShelterID)
	begin
		UPDATE Shelters
		set 
		Name = @sname, Location = @slocation
		where ShelterID = @ShelterID;
		print 'info updated';
	end
	else
	begin
		print 'Error: shelterID invalid';
	end;
end;

exec updateShelterInfo @ShelterID = 4, @sname = 'Prani seva kendra' , @slocation = 'Pune, MH';

select * from Shelters;








--8
select s.Name, sum(d.DonationAmount) as TotalDonationAmount
from Shelters s
left join Donations d on d.ShelterID = s.ShelterID
group by s.Name;





--9
Alter table Pets
add OwnerID int;

Alter table Pets
add foreign key(OwnerID) references Participants(ParticipantID);

select * from Pets;

update Pets set OwnerID = 405 where PetID = 101;
update Pets set OwnerID = 406 where PetID = 103;
update Pets set OwnerID = 408 where PetID = 107;
update Pets set OwnerID = 401 where PetID = 109;

select Name, Breed, Age, Type
from Pets
where OwnerID is NULL;


--10

select * from Donations;
select 
Month(DonationDate) as Donation_Month,
Year(DonationDate) as Donation_Year,
sum(DonationAmount) as TotalDonationAmount
from Donations 
GROUP BY
    MONTH(DonationDate), YEAR(DonationDate)
ORDER BY
    MONTH(DonationDate), YEAR(DonationDate);



--11
select distinct Breed
from Pets
where (Age between 1 and 3) or Age > 5;


--12
select *
from Pets p
join Shelters s on p.ShelterID = s.ShelterID
where p.AvailableForAdoption = 1;




--13
insert into Shelters values
(13, 'Pashu Seva griha', 'Mumbai'),
(11, 'animal care home', 'Mumbai');

select count(p.ParticipantID) as Total_Participants
from Participants p
join AdoptionEvents ae on ae.EventID = p.EventID
join Shelters s on s.ShelterID = ae.ShelterID
where s.Location = 'Mumbai';





--14
select distinct Breed 
from Pets
where Age between 1 and 5;




--15
select * from Pets 
where OwnerID is NULL;


--16
select p.Name as petName , pa.ParticipantName as Adopters_name
from Pets p 
join Participants pa on pa.ParticipantID = p.OwnerID;




--17
select count(p.PetID) as AvailablePetCount,
s.Name
from Shelters s
left join Pets p on p.ShelterID = s.ShelterID
group by s.Name;


--18
select * from Pets;

insert into Pets values (111, 'Jimmy', 3, 'Persian' , 'Cat', 1, 8, 407);

select p1.Name pet1Name, p2.Name pet2Name
, p1.Breed, s.Name as ShelterName
from Pets p1
join Pets p2 on p1.ShelterID = p2.ShelterID and p1.Breed = p2.Breed
join Shelters as s on p1.ShelterID =s.ShelterID
where p1.PetID < p2.PetID;


--19
select * from Shelters
cross join AdoptionEvents;




--20
select top 1 count(p.PetID) as adoptedPetCount, s.Name as ShelterName
from Shelters s
join Pets p on p.ShelterID = s.ShelterID
where p.AvailableForAdoption =1
group by s.Name
order by adoptedPetCount desc;


