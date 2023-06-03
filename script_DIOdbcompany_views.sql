-- Número de empregados por departamento e localidade
DROP VIEW IF EXISTS vw_employee_departament;
CREATE VIEW vw_employee_departament
AS
	SELECT e.Dno, d.Dname, l.Dlocation, count(*) Total
	FROM employee e
	INNER JOIN departament d ON d.Dnumber = e.Dno
	INNER JOIN dept_locations l ON l.Dnumber = d.Dnumber
	GROUP BY e.Dno, d.Dname, l.Dlocation
	ORDER BY d.Dname, l.Dlocation;
    
-- Lista de departamentos e seus gerentes 
DROP VIEW IF EXISTS vw_departament_manager;
CREATE VIEW vw_departament_manager
AS
	SELECT d.Dnumber, d.Dname, CONCAT(e.Fname, ' ', e.Lname) Manager
	FROM departament d
	INNER JOIN employee e ON e.Ssn = d.Mgr_ssn
	ORDER BY d.Dname;

-- Projetos com maior número de empregados (ex: por ordenação desc) 
DROP VIEW IF EXISTS vw_works_on_employee;
CREATE VIEW vw_works_on_employee
AS
	SELECT w.Pno, p.Pname, COUNT(w.Essn) Total
	FROM works_on w
	INNER JOIN project p ON p.Pnumber = w.Pno
	GROUP BY w.Pno, p.Pname
    ORDER BY Total DESC;
    
-- Lista de projetos, departamentos e gerentes
DROP VIEW IF EXISTS vw_project_departament;
CREATE VIEW vw_project_departament
AS
	SELECT p.Pnumber, p.Pname, p.Plocation, p.Dnum, d.Dname, d.Mgr_ssn, CONCAT(e.Fname, ' ', e.Lname) Manager
	FROM project p
	INNER JOIN departament d ON d.Dnumber = p.Dnum
	INNER JOIN employee e ON e.Ssn = d.Mgr_ssn
	ORDER BY p.Pname;

-- Quais empregados possuem dependentes e se são gerentes
DROP VIEW IF EXISTS vw_employee_dependent;
CREATE VIEW vw_employee_dependent
AS
	SELECT e.Ssn, CONCAT(e.Fname, ' ', e.Lname) Name, d.dependent_name, d.Relationship
	FROM employee e
	INNER JOIN dependent d ON d.Essn = e.Ssn;