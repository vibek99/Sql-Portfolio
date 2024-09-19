create schema HrAnalysis;
select*from hr_1;
select*from hr_2;

ALTER TABLE hr_1 ADD AttritionFlag INT;
UPDATE hr_1
SET AttritionFlag = CASE
    WHEN Attrition = 'Yes' THEN 1
    ELSE 0
END;

-- Average Attrition for each Dept

SELECT Department, format(avg(AttritionFlag)*100,2) AS AvgAttrition
FROM hr_1
GROUP BY Department;


-- Average working yr for each Department

SELECT h1.Department, format(AVG(h2.TotalWorkingYears),0) AS AvgTotalWorkingYears
FROM hr_1 h1
INNER JOIN hr_2 h2 ON h1.EmployeeNumber = h2.`Employee Id`
GROUP BY h1.Department
order by (format(AVG(h2.TotalWorkingYears),0))desc;






-- Average job Role BY male RS

SELECT 
    Gender, 
   JobRole,
   format(avg(HourlyRate),2)
from hr_1
WHERE 
    Gender = 'Male' and JobRole = 'Research Scientist'
GROUP BY 
    Gender;
    
    
    

-- Attrition rate vs monthly income stats

SELECT 
    h1.Gender, 
    FORMAT(AVG(h1.AttritionFlag)*100, 2) AS `Attrition Rate`,
    format(AVG(h2.MonthlyIncome),2) AS `Average Monthly Income`
FROM 
    hr_1 h1
INNER JOIN 
    hr_2 h2 ON h1.EmployeeNumber = h2.`Employee Id`
GROUP BY 
    h1.Gender
ORDER BY 
    `Attrition Rate` DESC;
    
    
    

-- Job role vs Work life Balance

SELECT 
    h1.JobRole, 
    CONCAT(FORMAT((AVG(h2.WorkLifeBalance) * 365 / 365), 2), ' years') AS WorkLifeBalYears
FROM 
    hr_1 h1
INNER JOIN 
    hr_2 h2 ON h1.EmployeeNumber = h2.`Employee Id`
GROUP BY 
    h1.JobRole
ORDER BY 
    WorkLifeBalYears DESC;
    
    -- Attrition Rate vs Year Last Promotion
    
    SELECT 
    h1.Gender, 
    FORMAT(AVG(h1.AttritionFlag)*100, 2) AS `Attrition Rate`,
    format(AVG(h2.YearsSinceLastPromotion),2) AS `YearsSinceLastPromotion`
FROM 
    hr_1 h1
INNER JOIN 
    hr_2 h2 ON h1.EmployeeNumber = h2.`Employee Id`
GROUP BY 
    h1.Gender
ORDER BY 
    `Attrition Rate` DESC;
