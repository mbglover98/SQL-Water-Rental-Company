Drop database if exists GloverDB;
create database GloverDB;

use GloverDB;

CREATE TABLE `Waiver` (
	`WaiverID` VARCHAR(10) Not NULL,
	`DateSigned` DATE DEFAULT NULL,
	`Acceptance` CHAR(3) DEFAULT NULL,
	`CustomerID` INT(3) NOT NULL
	) ENGINE = InnoDB DEFAULT CHARSET=latin1;
	
CREATE TABLE `Customer` (
	`CustomerID` INT(3) NOT NULL,
	`First Name` CHAR(10) DEFAULT NULL,
	`Last Name` CHAR(10) DEFAULT NULL,
	`Street`	VARCHAR(30) DEFAULT NULL,
	`City`	CHAR(15) DEFAULT NULL,
	`State` CHAR(2) DEFAULT NULL,
	`ZIP` INT(5) DEFAULT NULL,
	`Phone` BIGINT DEFAULT NULL
	) ENGINE = InnoDB DEFAULT CHARSET=latin1;
	
CREATE TABLE `Equipment` (
	`EquipmentID` VARCHAR(15) NOT NULL,
	`Equipment Name` CHAR(20) DEFAULT NULL,
	`Cost per Hour` INT(4) Default NULL
	) ENGINE = InnoDB DEFAULT CHARSET=latin1;
	
CREATE TABLE `Reserved For` (
	`ReservationID` INT(5) NOT NULL,
	`EquipmentID` VARCHAR(15) NOT NULL
	) ENGINE = InnoDB DEFAULT CHARSET=latin1;
	
CREATE TABLE `Insurance` (
	`InsuranceID` VARCHAR(11) NOT NULL,
	`ReservationID` INT(5) NOT NULL,
	`Total Paid` VARCHAR(8) Default NULL
	) ENGINE = InnoDB DEFAULT CHARSET=latin1;
	
CREATE TABLE `Reservation` (
	`ReservationID` INT(4) NOT NULL,
	`Reservation Date` DATE Default NULL,
	`Party Size` INT(3) DEFAULT NULL,
	`Rental Estimate` VARCHAR(8) DEFAULT NULL,
	`Rental Length` INT(4) DEFAULT NULL,
	`Rental COST` DECIMAL(8,2) DEFAULT NULL,
	`CustomerID` INT(3) NOT NULL
	) ENGINE = InnoDB DEFAULT CHARSET=latin1;
	
CREATE TABLE `Schedule` (
	`EID` Int(4) NOT NULL,
	`ReservationID` Int(4) NOT NULL,
	`Start Time` Int(4) DEFAULT NULL,
	`End Time` INT(4) DEFAULT Null
	)  ENGINE = InnoDB DEFAULT CHARSET=latin1;
	
CREATE TABLE `Travel` (
	`EID` INT(4) NOT NULL,
	`ReservationID` INT(4) NOT NULL,
	`Van Vin` BIGINT NOT NULL
	) ENGINE = InnoDB DEFAULT CHARSET=latin1;
	
CREATE TABLE `Van` (
	`Vin` BIGINT NOT NULL,
	`Registration` VARCHAR(20) DEFAULT NULL,
	`Plate Expiration` VARCHAR(20) DEFAULT NULL,
	`Plate Number` VARCHAR(10) DEFAULT NULL
	) ENGINE = InnoDB DEFAULT CHARSET=latin1;
	
CREATE TABLE `Employee` (
	`EID` INT(4) NOT NULL,
	`First Name` CHAR(10) DEFAULT NULL,
	`Last Name` CHAR(10) DEFAULT NULL,
	`Address` VARCHAR(30) DEFAULT NULL,
	`Cell Phone` BIGINT DEFAULT NULL,
	`Date Hired` INT(8) DEFAULT NULL,
	`License Number` INT(10) DEFAULT NULL
	) ENGINE = InnoDB DEFAULT CHARSET=latin1;
	
CREATE TABLE `Survey` (
	`SurveyID` INT(3) NOT NULL,
	`Experience` INT(1) DEFAULT NULL,
	`Employee Rating` INT(1) DEFAULT NULL,
	`Equipment Rating` INT(1) DEFAULT NULL,
	`ReservationID` INT(4) Not Null,
	`Ad ID` INT(4) Default NULL
	) ENGINE = InnoDB DEFAULT CHARSET=latin1;
	
