------------------------TRANSACTION ADMINISTRATOR

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Insert user
INSERT INTO "user" (id_user, username, email, password, profilePicture, personalText) 
 VALUES ($id_user, $username, $email, $password, $profilePicture, $personalText);

-- Insert administrator
INSERT INTO administrator(id_admin)
 VALUES($id_user);

END TRANSACTION;

------------------------TRANSACTION MODERATOR

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Insert user
INSERT INTO "user" (id_user, username, email, password, profilePicture, personalText) 
 VALUES ($id_user, $username, $email, $password, $profilePicture, $personalText);

-- Insert moderator
INSERT INTO moderator(id_moderator)
 VALUES($id_user);

END TRANSACTION;

------------------------TRANSACTION ANSWER

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Insert post
INSERT INTO post(id_post, id_author, date, text_body)
 VALUES($id_post, $id_author, Now(), $text_body);

-- Insert answer
INSERT INTO answer(id_answer, id_question, is_solution)
 VALUES($id_answer, $id_question, false);

END TRANSACTION;


-------------------------TRANSACTION QUESTION

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Insert post
INSERT INTO post(id_post, id_author, date, text_body)
 VALUES($id_post, $id_author, Now(), $text_body);

-- Insert question
INSERT INTO question(id_question, title)
 VALUES($id_question, $title);

END TRANSACTION;


------------------------TRANSACTION COMMENT

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Insert post
INSERT INTO post(id_post, id_author, date, text_body)
 VALUES($id_post, $id_author, Now(), $text_body);

-- Insert comment
INSERT INTO comment(id_comment)
 VALUES($id_comment;

END TRANSACTION;

------------------------TRANSACTION SYS_NOTIF

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Insert notification
INSERT INTO notification(id_notif, dismissed, id_user, date)
 VALUES($id_notif, false, $id_user, Now());

-- Insert specific notification
INSERT INTO system_notif(id_notif, notif_text)
 VALUES($id_notif, $notif_text);

END TRANSACTION;

------------------------TRANSACTION FOLLOW_TAG_NOTIF

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Insert notification
INSERT INTO notification(id_notif, dismissed, id_user, date)
 VALUES($id_notif, false, $id_user, Now());

-- Insert specific notification
INSERT INTO follow_tag_notif(id_notif, id_tag)
 VALUES($id_notif, $id_tag);

END TRANSACTION;

------------------------TRANSACTION MARKED_AS_SOLUTION_NOTIF

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Insert notification
INSERT INTO notification(id_notif, dismissed, id_user, date)
 VALUES($id_notif, false, $id_user, Now());
 
-- Insert specific notification
INSERT INTO marked_as_solution_notif(id_notif, id_answer)
 VALUES($id_notif, $id_answer);

END TRANSACTION;

------------------------TRANSACTION NEW_BADGE_NOTIF

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Insert notification
INSERT INTO notification(id_notif, dismissed, id_user, date)
 VALUES($id_notif, false, $id_user, Now());
 
-- Insert specific notification 
INSERT INTO new_badge_notif(id_notif, id_badge)
 VALUES($id_notif, $id_badge);

END TRANSACTION;

------------------------TRANSACTION NEW_ANSWER_NOTIF

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Insert notification
INSERT INTO notification(id_notif, dismissed, id_user, date)
 VALUES($id_notif, false, $id_user, Now());
 
-- Insert specific notification
INSERT INTO new_answer_notif(id_notif, id_answer)
 VALUES($id_notif, $id_answer);

END TRANSACTION;

------------------------TRANSACTION FOLLOWED_QUESTION_NOTIF

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Insert notification
INSERT INTO notification(id_notif, dismissed, id_user, date)
 VALUES($id_notif, false, $id_user, Now());
 
-- Insert specific notification
INSERT INTO followed_question_notif(id_notif, id_answer)
 VALUES($id_notif, $id_answer);

END TRANSACTION;