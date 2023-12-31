-- Create Database
CREATE DATABASE Suwapiyasa;

USE Suwapiyasa;

-- create table staff
CREATE TABLE Staff (
    Employee_No INT PRIMARY KEY,
    Gender VARCHAR(10),
    Name VARCHAR(50),
    Address VARCHAR(50),
    Telephone VARCHAR(15)
);

-- create table Doctor
CREATE TABLE Doctor (
    Employee_No INT PRIMARY KEY,
    Salary DECIMAL(10, 2),
    Specialty VARCHAR(50),
    HDnumber INT,
    FOREIGN KEY (Employee_No) REFERENCES Staff(Employee_No)
);

-- modify column HDnumber as varchar
ALTER TABLE Doctor 
MODIFY COLUMN HDnumber VARCHAR(10);

-- create table surgeon
CREATE TABLE Surgeon (
    Employee_No INT PRIMARY KEY,
    Contract_Type VARCHAR(50),
    Contract_Length INT,
    Specialty VARCHAR(50),
    FOREIGN KEY (Employee_No) REFERENCES Staff(Employee_No)
);

-- create table nurse
CREATE TABLE Nurse (
    Employee_No INT PRIMARY KEY,
    Salary DECIMAL(10, 2),
    YearsOfExperience INT,
    Skill_type VARCHAR(50),
    Grade VARCHAR(10),
    FOREIGN KEY (Employee_No) REFERENCES Staff(Employee_No)
);

-- create table patient
CREATE TABLE Patient (
    Patient_id INT PRIMARY KEY NOT NULL,
    Initials VARCHAR(10) NOT NULL,
    Surname VARCHAR(100) NOT NULL,
    Blood_type VARCHAR(10) NOT NULL,
    Telephone VARCHAR(15),
    Age INT,
    Doctor_id INT NOT NULL,
    FOREIGN KEY (Doctor_id) REFERENCES Doctor(Employee_No)
);

-- create table patient_allergy
CREATE TABLE Patient_Allergy (
     Patient_id INT PRIMARY KEY NOT NULL,
     Allergy VARCHAR(100),
     FOREIGN KEY (Patient_id) REFERENCES Patient (Patient_id)
);

-- create table location
CREATE TABLE Location (
    LocationID VARCHAR(10) PRIMARY KEY NOT NULL,
    RoomNo INT NOT NULL,
    NursingUnit VARCHAR(50),
    BedNo INT NOT NULL,
    Patient_id INT NOT NULL,
    FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id)
);

-- drop patient_id column from location table
ALTER TABLE Location
DROP FOREIGN KEY location_ibfk_1;

ALTER TABLE Location
DROP COLUMN Patient_id;

-- add locationid to the Patient table
ALTER TABLE Patient
ADD LocationID VARCHAR(10),
ADD FOREIGN KEY (LocationID) REFERENCES Location(LocationID);

-- create table medication
CREATE TABLE Medication (
    Code INT PRIMARY KEY NOT NULL,
    Name VARCHAR(60) NOT NULL,
    Quantity_of_Hand INT,
    Quantity_Ordered INT,
    Exp_date DATE,
    Cost DECIMAL(10, 2)
);

-- create table patient_medication
CREATE TABLE Patient_Medication (
    Patient_id INT NOT NULL,
    MedicationCode INT NOT NULL,
    Interaction_Severity VARCHAR(50),
    Interact_Medi_Code INT,
    FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id),
    FOREIGN KEY (MedicationCode) REFERENCES Medication(Code),
    FOREIGN KEY (Interact_Medi_Code) REFERENCES Medication(Code)
);

-- create table surgery
CREATE TABLE Surgery (
    SurgeryName VARCHAR(60) NOT NULL,
    PatientID INT NOT NULL,
    Date DATE NOT NULL,
    Time TIME NOT NULL,
    Category VARCHAR(50),
    SpecialNeeds VARCHAR(255),
    TheaterNo INT NOT NULL,
    Nurse_id INT NOT NULL,
    Surgeon_id INT NOT NULL,
    PRIMARY KEY (SurgeryName, PatientID),
    FOREIGN KEY (PatientID) REFERENCES Patient(Patient_id),
    FOREIGN KEY (Nurse_id) REFERENCES Nurse(Employee_No),
    FOREIGN KEY (Surgeon_id) REFERENCES Surgeon(Employee_No)
);

