PRAGMA user_version = 1;
PRAGMA foreign_keys = ON;

-- TABLE "user" START --
DROP TABLE IF EXISTS user;
CREATE TABLE user (
	id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
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
	id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	name CHARACTER(50)
);
CREATE UNIQUE INDEX i_status_name ON issue_status(name);
INSERT INTO issue_status(id, name) VALUES (null, 'Open');
INSERT INTO issue_status(id, name) VALUES (null, 'Closed');
-- TABLE "issue_status" END

-- TABLE "issue" START --
DROP TABLE IF EXISTS issue;
CREATE TABLE issue (
	id INTEGER PRIMARY KEY NOT NULL,
	user_id INTEGER,
	status_id INTEGER NOT NULL DEFAULT(1),
	FOREIGN KEY(user_id) REFERENCES user(id),
	FOREIGN KEY(status_id) REFERENCES issue_status(id)
);
--DROP INDEX IF EXISTS i_issue;
CREATE UNIQUE INDEX i_issue ON issue(id, user_id);

INSERT INTO issue(id, user_id) VALUES(100000, 1);
INSERT INTO issue(id, user_id) VALUES(113490, 1);
INSERT INTO issue(id, user_id) VALUES(144670, 1);
-- TABLE "issue" END --

-- TABLE "group" BEGIN --
DROP TABLE IF EXISTS step_group;
CREATE TABLE step_group (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title CHARACTER(100) NOT NULL,
    description TEXT
);
CREATE UNIQUE INDEX i_group_title ON step_group(title);

INSERT INTO step_group(id, title, description) VALUES(null, 'Code review', null);
INSERT INTO step_group(id, title, description) VALUES(null, 'Commit code', null);
INSERT INTO step_group(id, title, description) VALUES(null, '(Hot|E)-Fix', 'Follow general code check in instructions first');
-- TABLE "group" END --

-- TABLE "type" BEGIN --
DROP TABLE IF EXISTS step_type;
CREATE TABLE step_type (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name CHARACTER(50) 
);
CREATE UNIQUE INDEX i_type ON step_type(name);

INSERT INTO step_type(id, name) VALUES(null, 'checkbox');
-- TABLE "type" END --

-- TABLE "step" BEGIN --
DROP TABLE IF EXISTS step;
CREATE TABLE step (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    group_id INTEGER NOT NULL DEFAULT(1),
    type_id INTEGER NOT NULL,
    name CHARACTER(255) NOT NULL,
    label TEXT NOT NULL,
    weight SMALLINT NOT NULL DEFAULT(0),
    FOREIGN KEY(group_id) REFERENCES step_group(id),
    FOREIGN KEY(type_id) REFERENCES step_type(id)
);
CREATE UNIQUE INDEX i_step_group_name ON step(group_id, name);

INSERT INTO step(id, group_id, type_id, name, label, weight) VALUES (null, 1, 1, 'go_through', 'go through all files of review', 1);
INSERT INTO step(id, group_id, type_id, name, label, weight) VALUES (null, 1, 1, 'search', 'search for debugging symbols: <pre>$DB::single = 1;</pre> and <pre>console.log();</pre>', 1);
INSERT INTO step(id, group_id, type_id, name, label, weight) VALUES (null, 1, 1, 'leave', 'leave at least one comment on code: <pre>"Looks good"</pre>', 1);
INSERT INTO step(id, group_id, type_id, name, label, weight) VALUES (null, 1, 1, 'mark_codestriker', 'mark code as reviewed in CodeStriker', 1);
INSERT INTO step(id, group_id, type_id, name, label, weight) VALUES (null, 1, 1, 'mark_netsuite', 'mark code as reviewed in NetSuite', 1);
INSERT INTO step(id, group_id, type_id, name, label, weight) VALUES (null, 1, 1, 'test', 'inform author about closed review to switch issue to QA testing state', 1);
INSERT INTO step(id, group_id, type_id, name, label, weight) VALUES (null, 2, 1, 'tidy_perl_code', 'Check perl code <pre>make check && make tidy</pre>', 1);
INSERT INTO step(id, group_id, type_id, name, label, weight) VALUES (null, 2, 1, 'check_js_code', 'Check javascript code <pre>grunt</pre>', 1);
INSERT INTO step(id, group_id, type_id, name, label, weight) VALUES (null, 2, 1, 'create_diff', 'Create diff <pre>git diff trunk</pre>', 1);
INSERT INTO step(id, group_id, type_id, name, label, weight) VALUES (null, 2, 1, 'upload_diff', 'Upload diff to <a href="https://cvs.openair1.com/codestriker">codestriker</a> and wait to code review', 1);
INSERT INTO step(id, group_id, type_id, name, label, weight) VALUES (null, 2, 1, 'apply_diff', 'Apply diff to CVS <pre>git cvsexportcommit -v -P -w ../tb.trunk trunk branch/enh</pre>', 1);
INSERT INTO step(id, group_id, type_id, name, label, weight) VALUES (null, 2, 1, 'cvs_commit', 'Commit to CVS <pre>cvs commit -F .msg "Page.pm"</pre>', 1);
INSERT INTO step(id, group_id, type_id, name, label, weight) VALUES (null, 2, 1, 'mark_codestriker_commited', 'Mark reivew commited in  <a href="https://cvs.openair1.com/codestriker">codestriker</a>', 1);
INSERT INTO step(id, group_id, type_id, name, label, weight) VALUES (null, 2, 1, 'set_issue_qa_testing', 'Set status of issue to QA testing in <a href="http://www.netsuite.com/">NetSuite</a>', 1);
INSERT INTO step(id, group_id, type_id, name, label, weight) VALUES (null, 3, 1, 'releasebranch', 'be sure that your code is built on current release branch (not trunk)', 1);
INSERT INTO step(id, group_id, type_id, name, label, weight) VALUES (null, 3, 1, 'precommit', 'dont commit code before QA check', 1);
INSERT INTO step(id, group_id, type_id, name, label, weight) VALUES (null, 3, 1, 'date', 'check issue release date in NetSuite - if missing, ask James Samspon to add one', 1);
INSERT INTO step(id, group_id, type_id, name, label, weight) VALUES (null, 3, 1, 'patch', 'prepare unified patch with <pre>diff -uN</pre>', 1);
INSERT INTO step(id, group_id, type_id, name, label, weight) VALUES (null, 3, 1, 'reviewed', 'let someone review your code', 1);
INSERT INTO step(id, group_id, type_id, name, label, weight) VALUES (null, 3, 1, 'patchqa', 'patch qa:1443 server with your patch <pre>ssh www-release@qa.openair1.com</pre> (leave patch on server for possible revert)', 1);
INSERT INTO step(id, group_id, type_id, name, label, weight) VALUES (null, 3, 1, 'patchemail', 'sent an email about patching with instructions, how to revert your patch', 1);
INSERT INTO step(id, group_id, type_id, name, label, weight) VALUES (null, 3, 1, 'qastatus', 'switch issue status in NetSuite system to QA-cell and add comment about patched sever', 1);
INSERT INTO step(id, group_id, type_id, name, label, weight) VALUES (null, 3, 1, 'qacomplete', 'after positive QA response - update docs/delta.html with release date, patch instructions and issue info in actual hot fix release section', 1);
INSERT INTO step(id, group_id, type_id, name, label, weight) VALUES (null, 3, 1, 'hotfixcommit', 'commit your changes to release branch including delta docs entry <pre>commit -m "IS:xxxxxx [issue description]" [files] ../docs/delta.html</pre>', 1);
INSERT INTO step(id, group_id, type_id, name, label, weight) VALUES (null, 3, 1, 'efixcommit', 'store all changes in patches until E-Fix release date (commit all changes together to resease branch in the day of release of E-Fix - this will prevent conflicting commits from Hot-Fixes)', 1);
-- TABLE "step" BEGIN --

