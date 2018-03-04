CREATE SCHEMA IF NOT EXISTS PUBGAnalysis;
USE PUBGAnalysis;

DROP TABLE IF EXISTS Attaches; 
DROP TABLE IF EXISTS Attachments; 
DROP TABLE IF EXISTS Weapons;
DROP TABLE IF EXISTS Ammunition;
DROP TABLE IF EXISTS Equipments;
DROP TABLE IF EXISTS Consumables;
DROP TABLE IF EXISTS Vehicles;
DROP TABLE IF EXISTS Favorites;
DROP TABLE IF EXISTS Items;
DROP TABLE IF EXISTS Friends;
DROP TABLE IF EXISTS LeaderBoard;
DROP TABLE IF EXISTS GamePlayer; 
DROP TABLE IF EXISTS Users; 

CREATE TABLE Users (
UserName VARCHAR(255) NOT NULL,
`Password` VARCHAR(255) NOT NULL,
Email VARCHAR(320),
FavoItem VARCHAR(255),
 PRIMARY KEY (UserName)
);

CREATE TABLE LeaderBoard (
UserName VARCHAR(255),
Games INT,
WinNum INT,
Top10Num INT,
KD FLOAT,
AverageKill FLOAT,
WinRate FLOAT,
Top10Rate FlOAT,
HeadShotRate FLOAT,
HighestRating FLOAT,
SoloRating INT,
DuoRating INT,
SquadRating INT,
CONSTRAINT fk_LeaderBoard_UserName
 FOREIGN KEY (UserName)
 REFERENCES Users(UserName)
 ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Friends (
FriendUserName VARCHAR(255),
UserName VARCHAR(255), 
`Time` timestamp,
CONSTRAINT pk_Friends_FriendUserName
PRIMARY KEY (FriendUserName),
CONSTRAINT fk_Friends_UserName
 FOREIGN KEY (UserName)
 REFERENCES Users(UserName)
 ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Items (
ItemName VARCHAR(255),
UserName VARCHAR(255),
Image blob,
Introduction VARCHAR(255),
CONSTRAINT pk_Items_ItemName 
 PRIMARY KEY (ItemName),
CONSTRAINT fk_Items_UserName
 FOREIGN KEY (UserName)
 REFERENCES Users(UserName)
 ON DELETE SET NULL
);

CREATE TABLE Favorites (
FavoriteId INT AUTO_INCREMENT,
UserName VARCHAR(255),
ItemName VARCHAR(255),
CONSTRAINT pk_Favorites_FavoriteId
 PRIMARY KEY (FavoriteId),
CONSTRAINT fk_Favorites_UserName
 FOREIGN KEY (UserName)
 REFERENCES Users(UserName)
 ON UPDATE CASCADE ON DELETE CASCADE,
 CONSTRAINT fk_Favorites_ItemName
 FOREIGN KEY (ItemName)
 REFERENCES Items(ItemName)
 ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Vehicles (
ItemName VARCHAR(255),
Occupants INT,
TopSpeed INT,
Health INT,
VehicleType ENUM('Land','Water'),
CONSTRAINT pk_Vehicles_ItemName
 PRIMARY KEY (ItemName),
CONSTRAINT fk_Vehicles_ItemName
 FOREIGN KEY (ItemName)
 REFERENCES Items(ItemName)
 ON UPDATE CASCADE ON DELETE CASCADE
 );
 
CREATE TABLE Consumables (
ItemName VARCHAR(255),
CastTime INT,
CONSTRAINT pk_Consumables_ItemName
 PRIMARY KEY (ItemName),
CONSTRAINT fk_Consumables_ItemName
 FOREIGN KEY (ItemName)
 REFERENCES Items(ItemName)
 ON UPDATE CASCADE ON DELETE CASCADE
 );
 
CREATE TABLE Equipments (
ItemName VARCHAR(255),
`Level` INT,
DamageReduction FLOAT,
CapacityExtension INT,
Weight INT,
EquipmentType ENUM('Headgear', 'Armored vests', 'Belts', 'Outer', 'Back'),
CONSTRAINT pk_Equipments_ItemName
 PRIMARY KEY (ItemName),
CONSTRAINT fk_Equipments_ItemName
 FOREIGN KEY (ItemName)
 REFERENCES Items(ItemName)
 ON UPDATE CASCADE ON DELETE CASCADE
 );
 
 CREATE TABLE Ammunition (
 ItemName VARCHAR(255),
   CONSTRAINT pk_Ammunition_ItemName
 PRIMARY KEY (ItemName),
CONSTRAINT fk_Ammunition_ItemName
 FOREIGN KEY (ItemName)
 REFERENCES Items(ItemName)
 ON UPDATE CASCADE ON DELETE CASCADE
);
 
 CREATE TABLE Weapons (
 ItemName VARCHAR(255),
 Damage INT,
 WeaponType ENUM('Sniper Rifles', 'Assault Rifles', 'Submachine Guns', 'Shotguns', 'Pistols', 'Miscellaneous', 'Melee', 'Throwables'),
 AmmoName VARCHAR(255),
  CONSTRAINT pk_Weapons_ItemName
 PRIMARY KEY (ItemName),
CONSTRAINT fk_Weapons_ItemName
 FOREIGN KEY (ItemName)
 REFERENCES Items(ItemName)
 ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT fk_Weapons_AmmoName
 	FOREIGN KEY (AmmoName)
 	REFERENCES Ammunition(ItemName)
	ON DELETE SET NULL 
);
 
 CREATE TABLE Attachments (
 ItemName VARCHAR(255),
 AttachmentType  ENUM('Muzzle', 'Lower Rail', 'Upper Rail','Magazine', 'stock'),
 CONSTRAINT pk_Attachments_ItemName
 PRIMARY KEY (ItemName),
CONSTRAINT fk_Attachments_ItemName
 FOREIGN KEY (ItemName)
 REFERENCES Items(ItemName)
 ON UPDATE CASCADE ON DELETE CASCADE
 );
 
CREATE TABLE Attaches (
AttachId INT AUTO_INCREMENT,
AttachmentName VARCHAR(255),
WeaponName VARCHAR(255),
CONSTRAINT pk_Attaches_AttachId
 PRIMARY KEY (AttachId),
CONSTRAINT fk_Attaches_AttachmentName
 FOREIGN KEY (AttachmentName)
 REFERENCES Attachments(ItemName)
 ON UPDATE CASCADE ON DELETE CASCADE,
 CONSTRAINT fk_Attaches_WeaponName
 FOREIGN KEY (WeaponName)
 REFERENCES Weapons(ItemName)
 ON UPDATE CASCADE ON DELETE CASCADE
);


LOAD DATA LOCAL INFILE 'userInfo.csv' INTO TABLE Users
	FIELDS TERMINATED BY ',' ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE 'LeaderBoard.csv' INTO TABLE LeaderBoard
	FIELDS TERMINATED BY ',' ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

INSERT INTO Items(`ItemName`, `Introduction`)
	VALUES('VSS', 'The VSS is a suppressed sniper rifle that uses a heavy subsonic 9mm cartridge.'),
		('MINI14', 'Semi-auto carbine'),
		('SKS', 'Semi-auto Russian DMR rifle.'),
        ('MK14 EBR', 'Selective fire Designated Marksman Rifle originally built for user with units of USSOC such as Navy Seals and Delta Force.'),
        ('KARABINER 98 KURZ', 'Vintage sniper rifle.'),
        ('M24', 'Servicable sniper rifle.'),
        ('AWM', 'Monster sniper rifle.'),
        ('AKM', 'For comrades-in-arms.'),
        ('M416', 'German do things properly.'),
        ('M16A4', 'Burstfire assault rifle.'),
        ('SCAR-L', 'Modern assault rifle.'),
        ('GROZA', 'A selective fire Russian bullpup assault rifle chambered for a 7.62mm round.'),
        ('MICRO UZI', 'Spray your ammo but beware to not shoot yourself in the fooot.'),
        ('UMP9', 'Modern submachine gun using 9mm ammunition.'),
        ('KRISS VECTOR', 'Modern SMG using delayed blowback system and chambered for .45 ACP ammunition.'),
        ('TOMMY GUN', 'Infinite ammo with trench coat on.'),
        ('S686', 'Double barrel shotgun.'),
        ('S1897', 'Modest shotgun.'),
        ('S12K', 'Kinda foul in this world.'),
        ('P18C', 'An Austrian pistol with a full-auto mode and chambered for a 9mm round.'),
        ('P92', 'Modest handgun.'),
        ('P1911', 'Your grandpa loved it.'),
        ('R1895', 'Powerful revolver using 7.62mm ammunition.'),
        ('M249', 'Lighter than it looks.'),
        ('CROSSBOW', 'Hard to use, good to assasinate.'),
        ('PAN', 'Not for cooking.'),
        ('CROWBAR', 'A faithful shooter for every situation.'),
        ('MACHETE', 'Typical weapon for slaughter.'),
        ('SICKLE', 'Good for shaving.'),
        ('FRAG GRENADE', 'Fire in the hole.'),
        ('SMOKE GRENADE', 'Smoking useful.'),
        ('STUN GRENADE', 'Disorient a player for 10 seconds.'),
        ('MOLOTOV COCKTAIL', 'Highly explosive. Do not drink.'),
        ('12 Gauge', 'Ammo for S1897, S686, S12K'),
        ('5.56mm', 'Ammo for M16A4, M416, SCAR-L, M246, Mini14'),
        ('7.62mm', 'Ammo for R1895, AKM, Groza, Kar98k, M24, SKS, Mk14'),
        ('Bolt', 'Ammo for Crossbow'),
        ('.300 Magnum', 'Ammo for AWM'),
        ('.45 ACP', 'Ammo for P1911, Tommy Gun, Vector'),
        ('9mm', 'Ammo for P92, Micro Uzi, UMP9, VSS'),
        ('Choke', 'Reduces the spread of shotgun pellets'),
        ('Compensator for Assault Rifles', 'Slightly reduces horizontal recoil and reduces vertical recoil'),
        ('Compensator for SMG', 'Slightly reduces horizontal recoil and reduces vertical recoil'),
        ('Compensator for Sniper Rifles', 'Slightly reduces horizontal recoil and reduces vertical recoil'),
        ('Flash Hider for Assault Rifles', 'Eliminates muzzle flash and slightly reduces horizontal recoil and reduces vertical recoil'),
        ('Flash Hider for SMG', 'Eliminates muzzle flash and slightly reduces horizontal recoil and reduces vertical recoil'),
        ('Flash Hider for Sniper Rifles', 'Eliminates muzzle flash and slightly reduces horizontal recoil and reduces vertical recoil'),
        ('Suppressor for AR, S12K', 'Reduces a weapons sound to increse stealth'),
        ('Suppressor for SMG', 'Reduces a weapons sound to increse stealth'),
        ('Suppressor for Handgun', 'Reduces a weapons sound to increse stealth'),
        ('Suppressor for Sniper Rifles', 'Reduces a weapons sound to increse stealth'),
        ('Angled Foregrip', 'Slightly reduces horizontal and vertical recoil and makes switching to ADS faster'),
        ('Vertical Foregrip', 'Reduces horizontal recoil and makes switching to ADS faster'),
        ('Quiver', 'Attachable Weapon: Crossbow'),
        ('Red Dot Sight', 'Attachable weapons:'),
        ('Dot Sight', 'Attachable weapon: Crossbow'),
        ('Holographic Sight', 'Attachable weapons:'),
        ('2x Aimpoint Scope', 'Attachable weapons:'),
        ('4x ACOG Scope', 'Attachable weapons:'),
        ('8x CQBSS Scope', 'Attachable weapons:'),
        ('15x PM II Scope', 'Attachable weapons:'),
        ('Extended Mag for P9, P1911, P18C', 'Increases magazine capacity'),
        ('Extended QuickDraw Mag for P9, P1911, P18C', 'Increases reload speed and magazine capacity'),
        ('QucikDraw Mag for P9, P1911, P18C', 'Increases reload speed'),
        ('Extended Mag for Micro UZI, UMP9, Vector', 'increases magazine capacity'),
        ('Extended QuickDraw Mag for Micro UZI, UMP9, Vector', 'Increases reload speed and magazine capacity'),
        ('QuickDraw Mag for Micro UZI, UMP9, Vector', 'Increases reload speed'),
        ('Extended Mag for AR, S12K', 'increases magazine capacity'),
        ('QuickDraw Mag for AR, S12K', 'Increases reload speed'),
        ('Extended QuickDraw Mag for AR, S12K', 'Increases reload speed and magazine capacity'),
        ('Extended Mag for M24, AWM, SKS, VSS, Mk14, Mini14', 'Increases magazine capacity'),
        ('Extended QuickDraw Mag for M24, AWM, SKS, VSS, Mk14, Mini14', 'Increases reload speed and magazine capacity'),
        ('QuickDraw Mag for M24, AWM, SKS, VSS, Mk14, Mini14', 'Increases reload speed'),
        ('Bullet Loops for S1897, S686', 'Increases reload speed'),
        ('Stock', 'Makes recoil recovery faster and reduces weapon sway'),
        ('Tactical Stock', 'Makes recoil recovery faster and reduces weapon sway'),
        ('Bullet Loops for Kar98k', 'Increases reload speed'),
        ('Cheek Pad for Sniper Rifle', 'Reduces recoil kick and sway'),
        ('Motorcycle Helmet(Green)', 'Headgear'),
        ('Motorcycle Helmet(Grey)', 'Headgear'),
		('Military Helmet(Desert Camo)', 'Headgear'),
		('Military Helmet(Woodland Camo)', 'Headgear'),
		('Spetsnaz Helmet', 'Headgear'),
		('Police Vest1', 'Armored vests reduce damage'),
        ('Police Vest2', 'Armored vests reduce damage'),
		('Military Vest', 'Armored vests'),
		('Utility Belt', 'Belts'),
		('Ghillie Suit', 'Outer that can easily get into background'),
        ('Backpack1', 'Extend capacity'),
        ('Backpack2', 'Extend capacity'),
        ('Backpack3', 'Extend capacity'),
        ('Backpack4', 'Extend capacity'),
        ('Backpack5', 'Extend capacity'),
        ('Backpack6', 'Extend capacity'),
		('Parachute', 'Backpack for jumping out of the plane'),
        ('Energy Drink', 'Energy Drinks increase a character\'s boost by 40 instantly. Performing certain actions while casting this item will cancel it.'),
        ('Adrenaline Syringe', 'Adrenaline Syringes increase a character\'s boost by 100 instantly. Performing certain actions while casting this item will cancel it.'),
        ('Painkiller', 'Painkillers increase a character\'s boost by 60 instantly. Performing certain actions while casting this item will cancel it.'),
        ('Bandage', 'Bandages heal a character\'s health by 10 overtime. Performing certain actions while casting this item will cancel it. It cannot heal character\'s health over 75.'),
        ('First Aid Kit', 'First Aid Kits heal a character\'s health to 75 instantly. Performing certain actions while casting this item will cancel it. This item cannot be used when player\'s health is over 75.'),
        ('Med Kit', 'Med Kits heal a character\'s health to 100 instantly. Performing certain actions while casting this item will cancel it.'),
        ('Gas Can', 'You can refuel vehicles with it.'),
        ('Buggy', 'Land vehicle.'),
        ('UAZ (Open Top)', 'Land vehicle.'),
        ('UAZ (Closed Top)', 'Land vehicle.'),
        ('Motorcycle (w/ sidecar)', 'Land vehicle.'),
        ('Motorcycle', 'Land vehicle.'),
        ('Dacia 1300', 'Land vehicle.'),
        ('PG-117', 'Water vehicle.');
        
LOAD DATA LOCAL INFILE 'favorite.csv' INTO TABLE Favorites
	FIELDS TERMINATED BY ',' ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    (`UserName`, `ItemName`);
        
INSERT INTO Ammunition(`ItemName`)
	VALUES('12 Gauge'),
		('5.56mm'),
		('7.62mm'),
        ('Bolt'),
        ('.300 Magnum'),
        ('.45 ACP'),
        ('9mm');
        
INSERT INTO Weapons(`ItemName`, `Damage`, `WeaponType`, `AmmoName`)
	VALUES('VSS', 38, 'Sniper Rifles', '9mm'),
		('MINI14', 44, 'Sniper Rifles', '5.56mm'),
        ('SKS', 55, 'Sniper Rifles', '7.62mm'),
        ('MK14 EBR', 60, 'Sniper Rifles', '7.62mm'),
        ('KARABINER 98 KURZ', 72, 'Sniper Rifles', '7.62mm'),
        ('M24', 84, 'Sniper Rifles', '7.62mm'),
        ('AWM', 132, 'Sniper Rifles', '.300 Magnum'),
        ('AKM', 48, 'Assault Rifles', '7.62mm'),
        ('M416', 41, 'Assault Rifles', '5.56mm'),
        ('M16A4', 41, 'Assault Rifles', '5.56mm'),
        ('SCAR-L', 41, 'Assault Rifles', '5.56mm'),
        ('GROZA', 48, 'Assault Rifles', '7.62mm'),
        ('MICRO UZI', 23, 'Submachine Guns', '9mm'),
        ('UMP9', 35, 'Submachine Guns', '9mm'),
        ('KRISS VECTOR', 31, 'Submachine Guns', '.45 ACP'),
        ('TOMMY GUN', 38, 'Submachine Guns', '.45 ACP'),
        ('S686', 25, 'Shotguns', '12 Gauge'),
        ('S1897', 25, 'Shotguns', '12 Gauge'),
        ('S12K', 22, 'Shotguns', '12 Gauge'),
        ('P18C', 19, 'Pistols', NULL),
        ('P92', 29, 'Pistols', '9mm'),
        ('P1911', 35, 'Pistols', '.45 ACP'),
        ('R1895', 46, 'Pistols', '7.62mm'),
        ('M249', 44, 'Miscellaneous', '5.56mm'),
        ('CROSSBOW', 105, 'Miscellaneous', 'Bolt'),
        ('PAN', 80, 'Melee', NULL),
        ('CROWBAR', 60, 'Melee', NULL),
        ('MACHETE', 60, 'Melee', NULL),
        ('SICKLE', 60, 'Melee', NULL),
        ('FRAG GRENADE', 0, 'Throwables', NULL),
        ('SMOKE GRENADE', 0, 'Throwables', NULL),
        ('STUN GRENADE', 0, 'Throwables', NULL),
        ('MOLOTOV COCKTAIL', 0, 'Throwables', NULL);
        
INSERT INTO Attachments(`ItemName`, `AttachmentType`)
	VALUES
     ('Choke', 'Muzzle'),
        ('Compensator for Assault Rifles', 'Muzzle'),
        ('Compensator for SMG', 'Muzzle'),
        ('Compensator for Sniper Rifles', 'Muzzle'),
        ('Flash Hider for Assault Rifles', 'Muzzle'),
        ('Flash Hider for SMG', 'Muzzle'),
        ('Flash Hider for Sniper Rifles', 'Muzzle'),
        ('Suppressor for AR, S12K', 'Muzzle'),
        ('Suppressor for SMG', 'Muzzle'),
        ('Suppressor for Handgun', 'Muzzle'),
        ('Suppressor for Sniper Rifles', 'Muzzle'),
        ('Angled Foregrip', 'Lower Rail'),
        ('Vertical Foregrip', 'Lower Rail'),
        ('Quiver', 'Lower Rail'),
        ('Red Dot Sight', 'Upper Rail'),
        ('Dot Sight', 'Upper Rail'),
        ('Holographic Sight', 'Upper Rail'),
        ('2x Aimpoint Scope', 'Upper Rail'),
        ('4x ACOG Scope', 'Upper Rail'),
        ('8x CQBSS Scope', 'Upper Rail'),
        ('15x PM II Scope', 'Upper Rail'),
        ('Extended Mag for P9, P1911, P18C', 'Magazine'),
        ('Extended QuickDraw Mag for P9, P1911, P18C', 'Magazine'),
        ('QucikDraw Mag for P9, P1911, P18C', 'Magazine'),
        ('Extended Mag for Micro UZI, UMP9, Vector', 'Magazine'),
        ('Extended QuickDraw Mag for Micro UZI, UMP9, Vector', 'Magazine'),
        ('QuickDraw Mag for Micro UZI, UMP9, Vector', 'Magazine'),
        ('Extended Mag for AR, S12K', 'Magazine'),
        ('QuickDraw Mag for AR, S12K', 'Magazine'),
        ('Extended QuickDraw Mag for AR, S12K', 'Magazine'),
        ('Extended Mag for M24, AWM, SKS, VSS, Mk14, Mini14', 'Magazine'),
        ('Extended QuickDraw Mag for M24, AWM, SKS, VSS, Mk14, Mini14', 'Magazine'),
        ('QuickDraw Mag for M24, AWM, SKS, VSS, Mk14, Mini14', 'Magazine'),
        ('Bullet Loops for S1897, S686', 'Stock'),
        ('Stock', 'Stock'),
        ('Tactical Stock', 'Stock'),
        ('Bullet Loops for Kar98k', 'Stock'),
        ('Cheek Pad for Sniper Rifle', 'Stock');
        
INSERT INTO Equipments(`ItemName`, `Level`, `DamageReduction`,`CapacityExtension`, `Weight`, `EquipmentType`)
	VALUES
		('Motorcycle Helmet(Green)', 1, 0.3, 0, 40, 'Headgear'),
        ('Motorcycle Helmet(Grey)', 1, 0.3, 0, 40, 'Headgear'),
		('Military Helmet(Desert Camo)', 2, 0.4, 0, 50, 'Headgear'),
		('Military Helmet(Woodland Camo)', 2, 0.4, 0, 50, 'Headgear'),
		('Spetsnaz Helmet', 3, 0.55, 0, 60,'Headgear'),
		('Police Vest1', 1, 0.3, 50, 120, 'Armored vests'),
		('Police Vest2', 2, 0.4, 50, 150, 'Armored vests'),
		('Military Vest', 3, 0.55, 50, 180, 'Armored vests'),
		('Utility Belt', 0, 0, 50, 20, 'Belts'),
		('Ghillie Suit', 0, 0, 0, 100, 'Outer'),
		('Backpack1', 1, 0 , 150, 400, 'Back'),
		('Backpack2', 1, 0, 150, 400, 'Back'),
		('Backpack3', 2, 0, 200, 400, 'Back'),
		('Backpack4', 2, 0, 200, 400, 'Back'),
		('Backpack5', 3, 0, 250, 400, 'Back'),
		('Backpack6', 3, 0, 250, 400, 'Back'),
		('Parachute', 0, 0, 0, 400, 'Back');
        
INSERT INTO Attaches(`AttachmentName`, `WeaponName`)
	VALUES
     ('Choke', 'S1897'),
	 ('Choke', 'S686'),
     ('Compensator for Assault Rifles', 'AKM'),
     ('Compensator for Assault Rifles', 'M16A4'),
     ('Compensator for Assault Rifles', 'M416'),
     ('Compensator for Assault Rifles', 'SCAR-L'),
     ('Compensator for Assault Rifles', 'S12K'),
	 ('Compensator for Sniper Rifles', 'M24'),
	 ('Compensator for Sniper Rifles', 'AWM'),
     ('Compensator for Sniper Rifles', 'SKS'),
     ('Compensator for Sniper Rifles', 'MINI14'),
     ('Angled Foregrip', 'M416'),
     ('Angled Foregrip', 'SCAR-L'),
     ('Angled Foregrip', 'UMP9'),
     ('Angled Foregrip', 'SKS'),
     ('Vertical Foregrip', 'M416'),
	 ('Vertical Foregrip', 'SCAR-L'),
	 ('Vertical Foregrip', 'SKS'),
     ('Red Dot Sight', 'P18C'),
     ('Red Dot Sight', 'M16A4'),
     ('Red Dot Sight', 'M416'),
     ('Red Dot Sight', 'SCAR-L'),
     ('Red Dot Sight', 'P18C'),
     ('Red Dot Sight', 'CROSSBOW'),
     ('Stock', 'MICRO UZI'),
     ('Tactical Stock', 'M416'),
	 ('2x Aimpoint Scope', 'UMP9'),
     ('2x Aimpoint Scope', 'M416'),
     ('2x Aimpoint Scope', 'SCAR-L'),
     ('2x Aimpoint Scope', 'M249'),
     ('2x Aimpoint Scope', 'M24'),
     ('2x Aimpoint Scope', 'MINI14'),
     ('2x Aimpoint Scope', 'S12K'),
     ('4x ACOG Scope', 'UMP9'),
     ('4x ACOG Scope', 'M16A4'),
     ('4x ACOG Scope', 'M416'),
     ('4x ACOG Scope', 'SCAR-L'),
     ('4x ACOG Scope', 'S12K'),
     ('4x ACOG Scope', 'M24');

LOAD DATA LOCAL INFILE 'Vehicles.csv' INTO TABLE Vehicles
	FIELDS TERMINATED BY ',' ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE 'Consumables.csv' INTO TABLE Consumables
	FIELDS TERMINATED BY ',' ENCLOSED BY '"'
    LINES TERMINATED BY '\n'