-- View tables
SHOW TABLES;

-- insert data into staff table
INSERT INTO Staff (Employee_No, Gender, Name, Address, Telephone) VALUES
    (101, 'Male', 'Saman Perera', '23 Galle Road, Colombo', '011-1234567'),
    (102, 'Female', 'Nalini Fernando', '45 Kandy Road, Kandy', '081-9876543'),
    (103, 'Male', 'Priyantha Silva', '12 Negombo Road, Negombo', '031-5556667'),
    (104, 'Female', 'Mala Rajapaksa', '78 Matara Street, Matara', '041-7778889'),
    (105, 'Male', 'Roshan Gunawardena', '9 Jaffna Road, Jaffna', '021-2223334'),
    (106, 'Male', 'Kamal Peris', '56 Anuradhapura Road, Anuradhapura', '025-1234567'),
    (107, 'Female', 'Sujatha Kumari', '34 Gampaha Road, Gampaha', '033-9876543'),
    (108, 'Male', 'Chandana Fernando', '67 Badulla Street, Badulla', '055-5556667');
    
-- insert data into the Doctor table
INSERT INTO Doctor (Employee_No, Salary, Specialty, HDnumber) VALUES
    (101, 75000.00, 'Cardiology', null),
    (105, 80000.00, 'Orthopedics', 1010),
    (107, 70000.00, 'Pediatrics', null);

-- insert data into the Surgeon table
INSERT INTO Surgeon (Employee_No, Contract_Type, Contract_Length, Specialty) VALUES
    (103, 'Fixed Term', 24, 'Cardiac Surgery'),
    (106, 'Consultancy', 12, 'Neurological Surgery'),
    (108, 'Fixed Term', 18, 'Orthopedic Surgery');

-- insert data into the Nurse table    
INSERT INTO Nurse (Employee_No, Salary, YearsOfExperience, Skill_type, Grade) VALUES
    (102, 50000.00, 5, 'Surgical', 'Senior'),
    (104, 45000.00, 3, 'Pediatric', 'Junior');

-- insert data into the Patient table
INSERT INTO Patient (Patient_id, Initials, Surname, Blood_type, Telephone, Age, Doctor_id) VALUES
    (1001, 'M. A.', 'Silva', 'O+', '077-1234567', 35, 101),
    (1002, 'N. S.', 'Fernando', 'A-', '071-9876543', 42, 105),
    (1003, 'S. T.', 'Perera', 'B+', '076-5556667', 28, 107),
    (1004, 'A. B.', 'Rajapaksa', 'AB-', '070-7778889', 50, 101),
    (1005, 'K. R.', 'Gunaratne', 'O-', '078-2223334', 22, 105),
    (1006, 'P. K.', 'Samaraweera', 'A+', '075-8889999', 39, 101),
    (1007, 'R. W.', 'Fernandez', 'B-', '072-4445555', 31, 101),
    (1008, 'S. M.', 'Jayawardena', 'AB+', '079-6667777', 45, 107),
    (1009, 'D. N.', 'Wickramasinghe', 'O+', '074-1112222', 29, 105),
    (1010, 'B. G.', 'Peris', 'A-', '073-3334444', 37, 107);
    
INSERT INTO Patient_Allergy (Patient_id, Allergy) VALUES
    (1001, 'Peanuts'),
    (1002, 'Penicillin'),
    (1003, 'Dust'),
    (1004, 'Seafood'),
    (1005, 'Latex'),
    (1006, 'Pollen'),
    (1007, 'Eggs'),
    (1008, 'Mold'),
    (1009, 'Nuts'),
    (1010, 'Soy');
    
