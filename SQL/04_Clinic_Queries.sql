-- 1. Revenue from each sales channel in a given year
SELECT 
    sales_channel,
    SUM(amount) AS total_revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY sales_channel;

-- 2. Top 10 most valuable customers in a given year
SELECT 
    cs.uid,
    c.name,
    SUM(cs.amount) AS total_spent
FROM clinic_sales cs
JOIN customer c ON cs.uid = c.uid
WHERE YEAR(cs.datetime) = 2021
GROUP BY cs.uid, c.name
ORDER BY total_spent DESC
LIMIT 10;

-- 3. Month-wise revenue, expense, profit, and status
WITH revenue AS (
    SELECT 
        MONTH(datetime) AS month,
        SUM(amount) AS total_revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = 2021
    GROUP BY MONTH(datetime)
),
expenses_cte AS (
    SELECT 
        MONTH(datetime) AS month,
        SUM(amount) AS total_expense
    FROM expenses
    WHERE YEAR(datetime) = 2021
    GROUP BY MONTH(datetime)
)
SELECT 
    r.month,
    r.total_revenue,
    IFNULL(e.total_expense, 0) AS total_expense,
    (r.total_revenue - IFNULL(e.total_expense, 0)) AS profit,
    CASE 
        WHEN (r.total_revenue - IFNULL(e.total_expense, 0)) > 0 
        THEN 'PROFITABLE'
        ELSE 'NOT_PROFITABLE'
    END AS status
FROM revenue r
LEFT JOIN expenses_cte e ON r.month = e.month
ORDER BY r.month;

-- 4. Most profitable clinic in each city (given month & year)
WITH clinic_profit AS (
    SELECT 
        c.city,
        c.cid,
        c.clinic_name,
        IFNULL(SUM(cs.amount), 0) - IFNULL(SUM(e.amount), 0) AS profit
    FROM clinics c
    LEFT JOIN clinic_sales cs 
        ON c.cid = cs.cid 
        AND MONTH(cs.datetime) = 10
        AND YEAR(cs.datetime) = 2021
    LEFT JOIN expenses e 
        ON c.cid = e.cid 
        AND MONTH(e.datetime) = 10
        AND YEAR(e.datetime) = 2021
    GROUP BY c.city, c.cid, c.clinic_name
),
ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY city ORDER BY profit DESC) AS rnk
    FROM clinic_profit
)
SELECT city, cid, clinic_name, profit
FROM ranked
WHERE rnk = 1;

-- 5. Second least profitable clinic in each state (given month & year)
WITH clinic_profit AS (
    SELECT 
        c.state,
        c.cid,
        c.clinic_name,
        IFNULL(SUM(cs.amount), 0) - IFNULL(SUM(e.amount), 0) AS profit
    FROM clinics c
    LEFT JOIN clinic_sales cs 
        ON c.cid = cs.cid 
        AND MONTH(cs.datetime) = 10
        AND YEAR(cs.datetime) = 2021
    LEFT JOIN expenses e 
        ON c.cid = e.cid 
        AND MONTH(e.datetime) = 10
        AND YEAR(e.datetime) = 2021
    GROUP BY c.state, c.cid, c.clinic_name
),
ranked AS (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY state ORDER BY profit ASC) AS rnk
    FROM clinic_profit
)
SELECT state, cid, clinic_name, profit
FROM ranked
WHERE rnk = 2;