CREATE TABLE `Advertisement` (
	`Ad ID` INT(3) NOT NULL,
	`Location` VARCHAR(25) DEFAULT NULL,
	`Initial Date` Int(8) Default NULL,
	`Cost` DECIMAL(8,2) DEFAULT NULL,
	`Contact First` CHAR(15) DEFAULT NULL,
	`Contact Last` CHAR(15) DEFAULT NULL,
	`Contact Phone` BIGINT DEFAULT NULL
	) ENGINE = InnoDB DEFAULT CHARSET=latin1;
	
ALTER TABLE `Waiver`
	ADD PRIMARY KEY (`WaiverID`),
	ADD KEY `CustomerID` (`CustomerID`);
	
ALTER TABLE `Customer`
	ADD PRIMARY KEY (`CustomerID`);

ALTER TABLE `Equipment`
	ADD PRIMARY KEY (`EquipmentID`);
	
ALTER TABLE `Reserved For`
	ADD PRIMARY KEY (`ReservationID`,`EquipmentID`),
	ADD KEY `ReservationID`(`ReservationID`),
	ADD KEY `EquipmentID`(`EquipmentID`);
	
ALTER TABLE `Insurance`
	ADD PRIMARY KEY (`InsuranceID`),
	ADD KEY `ReservationID`(`ReservationID`);
	
ALTER TABLE `Reservation`
	ADD PRIMARY KEY (`ReservationID`),
	ADD KEY `CustomerID` (`CustomerID`);
	
ALTER TABLE `Schedule`
	ADD PRIMARY KEY (`EID`,`ReservationID`),
	ADD KEY `EID`(`EID`),
	ADD KEY `ReservationID`(`ReservationID`);
	
ALTER TABLE `Travel`
	ADD PRIMARY KEY (`EID`,`ReservationID`),
	ADD KEY `EID`(`EID`),
	ADD KEY `ReservationID`(`ReservationID`),
	ADD KEY `Van Vin` (`Van Vin`);
	
ALTER TABLE `Van`
	ADD PRIMARY KEY (`VIN`);
	
ALTER TABLE `Employee`
	Add PRIMARY KEY (`EID`);
	
ALTER TABLE `Survey`
	ADD PRIMARY KEY (`SurveyID`),
	ADD KEY `ReservationID` (`ReservationID`),
	ADD KEY `Ad ID` (`Ad ID`);
	
ALTER TABLE `Advertisement`
	ADD PRIMARY KEY (`Ad ID`);
	


ALTER TABLE `Waiver`
	ADD CONSTRAINT `WtC` FOREIGN KEY(`CustomerID`) REFERENCES `Customer` (`CustomerID`);
	
ALTER TABLE `Reserved For`
	ADD CONSTRAINT `R2E` FOREIGN KEY(`EquipmentID`) REFERENCES `Equipment` (`EquipmentID`),
	ADD CONSTRAINT `E2R` FOREIGN KEY(`ReservationID`) REFERENCES `Reservation` (`ReservationID`);

ALTER TABLE `Insurance`
	ADD CONSTRAINT `I2R` FOREIGN KEY(`ReservationID`) REFERENCES `Reservation` (`ReservationID`);

ALTER TABLE `Reservation`
	ADD CONSTRAINT `R2C` FOREIGN KEY(`CustomerID`) REFERENCES `Customer` (`CustomerID`);

ALTER TABLE `Schedule`
	ADD CONSTRAINT `S2R` FOREIGN KEY(`ReservationID`) REFERENCES `Reservation` (`ReservationID`),
	ADD CONSTRAINT `S2E` FOREIGN KEY(`EID`) REFERENCES `Employee` (`EID`);
ALTER TABLE `Travel`
	ADD CONSTRAINT `T2R` FOREIGN KEY(`ReservationID`) REFERENCES `Reservation` (`ReservationID`),
	ADD CONSTRAINT `T2E` FOREIGN KEY(`EID`) REFERENCES `Employee` (`EID`),
	ADD CONSTRAINT `T2V` FOREIGN KEY(`Van Vin`) References `Van` (`Vin`);