INSERT INTO Location (LocationID, RoomNo, NursingUnit, BedNo) VALUES
    ('L1', 1001, 'Cardiology', 3),
    ('L2', 2001, 'Pediatrics', 5),
    ('L3', 3001, 'Orthopedics', 2);
    
SELECT * FROM Location;

UPDATE Patient SET LocationID = 'L1' WHERE Patient_id = 1001;
UPDATE Patient SET LocationID = 'L1' WHERE Patient_id = 1004;
UPDATE Patient SET LocationID = 'L1' WHERE Patient_id = 1006;
UPDATE Patient SET LocationID = 'L1' WHERE Patient_id = 1007;
UPDATE Patient SET LocationID = 'L2' WHERE Patient_id = (1002);
UPDATE Patient SET LocationID = 'L2' WHERE Patient_id = (1005);   
UPDATE Patient SET LocationID = 'L2' WHERE Patient_id = (1009);
UPDATE Patient SET LocationID = 'L3' WHERE Patient_id = (1003);
UPDATE Patient SET LocationID = 'L3' WHERE Patient_id = (1008);
UPDATE Patient SET LocationID = 'L3' WHERE Patient_id = (1010);


INSERT INTO Medication (Code, Name, Quantity_of_Hand, Quantity_Ordered, Exp_date, Cost) VALUES
    (001, 'Aspirin', 50, 20, '2023-12-31', 5.99),
    (002, 'Paracetamol', 100, 30, '2023-11-30', 3.49),
    (003, 'Amoxicillin', 30, 10, '2024-05-15', 8.25),
    (004, 'Lisinopril', 40, 15, '2023-09-30', 12.50),
    (005, 'Atorvastatin', 25, 8, '2023-10-20', 18.75),
    (006, 'Ibuprofen', 75, 25, '2023-11-15', 4.75),
    (007, 'Metformin', 60, 18, '2024-02-28', 6.90),
    (008, 'Omeprazole', 55, 12, '2023-10-10', 7.25),
    (009, 'Simvastatin', 35, 10, '2024-03-25', 9.50),
    (0010, 'Ciprofloxacin', 40, 15, '2024-06-10', 11.30);
    
INSERT INTO Patient_Medication (Patient_id, MedicationCode, Interaction_Severity, Interact_Medi_Code) VALUES
	(1001, 001, 'Moderate', 002),
    (1002, 004, 'High', 005),
    (1003, 003, 'Low', NULL),
    (1004, 005, 'Moderate', 006),
    (1005, 006, 'High', 007),
    (1006, 007, 'Low', NULL),
    (1007, 008, 'Moderate', 009),
    (1008, 0010, 'Low', NULL),
    (1009, 001, 'High', NULL),
    (1010, 002, 'Low', 003);
    
    
INSERT INTO Surgery (SurgeryName, PatientID, Date, Time, Category, SpecialNeeds, TheaterNo, Nurse_id, Surgeon_id) VALUES
    ('Appendectomy', 1001, '2023-07-10', '10:00:00', 'General', 'No special needs', 1, 102, 103),
    ('Brain Tumor Removal', 1002, '2023-08-15', '11:30:00', 'Neurological', 'Requires precision instruments', 2, 104, 106),
    ('Knee Arthroscopy', 1003, '2023-09-20', '09:45:00', 'Orthopedic', 'No special needs', 1, 102, 108),
    ('Cataract Surgery', 1004, '2023-10-10', '08:15:00', 'Ophthalmology', 'Requires specialized tools', 3, 104, 103),
    ('Heart Bypass', 1005, '2023-11-25', '13:30:00', 'Cardiac', 'Highly complex surgery', 4, 102, 108),
    ('Hip Replacement', 1006, '2024-01-15', '14:00:00', 'Orthopedic', 'Requires specialized tools', 2, 102, 106),
    ('Appendectomy', 1007, '2024-02-20', '09:30:00', 'General', 'No special needs', 1, 102, 103),
    ('Laser Eye Surgery', 1008, '2024-04-05', '11:15:00', 'Ophthalmology', 'Requires precision instruments', 3, 104, 106),
    ('Gallbladder Removal', 1009, '2024-05-15', '10:30:00', 'General', 'No special needs', 1, 102, 103),
    ('Knee Replacement', 1010, '2024-06-10', '12:00:00', 'Orthopedic', 'Requires specialized tools', 2, 104, 108);
    
