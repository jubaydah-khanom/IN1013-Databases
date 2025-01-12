-- 1

CREATE VIEW samsBills AS (
    SELECT first_name, surname, bill_date, cust_name, bill_total
    FROM restStaff A 
    INNER JOIN restBill B
    ON A.staff_no = B.waiter_no
    WHERE staff_no = '004'
);

-- 2

SELECT * FROM samsBills
WHERE bill_total >= 400.00;

-- 3

CREATE VIEW roomTotals (room_name, total_sum) AS (
    SELECT room_name, SUM(bill_total)
    FROM restRest_table A
    INNER JOIN restBill B
    ON  A.table_no = B.table_no
    GROUP BY room_name
);

-- 4

CREATE VIEW teamTotals (headwaiter_name, total_sum) AS (
    SELECT CONCAT(B.first_name, ' ', B.surname), SUM(bill_total)
    FROM restStaff A
    INNER JOIN restStaff B
    ON B.staff_no = A.headwaiter
    INNER JOIN restBill B
    WHERE A.staff_no = B.waiter_no
    GROUP BY B.first_name, B.surname
);