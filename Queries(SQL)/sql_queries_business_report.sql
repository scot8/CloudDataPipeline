
-- Aggregating Data
SELECT 
    Month, 
    AVG(CAST(TotalOrders AS INT)) AS AverageOrdersPerMonth
FROM business_report
GROUP BY Month;

-- Pivoting Data
SELECT 
    Month,
    SUM(CAST(CASE WHEN Year = '2017' THEN TotalSales ELSE '0' END AS FLOAT)) AS Sales2017,
    SUM(CAST(CASE WHEN Year = '2018' THEN TotalSales ELSE '0' END AS FLOAT)) AS Sales2018
FROM business_report
GROUP BY Month;

-- Joining Data
SELECT *
FROM business_report br
JOIN customer_data_external c ON br.CustomerID = c.CustomerID;

-- Filtering Data
SELECT *
FROM business_report
WHERE Year = '2019';