SELECT * FROM Staff;

SELECT * FROM Doctor;

SELECT * FROM Surgeon;
    
SELECT * FROM Nurse;

SELECT * FROM Patient;

SELECT * FROM Patient_Allergy;

SELECT * FROM Location;

SELECT * FROM Medication;

SELECT * FROM Patient_Medication;

SELECT * FROM Surgery;

-- drop locationId Column from Patient Table
ALTER TABLE Patient
DROP FOREIGN KEY patient_ibfk_2;

ALTER TABLE Patient
DROP COLUMN LocationID;

-- Drop Location Table
DROP TABLE Location;

-- Create updated location table
CREATE TABLE Location (
    RoomNo VARCHAR (10) NOT NULL,
	BedNo VARCHAR (10) NOT NULL,
    NursingUnit VARCHAR(50),
    Patient_id INT NOT NULL,
    PRIMARY KEY (BedNo),
    FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id)
);

-- Insert data into the Location Table
INSERT INTO Location (RoomNo, BedNo, NursingUnit, Patient_id) VALUES
	('R101', 'B101', 'Cardiology', 1001),
    ('R102', 'B102', 'Pediatrics', 1002),
    ('R103', 'B103', 'Orthopedics', 1003),
    ('R104', 'B104', 'Cardiology', 1004),
    ('R105', 'B105', 'Pediatrics', 1005),
    ('R201', 'B201', 'Cardiology', 1006),
    ('R202', 'B202', 'Cardiology', 1007),
    ('R203', 'B203', 'Orthopedics', 1008),
    ('R204', 'B204', 'Pediatrics', 1009),
    ('R205', 'B205', 'Orthopedics', 1010);
    
SELECT * FROM Location;

-- Mini Project Q1 
CREATE VIEW Patient_Record AS
SELECT P.Patient_id AS PID, 
CONCAT(P.Initials,' ', P.Surname) AS PName, 
CONCAT(L.RoomNo, '-', L.BedNo) AS Location,
S.SurgeryName,
S.Date AS SurgeryDate
FROM Patient AS P
JOIN Location L ON P.Patient_id = L.Patient_id 
JOIN Surgery S ON P.Patient_id = S.PatientID;

SELECT * FROM Patient_Record;

-- Mini Project Q2

-- create table MedInfo
CREATE TABLE MedInfo (
    MedName VARCHAR(60) PRIMARY KEY,
    QuantityAvailable INT,
    ExpirationDate DATE NOT NULL
);

-- Q2.(i) - 421421850
-- Triggers for loading MedInfo from Medication
DELIMITER //
 CREATE TRIGGER `MedInfoInsert` AFTER INSERT ON `Medication` FOR EACH ROW BEGIN
    INSERT INTO MedInfo (MedName, QuantityAvailable, ExpirationDate)
        VALUES (new.Name, new.Quantity_of_Hand, new.Exp_date);
  END;
//
DELIMITER ;

-- <Q2 (ii) - 421421850>
-- Trigger to update the values
DELIMITER //
CREATE TRIGGER `MedInfoUpdate` AFTER UPDATE ON `Medication` FOR EACH ROW BEGIN
        UPDATE MedInfo
            SET QuantityAvailable=new.Quantity_of_Hand,
                ExpirationDate = new.Exp_date
        WHERE MedName = new.Name;
   END;
//
DELIMITER ;

-- <Q2 (iii) - 421421850>
-- Trigger to delete values
DELIMITER //
CREATE TRIGGER `MedInfoDelete` AFTER DELETE ON `Medication` FOR EACH ROW BEGIN
    DELETE FROM MedInfo WHERE MedName = old.Name;
  END;
  //
  DELIMITER ;
  
  -- Run select query on MedInfo - displays no values 
