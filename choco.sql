SELECT * FROM `awesome chocolates`.geo;
SELECT * FROM `awesome chocolates`.people;
SELECT * FROM `awesome chocolates`.products limit 20;
SELECT * FROM `awesome chocolates`.sales limit 20;


select*from geo;

select GeoID,PID,Amount,Customers,Boxes
from Sales
where GeoID='G4';

SELECT GeoID, SUM(Amount) AS TotalAmount, count(Customers) AS TotalCustomers, count(Boxes) AS TotalBoxes
FROM sales
where GeoID in ('G1' ,'G2')
GROUP BY GeoID
order by GeoID 




SELECT p.Product, p.Category, SUM(s.Amount) AS TotalAmount
FROM products
INNER JOIN sales s ON p.PID = s.PID
GROUP BY p.Product, p.Category;


SELECT p.Product, p.Category, SUM(s.Amount) AS TotalAmount
FROM sales s
INNER JOIN products p ON s.PID = p.PID
GROUP BY p.Product, p.Category;

select p.Team, p.salesperson,s.GeoID,sum(s.Amount)as TotalAmount
from sales s
inner join people p on s.SPID=p.SPID
where GeoID in('G1','G2')
group by p.Team, p.salesperson,GeoID
order by p.Team

select p.PID,p.Category,sum(s.Amount) as TOTAMNT
from sales s
inner join products p on p.PID=s.PID
where PID='P05'
group by p.PID,p.Category;

SELECT pe.Salesperson,p.PID, p.Product, sum(s.Amount) AS TOTAMNT
FROM sales s
INNER JOIN products p ON p.PID = s.PID
inner join people pe on pe.SPID=s.SPID
WHERE pe.SPID = 'SP05' and p.PID = 'P05'
GROUP BY p.PID, p.Category, pe.Salesperson
order by TOTAMNT

SELECT pe.Salesperson, p.PID, p.Product, s.SaleDate, SUM(s.Amount) AS TOTAMNT
FROM sales s
INNER JOIN products p ON p.PID = s.PID
INNER JOIN people pe ON pe.SPID = s.SPID
WHERE pe.SPID = 'SP05' AND p.PID = 'P05'
GROUP BY pe.Salesperson, p.PID, p.Product, s.SaleDate
ORDER BY TOTAMNT;


 CONCAT("$", FORMAT(SUM(s.Amount) / 1000000, 2), "M") 

SELECT p.salesperson, concat("$",format(sum(s.Amount)/1000000,2),"M") AS TotalAmount, COUNT(s.Boxes) AS TotalBoxes
FROM sales s
INNER JOIN people p ON p.SPID = s.SPID
GROUP BY p.salesperson
ORDER BY TotalAmount limit 5

-- here u can see the top 5 salesperson



----== #####$%$%$%$%$% (Call procedure----#####$%$%$%$%$%$ _______________

              call chocsale('SP02','P02','G4');
              
------ #####$%$%$%$%$% Call procedure----- #####$%$%$%$%$% _______________

-- in this` procedure u can call by anty paramtr like salesperson product or geo wise


SELECT p.Team, p.Salesperson, SUM(s.Amount) AS Total_Sales_Amount
FROM sales s
INNER JOIN people p ON p.SPID = s.SPID
GROUP BY p.Team, p.Salesperson
ORDER BY p.Team, Total_Sales_Amount desc;

-- here u can c team wise salesperson performence



select p.Salesperson,p.Location,sum(s.Amount) as TOTAL_AMOUNT
from Sales s
inner join people p on p.SPID = s.SPID
where p.Location='Hyderabad'
group by p.Salesperson,p.Location
order by TOTAL_AMOUNT

-- here u can c the location wise salesprsn sales



select g.Geo,p.Product,sum(s.Amount) as TA
from Sales s
Inner Join geo g on g.GeoID =s.GeoID
Inner join products p on p.PID = s.PID
group by g.Geo,p.Product
order by TA desc limit 5

-- here u can c the geo wise most product sales


SELECT 
    p.Team, p.Salesperson,sum(s.Amount) OVER (PARTITION BY p.SPID ORDER BY s.Amount) AS cumulative_order_amount
FROM
  sales s
inner join people p on p.SPID = s.SPID








SELECT p.salesperson,p.Team
       (s.Amount * s.Boxes) AS Sales,
       ROW_NUMBER() OVER (partition by Team ORDER BY (s.Amount * s.Boxes)) AS RowNumber
FROM sales s
INNER JOIN people p ON p.SPID = s.SPID
WHERE (s.Amount * s.Boxes) > 4;





SELECT*
from(
SELECT p.salesperson,
       p.Team,
       (s.Amount * s.Boxes) AS Sales,
       ROW_NUMBER() OVER (PARTITION BY p.Team ORDER BY p.Team ,(s.Amount * s.Boxes)desc) AS RowNumber
FROM sales s
INNER JOIN people p ON p.SPID = s.SPID
WHERE (s.Amount * s.Boxes) > 5
) as subquery
where rownumber <= 5;

select*from
(
SELECT p.salesperson,
       p.Team,
       (s.Amount * s.Boxes) AS Sales,
      dense_RANK() OVER (PARTITION BY p.Team ORDER BY p.Team ,(s.Amount * s.Boxes)) AS Rnk
FROM sales s
INNER JOIN people p ON p.SPID = s.SPID
)
As subquery
where Rnk<=3;


select*from(
    SELECT p.salesperson,
           p.Team,
           LEAD(s.Amount) OVER (PARTITION BY p.Team ORDER BY p.Team, (s.Amount * s.Boxes)) AS Lead_Sales,
         RANK() OVER (PARTITION BY p.Team ORDER BY p.Team ,(s.Amount * s.Boxes)) AS Rnk,
           CASE
                WHEN s.Amount > LAG(s.Amount) OVER (PARTITION BY p.Team ORDER BY p.Team, (s.Amount * s.Boxes)) THEN 'Higher than previous employee'
                WHEN s.Amount = LAG(s.Amount) OVER (PARTITION BY p.Team ORDER BY p.Team, (s.Amount * s.Boxes)) THEN 'Same as previous employee'
                WHEN s.Amount < LAG(s.Amount) OVER (PARTITION BY p.Team ORDER BY p.Team, (s.Amount * s.Boxes)) THEN 'Lower than previous employee'
           END AS Comparison_with_previous
    FROM sales s
    INNER JOIN people p ON p.SPID = s.SPID
) AS subquery
where Rnk<10
















