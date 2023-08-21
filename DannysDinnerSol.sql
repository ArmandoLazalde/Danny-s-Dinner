SELECT 
  * 
FROM 
  dbo.menu 
SELECT 
  * 
FROM 
  dbo.members 
SELECT 
  * 
FROM 
  dbo.sales 
  
-- 1. What is the total amount each customer spent at the restaurant?
SELECT 
  s.customer_id, 
  SUM(m.price) AS total_amt 
FROM 
  sales s 
  INNER JOIN menu m ON s.product_id = m.product_id 
GROUP BY 
  s.customer_id;

-- 2. How many days has each customer visited the restaurant?
SELECT 
  customer_id, 
  COUNT(
    DISTINCT (order_date)
  ) AS days_visited 
FROM 
  sales 
GROUP BY 
  customer_id;

-- 3. What was the first item from the menu purchased by each customer?
WITH customer_first_purchase AS(
  SELECT 
    customer_id, 
    MIN(order_date) AS first_purchase_date 
  FROM 
    sales 
  GROUP BY 
    customer_id
) 
SELECT 
  cfp.customer_id, 
  cfp.first_purchase_date, 
  m.product_name 
FROM 
  customer_first_purchase cfp 
  INNER JOIN sales s ON cfp.customer_id = s.customer_id 
  AND cfp.first_purchase_date = s.order_date 
  JOIN menu m ON m.product_id = s.product_id;

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT 
  m.product_name, 
  COUNT(*) AS purchase_times 
FROM 
  sales s 
  JOIN menu m ON s.product_id = m.product_id 
GROUP BY 
  m.product_name 
ORDER BY 
  purchase_times DESC;

-- 5. Which item was the most popular for each customer?
WITH customer_popularity AS (
  SELECT 
    s.customer_id, 
    m.product_name, 
    COUNT(*) AS purchase_times, 
    ROW_NUMBER() OVER(
      PARTITION BY s.customer_id 
      ORDER BY 
        COUNT (*) DESC
    ) AS Rank 
  FROM 
    sales s 
    JOIN menu m ON s.product_id = m.product_id 
  GROUP BY 
    m.product_name, 
    s.customer_id
) 
SELECT 
  cp.customer_id, 
  cp.product_name, 
  cp.purchase_times 
FROM 
  customer_popularity cp 
WHERE 
  Rank = 1;

-- 6. Which item was purchased first by the customer after they became a member?
WITH purchased AS (
  SELECT 
    s.customer_id, 
    MIN(s.order_date) AS first_purchase 
  FROM 
    sales s 
    JOIN members mb ON s.customer_id = mb.customer_id 
  WHERE 
    s.order_date >= mb.join_date 
  GROUP BY 
    s.customer_id
) 
SELECT 
  p.customer_id, 
  m.product_name 
FROM 
  purchased p 
  JOIN sales s ON s.customer_id = p.customer_id 
  JOIN menu m ON m.product_id = s.product_id 
WHERE 
  p.first_purchase = s.order_date 
  
 -- 7. Which item was purchased just before the customer became a member?
  WITH last_purchased AS (
    SELECT 
      s.customer_id, 
      MAX(s.order_date) AS last_purchase 
    FROM 
      sales s 
      JOIN members mb ON s.customer_id = mb.customer_id 
    WHERE 
      s.order_date < mb.join_date 
    GROUP BY 
      s.customer_id
  ) 
SELECT 
  lp.customer_id, 
  m.product_name 
FROM 
  last_purchased lp 
  JOIN sales s ON s.customer_id = lp.customer_id 
  JOIN menu m ON m.product_id = s.product_id 
WHERE 
  lp.last_purchase = s.order_date 
  
-- 8. What is the total items and amount spent for each member before they became a member?
SELECT 
  s.customer_id, 
  COUNT(*) AS Total_items, 
  SUM(m.price) AS Total_amt 
FROM 
  sales s 
  JOIN members mb ON s.customer_id = mb.customer_id 
  JOIN menu m ON s.product_id = m.product_id 
WHERE 
  s.order_date < mb.join_date 
GROUP BY 
  s.customer_id 

-- 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
SELECT 
  s.customer_id, 
  SUM(
    CASE WHEN m.product_name = 'sushi' THEN m.price * 20 ELSE m.price * 10 END
  ) AS total_points 
FROM 
  menu m 
  JOIN sales s ON s.product_id = m.product_id 
GROUP BY 
  s.customer_id 

-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - 
-- how many points do customer A and B have at the end of January?
SELECT 
  s.customer_id, 
  SUM(
    CASE WHEN s.order_date BETWEEN mb.join_date 
    AND DATEADD(day, 7, mb.join_date) THEN m.price * 20 WHEN m.product_name = 'sushi' THEN m.price * 20 ELSE m.price * 10 END
  ) AS total_points 
FROM 
  sales s 
  JOIN menu m ON s.product_id = m.product_id 
  LEFT JOIN members mb ON s.customer_id = mb.customer_id 
WHERE 
  s.customer_id IN ('A', 'B') 
  AND s.order_date <= '2021-01-31' 
GROUP BY 
  s.customer_id;

-- 11. The following requirements are related creating basic data tables that Danny and his team can use to quickly derive insights 
-- without needing to join the underlying tables using SQL.
SELECT 
  s.customer_id, 
  s.order_date, 
  m.product_name, 
  m.price, 
  CASE WHEN s.order_date >= mb.join_date THEN 'Y' ELSE 'N' END AS member 
FROM 
  sales s 
  JOIN menu m ON s.product_id = m.product_id 
  INNER JOIN members mb ON s.customer_id = mb.customer_id 
ORDER BY 
  s.customer_id, 
  s.order_date;

-- 12. Rank all the things 
WITH customers_data AS (
  SELECT 
    s.customer_id, 
    s.order_date, 
    m.product_name, 
    m.price, 
    CASE WHEN s.order_date < mb.join_date THEN 'N' WHEN s.order_date >= mb.join_date THEN 'Y' ELSE 'N' END AS member 
  FROM 
    sales s 
    LEFT JOIN members mb ON s.customer_id = mb.customer_id 
    JOIN menu m ON s.product_id = m.product_id
) 
SELECT 
  *, 
  CASE WHEN member = 'N' THEN NULL ELSE RANK () OVER(
    PARTITION BY customer_id, 
    member 
    ORDER BY 
      order_date
  ) END AS ranking 
FROM 
  customers_data 
ORDER BY 
  customer_id, 
  order_date;
