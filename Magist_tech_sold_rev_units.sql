use magist;

-- Is Magist having user growth? Technical growth from 2017 to 2018. But last 9.18 and 10.18 sold close to nothing
select order_purchase_timestamp from orders;


SELECT -- avg price tech sold per year
    ROUND(AVG(price), 2) AS avg_unique_price, 
    purchased_year
FROM (
    SELECT DISTINCT 
        product_id, 
        price, 
        CASE 
            WHEN YEAR(o.order_purchase_timestamp) = 2018 THEN "2018"
            WHEN YEAR(o.order_purchase_timestamp) = 2017 THEN "2017"
            ELSE "2016"
        END AS purchased_year
    FROM order_items oi
    JOIN orders o USING (order_id) -- Need this for the timestamp!
    JOIN products p USING (product_id)
    JOIN product_category_name_translation t USING (product_category_name)
    WHERE product_category_name_english IN ('computers', 'electronics', 'audio','computers_accessories','telephony')
) AS unique_product_sold -- Alias goes OUTSIDE the parentheses
GROUP BY purchased_year
ORDER BY purchased_year DESC;

-- tech categories and their prices
SELECT 
    t.product_category_name_english AS category,
    COUNT(DISTINCT oi.product_id) AS unique_products,
    ROUND(AVG(oi.price), 2) AS average_price,
    ROUND(MAX(oi.price), 2) AS most_expensive_item,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
JOIN products p USING (product_id)
JOIN orders USING (order_id)
JOIN product_category_name_translation t USING (product_category_name)
WHERE t.product_category_name_english IN (
    'computers', 
    'electronics', 
    'computers_accessories', 
    'telephony'
    'audio'
) and order_status='delivered'
GROUP BY category
ORDER BY average_price DESC;

- How many Tech sellers are there? What percentage of overall sellers are Tech sellers? 
-- 387 total
select 387/3085;
SELECT count(DISTINCT seller_id) 
FROM sellers
-- 1. Link seller to their items
LEFT JOIN order_items oi USING (seller_id)
-- 2. Link items to the products (this connects category names)
LEFT JOIN products p USING (product_id)
-- 3. Link Portuguese names to English names (Fix: Use product_category_name)
LEFT JOIN product_category_name_translation pt USING (product_category_name)
WHERE 
    pt.product_category_name_english IN (
        'audio', 
        'electronics', 
        'computers_accessories', 
        'pc_gamer', 
        'computers', 
        'tablets_printing_image' -- Check if yours has the 's'
    );


-- What is the total amount earned by all sellers? 13 221 498
-- What is the total amount earned by all Tech sellers? 1 321 858
select sum(oi.price) as total
FROM
order_items oi
left join orders o using (order_id)
LEFT JOIN products p USING (product_id)
LEFT JOIN product_category_name_translation pt USING (product_category_name)
WHERE 
    pt.product_category_name_english IN (
        'audio', 
        'electronics', 
        'computers_accessories', 
        'pc_gamer', 
        'computers', 
        'tablets_printing_image')
and o.order_status IN ('delivered');


-- Average monthly income of all sellers? 1164e
select 13221498/454/25;

-- Average monthly income of all Tech sellers? 116.46e
select 1321858/454/25;


SELECT -- avg monthly rev per tech sellers
    seller_id, 
    ROUND(SUM(price) / 25, 2) AS avg_monthly_revenue 
FROM order_items
JOIN products USING (product_id)
JOIN product_category_name_translation pt USING (product_category_name)
WHERE pt.product_category_name_english IN ('audio', 'electronics', 'computers_accessories', 'computers', 'telephony')
GROUP BY seller_id
ORDER BY avg_monthly_revenue DESC
LIMIT 10;


SELECT -- avg month units sold in tech
    YEAR(o.order_purchase_timestamp) AS year_purchased,
    COUNT(order_item_id) AS total_units_sold,
    -- Using 24 months for the full dataset span
    ROUND(COUNT(order_item_id) / 25.0, 1) AS avg_monthly_units
FROM order_items
JOIN orders o using (order_id)
JOIN products USING (product_id)
JOIN product_category_name_translation pt USING (product_category_name)
WHERE pt.product_category_name_english IN ('audio', 'electronics', 'computers_accessories', 'computers', 'telephony')
GROUP BY  year_purchased
ORDER BY 
year_purchased DESC,
total_units_sold DESC
LIMIT 10;

SELECT -- tech vs non tech sold units
    YEAR(o.order_purchase_timestamp) AS year_purchased,
    CASE 
        WHEN pt.product_category_name_english IN ('audio', 'electronics', 'computers_accessories', 'computers', 'telephony') THEN 'Tech'
        ELSE 'Non-Tech'
    END AS category_group,
    COUNT(oi.order_item_id) AS units_sold,
    COUNT(oi.order_item_id) AS total_volume
FROM 
    orders o
JOIN 
    order_items oi ON o.order_id = oi.order_id
JOIN 
    products p ON oi.product_id = p.product_id
JOIN 
    product_category_name_translation pt ON p.product_category_name = pt.product_category_name
WHERE 
    o.order_status = 'delivered'
    AND YEAR(o.order_purchase_timestamp) IN (2017, 2018)
GROUP BY 
    year_purchased, 
    category_group
ORDER BY 
    year_purchased ASC, 
    category_group DESC;
    
    select -- sales per tech categories
CASE
	WHEN year(order_purchase_timestamp)=2018 then "2018"
    WHEN year(order_purchase_timestamp)=2017 then "2017"
	ELSE "2016"
END AS "cat_ship_year",
count(*) as total_prod,
product_category_name_english,
round(avg(oi.price),2) as avg_price, round(sum(oi.price),2) as total_sold, 
ROUND((SUM(oi.price) / (
        SELECT SUM(price) 
        FROM order_items 
        JOIN orders USING (order_id) 
        WHERE order_status = 'delivered'
    )) * 100, 2) AS pct_year_sales
from products p
join product_category_name_translation using (product_category_name)
join order_items oi using (product_id)
join orders o using (order_id)
where order_status="delivered"
and product_category_name_english IN (
    'computers', 'electronics', 'computers_accessories', 'telephony', 'audio')
group by product_category_name_english, cat_ship_year
order by 
cat_ship_year desc,
total_prod desc; 
