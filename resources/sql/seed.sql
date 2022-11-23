create schema if not exists lbaw2214;
SET search_path TO lbaw2214;

DROP TABLE IF EXISTS post CASCADE; --140
DROP TABLE IF EXISTS question CASCADE; --50
DROP TABLE IF EXISTS answer CASCADE; --60
DROP TABLE IF EXISTS comment CASCADE; --30
DROP TABLE IF EXISTS draft CASCADE; --5
DROP TABLE IF EXISTS tag CASCADE; --25
DROP TABLE IF EXISTS question_tag CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS moderator CASCADE;
DROP TABLE IF EXISTS administrator CASCADE;

--notifs
DROP TABLE IF EXISTS notification CASCADE;
DROP TABLE IF EXISTS system_Notif CASCADE;
DROP TABLE IF EXISTS follow_tag_notif CASCADE;
DROP TABLE IF EXISTS marked_as_solution_notif CASCADE;
DROP TABLE IF EXISTS new_badge_notif CASCADE;
DROP TABLE IF EXISTS new_answer_notif CASCADE;
DROP TABLE IF EXISTS followed_question_notif CASCADE;

DROP TABLE IF EXISTS badge CASCADE;
DROP TABLE IF EXISTS badge_given CASCADE; --30
DROP TABLE IF EXISTS follows_tag CASCADE; --100
DROP TABLE IF EXISTS follows_question CASCADE; --15
DROP TABLE IF EXISTS question_vote CASCADE; --200
DROP TABLE IF EXISTS answer_vote CASCADE; --300
DROP TABLE IF EXISTS report CASCADE; --2
DROP TABLE IF EXISTS edit CASCADE; --3

DROP TYPE IF EXISTS rank;

CREATE TABLE users (
	id_user SERIAL PRIMARY KEY,
	username VARCHAR(25) UNIQUE NOT NULL,
	email TEXT UNIQUE NOT NULL,
	password TEXT NOT NULL,
	profile_picture TEXT DEFAULT 'storage/images/default-user.jpg',
	personal_text TEXT,
	blocked BOOLEAN DEFAULT '0',
	remember_token VARCHAR
);

create table administrator (
    id_admin INT PRIMARY KEY,
          CONSTRAINT FK_USER
            FOREIGN KEY(id_admin)
              REFERENCES users(id_user) ON DELETE CASCADE
);


create table moderator (
    id_moderator INT PRIMARY KEY,
          CONSTRAINT FK_USER
            FOREIGN KEY(id_moderator)
              REFERENCES users(id_user) ON DELETE CASCADE
);


create table post (
                      id_post SERIAL PRIMARY KEY,
                      id_author INT NOT NULL,
                      date TIMESTAMP NOT NULL DEFAULT Now(),
                      text_body TEXT NOT NULL,
                      CONSTRAINT FK_AUTHOR
                          FOREIGN KEY(id_author)
                              REFERENCES users(id_user)

);



create table question (
                          id_question INT PRIMARY KEY,
                          title TEXT NOT NULL,
                          score INT DEFAULT 0,
                          CONSTRAINT FK_POST
                              FOREIGN KEY(id_question)
                                  REFERENCES post(id_post) ON DELETE CASCADE
);

CREATE TABLE answer (
                        id_answer INT PRIMARY KEY,
                        id_question INT NOT NULL,
                        is_solution BOOLEAN NOT NULL DEFAULT '0',
                        score INT DEFAULT 0,
                        CONSTRAINT FK_POST
                                FOREIGN KEY(id_answer)
                                    REFERENCES post(id_post) ON DELETE CASCADE,
                            CONSTRAINT FK_QUESTION
                                FOREIGN KEY(id_question)
                                    REFERENCES question(id_question)
);


CREATE TABLE comment (
    id_comment INT PRIMARY KEY,
    id_question INT,
    id_answer INT,
        CONSTRAINT FK_POST
            FOREIGN KEY(id_comment)
                REFERENCES post(id_post) ON DELETE CASCADE,
        FOREIGN KEY(id_question)
            REFERENCES question(id_question),
        FOREIGN KEY(id_answer)
            REFERENCES answer(id_answer),
         CONSTRAINT COMMENT_BELONGS_TO_ONE_POST
                     CHECK ((id_question is NULL) != (id_answer is NULL))
);



CREATE TABLE draft (
                         id_draft SERIAL PRIMARY KEY ,
                         date TIMESTAMP NOT NULL DEFAULT Now(),
                         id_author integer NOT NULL,
                         title TEXT default NULL,
                         text_body TEXT default NULL,
                             CONSTRAINT FK_AUTHOR
                                FOREIGN KEY(id_author)
                                    REFERENCES users(id_user),
                             CONSTRAINT DRAFT_IS_NOT_EMPTY
                                 CHECK ((title is not NULL) or (text_body is not NULL))
);


CREATE TABLE tag
(
    id_tag SERIAL PRIMARY KEY,
    name   TEXT NOT NULL UNIQUE
);


CREATE TABLE question_tag (
                               id_tag INT NOT NULL,
                               id_question INT NOT NULL,
                               PRIMARY KEY (id_tag, id_question),
                                   CONSTRAINT FK_TAG
                                        FOREIGN KEY(id_tag)
                                            REFERENCES tag(id_tag) ON DELETE CASCADE,
                                    CONSTRAINT FK_QUESTION
                                        FOREIGN KEY(id_question)
                                            REFERENCES question(id_question) ON DELETE CASCADE
);



CREATE TYPE rank AS ENUM ('Gold', 'Silver', 'Bronze');

CREATE TABLE badge (
    id_badge serial PRIMARY KEY,
    b_rank rank NOT NULL,
    name VARCHAR (50) NOT NULL,
    condition TEXT NOT NULL
);



CREATE TABLE badge_given (
	id_badge INT NOT NULL,
    id_user INT NOT NULL,
    PRIMARY KEY (id_user, id_badge),
	    CONSTRAINT FK_BADGE
			FOREIGN KEY(id_badge)
				REFERENCES badge(id_badge),
		CONSTRAINT FK_USER
			FOREIGN KEY(id_user)
				REFERENCES users(id_user)
);



CREATE TABLE notification (
	id_notif SERIAL PRIMARY KEY,
	dismissed BOOL NOT NULL DEFAULT '0',
	id_user INT NOT NULL,
    date TIMESTAMP NOT NULL DEFAULT Now(),
	FOREIGN KEY (id_user) REFERENCES users(id_user) ON DELETE CASCADE
);


CREATE TABLE system_notif (
	id_notif INT PRIMARY KEY,
	notif_text TEXT NOT NULL,
	CONSTRAINT FK_NOTIF FOREIGN KEY (id_notif) REFERENCES notification (id_notif) ON DELETE CASCADE
);


CREATE TABLE follow_tag_notif (
	id_notif INT PRIMARY KEY,
	id_tag INT,
	CONSTRAINT FK_NOTIF FOREIGN KEY (id_notif) REFERENCES notification (id_notif) ON DELETE CASCADE,
	CONSTRAINT FK_TAG FOREIGN KEY (id_tag) REFERENCES tag(id_tag) ON DELETE CASCADE
);



CREATE TABLE marked_as_solution_notif (
	id_notif INT PRIMARY KEY,
	id_answer INT,
	CONSTRAINT FK_NOTIF FOREIGN KEY (id_notif) REFERENCES notification (id_notif) ON DELETE CASCADE,
	CONSTRAINT FK_ANSWER FOREIGN KEY (id_answer) REFERENCES answer(id_answer) ON DELETE CASCADE
);




CREATE TABLE new_badge_notif (
	id_notif INT PRIMARY KEY,
	id_badge INT,
	CONSTRAINT FK_NOTIF FOREIGN KEY (id_notif) REFERENCES notification (id_notif) ON DELETE CASCADE,
	CONSTRAINT FK_BADGE FOREIGN KEY (id_badge) REFERENCES badge(id_badge) ON DELETE CASCADE
);

CREATE TABLE new_answer_notif (
	id_notif INT PRIMARY KEY,
	id_answer INT,
	CONSTRAINT FK_NOTIF FOREIGN KEY (id_notif) REFERENCES notification (id_notif) ON DELETE CASCADE,
	CONSTRAINT FK_ANSWER FOREIGN KEY (id_answer) REFERENCES answer(id_answer) ON DELETE CASCADE
);


CREATE TABLE followed_question_notif (
	id_notif INT PRIMARY KEY,
	id_answer INT,
	CONSTRAINT FK_NOTIF FOREIGN KEY (id_notif) REFERENCES notification (id_notif) ON DELETE CASCADE,
	CONSTRAINT FK_ANSWER FOREIGN KEY (id_answer) REFERENCES answer(id_answer) ON DELETE CASCADE
);

CREATE TABLE follows_tag (
	id_user INT NOT NULL,
    id_tag INT NOT NULL,
    PRIMARY KEY (id_user, id_tag),
	    CONSTRAINT FK_TAG
			FOREIGN KEY(id_tag)
				REFERENCES tag(id_tag) ON DELETE CASCADE,
		CONSTRAINT FK_USER
			FOREIGN KEY(id_user)
				REFERENCES users(id_user) ON DELETE CASCADE
);

CREATE TABLE follows_question (
	id_user INT NOT NULL,
	id_question INT NOT NULL,
	PRIMARY KEY (id_user, id_question),
		CONSTRAINT FK_QUESTION
			FOREIGN KEY(id_question)
				REFERENCES question(id_question) ON DELETE CASCADE,
		CONSTRAINT FK_USER
			FOREIGN KEY(id_user)
				REFERENCES users(id_user) ON DELETE CASCADE
);



CREATE TABLE question_vote (
	id_user INT NOT NULL,
	id_question INT NOT NULL,
	score INT NOT NULL,
    PRIMARY KEY (id_user, id_question),
		CONSTRAINT SCORE_VALUES
			CHECK (score BETWEEN -1 AND 1),

		CONSTRAINT FK_QUESTION
			FOREIGN KEY(id_question)
				REFERENCES question(id_question) ON DELETE CASCADE,
		CONSTRAINT FK_USER
			FOREIGN KEY(id_user)
				REFERENCES users(id_user)
);



CREATE TABLE answer_vote (
	id_user INT NOT NULL,
	id_answer INT NOT NULL,
	score INT NOT NULL,
		CONSTRAINT SCORE_VALUES
			CHECK (score BETWEEN -1 AND 1),
	PRIMARY KEY (id_user, id_answer),
		CONSTRAINT FK_ANSWER
			FOREIGN KEY(id_answer)
				REFERENCES answer(id_answer) ON DELETE CASCADE,
		CONSTRAINT FK_USER
			FOREIGN KEY(id_user)
				REFERENCES users(id_user)
);


CREATE TABLE report (
    id_report SERIAL PRIMARY KEY,
	id_user INT NOT NULL,
	id_post INT NOT NULL,
    reason TEXT NOT NULL,
	date TIMESTAMP NOT NULL DEFAULT Now(),
    CONSTRAINT UNIQUE_USER_POST
	    UNIQUE (id_user, id_post),
    CONSTRAINT FK_POST
        FOREIGN KEY(id_post)
            REFERENCES post(id_post),
    CONSTRAINT FK_USER
        FOREIGN KEY(id_user)
            REFERENCES users(id_user)
);



CREATE TABLE edit (
    id_edit SERIAL PRIMARY KEY,
	id_user INT NOT NULL,
	id_post INT NOT NULL,
    old_text TEXT NOT NULL,
	date TIMESTAMP NOT NULL DEFAULT Now(),
    CONSTRAINT UNIQUE_USER_POST_DATE
	    UNIQUE (id_user, id_post, date),
    CONSTRAINT FK_ANSWER
        FOREIGN KEY(id_post)
            REFERENCES post(id_post),
    CONSTRAINT FK_USER
        FOREIGN KEY(id_user)
            REFERENCES users(id_user)
);

-----------------------------------------
-- Indexes
-----------------------------------------

DROP INDEX IF EXISTS publication_date;
DROP INDEX IF EXISTS notification_date;
DROP INDEX IF EXISTS question_votes;

CREATE INDEX publication_date ON post USING btree (date);
CREATE INDEX notification_date ON notification USING btree (date);
CREATE INDEX question_answers ON answer USING hash (id_question);

--Full Text Search

ALTER TABLE post
    ADD COLUMN tsvectors TSVECTOR;

DROP FUNCTION IF EXISTS post_search_update();
CREATE FUNCTION post_search_update() RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        NEW.tsvectors =
                setweight(to_tsvector('english', NEW.text_body), 'B');

    END IF;
    IF TG_OP = 'UPDATE' THEN
        IF (NEW.text_body <> OLD.text_body) THEN
            NEW.tsvectors =
                    setweight(to_tsvector('english', NEW.text_body), 'B');
        END IF;
    END IF;
    RETURN NEW;
END $$
    LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS question_search_update();
CREATE FUNCTION question_search_update() RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE post SET tsvectors = setweight(to_tsvector('english', NEW.title), 'A') WHERE id_post = NEW.id_question;
    END IF;
    IF TG_OP = 'UPDATE' THEN
        IF (NEW.title <> OLD.title) THEN
            UPDATE post SET tsvectors = setweight(to_tsvector('english', NEW.title), 'A') WHERE id_post = NEW.id_question;
        END IF;
    END IF;
    RETURN NEW;
END $$
    LANGUAGE plpgsql;

CREATE TRIGGER post_search
    BEFORE INSERT OR UPDATE ON post
    FOR EACH ROW
EXECUTE PROCEDURE post_search_update();

CREATE TRIGGER question_search
    BEFORE INSERT OR UPDATE ON question
    FOR EACH ROW
EXECUTE PROCEDURE question_search_update();

CREATE INDEX search_idx ON post USING GIN (tsvectors);


-----------------------------------------
-- Triggers
-----------------------------------------
DROP TRIGGER IF EXISTS give_question_badge ON question;
DROP FUNCTION IF EXISTS give_question_badge();

DROP TRIGGER IF EXISTS give_answer_badge ON answer;
DROP FUNCTION IF EXISTS give_answer_badge();

DROP TRIGGER IF EXISTS give_comment_badge ON comment;
DROP FUNCTION IF EXISTS give_comment_badge();

DROP TRIGGER IF EXISTS give_question_vote_badge ON question_vote;
DROP TRIGGER IF EXISTS give_answer_vote_badge ON answer_vote;
DROP FUNCTION IF EXISTS give_vote_badge();


DROP TRIGGER IF EXISTS edit_post ON edit;
DROP FUNCTION IF EXISTS can_edit();

DROP TRIGGER IF EXISTS only_one_solution ON answer;
DROP FUNCTION IF EXISTS only_one_solution();

DROP TRIGGER IF EXISTS repeated_followed_tag_notif ON follow_tag_notif;
DROP FUNCTION IF EXISTS repeated_followed_tag_notif();

DROP TRIGGER IF EXISTS only_one_report ON report;
DROP FUNCTION IF EXISTS only_one_report();

DROP TRIGGER IF EXISTS author_answer ON answer;
DROP FUNCTION IF EXISTS author_answer();

DROP TRIGGER IF EXISTS delete_user ON users;
DROP FUNCTION IF EXISTS delete_user();

DROP TRIGGER IF EXISTS answer_score ON answer_vote;
DROP FUNCTION IF EXISTS answer_score_update();

DROP TRIGGER IF EXISTS question_score ON question_vote;
DROP FUNCTION IF EXISTS question_score_update();

DROP TRIGGER IF EXISTS send_follow_tag_notifs ON question;
DROP FUNCTION IF EXISTS send_follow_tag_notifs();

DROP TRIGGER IF EXISTS send_follow_question_notifs ON answer;
DROP FUNCTION IF EXISTS send_follow_question_notifs();

DROP TRIGGER IF EXISTS send_new_answer_notif ON answer;
DROP FUNCTION IF EXISTS send_new_answer_notif();

DROP TRIGGER IF EXISTS send_marked_as_solution_notif ON answer;
DROP FUNCTION IF EXISTS send_marked_as_solution_notif();

DROP TRIGGER IF EXISTS send_new_badge_notif ON badge_given;
DROP FUNCTION IF EXISTS send_new_badge_notif();



--author of answer cannot answer his question
CREATE FUNCTION author_answer() RETURNS TRIGGER AS
$BODY$
BEGIN
    IF EXISTS (SELECT id_author FROM post WHERE id_post = NEW.id_answer  INTERSECT SELECT id_author FROM post WHERE id_post = NEW.id_question) THEN
        DELETE FROM Post WHERE id_post = NEW.id_answer;
        RAISE EXCEPTION 'An author of a question cannot answer his question';
    END IF;
    RETURN NEW;
END
$BODY$
    LANGUAGE plpgsql;

CREATE TRIGGER author_answer
    BEFORE INSERT OR UPDATE ON answer
    FOR EACH ROW
EXECUTE PROCEDURE author_answer();

--give question badges
CREATE FUNCTION give_question_badge() RETURNS TRIGGER AS
$BODY$
DECLARE
    idauthor integer;
    numquestion integer;
BEGIN
    idauthor = (SELECT id_author FROM post where id_post = NEW.id_question);
    numquestion = (SELECT COUNT(*) FROM (post JOIN question ON id_post = id_question)
                   WHERE id_author = idauthor);
    IF numquestion >= 10 AND
       NOT EXISTS(SELECT * FROM badge_given WHERE id_user = idauthor AND id_badge = 3)
    THEN
        INSERT INTO badge_given (id_user, id_badge) values (idauthor, 3);
    END IF;
    IF numquestion >= 50 AND
       NOT EXISTS(SELECT * FROM badge_given WHERE id_user = idauthor AND id_badge = 2)
    THEN
        INSERT INTO badge_given (id_user, id_badge) values (idauthor, 2);
    END IF;
    IF numquestion >= 100 AND
       NOT EXISTS(SELECT * FROM badge_given WHERE id_user = idauthor AND id_badge = 1)
    THEN
        INSERT INTO badge_given (id_user, id_badge) values (idauthor, 1);
    END IF;
    RETURN NEW;
END
$BODY$
    LANGUAGE plpgsql;

CREATE TRIGGER give_question_badge
    AFTER INSERT ON question
    FOR EACH ROW
EXECUTE PROCEDURE give_question_badge();


--give answer badges
CREATE FUNCTION give_answer_badge() RETURNS TRIGGER AS
$BODY$
DECLARE
    idauthor integer;
    numanswer integer;
BEGIN
    idauthor = (SELECT id_author FROM post where id_post = NEW.id_answer);
    numanswer = (SELECT COUNT(*) FROM (post JOIN answer ON id_post = id_answer)
                 WHERE id_author = idauthor);
    IF numanswer >= 10 AND
       NOT EXISTS(SELECT * FROM badge_given WHERE id_user = idauthor AND id_badge = 6)
    THEN
        INSERT INTO badge_given (id_user, id_badge) values (idauthor, 6);
    END IF;
    IF numanswer >= 50 AND
       NOT EXISTS(SELECT * FROM badge_given WHERE id_user = idauthor AND id_badge = 5)
    THEN
        INSERT INTO badge_given (id_user, id_badge) values (idauthor, 5);
    END IF;
    IF numanswer >= 100 AND
       NOT EXISTS(SELECT * FROM badge_given WHERE id_user = idauthor AND id_badge = 4)
    THEN
        INSERT INTO badge_given (id_user, id_badge) values (idauthor, 4);
    END IF;
    RETURN NEW;
END
$BODY$
    LANGUAGE plpgsql;

CREATE TRIGGER give_answer_badge
    AFTER INSERT ON answer
    FOR EACH ROW
EXECUTE PROCEDURE give_answer_badge();


--give comment badges
CREATE FUNCTION give_comment_badge() RETURNS TRIGGER AS
$BODY$
DECLARE
    idauthor integer;
    numcomment integer;
BEGIN
    idauthor = (SELECT id_author FROM post where id_post = NEW.id_comment);
    numcomment = (SELECT COUNT(*) FROM (post JOIN comment ON id_post = id_comment)
                  WHERE id_author = idauthor);
    IF numcomment >= 10 AND
       NOT EXISTS(SELECT * FROM badge_given WHERE id_user = idauthor AND id_badge = 9)
    THEN
        INSERT INTO badge_given (id_user, id_badge) values (idauthor, 9);
    END IF;
    IF numcomment >= 50 AND
       NOT EXISTS(SELECT * FROM badge_given WHERE id_user = idauthor AND id_badge = 8)
    THEN
        INSERT INTO badge_given (id_user, id_badge) values (idauthor, 8);
    END IF;
    IF numcomment >= 100 AND
       NOT EXISTS(SELECT * FROM badge_given WHERE id_user = idauthor AND id_badge = 7)
    THEN
        INSERT INTO badge_given (id_user, id_badge) values (idauthor, 7);
    END IF;
    RETURN NEW;
END
$BODY$
    LANGUAGE plpgsql;

CREATE TRIGGER give_comment_badge
    AFTER INSERT ON comment
    FOR EACH ROW
EXECUTE PROCEDURE give_comment_badge();


--give vote badges
CREATE FUNCTION give_vote_badge() RETURNS TRIGGER AS
$BODY$
DECLARE
    numvote integer;
BEGIN
    numvote = (SELECT COUNT(*) FROM question_vote WHERE id_user = NEW.id_user) +
              (SELECT COUNT(*) FROM answer_vote WHERE id_user = NEW.id_user);

    IF numvote >= 10 AND
       NOT EXISTS(SELECT * FROM badge_given WHERE id_user = NEW.id_user AND id_badge = 12)
    THEN
        INSERT INTO badge_given (id_user, id_badge) values (NEW.id_user, 12);
    END IF;
    IF numvote >= 50 AND
       NOT EXISTS(SELECT * FROM badge_given WHERE id_user = NEW.id_user AND id_badge = 11)
    THEN
        INSERT INTO badge_given (id_user, id_badge) values (NEW.id_user, 11);
    END IF;
    IF numvote >= 100 AND
       NOT EXISTS(SELECT * FROM badge_given WHERE id_user = NEW.id_user AND id_badge = 10)
    THEN
        INSERT INTO badge_given (id_user, id_badge) values (NEW.id_user, 10);
    END IF;
    RETURN NEW;
