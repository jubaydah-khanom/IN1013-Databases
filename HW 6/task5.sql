-- 1

SELECT first_name, surname, bill_date, COUNT(*)
FROM restStaff A
INNER JOIN restBill B
ON A.staff_no = B.waiter_no
GROUP BY first_name, surname, bill_date
HAVING COUNT(*) >= 2;

-- 2

SELECT room_name, COUNT(*)
FROM restRest_table
WHERE no_of_seats > 6
GROUP BY room_name;

-- 3

SELECT room_name, SUM(bill_total)
FROM restBill A
INNER JOIN restRest_table B
ON A.table_no = B.table_no
GROUP BY B.room_name

-- 4 

SELECT C.first_name, C.surname, sum(bill_total)
FROM restBill A
INNER JOIN restStaff B
ON A.waiter_no = B.staff_no
INNER JOIN restStaff C
ON B.headwaiter = C.staff_no
GROUP BY C.first_name, C.surname
ORDER BY SUM(bill_total) DESC;

-- 5 

SELECT cust_name
FROM restBill
GROUP BY cust_name
HAVING AVG(bill_total) > 400;

-- 6

SELECT first_name, surname, COUNT(*)
FROM restStaff A
INNER JOIN restBill B
ON A.staff_no = B.waiter_no
GROUP BY first_name, surname, bill_date
HAVING COUNT(*) >= 3;




