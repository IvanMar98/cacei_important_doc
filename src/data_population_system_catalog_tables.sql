use caceiv3;

-- Insertar Roles (roles)
insert into roles(name) values 
('responsable'),
('colaborador'),
('desarrollador'),
('asesor');

select * from roles;

-- Insertar estatusen los que se pueden encontrar las tesis (thesis_statuses)
insert into thesis_statuses(name) values
('in_progress'),
('completed');

select * from thesis_statuses;

-- Insertar estatus en los que se pueden encontrar los proyectos (projects_statuses)
insert into project_statuses(name) values
('in_progress'),
('completed'),
('cancelled');

select * from project_statuses;

-- Insertar niveles academicos que puede tener una tesis (academic_levels)
insert into academic_levels(name) values
('Licenciatura'),
('Maestría'),
('Doctorado');

select * from academic_levels;

-- Insertar fuentes de financiamiento (funding_sources)
insert into funding_sources(name) values
('Consejo Nacional de Humanidades, Ciencias y Tecnologías'),
('Financiamiento interno de la institución'),
('Empresas privadas o industria'),
('Programas estatales de apoyo'),
('Organismos y fondos internacionales');

update funding_sources
set name = 'CONAHCYT',
	description = 'Consejo Nacional de Humanidades, Ciencias y Tecnologías'
where id = 1;

update funding_sources
set name = 'Institucional',
	description = 'Financiamiento interno de la institución'
where id = 2;

update funding_sources
set name = 'Sector Privado',
	description = 'Empresas privadas o industria'
where id = 3;

update funding_sources
set name = 'Gobierno estatal',
	description = 'Programas estatales de apoyo'
where id = 4;

update funding_sources
set name = 'Internacional',
	description = 'Organismos y fondos internacionales'
where id = 5;

select * from funding_sources;

-- Insertar instituciones de procedencia de las que pueden partir los proyectos (institutions_origin)
insert into institutions_origin(name) values
('Universidad Tecnológica de México'),
('Instituto Politécnico Nacional'),
('Universidad Nacional Autónoma de México'),
('Tecnológico Nacional de México'),
('Universidad Autónoma de Nuevo León');

update institutions_origin
set name = 'UTM',
	description = 'Universidad Tecnológica de México'
where id = 1;

update institutions_origin
set name = 'IPN',
	description = 'Instituto Politécnico Nacional'
where id = 2;

update institutions_origin
set name = 'UNAM',
	description = 'Universidad Nacional Autónoma de México'
where id = 3;

update institutions_origin
set name = 'TecNM',
	description = 'Tecnológico Nacional de México'
where id = 4;

update institutions_origin
set name = 'UANL',
	description = 'Universidad Autónoma de Nuevo León'
where id = 5;

select * from institutions_origin;

-- Insertar lineas de investigacion
	-- Ya que esta tabla tiene relacion con parent_id que puede ser una linea de investigacion de la misma tabla. Primero insertamos las lineas padre
    -- Las lineas de investigacion principales serian con parent_id = null
    
	insert into research_lines(name, parent_id, description) values
    ('Ingeniería de Software', NULL, 'Estudio del desarrollo y mantenimiento de software'),
	('Bases de Datos', NULL, 'Gestión, modelado y análisis de datos'),
	('Inteligencia Artificial', NULL, 'Sistemas capaces de simular inteligencia humana'),
	('Sistemas de Información', NULL, 'Sistemas para la gestión de información organizacional'),
	('Educación en Ingeniería', NULL, 'Investigación en procesos de enseñanza en ingeniería');
    
    -- Sublinea serian con parent_id = id de la linea padre
    insert into research_lines(name, parent_id, description) values
    ('Arquitectura de Software', 1, 'Diseño estructural de sistemas de software'),
	('Calidad de Software', 1, 'Pruebas, métricas y aseguramiento de calidad'),
	('Desarrollo Web', 1, 'Aplicaciones web y tecnologías asociadas'),
	('Ingeniería de Requisitos', 1, 'Obtención y gestión de requerimientos'),
    ('Modelado de Datos', 2, 'Diseño conceptual y lógico de bases de datos'),
	('Bases de Datos Distribuidas', 2, 'Sistemas de datos en múltiples nodos'),
	('Big Data', 2, 'Procesamiento de grandes volúmenes de datos'),
    ('Aprendizaje Automático', 3, 'Algoritmos que aprenden de los datos'),
	('Visión por Computadora', 3, 'Procesamiento y análisis de imágenes'),
	('Procesamiento de Lenguaje Natural', 3, 'Análisis automático del lenguaje humano'),
    ('Sistemas Empresariales', 4, 'ERP, CRM y sistemas organizacionales'),
	('Gobierno de TI', 4, 'Gestión estratégica de tecnologías de información'),
	('Seguridad de la Información', 4, 'Protección de datos y sistemas'),
    ('Innovación Educativa', 5, 'Nuevas metodologías de enseñanza'),
	('Evaluación Educativa', 5, 'Modelos y técnicas de evaluación académica'),
	('Educación Basada en Competencias', 5, 'Formación orientada a competencias profesionales');
    
select * from research_lines;

-- Insertar cuerpos academicos que pueden tener los articulos, proyectos y tesis (academic_bodies)