END
$BODY$
    LANGUAGE plpgsql;

CREATE TRIGGER give_question_vote_badge
    AFTER INSERT ON question_vote
    FOR EACH ROW
EXECUTE PROCEDURE give_vote_badge();

CREATE TRIGGER give_answer_vote_badge
    AFTER INSERT ON answer_vote
    FOR EACH ROW
EXECUTE PROCEDURE give_vote_badge();


--check if user can edit
CREATE FUNCTION can_edit() RETURNS TRIGGER AS
$BODY$
BEGIN
    IF (NEW.id_user NOT IN (SELECT id_admin FROM administrator)) AND
       (NEW.id_user NOT IN (SELECT id_moderator FROM moderator)) AND
       NOT (NEW.id_user = (SELECT id_author FROM post WHERE id_post = NEW.id_post) )
    THEN RAISE EXCEPTION 'This user cannot edit this post!';
    END IF;
    RETURN NEW;
END
$BODY$
    LANGUAGE plpgsql;

CREATE TRIGGER edit_post
    BEFORE INSERT ON edit
    FOR EACH ROW
EXECUTE PROCEDURE can_edit();


--check if it is the only solution
CREATE FUNCTION only_one_solution() RETURNS TRIGGER AS
$BODY$
BEGIN
    IF NEW.is_solution = '1' AND
       EXISTS (SELECT * FROM answer WHERE id_question = NEW.id_question AND is_solution = '1')
    THEN
        UPDATE answer SET is_solution = '0' WHERE is_solution = '1';
    END IF;
    RETURN NEW;
END
$BODY$
    LANGUAGE plpgsql;

CREATE TRIGGER only_one_solution
    BEFORE INSERT ON answer
    FOR EACH ROW
EXECUTE PROCEDURE only_one_solution();


--check if the new notification has already been sent before
CREATE FUNCTION repeated_followed_tag_notif() RETURNS TRIGGER AS
$BODY$
BEGIN
    IF EXISTS (SELECT * FROM follow_tag_notif JOIN notification
                                                   ON follow_tag_notif.id_notif = notification.id_notif
               WHERE id_user = (SELECT id_user FROM notification WHERE id_notif = NEW.id_notif)
                 AND id_tag = NEW.id_tag)
    THEN RAISE EXCEPTION 'There already is another notification for this user from this tag!';
    END IF;
    RETURN NEW;
END
$BODY$
    LANGUAGE plpgsql;

CREATE TRIGGER repeated_followed_tag_notif
    BEFORE INSERT ON follow_tag_notif
    FOR EACH ROW
EXECUTE PROCEDURE repeated_followed_tag_notif();


--check if the user didn't already report before
CREATE FUNCTION only_one_report() RETURNS TRIGGER AS
$BODY$
BEGIN
    IF EXISTS (SELECT * FROM report WHERE id_user = NEW.id_user AND id_post = NEW.id_post)
    THEN RAISE EXCEPTION 'There already is another report for this post from this user!';
    END IF;
    RETURN NEW;
END
$BODY$
    LANGUAGE plpgsql;

CREATE TRIGGER only_one_report
    BEFORE INSERT ON report
    FOR EACH ROW
EXECUTE PROCEDURE only_one_report();

--send notifications to everyone that follows a tag when a new post uses it
CREATE FUNCTION send_follow_tag_notifs() RETURNS TRIGGER AS --after insert on post
$BODY$
DECLARE t RECORD;
BEGIN
    FOR t IN SELECT * FROM follows_tag WHERE follows_tag.id_tag IN (SELECT id_tag FROM question_tag WHERE id_question = NEW.id_question)
        LOOP
            INSERT INTO notification(dismissed, id_user, date)
            VALUES(false, t.id_user, Now());

            insert into follow_tag_notif (id_notif, id_tag)
                (select currval('notification_id_notif_seq'), t.id_tag);


        END LOOP;
    RETURN NEW;

END
$BODY$
    LANGUAGE plpgsql;

CREATE TRIGGER send_follow_tag_notifs
    AFTER INSERT ON question
    FOR EACH ROW
EXECUTE PROCEDURE send_follow_tag_notifs();

--send notifications to everyone that follows a tag when a new post uses it
CREATE FUNCTION send_marked_as_solution_notif() RETURNS TRIGGER AS --after insert on post
$BODY$
DECLARE t record;
BEGIN
    IF NEW.is_solution = true AND OLD.is_solution = false THEN SELECT INTO t * FROM post WHERE id_post = NEW.id_answer;
    INSERT INTO notification(dismissed, id_user, date)
    VALUES(false, t.id_author, Now());

    insert into marked_as_solution_notif (id_notif)
        (select currval('notification_id_notif_seq'), NEW.id_answer);
    END IF;
    RETURN NEW;

END
$BODY$
    LANGUAGE plpgsql;

CREATE TRIGGER send_marked_as_solution_notif
    AFTER UPDATE ON answer
    FOR EACH ROW
EXECUTE PROCEDURE send_marked_as_solution_notif();


--send notifications to a user when they receive a new badge
CREATE FUNCTION send_new_badge_notif() RETURNS TRIGGER AS --after insert on post
$BODY$
BEGIN
    INSERT INTO notification(dismissed, id_user, date)
    VALUES(false, NEW.id_user, Now());

    insert into new_badge_notif (id_notif, id_badge)
        (select currval('notification_id_notif_seq'), NEW.id_badge);
    RETURN NEW;
END
$BODY$
    LANGUAGE plpgsql;

CREATE TRIGGER send_new_badge_notif
    AFTER INSERT ON badge_given
    FOR EACH ROW
EXECUTE PROCEDURE send_new_badge_notif();

--send notifications to a user when they receive new answers on a question
CREATE FUNCTION send_new_answer_notif() RETURNS TRIGGER AS --after insert on post
$BODY$
DECLARE t RECORD;
BEGIN
    SELECT INTO t * FROM post WHERE id_post = NEW.id_question;
    INSERT INTO notification(dismissed, id_user, date)
    VALUES(false, t.id_author, Now());

    insert into new_answer_notif (id_notif, id_answer)
        (select currval('notification_id_notif_seq'), NEW.id_answer);
    RETURN NEW;
END
$BODY$
    LANGUAGE plpgsql;

CREATE TRIGGER send_new_answer_notif
    AFTER INSERT ON answer
    FOR EACH ROW
EXECUTE PROCEDURE send_new_answer_notif();



--send notifications to everyone that follows a question when it receives a new answer
CREATE FUNCTION send_follow_question_notifs() RETURNS TRIGGER AS
$BODY$
DECLARE t RECORD;
BEGIN
    FOR t IN SELECT * FROM follows_question WHERE follows_question.id_question = NEW.id_question
        LOOP
            INSERT INTO notification(dismissed, id_user, date)
            VALUES(false, t.id_user, Now());

            insert into followed_question_notif (id_notif, id_answer)
                (select currval('notification_id_notif_seq'), NEW.id_answer);


        END LOOP;
    RETURN NULL;

END
$BODY$
    LANGUAGE plpgsql;

CREATE TRIGGER send_follow_question_notifs
    AFTER INSERT ON answer
    FOR EACH ROW
EXECUTE PROCEDURE send_follow_question_notifs();



--update the score of a question
CREATE FUNCTION question_score_update() RETURNS TRIGGER AS
$BODY$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE question SET score = score + NEW.score WHERE question.id_question = NEW.id_question;
    END IF;
    IF TG_OP = 'UPDATE' THEN
        UPDATE question SET score = score + NEW.score - OLD.score WHERE question.id_question = NEW.id_question;
    END IF;
    RETURN NEW;

END
$BODY$
    LANGUAGE plpgsql;

CREATE TRIGGER question_score
    BEFORE INSERT OR UPDATE ON question_vote
    FOR EACH ROW
EXECUTE PROCEDURE question_score_update();

CREATE FUNCTION answer_score_update() RETURNS TRIGGER AS
$BODY$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE answer SET score = score + NEW.score WHERE answer.id_answer = NEW.id_answer;
    END IF;
    IF TG_OP = 'UPDATE' THEN
        UPDATE answer SET score = score + NEW.score - OLD.score WHERE answer.id_answer = NEW.id_answer;
    END IF;
    RETURN NEW;

END
$BODY$
    LANGUAGE plpgsql;

CREATE TRIGGER answer_score
    BEFORE INSERT OR UPDATE ON answer_vote
    FOR EACH ROW
EXECUTE PROCEDURE answer_score_update();



-----------------------------------------
-- Transactions
-----------------------------------------
/*
 ------------------------TRANSACTION ADMINISTRATOR

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Insert user
INSERT INTO users (username, email, password, profile_picture, personal_text)
 VALUES ($username, $email, $password, $profile_picture, $personal_text);

-- Insert administrator
INSERT INTO administrator(id_admin)
 VALUES(currval('user_id_user_seq'));

END TRANSACTION;

------------------------TRANSACTION MODERATOR

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Insert user
INSERT INTO users (id_user, username, email, password, profile_picture, personal_text)
 VALUES ($id_user, $username, $email, $password, $profile_picture, $personal_text);

-- Insert moderator
INSERT INTO moderator(id_moderator)
 VALUES(currval('user_id_user_seq'));

END TRANSACTION;

------------------------TRANSACTION ANSWER

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Insert post
INSERT INTO post(id_author, date, text_body)
 VALUES($id_author, Now(), $text_body);

-- Insert answer
INSERT INTO answer(id_answer, id_question, is_solution)
 VALUES(currval('post_id_post_seq'), $id_question, false);

END TRANSACTION;


-------------------------TRANSACTION QUESTION

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Insert post
INSERT INTO post(id_author, date, text_body)
 VALUES($id_author, Now(), $text_body);

-- Insert question
INSERT INTO question(id_question, title)
 VALUES(currval('post_id_post_seq'), $title);

END TRANSACTION;


------------------------TRANSACTION COMMENT

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Insert post
INSERT INTO post(id_author, date, text_body)
 VALUES($id_author, Now(), $text_body);

-- Insert comment
INSERT INTO comment(id_comment)
 VALUES(currval('post_id_post_seq'));

END TRANSACTION;

------------------------TRANSACTION SYS_NOTIF

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Insert notification
INSERT INTO notification(dismissed, id_user, date)
 VALUES(false, $id_user, Now());

-- Insert specific notification
INSERT INTO system_notif(id_notif, notif_text)
 VALUES(currval('notification_id_notif_seq'), $notif_text);

END TRANSACTION;

------------------------TRANSACTION FOLLOW_TAG_NOTIF

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Insert notification
INSERT INTO notification(dismissed, id_user, date)
 VALUES(false, $id_user, Now());

-- Insert specific notification
INSERT INTO follow_tag_notif(id_notif, id_tag)
 VALUES(currval('notification_id_notif_seq'), $id_tag);

END TRANSACTION;

------------------------TRANSACTION MARKED_AS_SOLUTION_NOTIF

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Insert notification
INSERT INTO notification(dismissed, id_user, date)
 VALUES(false, $id_user, Now());

-- Insert specific notification
INSERT INTO marked_as_solution_notif(id_notif, id_answer)
 VALUES(currval('notification_id_notif_seq'), $id_answer);

END TRANSACTION;

------------------------TRANSACTION NEW_BADGE_NOTIF

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Insert notification
INSERT INTO notification(dismissed, id_user, date)
 VALUES(false, $id_user, Now());

-- Insert specific notification
INSERT INTO new_badge_notif(id_notif, id_badge)
 VALUES(currval('notification_id_notif_seq'), $id_badge);

END TRANSACTION;

------------------------TRANSACTION NEW_ANSWER_NOTIF

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Insert notification
INSERT INTO notification(dismissed, id_user, date)
 VALUES(false, $id_user, Now());

-- Insert specific notification
INSERT INTO new_answer_notif(id_notif, id_answer)
 VALUES(currval('notification_id_notif_seq'), $id_answer);

END TRANSACTION;

------------------------TRANSACTION FOLLOWED_QUESTION_NOTIF

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Insert notification
INSERT INTO notification(dismissed, id_user, date)
 VALUES(false, $id_user, Now());

-- Insert specific notification
INSERT INTO followed_question_notif(id_notif, id_answer)
 VALUES(currval('notification_id_notif_seq'), $id_answer);

END TRANSACTION;




 ----------------------------TRANSACTION DELETE USER

BEGIN TRANSACTION ;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED ;

UPDATE users
SET username = CONCAT ('deleted_user_',$id_user::TEXT),
    email = CONCAT ('deleted_email_',$id_user::TEXT),
    password = CONCAT (MD5(RANDOM()::TEXT),$id_user::TEXT),
    profile_picture = NULL,
    personal_text = NULL
WHERE id_user = $id_user;

-- delete notifications
DELETE FROM notification WHERE id_user = $id_user;
-- delete drafts
DELETE FROM draft WHERE id_author = $id_user;
-- delete follows_tag
DELETE FROM follows_tag WHERE id_user = $id_user;
-- delete follows_question
DELETE FROM follows_question WHERE id_user = $id_user;
-- delete badges
DELETE FROM badge_given WHERE id_user = $id_user;

END TRANSACTION;

 */