ALTER TABLE `Survey`
	ADD CONSTRAINT `Sur2R` FOREIGN KEY(`ReservationID`) REFERENCES `Reservation` (`ReservationID`),
	ADD CONSTRAINT `Sur2A` FOREIGN KEY(`Ad ID`) REFERENCES `Advertisement` (`Ad ID`);



INSERT INTO `Customer` VALUES
(51,'Camille','Sosa','Ap #279-9361 Maecenas Rd.','Humansville','MO',65674,7891453851),
(378,'Valentine','Ashley','P.O. Box 366, 7146 Mauris Rd.','Johnson City','KS',67855,5498614423),
(493,'Melissa','Padilla','6453 Mi St.','Ruston','LA',71270,2569841256),
(32,'Courtney','Fitzgerald','4604 Sed St.','Wichita Falls','TX',76308,6421357561),
(156,'Iliana','Jefferson','3720 Sedgeway Avenue','Ruidoso','NM',88345,3766612350),
(235,'Ifeoma','Maddox','241 Vel Avenue','Grand Forks','ND',58208,5762584562),
(2,'Xandra','Beasley','6301 Quis St.','Oklahoma City','OK',73139,9856321562),
(210,'Noel','Dillon','992 Euismod St.','Cascadia','OR',97345,3697413216),
(236,'Doris','Mendez','9245 Pellentesque St.','South Bend','IN',46615,7596512251),
(224,'Nash','Burns','1873 Facilisis Avenue','Riverside','CA',91718,9863217898),
(131,'Piper','Bolton','1329 Nullam St.','Mobile','AL',36603,2564447852),
(114,'Clinton','Rosa','5359 Diam Road','Woodworth','ND',58469,3652569637),
(161,'Jocelyn','Witt','7063 Dictum Ave','Adams Mill','TN',37641,3279138264),
(129,'Cade','Craft','1117 Penatibus Road','Biloxi','MS',39540,5554216689);

INSERT INTO `Equipment` VALUES
('442113890-00002','life jacket','5.00'),
('909077695-00007','life jacket','5.00'),
('325663060-00003','tandem kayak','35.00'),
('166877688-00001','single kayak','25.00'),
('020923850-00000','paddle board','15.00'),
('292238029-00006','canoe','30.00'),
('739639565-00004','canoe','30.00'),
('095577532-00005','life jacket','5.00'),
('438864639-00002','inner tube','10.00'),
('712059856-00005','life jacket','5.00'),
('792341521-00005','tandem kayak','35.00'),
('647452796-00004','life jacket','5.00'),
('358648228-00007','paddle board','15.00'),
('142873926-00000','life jacket','5.00'),
('295358048-00003','canoe','30.00'),
('063091896-00009','paddle board','15.00'),
('852623461-00005','canoe','30.00'),
('220878771-00009','single kayak','25.00'),
('957771983-00005','single kayak','25.00'),
('221805096-00007','canoe','30.00'),
('365845080-00008','inner tube','10.00'),
('352350813-00007','inner tube','10.00'),
('909481558-00007','single kayak','25.00'),
('436210959-00009','paddle board','15.00'),
('753178037-00002','canoe','30.00'),
('123315392-00001','tandem kayak','35.00'),
('667890230-00002','paddle board','15.00'),
('794778050-00003','life jacket','5.00'),
('524867207-00002','tandem kayak','35.00'),
('118853126-00001','paddle board','15.00'),
('879310522-00005','paddle board','15.00'),
('154318455-00008','tandem kayak','35.00'),
('460910433-00008','life jacket','5.00'),
('527482582-00006','life jacket','5.00'),
('619923014-00002','paddle board','15.00'),
('679824334-00008','tandem kayak','35.00'),
('180918047-00002','tandem kayak','35.00'),
('353139389-00004','canoe','30.00'),
('393527908-00007','canoe','30.00'),
('746780113-00005','tandem kayak','35.00'),
('508306008-00006','paddle board','15.00'),
('265400234-00000','single kayak','25.00'),
('458982741-00001','life jacket','5.00'),
('200493070-00003','inner tube','10.00'),
('610052482-00003','paddle board','15.00'),
('259923670-00006','inner tube','10.00'),
('440353100-00009','tandem kayak','35.00'),
('161670005-00008','inner tube','10.00'),
('560600553-00005','tandem kayak','35.00'),
('232304410-00003','tandem kayak','35.00'),
('662156207-00000','life jacket','5.00'),
('842467052-00002','tandem kayak','35.00'),
('635228653-00005','paddle board','15.00'),
('163106206-00002','inner tube','10.00'),
('754296010-00004','paddle board','15.00'),
('233797091-00003','single kayak','25.00'),
('976226217-00009','canoe','30.00'),
('412470254-00001','life jacket','5.00'),
('044537736-00009','paddle board','15.00'),
('548328855-00000','tandem kayak','35.00'),
('856767892-00008','single kayak','25.00'),
('174542035-00004','single kayak','25.00'),
('652322082-00007','life jacket','5.00'),
('298765207-00006','inner tube','10.00'),
('149055857-00002','life jacket','5.00'),
('247500622-00003','single kayak','25.00'),
('458732336-00003','single kayak','25.00'),
('547942573-00007','canoe','30.00'),
('009492968-00004','life jacket','5.00'),
('867600405-00007','paddle board','15.00'),
('228239356-00006','tandem kayak','35.00'),
('878437599-00003','tandem kayak','35.00'),
('935738591-00004','paddle board','15.00'),
('877805671-00006','paddle board','15.00');

