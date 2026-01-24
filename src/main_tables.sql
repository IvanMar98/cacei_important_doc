use caceiv3;
-- Create main tables

-- Projects
	create table if not exists projects (
		id int not null auto_increment,
		name varchar(150) not null,
		start_date date not null,
		end_date date null,
		status enum('in_progress', 'completed', 'cancelled') not null,
		is_financing boolean not null,
		funding_amount decimal(12, 2) null,
		institution_origin_id int null,
		research_line_id int null,
		project_type_id int null,
		funding_source_id int null,
		academic_body_id int null,
		primary key(id),
		constraint fk_projects_institutions_origin
			foreign key(institution_origin_id)
			references institutions_origin(id),
		constraint fk_projects_research_lines
			foreign key(research_line_id) 
			references research_lines(id),
		constraint fk_projects_project_types
			foreign key(project_type_id)
			references project_types(id),
		constraint fk_projects_funding_sources
			foreign key(funding_source_id) 
			references funding_sources(id),
		constraint fk_projects_academic_bodies
			foreign key(academic_body_id) 
			references academic_bodies(id),
		-- Si se agrega una fecha de termino esta no debe ser menor a la fecha de inicio
		constraint chk_project_dates
			check (
				end_date is null
				or end_date >= start_date
			),
		-- El campo en_date solo es obligatorio cuando el proyecto NO esta en progreso. 
        -- NOTA: ESTA CONSTRAINT YA NO APLICA YA QUE EL STATUS YA NO VIVE EN LA TABLA projects, se creara un trigger, revisar archivo "triggers".
		constraint chk_project_end_date_required
			check (
				status = 'in_progress'
				or end_date is not null
			),
		-- Si el proyecto no es financiado, is_financing = false, no se requiere funding amount ni tampoco una fuente de financiamiento
		constraint chk_project_financing
			check (
				is_financing = false
				or (
					funding_amount is not null
					and funding_amount > 0
					and funding_source_id is not null
				)
			)
	);
    
	-- Modificar campo status ya que ahora sera una foreign key 
    
		-- Primero eliminar constraint chk_project_end_date_required
		alter table projects
		drop check chk_project_end_date_required;
		
		-- cambiar la columna status por project_status_id
		alter table projects
		change column status project_status_id int;
        
        -- crear contrat fk con tabla project_statuses
        alter table projects
        add constraint fk_projects_projects_statutes
        foreign key(project_status_id) references project_statuses(id);
        
        
    
	show create table projects;
    
-- Users
	create table if not exists users (
		id int not null auto_increment,
		name varchar(100) not null,
		first_last_name varchar(100) not null,
		second_last_name varchar(100) not null,
		birthdate date null,
		curp varchar(18) null,
		rfc varchar(13) null,
		email varchar(80) not null,
		password varchar(255) null,
		gender enum('FEMALE', 'MALE') null,
		country_birth_id int null,
		image_profile varchar(255) null,
		biografy varchar(500) null,
		is_external boolean not null default false,
		primary key(id),
		constraint fk_users_countries
			foreign key(country_birth_id)
			references countries(id),
		constraint uq_user_email unique(email),
		constraint uq_user_curp unique(curp),
		constraint uq_user_rfc unique(rfc),
		
		-- Si el usuario no es externo, is_external = false, debe tener obligacion completa
		constraint chk_user_internal_required_fields
			check (
				is_external = true
				or  (
					birthdate is not null
					and curp is not null
					and rfc is not null
					and password is not null
					and gender is not null
					and country_birth_id is not null
				)
			)
	);

-- Journals
	CREATE TABLE IF NOT EXISTS journals (
		id INT NOT NULL AUTO_INCREMENT,
		name VARCHAR(100) NOT NULL,
		issn VARCHAR(10) NULL,
		isbn VARCHAR(17) NULL,
		latindex VARCHAR(20) NULL,
		journal_number VARCHAR(20) NULL,
		is_indexed BOOLEAN NOT NULL DEFAULT FALSE,
		volume VARCHAR(100),
		PRIMARY KEY (id),
		CONSTRAINT uc_issn UNIQUE (issn)
	);
    
    -- Eliminar constraint unique
	alter table journals
	drop INDEX uc_issn;
    
    -- Agregar nueva contraint unique
    alter table journals
	add constraint uq_issn unique (issn);
    
    show create table journals;

