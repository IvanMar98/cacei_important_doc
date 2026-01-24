-- Trigger para validar cuando una conferencia es virtual y de ser vitual seteara el campo is_virtual como true o false

DELIMITER $$

	create trigger trg_conference_insert_is_virtual
	before insert on conferences
	for each row 
	begin
		declare modality_name varchar(100);
		select name 
		into modality_name
		from modality_types
		where id = new.modality_id;
		
		if modality_name = 'virtual' then
			set new.is_virtual = true;
		else 
			set new.is_virtual = false;
		end if;
	end
$$

DROP TRIGGER IF EXISTS trg_conference_update_is_virtual;

DELIMITER $$

	create trigger trg_conference_update_is_virtual
	before update on conferences
	for each row 
	begin
		declare modality_name varchar(100);
		select name 
		into modality_name
		from modality_types
		where id = new.modality_id;
		
		if modality_name = 'virtual' then
			set new.is_virtual = true;
		else 
			set new.is_virtual = false;
		end if;
	end
$$


-- Trigger para validar si una tesis tiene estatus completed

delimiter $$
	create trigger trg_thesis_insert_is_completed
    before insert on theses
    for each row
    begin
		declare status_name varchar(100);
		select name into status_name from thesis_statuses
		where id = new.thesis_status_id;
        if status_name = 'completed' then 
			if new.defense_date is null then 
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Error: defense date is required when thesis is completed';
            end if;
			if new.defense_date > current_date() then
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Error: Invalid defense date';
			end if;
            if new.defense_date <= new.start_date then
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Error: Invalid defense date, it must be greater than to start_date';
            end if;
		end if;
    end
$$

delimiter $$
	create trigger trg_thesis_update_is_completed
    before update on theses
    for each row
    begin
		declare status_name varchar(100);
		select name into status_name from thesis_statuses
		where id = new.thesis_status_id;
        if status_name = 'completed' then 
			if new.defense_date is null then 
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Error: defense date is required when thesis is completed';
            end if;
			if new.defense_date > current_date() then
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Error: Invalid defense date';
			end if;
            if new.defense_date <= new.start_date then
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Error: Invalid defense date, it must be greater than to start_date';
            end if;
		end if;
    end
$$

DROP TRIGGER IF EXISTS trg_thesis_update_is_completed;

-- Trigger para validar el estatus de un proyecto y si es completed validar end_date
delimiter $$

	create trigger trg_project_ins_validate_status
	before insert on projects
	for each row
	begin
		declare status_name varchar(100);
        select name into status_name from project_statuses
        where id = new.project_status_id;
        if status_name = 'completed' then
			if new.end_date is null then
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Error: end date is required when project is completed';
            end if;
            if new.end_date <= new.start_date then
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Error: Invalid end date, it must be greater than to start_date';
            end if;
            if new.end_date > current_date() then
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Error: Invalid end date';
			end if;
        end if;
	end
$$

delimiter $$

	create trigger trg_project_upd_validate_status
	before update on projects
	for each row
	begin
		declare status_name varchar(100);
        select name into status_name from project_statuses
        where id = new.project_status_id;
        if status_name = 'completed' then
			if new.end_date is null then
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Error: end date is required when project is completed';
            end if;
            if new.end_date <= new.start_date then
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Error: Invalid end date, it must be greater than to start_date';
            end if;
            if new.end_date > current_date() then
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Error: Invalid end date';
			end if;
        end if;
	end
$$
