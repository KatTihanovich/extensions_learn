--To install an extension
CREATE EXTENSION pg_stat_statements;
CREATE EXTENSION pgcrypto;

--Listing Installed Extensions:
SELECT * FROM pg_extension;

--Create a new table called "employees
CREATE TABLE employees (
   id serial PRIMARY KEY,
   first_name VARCHAR(255),
   last_name VARCHAR(255),
   email VARCHAR(255),
   encrypted_password TEXT
);

--Insert sample employee data into the table. 
INSERT INTO employees (first_name, last_name, email, encrypted_password) VALUES
   ('Alex', 'Smith', 'alexsmith@student.edu.pl', crypt('456456', gen_salt('bf'))),
   ('Fren', 'Pinno', 'fpynno@mail.ru', crypt('llllk', gen_salt('bf'))),
   ('Darius', 'Keir', 'dar.keir@gmail.com', crypt('bdkvskjd', gen_salt('bf'))),
   ('Katsiaryna', 'Tsikhanovich', 'katerinatihanovich@gmail.com', crypt('Kattt', gen_salt('bf')));
   

--Select all employees:  
SELECT * FROM employees;

--Update an employee's personal information, such as their last name
UPDATE employees SET last_name = 'Pynno' WHERE email = 'fpinno@mail.ru';

SELECT * FROM employees;

-- Delete an employee record using the email column
DELETE FROM employees WHERE email = 'dar.keir@gmail.com';

SELECT * FROM employees;

--Configure the pg_stat_statements extension
ALTER SYSTEM SET shared_preload_libraries TO 'pg_stat_statements';
ALTER SYSTEM SET pg_stat_statements.track TO 'all';

--Run the following query to gather statistics for the executed statements:
SELECT * FROM pg_stat_statements;

--- Analyze the output of the pg_stat_statements view (self-check)

--Identify the most frequently executed queries
SELECT query, calls 
FROM pg_stat_statements
ORDER BY calls DESC;

-- Determine which queries have the highest average and total runtime
SELECT query, total_plan_time as total_time , total_plan_time /calls AS avg_time
FROM pg_stat_statements
ORDER BY avg_time, total_time DESC;