use hr_analytic;
select *from hr_analytic.hr_table;

--  Q1 Write a SQL query to find the total number of employees in the table.
SELECT COUNT(*) AS total_employees
FROM hr_table;

-- Q2 Write a SQL query to display the number of employees in each department.
SELECT Department, COUNT(*) AS employee_count
FROM hr_table
GROUP BY Department;

-- Q3 Write a SQL query to retrieve all employees who left the company (Attrition = 'Yes').
SELECT *
FROM hr_table
WHERE Attrition = 'Yes' ;

-- Q4 Write a SQL query to find the average monthly income for each job role.
SELECT JobRole, AVG(MonthlyIncome) AS avg_salary
FROM hr_table
GROUP BY JobRole;

-- Q5 Write a SQL query to display the top 5 highest paid employees.
SELECT *
FROM hr_table
ORDER BY MonthlyIncome DESC
LIMIT 5;

-- Q6 Write a SQL query to find employees whose monthly income is above the company average.
SELECT *
FROM hr_table
WHERE MonthlyIncome >
      (SELECT AVG(MonthlyIncome) FROM hr_table);
      
-- Q7 Write a SQL query to calculate the attrition count for each department.
SELECT 
    Department,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count
FROM hr_table
GROUP BY Department;

-- Q8 Write a SQL query to show employees where YearsWithCurrManager is NULL.
SELECT *
FROM hr_table
WHERE yearswithcurrmanager IS NULL;

-- Q9 Write a SQL query to replace NULL MonthlyIncome with 0 in the output.
SELECT 
    EmployeeNumber,
    COALESCE(MonthlyIncome, 0) AS MonthlyIncome_Clean
FROM hr_table;

-- Q10  Write a SQL query to find the highest paid employee in each department.
SELECT *
FROM (
    SELECT *,
           RANK() OVER (PARTITION BY Department ORDER BY MonthlyIncome DESC) AS rnk
    FROM hr_table
) t
WHERE rnk = 1;