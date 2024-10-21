-- We have given you create statements for 4 of the tables. Do not change these!
--   - Location
--   - PointOfInterest
--   - ViewingInstructions
--   - Route

-- As part of Question 2, you need to complete the create statements for 
-- the following tables: [5 marks each table for correctnes to the diagram in A2]
--   - Person
--   - Plan
--   - PlannedRouteSelection
--   - PlannedLocationSelection
--   - RouteStartTime
--   - Waypoint
-- DO NOT CHANGE THE ORDER OF THE CREATE STATEMENTS

-- at the end of the file are some places for your to write your own insert data for testing.

-- here is the order to drop the tables so that there are no FK issues while re-populating
DROP TABLE IF EXISTS `PlannedLocationSelection` ;
DROP TABLE IF EXISTS `Waypoint` ;
DROP TABLE IF EXISTS `ViewingInstructions` ;
DROP TABLE IF EXISTS `PlannedRouteSelection` ;
DROP TABLE IF EXISTS `RouteStartTime` ;
DROP TABLE IF EXISTS `Route` ;
DROP TABLE IF EXISTS `Location` ;
DROP TABLE IF EXISTS `Plan` ;
DROP TABLE IF EXISTS `PointOfInterest` ;
DROP TABLE IF EXISTS `Person` ;

-- -----------------------------------------------------
-- Table `Location`
-- -----------------------------------------------------

