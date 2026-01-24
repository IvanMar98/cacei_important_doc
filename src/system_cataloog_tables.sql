-- Create new data base

	CREATE DATABASE IF NOT EXISTS caceiv3;
	use caceiv3;

-- Create catalog tables

-- Fundind Sources
	create table if not exists funding_sources (
	  id int not null auto_increment,
	  name varchar(100) not null,
	  primary key (id)
	);
	alter table funding_sources
	add constraint nn_name unique (name);

	-- Eliminar constraint unique
	alter table funding_sources
	drop INDEX nn_name;

	-- Agregar una nueva contraint unique
	alter table funding_sources
	add constraint uq_funding_source_name unique (name);
    
    -- Agregar columna description 
    
    alter table funding_sources
    add column description varchar(255) not null;

	show create table funding_sources;

-- project_statuses
	create table if not exists project_statuses (
		id int not null auto_increment,
		name varchar(100) not null,
		primary key(id),
		constraint uq_project_statuse_name unique(name)
	);
    
-- Institutions Origins
	create table if not exists institutions_origin (
		id int not null auto_increment,
		name varchar(100),
		primary key (id)
	);
	alter table institutions_origin
	add constraint nn_name unique (name);

	-- Eliminar constraint unique
	alter table institutions_origin
	drop INDEX nn_name;

	-- Agregar una nueva contraint unique y not null
	alter table institutions_origin
	modify name varchar(100) not null,
	add constraint uq_institution_origin_name unique (name);
    
    -- Agregar columna description 
    alter table institutions_origin
    add column description varchar(100);
	
    alter table institutions_origin
    modify description varchar(100) not null;
    

	show create table institutions_origin;

-- Research Lines
	create table if not exists research_lines (
		id int not null auto_increment,
		name varchar(100),
		parent_id int null,
		primary key (id),
		constraint fk_research_lines_parent
			foreign key (parent_id) references research_lines(id)
			on delete set null
			on update cascade
	);
	alter table research_lines
	add constraint nn_name unique (name);
    
	-- Eliminar constraint unique
	alter table research_lines
	drop INDEX nn_name;

	-- Agregar una nueva contraint unique y not null
	alter table research_lines
	modify name varchar(100) not null,
	add constraint uq_research_line_name unique (name);
		
	show create table research_lines;

-- Academic Bodies
	create table if not exists academic_bodies (
		id int not null auto_increment,
		name varchar(100),
		primary key (id)
	);
	alter table academic_bodies
	add constraint nn_name unique (name);
    
    -- Eliminar constraint unique
	alter table academic_bodies
	drop INDEX nn_name;

	-- Agregar una nueva contraint unique y not null
	alter table academic_bodies
	modify name varchar(100) not null,
	add constraint uq_academic_body_name unique (name);

	show create table academic_bodies;

-- Project Types
	create table if not exists project_types (
		id int not null auto_increment,
		name varchar(100),
		primary key(id)
	);
	alter table project_types
	add constraint nn_name unique (name);
	
    -- Eliminar constraint unique
	alter table project_types
	drop INDEX nn_name;

	-- Agregar una nueva contraint unique y not null
	alter table project_types
	modify name varchar(100) not null,
	add constraint uq_project_type_name unique (name);
    
	show create table project_types;

-- Roles
	create table if not exists roles (
		id int not null auto_increment,
		name varchar(100),
		primary key(id)
	);
	alter table roles
	add constraint uc_role unique (name);

	-- Eliminar constraint unique
	alter table roles
	drop INDEX uc_role;

	-- Agregar una nueva contraint unique y not null
	alter table roles
	modify name varchar(100) not null,
	add constraint uq_role_name unique (name);
    
	show create table roles;
    
-- Countries
	create table if not exists countries (
		id int not null auto_increment,
		name varchar(100),
		primary key(id)
	);
	alter table countries
	add constraint uc_role unique (name);
    
    -- Eliminar constraint unique
	alter table countries
	drop INDEX uc_role;

	-- Agregar una nueva contraint unique y not null
	alter table countries
	modify name varchar(100) not null,
	add constraint uq_country_name unique (name);

	show create table countries;

-- Publication Types
	create table if not exists publication_types (
		id int not null auto_increment,
		name varchar(100),
		primary key(id)
	);
	alter table publication_types
	add constraint uc_role unique (name);
    
    -- Eliminar constraint unique
	alter table publication_types
	drop INDEX uc_role;

	-- Agregar una nueva contraint unique y not null
	alter table publication_types
	modify name varchar(100) not null,
	add constraint uq_publication_type_name unique (name);

	show create table publication_types;

-- Presentation Types
	create table if not exists presentation_types (
		id int not null auto_increment,
		name varchar(100) not null,
		primary key(id)
	);
    
	-- Agregar nueva contraint unique
	alter table journals
	add constraint uq_presentation_type_name unique (name);
	
	show create table presentation_types;
    
-- Books
	create table if not exists books (
		id int not null auto_increment,
		name varchar(200) not null,
		editorial varchar(100) not null,
		publication_year year not null,
		isbn varchar(17) not null,
		primary key(id),
		constraint uq_book_isbn unique(isbn)
	);

-- Conference Types
	create table if not exists conference_types (
		id int not null auto_increment,
        name varchar(100) not null,
        primary key(id),
        constraint uq_conference_type_name unique(name)
    );

	show create table conference_types;
    
-- Modality Types
	create table if not exists modality_types (
		id int not null auto_increment,
        name varchar(100) not null,
        primary key(id),
        constraint uq_modality_type_name unique(name)
    );
    
	show create table modality_types;
    
-- Speaker Roles
    create table if not exists speaker_roles (
		id int not null auto_increment,
        name varchar(100) not null,
        primary key(id),
        constraint uq_speaker_role_name unique(name)
    );
    
-- Course Types
    create table if not exists course_types (
		id int not null auto_increment,
        name varchar(100) not null,
        primary key(id),
        constraint uq_scourse_types_name unique(name)
    );
    
    -- Eliminar constraint unique
	alter table course_types
	drop INDEX uq_scourse_types_name;
    
    -- Agregar nueva contraint unique
    alter table course_types
	add constraint uq_course_type_name unique (name);
    
    show create table course_types;

-- Course Roles
    create table if not exists course_roles (
		id int not null auto_increment,
        name varchar(100) not null,
        primary key(id),
        constraint uq_course_role_name unique(name)
    );
    
    show create table course_roles;
    
-- Thesis Statuses
	create table if not exists thesis_statuses (
		id int not null auto_increment,
        name varchar(100) not null,
        primary key(id),
        constraint uq_thesis_statuse_name unique(name)
    );
    
    show create table thesis_statuses;
    
-- Academic Levels
	create table if not exists academic_levels (
		id int not null auto_increment,
        name varchar(100) not null,
        primary key(id),
        constraint uq_academic_level_name unique(name)
    );
    
    show create table academic_levels;
    
-- Thesis Roles
	create table if not exists thesis_roles (
		id int not null auto_increment,
        name varchar(100) not null,
        primary key(id),
        constraint uq_theis_role_name unique(name)
    );
    
    show create table thesis_roles;
