PRAGMA user_version = 1;
PRAGMA foreign_keys = ON;

-- TABLE "user" START --
DROP TABLE IF EXISTS user;
CREATE TABLE user (
	id INTEGER PRIMARY KEY NOT NULL,
	name CHARACTER(50) NOT NULL
);
--DROP INDEX i_user_name IF EXISTS i_user_name;
CREATE UNIQUE INDEX i_user_name ON user(name);

INSERT INTO user(id, name) VALUES(null, 'Milos');
INSERT INTO user(id, name) VALUES(null, 'Jarda');
INSERT INTO user(id, name) VALUES(null, 'Norbert');
INSERT INTO user(id, name) VALUES(null, 'Roman');
INSERT INTO user(id, name) VALUES(null, 'Vlasta');
INSERT INTO user(id, name) VALUES(null, 'Michal');
INSERT INTO user(id, name) VALUES(null, 'Radek');
INSERT INTO user(id, name) VALUES(null, 'Rosario');
-- TABLE "user" END --

-- TABLE "issue_status" START
DROP TABLE IF EXISTS issue_status;
CREATE TABLE issue_status (
	id INTEGER PRIMARY KEY NOT NULL,
	status CHARACTER(50)
);

INSERT INTO issue_status(id, status) VALUES (null, 'Open');
INSERT INTO issue_status(id, status) VALUES (null, 'Closed');
-- TABLE "issue_status" END

-- TABLE "issue" START --
DROP TABLE IF EXISTS issue;
CREATE TABLE issue (
	id INTEGER PRIMARY KEY NOT NULL,
	user_id INTEGER,
	status_id INTEGER NOT NULL DEFAULT(1),
	-- STEPS BEGIN --
	go_through BOOLEAN NOT NULL DEFAULT(0),
	search BOOLEAN NOT NULL DEFAULT(0),
	leave BOOLEAN NOT NULL DEFAULT(0),
	mark_codestriker BOOLEAN NOT NULL DEFAULT(0),
	mark_netsuite BOOLEAN NOT NULL DEFAULT(0),
	test BOOLEAN NOT NULL DEFAULT(0),
	tidy_perl_code BOOLEAN NOT NULL DEFAULT(0),
	check_js_code BOOLEAN NOT NULL DEFAULT(0),
	create_diff BOOLEAN NOT NULL DEFAULT(0),
	upload_diff BOOLEAN NOT NULL DEFAULT(0),
	apply_diff BOOLEAN NOT NULL DEFAULT(0),
	cvs_commit BOOLEAN NOT NULL DEFAULT(0),
	mark_codestriker_commited BOOLEAN NOT NULL DEFAULT(0),
	set_issue_qa_testing BOOLEAN NOT NULL DEFAULT(0),
	releasebranch BOOLEAN NOT NULL DEFAULT(0),
	precommit BOOLEAN NOT NULL DEFAULT(0),
	date BOOLEAN NOT NULL DEFAULT(0),
	patch BOOLEAN NOT NULL DEFAULT(0),
	reviewed BOOLEAN NOT NULL DEFAULT(0),
	patchqa BOOLEAN NOT NULL DEFAULT(0),
	patchemail BOOLEAN NOT NULL DEFAULT(0),
	qastatus BOOLEAN NOT NULL DEFAULT(0),
	qacomplete BOOLEAN NOT NULL DEFAULT(0),
	hotfixcommit BOOLEAN NOT NULL DEFAULT(0),
	efixcommit BOOLEAN NOT NULL DEFAULT(0),
	-- STEPS END --
	FOREIGN KEY(user_id) REFERENCES user(id),
	FOREIGN KEY(status_id) REFERENCES issue_status(id)
);
--DROP INDEX IF EXISTS i_issue;
CREATE UNIQUE INDEX i_issue ON issue(id, user_id);

INSERT INTO issue(id, user_id) VALUES(100000, 1);
INSERT INTO issue(id, user_id) VALUES(113490, 1);
INSERT INTO issue(id, user_id) VALUES(144670, 1);
-- TABLE "issue" END --