CREATE TABLE `Location` (
  `locationID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(300) NOT NULL,
  `description` TEXT NOT NULL,
  `image` BLOB NOT NULL,
  PRIMARY KEY (`locationID`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `PointOfInterest`
-- -----------------------------------------------------

CREATE TABLE `PointOfInterest` (
  `pointOfInterestID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `mapReference` VARCHAR(2048) NOT NULL,
  `samplePhoto` BLOB NOT NULL,
  `description` TEXT NOT NULL,
  `typeOfPOI` VARCHAR(20) NOT NULL,
  `animalDescription` TEXT NULL DEFAULT NULL,
  `animalClassification` VARCHAR(20) NULL DEFAULT NULL,
  `animalEndangeredStatus` VARCHAR(20) NULL DEFAULT NULL,
  `plantDescription` TEXT NULL DEFAULT NULL,
  `plantIsPoisonous` TINYINT NULL DEFAULT NULL,
  `plantIsEdible` TINYINT NULL DEFAULT NULL,
  `plantAllergyNote` TEXT NULL DEFAULT NULL,
  `shopName` VARCHAR(500) NULL DEFAULT NULL,
  `shopSecondMapReference` VARCHAR(2048) NULL DEFAULT NULL,
  `shopBargainBarcode` BLOB NULL DEFAULT NULL,
  `placeSamplePhoto` BLOB NULL DEFAULT NULL,
  `placeDescription` TEXT NULL DEFAULT NULL,
  `placeEstimatedExistanceInYears` BIGINT UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`pointOfInterestID`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `ViewingInstructions`
-- -----------------------------------------------------

CREATE TABLE `ViewingInstructions` (
  `locationID` INT UNSIGNED NOT NULL,
  `pointOfInterestID` INT UNSIGNED NOT NULL,
  `instructionDetails` TEXT NOT NULL,
  PRIMARY KEY (`locationID`, `pointOfInterestID`),
  CONSTRAINT FOREIGN KEY (`locationID`) REFERENCES `Location` (`locationID`),
  CONSTRAINT FOREIGN KEY (`pointOfInterestID`) REFERENCES `PointOfInterest` (`pointOfInterestID`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Route`
-- -----------------------------------------------------

CREATE TABLE `Route` (
  `routeID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `estimatedWalkingTime` SMALLINT UNSIGNED NOT NULL COMMENT 'in minutes',
  `routeName` VARCHAR(200) NOT NULL,
  `routeDescription` TEXT NOT NULL,
  `startsAt` INT UNSIGNED NOT NULL,
  `endsAt` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`routeID`),
  CONSTRAINT FOREIGN KEY (`startsAt`) REFERENCES `Location` (`locationID`),
  CONSTRAINT FOREIGN KEY (`endsAt`) REFERENCES `Location` (`locationID`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Person`
-- -----------------------------------------------------

Create Table `Person` (
`personID` int unsigned not null auto_increment,
`name` varchar(200) not null,
`password` varchar(64) not null,
`email` varchar(255) not null,
primary key (personID)
)
Engine = InnoDB;

-- -----------------------------------------------------
-- Table `Plan`
-- -----------------------------------------------------

Create Table `Plan` (
`planID` int unsigned not null auto_increment,
`planName` varchar(200) not null,
`whenCreated` datetime not null,
`whenLastUpdated` datetime not null,
`isCreatedBy` int unsigned not null, 
primary key (`planID`),
constraint foreign key (`isCreatedBy`) references `Person` (`personID`)
)
Engine = InnoDB;

-- -----------------------------------------------------
-- Table `PlannedLocationSelection`
-- -----------------------------------------------------

Create Table `PlannedLocationSelection` (
planID int unsigned not null,
locationID int unsigned not null,
dateSelected Date not null,
timeSelected Time not null,
primary key (`planID`, `locationID`),
constraint foreign key (planID) references plan(planID),
constraint foreign key (locationID) references location(locationID)
)
Engine = InnoDB;

-- -----------------------------------------------------
-- Table `PlannedRouteSelection`
-- -----------------------------------------------------

Create Table `PlannedRouteSelection` (
planID int unsigned not null,
routeID int unsigned not null,
dateSelected Date not null,
timeSelected Time not null,
primary key (`planID`, `routeID`),
constraint foreign key (planID) references plan(planID),
constraint foreign key (routeID) references route(routeID)
)
Engine = InnoDB;

-- -----------------------------------------------------
-- Table `RouteStartTime`
-- -----------------------------------------------------

Create Table `RouteStartTime` (
routeID int unsigned not null,
dayandTimeStart char(8) not null,
primary key (routeID),
constraint foreign key (routeID) references route(routeID)
)
Engine = InnoDB;

-- -----------------------------------------------------
-- Table `Waypoint`
-- -----------------------------------------------------

Create Table `Waypoint` (
routeID int unsigned not null,
locationID int unsigned not null, 
relativeArrivalTime smallint unsigned not null,
relativeDepartureTime smallint unsigned not null,  
primary key (`routeID`, `locationID`),
constraint foreign key (routeID) references route(routeID),
constraint foreign key (locationID) references location(locationID)
)
Engine = InnoDB;

-- -----------------------------------------------------
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Your insert into statements below here
-- -----------------------------------------------------
-- -----------------------------------------------------
-- -----------------------------------------------------

-- Location data insert statements below here

insert into location (name, description, image)
Values
(
"Sydney Opera House", 
"The Sydney Opera House is an iconic architectural marvel situated on Bennelong Point in Sydney Harbour.", 
load_file("C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\SydneyOperaHouse.jfif")
),
(
"Bondi Beach",
"It is known for its golden sands, lively atmosphere, and excellent waves, making it a popular spot for both locals and tourists.",
load_file("C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\BondiBeach.jfif")
),
(
"Sydney Harbour Bridge",
"Completed in 1932, it connects the Sydney central business district with the North Shore and offers panoramic views from its walkway.",
load_file("C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\SydneyHabourBridge.jfif")
),
(
"Royal Botanic Garden",
"It features a diverse collection of plants, tranquil walking paths, and scenic views of Sydney Harbour.",
load_file("C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\RBG.jfif")
),
(
"Taronga Zoo",
"It is home to a wide range of animals from around the world and focuses on conservation and education.",
load_file("C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\TanrongaZoo.jfif")
),
(
"Wildlife Sanctuary",
"A protected area for wildlife species",
load_file("C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\WildlifeSanctuary.jfif")
);

-- PointOfInterest data insert statements below here
INSERT INTO pointofinterest (name, mapReference, samplePhoto, description, typeOfPOI, animalDescription, animalClassification, animalEndangeredStatus, plantDescription, plantIsPoisonous, plantIsEdible, plantAllergyNote, shopName, shopSecondMapReference, shopBargainBarcode, placeSamplePhoto, placeDescription, placeEstimatedExistanceInYears)
VALUES 
(
'Sydney Opera House Tour',
'https://maps.google.com/?q=Sydney+Opera+House+Tour', 
load_file("C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\SydneyOperaHouseTour.jfif"), 
'Guided tours showcasing the Opera House’s architecture and history.', 
'Tour', 
NULL, 
NULL, 
NULL, 
NULL, 
NULL, 
NULL, 
NULL, 
'Opera House Gift Shop',
'https://maps.google.com/?q=Opera+House+Gift+Shop',
NULL,
NULL,
'Explore the iconic performing arts venue with a guided tour.', 
50
), 
(
'Koala Encounter',
 'https://maps.google.com/?q=Koala+Encounter',
 load_file("C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\KoalaEncounter.jfif"),
 'Interactive experience to see and learn about koalas.',
 'Wildlife Encounter',
 'Koala: Small marsupial, eucalyptus eater.',
 'Marsupial',
 'Vulnerable',
 'Eucalyptus: Essential for koalas.',
 1,
 0,
 'Eucalyptus can cause allergic reactions.',
 'Taronga Zoo Shop',
 'https://maps.google.com/?q=Taronga+Zoo+Shop',
 load_file("C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\ShopDiscount.png"),
 load_file("C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\TarongaZooShop.jfif"),
 'Close-up encounters with iconic Australian wildlife.',
 100
 ),
(
'Cactus Garden',
 'https://maps.google.com/?q=Cactus+Garden', 
 load_file("C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\CactusGarden.jfif"),
 'A specialized garden showcasing a diverse collection of cacti and succulents.',
 'Garden',
 NULL,
 NULL,
 NULL,
 'Cacti: Drought-resistant plants with unique shapes.',
 0,
 1,
 'Some cacti have spines that can cause irritation.',
 'Garden Shop',
 'https://maps.google.com/?q=Garden+Shop',
 NULL,
load_file("C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\GardenShop.jfif"),
 'Explore a variety of fascinating cacti in this specialized garden.',
 200
 ),
(
'BridgeClimb Experience', 
'https://maps.google.com/?q=BridgeClimb+Experience',
 load_file("C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\BridgeClimbExp.jfif"),
 'Climbing adventure that takes you to the top of the Sydney Harbour Bridge.',
 'Experience',
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 'The Bridge Climb Shop',
 'https://maps.google.com/?q=The+Bridge+Climb+Shop',
 NULL,
 load_file("C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\BridgeClimbShop.jfif"),
 'A thrilling climb providing breathtaking views of Sydney.',
 90
 ), 
(
'Bondi Surf School',
 'https://maps.google.com/?q=Bondi+Surf+School',
 load_file("C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\BondiSurfSchool.jfif"),
 'Learn to surf with experienced instructors at Bondi Beach.',
 'Activity',
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 'Bondi Beach Shop',
 'https://maps.google.com/?q=Bondi+Beach+Shop',
 NULL,
 "C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\BondiBeachShop.jfif",
 'Experience surfing at one of Sydney’s most famous beaches.',
 100
 ),
 (
    'Kangaroo Encounter',
    'https://maps.example.com/kangaroo-encounter',
    load_file("C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\KangarooEncounter.jfif"),
    'An unforgettable experience where you can observe kangaroos in their natural habitat.',
    'Wildlife Encounter',
    'Kangaroos are large marsupials native to Australia, known for their powerful hind legs and strong tails. They are often seen hopping across the plains.',
    'Mammal',
    'Least Concern', 
    'Various native Australian plants, including eucalyptus and grass species.',
    0,  
    1,  
    'Check for allergies to native flora before visiting.',
    'Taronga Zoo Shop',
 'https://maps.google.com/?q=Taronga+Zoo+Shop',
 load_file("C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\ShopDiscount.png"),
 load_file("C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\TarongaZooShop.jfif"),
    'This place offers a unique opportunity to get up close with kangaroos and learn about their habitat and behavior.',
    50  
);

-- ViewingInstructions data insert statements below here
insert into viewingInstructions (locationID, pointofInterestID, instructionDetails)
values
(
1,
1,
"To enjoy your Sydney Opera House tour, please arrive 15 minutes early to check in at the main entrance. Gather at the designated meeting point in the forecourt, where your guide will be waiting. Wear comfortable shoes, bring a water bottle, and your camera for photos (but no flash photography indoors). The guided tour lasts about an hour, offering insights into key areas of the Opera House, so please remain quiet and respectful during presentations. The venue is wheelchair accessible, so let your guide know if you need assistance. Restrooms are available nearby, and the tour concludes at the gift shop, where you can explore and purchase souvenirs. Enjoy your visit!"
),
(
5,
2,
"For the Koala Encounter at Taronga Zoo, please arrive at least 15 minutes early to check in at the entrance. Wear comfortable shoes, and don’t forget your camera (without flash) to capture the moment. The encounter lasts about 30 minutes, where you’ll learn fascinating facts about koalas and their habitat. Be respectful and quiet to ensure a pleasant experience for both the animals and fellow visitors. The encounter may have specific age or height restrictions, so check in advance. After your session, feel free to explore the zoo’s other exhibits and enjoy the stunning views of Sydney Harbour."
),
(
4,
3,
"When visiting the Cactus Garden at the Royal Botanic Gardens, plan to spend some time exploring the diverse range of cacti and succulents. Arrive during opening hours and wear comfortable walking shoes. Bring a water bottle and your camera to capture the unique flora. Guided tours are available, offering insights into the plants’ adaptations and care. Enjoy a peaceful stroll through the garden, but please do not pick any plants or disturb the wildlife. The garden is a perfect spot for a picnic, so consider bringing along some snacks!"
),
(
3,
4,
"For your Sydney Harbour Bridge experience, arrive at the meeting point 15 minutes early for your climb or walk. Wear comfortable, weather-appropriate clothing and sturdy shoes. If you’re climbing, a safety harness will be provided, and you’ll receive a briefing on safety procedures. The climb lasts about three hours and offers breathtaking views of the city and harbour, so don’t forget your camera (but no loose items). Please stay with your group and follow the guide’s instructions. Afterward, enjoy the surrounding area, including cafes and lookout points for more stunning views."
),
(
2,
5,
"When attending the Bondi Beach Surf School, arrive at least 30 minutes early to check in and get fitted for a wetsuit and surfboard. Wear sunscreen and bring a towel and water bottle. The lesson lasts around two hours, with experienced instructors guiding you through the basics of surfing. Listen closely to safety instructions and practice in designated areas. Enjoy the fun atmosphere, but remember to be respectful of other surfers and beachgoers. After your lesson, take some time to relax on the beach or explore the vibrant Bondi area."
),
(
5, 
6, 
'Location: Australian Wildlife Exhibit. Best Viewing Times: Early morning (8 AM - 10 AM) and late afternoon (4 PM - 6 PM) are ideal times to see kangaroos active. Please remain quiet and calm to avoid startling the kangaroos. Maintain a safe distance; do not attempt to touch or feed the kangaroos. Observe from designated viewing areas only. Do not approach any kangaroos that appear agitated or stressed. Follow all posted signs and staff instructions. Use natural light for the best photos; avoid using flash, as it can scare the animals. For questions or further information, please contact a staff member.'
),
(
1,
4,
'Here you can see the Bridge Climb Experience'
),
(
4,
1,
'You can see the Opera House Tour from the Gardens'
);

-- Route data insert statements below here
insert into route (estimatedWalkingTime, routeName, routeDescription, startsAt, endsAt)
values
(15, 'Central Park Loop', 'A scenic walk around Central Park.', 4, 2),
(30, 'Downtown to Uptown', 'A route from downtown to uptown with various landmarks.', 2, 3),
(45, 'River Walk', 'A relaxing walk along the river with beautiful views.', 1, 2),
(25, 'Historic District Tour', 'A tour of the historic district with guided points of interest.', 1, 3),
(50, 'Scenic Walk', 'A relaxing walk with stunning vistas.', 2, 5);

-- Person data insert statements below here
INSERT INTO `Person` (`name`,`password`,`email`)
VALUES
  ("Reese Carney","HHA41HOK7JE","nunc.nulla@yahoo.net"),
  ("Harrison Erickson","SZV89LAF8QA","justo@protonmail.org"),
  ("Jessica Castillo","AXT75WKO9VM","nulla.dignissim@yahoo.couk"),
  ("Brody Hahn","XEM48ZMR0VO","elementum.sem@aol.com"),
  ("Kirk Brooks","OQD91SVU4XB","quam@yahoo.net"),
  ("Nelle Pope","KAI88PBY3PN","gravida.sit@outlook.com");

-- Plan data insert statements below here
     
insert into plan (planName, whenCreated, whenLastUpdated, isCreatedBy)
Values
("Resse's Adventure Plan", "2024-01-21 08:31:34", "2024-03-22 09:11:33", 1),
("Resse's Relaxtion Plan", "2024-01-21 08:30:21", "2024-03-21 10:21:58", 1),
("Kirk's Plan", "2024-02-18 17:39:01", "2024-02-19 9:23:29", 5);

-- PlannedLocationSelection data insert statements below here
insert into plannedlocationselection (planID, locationID, dateSelected, timeSelected) 
values
(1,3,"2024-03-22", "10:30:00"),
(1,1,"2024-03-22", "11:20:00"),
(1,4,"2024-03-22","12:00:00"),
(2,5,"2024-02-20","11:00:00"),
(3,2,"2024-04-09", "18:00:00");

-- PlannedRouteSelection data insert statements below here

insert into plannedrouteselection (planID, routeID, dateSelected, timeSelected)
values
(1, 5, "2024-04-21", "18:00:00"),
(2, 3, "2024-03-14", "12:00:00");

-- RouteStartTime data insert statements below here
insert into routestarttime (routeID, dayAndTimeStart)
values
(1, "Mon09:00"),
(2, "Wed17:30"),
(3, "Sun12:00"),
(4, "Tue11:00"),
(5, "Fri18:00");

-- Waypoint data insert statements below here
INSERT INTO `Waypoint` (routeID, locationID, relativeArrivalTime, relativeDepartureTime)
VALUES
(1, 4, 10, 75),
(1, 2, 85, 90), 
(2, 2, 5, 10),
(2, 3, 15, 50),
(3, 1, 30, 40),
(3, 2, 70, 80),  
(4, 1, 20, 30),  
(4, 3, 30, 55),  
(5, 2, 10, 30),  
(5, 5, 50, 70);



