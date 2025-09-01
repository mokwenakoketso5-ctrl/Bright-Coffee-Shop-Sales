

SELECT 
       --1.Categorical data
       store_location,
       product_category,
       product_detail,
       product_type,
        --2.Unique identifiers
        COUNT(DISTINCT transaction_id) AS number_of_sales,
        COUNT(DISTINCT product_id) AS number_of_unique_products,
        COUNT(DISTINCT store_id) AS number_of_stores,

        --3.Dates
        TO_DATE(transaction_date) AS transaction_date,
        DAYOFMONTH(TO_DATE(transaction_date)) AS day_of_month,
        MONTHNAME(TO_DATE(transaction_date)) AS month_name,
        DAYOFWEEK(TO_DATE(transaction_date)) AS day_of_week,
        TO_CHAR(TO_DATE(transaction_date), 'YYYYMM') AS month_id,

        --4)Time buckets
        CASE
            WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
            WHEN transaction_time BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
            WHEN transaction_time BETWEEN '17:00:00' AND '19:59:59' THEN 'Evening'
            ELSE 'Night'
        END AS time_buckets,

        --5)Quantitative data(revenue)
        SUM(transaction_qty*unit_price) AS revenue,

        -- 6)Days
        CASE
            WHEN DAYNAME(transaction_date) NOT IN ('Saturday', 'Sunday') THEN 'Weekday'
        ELSE 'Weekend'
         END AS day_category
 FROM bright_coffee.sales.analysis
  GROUP BY ALL;
  
