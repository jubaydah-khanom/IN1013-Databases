/*
Student name: Jubaydah Khanom             
Student ID: 240034901            
*/

/* SECTION 1 - CREATE TABLE STATEMENTS */

CREATE TABLE gymMembers (
    member_id INTEGER(4) PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    date_of_birth INTEGER(6) NOT NULL,
    gender VARCHAR(6),
    contact_number VARCHAR(15)
);

CREATE TABLE gymMembership (
    member_id INTEGER(4),
    membership_name VARCHAR(10),
    monthly_fee DECIMAL(4, 2) NOT NULL,
    start_date INTEGER(6) NOT NULL,
    end_date INTEGER(6),
    FOREIGN KEY (member_id) REFERENCES gymMembers (member_id),
    PRIMARY KEY (membership_name, member_id)
);

CREATE TABLE gymActivities (
    activity_name VARCHAR(50) PRIMARY KEY,
    fee DECIMAL(4,2) NOT NULL
);

CREATE TABLE gymBookings (
    booking_id INTEGER(6) PRIMARY KEY,
    member_id INTEGER(4),
    booking_date INTEGER(6) NOT NULL,
    status TINYINT(1) NOT NULL,
    activity_name VARCHAR(50) NOT NULL,
    FOREIGN KEY (member_id) REFERENCES gymMembers (member_id),
    FOREIGN KEY (activity_name) REFERENCES gymActivities (activity_name)
);

/* SECTION 2 - INSERT STATEMENTS */

INSERT INTO gymMembers VALUES
    (5001, "Oliver Queen", 850516, "Male", "07123456789"),
    (0402, "Felicity Smoak", 880104, "Female", "07234567890"),
    (0203, "John Diggle", 810611, "Male", NULL),
    (0104, "Roy Harper", 960830, "Male", "07890123456"),
    (1005, "Thea Queen", 991228, "Female", "07765432109"),
    (2006, "Laurel Lance", 850412, "Female", "07456789012"),
    (0047, "Sara Lance", 880906, NULL, "07543210987"),
    (1008, "Curtis Holt", 870214, NULL, NULL),
    (0409, "Rene Ramirez", 870725, "Male", NULL),
    (0160, "Dinah Drake", 911120, "Female", "07876543210"),
    (0111, "Quentin Lance", 980420, "Male", "07654321098"),
    (0122, "Tommy Merlyn", 920314, "Male", "07345678901"),
    (0183, "Malcolm Merlyn", 951231, "Male", "07234567890"),
    (0114, "Lyla Michaels", 920601, "Female", "07901234567"),
    (9015, "Ray Palmer", 930526, "Male", "07789012345"),
    (0516, "Shado Fei", 930103, "Female", "07567890123");

INSERT INTO gymMembership VALUES
    (5001, "Premium", 50.00, 230315, NULL),  
    (0402, "Basic", 00.00, 230726, 240501),
    (0203, "Standard", 35.00, 230920, 240713),
    (0104, "Basic", 00.00, 240104, NULL),
    (1005, "Standard", 35.00, 240209, NULL),
    (2006, "Standard", 35.00, 230811, 240905),
    (0047, "Standard", 35.00, 230811, 240222),
    (1008, "Premium", 50.00, 240423, 240504),
    (0409, "Basic", 00.00, 240401, NULL),
    (0160, "Standard", 35.00, 230401, 240611),
    (0111, "Standard", 35.00, 230612, NULL),
    (0122, "Standard", 35.00, 240930, NULL),
    (0183, "Premium", 50.00, 230805, 240416),
    (0114, "Basic", 00.00, 230725, NULL),
    (9015, "Premium", 50.00, 240622, 240817),
    (0516, "Premium", 50.00, 250105, NULL);

INSERT INTO gymActivities VALUES
    ("Gym", 05.00),
    ("Steam Room", 07.00),
    ("Spa", 10.00),
    ("Badminton", 15.00),
    ("Tennis", 12.00),
    ("Football", 05.00),
    ("Pilates Class", 15.00),
    ("Yoga Class", 15.00),
    ("Strength Conditioning Class", 15.00),
    ("Swimming", 06.00),
    ("Volleyball", 10.00),
    ("Boxing Class", 15.00);

