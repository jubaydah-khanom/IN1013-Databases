DROP DATABASE IF EXISTS pet_database;
CREATE DATABASE pet_database;
USE pet_database;

-- SCHEMA DEFINITIONS

CREATE TABLE petPet (
    petname VARCHAR(20) NOT NULL,
    owner VARCHAR(45),
    species VARCHAR(45) NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M', 'F')), 
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
    FOREIGN KEY (petname) REFERENCES petPet (petname) ON DELETE CASCADE 
    -- ON DELETE CASCADE allows for entry from petPet to also be removed from petEvent 
);

-- DESCRIBE table; shows table in terminal

-- INSERT values into tables

INSERT INTO petPet VALUES
    ("Fluffy", "Harold", "cat", "F", "1993-02-04", NULL),
    ("Claws", "Gwen", "cat", "M", "1994-03-17", NULL),
    ("Buffy", "Harold", "dog", "F", "1989-05-13", NULL),
    ("Fang", "Benny", "dog", "M", "1990-08-27", NULL),
    ("Bowser", "Diane", "dog", "M", "1979-08-31", "1995-07-29"),
    ("Chirpy", "Gwen", "bird", "F", "1998-09-11", NULL),
    ("Whistler", "Gwen", "bird", NULL, "1997-12-09", NULL),
    ("Slim", "Benny", "snake", "M", "1996-04-29", NULL),
    ("Puffball","Diane","hamster","F","1999-03-30", NULL);

INSERT INTO petEvent VALUES
    ("Fluffy", "1995-05-15", "litter", "4 kittens, 3 female, 1 male"),
    ("Buffy", "1993-06-23", "litter", "5 puppies, 2 female, 3 male"),
    ("Buffy", "1994-06-19", "litter", "3 puppies, 3 female"),
    ("Chirpy", "1999-03-21", "vet", "needed beak straightened"),
    ("Slim", "1997-08-03", "vet", "broken rib"),
    ("Slim", "1997-10-04", "vet", "broken tooth"),
    ("Bowser", "1991-10-12", "kennel", NULL),
    ("Fang", "1991-10-12", "kennel", NULL),
    ("Fang", "1998-08-28", "birthday", "Gave him a new chew toy"),
    ("Claws", "1998-03-17","birthday", "Gave him a new flea collar"),
    ("Whistler", "1998-12-09", "birthday", "First birthday");

-- INSERT new values

INSERT INTO petPet VALUES
    ("Hammy", "Diane", "hamster", "M", "2010-10-30", NULL);

INSERT INTO petEvent VALUES
    ("Fluffy", "2020-10-15", "vet", "antibiotics"),
    ("Hammy", "2020-10-15", "vet", "antibiotics");

-- UPDATE values

UPDATE petEvent
SET remark = "5 kittens, 2 male, 3 female"
WHERE petname = "Fluffy";

UPDATE petEvent
SET petname = "Claws"
WHERE eventdate = "1997-08-03";

UPDATE petPet
SET death = "2020-09-01"
WHERE petname = "Puffball";

-- DELETE values

DELETE FROM petPet
WHERE owner = "Harold" AND species = "dog";