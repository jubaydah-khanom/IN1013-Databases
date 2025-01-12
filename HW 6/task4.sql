USE rest_database

-- 1

SELECT cust_name
FROM restBill
WHERE bill_total > 450
and waiter_no IN (
    SELECT staff_no
    FROM restStaff 
    WHERE headwaiter = (
        SELECT staff_no
        FROM restStaff
        WHERE first_name = 'Charles'
    )
);

-- 2

SELECT first_name, surname
FROM restStaff
WHERE staff_no in (
    SELECT headwaiter
    FROM restStaff
    WHERE staff_no in (
        SELECT DISTINCT waiter_no
        FROM restBill
        WHERE bill_date = 160111 and cust_name LIKE '%Nerida%')
    );

-- 3

SELECT cust_name
FROM restBill
WHERE bill_total = (
    SELECT MIN(bill_total) 
    FROM restBill
);

-- 4

SELECT first_name, surname
FROM restStaff
WHERE headwaiter IS NOT NULL AND staff_no NOT IN (
    SELECT DISTINCT waiter_no 
    FROM restBill
);

-- 5

SELECT DISTINCT A.cust_name, B.first_name, B.surname, C.room_name
FROM restBill A
INNER JOIN restRest_table C
ON A.table_no = C.table_no
INNER JOIN restRoom_management D
ON D.room_name = C.room_name
INNER JOIN restStaff B
ON B.staff_no = D.headwaiter
WHERE bill_total = (
    SELECT MAX(bill_total)
    FROM restBill
);

