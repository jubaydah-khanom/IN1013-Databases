USE rest_database

-- 1

SELECT first_name, surname
FROM restStaff T1
INNER JOIN restBill T2
ON T1.staff_no = T2.waiter_no
WHERE cust_name = 'Tanya Singh';

-- 2

SELECT room_date 
FROM restStaff T1 
INNER JOIN restRoom_management T2 
ON T1.staff_no = T2.headwaiter 
WHERE first_name = 'Charles' AND room_name = 'Green';

-- 3

SELECT T1.first_name, T1.surname 
FROM restStaff T1 
INNER JOIN restStaff T2 
ON T1.headwaiter = T2.headwaiter 
WHERE T2.first_name = 'Zoe' AND T2.surname = 'Ball';

-- 4

SELECT T1.cust_name, T1.bill_total, T2.first_name, T2.surname 
FROM restBill T1 
INNER JOIN restStaff T2 
ON T1.waiter_no = T2.staff_no 
ORDER BY T1.bill_total DESC;

-- 5

SELECT T2.first_name, T2.surname
FROM restBill T1
INNER JOIN restStaff T2
ON T1.waiter_no = T2.staff_no
WHERE T1.bill_no in (00014, 00017);

-- 6

SELECT first_name, surname
FROM restStaff T1
INNER JOIN restRoom_management T2
ON T2.headwaiter = T1.headwaiter
WHERE T2.room_name = 'Blue' AND T2.room_date = 160312
UNION
SELECT first_name, surname
FROM restStaff T1
INNER JOIN restRoom_management T2
ON T1.staff_no = T2.headwaiter
WHERE T2.room_name = 'Blue' AND T2.room_date = 160312;
