-- Usuário gerente terá acesso as informações de employee e departamento
CREATE USER 'manager'@'localhost' IDENTIFIED BY 'manager123.';
GRANT SELECT ON dbcompany.* TO 'manager'@'localhost';
FLUSH PRIVILEGES;

-- Usuário employee não terá acesso as informações relacionadas aos departamentos ou gerentes
CREATE USER 'employee'@'localhost' IDENTIFIED BY 'employee123.';
GRANT SELECT ON dbcompany.vw_works_on_employee TO 'employee'@'localhost';
