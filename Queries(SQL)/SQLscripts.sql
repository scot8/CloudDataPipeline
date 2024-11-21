SELECT * from business_report;

Select * from customer_data_external;

SELECT *
FROM business_report br
JOIN customer_data_external c ON br.CustomerID = c.CustomerID;