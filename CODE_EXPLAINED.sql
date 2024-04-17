-- JOIN (add) the Reasons table to the Absenteeism_at_work table (the main table) so we can add the reason (reasons.reasons) to it. 
SELECT * FROM Absenteeism_at_work a
--LEFT JOIN becuase you want ALL columns from the the table on the left (the Absenteeism_at_work table is on the left)
LEFT JOIN Compensation c ON c.id = a.id /*The resulting table will now include the column "comp_hr"**/
--LEFT JOIN the Reasons table to add the reasoning for the absence depending on the number in the Reason_for_absense column in the Absenteeism_at_work table
LEFT JOIN Reasons r ON r.Number = a.Reason_for_absence;

--Find the "healthiest" of the employees who would recieve part of the bonus  
SELECT * FROM Absenteeism_at_work
--They do not drink nor do they smoke
WHERE Social_drinker = 0 AND Social_smoker = 0
--Their BMI is considered "Healthy"
AND Body_mass_index IS BETWEEN 18.5 AND 25
--Their absenteeism (in hours) is LESS THAN the avaerage absenteeism of everybody (in hours)
AND Absenteeism_time_in_hours < (SELECT AVG(Absenteeism_time_in_hours) FROM Absenteeism_at_work);

--Compensation Rate Increase for Non-Smokers ($983,221 bonus for the budget to distribute each hour for every non-smoker)
SELECT COUNT(*) AS "Non-Smokers" FROM Absenteeism_at_work
WHERE Social_smoker = 0;
--686 non-smokers
--8 hours a day for 5 days a week for 52 weeks a year = 2,080 hours/year
--2080 hours * 686 non-smokers = 1,426,880 hours to distrubute the budget to
--$983,221 / 1,426,880 hours = 0.68 cents/hour 
--2080 hours/year * 0.68 cents/hour = $1,414.40/year extra for non-smokers

--Optimizing The Query (This will be submitted to Power BI) (No duplicate columns)
SELECT
a.ID, r.Reason, a.Month_of_absence, a.Day_of_the_week, a.Seasons, a.Transportation_Expense, a.Age, a.Work_load_Average_Day, a.Education, a.Son,
a.Social_Drinker, a.Social_Smoker, a.Absenteeism_Time_In_Hours AS 'Hours Absent',
--Turn the numbers of months to seasons
CASE WHEN Month_of_absence IN (1,2,12) THEN 'Winter'
	 WHEN Month_of_absence IN (3,4,5) THEN 'Spring'
	 WHEN Month_of_absence IN (6,7,8) THEN 'Summer'
	 WHEN Month_of_absence IN (9,10,11) THEN 'Fall'
	 ELSE 'Unknown' END AS Season_Names,
--Turn the BMI to categories
CASE WHEN Body_mass_index < 18.5 THEN 'Underweight'
	 WHEN Body_mass_index BETWEEN 18.5 AND 25 THEN 'Healthy Weight'
	 WHEN Body_mass_index BETWEEN 25 AND 30 THEN 'Overweight'
	 WHEN Body_mass_index > 30 THEN 'Obese'
	 ELSE 'Unknown' END AS BMI_Category,
--Turn the day of the week to the corresponding day of the week
CASE WHEN Day_of_the_week = 1 THEN 'Monday'
	 WHEN Day_of_the_week = 2 THEN 'Tuesday'
	 WHEN Day_of_the_week = 3 THEN 'Wednesday'
	 WHEN Day_of_the_week = 4 THEN 'Thursday'
	 WHEN Day_of_the_week = 5 THEN 'Friday'
	 WHEN Day_of_the_week = 6 THEN 'Saturday'
	 ELSE 'Sunday' END AS Week_Day,
--Turn the month of absence to the corresponding month
CASE WHEN Month_of_absence = 1 THEN 'January'
	 WHEN Month_of_absence = 2 THEN 'February'
	 WHEN Month_of_absence = 3 THEN 'March'
	 WHEN Month_of_absence = 4 THEN 'April'
	 WHEN Month_of_absence = 5 THEN 'May'
	 WHEN Month_of_absence = 6 THEN 'June'
	 WHEN Month_of_absence = 7 THEN 'July'
	 WHEN Month_of_absence = 8 THEN 'August'
	 WHEN Month_of_absence = 9 THEN 'September'
	 WHEN Month_of_absence = 10 THEN 'October'
	 WHEN Month_of_absence = 11 THEN 'November'
	 WHEN Month_of_absence = 12 THEN 'December'
	 ELSE 'Unknown' END AS The_Month,
--Turn the social drink boolean to a yes or no
CASE WHEN Social_drinker = 1 THEN 'Yes'
	 ELSE 'No' END AS Social_Drinker,
--Turn the social smoker boolean to a yes or no
CASE WHEN Social_smoker = 1 THEN 'Yes'
	 ELSE 'No' END AS Social_Smoker,
--Turn the education boolean to one of the aforementioned degree variables
CASE WHEN Education = 1 THEN 'GED'
	 WHEN Education = 2 THEN 'Associates'
	 WHEN Education = 3 THEN 'Bachelors'
	 ELSE 'PhD' END AS Education_Degree
FROM Absenteeism_at_work a
LEFT JOIN Compensation c ON c.id = a.id
LEFT JOIN Reasons r ON r.Number = a.Reason_for_absence;
