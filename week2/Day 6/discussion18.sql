-- 1
CREATE TABLE countries (
country_id VARCHAR(10) PRIMARY KEY,
country_name VARCHAR(40),
region_id VARCHAR(10) NOT NULL,
-- CONSTRAINT pk_countries PRIMARY KEY (country_id, region_id)
UNIQUE (country_id, region_id)
);

-- 2
CREATE TABLE jobs (
job_id VARCHAR(10) PRIMARY KEY,
job_title VARCHAR(35) DEFAULT '',
min_salary DECIMAL(6, 0) DEFAULT 150000,
max_salary DECIMAL(6, 0)
);

-- 3
CREATE TABLE job_history (
employee_id INT,
start_date DATE,
end_date DATE,
job_id VARCHAR(15) NOT NULL,
department_id VARCHAR(15) NOT NULL,
CONSTRAINT pk_job_history PRIMARY KEY (employee_id, start_date),
CONSTRAINT fk_job_history FOREIGN KEY (job_id) REFERENCES jobs(job_id),
CONSTRAINT chk_dates CHECK (start_date < end_date)
);

-- 4
CREATE TABLE departments (
department_id VARCHAR(10) NOT NULL PRIMARY KEY,
department_name VARCHAR(30) NOT NULL,
manager_id int Ngit fetch origin
OT NULL,
location_id VARCHAR(10)
);

CREATE TABLE employees (
employee_id INT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
email VARCHAR(100),
phone_number VARCHAR(20),
hire_date DATE,
job_id VARCHAR(15),
salary DECIMAL(10, 2),
commission DECIMAL(10, 2),
manager_id INT,
department_id VARCHAR(10),
CONSTRAINT uk_email UNIQUE (email),
CONSTRAINT fk_job_id FOREIGN KEY (job_id) REFERENCES jobs(job_id)
);

ALTER TABLE departments
ADD CONSTRAINT fk_mgr_id FOREIGN KEY (manager_id) REFERENCES employees(employee_id);

ALTER TABLE employees
ADD CONSTRAINT fk_manager_department FOREIGN KEY (manager_id, department_id) REFERENCES departments(manager_id, department_id);

-- 5
CREATE TABLE employees (
employee_id INT NOT NULL PRIMARY KEY,
first_name VARCHAR(50)NOT NULL,
last_name VARCHAR(50),
email VARCHAR(100) NOT NULL UNIQUE,
phone_number VARCHAR(20),
hire_date DATE,
job_id VARCHAR(10) REFERENCES jobs(job_id),
salary DECIMAL(10, 2),
commission DECIMAL(10, 2),
manager_id INT,
department_id VARCHAR(10),
CONSTRAINT fk_manager_department FOREIGN KEY (manager_id, department_id) REFERENCES departments(manager_id, department_id)
) ENGINE=InnoDB;

-- 6
CREATE TABLE employees (
employee_id INT NOT NULL PRIMARY KEY,
first_name VARCHAR(50)NOT NULL,
last_name VARCHAR(50),
job_id VARCHAR(10) REFERENCES jobs(job_id) ON DELETE CASCADE ON UPDATE RESTRICT,
salary DECIMAL(10, 2)
) ENGINE=InnoDB;

-- 7
CREATE TABLE employees (
employee_id INT NOT NULL PRIMARY KEY,
first_name VARCHAR(50)NOT NULL,
last_name VARCHAR(50),
job_id VARCHAR(10) REFERENCES jobs(job_id) ON DELETE SET NULL ON UPDATE SET NULL,
salary DECIMAL(10, 2)
) ENGINE=InnoDB;

-- 8
CREATE TABLE employees (
employee_id INT NOT NULL PRIMARY KEY,
first_name VARCHAR(50)NOT NULL,
last_name VARCHAR(50),
job_id VARCHAR(10) REFERENCES jobs(job_id)ON DELETE NO ACTION ON UPDATE NO ACTION,
salary DECIMAL(10, 2)
) ENGINE=InnoDB;