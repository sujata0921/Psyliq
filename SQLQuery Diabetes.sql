Create Database Diabetes_Prediction
use Diabetes_Prediction

select * from [Diabetes_prediction 1]

---1. Retrieve the Patient_id and ages of all patients.SELECT 
    Patient_id, 
    DATEDIFF(YEAR, D_O_B, GETDATE()) - 
        CASE 
            WHEN MONTH(GETDATE()) < MONTH(D_O_B) OR (MONTH(GETDATE()) = MONTH(D_O_B) AND DAY(GETDATE()) < DAY(D_O_B)) 
            THEN 1 
            ELSE 0 
        END AS Age
FROM 
    [Diabetes_prediction 1];

----2. Select all female patients who are olderthan 30.

SELECT 
    Patient_id, 
    DATEDIFF(YEAR, D_O_B, GETDATE()) - 
        CASE 
            WHEN MONTH(GETDATE()) < MONTH(D_O_B) OR (MONTH(GETDATE()) = MONTH(D_O_B) AND DAY(GETDATE()) < DAY(D_O_B)) 
            THEN 1 
            ELSE 0 
        END AS Age,
    Gender
FROM 
     [Diabetes_prediction 1]
WHERE 
    Gender = 'Female' AND
    DATEDIFF(YEAR, D_O_B, GETDATE()) - 
        CASE 
            WHEN MONTH(GETDATE()) < MONTH(D_O_B) OR (MONTH(GETDATE()) = MONTH(D_O_B) AND DAY(GETDATE()) < DAY(D_O_B)) 
            THEN 1 
            ELSE 0 
        END > 30;

----3.  Calculate the average BMI of patients.

SELECT 
    AVG(bmi) AS Average_BMI
FROM 
    [Diabetes_prediction 1]
WHERE 
    bmi IS NOT NULL;

----4. List patients in descending order of blood glucose levels.

SELECT 
    Patient_id, 
    blood_glucose_level
FROM 
    [Diabetes_prediction 1]
ORDER BY 
    blood_glucose_level DESC;

----5. Find patients who have hypertension and diabetes.
SELECT 
    Patient_id,
    EmployeeName,
    DATEDIFF(YEAR, D_O_B, GETDATE()) AS Age,
    hypertension,
    diabetes
FROM 
    [Diabetes_prediction 1]
WHERE 
    hypertension = 1  -- Assuming 1 represents 'Yes' for hypertension
    AND diabetes = 1; -- Assuming 1 represents 'Yes' for diabetes

----6. Determine the number of patients with heart disease.

SELECT 
    COUNT(*) AS Patients_With_Heart_Disease
FROM 
    [Diabetes_prediction 1]
WHERE 
    heart_disease = 1; -- Assuming 1 represents the presence of heart disease

----7. Group patients by smoking history and count how many smokers and nonsmokers there are.

SELECT 
    smoking_history AS Smoking_Status,
    COUNT(*) AS Number_of_Patients
FROM 
    [Diabetes_prediction 1]
GROUP BY 
    smoking_history;

----8. Retrieve the Patient_id of patients who have a BMI greater than the average BMI.

WITH AvgBMI AS (
    SELECT AVG(bmi) AS Average_BMI
    FROM [Diabetes_prediction 1]
)
SELECT Patient_id
FROM [Diabetes_prediction 1], AvgBMI
WHERE bmi > Average_BMI;

----9. Find the patient with the highest HbA1c level and the patient with the lowest HbA1clevel.

SELECT 
    MAX(HbA1c_level) AS Highest_HbA1c,
    MIN(HbA1c_level) AS Lowest_HbA1c
FROM 
    [Diabetes_prediction 1];

----10. Calculate the age of patients in years (assuming the current date as of now).SELECT 
    Patient_id,
    EmployeeName,
    DATEDIFF(YEAR, D_O_B, GETDATE()) AS Age
FROM 
    [Diabetes_prediction 1];

----11. Rank patients by blood glucose level within each gender group.

SELECT 
    Patient_id,
    EmployeeName,
    Gender,
    blood_glucose_level,
    ROW_NUMBER() OVER(PARTITION BY Gender ORDER BY blood_glucose_level DESC) AS Glucose_Rank
FROM 
    [Diabetes_prediction 1];

----12. Update the smoking history of patients who are olderthan 40 to "Ex-smoker."

UPDATE [Diabetes_prediction 1]
SET smoking_history = 'Ex-smoker'
WHERE DATEDIFF(YEAR, D_O_B, GETDATE()) > 40;

---- 13. Insert a new patient into the database with sample data.
INSERT INTO [Diabetes_prediction 1] (Patient_id, EmployeeName, [gender], [D_O_B], Diabetes, hypertension, heart_disease, smoking_history, bmi, HbA1c_level, blood_glucose_level)
VALUES (2, 'Sarah Doe', 'Female', '1986-12-26', 1, 0, 0, 'Non-smoker', 25.5, 6.8, 120);

---14. Delete all patients with heart disease from the database

DELETE FROM [Diabetes_prediction 1]
WHERE heart_disease = 1;

----15. Find patients who have hypertension but not diabetes using the EXCEPT operator.

-- Patients with hypertension
SELECT *
FROM [Diabetes_prediction 1]
WHERE hypertension = 1

EXCEPT

-- Patients without diabetes
SELECT *
FROM [Diabetes_prediction 1]
WHERE Diabetes = 1;

----16. Define a unique constraint on the "patient_id" column to ensure its values are unique

ALTER TABLE [Diabetes_prediction 1]
ADD CONSTRAINT UC_PatientID UNIQUE (Patient_id);

---17.Create a view that displays the Patient_ids, ages, and BMI of patients.

-- End previous batch, if any
GO

-- Create the view
CREATE VIEW Patient1Info AS
SELECT 
    Patient_id,
    DATEDIFF(YEAR, D_O_B, GETDATE()) AS Age,
    bmi
FROM [Diabetes_prediction 1];
GO -- End the batch after CREATE VIEW

