INSERT INTO gymBookings VALUE
    (384212, 5001, 230521, 1, "Gym"),
    (482293, 5001, 230521, 1, "Steam Room"),
    (892042, 1005, 240521, 1, "Gym"),
    (782554, 0203, 240511, 0, "Gym"),
    (372813, 0047, 230904, 1, "Badminton"),
    (732145, 1005, 240526, 1, "Gym"),
    (943245, 0111, 240517, 0, "Spa"),
    (453253, 5001, 230702, 0, "Gym"),
    (312344, 2006, 240519, 0, "Yoga Class"),
    (572532, 0402, 230807, 1, "Pilates Class"),
    (325421, 0183, 240111, 1, "Gym");



/* SECTION 3 - UPDATE STATEMENTS - The queries must be explained in natural (English) language first, and then followed up by respective statements */

/* 1) Update prices of any classes to £20.00 */

UPDATE gymActivities
SET fee = 20
WHERE activity_name LIKE "%Class";

/* 2) Update Felicity Smoak's booking activity to Steam Room */

UPDATE gymBookings
SET activity_name = "Steam Room"
WHERE member_id = (
    SELECT member_id
    FROM gymMembers
    WHERE name = "Felicity Smoak");

/* SECTION 4 - SELECT STATEMENTS - The queries must be explained in natural (English) language first, and then followed up by respective SELECTs*/


/* 1) Find all Premium Members */
SELECT A.name AS "Name", A.member_id AS "Member ID"
FROM gymMembers A
INNER JOIN gymMembership B
ON A.member_id = B.member_id
WHERE membership_name LIKE "%Premium%";

/* 2) How many bookings does each activity have? */
SELECT activity_name AS "Activity", COUNT(booking_id) AS "Number of Bookings"
FROM gymBookings
GROUP BY activity_name;

/* 3) Calculate total spend on activities by each member */
SELECT A.name AS "Name", A.member_id AS "Member ID", SUM(C.fee) AS "Total Spend"
FROM gymMembers A
INNER JOIN gymBookings B
ON A.member_id = B.member_id
INNER JOIN gymActivities C
ON B.activity_name = C.activity_name
GROUP BY A.name, A.member_id;

/* 4) Find all activities that cost more than Steam Room */
SELECT activity_name AS "Activity", fee AS "Fee"
FROM gymActivities
WHERE fee > (
    SELECT fee 
    FROM gymActivities 
    WHERE activity_name = 'Steam Room'
);

/* 5) List members that have a Basic Membership and never booked an activity */
SELECT A.name AS "Name", A.member_id AS "Member ID"
FROM gymMembers A
INNER JOIN gymMembership B
ON A.member_id = B.member_id
LEFT JOIN gymBookings C
ON A.member_id = C.member_id
WHERE B.membership_name = "Basic" AND C.booking_id IS NULL;

/* 6) List all members that have booked Swimming or Gym, and the total spend on each activity */
SELECT DISTINCT A.name AS "Name", B.activity_name AS "Activity Name", SUM(C.fee) AS "Total Spend"
FROM gymMembers A
INNER JOIN gymBookings B 
ON A.member_id = B.member_id
INNER JOIN gymActivities C
ON C.activity_name = B.activity_name
WHERE B.activity_name = "Swimming" OR B.activity_name = "Gym"
GROUP BY A.name, B.activity_name
ORDER BY A.name, B.activity_name;

/* 7) List all female members and members that have booked an activity */
SELECT A.name AS "Name", A.gender AS "Gender"
FROM gymMembers A
WHERE A.gender LIKE "%Female%"
UNION
SELECT A.name AS "Name", B.activity_name AS "Activity"
FROM gymMembers A 
INNER JOIN gymBookings B
ON A.member_id = B.member_id
WHERE A.gender LIKE "%Female%";

/* 8) List members with more than one booking */
SELECT name AS "Name", member_id AS "Member ID"
FROM gymMembers
WHERE member_id IN (
    SELECT member_id
    FROM gymBookings
    GROUP BY member_id
    HAVING COUNT(member_id) > 2
);


/* SECTION 5 - DELETE ROWS - The queries must be explained in natural (English) language first, and then followed up by respective statements */

/* 1) Delete bookings for members that ended their membership */

DELETE FROM gymBookings
WHERE member_id IN (
    SELECT member_id
    FROM gymMembership
    WHERE end_date IS NOT NULL
);

/* 2) Delete activities with no bookings */

DELETE FROM gymActivities
WHERE activity_name NOT IN (
    SELECT DISTINCT activity_name
    FROM gymBookings
);


/* SECTION 6 - DROP TABLES */

DROP TABLE gymBookings;
DROP TABLE gymActivities;
DROP TABLE gymMembership;
DROP TABLE gymMembers;

SHOW TABLES;