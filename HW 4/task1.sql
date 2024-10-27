DROP DATABASE IF EXISTS pet_database;
CREATE DATABASE pet_database;
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