INSERT INTO `Reservation` VALUES
(4073,'2022-05-26',11,'50.00',3,'61.62',51),
(3645,'2022-03-06',4,'60.00',1,'67.87',378),
(6206,'2022-05-27',9,'80.00',4,'92.31',493),
(3769,'2022-05-08',5,'60.00',2,'66.83',32),
(6647,'2022-05-31',5,'60.00',1,'71.57',156),
(7874,'2022-03-03',6,'50.00',2,'57.88',235),
(6076,'2021-12-25',1,'20.00',2,'23.47',2),
(5074,'2021-03-27',6,'70.00',1,'79.89',210),
(8986,'2021-07-28',11,'40.00',3,'53.29',235),
(4295,'2021-03-30',12,'30.00',1,'47.18',224),
(6983,'2021-03-03',4,'50.00',1,'56.61',131),
(9975,'2021-03-16',3,'70.00',1,'77.03',114),
(4427,'2021-03-30',10,'50.00',2,'63.88',161),
(8176,'2020-07-27',10,'50.00',2,'66.83',129);

INSERT INTO `Employee` VALUES
(2265,'Blossom','Blackwell','68 CR 221 Trinity,Al',5354792077,1211996,58510750),
(8818,'Caesar','Ellison','221 CR 591 Trinity,Al',7114378952,1152015,45213799),
(1325,'Leah','Hebert','78 CR 434 Trinity,Al',7472459927,10161997,81778827),
(6145,'Orlando','Slater','9131 CR 222 Trinity,Al',5563010965,1242008,21379669),
(6644,'Savannah','Cameron','551 CR 318 Trinity,Al',6535678010,732000,63384287);

INSERT INTO `Advertisement` VALUES
(551,'radio','08112020','91.00','John','Chem',1324859765),
(541,'commercial','02182021','103.00','Rich','Tam',4568975566),
(629,'radio','04102020','91.00','Quin','Randall',9637418426),
(496,'commercial','03102021','103.00','Tammy','Renolds',9517536248),
(391,'newspaper','07132021','54.00','Brett','Queen',1478523641),
(623,'magazine','12162020','31.00','Vince','Vince',6549873215),
(591,'commercial','04072021','103.00','Bridgette','Potts',1597536853),
(796,'newspaper','04302021','54.00','Leonard','Skynard',8881375654),
(780,'magazine','11032020','31.00','Ching','Chang',2569744458),
(419,'magazine','09152020','31.00','Pamela','Gonzalez',20529748521);

INSERT INTO `Waiver` VALUES
('12444936-7','2022-05-26','yes',51),
('38667837-5','2022-03-06','yes',378),
('46273411-5','2022-05-27','yes',493),
('8177376-9',Null,'no',32),
('33014751-2','2022-05-31','yes',156),
('20791366-9','2022-03-03','yes',235),
('15702534-1',Null,'no',2),
('14812709-3',Null,'no',210),
('10287489-7',Null,'no',235),
('42029098-5','2021-03-30','yes',224),
('6263817-6','2022-02-17','yes',131),
('32838369-1','2021-03-16','yes',114),
('8749646-5',Null,'no',161),
('15180766-6','2020-07-27','yes',129);