-- Articles
	create table if not exists articles (
		id int not null auto_increment,
		name varchar(100) not null,
		publication_year year not null,
		publication_type_id int not null,
		academic_body_id int not null,
		research_line_id int not null,
		primary key(id),
		constraint fk_articles_publications_types
			foreign key(publication_type_id)
			references publication_types(id),
		constraint fk_articles_academic_bodies
			foreign key(academic_body_id)
			references academic_bodies(id),
		constraint fk_articles_research_lines
			foreign key(research_line_id)
			references research_lines(id)
	);
    
-- Presentations 
	create table if not exists presentations(
		id int not null,
        name varchar(100) not null,
        presentation_date date,
        presentation_type_id int,
        primary key(id),
        constraint fk_presentations_publication_types
        foreign key(presentation_type_id)
        references presentation_types(id)
    );
    
    -- Update data type of presentation_date
    
    alter table presentations
    modify presentation_date date not null;
    
    -- Update id field
    alter table presentations
    modify id int not null auto_increment;
    
-- Conferences
	create table if not exists conferences(
		id int not null,
        name varchar(100) not null,
        description varchar(255) not null,
        conference_date date not null,
        city varchar(100) not null,
        place varchar(100),
        is_virtual boolean,
        institution_organizer varchar(255) not null,
        conference_type_id int,
        modality_id int,
        country_id int,
        primary key(id),
        constraint fk_conferences_conferences_types
			foreign key(conference_type_id)
			references conference_types(id),
        constraint fk_conferences_modality_types
			foreign key(modality_id)
			references modality_types(id),
		constraint fk_conferences_countries
			foreign key(country_id)
            references countries(id),
		-- Si la presentation es en modalidad virtual el place puede ser null
		constraint chk_conference_place_required
			check (
				is_virtual = true
				or place is not null
			)
    );
		-- Update id field
		alter table conferences
		modify id int not null auto_increment;
    
-- Courses
	create table if not exists courses(
		id int not null auto_increment,
		name varchar(100) not null, 
		hours_curricular_value int not null,
		course_type_id int,
		institution_organizer varchar(255),
		primary key(id),
		constraint fk_courses_courses_type
			foreign key(course_type_id)
			references course_types(id)
			ON DELETE SET NULL
	);

-- Theses
	create table if not exists theses(
		id int not null auto_increment,
        title varchar(255) not null,
        defense_date date,
        is_completed boolean not null default false,
        thesis_status_id int,
        research_line_id int,
        academic_body_id int,
        academic_level_id int,
        primary key(id),
        constraint fk_theses_thesis_statuses
			foreign key(thesis_status_id)
            references thesis_statuses(id)
            on delete set null,
        constraint fk_theses_research_lines
			foreign key(research_line_id)
            references research_lines(id)
            on delete set null,
		constraint fk_theses_academic_bodies
			foreign key(academic_body_id)
            references academic_bodies(id)
            on delete set null,
		constraint fk_theses_academic_levels
			foreign key(academic_level_id)
            references academic_levels(id)
			on delete set null,
		-- Si el estatus de la tesis es completed defense date ni debe ser null y la fecha no debe ser antes al dia del registro
        -- NOTA: Este check ya no es necesario se movio al trigger, revisar archivo triggers
		constraint chk_thesis_status_required
			check (
				is_completed = false
				or  defense_date is not null
			)
    );
    
    -- Agregar campo start_date a tabla theses 
        alter table theses
        add column start_date date not null;
	
    -- Como ya tenemos start_date en la tabla ya podemos manejar la constraint check en el trigger
    -- NOTA: revisar el archivo triggers
		alter table theses
		drop check chk_thesis_status_required;
	-- Elimiar campo is_completed ya no sera necesario
		alter table theses
		drop column is_completed;
    
-- Book chapters
	create table if not exists book_chapters(
		id int not null,
        book_id int not null,
        chapter_name varchar(100) not null,
        start_page varchar(100),
        end_page varchar(100),
        primary key(id),
        constraint fk_book_chapters_book
        foreign key(book_id) references books(id)
        on delete cascade
    );
    
-- Book chapters authors
	create table book_chapter_authors (
		book_chapter_id int not null,
		user_id int not null,
		author_order int not null,
		primary key (book_chapter_id, user_id),
		foreign key (book_chapter_id) references book_chapters(id)
			on delete cascade,
		foreign key (user_id) references users(id)
			on delete cascade,
		constraint uq_chapter_author_order
			unique (book_chapter_id, author_order)
	);
    
    