SELECT * FROM MedInfo;

-- insert new values to the Medication Table
INSERT INTO Medication VALUES
	(0011, 'Propranolol', 30, 10, '2024-01-31', 7.99),
    (0012, 'Albuterol', 40, 15, '2023-11-15', 5.49),
    (0013, 'Cephalexin', 25, 8, '2023-12-10', 6.25),
    (0014, 'Prednisone', 60, 18, '2024-03-25', 9.90),
    (0015, 'Levothyroxine', 55, 12, '2024-02-28', 8.25);

-- After inserting values newly inserted values will be there in the MedInfo
SELECT * FROM MedInfo;

-- update values in Medication table
UPDATE Medication SET Quantity_of_Hand = '25'
WHERE Code = '0011';

-- After updating the QuantityAvailable
SELECT * FROM MedInfo;

-- delete values in Medication table
DELETE FROM Medication WHERE Code = '0011';

-- After deleting 
SELECT * FROM MedInfo;

-- <Q3 - 421421850>
-- insert more data to the Patient_Medication table
INSERT INTO Patient_Medication VALUES
    (1001, 1, 'Low', 2),
    (1001, 3, 'Moderate', 4),
    (1002, 2, 'High', 1),
    (1002, 4, 'Low', 5),
    (1003, 5, 'Moderate', 2),
    (1004, 1, 'High', 3),
    (1004, 2, 'Low', 4);

SELECT * FROM Patient_Medication;

-- Procedure to get the Medication Count
DELIMITER //
CREATE PROCEDURE sp_GetMedicationCount(
    IN PatientID INT,
    INOUT MedicationCount INT
)
BEGIN
    -- count medications for the specified patient
    SELECT COUNT(*) INTO MedicationCount
    FROM Patient_Medication
    WHERE Patient_id = PatientID;
END;
//
DELIMITER ;

-- Declare variables
SET @patientID = 1001; 
SET @medicationCount = 0;

-- Call the stored procedure and pass the variables
CALL sp_GetMedicationCount(@patientID, @medicationCount);

-- Access the result stored in the session variable
SELECT @medicationCount AS MedicationCount;

-- <Q4 - 421421850>
-- update some dates to get results
UPDATE Medication
SET Exp_date = '2023-09-13'
WHERE Code = 008;

UPDATE Medication
SET Exp_date = '2023-09-08'
WHERE Code = 002;

UPDATE Medication
SET Exp_date = '2023-09-25'
WHERE Code = 0013;

-- function to calculate days remaining to exp
DELIMITER //
CREATE FUNCTION Func_CalculateDays (Expiration DATE)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE TodayDate DATE;
	DECLARE RemainingDays INT;
    
    SELECT CURRENT_DATE() INTO TodayDate;
    -- Calculate the difference in days between the current date and the expiration date
    SET RemainingDays = DATEDIFF(Expiration, TodayDate);
    
    RETURN RemainingDays;
END;
//
DELIMITER ;

-- Function Calls
SELECT
    Code, Name, Quantity_of_Hand, Quantity_Ordered, Exp_date, Cost,
    Func_CalculateDays(Exp_date) AS DaysRemaining
FROM
    Medication
WHERE
    Func_CalculateDays(Exp_date) < 30;

-- <Q5 - 421421850> 
-- load data to Staff table
LOAD XML LOCAL INFILE "C:/Users/Administrator/Desktop/421421850_Mini Project/Staff.xml"
INTO TABLE Suwapiyasa.Staff
ROWS IDENTIFIED BY '<EMPLOYEE>';

-- after load xml data
SELECT * FROM Staff;

-- load data to Patient table
LOAD XML LOCAL INFILE "C:/Users/Administrator/Desktop/421421850_Mini Project/Patient.xml"
INTO TABLE Suwapiyasa.Patient
ROWS IDENTIFIED BY '<PATIENT>';

-- after loaded xml data
SELECT * FROM Patient;