-- TABLE "step_status" BEGIN --
DROP TABLE IF EXISTS step_status;
CREATE TABLE step_status (
    step_id INTEGER NOT NULL,
    issue_id INTEGER NOT NULL,
    value INTEGER NOT NULL DEFAULT(0),
    PRIMARY KEY (step_id, issue_id)
    FOREIGN KEY(step_id) REFERENCES step(id),
    FOREIGN KEY(issue_id) REFERENCES issue(id)
);

-- ISSUE:100000
INSERT INTO step_status(step_id, issue_id, value) VALUES(1, 100000, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(2, 100000, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(3, 100000, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(4, 100000, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(5, 100000, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(6, 100000, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(7, 100000, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(8, 100000, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(9, 100000, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(10, 100000, 1);
INSERT INTO step_status(step_id, issue_id, value) VALUES(11, 100000, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(12, 100000, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(13, 100000, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(14, 100000, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(15, 100000, 1);
INSERT INTO step_status(step_id, issue_id, value) VALUES(16, 100000, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(17, 100000, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(18, 100000, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(19, 100000, 1);
INSERT INTO step_status(step_id, issue_id, value) VALUES(20, 100000, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(21, 100000, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(22, 100000, 1);
INSERT INTO step_status(step_id, issue_id, value) VALUES(23, 100000, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(24, 100000, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(25, 100000, 0);
-- ISSUE:113490
INSERT INTO step_status(step_id, issue_id, value) VALUES(1, 113490, 1);
INSERT INTO step_status(step_id, issue_id, value) VALUES(2, 113490, 1);
INSERT INTO step_status(step_id, issue_id, value) VALUES(3, 113490, 1);
INSERT INTO step_status(step_id, issue_id, value) VALUES(4, 113490, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(5, 113490, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(6, 113490, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(7, 113490, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(8, 113490, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(9, 113490, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(10, 113490, 1);
INSERT INTO step_status(step_id, issue_id, value) VALUES(11, 113490, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(12, 113490, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(13, 113490, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(14, 113490, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(15, 113490, 1);
INSERT INTO step_status(step_id, issue_id, value) VALUES(16, 113490, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(17, 113490, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(18, 113490, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(19, 113490, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(20, 113490, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(21, 113490, 1);
INSERT INTO step_status(step_id, issue_id, value) VALUES(22, 113490, 1);
INSERT INTO step_status(step_id, issue_id, value) VALUES(23, 113490, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(24, 113490, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(25, 113490, 0);
-- ISSUE:144670
INSERT INTO step_status(step_id, issue_id, value) VALUES(1, 144670, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(2, 144670, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(3, 144670, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(4, 144670, 1);
INSERT INTO step_status(step_id, issue_id, value) VALUES(5, 144670, 1);
INSERT INTO step_status(step_id, issue_id, value) VALUES(6, 144670, 1);
INSERT INTO step_status(step_id, issue_id, value) VALUES(7, 144670, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(8, 144670, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(9, 144670, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(10, 144670, 1);
INSERT INTO step_status(step_id, issue_id, value) VALUES(11, 144670, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(12, 144670, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(13, 144670, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(14, 144670, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(15, 144670, 1);
INSERT INTO step_status(step_id, issue_id, value) VALUES(16, 144670, 1);
INSERT INTO step_status(step_id, issue_id, value) VALUES(17, 144670, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(18, 144670, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(19, 144670, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(20, 144670, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(21, 144670, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(22, 144670, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(23, 144670, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(24, 144670, 0);
INSERT INTO step_status(step_id, issue_id, value) VALUES(25, 144670, 0);
-- TABLE "step_status" END --

