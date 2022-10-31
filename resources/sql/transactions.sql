------------------------TRANSACTION ADMINISTRATOR

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Insert user
INSERT INTO "user" (username, email, password, profilePicture, personalText)
 VALUES ($username, $email, $password, $profilePicture, $personalText);

-- Insert administrator
INSERT INTO administrator(id_admin)
 VALUES(currval('user_id_user_seq'));

END TRANSACTION;

------------------------TRANSACTION MODERATOR

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Insert user
INSERT INTO "user" (id_user, username, email, password, profilePicture, personalText)
 VALUES ($id_user, $username, $email, $password, $profilePicture, $personalText);

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

UPDATE "user"
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