insert into users (username, email, password, profile_picture, personal_text) values ('admin', 'admin@admin.com', '$2y$10$MhJeCSrNVCOhVHbKeSwffuKfXdvAzQ/HIDCMmJExcrvLEwEtqDOLS', 'storage/images/default-user.jpg', '');
insert into users (username, email, password, profile_picture, personal_text) values ('helper', 'helper@help.com', '$2y$10$MhJeCSrNVCOhVHbKeSwffuKfXdvAzQ/HIDCMmJExcrvLEwEtqDOLS', 'storage/images/default-user.jpg', '');
insert into users (username, email, password, profile_picture, personal_text) values ('anuschke0', 'pdaouse0@nature.com', 'Eb3BBl', 'https://robohash.org/etcorporispossimus.png?size=50x50&set=set1', '');
insert into users (username, email, password, profile_picture, personal_text) values ('bekell1', 'rpennicard1@hao123.com', '9FEnHZkC', 'https://robohash.org/officiaipsamofficiis.png?size=50x50&set=set1', 'maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in');
insert into users (username, email, password, profile_picture, personal_text) values ('pcalven2', 'bdaudray2@sfgate.com', 'W2l5yKN4Ffj', 'storage/images/default-user.jpg', 'vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien');
insert into users (username, email, password, profile_picture, personal_text) values ('ayorath3', 'gcurmi3@dion.ne.jp', '45z1G3gU6', 'https://robohash.org/quasidebitisaliquid.png?size=50x50&set=set1', 'scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit');
insert into users (username, email, password, profile_picture, personal_text) values ('fmurray4', 'lshrimplin4@cafepress.com', 'ECpX3g45', 'storage/images/default-user.jpg', 'dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum');
insert into users (username, email, password, profile_picture, personal_text) values ('gmoden5', 'lfollitt5@comsenz.com', 'szV7jLoNHXy', 'https://robohash.org/estrationeaut.png?size=50x50&set=set1', 'a libero nam dui proin leo odio porttitor id');
insert into users (username, email, password, profile_picture, personal_text) values ('togriffin6', 'kfitzgibbon6@mtv.com', 'GP3rxKQ8', 'storage/images/default-user.jpg', 'suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet');
insert into users (username, email, password, profile_picture, personal_text) values ('hmeddows7', 'dtolson7@1und1.de', 'OQD2If072Up', 'https://robohash.org/nisiexpeditaquidem.png?size=50x50&set=set1', null);
insert into users (username, email, password, profile_picture, personal_text) values ('rgerred8', 'ncrat8@bluehost.com', '8eKA1Iq', 'https://robohash.org/aperiamautrepellat.png?size=50x50&set=set1', null);
insert into users (username, email, password, profile_picture, personal_text) values ( 'rvandevelde9', 'dwillingam9@theatlantic.com', 'sjQmy2KUL9va', 'https://robohash.org/nemonecessitatibusnihil.png?size=50x50&set=set1', '');
insert into users (username, email, password, profile_picture, personal_text) values ( 'asneakera', 'ndeeslya@fastcompany.com', 'tIvToY', 'storage/images/default-user.jpg', 'mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit');
insert into users (username, email, password, profile_picture, personal_text) values ( 'bboardb', 'clarmanb@wisc.edu', '9y1KePwc3wo', 'https://robohash.org/laboriosamquidemnulla.png?size=50x50&set=set1', 'augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit');
insert into users (username, email, password, profile_picture, personal_text) values ( 'rblakec', 'tgrosvenerc@rakuten.co.jp', 'Hms5ygn', 'https://robohash.org/occaecatidistinctiodicta.png?size=50x50&set=set1', 'erat eros viverra');
insert into users (username, email, password, profile_picture, personal_text) values ( 'cburrasd', 'stwiddyd@usa.gov', 'cG3Lyq', 'https://robohash.org/dolorumestpossimus.png?size=50x50&set=set1', null);
insert into users (username, email, password, profile_picture, personal_text) values ( 'bcristofaninie', 'hheliare@skype.com', 'Mox6IKJf7G', 'storage/images/default-user.jpg', null);
insert into users (username, email, password, profile_picture, personal_text) values ( 'ghendrenf', 'ahewf@mediafire.com', 'N679OUSLcNcv', 'https://robohash.org/autcorruptiet.png?size=50x50&set=set1', 'odio condimentum id luctus nec molestie sed');
insert into users (username, email, password, profile_picture, personal_text) values ( 'bwalbrung', 'fbartrumg@weather.com', 'kEGeA1stzT', 'storage/images/default-user.jpg', 'libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla');
insert into users (username, email, password, profile_picture, personal_text) values ( 'bchritchleyh', 'adelafonth@photobucket.com', 'uPZvFJmA', 'storage/images/default-user.jpg', null);
insert into users (username, email, password, profile_picture, personal_text) values ( 'eclitheroei', 'sbandti@dropbox.com', 'jtV7jjiX', 'storage/images/default-user.jpg', 'erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque');
insert into users (username, email, password, profile_picture, personal_text) values ( 'jspeakej', 'nlesaunierj@unicef.org', 'gglUvzcRxPi', 'https://robohash.org/quissaepemolestiae.png?size=50x50&set=set1', 'neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi');
insert into users (username, email, password, profile_picture, personal_text) values ( 'mjansikk', 'uwolfendellk@ovh.net', 'TEAFeWz', 'https://robohash.org/nobisminusvoluptatibus.png?size=50x50&set=set1', 'pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor');
insert into users (username, email, password, profile_picture, personal_text) values ( 'ekiehnel', 'imurrishl@usa.gov', 'L86gXM9', 'storage/images/default-user.jpg', 'duis bibendum felis sed interdum');
insert into users (username, email, password, profile_picture, personal_text) values ( 'dcayzerm', 'dfullbrookm@facebook.com', 'tCmDGUfq', 'https://robohash.org/praesentiumlaborenecessitatibus.png?size=50x50&set=set1', 'consequat in consequat ut nulla sed accumsan felis ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit');
insert into users (username, email, password, profile_picture, personal_text) values ( 'dtucknuttn', 'ajorcken@java.com', 'ZwWsW2otU2Fq', 'https://robohash.org/anobismaxime.png?size=50x50&set=set1', null);
insert into users (username, email, password, profile_picture, personal_text) values ( 'gheaselgraveo', 'acogleo@posterous.com', 'rZkVoMlAA', 'https://robohash.org/impeditnonquibusdam.png?size=50x50&set=set1', null);
insert into users (username, email, password, profile_picture, personal_text) values ( 'rscowcroftp', 'lzarfatp@shop-pro.jp', 'yRbvlP', 'https://robohash.org/architectomodiomnis.png?size=50x50&set=set1', 'non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla');
insert into users (username, email, password, profile_picture, personal_text) values ( 'ehanhardtq', 'ckrollq@webeden.co.uk', 'a5rVxUX', 'https://robohash.org/numquamassumendaquo.png?size=50x50&set=set1', 'sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies');
insert into users (username, email, password, profile_picture, personal_text) values ( 'dranklinr', 'emohammedr@independent.co.uk', 'Xlfa80x72NL', 'storage/images/default-user.jpg', 'magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam');
insert into users (username, email, password, profile_picture, personal_text) values ( 'lmathewess', 'glinsteads@omniture.com', 'iJMWbpRhc', 'storage/images/default-user.jpg', 'mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum');
insert into users (username, email, password, profile_picture, personal_text) values ( 'tmcgauhyt', 'wsinclairt@twitter.com', '0UYf8N1', 'https://robohash.org/totamvoluptatemoccaecati.png?size=50x50&set=set1', 'tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique');
insert into users (username, email, password, profile_picture, personal_text) values ( 'ihaeslieru', 'epavelkau@phoca.cz', 'nqW7Fg8VpR', 'https://robohash.org/doloremanimiex.png?size=50x50&set=set1', 'neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis');
insert into users (username, email, password, profile_picture, personal_text) values ( 'shartellv', 'ehalmsv@dagondesign.com', 'Kv1i4M9', 'https://robohash.org/aliquidvoluptasunde.png?size=50x50&set=set1', 'amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel');
insert into users (username, email, password, profile_picture, personal_text) values ( 'rordeltw', 'jottleyw@salon.com', 'mM0Wh6fS', 'https://robohash.org/idblanditiisfacere.png?size=50x50&set=set1', 'in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan');
insert into users (username, email, password, profile_picture, personal_text) values ( 'mnotmanx', 'hlatteyx@simplemachines.org', 'UtEGDO2a', 'storage/images/default-user.jpg', 'primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis');
insert into users (username, email, password, profile_picture, personal_text) values ( 'kbrisseauy', 'naleksandrovy@unesco.org', 'BMbwgH8N1N', 'https://robohash.org/velarchitectominima.png?size=50x50&set=set1', null);
insert into users (username, email, password, profile_picture, personal_text) values ( 'pmcminnz', 'gboleynz@soundcloud.com', '0NaM7Ok', 'https://robohash.org/nullaeosillo.png?size=50x50&set=set1', 'nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate');
insert into users (username, email, password, profile_picture, personal_text) values ( 'cmantripp10', 'deliot10@etsy.com', 'p1418n0', 'https://robohash.org/quasivoluptasut.png?size=50x50&set=set1', 'lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue');
insert into users (username, email, password, profile_picture, personal_text) values ( 'aalderson11', 'dconibear11@tripadvisor.com', 'dabl38', 'storage/images/default-user.jpg', null);
insert into users (username, email, password, profile_picture, personal_text) values ( 'gajean12', 'scamplen12@trellian.com', 'ghyufTco', 'https://robohash.org/voluptasdoloremreiciendis.png?size=50x50&set=set1', 'amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin');
insert into users (username, email, password, profile_picture, personal_text) values ( 'pkop13', 'ginott13@123-reg.co.uk', '4lIdNqdWg', 'https://robohash.org/consecteturiustonulla.png?size=50x50&set=set1', null);
insert into users (username, email, password, profile_picture, personal_text) values ( 'alivingston14', 'vhousaman14@japanpost.jp', 'oYc12WcB8n', 'https://robohash.org/delenitietimpedit.png?size=50x50&set=set1', 'magna at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet');
insert into users (username, email, password, profile_picture, personal_text) values ( 'imccosh15', 'cgreim15@sbwire.com', 'Xn0uwrQ25', 'https://robohash.org/velitaliquidquo.png?size=50x50&set=set1', 'odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet');
insert into users (username, email, password, profile_picture, personal_text) values ( 'krizzetti16', 'rmccambrois16@shareasale.com', 'hhVPC4', 'https://robohash.org/rerumvoluptatumqui.png?size=50x50&set=set1', null);
insert into users (username, email, password, profile_picture, personal_text) values ( 'glagneaux17', 'hranscome17@360.cn', 'fOcmTyZ', 'storage/images/default-user.jpg', 'justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl');
insert into users (username, email, password, profile_picture, personal_text) values ( 'fandreucci18', 'ckenner18@etsy.com', 'XHtWAlVm', 'https://robohash.org/dignissimosaccusantiumdeleniti.png?size=50x50&set=set1', null);
insert into users (username, email, password, profile_picture, personal_text) values ( 'nmulleary19', 'kquantick19@dot.gov', '2YDalu8', 'https://robohash.org/recusandaeabquibusdam.png?size=50x50&set=set1', 'felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus');
insert into users (username, email, password, profile_picture, personal_text) values ( 'glantoph1a', 'fleftley1a@goodreads.com', '852Qpf', 'https://robohash.org/recusandaeharumvoluptate.png?size=50x50&set=set1', 'sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta');
insert into users (username, email, password, profile_picture, personal_text) values ( 'eputtnam1b', 'lfoulgham1b@bizjournals.com', '3pm4sK', 'https://robohash.org/quiquiaoccaecati.png?size=50x50&set=set1', 'tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus');
insert into users (username, email, password, profile_picture, personal_text) values ( 'elamberts1c', 'stilt1c@biglobe.ne.jp', 'xTH2Qgo122', 'https://robohash.org/porroautemearum.png?size=50x50&set=set1', 'lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in');
insert into users (username, email, password, profile_picture, personal_text) values ( 'mtailour1d', 'nbassil1d@aboutads.info', 'vuRPMFR', 'https://robohash.org/ipsamdoloremprovident.png?size=50x50&set=set1', 'nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus');
insert into users (username, email, password, profile_picture, personal_text) values ( 'jneem1e', 'gfelgat1e@chron.com', 'eGBywlZLA', 'https://robohash.org/sedenimsint.png?size=50x50&set=set1', 'tempor convallis nulla neque libero convallis eget eleifend luctus');
insert into users (username, email, password, profile_picture, personal_text) values ( 'hpareman1f', 'naishford1f@squarespace.com', 'ULrHVK8w6QFt', 'https://robohash.org/ipsumidporro.png?size=50x50&set=set1', 'lobortis');
insert into users (username, email, password, profile_picture, personal_text) values ( 'marnoult1g', 'cnelane1g@lulu.com', 'KBUcJ3R2', 'storage/images/default-user.jpg', null);
insert into users (username, email, password, profile_picture, personal_text) values ( 'rfeatherstone1h', 'cbaroch1h@technorati.com', 'q5tpn4', 'https://robohash.org/eosrerumexcepturi.png?size=50x50&set=set1', 'nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem');
insert into users (username, email, password, profile_picture, personal_text) values ( 'odellenty1i', 'ainstone1i@ft.com', 'aojpUC', 'https://robohash.org/autemfacilisin.png?size=50x50&set=set1', 'at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget');
insert into users (username, email, password, profile_picture, personal_text) values ( 'epiggrem1j', 'obertelsen1j@eepurl.com', 'y5HxfS21Qq', 'storage/images/default-user.jpg', null);
insert into users (username, email, password, profile_picture, personal_text) values ( 'eclack1k', 'hnaile1k@nationalgeographic.com', 'caxB3LhOuY', 'storage/images/default-user.jpg', 'urna ut tellus nulla ut erat id mauris vulputate elementum');
insert into users (username, email, password, profile_picture, personal_text) values ( 'owhetnall1l', 'afelten1l@shinystat.com', 'Fufa464aC', 'https://robohash.org/omnisvelquod.png?size=50x50&set=set1', 'nam nulla integer pede justo');
insert into users (username, email, password, profile_picture, personal_text) values ( 'ebuncombe1m', 'jderycot1m@yellowbook.com', 'pKfUikUO5HY', 'storage/images/default-user.jpg', 'vel');
insert into users (username, email, password, profile_picture, personal_text) values ( 'marmatage1n', 'astrongitharm1n@slate.com', 'mGecI98JzrQq', 'storage/images/default-user.jpg', 'potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit');
insert into users (username, email, password, profile_picture, personal_text) values ( 'plafuente1o', 'kyurin1o@360.cn', 'QFj8ZyZJaGUY', 'https://robohash.org/quasiimpeditdolor.png?size=50x50&set=set1', 'lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien');
insert into users (username, email, password, profile_picture, personal_text) values ( 'lbatchelour1p', 'tbraidon1p@istockphoto.com', 'PnvRNey', 'storage/images/default-user.jpg', 'eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu');
insert into users (username, email, password, profile_picture, personal_text) values ( 'bhartman1q', 'tbucham1q@simplemachines.org', 'NuLSKYxUlbMJ', 'https://robohash.org/sedquiet.png?size=50x50&set=set1', 'orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam');
insert into users (username, email, password, profile_picture, personal_text) values ( 'wdartnall1r', 'dmeech1r@nydailynews.com', 'lbFkEFO', 'https://robohash.org/minimasimiliqueadipisci.png?size=50x50&set=set1', 'turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus');
insert into users (username, email, password, profile_picture, personal_text) values ( 'atrevain1s', 'ejosilevich1s@who.int', 'lYvbfnQl9L', 'https://robohash.org/consecteturdoloribusrepudiandae.png?size=50x50&set=set1', 'sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi');
insert into users (username, email, password, profile_picture, personal_text) values ( 'amurison1t', 'dgreve1t@amazonaws.com', 'ughj5xa4', 'https://robohash.org/quiperferendisrepudiandae.png?size=50x50&set=set1', null);
insert into users (username, email, password, profile_picture, personal_text) values ( 'agatrill1u', 'akilmary1u@addthis.com', 'L8D1HSYj', 'https://robohash.org/sapientealiquida.png?size=50x50&set=set1', null);
insert into users (username, email, password, profile_picture, personal_text) values ( 'gphizackarley1v', 'cwestwell1v@harvard.edu', 'kWYVsdZQF', 'https://robohash.org/nullafugiatquasi.png?size=50x50&set=set1', 'in');
insert into users (username, email, password, profile_picture, personal_text) values ( 'jmetzke1w', 'cpau1w@salon.com', 'DjSmBH2ztsXa', 'https://robohash.org/distinctionobisfacere.png?size=50x50&set=set1', null);
insert into users (username, email, password, profile_picture, personal_text) values ( 'tmarusyak1x', 'kribbon1x@diigo.com', 'Z7qJTznNyR', 'https://robohash.org/porroquiaccusamus.png?size=50x50&set=set1', 'felis sed interdum venenatis turpis enim blandit mi in porttitor pede');
insert into users (username, email, password, profile_picture, personal_text) values ( 'rleacock1y', 'agilvary1y@usgs.gov', 'X0t9xh', 'https://robohash.org/temporerepellatiusto.png?size=50x50&set=set1', 'ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in');
insert into users (username, email, password, profile_picture, personal_text) values ( 'dwinterbottom1z', 'jbrogi1z@123-reg.co.uk', '0qZrEDi', 'https://robohash.org/quispraesentiumvero.png?size=50x50&set=set1', 'interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis at velit eu est congue elementum in hac habitasse');
insert into users (username, email, password, profile_picture, personal_text) values ( 'babbs20', 'vrogan20@hibu.com', 'HuiU5an', 'storage/images/default-user.jpg', 'morbi');
insert into users (username, email, password, profile_picture, personal_text) values ( 'amotion21', 'pocalleran21@simplemachines.org', 'pJfe7UkDO', 'https://robohash.org/quoautnon.png?size=50x50&set=set1', null);
insert into users (username, email, password, profile_picture, personal_text) values ( 'ehiner22', 'elile22@spiegel.de', '5b2B4SSx2sXp', 'https://robohash.org/consequaturestquia.png?size=50x50&set=set1', null);
insert into users (username, email, password, profile_picture, personal_text) values ( 'rcoop23', 'bsazio23@salon.com', 'Uu6DixN', 'storage/images/default-user.jpg', 'posuere');
insert into users (username, email, password, profile_picture, personal_text) values ( 'bconring24', 'bwickwarth24@npr.org', 'akneJxjXHWF', 'https://robohash.org/isteetvel.png?size=50x50&set=set1', 'turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra');
insert into users (username, email, password, profile_picture, personal_text) values ( 'foneil25', 'bvears25@mtv.com', '42UKiPzbjiiG', 'storage/images/default-user.jpg', 'lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique');
insert into users (username, email, password, profile_picture, personal_text) values ( 'brendbaek26', 'pdewerson26@pcworld.com', 'jr9TJuBfoFnF', 'https://robohash.org/suscipitquiquidem.png?size=50x50&set=set1', 'vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus');
insert into users (username, email, password, profile_picture, personal_text) values ( 'vchatainier27', 'msheppey27@cbsnews.com', 'DoHXG1nL3Ol', 'storage/images/default-user.jpg', 'ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio');
insert into users (username, email, password, profile_picture, personal_text) values ( 'laronowitz28', 'bseawell28@youtube.com', 'JojJQjRwJ', 'https://robohash.org/etsuscipitlaudantium.png?size=50x50&set=set1', null);
insert into users (username, email, password, profile_picture, personal_text) values ( 'gburlingham29', 'sdossettor29@soup.io', 'LkMlEmk', 'https://robohash.org/eaquoscumque.png?size=50x50&set=set1', 'rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in');
insert into users (username, email, password, profile_picture, personal_text) values ( 'ayannoni2a', 'gcampling2a@bloglines.com', '9iKQkE', 'storage/images/default-user.jpg', 'in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien');
insert into users (username, email, password, profile_picture, personal_text) values ( 'iterzo2b', 'hgrigorushkin2b@plala.or.jp', 'yKnmUjqoBeJM', 'storage/images/default-user.jpg', 'justo in');
insert into users (username, email, password, profile_picture, personal_text) values ( 'lhars2c', 'cmcclay2c@cargocollective.com', 'CoTQ1937bb', 'storage/images/default-user.jpg', 'a suscipit nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis');
insert into users (username, email, password, profile_picture, personal_text) values ( 'abowe2d', 'evaskin2d@ocn.ne.jp', 'igJamiWDqwb3', 'https://robohash.org/quosreprehenderitvoluptatem.png?size=50x50&set=set1', 'eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque');
insert into users (username, email, password, profile_picture, personal_text) values ( 'lborris2e', 'sdunning2e@wikimedia.org', '81yPQIZkDM', 'storage/images/default-user.jpg', null);
insert into users (username, email, password, profile_picture, personal_text) values ( 'ddreini2f', 'npavluk2f@e-recht24.de', 'kO86XBls6', 'https://robohash.org/porroetet.png?size=50x50&set=set1', 'ullamcorper augue a');
insert into users (username, email, password, profile_picture, personal_text) values ( 'gjirus2g', 'cdri2g@canalblog.com', 'iuGkbtIqS5', 'https://robohash.org/voluptatumetullam.png?size=50x50&set=set1', 'risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices');
insert into users (username, email, password, profile_picture, personal_text) values ( 'lbuttler2h', 'hstratiff2h@globo.com', 'XagcmE2', 'https://robohash.org/ipsumestomnis.png?size=50x50&set=set1', 'a nibh in quis justo');
insert into users (username, email, password, profile_picture, personal_text) values ( 'agallienne2i', 'bbarents2i@skype.com', 'oM14lxz', 'https://robohash.org/utrationequaerat.png?size=50x50&set=set1', null);
insert into users (username, email, password, profile_picture, personal_text) values ( 'sbolle2j', 'glancastle2j@google.it', '2xwf8Zvf4S', 'storage/images/default-user.jpg', null);
insert into users (username, email, password, profile_picture, personal_text) values ( 'tleggan2k', 'dpeirson2k@mapquest.com', 'jkgGHcfoyE', 'https://robohash.org/accusamussedlibero.png?size=50x50&set=set1', 'nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede');
insert into users (username, email, password, profile_picture, personal_text) values ( 'sbrilon2l', 'mbriand2l@lycos.com', '9Oz8h40', 'storage/images/default-user.jpg', 'semper interdum');
insert into users (username, email, password, profile_picture, personal_text) values ( 'kphelit2m', 'ecampsall2m@fda.gov', '9pMkAOew', 'https://robohash.org/debitisdoloresnulla.png?size=50x50&set=set1', 'viverra pede ac diam cras pellentesque volutpat dui maecenas');
insert into users (username, email, password, profile_picture, personal_text) values ( 'gsteuhlmeyer2n', 'mdelacey2n@cam.ac.uk', 'GQXNhyDljvS', 'https://robohash.org/sapientenecessitatibuseos.png?size=50x50&set=set1', 'eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient');
insert into users (username, email, password, profile_picture, personal_text) values ( 'acouper2o', 'bcurwood2o@example.com', 'PZnF1QTL', 'storage/images/default-user.jpg', null);
insert into users (username, email, password, profile_picture, personal_text) values ( 'htrevett2p', 'jhallybone2p@harvard.edu', 'JSsxNNac', 'https://robohash.org/quidistinctiosit.png?size=50x50&set=set1', 'magna vestibulum aliquet ultrices erat tortor sollicitudin mi');
insert into users (username, email, password, profile_picture, personal_text) values ( 'plinnock2q', 'tbetz2q@umn.edu', 'lCLaNotiy', 'https://robohash.org/sintsintvoluptatem.png?size=50x50&set=set1', 'id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo');
insert into users (username, email, password, profile_picture, personal_text) values ('mcommings2r', 'bsmithyman2r@spiegel.de', 'Uad8SHcY4', 'https://robohash.org/animicumquenam.png?size=50x50&set=set1', 'sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis');

insert into administrator (id_admin) values (96);
insert into administrator (id_admin) values (1);
insert into administrator (id_admin) values (53);

insert into moderator (id_moderator) values (18);
insert into moderator (id_moderator) values (93);
insert into moderator (id_moderator) values (10);
insert into moderator (id_moderator) values (8);
insert into moderator (id_moderator) values (92);
insert into moderator (id_moderator) values (67);
insert into moderator (id_moderator) values (81);


