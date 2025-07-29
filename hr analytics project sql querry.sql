create database HR_analytics;
use HR_analytics;
show tables;
select * from hr_1;
select*from hr_2;

# 1 Total number of employee-----------
select distinct count(Employeecount) as total_employee from hr_1;

# 2 Total male Employee----------
select distinct count(Employeecount) as total_male_EMPLOYEE from hr_1 where Gender="male";

# 3 Total female Employe-------
select distinct count(Employeecount) as Total_female_Employee from hr_1 where Gender="female";

# 4 Total attrition rate--------
select avg( case when Attrition = "yes" then 1 else 0 end) as total_attrition from hr_1;

# 5 Average attrition rate for all department----------
SELECT Department, AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Avg_Attrition
FROM hr_1 GROUP BY Department;

# 6 average hourly rate of male scietist research;---------
select Jobrole,avg(HourlyRate) as Average_hourly_rate from hr_1 
 where gender = "male" and Jobrole="Research Scientist" group by Jobrole;
 
# 7 Attrition rate vs monthly income stats--------
WITH AttritionRate AS (
  SELECT AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Rate FROM hr_1),
MonthlyIncome AS (SELECT CASE 
      WHEN MonthlyIncome < 10000 THEN 'Low'
      WHEN MonthlyIncome BETWEEN 10000 AND 25000 THEN 'Medium'
      WHEN MonthlyIncome > 25000 THEN 'High'
    END AS IncomeRange,MonthlyIncome FROM hr_2)
SELECT IncomeRange,AVG(MonthlyIncome) AS AverageMonthlyIncome,
(SELECT Rate FROM AttritionRate) AS OverallAttritionRate
FROM MonthlyIncome GROUP BY IncomeRange;

# 8 average working years for each department--------
SELECT h1.Department,AVG(h2.TotalWorkingYears) AS AverageWorkingYears
FROM hr_1 h1 CROSS JOIN hr_2 h2 GROUP BY h1.Department;

# 9 Job role vs work life balance--------
SELECT h1.JobRole,AVG(h2.WorkLifeBalance) AS AverageWorkLifeBalance
FROM hr_1 h1 CROSS JOIN hr_2 h2 GROUP BY h1.JobRole;

# 10 Attrition rate vs since last year promotion-----
select avg(case when h1.Attrition = "yes" then 1 else 0 end) as Attritionrate,
h2.YearsSinceLastPromotion from hr_1 h1 cross join hr_2 h2 GROUP BY h2.YearsSinceLastPromotion ;
 