-- project_users
	create table if not exists project_users(
		project_id int not null,
		user_id int not null,
		role_id int not null,
		foreign key(user_id) references users(id)
		on delete cascade,
		foreign key(project_id) references projects(id)
		on delete cascade,
		foreign key(role_id) references roles(id),
		primary key(project_id, user_id)
	);

-- project_articles
	create table if not exists project_articles(
		project_id int not null,
        article_id int not null,
        foreign key(project_id) references projects(id)
        on delete cascade,
        foreign key(article_id) references articles(id)
        on delete cascade,
        primary key(project_id, article_id)
    );
    
-- project_presentations
	create table if not exists project_presentations(
		project_id int not null,
		presentation_id int not null,
		foreign key(project_id) references projects(id)
		on delete cascade,
		foreign key(presentation_id) references presentations(id)
		on delete cascade,
		primary key(project_id, presentation_id)
	);
    
-- article_journals
	create table if not exists article_journals(
		article_id int not null,
        journal_id int not null,
        start_page varchar(100),
        end_page varchar(100),
        foreign key(article_id) references articles(id)
        on delete cascade,
        foreign key(journal_id) references journals(id)
        on delete cascade,
        primary key(article_id, journal_id)
    );
    
-- article_projects
	create table if not exists article_projects(
		article_id int not null,
        project_id int not null,
        foreign key(article_id) references articles(id)
        on delete cascade,
        foreign key(project_id) references projects(id)
        on delete cascade,
        primary key(article_id, project_id)
    );
    
-- article_presentations
	create table if not exists article_presentations(
		article_id int not null,
        presentation_id int not null,
        foreign key(article_id) references articles(id)
        on delete cascade,
        foreign key(presentation_id) references presentations(id)
        on delete cascade,
        primary key(article_id, presentation_id)
    );
    
-- article_authors
	create table if not exists article_authors(
		article_id int not null,
        user_id int not null,
        author_order int not null,
        foreign key(article_id) references articles(id)
        on delete cascade,
        foreign key(user_id) references users(id)
        on delete cascade,
        primary key(article_id, user_id),
		constraint uq_article_author_order
        unique (article_id, author_order)
    );
    
-- book_authors
	create table if not exists book_authors(
		book_id int not null,
        user_id int not null,
        author_order int not null,
        foreign key(book_id) references books(id)
        on delete cascade,
        foreign key(user_id) references users(id)
        on delete cascade,
        primary key(book_id, user_id),
		constraint uq_book_author_order
        unique (book_id, author_order)
    );

-- conference_speakers
	create table if not exists conference_speakers(
		conference_id int not null,
        user_id int not null,
        speaker_role_id int not null,
        foreign key(conference_id) references conferences(id)
        on delete cascade,
        foreign key(speaker_role_id) references speaker_roles(id),
        foreign key(user_id) references users(id)
        on delete cascade,
        primary key(conference_id, user_id)
    );
    
-- conference_articles
	create table if not exists conference_articles(
		conference_id int not null,
        article_id int not null,
        foreign key(conference_id) references conferences(id)
        on delete cascade,
        foreign key(article_id) references articles(id)
        on delete cascade,
        primary key(conference_id, article_id)
    );

-- conference_projects
	create table if not exists conference_projects(
		conference_id int not null,
        project_id int not null,
        foreign key(conference_id) references conferences(id)
        on delete cascade,
        foreign key(project_id) references projects(id)
        on delete cascade,
        primary key(conference_id, project_id)
    );
    
    -- course_users
		create table if not exists course_users(
			course_id int not null,
			user_id int not null,
			course_role_id int not null,
			start_date date,
			end_date date,
			certificate_url varchar(255),
			foreign key(course_id) references courses(id)
			on delete cascade,
			foreign key(user_id) references users(id)
			on delete cascade,
			foreign key(course_role_id) references course_roles(id),
			primary key(course_id, user_id)
		);
    
    -- thesis_users
		create table if not exists thesis_users(
			thesis_id int not null,
			user_id int not null,
			thesis_role_id int not null,
			start_date date,
			end_date date,
			foreign key(thesis_id) references theses(id)
			on delete cascade,
			foreign key(user_id) references users(id)
			on delete cascade,
			foreign key(thesis_role_id) references thesis_roles(id),
			primary key(thesis_id, user_id)
		);
        
        -- Eliminar campos star_date y end_date de esta tabla
        alter table thesis_users
        drop column start_date,
        drop column end_date;
    
    -- thesis_projects
		create table if not exists thesis_projects(
			thesis_id int not null,
			user_id int not null,
			thesis_role_id int not null,
			foreign key(thesis_id) references theses(id)
			on delete cascade,
			foreign key(user_id) references users(id)
			on delete cascade,
			foreign key(thesis_role_id) references thesis_roles(id),
			primary key(thesis_id, user_id)
		);
    
    -- thesis_articles
		create table if not exists thesis_articles(
			thesis_id int not null,
			article_id int not null,
			foreign key(thesis_id) references theses(id)
			on delete cascade,
			foreign key(article_id) references articles(id)
			on delete cascade,
			primary key(thesis_id, article_id)
		);
    