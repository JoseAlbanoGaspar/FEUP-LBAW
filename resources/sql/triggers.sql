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
      NOT EXISTS(SELECT * FROM badges_given WHERE id_user = idauthor AND id_badge = 3)
   THEN
      INSERT INTO badges_given (id_user, id_badge) values (idauthor, 3);
   END IF;
   IF numquestion >= 50 AND
      NOT EXISTS(SELECT * FROM badges_given WHERE id_user = idauthor AND id_badge = 2)
   THEN
      INSERT INTO badges_given (id_user, id_badge) values (idauthor, 2);
   END IF;
   IF numquestion >= 100 AND
      NOT EXISTS(SELECT * FROM badges_given WHERE id_user = idauthor AND id_badge = 1)
   THEN
      INSERT INTO badges_given (id_user, id_badge) values (idauthor, 1);
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
      NOT EXISTS(SELECT * FROM badges_given WHERE id_user = idauthor AND id_badge = 6)
   THEN
      INSERT INTO badges_given (id_user, id_badge) values (idauthor, 6);
   END IF;
   IF numanswer >= 50 AND
      NOT EXISTS(SELECT * FROM badges_given WHERE id_user = idauthor AND id_badge = 5)
   THEN
      INSERT INTO badges_given (id_user, id_badge) values (idauthor, 5);
   END IF;
   IF numanswer >= 100 AND
      NOT EXISTS(SELECT * FROM badges_given WHERE id_user = idauthor AND id_badge = 4)
   THEN
      INSERT INTO badges_given (id_user, id_badge) values (idauthor, 4);
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
      NOT EXISTS(SELECT * FROM badges_given WHERE id_user = idauthor AND id_badge = 9)
   THEN
      INSERT INTO badges_given (id_user, id_badge) values (idauthor, 9);
   END IF;
   IF numcomment >= 50 AND
      NOT EXISTS(SELECT * FROM badges_given WHERE id_user = idauthor AND id_badge = 8)
   THEN
      INSERT INTO badges_given (id_user, id_badge) values (idauthor, 8);
   END IF;
   IF numcomment >= 100 AND
      NOT EXISTS(SELECT * FROM badges_given WHERE id_user = idauthor AND id_badge = 7)
   THEN
      INSERT INTO badges_given (id_user, id_badge) values (idauthor, 7);
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
      NOT EXISTS(SELECT * FROM badges_given WHERE id_user = NEW.id_user AND id_badge = 12)
   THEN
      INSERT INTO badges_given (id_user, id_badge) values (NEW.id_user, 12);
   END IF;
   IF numvote >= 50 AND
      NOT EXISTS(SELECT * FROM badges_given WHERE id_user = NEW.id_user AND id_badge = 11)
   THEN
      INSERT INTO badges_given (id_user, id_badge) values (NEW.id_user, 11);
   END IF;
   IF numvote >= 100 AND
      NOT EXISTS(SELECT * FROM badges_given WHERE id_user = NEW.id_user AND id_badge = 10)
   THEN
      INSERT INTO badges_given (id_user, id_badge) values (NEW.id_user, 10);
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
   THEN RAISE EXCEPTION 'There already is another solution to this question!';
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