--Questions
insert into post (id_author, date, text_body) values (2, '2022-11-09 12:05:12', 'I am developing a program from another program (a fork) under GPLv3. I know that if "my" program is used commercially or just distributed (as opposed to just personal use) it should keep the same license.

I don''t understand from the GPLv3 license terms, whether this program which would be available open source, can be used as a piece inside proprietary software or not.

Can someone let me know and maybe tell which part of the license states this?');
insert into post (id_author, date, text_body) values (5, '2022-10-11 09:48:14', 'In two works of fiction I read or saw, a person was convicted for murder when the victim was actually alive. (In one case, not quite alive - police take finger prints of an unknown 30 year old woman, freshly murdered, and finds that they match a 16 year old girl supposedly murdered 14 years before, with her father in jail for the murder.)

Now while this makes for an interesting story, have there been any real cases where this happened where A was convicted of murdering B, then later it is shown that B was well and alive long enough that A couldn''t have been guilty? In addition to no evidence suggesting that A murdered someone else?');
insert into post (id_author, date, text_body) values (7, '2022-10-16 19:28:21', 'It is a common practice that opposing parties communicate via their lawyers rather than the parties communicating directly to each other.

Besides saving the parties'' time, what are the benefits and what are the drawbacks associated with this practice?

Does it happen that the opposing parties would be unable to come to a settlement directly, but would be able to have that conversation between lawyers?');
insert into post (id_author, date, text_body) values (3, '2022-10-07 06:46:45', 'Rob has created some illegal copies (violating the copyright) and is (illegally) selling them.

Bob likes the content, and, unable to find any legal copies of the same content, buys from Rob.

I get it that the contract is null and void.

However, Bob, knowing all the above, still completes the transaction and enjoys the content. Does he commit any offense that can be punished?

Jurisdiction: anywhere you can answer about.');
--5
insert into post (id_author, date, text_body) values (3, '2022-10-03 12:15:19', 'Will a termination by convenience clause always be honored by the court, if it is used in a manner that is completely unethical? Eg. can a company terminate an account that just bought an expensive subscription without refunding said subscription?

Edit: can someone actually tell me whether this runs afoul of a tenet of contract law?');
insert into post (id_author, date, text_body) values (9, '2022-10-15 02:52:08', 'Say there''s a clause (art. 14) that creates an obligation for party A, from which an obligation for party B follows. Say it looks like this:

art.14. Every year, no later than six months after the end of that calendar year, Party A will provide Party B with a section-by-section overview of the costs for service A.

art.15. What appears from the overview, taking into account advance payments made by Party B to Party A, whether Party A has been paid in advance too little by Party B or Party B paid in advance too much to Party A, must be paid or repaid within one month after the overview has been provided to Party B.

These articles happen to be in a General terms and conditions document that is part of the contract, through an article in the contract that says that the general terms and conditions are part of the contract.

Party B happens to have been negligent and considered the advance payments as flat rate for the service. This understanding came to Party B partly because, according to Party B, that is how the agreement was presented by Party A, contrary to the letter of the agreement. This understanding comes also partly from previous clients of Party A, who also considered the fixed monthly payments as flat rates that do not need settlement. These clients used the service for years, stopped using it, and never received an overview for settlement according to art.14.

For more than 5 years, party A ignores their obligation regarding art.14. and never mentions it. Party B does not try to enforce art.14, because, in their mind, such an article was never part of the agreement.

In the second half of the 6th year, Party A tries to enforce art.14, by providing an overview for settlements over the previous 2 years going backwards from the moment of submitting the overview.

Considering that:

Party A demonstrated a history of not fulfilling their obligations according to art. 14 in relation with Party B, but also in relation with other Parties with whom it had similar agreements.
Party A never mentioned article 14 from the general terms and conditions at signing.
Party B never objected to Party A not fulfilling their obligations.
I would argue that there was an implied in fact agreement that the advance payments are fixed flat rates for service A, because both parties met in mind and abided by this agreement through their actions, i.e. Party A never submitted an overview, and Party B always paid the advance payments in time.

This implied in fact agreement of parties goes in conflict with art.14. Provided that the implied in fact agreement stands legal scrutiny, and considering that meeting of minds must have happened after the signing of the written agreement, the implied in fact agreement is newer, thus supersedes art.14 of the written agreement.

For what is worth, the situation stems from a rental agreement in the Netherlands, so EU/Dutch law applies to the original case. Nevertheless for the purpose of this question, I am interested in what principles of law apply, especially from civil law, but I am also curious of an interpretation according to common law.

I am not a legal expert, but I am familiar with some principles of laws. The above is a working example, but my general question is whether a clause in a written contract is valid and enforceable, if all parties took regular actions contrary to the clause for a very long time without any dispute. An analogy to the above situation would be a written agreement of parties that monthly, 10$ would be exchanged for a selfie, for a period of 20 years. Then 19 years pass and nobody ever sent a selfie, or 10$ in exchange, or took any action with respect to that agreement, but one party starts sending selfies (many years later) and asks for their rightful 10$. In my mind, that''s just crazy, but then again, I''m not a lawyer. What do the experts think?');
insert into post (id_author, date, text_body) values (1, '2022-11-21 18:00:19', 'The reason I ask is this. My father was bicycling when he crossed in front of traffic and was struck by someone driving a vehicle, and unfortunately, he died shortly after. I won’t go through all the evidence, but I happen to know what was almost certainly the cause of my father crossing in front of traffic like this. He had a vision problem with the peripheral vision in his left eye.

So with that said, I keep thinking about the person who hit him and how that must have made them feel. I wasn’t present at the scene but an officer who was there told me that they were cooperative with the police and there was no evidence that they did anything wrong. But what I keep thinking about is that I know from talking to others who have accidentally killed someone how that scene keeps replaying in their head and I’m sure it bothers him a lot.

I want to call this person, tell them who I am, and let them know that I and the rest of the family aren’t angry at him, that it wasn’t his fault, and tell him the thing about my dad’s eye, in hopes that that information will help him recover from the shock.

Is it legally problematic to reach out to him, considering that I got his name from a police report? Or problematic for a different reason?

If it makes a difference, this is in Tennessee, USA.');
insert into post (id_author, date, text_body) values (5, '2022-11-18 01:43:52', 'Suppose there is a law saying it is illegal to XYZ between 10 PM and 6 AM. If Alice XYZs at 11 PM, she cannot use "I didn''t know about the law" as a defense. What if she does know about the law, but her watch (due to something she could not have known about or prevented) incorrectly shows that it is 9 PM, and she has no reason to doubt it''s accuracy and has no other way to determine the time? Is the fact that she knew about the law and could not have reasonably known she was violating it a defense?');
insert into post (id_author, date, text_body) values (7, '2022-10-02 09:39:02', 'I don''t understand the current economic situation. The savings rate is at a long-time low. Something like 30% of Americans failed to pay mortgage or rent in June, inflation is signficantly increasing the real cost of living, yet 90% of advertised jobs are going unfilled! It''s like every metric of worker survivability is declining, yet they still refuse to work! What the heck? As an employer I have run many ads for workers and the resumes I get are either non-existent or they just keep getting worse. I thought the applicants I got last year were bad, but the paltry few I get now are just pathetic, and I offer very high salaries, like $120k+ benefits for semi-skilled labor. I hear that unskilled jobs pay only $20 per hour and it is unfathomable to me how they get even a single high quality applicant with pay like that. In fact, a lot of the clerks I have been seeing in stores recently are people with obvious personal issues.

A year ago I know there were all these federal payments and unemployment compensation extensions that were supposedly allowing US workers to sit home and entertain themselves, but my understanding is that these handouts have more or less ended. And anyway how far can $3,000 go anyway? I mean you can''t survive for months and months on a couple of $3,000 checks.

I have heard rumors that the new mentality is ''don''t work, just go live in your parent''s basement''. So, I guess according to this theory workers are just "slumming it" and trying to figure out how to get by on the absolute minimum, to hell with standard of living. So, that is one possible explanation.

So, from an economic theory perspective (I am not an economist) what is the explanation for this phenomenon of the vanishing American worker?');
--10
insert into post (id_author, date, text_body) values (56, '2022-11-13 07:45:49', 'In a quote in this report in the Daily Express Jacob Rees-Mogg asserts that:

Cutting corporation tax from 28 percent down to 19 percent led to about a 50 percent increase in corporation tax revenues and an increase in corporation tax as a percentage of GDP.

Is this true? Was corporation tax reduced like this, and did it lead to such an increase in revenue?');
insert into post (id_author, date, text_body) values (29, '2022-10-29 09:11:49', 'Is it true that "Companies with diverse workforces outperform those with homogenous teams"? That''s what TrendsWatching says anyway. And is it "diverse workforce" or "workforce comprising people from a variety of backgrounds"? I don''t immediately see what racial diversity per ce may have to do with performance. TrendsWatching references this report');
insert into post (id_author, date, text_body) values (91, '2022-11-04 19:58:15', 'I recently heard on a video that when the value of the currency of an economy rises, it is less desirable to trade with that economy. I couldn''t understand it.');
insert into post (id_author, date, text_body) values (86, '2022-10-04 17:00:02', 'In the short run, It might affect the employment rate of developed countries. But it will boost the employment rate in the Long run, why?');
insert into post (id_author, date, text_body) values (18, '2022-10-10 00:45:39', 'I am aware that Monte-Carlo Simulation is used for making accurate assumptions by introducing randomness. But can it be used to synthesize or create a dataset? If yes, can someone share an example?');

--15
insert into post (id_author, date, text_body) values (57, '2022-10-18 10:01:21', 'I am new to studying Economics and am at a loss of intuition to understand the difference between the Classical and Keynesian systems.

The following is my understanding of the two theories:

The Classical theorists came up with the implicit theory of aggregate demand where they believed that interest rate will ensure that changes in autonomous components of demand (C, I or G) are offset against one another. For instance, if I increases, interest rate will increase and consumption will go down by exactly the same amount by which I increases in the end once the market equilibrates (because the reduced consumption will now become the savings to feed the requisite increase in I) . The Keynesians, on the other hand, proclaim that when I increases, it will lead to an "income-induced" increase in C and in totality, the total income Y will change. Interest rates will still increase in the Keynesian world, because with increases in Y, the speculative demand for money has to change (and interest rate (r have to go up) to ensure money market equilibrium.

These two approaches seem to be coming to very different conclusions. The former says that whatever happens, r will ensure that Y remains constant, while the other one says that increases in autonomous factors such as I will not be offset by increase in r and the total Y will go up. I guess that this is happening because Keynesian theorists believe that demand for money also depends on interest rate r as against Classical practitioners who believed that money demand only depended on Y.

However, I believe that there is still something that I am missing. I am trying to find the one thing that will explain the key difference between the two approaches. Can anyone please help me understand that key difference between the two theories which allows for complete offsetting of C, I and G against one another due to r in one but not the other?

EDIT: I just finished studying the IS-LM Model and the following is my understanding: When one of the factors, say G increases, as per the simple Keynesian system, Y should have gone up by G∗1/(1−b), but that doesn''t happen because as Y changes, interest rate changes (due to increase in transactional money demand). This change in interest rate will reduce I but at the same time, due to increases in r, the speculative demand for money would decrease. All in all, the change in Y would be somewhat less than G∗1/(1−b). In Classical model, there is no room for speculative demand and hence there is only one value of Y where money demand can equate money supply and hence everything has to offset to come at that level. Is my understanding correct?');
insert into post (id_author, date, text_body) values (62, '2022-10-10 20:37:58', 'I found this useful website over here that shows interesting information on income related statistics in Canada (2016) for each postal code:

https://www12.statcan.gc.ca/census-recensement/2016/dp-pd/prof/details/page.cfm?Lang=E&Geo1=FSA&Code1=V5Y&Geo2=PR&Code2=01&Data=Count&SearchText=V5Y&SearchType=Begins&SearchPR=01&B1=All

As an example, I wanted to see what percentage of people within this area of Vancouver (V5Y) have a mortgage (e.g. Ctrl + F = " Total - Owner households in non-farm, non-reserve private dwellings - 25% sample data ").

Based on this information - it appears that in this area of Vancouver, 57.6 % of people have a mortgage.

I had the following question about this:

It says that this number is based on " 25% sample data."

So does this mean that they took a random sample of 25% of all homeowners in this area - and 57.6% of this random sample reported to have a mortgage?

Can someone please confirm this?

Thanks!');
insert into post (id_author, date, text_body) values (77, '2022-10-31 16:50:50', 'I am really confused on how to classify low fees government nursing home services that are provided to elderly people. Is it public good or private good or quasi-public? My reasoning is that it is a private good. It is because even though it provides low fees it excludes some poor elderly people who cannot afford it. However, I really don''t know how much rival it really is. If uncongested, I don''t think it is rival, as someone''s already admission into nursing houses doesn''t reduce the quality of care I receive if get admitted to such houses. However, under congested conditions, the quality of health care received reduces significantly and hence becomes rival. So since it lies somewhere between public and private, shall we call it quasi-public? What is the line for defining a quasi-public good? Can someone explain me with examples.');
insert into post (id_author, date, text_body) values (74, '2022-11-15 04:31:29', 'In some country, the currency is called "dollars". There are 100 trillion (100T) total dollars in existence. People trade these dollars for goods and services.

A new fintech startup comes along and prints a bunch of paper notes saying "rallods." There are 100T total rallods in existence. The founder somehow generates a lot of hype and people start trading rallods for goods and services, at a rate of 2 rallods = 1 dollar. This rate never changes, as the trade between rallods and dollars is exactly balanced.

What is now the money supply in this country? Is it still 100T dollars, or is it 150T dollars = 300T rallods?

I expect that the economy will set prices similar to the scenario where there are 150T dollars and no rallods, or 300T rallods and no dollars. If not, please explain why.');
insert into post (id_author, date, text_body) values (27, '2022-09-02 15:09:08', 'I''m looking for examples of governments where top officials have declared that their approach to COVID was incorrect in hindsight. Couple of hypothetical examples:

Swedish officials saying that their (relatively speaking) laissez faire approach was incorrect and they should''ve locked down hard in March 2020
Italian officials saying that their hardcore lockdowns in March 2020 were a mistake and they should''ve followed Sweden''s lead instead
An ideal answer would include links to official reports by governmental organizations rather than one-off statements by politicians.');
--20
insert into post (id_author, date, text_body) values (4, '2022-10-13 23:34:45', 'Many countries have special laws regarding inheritance taxes. Why would this be treated separately when it could just be taxed equally to all other income?

Suppose Eve normally earns €50,000 per year. Due to an inheritance, one year, Eve earns €150,000. Why do we need an inheritance tax — one could just tax an income of €150,000?

We might want to tax income one has worked for less than income one has not worked for, but this could be organised by declaring both income from labour and total income separately. However, it seems rather that in some countries, inheritance income one hasn''t worked for is taxed less than income from labour. I don''t see how that makes sense. Eve is not a charity.

There is a related question, What ethical (if any) or economical arguments are offered in defense of the inheritance tax?, but that one is sort of the other way around, because the asker seems to imply that inheritances should be taxed less than income from labour. If there is no inheritance tax (Wikipedia lists various countries that have abolished them) it should be just taxed like all other income, I suppose.');
insert into post (id_author, date, text_body) values (99, '2022-10-18 11:26:25', 'I''m an Iranian and I''ve been confronted with sites now and then where I can''t get my number registered or I won''t be allowed to even view the page where my IP address is detected to be from Iran and so on.

samples are:

https://twitter.com/settings/add_phone (not listing Iran)
https://developers.google.com/ (not letting to view the page)
http://www.oracle.com/ (not letting to view the whole site)
well, I know the US is not in good terms with my country at the moment; but I don''t see why some sites would decide to stop users from Iran and some wouldn''t?

And I like to know if there is any specific law in the US enforcing these acts or it''s the policy of these sites that are different from other companies in the US?
');
insert into post (id_author, date, text_body) values (52, '2022-11-14 14:01:08', 'Inspired by the following paragraph from this article.

Singapore — one of only 11 countries in the world with the coveted AAA sovereign rating — is also in a league of its own. For starters, it does not have any net government debt. This is because there are laws that prevent its government from spending more than what it earns annually unless there are extraordinary circumstances, such as the Covid-19 pandemic. The prudence in financial management has allowed the accumulation of sizeable reserves, on top of what is reported by its central bank, which uses currency strength to hedge against inflation.

The little debt service charges (less than 0.5% of revenue in 2020) Singapore incurs are more than made up for by its investment returns, which make up around one-fifth of its government’s annual income, giving the city state flexibility to remain a low-tax regime.

Singapore is able to lower taxes because their investments are sufficient to provide 20% of the government''s revenue. But if one can get 20% of revenue from investments, then it also might be possible to get 100% of the government budget from investments. At that point, one would not need taxes anymore.

Is hitting 100% of revenue from investments actually possible? If yes, has any country ever managed or is attempting to hit that benchmark? If it is not possible, why not?');
insert into post (id_author, date, text_body) values (61, '2022-10-04 10:26:48', 'Due to rapid development and spread of social networks, politicians among other public figures were forced into also using them to communicate various things (e.g. Trump''s Facebook account, Trumps Twitter account)

Question: do posts made on these networks have the same power as public declarations made using more classic channels such as TV broadcasted press conferences?

I mean do they generate the same reaction? e.g. diplomats ask for clarifications when an important politician makes inappropriate allegations about some aspects of his/her country. Or some messages are simply ignored if not made using a classic way of communication (e.g. posted as official announcements or documents on Government''s web site, TV broadcasted).

I will try to clarify the question by providing an example. Trump has posted the following message on his Twitter account:

The U.S. has been talking to North Korea, and paying them extortion money, for 25 years. Talking is not the answer!

This is clearly related to North Korea, and its relations with US. Does this kind of post/message creates the same effect as if it was said during a press conference, a summit? Or these messages are seen as less serious if a social network in used as a channel?');
insert into post (id_author, date, text_body) values (42, '2022-10-11 01:44:44', 'The German Bundesrat contains representatives of the governments of each of the 16 Bundesländer (states). Certain laws from the federal government also need to pass a vote of the Bundesrat. Each state has a couple of vote (roughly depending on population) and most are governed by a coalition of multiple parties. However, the Grundgesetz (essentially the German constitution) says each state has to vote uniformly. The government of the state needs to agree amongst itself which way to vote. There is also no possibility to abstain as this would be equivalent to a no vote. The official website explains how this works (in German).

There was recently a major vote on the Bürgergeld proposed by the federal goverment (a coalition of the SPD, the Greens and the FDP) and opposed by the CDU. In the Bundesrat all states where the CDU is part of the government voted no so the law was rejected. However, with the exception of Bavaria, in every single state where the CDU is part of the government at least one of SPD, Greens or FDP is also part of the government (see here).

In my understanding of the rules, in each of these states if the CDU insists on a No vote, the SPD, Greens or FDP insist on a Yes vote, they could both vote that way making the vote of that state invalid. This would lead to 30 yes votes from states without the CDU in the government, 6 no votes from Bavaria and 33 invalid votes.

Question 1: Would the law pass in this scenario?

Question 2: Are there historical precedents where some states voted invalid in the Bundesrat and this allowed the passage of a law against the wishes of one political party?');
--25
insert into post (id_author, date, text_body) values (77, '2022-10-03 11:52:53', 'Alice and Bob are two students who are habitual cheaters.

Alice to Bob: You really should stop cheating on your exams.

Bob to Alice: I''ll stop cheating if you stop cheating too.

Does the hypothetical argument above fall under whataboutism? It seems borderline to me. In this argument, Bob doesn''t deny that Alice is right, but they refuse to stop cheating with a rationale that indirectly criticizes Alice for hypocrisy. The latter seems like a hallmark of whataboutism.

Related: Why is "Whataboutism" often criticized? and How can I respond to Whataboutism?');
insert into post (id_author, date, text_body) values (93, '2022-11-20 19:36:55', 'Government employees'' salaries are paid for by taxes levied by the government on the labour income of employees among other. Why do governments not simply pay their own employees tax-free salaries?

I appreciate that taxing government employees has redistributive implications between different levels of governments. In practice it often means that local governments need to pay their employees higher gross salaries, which are then taxed by higher levels of government. But I doubt that this form of redistribution is the reason why government employees'' income would be taxed in the first place.');
insert into post (id_author, date, text_body) values (41, '2022-11-12 22:01:25', 'For example, if Donald Trump lost a primary in 2024, he could still run for president. If so, he might theoretically want to appeal to Republican voters by claiming to be "the real republican candidate" and accusing the official candidate of being a "RINO." What limitations would he face in executing such a campaign? Can a candidate run as a party X candidate without an official endorsement from the party? Are there any historical examples of this sort of thing?');
insert into post (id_author, date, text_body) values (68, '2022-10-17 20:54:17', 'Persevering client-driven support');
insert into post (id_author, date, text_body) values (32, '2022-10-06 13:27:36', 'Adaptive reciprocal hardware');
insert into post (id_author, date, text_body) values (85, '2022-10-15 23:10:35', 'Mandatory client-server matrices');
insert into post (id_author, date, text_body) values (60, '2022-10-12 23:38:42', 'Ergonomic discrete frame');
insert into post (id_author, date, text_body) values (46, '2022-10-16 05:02:01', 'De-engineered 6th generation software');
insert into post (id_author, date, text_body) values (96, '2022-10-09 20:39:54', 'Digitized executive core');
insert into post (id_author, date, text_body) values (52, '2022-10-10 23:45:42', 'Multi-lateral coherent pricing structure');
insert into post (id_author, date, text_body) values (59, '2022-10-05 18:08:08', 'Mandatory solution-oriented model');
insert into post (id_author, date, text_body) values (32, '2022-10-04 13:48:48', 'Devolved responsive capability');
insert into post (id_author, date, text_body) values (86, '2022-10-13 18:36:06', 'Polarised full-range ability');
insert into post (id_author, date, text_body) values (53, '2022-10-18 14:36:03', 'Synergistic attitude-oriented paradigm');
insert into post (id_author, date, text_body) values (58, '2022-10-01 06:03:31', 'Re-contextualized explicit middleware');
insert into post (id_author, date, text_body) values (57, '2022-10-15 19:33:49', 'Synergistic didactic knowledge base');
insert into post (id_author, date, text_body) values (95, '2022-10-14 14:30:14', 'Synergistic client-server core');
insert into post (id_author, date, text_body) values (85, '2022-10-18 16:06:37', 'User-centric intangible implementation');
insert into post (id_author, date, text_body) values (78, '2022-10-08 17:13:47', 'Total multi-state process improvement');
insert into post (id_author, date, text_body) values (99, '2022-10-09 05:11:52', 'Virtual 4th generation adapter');
insert into post (id_author, date, text_body) values (53, '2022-10-02 14:29:08', 'Quality-focused static intranet');
insert into post (id_author, date, text_body) values (89, '2022-10-06 10:29:34', 'Monitored content-based application');
insert into post (id_author, date, text_body) values (51, '2022-10-05 15:47:12', 'Profit-focused scalable budgetary management');
insert into post (id_author, date, text_body) values (38, '2022-10-14 12:56:29', 'Object-based multi-state access');
insert into post (id_author, date, text_body) values (81, '2022-10-17 10:37:43', 'Balanced system-worthy framework');
insert into post (id_author, date, text_body) values (81, '2022-10-13 22:45:07', 'Visionary object-oriented architecture');



--Answers
-- insert into post (id_author, date, text_body) values (62, '2022-11-17 03:30:07', 'Triple-buffered hybrid hierarchy');
insert into post (id_author, date, text_body) values (62, '2022-11-16 03:30:07', 'If proprietary software contains GPL-licensed software then the same rules apply. Whether it''s 99% GPL-licensed with 1% changes, or 99% proprietary with 1% GPL-licensed code added, makes no legal difference.');
insert into post (id_author, date, text_body) values (41, '2022-10-13 11:12:59', 'There was a quite famous case in Spain in 1910, the Crime of Cuenca.

A man disappeared from a village, and an investigation didn''t find anything. A couple of years later popular pressure lead to the investigation being reopened and two suspects being interrogated until they confessed under torture. 16 years after the alleged murder, the victim showed up alive in the village and it was discovered that he had gone away voluntarily and lived since then in a town 100 km away.

By then the accused were already free after 12 years in prison but the sentence were eventually overturned. Those held responsible of justice miscarriage were tried but finally acquitted.

');
insert into post (id_author, date, text_body) values (56, '2022-11-01 19:18:58', 'There is the case of Natasha Ryan. She was simply given a fine for instigating an investigation into her false murder.');
insert into post (id_author, date, text_body) values (71, '2022-11-03 17:41:21', 'Just using an objective intermediary can produce settlements that parties can''t reach in direct confrontation. That''s why mediation is a popular tool for resolving conflicts.

Using lawyers as mediators has some added benefits:

Lawyers know the law and rules of litigation better than laymen and so they can tell their clients what the range of possible outcomes are, and when communicating with opposing counsel they both know what is realistic.
Lawyers are (at least in principle) forbidden to lie in the course of their professional conduct.
I.e., using lawyers should reduce the amount of gaming involved in resolving a conflict.

And if that''s not reason enough to get opposing lawyers speaking directly: Rules of litigation require opposing counsel to "meet and confer" regarding many procedural issues.

A typical example is CCP §2023.010 which requires the court to sanction a party for "Failing to confer in person, by telephone, or by letter with an opposing party or attorney in a reasonable and good faith attempt to resolve informally any dispute concerning discovery."

The judicial system thinks it''s always a good idea for opposing lawyers to speak directly because it can only reduce the burden on the public courts. Lawyers are officers of the courts to which they have been admitted to practice, and so while their primary duty is to their clients, they also have an obligation to uphold the law and avoid misusing the courts. Here''s an essay published by the ABA that further explains, "cooperation represents the shortest, fastest, and least costly path to what the rules, as applied, ultimately would require the parties to do anyway."

From the perspective of the client, the only drawback to conference that I can think of is the theoretical risk that one lawyer will unnecessarily divulge some piece of information that the other party can exploit to its advantage. Such a mistake would be grounds for a malpractice claim against the lawyer who committed it. And if it is brought to the attention of a court overseeing the process then the court may take steps to mitigate the damage to the party so disadvantaged. A common example is in criminal law where a judge will prohibit improper statements or evidence from being exposed to the jury.');
insert into post (id_author, date, text_body) values (25, '2022-10-18 08:18:55', 'I''m guessing the answer is that the lawyers would tell you yes, but in fact is not necessarily the case that lay people can''t settle among themselves. The one hypothetical benefit would be that they could communicate in a savvy way so as to not sabotage prospects of advantages at trial. But in my experience, many professional lawyers aren''t always the best strategists anyway, and they often don''t consider one''s interests holistically, even in just the different legal facets of the situation, much less its non legal aspects.

However, certain things like the civil practice direction on pre action conduct are specified in civil procedure rules and one can be penalised for not following it properly later on if you and the other party fail to settle. In this sense it can be rather helpful to have a lawyer who is familiar with all these rules.');
insert into post (id_author, date, text_body) values (35, '2022-10-12 04:50:45', 'In canada, Bob has committed no offence unless:

Bob copies the material in order to receive it (for example, downloading it from the internet); this would be copyright infringement
Bob circumvents a technological protection measure in order to use the material; this is prohibited at s. 41.1 of the Copyright Act
Bob further sells, rents, or distributes the material; this is secondary infringment, defined at s. 27(2) of the Copyright Act
the copied material is money; this would violate s. 450 of the Criminal Code
In the circumstance where the copy that will become Bob''s is not money, has already been made, unincumbered by any technological protection measure (for example, a book, or cassette, or sculpture), and where Bob acquires it for purely personal use, then Bob is not committing any offence in Canadian law.');
insert into post (id_author, date, text_body) values (27, '2022-10-09 06:12:59', 'In the US, Bob has probably not even committed copyright infringement. However, if Bob, knowing that the copy (or copies) were infringing, distributes them (or it) to others, or makes additional copies, (or does other acts of infringement) then Bob has committed infringement. But this is usually only grounds for a civil suit, which could result in civil damages. It is not normally treated as a crime, even whgen it technically could be.');
insert into post (id_author, date, text_body) values (52, '2022-10-13 12:22:54', 'In general, one party may cancel a contract for any reason which is provided for in the contract, and does not violate any current law. However, if such a contract is brought before a court which includes equity jurisdiction (as most common law courts now do), the court might well object to the terminating party obtainign an unjust enrichment as by collecting the prove for a service, but never providing th service nor a refund. Such a court might well order a refund of the unearned price, unless some other factor justified the termination.

Additionally, if the transaction is considered a consumer transaction under local law, consumer protection laws may regulate the transaction, and prohibit a cancellation without refund. The scope and provisions of such laws vary widely between jurisdictions, so one might or might not apply in any particular ase..');
insert into post (id_author, date, text_body) values (22, '2022-10-11 06:56:52', 'Nor is it the same in every jurisdiction - I will focus on australia.

The central tenant of contract law is that the parties are free to agree anything that is legal irrespective of whether this leads to what may seem to be a harsh or unjust outcome to an outside observer (or the parties themselves). At common law, harsh and unjust terms are legal - only unconscionability attracts legal protection. However, see below.

The parties have an obligation to follow the terms of the contract in a way that gives effect to the purpose of the contract and to not act in bad faith - there is no obligation to act in good faith. Notwithstanding, a party that scrupulously follows the terms of a contract cannot be acting in bad faith - they are doing what they agreed to do.

That said, most “termination for convenience” clauses are, by their nature, discretionary. Where a party has a discretionary power under a contract they must exercise it reasonably. This doesn''t mean that they can''t exercise the power if it causes damage to the other party but, if it does, then that is a factor in whether the action was reasonable.

If the action was reasonable then only rights and obligations up to the date of termination are enforceable at common law. So, in your circumstance the customer is not entitled to a refund.

However, ...
Many contracts are not made purely at common law and statute law has knocked some of the harsh edges off.

For example, this contract may be subject to Australian Consumer Law (ACL).

For the purposes of the ACL, a person is a ''consumer'' if they acquire goods or services that are priced at less than $40,000. A person is also a ''consumer'' if they acquire good or services that are priced at more than $40,000 but they are ''of a kind ordinarily acquired for personal, domestic or household use or consumption''.

If your “expensive subscription” is less than $40,000 then ACL applies and you are entitled to a refund for the services not provided.

Further, if the vendor engaged in “misleading or deceptive conduct” (irrespective of if you are a consumer) then the contract can be set aside and you get your money back.

If the contract is a “consumer contract” (which includes most “take it or leave it” contracts with individuals and small and medium enterprises) then a term is unlawful if it is unfair rather than unconscionable.');

--60
insert into post (id_author, date, text_body) values (69, '2022-10-17 15:04:30', 'No, that is very unlikely. Not only it would have to be allowed by the terms of the contract, but the clause itself might contravene consumer protection laws insofar as it has all the appearance of an unfair and deceptive practice.

can someone actually tell me whether this runs afoul of a tenet of contract law?

Contract law is premised on the covenant of good faith and fair dealing, and also on the principle that clauses are entered by the parties knowingly and willfully.

If the terms of the clause reasonably inform the customer about provider''s arbitrariness, the contract itself meets the premise(s) of contract law. But, as said above, that agreement won''t necessarily survive the enacted laws on consumer protection.

By contrast, if the customer is not duly informed, then the provider would incur breach of contract (and thus be in violation of contract law), fraud, unjust enrichment, and similar/related torts.');
insert into post (id_author, date, text_body) values (43, '2022-10-15 07:51:55', 'It''s not possible to have a contract with a termination at convenience clause. A contract requires consideration from both parties. If one party can terminate the arrangement at any time without having fulfilled any obligations, then they don''t have any obligations towards you, so it''s not a contract. It''s just you giving money to the company as a gift, and the company might do something in return. Note that a contract can allow for termination after exchange of consideration (for instance, in a lease, after one party has paid rent for some months, and the other party has provided a dwelling for some months, the contract can be terminated), but if an agreement allows one party to unilaterally cancel without having provided any consideration at all, it''s not a contract.');
insert into post (id_author, date, text_body) values (34, '2022-10-17 16:04:36', 'Party A had an obligation that it did not fulfil, providing the section-by-section overview of the costs.

To the extent that Party B suffered damage from each breach, for example, because Party A owes a refund, Party B can recover that plus interest subject to any statute of limitations on actions for contract breach. To the extent that Party A suffered damage, tough - they don’t get to benefit from their own breach.

Party A might wish to argue that Party B has waived their right to adjust the payment but this would be difficult to prove. It doesn’t appear that there is an explicit waiver but neither is their an implied waiver: Party A would need to show that Party B was aware of and condoned the breach in some way.

You are right that a contract can be altered after it is entered into and that such a change can be implicit rather than explicit. But that would require showing some action rather than inaction by the parties to effect a different arrangement. In practice, where one party affirms the written contract, without clear and compelling evidence that the contract has subsequently been changed, the written contract will prevail.

For an example, Yale University periodically collects the interest due on a perpetual bond originally issued by the Dutch water board Lekdijk Bovendams on 15 May 1624. Originally issued with a principal of "1000 silver Carolus gulders of 20 Stuivers a piece", as of 2004 the yearly interest payment to the bondholder is set at €11.35 (15€ as of 2018 = 16$). According to its original terms, the bond would pay 5% interest in perpetuity, although the interest rate was reduced to 3.5% and then 2.5% during the 18th century. Providing it is physically presented to the successors of the board (the Dutch Water Authority) interest must be paid even if it has been many decades singe the last payment. Of course, practically, crossing the Atlantic to collect 15€ every year is not commercially viable so the do it every decade or so and then, only for the historical value. So long as the Netherlands continues to exist as a legal entity, this obligation will continue.');
insert into post (id_author, date, text_body) values (34, '2022-10-16 12:09:09', 'Yes, the clause remains valid. But only breaches where the statute of limitations has not expired are actionable.

A party''s waiver of his entitlement pursuant to specific breaches of contract --or a pattern of breaches-- does not eliminate the explicit clause on which that entitlement is premised. There is a difference between (1) the intended elimination of a clause, and (2) a party''s waiver of an explicit right that is intended to subsist.

Some explicit contracts establish that any amendments have to be in writing and signed by the parties, or otherwise memorialized. However, that type of clauses is largely redundant because the aforementioned difference is cognizable also in contracts that have no such clause. The clause is also pointless insofar as the parties are entitled to systematically waive their rights anyway (i.e., by never enforcing them).

In the scenario you describe, party A''s waiver --whether apparent or official-- of art. 14 with respect to any similar contracts elsewhere is irrelevant to its explicit contract with party B. The written contract supersedes common practice. See Restatement (Second) of Contracts at §203(b) ("express terms are given greater weight than course of performance").

Nor does party A need to remind party B about art. 14 when signing. Party B knows or is expected to know and understand the contents of the contract it signs. Since art. 14 is in the General Terms and Conditions, the "article in the contract that says that the general terms and conditions are part of the contract" further weakens party B''s allegation that party A did not mention art. 14.

Party B''s silence regarding party A''s non-compliance with art. 14 helps toward lawful avoidance of art. 14 on those specific instances of non-compliance, but that does not alter the general validity of that provision.

That being said, party A''s actionability on art. 14 is limited to overviews that comply with the timing provided in that article: no later than six months after the end of the calendar year. Thus, party A''s failure to provide an overview during the first semester of a calendar year forfeits enforcement of art. 15 in regard only to that specific year.

Without knowing more about the contract at issue, it is reasonable to presume that art. 14 refers to costs pursuant to only the previous year. Costs that should have been billed in prior years are not to be included in the overview. Otherwise, art. 14 would be meaningless because all party A would have to do on belated costs is wait till new year. That would contravene an important principle formulated in Restatement (Second) of Contracts at §203(a): "[A]n interpretation which gives a[n] [...] effective meaning to all the terms is preferred to an interpretation which leaves a part [...] of no effect".

These principles apply to Dutch contract law as well as in common law jurisdictions. Dutch contract law has what is known as the Haviltex rule for superseding the literal wording of a contract. However, the scenario you describe gives no room for interpreting that art. 14 has been stricken from the contract. Party A simply did not enforce his right for a number of years.');
insert into post (id_author, date, text_body) values (57, '2022-11-10 01:11:19', 'The First Amendment protects your right to free speech. There is no exception for speech directed at people whose names the speaker finds in a police report.');
insert into post (id_author, date, text_body) values (46, '2022-11-19 21:59:06', 'It depends on what the mens rea requirement is.

Mens rea if not specified in a criminal offence
In Canada, if this is a criminal offence, and a mens rea is not specified in the Criminal Code, the presumption is that the mens rea would be satisfied by recklessness, knowledge, willful blindness, or intention (Pappajohn v. The Queen, [1980] 2 SCR 120; R. v. Briscoe, 2010 SCC 13). The prosecution would have to show that Alice was at least subjectively aware of the risk that she was doing XYZ during the prohibited hours and proceeded nonetheless (this is recklessness; Sansregret v. The Queen, [1985] 1 SCR 570 ). Based on the facts as you''ve presented in the hypothetical, you may have ruled out the possibility that Alice was reckless. Although, depending on the time of year, it may be that the sun sets around 9pm, which may present some awareness of the risk that you have not accounted for in your hypothetical.

Mens rea if specified
If the text of the statute does specify a mens rea then that is what the prosecution needs to show. For example, if one is prohibited from doing XYZ while "knowing" that it is after 9pm, then the prosecution will have to demonstrate actual subjective knowledge of the time, or wilful blindness (which Canadian law takes to impute knowledge: Briscoe).

Additional burdens to make use of some mistakes of fact
Some offences put an even higher burden on the accused in order to rely on a mistake of fact. In sexual offences where the age of the complainant is relevant (e.g. that they 14 or younger, or 16 or younger, or 18 or younger), the accused cannot make out a mistake-of-age defence without showing they took reasonable steps to ascertain the age (see Criminal Code, s. 150.1).1

Presumptive mens rea for regulatory offences is much lower: strict liability, subject to a due-diligence defence
However, if this were a public-welfare/regulatory offence, like a provincial traffic law, or a licensing restriction on an aviation licence, or municipal by-law, there is no mens rea presumption. Rather, public-welfare/regulatory offences prima facie fall into the category of strict liability offences, subject only to a due-diligence defence (R. v. Sault Ste. Marie, [1978] 2 SCR 1299). Alice would have to show that she had a "reasonable belief in facts which, if true, would have rendered the act innocent". What it means to have a "reasonable belief in facts" is very fact-specific.2 Alice has to hold the belief herself, and the trier of fact must accept that a reasonable person would also have held that belief. Just as in the case for recklessness, I can imagine that the timing of sunset might pose a problem for a due-diligence defence in your particular example.

Absolute liability
If the penalties for the offence do not include the risk of imprisonment, the offence can even be declared to be an absolute liability offence, in which due diligence is not even a defence (Re B.C. Motor Vehicle Act, [1985] 2 SCR 486).

1. For example, simply relying on a complainant''s "language and statements indicating that she could be 14 years of age or older did not constitute taking reasonable steps or all reasonable steps to ascertain her true age in all the circumstances, especially after being warned by her mother to stop all contact or she would call the police and stating that the complainant was way too young for him" (R. v. Dragos, 2012 ONCA 538).

2. For example, for the sale of alcohol, "when the individual clearly appears to be underage, ... a duly diligent permittee would require at least two more pieces of ID confirming that the person was not a minor, question the individual about the ID, then decide if it is reasonable to serve the individual alcohol versus the youthful appearance of the individual" (Citynski Hotels Ltd. v. Saskatchewan, 2003 SKQB 314).');
insert into post (id_author, date, text_body) values (87, '2022-11-20 20:00:56', 'In addition to Jen''s answer, I would like to add that the example used of Alice committing an illegal act as a result of ignorance of the facts pertaining to breaking a curfew is perhaps somewhat limited and discuss the notion of the "standard of knowledge" more generally. If you are asking about the question of the principle of "ignorantia juris non excusat" in general, as the title of your question suggests, then the concept of "ignorance of the facts" would vary heavily depending on circumstance owing to various legal and social reasons. Apologies if your question is specific to the facts of your example.

Jen has pointed out some standards that are used in various circumstances: subjective knowledge, actual subjective knowledge, reasonable effort to find out, strict and absolute liability. The last two don''t really relate to what an accused had in mind when doing something, but they are one of many concepts that we use to deal with the issue of knowledge. In strict liability, we simply say that the issue of knowledge is not so important.

The overarching principle is that the standard of "knowledge of the facts" used varies depending on the illegal act committed. In some cases, we are more ready to find someone as having knowledge and to charge them for a crime. In other cases, for various reasons, we are more hesitant in doing this and would not want to make the accused''s life so difficult. Which is why for some traffic accidents, as Jen mentioned, there is absolute liability; why for regulatory offences we impose strict liability subject to a due-diligence defence; and why in some criminal offences, the prosecution has the burden of proof in showing knowledge.

In Singapore, as a matter of drug deterrence among other reasons, drug traffickers are presumed to have knowledge of the fact that they were trafficking drugs on them (Zainal bin Hamad v Public Prosecutor). The burden of proof lies upon the accused to show that they did not have knowledge "of the facts". This has a significant practical effect, as many accused traffickers argue that they were given a package to traffic which they had no knowledge pertaining to. By reversing the burden of proof of knowledge, the prosecution has a much easier job in convicting an accused.

Apart from regulations and statutory laws, knowledge is also relevant in issues of civil and commercial law. In negligence, for example, a plaintiff needs to show that the defendant could have objectively foreseen that their negligent acts would result in harm (Caparo v Dickman). If a defendant misrepresents themselves to a plaintiff, he might not be liable if he did not know himself of the mistake (Solle v. Butcher), or he may be liable in negligence for not taking care to avoid negligent misstatements (Hedley Byrne).');
insert into post (id_author, date, text_body) values (92, '2022-11-13 23:14:02', 'The tax rate in US was cut from 28% to 19% over period of 7 years from 2010 to 2017 (HMS Treasury).

Regarding the corporate tax revenue being increased by 50% there is missing information to be able to answer the question. For example, over which years are we doing the comparison?

If we compare 2009 with 2018 (that is year before the process started and year after it ended) there was about 47.11%, which is close to 50%, increase in corporate tax revenues according to OECD. However, if you want to just compare change from the year 2017 then it was nowhere near 50%. The article you link does not really have enough detail to say over what period was this 50% increase supposed to happen, so it depends on you whether you want to go with charitable interpretation or not.

Regarding causality, that is whether the cut was itself causally link to the increase in revenue matters are more complicated. There is research that shows that cutting corporate taxes boosts economic growth and that in turn has to also boost tax revenue (e.g. see Cloyne et al. 2022). Nonetheless at the same time it would be stretch to claim that all changes in government revenue over period of 7 years come from this change to tax rates. There is no research that looks at this question and this particular policy, to my best knowledge, so it is not possible to answer that conclusively, but I think any reasonable economist would find it extremely implausible that the growth in UK corporate taxes can be attributed to this single cause and nothing else.');
insert into post (id_author, date, text_body) values (87, '2022-11-16 03:41:15', 'Does diversity lead to more productivity?

Some diversity enhances productivity some doesn''t. For example, age diversity Ilmakunnas & Ilmakunnas 2011), cultural diversity or knowledge/experience (Navon 2010) diversity among employees is related to increase in productivity.

On the other hand educational (Ilmakunnas & Ilmakunnas 2011) or linguistic diversity (Dale-Olsenab Finseraas 2021) is shown to negatively impact productivity.

These are some examples. A workforce diversity can be measured along plethora of multiple dimensions so no answer can look at every single possible dimension diversity.

I don''t immediately see what racial diversity per ce may have to do with performance.

The poster, nor the report to which you link, does talk about racial diversity. It talks about homogeneous vs heterogenous teams. A team composed of same racial group can be heterogenous (i.e. diverse) along some other dimension such as education or age. Underrepresented group is any group that is not proportionally represented in some area relative to their proportion in total population, so for example in some industries that can be women, or Hindu etc.

Team heterogeneity can be measured among myriads of different dimensions (some examples: age, sex, gender, sexual orientation, experience, skill set, education, culture, language, geographic, nationality, religion, ideology etc...).');
insert into post (id_author, date, text_body) values (88, '2022-11-19 17:32:27', 'According to Nancy Adler and Tony Byers, there is a big difference between living an inclusive diversity and just having a diverse workforce.

In general, if the team members are well intentioned, there is clear commitment by management, everyone is welcome to share their ideas, and there is a good balance of everyone''s interests, diverse teams bring so much more to the table, especially in creative jobs. (Repetitive and highly standardized jobs may have a slight advantage in mono-cultural teams because of less communication "friction").

During each project, teams will go through different phases. During the divergence phase, teams explore new ideas and innovative solutions. Diverse teams can develop more ideas, more diverse ideas, and they can include the perspectives of more different customer groups (access to new markets). More out-of-the-box thinking occurs and leads to more innovation.

During the ensuing convergence phase, teams will have to decide which ideas will make it into the final course of action. If not managed well, this phase may lead to some friction, misinterpretations, more disagreement, miscommunication and high stress levels. Diverse teams therefore should be allowed more time to find common ground initially.

If left unmanaged, the benefits of diverse teams can drain quickly. When team members feel their ideas are being ignored or the treatment and job opportunities are unfair, this will lead to resignation, disengagement, and a low identification with the organization. For the organization, this leads to low talent retention and missed opportunities. The daily humiliation sags like a heavy load, and it can get much worse. This is not an argument against diverse teams - it is an argument for the value of good leadership.

If managed well, diverse teams will outperform mono cultures.');
--70
insert into post (id_author, date, text_body) values (54, '2022-11-06 11:44:56', 'In 101 macro, there are two concepts regarding exchange rates:

Nominal exchange rate (e):
The exchange rate we all hear about (how many units of local currency you have to give up for one unit of foreign currency)

Real exchange rate (ϵ):
How many units of a local good you would give up by buying one unit of a foreign good.

It is easy to check that the formula is:

ϵ=e⋅P∗P,

where

P∗= price of the good in the foreign country,

P= local price if the good.

If the value of a foreign currency increases, then e increases. Keeping prices constant, ϵ increases proportionally.

This implies that buying a foreign good now has a higher opportunity cost in terms of the local goods you could rather buy. This would decrease demand of that foreign country’s goods.

Therefore, a revaluation of a country’s currency comes together with a decrease in its exports (X).

It would also generate an increase in its imports (I) as that country would perceive other countries’ goods as cheaper, meaning they would demand more of them.

The general effect of country’s currency revaluation is that their net exports (NX):

NX=X−I

go down.

');
insert into post (id_author, date, text_body) values (24, '2022-11-16 05:01:09', 'To buy something in a foreign country you first have to obtain the foreign currency. Generally speaking you can''t buy goods and services in US with euros and EU with dollars.

When currency in country X appreciates it is more expensive for foreigners to buy that currency (which they need to buy goods and services). So when currency appreciates foreigners will find it less desirable to trade with the country X because from their point of view everything suddenly becomes much more expensive).');
insert into post (id_author, date, text_body) values (37, '2022-11-05 12:12:45', 'The statement in that video is incorrect, or rather incomplete.

If the value of the currency of an economy rises it becomes less attractive to buy from this economy. Because it''s products are now more expensive for other countries/economies.

However on the flip side, if the value of the currency of this economy rises it''s more attractive to sell to them. Because the money/currency you receive for your products is more valuable now.');
insert into post (id_author, date, text_body) values (3, '2022-10-17 06:36:18', 'The library TensorFlow Probability is designed for this purpose. In fact, the first example currently at the web site involves the creation of synthetic data which is then used for a regression example:');
insert into post (id_author, date, text_body) values (7, '2022-10-31 23:23:28', 'My reasoning is that it is a private good. It is because even though it provides low fees it excludes some poor elderly people who cannot afford it.

In that case it''s excludable. That is sufficient to show that it''s not a public good, since the standard definition of a public good is that it''s both non-excludable and non-rival.

If uncongested, I don''t think it is rival, as someone''s already admission into nursing houses doesn''t reduce the quality of care I receive if get admitted to such houses. However, under congested conditions, the quality of health care received reduces significantly and hence becomes rival.

I''m not sure that congested / uncongested is the most appropriate terminology here. A nursing home is unlikely to be run like, say, a public park. More likely it will have, at any time, a certain number of places, and the number of people admitted will not be allowed to exceed that number. So it would probably be more appropriate to consider whether demand (at the low fee) exceeds supply (places available). But with that change of terminology your logic will still apply: if demand is less than supply, it''s not rival, but if demand exceeds supply, it is.

In summary, therefore, the good is excludable and, depending on circumstances, may or may not be rival. Should it then be classified as a quasi-public good? Examples commonly given of quasi-public goods are public roads and bridges (presumably those without tolls), goods which are non-excludable and often non-rival, but can sometimes become rival due to congestion. It would be stretching the meaning of the term to apply it to a good which is excludable, just because in some circumstances it is non-rival. So your initial suggestion that low fee nursing home services are a private good is valid, although it could also be argued that, when demand is less than supply, they are a club good, which has been defined as a good which is excludable but non-rival.');
insert into post (id_author, date, text_body) values (77, '2022-10-10 22:13:52', 'Just one week ago the Germany minister for Health Lauterbach presented a scientific study conducted by among other the Robert-Koch-Institute (the leading German scientific advisor during the pandemics) about the situation of kindergarten facilities (children care from age one to six) during the pandemics.

The study concludes that forcing the kindergarten facilities to close for months (in April-June 2020 and January-April 2021) was wrong and according to this scientific results shouldn''t have been done because they weren''t locations of increased infection risk of Covid 19. Additionally, the study says that socially disadvantaged children and families have suffered especially under this measure. The minister promised that there won''t be such shutdowns anymore (during this pandemics I guess).

In a joint press conference with the minister of Family Affairs on Nov 2nd 2022 the Minister of Health, Professor Karl Lauterbach said:

Kitas waren keine Infektionsherde...

Somit muss man sagen, nach dem Wissen von heute kommt man klar zu der Erkenntnis, dass die Kita-Schließungen zu Begin der Pandemie nicht nötig gewesen wären, sie waren also unnötig aus der Sicht der Wissenschaft von heute...Das Schließen von Kitas ist medizinisch definitiv nicht angemessen...und wäre nicht nötig gewesen.

Kindergartens were no source of infections...

Accordingly one has to say, from the knowledge of today one has to come to the conclusion that the Kindergarten closures at the beginning of the pandemic would not have been necessary, they had been needless from the view of science of today...Closures of Kindergartens are definitely not medicinally adequate...and were not necessary.

Minister of Family Affairs Lisa Paus said:

Trotz all dieser Anstrengungen wissen wir, dass die Belastung von Kindern und Jugendlichen in der Pandemie deutlich zugenommen haben, und das gerade bei denjenigen, die shon vor der Pandemie belastet waren. Deswegen ist es eben nicht überrraschend, aber um so bedrückender, dass die Pandemie die soziale Ungleichheit schon bei den Kleinsten, schon bei Kindern in der Kita verschärft hat. Laut der Kita-Corona-Studie tragen die Kinder, die am meisten von frühkindlicher Förderung profitieren können, besonders schwer an den Folgen der Eindämmungsmaßnahmen.

Despite of all efforts made we know that the strains on children and adolescents were significantly rising during the pandemic, and especially for those that had been under pressure even before the pandemic. Therefor it is not surprising, but even more depressing that the pandemic aggravated social inequality already among the youngest, even among children in daycare. According to the Kindergarten-Corona study the children that can profit the most from early childhood assistance, are suffering the most from the consequences of containment measures.');
insert into post (id_author, date, text_body) values (12, '2022-10-11 04:40:39', 'Sweden used quite relaxed policy with comparatively comparatively limited restrictions. I am not sure if they are very sorry overall on this but anyway Swedes admit to making some mistakes, particularly in nursing homes, where the death toll was staggering.');
insert into post (id_author, date, text_body) values (92, '2022-10-03 11:27:11', 'Such a declaration would be nonsensical.

"If we had the same information two years ago that we have now, we would have decided otherwise" deals with a hypothetical scenario that cannot ever come to pass, because we cannot see into the future.

The measuring stick for past decisions is "with the same information as the past decision-makers had available, would we decide the same thing now?"

In addition, the state as sovereign cannot rely on external or higher entities to come to its aid, and reaction to crisis will be oriented along whether the crisis has the potential to damage that sovereignty. That calculation will look different in Sweden than in Singapore or Taiwan, so direct comparison between countries is also difficult -- a policy that works in Italy could fail in Sweden, or vice versa.

Third, a lot of the things that didn''t go wrong did so because of prevention programs that were already in place years before the pandemic, and the state''s reaction to the crisis contains both long-term and short-term components, and it is difficult to evaluate these separately. Measures interact with each other as well, for example a mandatory mask policy also created supply chains that allows healthcare workers to exchange their masks more frequently.');
insert into post (id_author, date, text_body) values (93, '2022-10-06 17:15:51', 'Governments have admitted it implicitly every time they changed their guidance. The change of guidance, before the pandemic subsided, amounted to admitting that the previous guidance was sub-optimal.');
insert into post (id_author, date, text_body) values (40, '2022-10-15 01:18:38', 'Historically, inheritance was a family affair
The family being a single economical unit, spanning generations. Parents and children working together for the common survival, as a farm or small business.
The concept that society has inherited (pun intended) is: Inheritance is not income, it is just redistribution of common wealth within the same family. Each heir has already worked to create this wealth, the family income has already been taxed.
The concepts of family, income, state, tax etc. have evolved, the importance of private income, individual wealth and inheritance has changed, as well as the relations between parents and children.
What is just (or should be) regarding inheritance and taxation seems to be the core of this question. My answer can only be: whatever society decides. I gave some explanation how the current state has evolved. How it will evolve further is how society as a whole may answer the question.');

--80
insert into post (id_author, date, text_body) values (52, '2022-10-19 18:19:05', '(this answer is a bit meh)

You could tax it the same way, but people don''t want that.

Inheritance is different. People don''t choose to inherit. People can''t change their behaviour to inherit more or less, or earlier or later.

Generally different forms of income are taxed differently. Capital gains are taxed differently from income (and capital gains on property are taxed differently again). Gambling winnings have a different tax system. Severance pay is not taxed the same as bonuses.

The government sets a tax system that it thinks can be "sold" to a public (who want public service, but would rather not pay tax) can raise money from those who are able to pay and doesn''t harm those who can''t. The tax system must raise enough money to pay for public services without being so unpopular that the government gets voted out. To walk this tightrope, government find it necessary to tax different forms of income differently.

But Meh the government could tax inheritance the same as other income, but it might not stay in government long if it did.

So the answer is political not economic.

');
insert into post (id_author, date, text_body) values (48, '2022-10-14 22:00:33', 'Suppose instead that Eve inherits €5,000,000. The taxes on that as a one year income would be immense. Moreover, that €5,000,000 represents income her parents earned on which they had already paid taxes. In one sense, it would be unfair to tax that already taxed income. However, in another sense, those large inheritances represent a key factor in wealth disparity. Many countries allow some amount to be passed down generation to generation tax free but do tax what are deemed to be excessive inheritances.');
insert into post (id_author, date, text_body) values (45, '2022-10-16 05:48:59', 'Inheritance may be a bank account or stock portfolio. But often it involves things like a single-family home, or a small business. Taxing this at the same rate as income would force the inheritor to sell it off and re-invest the remaining inheritance, which is seen by the public as undesirable.

Of course, as mentioned in the comments, public opinion is shaped by those with an interest to try and shape in. In germany one perfidious issue is the mix-up of Mittelschicht (middle classes) and Mittelstand (small and medium businesses, i.e. no more than a couple hundred employees). Any attempt to tax the Mittelstand owners gets portrayed by the Mittelstand lobbyists at an attempt to tax the Mittelschicht. And both members of the upper end of the lower class and the lower end of the upper class like to self-identify as middle class.');
insert into post (id_author, date, text_body) values (78, '2022-10-17 17:18:57', 'Partial answer. Philosophically, we want to be advanced beings, but actually we are still dominated by our ancient instincts. You are putting in your question the highest point of view where every member of the society is an individual and their wealth belongs only to them; passing that wealth to their children is like passing it to other individuals. But the laws are still affected by the tribal mentality; the wealth of the individual is also the wealth of the family.');
insert into post (id_author, date, text_body) values (45, '2022-10-18 13:40:18', 'The tax has to be payable. Society won''t accept a tax where many people can''t receive their inheritance because of taxes.

To rebut your point about separate taxes favoring the roch and their huge inheritances, consider this. Eve actually makes 20k per year and lives in a house in poor neighbourhood with her mother. Her mother dies and the house is appraised to be worth 100k.

If those 100k were taxed just like anything else, Eve couldn''t pay the tax and should sell the house to pay it. She''d end up even worse, likely renting for the rest of her life.

But society does not accept such system because they think they should be able to leave their belongings to their family after they pass away.');
insert into post (id_author, date, text_body) values (9, '2022-10-15 08:36:55', 'As stated by James K and alluded to in other answers, you can make the case that inheritance is a very special kind of income. Inheritance resembles donations, and some countries will use the exact same tax for donations and inheritance.

Once you agree inheritance is a singular way of obtaining assets, creating a special tax out of it has some procedural advantages for a government:

You can choose different collectors for the new tax. For example, in Brazil, inheritance tax is collect by states, while regular income tax is collected by the federal government.
You can choose different taxpayers. In inheritance, the heirs or the deceased person''s estate can pay for the tax, while in income tax it is more intuitive that only who gets the income pays.
You can choose different rates. You can have lower/higher rates to incentivize/penalize capital accumulation within families.
Of course, all these different rules could be integrated to income tax laws and we could call everything income tax. But since people intuitively understand the difference between regular income and inheritance, it is easier to create a new tax with an appropriate name.');
insert into post (id_author, date, text_body) values (16, '2022-11-02 14:19:31', 'At least in the United States, there isn''t much choice but to create a separate category for it. Taxing it as earned income would destroy family farms and overly encourage wasteful spending near the end of people''s lives. Taxing it as unearned income would be too low a tax rate for large estates.');
insert into post (id_author, date, text_body) values (13, '2022-11-18 04:44:41', 'An aspect that is never mentioned when it comes to inheritance tax is that inheritance is a service offered to the heirs by the government. Real estate is recorded with the government and only exists because there is a government record of the ownership. These records need to be updated for the new owners. The tractor on the farmland belongs to the heirs because government guarantees it. Stocks lie in some banks vault. The banks must transfer the ownership to the heirs. Government obliges them to. Same for savings accounts.

One way of thinking about inheritance tax is that it is a payment for this service.');
insert into post (id_author, date, text_body) values (51, '2022-11-04 13:14:29', 'Treating inheritance as income would create a huge difference between inheriting a property and (for instance) getting the same property as a gift from your parents.

People would have a choice of either gifting most of their assets to their children (perhaps using complex contracts which limit what the children can do with the assets while their parents are still alive), or penalize their children with an income tax. Furthermore, such contracts would have to be regularly updated as parents acquire new assets, and it would be especially complicated when such assets are sold or otherwise disappear. E.g. moving to a new house would become really complicated for retired people who presumably already have gifted their old house to their children.

Inheritance makes such situations more manageable, while still preserving the ability to pass wealth to the next generation within a family. Notably, the issues mentioned above essentially don''t exist for rich people who have a family lawyer anyway, but would be a harsh strike for the poorer families.');
insert into post (id_author, date, text_body) values (93, '2022-11-12 22:11:21', 'Most people don''t inherit, or very little. They don''t pay inheritance tax anyway.

Inheritance is a form on wealth building that is mostly used by the already wealthy family. It builds wealth along generations.

Financial power gives political power, which in turn gives political advantages.

Having a low tax rate on inheritance is maintained because rich get rich, and poor stay poor. Same thing for capital gain taxes which is lower than the highest income tax bracket in all the countries I know about.

Income tax is progressive (in most countries), and affects only low to upper-middle classes. Anyone above that receives dividends and capital gains, and doesn''t pay income tax, or very little.');
--90
insert into post (id_author, date, text_body) values (52, '2022-10-23 00:09:08', 'There are three possibilities here: Trade sanctions, censorship, and export controls. They are listed in order from least likely to cause a problem to most, although any one of them could be the issue for a given site/country/behavior combination.');
insert into post (id_author, date, text_body) values (86, '2022-10-18 03:14:18', 'Consider Kuwait. It has "investments" in oil (ie it owns the land where the oil is found, and charges for the right to drill), and from these it makes enough money to not have any personal or corporate tax on Kuwaiti nationals or businesses owned by Kuwaitis. Is the money that the oil companies pay a "tax" or is it payment for a resource?

So in principle, this is possible. It doesn''t solve anything though. If the government is acting as a shareholder, and earning dividends from its holdings, that is money which could otherwise be passed onto others, either in the form of dividends to private shareholders, or in wages to workers.

The net effect is still money moving from people to the government, but in a way that is less easy for the government to control (and so is likely to become more regressive). Unless there is a special situation (such as a massive and valuable natural resource like the Kuwaiti oilfields) this is not likely to be an effective way for a government to raise finances.');
insert into post (id_author, date, text_body) values (6, '2022-10-15 16:34:36', 'It would be the same principle of the tax haven. The idea could work only for a small country whose economy depends on the money flowing from bigger countries with way bigger economies.

Let''s make the opposite hypothesis, the country earns mainly from local investments, to get enough revenues to fund all the public services and save money to prepare for eventual downturns such country should control such a big chunk of the economy that there would be no space for private enterprise. When the government gets such a control over the economy it does not matter whether the ideology is, communist or capitalist, eventually cronyism and clientelism affect the system.

Only a country investing abroad and reinvesting over time for a long period could get to the point that it will need no taxes, but it would have to spread the investment among many countries, investing in a single country would be an enormous risk and create a dependency. But a country that is well managed will also see their per capita GDP grow a lot more than the other countries, with a small medium population the size of the economy would be so big that it could not pull enough dividends from their investments abroad to fund themselves without destabilising the other countries. That is why the population has to be very small.

Singapore is small, but densely populated, I don''t know whether it might really reach the point where they need no taxes. You can compare it with Norway, the country is bigger, the population is smaller. They invested abroad for decades part of their oil revenues and still did not reach a point where the government needs no taxes.');
insert into post (id_author, date, text_body) values (73, '2022-10-09 09:17:33', 'This is similar to asking whether a private individual or family could live on their investment returns, without having a job that provides steady income.

It''s possible, but unless you were "born with a silver spoon" (i.e. your parents were wealthy enough to set you up for life), you first have to work many years to accumulate these investments. You would have to set aside significant portions of your income as savings to be invested, instead of spending this on your daily needs. Unless you''re being paid very well, this is likely to require significant belt-tightening to avoid spending this money; at the very least you might have to forego discretionary expenses like fancy vacations.

If you assume that returns on investment are 5-10% annually, this basically means that you can''t live only on the returns until you''ve accumulated investments worth 10 to 20 times the your annual expenses. If you set aside 10% of your income every year, and you''re breaking even on the rest, that will take most of your life (earnings do compound, but also you earn less in the early years of your career).

Of course, most people do get into this situation. When you retire, you mainly have your savings and the returns on your investments to live on (although some people get pensions, and there are government benefits like social security). Many governments provide tax benefits to encourage saving for retirement. But it''s also common for expenses to go down -- by the time most people retire, the children are grown and the parents aren''t paying their expenses, the mortgage may be paid off, there are no commuting expenses, etc.

What does this mean if we go from the personal analogy to governments? In order to build up reserves that can be invested and produce significant returns, the government will have to set aside a big portion of its income. Governments are generally expected to use their income to provide services to citizens. If the government initially receives much of its income from taxe, the taxpayers may not appreciate that they''re paying higher taxes so that some of it can be set aside -- this is not likely to benefit anyone for several generation.

The "silver spoon" mentioned above applies to countries that don''t depend as much on taxes. Countries that have valuable natural resources (e.g. oil-rich countries) can use the income from these to build up their reserves. Since the constituents aren''t funding this, they''re less likely to find this eggregious. On the other hand, whoever is buying the resources might not be willing to pay the markup that''s due to the government using this revenue for accumulating cash. So it depends on whether there are other competing countries.

Note that one difference between people and countries is that people expect to die, and you can''t take it with you. So when you retire, you only need to be able to fund your expenses for a few decades. You can draw down your reserves in addition to living on the returns. While not always achieved, nations expect to go on forever, so they''d need to build up their investments sufficiently that they rarely need to dip into the principal.');
insert into post (id_author, date, text_body) values (33, '2022-10-05 07:33:04', 'This is just a tax by another name. Some people are paying for some things and a portion of that payment goes to the government. That portion which goes to the government is effectively a tax even if you call it something different.

Consider a country where a government puts a 20% tax on oil and gas profits. Consider a different country where a government owns 20% of all oil and gas companies. There is no real difference - both governments are getting 20% of oil and gas profits, against the will of the customers (who would like the price to be 20% cheaper) and other shareholders (who would like the price to stay the same but their share of the profit to be 20% higher).');
insert into post (id_author, date, text_body) values (83, '2022-10-04 02:03:42', 'It did happen in Norway that they have a significant sovereign wealth fund. Because they profited hugely from oil now, and they have relatively small population, it''s worth $250,000 per citizen.

https://en.wikipedia.org/wiki/Government_Pension_Fund_of_Norway

In general it could be possible to replace all taxes with that, if governments become more careful with money you can easily cut 3/4 of government spending worldwide.');
insert into post (id_author, date, text_body) values (57, '2022-10-04 19:36:02', 'When POTUS rambles about going to war or openly criticizes his administration on Twitter, you take what he wrote seriously, as in it''s not a joke he means it - irrespective of it not being an official or traditional communication channel. So yes, it''s has just as much significance as the latter when something new and worth noting comes out of it.

Even if you were to leave out the countless reporting, commentary, and opinion pieces on Trump-related newsworthy events - of which there has been a plethora since he came to office, ranging from commentary that left most of the US aghast to war threats - you''d still be left with a hefty news barrage of articles that are analyzing or commenting on what Trump said on Twitter.

His tweet about banning transexuals from the army and its aftermath, for instance, generated ~13k news articles if a Google News search is anything to go by. That''s quite significant, considering that the army is still awaiting a directive to that effect three weeks later.');
insert into post (id_author, date, text_body) values (62, '2022-10-19 19:28:01', 'No - the law would not pass. As you point out "There is also no possibility to abstain as this would be equivalent to a no vote." The reason for an abstention being equivalent to a no vote is that Article 52(3) of the Basic Law states that resolutions of the Bundesrat may only be passed by an absolute majority of the chamber (or two-thirds majority for constitutional amendments) - not just a majority of the valid votes cast on that particular resolution, nor a majority of delegates present.

In your example, the resolution with 30 ''yes'' votes would fail due to not achieving the requisite 35 votes in favour. The invalid votes would be treated the same as abstaining, and consequently equivalent to voting no. There are, therefore, no historical examples of this being used to pass a law against the wishes of one political party.');
insert into post (id_author, date, text_body) values (17, '2022-10-13 04:01:42', 'No. Passing requires a majority of the chamber, not of the quorum. In other words, it requires a majority of all possible votes, not just of the votes cast (or the valid votes cast).

You actually already mentioned this in your question without realizing it: this is exactly the same reasoning as for abstention.

Question 2: Are there historical precedents where some states voted invalid in the Bundesrat and this allowed the passage of a law against the wishes of one political party?

As per the answer to your question 1, it is not possible to pass a law this way. So, I will focus on the first half of the question.

There are, as of now, only two cases of a "split vote" of a Bundesland in the Bundesrat. The first happened in 1949 and was a simple mistake that got resolved immediately.');
insert into post (id_author, date, text_body) values (43, '2022-10-17 13:54:41', 'It depends.
Whataboutism is about derailing the discussion about a particular problem by pointing out another problem. The focus is on the derailing, not on actually wanting to solve that other problem.

So if Bob is genuinely offering a pact to Alice that they both stop cheating, and is considering Alice accepting this pact a possibility, it is not whataboutism.

If the anticipated outcome is eg Alice denying that she is even cheating in the first place, followed by a transition into a discussion of whether or not Alice is cheating, then it is whataboutism.');
--100
insert into post (id_author, date, text_body) values (29, '2022-10-13 13:37:07', 'Yes

If any of the two would be caught cheating, saying "another also does" or even "everyone does" is very unlikely to work as excuse of any kind, every university would confirm. One is not relevant to another.

Also, being caught cheating (now or before) does not deny right of reporting about another student doing the same violation.

To say, religions do indeed suggest to forgive on the basis that no one is free from the sin but not when this is being cynically abused. Even Vatican has a prison.');
insert into post (id_author, date, text_body) values (28, '2022-10-04 10:12:04', 'I think I convinced myself that this isn''t whataboutism. The reason is that for there to be a debate, there needs to be a statement whose truth is contested. In this example, Alice professes a belief in the statement "You [Bob] should stop cheating". Since Bob apparently agrees with that statement, they aren''t actually disagreeing, and there is no debate.

Bob''s response adds another layer - he makes a new statement whose truth is (potentially) contested: that "You [Alice] should stop cheating first". Alice could agree to this, or she could counter with:

You [Bob] should stop cheating first because ...
I should not have to stop cheating because ...
But Alice''s response is outside the scope of the question.

If Bob had instead argued he should not have to stop cheating because Alice is cheating too, then that becomes whataboutism.');
insert into post (id_author, date, text_body) values (10, '2022-11-21 07:09:54', 'Easier for everybody
For the government
Taxes are complex. It is not only how much the employee gets from the government. It is also:

other income sources
other income sources from family members (which might or might not be government employees)
deductions
To do that, you would need to create a new tax system (that needs to handle more complicated issues like mixed incomes) when you already have a "working" one.

Easier for the employees
Comparing offers from government and not government jobs is easier.
They do not need to rely on specialized, more complicated, tax assessors/programs.
Easier for the public
A complex system makes it easy for loopholes to appear. Even if they are not widely exploited, loopholes that favour public employees are likely to create resentment among the public.

And, why would you do otherwise?
If the execution is perfect (everybody ends paying up the same that with the current system), there is no benefit at all.');
insert into post (id_author, date, text_body) values (11, '2022-11-20 23:17:40', 'Taxes are more than the money for government
Taxes are not simply an instrument for government to get money. It''s also an important instrument of welfare policy. Taxes differ depending not only on income, but on the social situation of the tax payer, like their marital status, the amount of children and the money spent on their education etc.

If you''d free government employees from taxes, you''d have to wage the differently depending on eg. the amount of children, you''d have to apply other tax rates from their additional income (such as dividends) etc. You''d create a lot of complications, each of that would likely be a big political issue to discuss. It''s quite pragmatical to have one tax policy and discuss it in one place.');
insert into post (id_author, date, text_body) values (53, '2022-11-21 00:53:56', 'The idea may also be that even though you might work for the government, you still will use or benefit from government services. A government employee will only do one specialized job at a time. An officer in the military is not doing remotely the same work as an accident investigator in the Department of Transportation and both those people are not working prosecuting criminals in the department of justice. Depending on how local taxes are funded, there are entire regions of the country that would be cash strapped if they could not tax government employees (For example, in the United States, a vast majority of federal government workers live in Maryland and Virginia, and those states would be out a lot in taxes.

It''s the same principle as asking "Why should a childless couple pay the same tax for the school system? They aren''t getting anything from it as the couple that has 10 kids!" Just because you aren''t benefitted from a government service directly doesn''t mean you don''t have a benefit (One of those kids in school now is going to be the nurse helping you live comfortably in your retirement home, and he or she is getting that education right now in a public school.).

I''m all for paying as little taxes as possible, but that doesn''t betray the understanding that if a large swarth is exempt because of the income earning job they have, stuff that is a benefit to me does not get funding.');
insert into post (id_author, date, text_body) values (64, '2022-11-21 04:32:31', 'If government employees didn''t pay taxes, they wouldn''t be able to get tax benefits from things like donating to charity.');
insert into post (id_author, date, text_body) values (33, '2022-10-20 20:12:55', '-1


In most countries in the world the government is the biggest employer. It would hurt the government''s ability to generate income pretty hard if the stopped taxing the income of the biggest employer''s employees. Depending on just how big the public sector is in the country it could probably be easier just to scrap the concept of payroll tax altogether if a country wanted to do this.

There is also the fact that people who work for the government still enjoy many of the service that local and national government provide and should still pay there fair share to ensure the continued operation of these services.');
insert into post (id_author, date, text_body) values (19, '2022-11-15 09:59:45', 'No, because it is the party rather than the candidate that gives official endorsement. A losing primary candidate from party X for president could however theoretically claim to be an independent or win in some other party''s primary (or gain endorsement by some other party in some other way) in all but two states, South Dakota and Texas.

All but three states have some kind of sore loser law that precludes a party switch for some elections between losing a primary and the general election. However, all but South Dakota and Texas have clarified their sore loser laws to state that they do not apply to presidential elections.

It is the national party rather than the state that decides who gets to carry that party''s label during a presidential election. I do not know what would happen if someone ran for president in party X''s primary in South Dakota or Texas, switched to party Y, and then won enough primaries to win that party''s convention.');
insert into post (id_author, date, text_body) values (92, '2022-10-19 14:30:49', 'Secured didactic projection as a way of acquiring funds might be interesting');
insert into post (id_author, date, text_body) values (3, '2022-10-01 23:49:00', 'Organized full-range intranet might be a way of achieving that, but may be to technical.');
insert into post (id_author, date, text_body) values (33, '2022-10-13 17:37:54', 'Devolved mobile ability is one solution I''ve heard of for your problem.');


--Comments
insert into post (id_author, date, text_body) values (2, '2022-10-08 02:58:14', 'Compatible optimal support');
insert into post (id_author, date, text_body) values (50, '2022-10-13 15:22:48', 'Persevering mobile Graphic Interface');
insert into post (id_author, date, text_body) values (72, '2022-10-17 13:03:52', 'Cloned object-oriented framework');
insert into post (id_author, date, text_body) values (66, '2022-10-14 01:41:26', 'Horizontal 4th generation project');
insert into post (id_author, date, text_body) values (86, '2022-10-11 16:53:44', 'Down-sized hybrid moderator');
insert into post (id_author, date, text_body) values (24, '2022-10-07 12:53:49', 'Balanced multi-state throughput');
insert into post (id_author, date, text_body) values (66, '2022-10-15 11:54:28', 'Reactive modular hub');
insert into post (id_author, date, text_body) values (92, '2022-10-07 23:54:23', 'Distributed client-server monitoring');
insert into post (id_author, date, text_body) values (74, '2022-10-10 19:27:18', 'Seamless optimal frame');
insert into post (id_author, date, text_body) values (89, '2022-10-14 14:45:27', 'Profit-focused hybrid algorithm');
insert into post (id_author, date, text_body) values (54, '2022-10-15 08:40:43', 'Optimized national complexity');
insert into post (id_author, date, text_body) values (61, '2022-10-04 22:21:09', 'Intuitive intangible Graphic Interface');
insert into post (id_author, date, text_body) values (45, '2022-10-18 09:13:41', 'Streamlined global conglomeration');
insert into post (id_author, date, text_body) values (69, '2022-10-12 11:18:11', 'Inverse exuding application');
insert into post (id_author, date, text_body) values (85, '2022-10-06 04:20:16', 'Up-sized zero defect archive');
insert into post (id_author, date, text_body) values (98, '2022-10-17 08:01:32', 'Vision-oriented interactive database');
insert into post (id_author, date, text_body) values (57, '2022-10-08 01:59:53', 'Centralized hybrid encryption');
insert into post (id_author, date, text_body) values (45, '2022-10-18 04:10:29', 'Exclusive asymmetric time-frame');
insert into post (id_author, date, text_body) values (67, '2022-10-05 22:02:15', 'Programmable composite process improvement');
insert into post (id_author, date, text_body) values (27, '2022-10-01 11:37:31', 'Operative exuding Graphic Interface');
insert into post (id_author, date, text_body) values (47, '2022-10-03 10:34:22', 'Secured context-sensitive functionalities');
insert into post (id_author, date, text_body) values (92, '2022-10-06 03:29:45', 'Monitored asymmetric definition');
insert into post (id_author, date, text_body) values (43, '2022-10-11 10:24:31', 'Adaptive dedicated leverage');
insert into post (id_author, date, text_body) values (22, '2022-10-07 04:14:56', 'Robust grid-enabled artificial intelligence');
insert into post (id_author, date, text_body) values (27, '2022-10-15 17:46:45', 'Centralized needs-based matrix');
insert into post (id_author, date, text_body) values (24, '2022-10-01 15:19:49', 'Focused dynamic product');
insert into post (id_author, date, text_body) values (7, '2022-10-12 04:42:59', 'Multi-lateral impactful leverage');
insert into post (id_author, date, text_body) values (1, '2022-10-06 03:07:27', 'Assimilated fault-tolerant strategy');
insert into post (id_author, date, text_body) values (71, '2022-10-09 07:13:28', 'Centralized bandwidth-monitored function');
insert into post (id_author, date, text_body) values (85, '2022-10-10 15:55:46', 'Advanced zero tolerance neural-net');



insert into question (id_question, title) values (1, 'Using open source software in proprietary software');
insert into question (id_question, title) values (2, 'Convicted for murder and "victim" found alive');
insert into question (id_question, title) values (3, 'Is it always a good idea to instruct opposing lawyers to speak directly?');
insert into question (id_question, title) values (4, 'Is it punishable to purchase (knowingly) illegal copies where legal ones are not available?');
insert into question (id_question, title) values (5, 'Termination by convenience clauses');
insert into question (id_question, title) values (6, 'If a party does not fulfil an obligation of a clause, and the other party ignores the failure for a long time, is the clause still legally valid?');
insert into question (id_question, title) values (7, 'Is it legal to contact someone whose name you got from a police report?');
insert into question (id_question, title) values (8, 'Is ignorance of facts an excuse?');
insert into question (id_question, title) values (9, 'How can there be a "lack" of workers? The Vanishing American Worker');
insert into question (id_question, title) values (10, 'Did cutting coporation tax in the UK lead to an increase in revenue?');
insert into question (id_question, title) values (11, 'Does diversity lead to more productivity?');
insert into question (id_question, title) values (12, 'If the value of the currency of an economy rises, then is it less desirable to trade with that economy?');
insert into question (id_question, title) values (13, 'Does globalization affect employment rate?');
insert into question (id_question, title) values (14, 'Can data be created using Monte Carlo Simulation');
insert into question (id_question, title) values (15, 'Keynesian vs classical consumption functions');
insert into question (id_question, title) values (16, 'How Many People Have Mortgages in Canada?');
insert into question (id_question, title) values (17, 'Low fees government provided elderly nursing houses- private or public goods or quasi public?');
insert into question (id_question, title) values (18, 'Does the money supply increase when more types of money are added to the economy?');
insert into question (id_question, title) values (19, 'Have any governments admitted that their approach to COVID was mistaken?');
insert into question (id_question, title) values (20, 'What is the purpose of an inheritance tax when inheritance could be taxes like other income?');
insert into question (id_question, title) values (21, 'Are Internet Companies (Google, twitter, Facebook , ...) affected by sanctions against Iran?');
insert into question (id_question, title) values (22, 'Could a government make so much money from investments they can stop charging taxes?');
insert into question (id_question, title) values (23, 'Do declarations made by politicians using social networks have the same effect as those made through classical ways?');
insert into question (id_question, title) values (24, 'Did the German Bundesrat ever have a vote with deliberate invalid votes?');
insert into question (id_question, title) values (25, 'Does this argument qualify as whataboutism?');
insert into question (id_question, title) values (26, 'Why do government employees pay income taxes?');
insert into question (id_question, title) values (27, 'What limitations exist for a candidate to claim party membership if they''re not an official member?');
insert into question (id_question, title) values (28, 'Special Forces exist or just fiction?');
insert into question (id_question, title) values (29, 'Blame It on Rio or blame it on someone else?');
insert into question (id_question, title) values (30, 'Year of the Bear or Year of the Bull?');
insert into question (id_question, title) values (31, 'Rocky Mountain High or Rocky Mountain Low?');
insert into question (id_question, title) values (32, 'Woyzeck is a good author o study eocnomic issues?');
insert into question (id_question, title) values (33, 'Tales of the poor and the rich?');
insert into question (id_question, title) values (34, 'Does subsidizing the arts help or hurt the economy?');
insert into question (id_question, title) values (35, 'Who was the worst ruler in history?');
insert into question (id_question, title) values (36, 'Figures of growth in the 19th century?');
insert into question (id_question, title) values (37, 'The end of the world is near?');
insert into question (id_question, title) values (38, 'Is it good to be a fan of a political party?');
insert into question (id_question, title) values (39, 'Something weird is happening in the world?');
insert into question (id_question, title) values (40, 'Secret Life of Milton S. Hershey?');
insert into question (id_question, title) values (41, 'Is it possible to have a good life without money?');
insert into question (id_question, title) values (42, 'Wild Hearts Can''t Be Broken');
insert into question (id_question, title) values (43, 'Tension at the border between Margoland and Freidoland?');
insert into question (id_question, title) values (44, '12 Rounds of an election?');
insert into question (id_question, title) values (45, 'The way money is made?');
insert into question (id_question, title) values (46, 'Best country to live in?');
insert into question (id_question, title) values (47, 'Chapayev as a hero?');
insert into question (id_question, title) values (48, 'Results of research on the impact of the pandemic on the economy?');
insert into question (id_question, title) values (49, 'Husbands and Wives, who makes more money?');
insert into question (id_question, title) values (50, 'The truth to the statement that the rich are getting richer and the poor are getting poorer?');

INSERT INTO answer (id_answer,id_question,is_solution)
VALUES
    (51,1,'1'),
    (52,2,'1'),
    (53,2,'0'),
    (54,3,'0'),
    (55,3,'0'),
    (56,4,'0'),
    (57,4,'1'),
    (58,5,'1'),
    (59,5,'0'),
    (60,5,'0');
INSERT INTO answer (id_answer,id_question,is_solution)
VALUES
    (61,6,'1'),
    (62,6,'0'),
    (63,7,'0'),
    (64,8,'1'),
    (65,8,'0'),
    (66,10,'0'),
    (67,11,'1'),
    (68,11,'0'),
    (69,12,'0'),
    (70,12,'1');
INSERT INTO answer (id_answer,id_question,is_solution)
VALUES
    (71,12,'0'),
    (72,12,'0'),
    (73,14,'0'),
    (74,17,'0'),
    (75,19,'0'),
    (76,19,'0'),
    (77,19,'0'),
    (78,19,'1'),
    (79,20,'1'),
    (80,20,'0');
INSERT INTO answer (id_answer,id_question,is_solution)
VALUES
    (81,20,'0'),
    (82,20,'0'),
    (83,20,'0'),
    (84,20,'0'),
    (85,20,'0'),
    (86,20,'0'),
    (87,20,'0'),
    (88,20,'0'),
    (89,20,'0'),
    (90,21,'0');
INSERT INTO answer (id_answer,id_question,is_solution)
VALUES
    (91,22,'0'),
    (92,22,'0'),
    (93,22,'0'),
    (94,22,'0'),
    (95,22,'1'),
    (96,23,'0'),
    (97,23,'0'),
    (98,24,'1'),
    (99,24,'0'),
    (100,25,'1');
INSERT INTO answer (id_answer,id_question,is_solution)
VALUES
    (101,25,'0'),
    (102,25,'0'),
    (103,26,'0'),
    (104,26,'0'),
    (105,26,'0'),
    (106,26,'1'),
    (107,26,'0'),
    (108,27,'0'),
    (109,40,'1'),
    (110,35,'0');


INSERT INTO comment (id_comment, id_question, id_answer)
VALUES
    (111,1,NULL),
    (112,7,NULL),
    (113,9,NULL),
    (114,7,NULL),
    (115,12,NULL),
    (116,1,NULL),
    (117,2,NULL),
    (118,3,NULL),
    (119,3,NULL),
    (120,2,NULL);
INSERT INTO comment (id_comment, id_question, id_answer)
VALUES
    (121,NULL,51),
    (122,NULL,51),
    (123,NULL,52),
    (124,NULL,52),
    (125,NULL,53),
    (126,NULL,54),
    (127,NULL,55),
    (128,NULL,55),
    (129,NULL,55),
    (130,NULL,56);
INSERT INTO comment (id_comment, id_question, id_answer)
VALUES
    (131,10,NULL),
    (132,10,NULL),
    (133,11,NULL),
    (134,11,NULL),
    (135,12,NULL),
    (136,13,NULL),
    (137,35,NULL),
    (138,20,NULL),
    (139,20,NULL),
    (140,18,NULL);


INSERT INTO draft (date,id_author,title,text_body)
VALUES
    ('2022-09-18 09:10:41',83,'lorem vitae odio sagittis semper. Nam','placerat, orci lacus vestibulum lorem, sit amet ultricies'),
    ('2022-08-10 12:39:59',40,'turpis non enim. Mauris','Fusce fermentum fermentum arcu. Vestibulum ante'),
    ('2022-05-14 11:43:14',88,'magnis dis parturient montes, nascetur ridiculus mus.','arcu iaculis enim, sit amet ornare lectus'),
    ('2022-08-09 19:37:15',13,'mi enim, condimentum eget, volutpat ornare, facilisis eget,','tempor diam dictum sapien. Aenean massa. Integer vitae nibh. Donec est mauris,'),
    ('2022-09-12 09:36:13',46,'Nunc quis arcu vel','commodo at, libero. Morbi accumsan laoreet ipsum. Curabitur consequat, lectus sit amet luctus vulputate, nisi sem semper');


INSERT INTO tag (name) VALUES ('eli5');
INSERT INTO tag (name) VALUES ('politics');
INSERT INTO tag (name) VALUES ('economics');
INSERT INTO tag (name) VALUES ('economy');
INSERT INTO tag (name) VALUES ('law');
INSERT INTO tag (name) VALUES ('constitution');
INSERT INTO tag (name) VALUES ('rights');
INSERT INTO tag (name) VALUES ('global');
INSERT INTO tag (name) VALUES ('international');
INSERT INTO tag (name) VALUES ('court');
INSERT INTO tag (name) VALUES ('authoritarian');
INSERT INTO tag (name) VALUES ('libertarian');
INSERT INTO tag (name) VALUES ('left');
INSERT INTO tag (name) VALUES ('right');
INSERT INTO tag (name) VALUES ('extremism');
INSERT INTO tag (name) VALUES ('radical');
INSERT INTO tag (name) VALUES ('capitalism');
INSERT INTO tag (name) VALUES ('communism');
INSERT INTO tag (name) VALUES ('parliament');
INSERT INTO tag (name) VALUES ('government');
INSERT INTO tag (name) VALUES ('judge');
INSERT INTO tag (name) VALUES ('police');
INSERT INTO tag (name) VALUES ('jail');
INSERT INTO tag (name) VALUES ('obligation');
INSERT INTO tag (name) VALUES ('taxes');


INSERT INTO question_tag (id_tag,id_question)
VALUES
    (20,18),
    (9,34),
    (15,43),
    (20,29),
    (19,49),
    (15,18),
    (13,3),
    (7,7),
    (4,12),
    (10,4);
INSERT INTO question_tag (id_tag,id_question)
VALUES
    (23,13),
    (14,20),
    (12,46),
    (5,18),
    (6,47),
    (13,20),
    (18,39),
    (21,17),
    (11,35),
    (9,17);
INSERT INTO question_tag (id_tag,id_question)
VALUES
    (11,8),
    (9,31),
    (8,20),
    (9,21),
    (10,32),
    (10,37),
    (21,14),
    (6,15),
    (20,24);
INSERT INTO question_tag (id_tag,id_question)
VALUES
    (6,18),
    (2,3),
    (8,15),
    (15,13),
    (8,13),
    (17,45),
    (21,1),
    (21,25),
    (10,7),
    (13,22);
INSERT INTO question_tag (id_tag,id_question)
VALUES
    (9,27),
    (3,13),
    (2,38),
    (24,8),
    (5,49),
    (9,1),
    (4,32),
    (25,38),
    (15,38),
    (19,17);
INSERT INTO question_tag (id_tag,id_question)
VALUES
    (4,43),
    (23,19),
    (10,31),
    (15,45),
    (19,34),
    (16,41),
    (4,13),
    (2,32),
    (11,40),
    (20,2);
INSERT INTO question_tag (id_tag,id_question)
VALUES
    (10,25),
    (18,19),
    (5,34),
    (2,42),
    (5,31),
    (19,5),
    (22,26),
    (25,41);
INSERT INTO question_tag (id_tag,id_question)
VALUES
    (2,17),
    (8,50),
    (8,6),
    (23,33),
    (17,41),
    (3,31),
    (18,50),
    (2,45),
    (13,15),
    (17,37);



INSERT INTO badge (b_rank, name, condition) VALUES ('Gold', 'Inquisitive Master', 'Ask more than 100 questions');
INSERT INTO badge (b_rank, name, condition) VALUES ('Silver', 'Inquisitive Pro', 'Ask more than 50 questions');
INSERT INTO badge (b_rank, name, condition) VALUES ('Bronze', 'Inquisitive Beginner', 'Ask more than 10 questions');
INSERT INTO badge (b_rank, name, condition) VALUES ('Gold', 'Answer Master', 'Answer more than 100 answers');
INSERT INTO badge (b_rank, name, condition) VALUES ('Silver', 'Answer Pro', 'Answer more than 50 answers');
INSERT INTO badge (b_rank, name, condition) VALUES ('Bronze', 'Answer Beginner', 'Answer more than 10 answers');
INSERT INTO badge (b_rank, name, condition) VALUES ('Gold', 'Commentator Master', 'Comment more than 100 times');
INSERT INTO badge (b_rank, name, condition) VALUES ('Silver', 'Commentator Pro', 'Comment more than 50 times');
INSERT INTO badge (b_rank, name, condition) VALUES ('Bronze', 'Commentator Beginner', 'Comment more than 10 times');
INSERT INTO badge (b_rank, name, condition) VALUES ( 'Gold', 'Judge Master', 'Vote more than 100 times');
INSERT INTO badge (b_rank, name, condition) VALUES ( 'Silver', 'Judge Pro', 'Vote more than 50 times');
INSERT INTO badge (b_rank, name, condition) VALUES ( 'Bronze', 'Judge Beginner', 'Vote more than 10 times');

INSERT INTO badge_given (id_user,id_badge)
VALUES
    (94,9),
    (54,3),
    (50,8),
    (77,1),
    (41,10),
    (30,2),
    (71,1),
    (48,3),
    (67,6),
    (59,5),
    (1,3),
    (72,6),
    (88,1),
    (76,7),
    (43,1),
    (13,9),
    (10,2),
    (39,9),
    (7,4),
    (83,12),
    (58,3),
    (22,1),
    (92,8),
    (31,3),
    (26,11),
    (7,6),
    (52,6),
    (42,11),
    (10,3),
    (60,7);


insert into notification (dismissed, id_user, date) values (true, 73, '2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (true, 49,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 71,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 49,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 74,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (true, 38,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (true, 28,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (true, 92,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (true, 4,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (true, 69,'2022-10-02 12:32:23');

insert into notification (dismissed, id_user, date) values (true, 26,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 97,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (true, 95,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 71,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (true, 88,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (true, 80,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (true, 33,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (true, 63,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 20,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 66,'2022-10-02 12:32:23');

insert into notification (dismissed, id_user, date) values (true, 94,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (true, 60,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (true, 9,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 74,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 39,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (true, 19,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 29,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (true, 78,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (true, 22,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 37,'2022-10-02 12:32:23');

insert into notification (dismissed, id_user, date) values (false, 81,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 66,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (true, 2,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (true, 16,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 62,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 27,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 87,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 23,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (true, 22,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 51,'2022-10-02 12:32:23');

insert into notification (dismissed, id_user, date) values (true, 76,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (true, 96,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (true, 47,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 55,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 17,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 61,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 31,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (true, 2,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 90,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 74,'2022-10-02 12:32:23');

insert into notification (dismissed, id_user, date) values (true, 26,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 80,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (true, 6,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (true, 81,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 61,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (true, 1,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 60,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (true, 40,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 44,'2022-10-02 12:32:23');
insert into notification (dismissed, id_user, date) values (false, 32,'2022-10-02 12:32:23');


insert into system_notif (id_notif, notif_text) values (1, 'augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit');
insert into system_notif (id_notif, notif_text) values (2, 'duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla');
insert into system_notif (id_notif, notif_text) values (3, 'augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit');
insert into system_notif (id_notif, notif_text) values (4, 'aenean auctor gravida sem praesent id massa id nisl venenatis');
insert into system_notif (id_notif, notif_text) values (5, 'aenean auctor gravida sem praesent id massa id nisl venenatis');
insert into system_notif (id_notif, notif_text) values (6, 'augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit');
insert into system_notif (id_notif, notif_text) values (7, 'augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit');
insert into system_notif (id_notif, notif_text) values (8, 'duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla');
insert into system_notif (id_notif, notif_text) values (9, 'aenean auctor gravida sem praesent id massa id nisl venenatis');
insert into system_notif (id_notif, notif_text) values (10, 'augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit');

insert into follow_tag_notif (id_notif, id_tag) values (11, 5);
insert into follow_tag_notif (id_notif, id_tag) values (12, 20);
insert into follow_tag_notif (id_notif, id_tag) values (13, 1);
insert into follow_tag_notif (id_notif, id_tag) values (14, 13);
insert into follow_tag_notif (id_notif, id_tag) values (15, 15);
insert into follow_tag_notif (id_notif, id_tag) values (16, 10);
insert into follow_tag_notif (id_notif, id_tag) values (17, 9);
insert into follow_tag_notif (id_notif, id_tag) values (18, 6);
insert into follow_tag_notif (id_notif, id_tag) values (19, 20);
insert into follow_tag_notif (id_notif, id_tag) values (20, 7);

insert into marked_as_solution_notif (id_notif, id_answer) values (21,52);
insert into marked_as_solution_notif (id_notif, id_answer) values (22,105);
insert into marked_as_solution_notif (id_notif, id_answer) values (23,66);
insert into marked_as_solution_notif (id_notif, id_answer) values (24,69);
insert into marked_as_solution_notif (id_notif, id_answer) values (25,72);
insert into marked_as_solution_notif (id_notif, id_answer) values (26,84);
insert into marked_as_solution_notif (id_notif, id_answer) values (27,98);
insert into marked_as_solution_notif (id_notif, id_answer) values (28,100);
insert into marked_as_solution_notif (id_notif, id_answer) values (29,99);
insert into marked_as_solution_notif (id_notif, id_answer) values (30,101);

insert into new_badge_notif (id_notif,id_badge) values (31,1);
insert into new_badge_notif (id_notif,id_badge) values (32,2);
insert into new_badge_notif (id_notif,id_badge) values (33,3);
insert into new_badge_notif (id_notif,id_badge) values (34,4);
insert into new_badge_notif (id_notif,id_badge) values (35,5);
insert into new_badge_notif (id_notif,id_badge) values (36,6);
insert into new_badge_notif (id_notif,id_badge) values (37,7);
insert into new_badge_notif (id_notif,id_badge) values (38,8);
insert into new_badge_notif (id_notif,id_badge) values (39,9);
insert into new_badge_notif (id_notif,id_badge) values (40,10);

-- insert into new_answer_notif (id_notif,id_answer) values (41,53);
INSERT INTO follows_tag (id_user, id_tag)
VALUES
    (66,12),
    (29,14),
    (78,23),
    (88,17),
    (61,6),
    (96,18),
    (87,7),
    (54,16),
    (5,24),
    (62,22),
    (56,4),
    (84,10),
    (64,8),
    (10,17),
    (70,6),
    (23,4),
    (57,11),
    (12,8),
    (61,3),
    (64,24),
    (5,8),
    (33,25),
    (17,3),
    (95,2),
    (66,16),
    (94,6),
    (54,1),
    (4,16),
    (83,22),
    (2,22),
    (2,1),
    (2,2),
    (2,3),
    (10,6);
INSERT INTO follows_tag (id_user, id_tag)
VALUES
    (4,18),
    (61,7),
    (86,4),
    (37,25),
    (15,18),
    (6,16),
    (76,6),
    (33,23),
    (6,19),
    (90,12),
    (21,20),
    (37,5),
    (43,2),
    (32,22),
    (64,18),
    (30,6),
    (12,23),
    (86,11),
    (83,12),
    (62,4);
INSERT INTO follows_question (id_user,id_question)
VALUES
    (58,7),
    (94,6),
    (49,46),
    (45,30),
    (12,23),
    (72,10),
    (96,30),
    (1,22),
    (63,45),
    (100,33),
    (85,39),
    (50,2),
    (73,24),
    (14,25),
    (64,31),
    (79,12),
    (67,23),
    (15,10),
    (30,24),
    (40,26),
    (76,5),
    (65,40),
    (52,11),
    (97,37),
    (48,42);

-- insert into new_answer_notif (id_notif,id_answer) values (42,64);
-- insert into new_answer_notif (id_notif,id_answer) values (43,75);
-- insert into new_answer_notif (id_notif,id_answer) values (45,97);
-- insert into new_answer_notif (id_notif,id_answer) values (44,86);
-- insert into new_answer_notif (id_notif,id_answer) values (46,108);
-- insert into new_answer_notif (id_notif,id_answer) values (47,109);
-- insert into new_answer_notif (id_notif,id_answer) values (48,55);
-- insert into new_answer_notif (id_notif,id_answer) values (49,67);
-- insert into new_answer_notif (id_notif,id_answer) values (50,56);

insert into followed_question_notif (id_notif,id_answer) values (51,60);
insert into followed_question_notif (id_notif,id_answer) values (52,61);
insert into followed_question_notif (id_notif,id_answer) values (53,62);
insert into followed_question_notif (id_notif,id_answer) values (54,63);
insert into followed_question_notif (id_notif,id_answer) values (55,64);
insert into followed_question_notif (id_notif,id_answer) values (56,65);
insert into followed_question_notif (id_notif,id_answer) values (57,66);
insert into followed_question_notif (id_notif,id_answer) values (58,67);
insert into followed_question_notif (id_notif,id_answer) values (59,68);
insert into followed_question_notif (id_notif,id_answer) values (60,69);

INSERT INTO follows_tag (id_user, id_tag)
VALUES
    (51,9),
    (58,3),
    (12,18),
    (45,13),
    (35,17),
    (28,7),
    (68,10),
    (38,24),
    (98,13),
    (55,14),
    (96,15),
    (42,25),
    (43,22),
    (95,13),
    (41,9),
    (20,10),
    (17,8),
    (41,6),
    (48,2),
    (11,6),
    (88,24),
    (35,6),
    (22,3),
    (33,7),
    (52,17),
    (45,10),
    (36,22),
    (4,5),
    (99,4),
    (60,17);
INSERT INTO follows_tag (id_user, id_tag)
VALUES
    (99,21),
    (57,19),
    (29,17),
    (70,2),
    (48,9),
    (62,9),
    (17,7),
    (22,20),
    (62,11),
    (83,17),
    (49,18),
    (39,3),
    (44,18),
    (94,11),
    (93,8),
    (48,24),
    (3,18),
    (44,22),
    (60,20),
    (19,9);


INSERT INTO question_vote (id_user,id_question,score)
VALUES
    (26,47,1),
    (81,8,-1),
    (61,26,1),
    (65,32,1),
    (7,5,-1),
    (8,19,1),
    (9,1,0),
    (80,26,1),
    (74,6,1),
    (31,5,-1),
    (80,37,-1),
    (96,43,-1),
    (95,11,1),
    (56,43,1),
    (71,7,1),
    (38,2,-1),
    (66,21,-1),
    (65,8,-1),
    (84,4,-1),
    (55,2,1),
    (82,9,-1),
    (25,37,-1),
    (6,39,-1),
    (58,26,1),
    (54,28,1),
    (99,45,1),
    (48,23,1),
    (75,25,1),
    (15,42,-1),
    (67,44,-1);
INSERT INTO question_vote (id_user,id_question,score)
VALUES
    (89,25,-1),
    (47,40,-1),
    (22,33,-1),
    (57,19,1),
    (14,24,1),
    (4,15,1),
    (7,7,-1),
    (93,46,1),
    (90,39,1),
    (20,32,1),
    (98,44,-1),
    (91,42,1),
    (85,7,0),
    (2,8,-1),
    (18,27,-1),
    (4,43,-1),
    (89,38,1),
    (67,13,-1),
    (20,19,1),
    (12,10,1);
INSERT INTO question_vote (id_user,id_question,score)
VALUES
    (6,49,-1),
    (90,48,1),
    (55,41,0),
    (42,16,1),
    (59,15,1),
    (12,5,0),
    (20,4,-1),
    (1,2,1),
    (87,42,-1),
    (82,16,-1),
    (10,38,1),
    (64,46,-1),
    (37,36,-1),
    (19,35,1),
    (86,16,-1),
    (16,49,-1),
    (22,27,1),
    (73,24,1),
    (86,7,-1),
    (84,23,1),
    (61,18,1),
    (47,41,1),
    (30,27,-1),
    (97,31,1),
    (46,17,-1),
    (6,34,1),
    (41,15,1),
    (2,9,-1),
    (7,20,1),
    (70,4,1);
INSERT INTO question_vote (id_user,id_question,score)
VALUES
    (32,38,1),
    (84,3,-1),
    (43,31,-1),
    (34,37,-1),
    (60,31,1),
    (37,3,1),
    (75,45,-1),
    (59,48,-1),
    (80,7,1),
    (87,48,1),
    (46,36,-1),
    (36,28,1),
    (85,27,1),
    (94,33,-1),
    (97,15,1),
    (64,10,1),
    (82,15,-1),
    (16,42,1),
    (96,47,1),
    (63,3,1);
INSERT INTO question_vote (id_user,id_question,score)
VALUES
    (13,12,-1),
    (51,13,1),
    (76,12,0),
    (89,50,-1),
    (6,27,1),
    (19,40,1),
    (84,10,-1),
    (39,2,0),
    (92,13,1),
    (73,41,-1),
    (80,31,1),
    (21,15,0),
    (81,49,1),
    (66,45,-1),
    (69,37,-1),
    (65,40,-1),
    (29,8,-1),
    (80,49,1),
    (73,23,1),
    (94,48,1),
    (59,11,-1),
    (74,38,1),
    (79,11,-1),
    (96,30,-1),
    (6,31,-1),
    (57,31,-1),
    (3,2,1),
    (88,12,1),
    (77,19,1),
    (54,46,-1);
INSERT INTO question_vote (id_user,id_question,score)
VALUES
    (95,14,-1),
    (51,40,1),
    (2,5,1),
    (70,28,1),
    (56,12,1),
    (87,47,-1),
    (53,15,-1),
    (38,28,-1),
    (7,47,1),
    (26,25,1),
    (76,39,1),
    (48,7,-1),
    (96,38,1),
    (64,40,-1),
    (96,3,1),
    (58,33,1),
    (93,20,1),
    (41,45,-1),
    (79,36,1),
    (70,30,1);
INSERT INTO question_vote (id_user,id_question,score)
VALUES
    (44,6,-1),
    (86,27,1),
    (68,32,-1),
    (44,8,1),
    (47,6,-1),
    (20,29,-1),
    (93,17,-1),
    (98,19,-1),
    (35,19,1),
    (55,30,-1),
    (40,28,-1),
    (75,15,1),
    (64,6,-1),
    (43,8,-1),
    (75,11,-1),
    (72,41,1),
    (85,38,-1),
    (72,35,1),
    (60,33,1),
    (96,8,-1),
    (62,21,-1),
    (85,33,1),
    (28,6,1),
    (71,46,1),
    (64,31,-1),
    (64,42,-1),
    (65,49,1),
    (10,27,-1),
    (42,23,1),
    (99,2,-1);
INSERT INTO question_vote (id_user,id_question,score)
VALUES
    (91,38,1),
    (1,35,1),
    (17,48,1),
    (42,21,-1),
    (8,34,-1),
    (68,6,-1),
    (31,14,1),
    (77,32,-1),
    (16,18,-1),
    (34,22,-1),
    (82,8,-1),
    (84,12,1),
    (79,6,1),
    (97,28,1),
    (62,40,-1),
    (16,3,1),
    (47,21,-1),
    (11,48,-1),
    (17,49,1),
    (24,42,-1);


INSERT INTO answer_vote (id_user,id_answer,score)
VALUES
    (81,87,-1),
    (87,59,1),
    (84,81,-1),
    (46,108,1),
    (35,98,-1),
    (35,60,1),
    (7,84,1),
    (28,102,1),
    (31,66,1),
    (65,99,1),
    (10,55,-1),
    (22,67,1),
    (41,67,-1),
    (84,94,-1),
    (63,58,-1),
    (52,88,-1),
    (96,61,1),
    (50,87,1),
    (7,110,1),
    (46,90,1),
    (85,63,-1),
    (42,103,-1),
    (78,67,1),
    (35,69,1),
    (84,53,-1),
    (18,89,1),
    (93,88,1),
    (28,100,1),
    (77,109,1),
    (46,52,-1);
INSERT INTO answer_vote (id_user,id_answer,score)
VALUES
    (98,73,-1),
    (77,98,-1),
    (91,84,1),
    (77,95,1),
    (53,86,1),
    (73,61,1),
    (33,56,1),
    (81,108,1),
    (11,104,1),
    (94,74,-1),
    (44,68,-1),
    (59,89,-1),
    (8,91,1),
    (17,73,1),
    (38,99,-1),
    (57,99,-1),
    (52,53,1),
    (91,77,1),
    (57,66,1),
    (68,66,-1);
INSERT INTO answer_vote (id_user,id_answer,score)
VALUES
    (33,77,1),
    (40,95,-1),
    (66,103,-1),
    (17,84,1),
    (92,87,-1),
    (19,75,-1),
    (41,96,1),
    (68,103,1),
    (53,65,1),
    (4,82,-1),
    (21,80,1),
    (81,79,-1),
    (33,52,1),
    (63,94,-1),
    (34,97,1),
    (6,52,1),
    (60,72,-1),
    (61,67,-1),
    (40,53,1),
    (87,58,1),
    (13,53,1),
    (47,54,1),
    (66,58,-1),
    (44,101,1),
    (2,67,1),
    (58,52,1),
    (14,101,-1),
    (47,55,1),
    (85,70,-1),
    (82,61,1);
INSERT INTO answer_vote (id_user,id_answer,score)
VALUES
    (13,58,1),
    (94,82,1),
    (39,57,1),
    (88,97,1),
    (67,62,-1),
    (22,59,-1),
    (93,92,-1),
    (100,95,-1),
    (89,73,-1),
    (41,53,1),
    (55,55,-1),
    (62,82,-1),
    (30,66,1),
    (73,78,1),
    (28,65,-1),
    (97,58,-1),
    (60,97,0),
    (84,89,-1),
    (79,108,1),
    (38,52,-1);
INSERT INTO answer_vote (id_user,id_answer,score)
VALUES
    (57,59,1),
    (12,68,1),
    (9,100,-1),
    (11,77,1),
    (52,99,-1),
    (94,63,-1),
    (99,83,-1),
    (56,85,-1),
    (98,96,1),
    (61,97,-1),
    (34,80,1),
    (59,83,-1),
    (100,98,-1),
    (77,91,1),
    (3,92,0),
    (100,97,1),
    (88,81,-1),
    (31,84,0),
    (69,85,1),
    (42,86,-1),
    (61,58,1),
    (87,73,1),
    (62,90,-1),
    (38,91,-1),
    (20,101,1),
    (72,102,-1),
    (30,95,-1),
    (35,66,-1),
    (69,81,-1),
    (50,84,-1);
INSERT INTO answer_vote (id_user,id_answer,score)
VALUES
    (83,108,1),
    (61,101,1),
    (11,102,-1),
    (12,104,1),
    (38,107,1),
    (81,77,1),
    (1,66,1),
    (68,84,-1),
    (25,108,-1),
    (56,93,1),
    (3,58,1),
    (53,67,-1),
    (26,76,-1),
    (47,56,-1),
    (62,72,1),
    (94,79,1),
    (9,69,1),
    (53,98,0),
    (27,97,-1),
    (28,73,1);
INSERT INTO answer_vote (id_user,id_answer,score)
VALUES
    (71,92,1),
    (23,96,-1),
    (6,73,-1),
    (69,99,-1),
    (25,79,1),
    (78,51,1),
    (92,53,1),
    (82,63,1),
    (64,73,1),
    (19,96,-1),
    (63,103,-1),
    (23,83,-1),
    (58,109,1),
    (90,108,1),
    (81,95,1),
    (65,57,1),
    (57,103,1),
    (41,93,1),
    (96,71,1),
    (6,53,1),
    (55,98,-1),
    (53,52,-1),
    (86,109,1),
    (23,109,1),
    (31,69,1),
    (58,108,1),
    (12,64,-1),
    (72,93,1),
    (38,81,1),
    (69,82,1);
INSERT INTO answer_vote (id_user,id_answer,score)
VALUES
    (100,80,-1),
    (97,92,1),
    (48,52,1),
    (23,57,-1),
    (22,107,1),
    (81,93,1),
    (45,98,1),
    (52,56,1),
    (86,95,1),
    (91,96,-1),
    (26,69,-1),
    (75,87,1),
    (99,62,1),
    (38,95,1),
    (1,87,-1),
    (93,72,-1),
    (93,78,-1),
    (95,85,-1),
    (84,99,-1),
    (1,93,1);
INSERT INTO answer_vote (id_user,id_answer,score)
VALUES
    (99,85,1),
    (74,94,-1),
    (57,79,-1),
    (32,107,1),
    (96,91,1),
    (46,66,1),
    (75,92,1),
    (56,107,1),
    (67,104,-1),
    (39,91,-1),
    (50,52,-1),
    (82,59,1),
    (63,79,1),
    (26,100,1),
    (25,56,1),
    (79,80,1),
    (70,81,-1),
    (23,71,1),
    (96,55,1),
    (26,55,1),
    (29,88,1),
    (97,56,1),
    (18,90,1),
    (43,53,1),
    (33,102,-1),
    (20,108,-1),
    (9,95,-1),
    (23,66,-1),
    (54,84,-1),
    (11,98,1);
INSERT INTO answer_vote (id_user,id_answer,score)
VALUES
    (51,74,-1),
    (95,75,-1),
    (39,54,1),
    (14,90,1),
    (90,62,1),
    (58,51,1),
    (69,66,1),
    (60,101,1),
    (37,100,1),
    (17,89,1),
    (93,56,-1),
    (5,96,-1),
    (84,103,-1),
    (26,89,-1),
    (20,98,1),
    (91,103,1),
    (42,87,-1),
    (59,73,-1),
    (93,91,-1),
    (70,108,1);
INSERT INTO answer_vote (id_user,id_answer,score)
VALUES
    (12,75,1),
    (9,108,-1),
    (62,96,-1),
    (73,73,-1),
    (39,76,1),
    (17,59,1),
    (36,54,1),
    (89,101,1),
    (55,79,1),
    (60,82,-1),
    (60,108,-1),
    (20,103,-1),
    (67,76,1),
    (97,53,-1),
    (20,96,-1),
    (68,77,-1),
    (58,69,1),
    (50,58,1),
    (20,67,1),
    (87,91,1),
    (32,101,-1),
    (9,84,1),
    (29,77,-1),
    (29,60,1),
    (97,57,-1),
    (43,67,-1),
    (94,76,1),
    (33,70,1),
    (95,106,1),
    (92,103,1);
INSERT INTO answer_vote (id_user,id_answer,score)
VALUES
    (97,90,1),
    (68,80,-1),
    (5,61,-1),
    (47,70,1),
    (42,97,1),
    (87,108,1),
    (51,70,1),
    (27,79,1),
    (88,55,-1),
    (8,84,-1),
    (27,70,-1),
    (34,60,1),
    (86,86,1),
    (59,92,1),
    (55,67,1),
    (89,92,-1),
    (92,83,-1),
    (59,106,-1),
    (41,62,1),
    (45,102,1);

INSERT INTO report (id_user,id_post,reason,date)
VALUES
    (36,112,'neque. Nullam ut nisi a odio semper cursus. Integer mollis. Integer tincidunt aliquam arcu.','2022-10-21 10:46:30'),
    (51,63,'In lorem. Donec elementum, lorem ut aliquam iaculis, lacus pede sagittis augue, eu tempor erat','2022-10-21 14:34:46');

INSERT INTO edit (id_user,id_post,old_text,date)
VALUES
    (8,1,'vel lectus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.','2022-10-20 15:34:06'),
    (32,29,'Vivamus molestie dapibus ligula. Aliquam erat volutpat. Nulla dignissim. Maecenas ornare egestas ligula. Nullam','2022-10-21 13:07:31'),
    (89,46,'ipsum leo elementum sem, vitae aliquam eros turpis non enim. Mauris quis turpis vitae purus gravida','2022-10-20 09:12:05');

