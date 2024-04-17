SELECT
a.ID, r.Reason, a.Month_of_absence, a.Day_of_the_week, a.Seasons, a.Transportation_Expense, a.Age, a.Work_load_Average_Day, a.Education, a.Son,
a.Social_Drinker, a.Social_Smoker, a.Absenteeism_Time_In_Hours AS 'Hours Absent',
CASE WHEN Month_of_absence IN (1,2,12) THEN 'Winter'
	 WHEN Month_of_absence IN (3,4,5) THEN 'Spring'
	 WHEN Month_of_absence IN (6,7,8) THEN 'Summer'
	 WHEN Month_of_absence IN (9,10,11) THEN 'Fall'
	 ELSE 'Unknown' END AS Season_Names,
CASE WHEN Body_mass_index < 18.5 THEN 'Underweight'
	 WHEN Body_mass_index BETWEEN 18.5 AND 25 THEN 'Healthy Weight'
	 WHEN Body_mass_index BETWEEN 25 AND 30 THEN 'Overweight'
	 WHEN Body_mass_index > 30 THEN 'Obese'
	 ELSE 'Unknown' END AS BMI_Category,
CASE WHEN Day_of_the_week = 1 THEN 'Monday'
	 WHEN Day_of_the_week = 2 THEN 'Tuesday'
	 WHEN Day_of_the_week = 3 THEN 'Wednesday'
	 WHEN Day_of_the_week = 4 THEN 'Thursday'
	 WHEN Day_of_the_week = 5 THEN 'Friday'
	 WHEN Day_of_the_week = 6 THEN 'Saturday'
	 ELSE 'Sunday' END AS Week_Day,
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
CASE WHEN Social_drinker = 1 THEN 'Yes'
	 ELSE 'No' END AS Social_Drinker,
CASE WHEN Social_smoker = 1 THEN 'Yes'
	 ELSE 'No' END AS Social_Smoker,
CASE WHEN Education = 1 THEN 'GED'
	 WHEN Education = 2 THEN 'Associates'
	 WHEN Education = 3 THEN 'Bachelors'
	 ELSE 'PhD' END AS Education_Degree
FROM Absenteeism_at_work a
LEFT JOIN Compensation c ON c.id = a.id
LEFT JOIN Reasons r ON r.Number = a.Reason_for_absence;
