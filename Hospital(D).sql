create schema D1;

select*from dialysis2;


-- KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1)KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1)

SELECT 'patients included in the transfusion summary' AS summary_type, SUM(`patients included in the transfusion summary`) AS total FROM dialysis1
UNION ALL
SELECT 'patients in nPCR summary', SUM(`patients in nPCR summary`) FROM dialysis1
UNION ALL
SELECT 'Patients included in fistula summary', SUM(`Patients included in fistula summary`) FROM dialysis1
union all
select 'patients in long term catheter summary' , SUM(`patients in long term catheter summary`) FROM dialysis1
union all
select 'patients included in hospitalization summary',SUM(`patients included in hospitalization summary`) FROM dialysis1
union all
select 'Patients included in survival summary',SUM(`Patients included in survival summary`)FROM dialysis1
union all
select'patients in hypercalcemia summary',sum(`patients in hypercalcemia summary`)FROM dialysis1;


-- KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1)KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1) KPI(1)









-- KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2)

SELECT `Profit or Non-Profit`, 
       COUNT(`Profit or Non-Profit`) AS Total,
       CONCAT(ROUND((COUNT(`Profit or Non-Profit`) / (SELECT COUNT(*) FROM dialysis1) * 100), 2), '%') AS Percentage
FROM dialysis1
GROUP BY `Profit or Non-Profit`

UNION ALL

SELECT 'Grand Total', 
       COUNT(`Profit or Non-Profit`) AS Total, 
       CONCAT(ROUND((COUNT(`Profit or Non-Profit`) / (SELECT COUNT(*) FROM dialysis1) * 100), 2), '%')
FROM dialysis1;


-- KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2) KPI(2)









-- KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3)


SELECT d1.`Chain Organization`, COUNT(d2.`Total Performance Score`) AS score_count
FROM dialysis2 AS d2
INNER JOIN dialysis1 AS d1 ON d1.state = d2.state
WHERE d2.`Total Performance Score` = 'No Score'
GROUP BY d1.`Chain Organization`
ORDER BY score_count DESC;


-- KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3) KPI(3)









-- KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4)

SELECT state,SUM(`# of Dialysis Stations`) AS TotalDialysisStations
FROM dialysis1
GROUP BY state
order by TotalDialysisStations desc limit 10;

-- KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4) KPI(4)











-- KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5)


SELECT 'hospitalization_text' AS category, COUNT(*) AS count
FROM dialysis1
WHERE `Patient hospitalization category text` = 'As Expected'

UNION ALL
SELECT 'survival_text' AS category, COUNT(*) AS count
FROM dialysis1
WHERE `Patient Survival Category Text` = 'As Expected'

UNION ALL
SELECT 'infection_text' AS category, COUNT(*) AS count
FROM dialysis1
WHERE `Patient Infection category text` = 'As Expected'

UNION ALL
SELECT 'fistula_text' AS category, COUNT(*) AS count
FROM dialysis1
WHERE `Fistula Category Text` = 'As Expected'

UNION ALL
SELECT 'swr_text' AS category, COUNT(*) AS count
FROM dialysis1
WHERE `SWR category text` = 'As Expected'

UNION ALL
SELECT 'pppw_text' AS category, COUNT(*) AS count
FROM dialysis1
WHERE `PPPW category text` = 'As Expected';


-- KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5) KPI(5)











-- KPI(6) KPI(6)  KPI(6) KPI(6) KPI(6) KPI(6) KPI(6) KPI(6) KPI(6) KPI(6) KPI(6) KPI(6) KPI(6) KPI(6) KPI(6) KPI(6) KPI(6) KPI(6) KPI(6)


SELECT ROUND(SUM(CASE 
 WHEN `PY2020 Payment Reduction Percentage`!= 'No Reduction' 
 THEN CAST(`PY2020 Payment Reduction Percentage` AS DECIMAL(10, 2)) 
 ELSE 0 
 END) / NULLIF(COUNT(CASE 
 WHEN `PY2020 Payment Reduction Percentage` != 'No Reduction' 
 THEN 1 END), 0), 5) AS 'Average Payment Reduction Rate' 
 FROM 
 dialysis2;

-- KPI(6) KPI(6)  KPI(6) KPI(6) KPI(6) KPI(6) KPI(6) KPI(6) KPI(6) KPI(6) KPI(6) KPI(6) KPI(6) KPI(6) KPI(6) KPI(6) KPI(6) KPI(6) KPI(6)






