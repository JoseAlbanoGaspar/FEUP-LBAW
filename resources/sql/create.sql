DROP TABLE IF EXISTS post CASCADE; --140
DROP TABLE IF EXISTS question CASCADE; --50
DROP TABLE IF EXISTS answer CASCADE; --60
DROP TABLE IF EXISTS comment CASCADE; --30
DROP TABLE IF EXISTS draft CASCADE; --5
DROP TABLE IF EXISTS tag CASCADE; --25
DROP TABLE IF EXISTS question_tag CASCADE;
DROP TABLE IF EXISTS "user" CASCADE;
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

CREATE TABLE "user" (
	id_user SERIAL PRIMARY KEY,
	username VARCHAR(25) UNIQUE NOT NULL,
	email TEXT UNIQUE NOT NULL,
	password TEXT NOT NULL,
	profile_picture TEXT,
	personal_text TEXT
);

create table administrator (
    id_admin INT PRIMARY KEY,
          CONSTRAINT FK_USER
            FOREIGN KEY(id_admin)
              REFERENCES "user"(id_user) ON DELETE CASCADE
);


create table moderator (
    id_moderator INT PRIMARY KEY,
          CONSTRAINT FK_USER
            FOREIGN KEY(id_moderator)
              REFERENCES "user"(id_user) ON DELETE CASCADE
);


create table post (
                      id_post SERIAL PRIMARY KEY,
                      id_author INT NOT NULL,
                      date DATE NOT NULL,
                      text_body TEXT NOT NULL,
                      CONSTRAINT FK_AUTHOR
                          FOREIGN KEY(id_author)
                              REFERENCES "user"(id_user)

);



create table question (
                          id_question SERIAL PRIMARY KEY,
                          title TEXT NOT NULL,
                          score INT DEFAULT 0,
                          CONSTRAINT FK_POST
                              FOREIGN KEY(id_question)
                                  REFERENCES post(id_post) ON DELETE CASCADE
);

CREATE TABLE answer (
                        id_answer SERIAL PRIMARY KEY,
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
    id_comment SERIAL PRIMARY KEY,
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
                         date DATE NOT NULL,
                         id_author integer NOT NULL,
                         title TEXT default NULL,
                         text_body TEXT default NULL,
                             CONSTRAINT FK_AUTHOR
                                FOREIGN KEY(id_author)
                                    REFERENCES "user"(id_user),
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
                                            REFERENCES tag(id_tag),
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
				REFERENCES "user"(id_user)
);



CREATE TABLE notification (
	id_notif SERIAL PRIMARY KEY,
	dismissed BOOL NOT NULL,
	id_user INT NOT NULL,
    date DATE NOT NULL,
	FOREIGN KEY (id_user) REFERENCES "user"(id_user) ON DELETE CASCADE
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
	CONSTRAINT FK_TAG FOREIGN KEY (id_tag) REFERENCES tag(id_tag)
);



CREATE TABLE marked_as_solution_notif (
	id_notif INT PRIMARY KEY,
	id_answer INT,
	CONSTRAINT FK_NOTIF FOREIGN KEY (id_notif) REFERENCES notification (id_notif) ON DELETE CASCADE,
	CONSTRAINT FK_ANSWER FOREIGN KEY (id_answer) REFERENCES answer(id_answer)
);




CREATE TABLE new_badge_notif (
	id_notif INT PRIMARY KEY,
	id_badge INT,
	CONSTRAINT FK_NOTIF FOREIGN KEY (id_notif) REFERENCES notification (id_notif) ON DELETE CASCADE,
	CONSTRAINT FK_BADGE FOREIGN KEY (id_badge) REFERENCES badge(id_badge)
);

CREATE TABLE new_answer_notif (
	id_notif INT PRIMARY KEY,
	id_answer INT,
	CONSTRAINT FK_NOTIF FOREIGN KEY (id_notif) REFERENCES notification (id_notif) ON DELETE CASCADE, 
	CONSTRAINT FK_ANSWER FOREIGN KEY (id_answer) REFERENCES answer(id_answer)
);


CREATE TABLE followed_question_notif (
	id_notif INT PRIMARY KEY,
	id_answer INT,
	CONSTRAINT FK_NOTIF FOREIGN KEY (id_notif) REFERENCES notification (id_notif) ON DELETE CASCADE,
	CONSTRAINT FK_ANSWER FOREIGN KEY (id_answer) REFERENCES answer(id_answer)
);

