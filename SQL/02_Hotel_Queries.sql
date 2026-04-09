-- For every user in the system, get the user_id and last booked room_no
SELECT b.user_id, b.room_no
FROM bookings b
JOIN (
    SELECT user_id, MAX(booking_date) AS last_booking
    FROM bookings
    GROUP BY user_id
) lb
ON b.user_id = lb.user_id 
AND b.booking_date = lb.last_booking;

-- Get booking_id and total billing amount of every booking created in November, 2021
SELECT bc.booking_id,
       SUM(bc.item_quantity * i.item_rate) AS total_bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(bc.bill_date) = 11 
  AND YEAR(bc.bill_date) = 2021
GROUP BY bc.booking_id;

-- Get bill_id and bill amount of all the bills raised in October, 2021 having bill amount >1000
SELECT bc.bill_id,
       SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(bc.bill_date) = 10
  AND YEAR(bc.bill_date) = 2021
GROUP BY bc.bill_id
HAVING bill_amount > 1000;

-- Most ordered and least ordered item of each month in 2021
WITH item_orders AS (
    SELECT 
        MONTH(bc.bill_date) AS month,
        bc.item_id,
        SUM(bc.item_quantity) AS total_quantity
    FROM booking_commercials bc
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY MONTH(bc.bill_date), bc.item_id
),
ranked_items AS (
    SELECT *,
           RANK() OVER (PARTITION BY month ORDER BY total_quantity DESC) AS max_rank,
           RANK() OVER (PARTITION BY month ORDER BY total_quantity ASC) AS min_rank
    FROM item_orders
)
SELECT month, item_id, total_quantity,
       CASE 
           WHEN max_rank = 1 THEN 'MOST_ORDERED'
           WHEN min_rank = 1 THEN 'LEAST_ORDERED'
       END AS category
FROM ranked_items
WHERE max_rank = 1 OR min_rank = 1;

-- Customers with second highest bill value of each month (2021)
WITH monthly_bills AS (
    SELECT 
        bc.bill_id,
        b.user_id,
        MONTH(bc.bill_date) AS month,
        SUM(bc.item_quantity * i.item_rate) AS bill_amount
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    JOIN bookings b ON bc.booking_id = b.booking_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY bc.bill_id, b.user_id, MONTH(bc.bill_date)
),
ranked_bills AS (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY month ORDER BY bill_amount DESC) AS rnk
    FROM monthly_bills
)
SELECT user_id, bill_id, month, bill_amount
FROM ranked_bills
WHERE rnk = 2;