INSERT INTO `Insurance` VALUES
('948778-1347',6647,'6.00'),
('025172-0959',7874,'12.00'),
('888113-4947',6076,'12.00'),
('096843-7541',5074,'6.00'),
('564887-4138',8986,'18.00'),
('315412-9997',4295,'6.00'),
('654611-5848',6983,'6.00');

INSERT INTO `Van` VALUES
(35349473899,'Mar 3, 2021','March 30,2022','V4L 4I5'),
(39342007099,'Jul 8, 2021','Jul 30,2022','W3C 3L9'),
(44223627999,'Mar 25, 2021','Mar 30,2022','G2B 6M1'),
(78942255699,'Mar 27, 2021','Mar 30,2022','V7L 0L5');


INSERT INTO `Survey` VALUES
(634,2,10,7,4073,551),
(377,1,7,8,3645,629),
(433,4,2,1,6206,551),
(383,3,5,4,7874,496),
(882,7,6,4,6076,629),
(795,5,2,9,5074,496),
(668,10,10,2,8986,551),
(656,9,1,6,4295,780),
(934,8,8,2,4427,419),
(647,6,2,9,8176,780);

INSERT INTO `Reserved For` VALUES
(3645,'442113890-00002'),
(3645,'909077695-00007'),
(3645,'325663060-00003'),
(3645,'166877688-00001'),
(3645,'020923850-00000'),
(4073,'292238029-00006'),
(3769,'739639565-00004'),
(3769,'095577532-00005'),
(3769,'438864639-00002'),
(3769,'712059856-00005'),
(3769,'792341521-00005'),
(3769,'647452796-00004'),
(4073,'358648228-00007'),
(4073,'142873926-00000'),
(4073,'295358048-00003'),
(4073,'063091896-00009'),
(4073,'852623461-00005'),
(4073,'220878771-00009'),
(4295,'957771983-00005'),
(4295,'221805096-00007'),
(4295,'365845080-00008'),
(4295,'352350813-00007'),
(4295,'909481558-00007'),
(4427,'436210959-00009'),
(4427,'753178037-00002'),
(4427,'123315392-00001'),
(4427,'667890230-00002'),
(4427,'794778050-00003'),
(5074,'524867207-00002'),
(5074,'118853126-00001'),
(5074,'879310522-00005'),
(5074,'154318455-00008'),
(5074,'460910433-00008'),
(6076,'527482582-00006'),
(6076,'619923014-00002'),
(4427,'679824334-00008'),
(4295,'180918047-00002'),
(6206,'353139389-00004'),
(6206,'393527908-00007'),
(6206,'746780113-00005'),
(6206,'508306008-00006'),
(6206,'265400234-00000'),
(6206,'458982741-00001'),
(6206,'200493070-00003'),
(6647,'610052482-00003'),
(6647,'259923670-00006'),
(6647,'440353100-00009'),
(6647,'161670005-00008'),
(4073,'560600553-00005'),
(6983,'232304410-00003'),
(6983,'662156207-00000'),
(6983,'842467052-00002'),
(8176,'635228653-00005'),
(8176,'163106206-00002'),
(7874,'754296010-00004'),
(7874,'233797091-00003'),
(7874,'976226217-00009'),
(7874,'412470254-00001'),
(7874,'044537736-00009'),
(8176,'548328855-00000'),
(8176,'856767892-00008'),
(8176,'174542035-00004'),
(8176,'652322082-00007'),
(8176,'298765207-00006'),
(8986,'149055857-00002'),
(8986,'247500622-00003'),
(8986,'458732336-00003'),
(8986,'547942573-00007'),
(8986,'009492968-00004'),
(9975,'867600405-00007'),
(9975,'228239356-00006'),
(9975,'878437599-00003'),
(9975,'935738591-00004'),
(9975,'877805671-00006');

INSERT INTO `Schedule` VALUES
(2265,4073,0910,1340),
(8818,6206,0900,1200),
(6145,4295,1200,1500),
(6644,9975,1500,1800),
(1325,4427,0800,1700);

INSERT INTO `Travel` VALUES
(2265,4073,35349473899),
(8818,3645,39342007099),
(1325,6206,44223627999),
(6145,3769,78942255699);