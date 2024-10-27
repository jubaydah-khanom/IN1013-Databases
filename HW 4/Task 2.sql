-- DROP DATABASE IF EXISTS pet_database;
-- CREATE DATABASE pet_database;
USE pet_database;

-- SCHEMA DEFINITIONS

CREATE TABLE petPet (
    petname VARCHAR(20) NOT NULL,
    owner VARCHAR(45),
    species VARCHAR(45) NOT NULL,
    gender CHAR(1) NOT NULL CHECK (gender IN ('M', 'F')), 
    birth DATE,
    death DATE,
    PRIMARY KEY (petname)
);

CREATE TABLE petEvent (
    petname VARCHAR(20) NOT NULL,
    eventdate DATE,
    eventtype VARCHAR(15), 
    remark VARCHAR(255),
    PRIMARY KEY (petname, eventdate),
    FOREIGN KEY (petname) REFERENCES petPet (petname)
)

-- DESCRIBE table; shows table in terminal





INSERT INTO petEvent VALUES
    ("Fluffy", "2020-10-15", "vet", "antibiotics"),
    ("Hammy", "2020-10-15", "vet", "antibiotics"),

INSERT INTO petPet VALUES
    ("Hammy", "Diane", "hamster", "M", "2010-10-30", NULL),

UPDATE petEvent
SET remark = "5 kittens, 2 male, 3 female"
WHERE petname = "Fluffy"
-- UPDATE petEvent
SET petname = "Claws"
WHERE eventdate = "1997-08-03"

UPDATE petPet
SET death = "2020-09-01"
WHERE petname = "Puffball"

DELETE FROM petPet








------------------------ CUTOFF POINT ------------------------------

-- Up to the end should be in task2.sql