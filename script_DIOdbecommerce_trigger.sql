-- Triggers de remoção: before delete 
-- Usuários podem excluir suas contas por algum motivo. Dessa forma,
-- para não perder as informações sobre estes usuários, crie um gatilho before remove ou
-- para before alteração

DROP TRIGGER IF EXISTS `dbecommerce`.`trg_clients_del_log`;
DELIMITER $$
CREATE TRIGGER trg_clients_del_log
BEFORE DELETE ON clients
FOR EACH ROW
BEGIN
  INSERT INTO clients_log
    (idClient, Fname, Minit, Lname, CPF, Address, action_type, action_datetime, deleted_by)
	VALUES (OLD.idClient, OLD.Fname, OLD.Minit, OLD.Lname, OLD.CPF, OLD.Address, 'delete', NOW(), USER());
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `dbecommerce`.`trg_clients_upd_log`;
DELIMITER $$
CREATE TRIGGER trg_clients_upd_log
BEFORE UPDATE ON clients
FOR EACH ROW
BEGIN
  INSERT INTO clients_log
    (idClient, Fname, Minit, Lname, CPF, Address, action_type, action_datetime, deleted_by)
	VALUES (OLD.idClient, OLD.Fname, OLD.Minit, OLD.Lname, OLD.CPF, OLD.Address, 'update', NOW(), USER());
END$$
DELIMITER ;