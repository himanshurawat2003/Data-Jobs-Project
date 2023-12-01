SELECT * FROM salaries;

-- Creating a new table named as Cleaned_Salaries from the existing table where inserting the cleaned Data into it .

SELECT work_year As 'Work_Year' ,								 -- Renaming as Work Year
	   job_title As 'Job_Title' ,								 -- Renaming as Job Title
	   CASE When experience_level = 'SE' Then 'Senior Level'	 -- describing the Abbrevation
			When experience_level = 'MI' Then 'Mid-Level'		 -- describing the Abbrevation
			When experience_level = 'EN' Then 'Entry Level'		 -- describing the Abbrevation
			When experience_level = 'EX' Then 'Executive Level'  -- describing the Abbrevation
		  END As Experience ,									 -- Renaming the Column name
	   CASE When employment_type = 'PT' Then 'Part Time'		 -- describing the Abbrevation
			When employment_type = 'FT' Then 'Full Time'		 -- describing the Abbrevation
			When employment_type = 'CT' Then 'Contract'			 -- describing the Abbrevation
			When employment_type = 'FL' Then 'Freelance'		 -- describing the Abbrevation
		  END As Employment_Type ,								 
	   salary_in_usd As 'Salary_in_USD' ,						 -- Renaming the Column name
	   CASE When remote_ratio = 0 Then 'No Remote'				 -- Describing the row name
			When remote_ratio = 50 Then 'Partially Remote'		 -- Describing the row name
			When remote_ratio = 100 Then 'Fully Remote'			 -- Describing the row name
		  End As Mobility ,										 -- Renaming the Column name
	   Company_location ,										 
	   CASE When company_size = 'S' Then 'Small'				 -- describing the Abbrevation
			When company_size = 'M' Then 'Medium'				 -- describing the Abbrevation
			When company_size = 'L' Then 'Large'				 -- describing the Abbrevation
		  End As Company_Size									 
INTO Cleaned_Salary												 -- Inserting Data into New Cleaned_Salary Table
FROM salaries
WHERE salary_currency = 'USD' ;

SELECT * FROM Cleaned_Salary ;    -- Executing the New Table