CREATE TABLE follows_tag (
	id_user INT NOT NULL,
    id_tag INT NOT NULL,
    PRIMARY KEY (id_user, id_tag),
	    CONSTRAINT FK_TAG
			FOREIGN KEY(id_tag)
				REFERENCES tag(id_tag),
		CONSTRAINT FK_USER
			FOREIGN KEY(id_user)
				REFERENCES "user"(id_user) ON DELETE CASCADE
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
				REFERENCES "user"(id_user) ON DELETE CASCADE
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
				REFERENCES "user"(id_user) 
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
				REFERENCES "user"(id_user)
);


CREATE TABLE report (
    id_report SERIAL PRIMARY KEY,
	id_user INT NOT NULL,
	id_post INT NOT NULL,
    reason TEXT NOT NULL,
	date DATE NOT NULL,
    CONSTRAINT UNIQUE_USER_POST
	    UNIQUE (id_user, id_post),
    CONSTRAINT FK_POST
        FOREIGN KEY(id_post)
            REFERENCES post(id_post),
    CONSTRAINT FK_USER
        FOREIGN KEY(id_user)
            REFERENCES "user"(id_user)
);



CREATE TABLE edit (
    id_edit SERIAL PRIMARY KEY,
	id_user INT NOT NULL,
	id_post INT NOT NULL,
    old_text TEXT NOT NULL,
	date DATE NOT NULL,
    CONSTRAINT UNIQUE_USER_POST_DATE
	    UNIQUE (id_user, id_post, date),
    CONSTRAINT FK_ANSWER
        FOREIGN KEY(id_post)
            REFERENCES post(id_post),
    CONSTRAINT FK_USER
        FOREIGN KEY(id_user)
            REFERENCES "user"(id_user)
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

DROP TRIGGER IF EXISTS delete_user ON "user";
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

------------------------TRANSACTION DELETE USER

/*
-- delete useless information about deleted user
CREATE FUNCTION delete_user_misc() RETURNS TRIGGER AS
$BODY$
BEGIN
    -- delete notifications
    DELETE FROM notification WHERE id_user = OLD.id_user;
    -- delete drafts
    DELETE FROM draft WHERE id_author = OLD.id_user;
    -- delete follows_tag
    DELETE FROM follows_tag WHERE id_user = OLD.id_user;
    -- delete follows_question
    DELETE FROM follows_question WHERE id_user = OLD.id_user;

END
$BODY$
    LANGUAGE plpgsql;

*/

--isto também não dá pq fazer DELETE USER falha logo por causa de primary keys
CREATE OR REPLACE FUNCTION delete_user() RETURNS TRIGGER AS
$BODY$
BEGIN
UPDATE "user"
SET username = CONCAT ('deleted_user_',id_user::TEXT),
    email = CONCAT ('deleted_email_',id_user::TEXT),
    password = CONCAT (MD5(RANDOM()::TEXT),id_user::TEXT),
    profile_picture = NULL,
    personal_text = NULL
WHERE id_user = OLD.id_user;

-- delete notifications
DELETE FROM notification WHERE id_user = OLD.id_user;
-- delete drafts
DELETE FROM draft WHERE id_author = OLD.id_user;
-- delete follows_tag
DELETE FROM follows_tag WHERE id_user = OLD.id_user;
-- delete follows_question
DELETE FROM follows_question WHERE id_user = OLD.id_user;


RAISE 'Users can not be deleted';

END
$BODY$
    LANGUAGE plpgsql;

CREATE TRIGGER delete_user
    BEFORE DELETE ON "user"
    FOR EACH ROW
EXECUTE PROCEDURE delete_user();



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
INSERT INTO "user" (username, email, password, profile_picture, personal_text)
 VALUES ($username, $email, $password, $profile_picture, $personal_text);

-- Insert administrator
INSERT INTO administrator(id_admin)
 VALUES(currval('user_id_user_seq'));

END TRANSACTION;

------------------------TRANSACTION MODERATOR

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Insert user
INSERT INTO "user" (id_user, username, email, password, profile_picture, personal_text)
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

 */
