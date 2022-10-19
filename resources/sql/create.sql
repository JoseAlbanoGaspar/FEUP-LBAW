DROP TABLE IF EXISTS "Post"; --140
DROP TABLE IF EXISTS "Question"; --50
DROP TABLE IF EXISTS "Answer"; --60
DROP TABLE IF EXISTS "Comment"; --30
DROP TABLE IF EXISTS "Draft"; --5
DROP TABLE IF EXISTS "Tag"; --25
DROP TABLE IF EXISTS "QuestionTag";
DROP TABLE IF EXISTS "User";


create table "User"
(
    id_user int not null PRIMARY KEY
);
insert into "User" values (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12), (13), (14), (15), (16), (17), (18), (19), (20), (21), (22), (23), (24), (25), (26), (27), (28), (29), (30), (31), (32), (33), (34), (35), (36), (37), (38), (39), (40), (41), (42), (43), (44), (45), (46), (47), (48), (49), (50), (51), (52), (53), (54), (55), (56), (57), (58), (59), (60), (61), (62), (63), (64), (65), (66), (67), (68), (69), (70), (71), (72), (73), (74), (75), (76), (77), (78), (79), (80), (81), (82), (83), (84), (85), (86), (87), (88), (89), (90), (91), (92), (93), (94), (95), (96), (97), (98), (99), (100);

create table "Post" (
                      id_post SERIAL PRIMARY KEY,
                      id_author INT NOT NULL,
                      date DATE NOT NULL,
                      textBody TEXT NOT NULL,
                      CONSTRAINT authorExists
                          FOREIGN KEY(id_author)
                              REFERENCES "User"(id_user)

);


insert into "Post" (id_post, id_author, date, textBody) values (1, 42, '2022-10-09 12:05:12', 'Optional logistical matrix');
insert into "Post" (id_post, id_author, date, textBody) values (2, 65, '2022-10-11 09:48:14', 'Synchronised non-volatile knowledge user');
insert into "Post" (id_post, id_author, date, textBody) values (3, 17, '2022-10-16 19:28:21', 'Mandatory neutral instruction set');
insert into "Post" (id_post, id_author, date, textBody) values (4, 13, '2022-10-07 06:46:45', 'Distributed dedicated open architecture');
insert into "Post" (id_post, id_author, date, textBody) values (5, 73, '2022-10-03 12:15:19', 'Re-contextualized web-enabled application');
insert into "Post" (id_post, id_author, date, textBody) values (6, 99, '2022-10-15 02:52:08', 'Virtual eco-centric function');
insert into "Post" (id_post, id_author, date, textBody) values (7, 41, '2022-10-13 18:00:19', 'Balanced regional extranet');
insert into "Post" (id_post, id_author, date, textBody) values (8, 65, '2022-10-18 01:43:52', 'Customizable value-added paradigm');
insert into "Post" (id_post, id_author, date, textBody) values (9, 17, '2022-10-02 09:39:02', 'Profound demand-driven challenge');
insert into "Post" (id_post, id_author, date, textBody) values (10, 56, '2022-10-13 07:45:49', 'Synergized logistical circuit');
insert into "Post" (id_post, id_author, date, textBody) values (11, 29, '2022-10-16 09:11:49', 'Virtual bifurcated structure');
insert into "Post" (id_post, id_author, date, textBody) values (12, 91, '2022-10-04 19:58:15', 'Programmable uniform local area network');
insert into "Post" (id_post, id_author, date, textBody) values (13, 86, '2022-10-04 17:00:02', 'Multi-layered heuristic ability');
insert into "Post" (id_post, id_author, date, textBody) values (14, 18, '2022-10-10 00:45:39', 'Inverse systemic software');
insert into "Post" (id_post, id_author, date, textBody) values (15, 57, '2022-10-18 10:01:21', 'Visionary executive local area network');
insert into "Post" (id_post, id_author, date, textBody) values (16, 62, '2022-10-10 20:37:58', 'Universal systemic throughput');
insert into "Post" (id_post, id_author, date, textBody) values (17, 77, '2022-10-15 16:50:50', 'Reverse-engineered well-modulated pricing structure');
insert into "Post" (id_post, id_author, date, textBody) values (18, 74, '2022-10-15 04:31:29', 'User-friendly multimedia core');
insert into "Post" (id_post, id_author, date, textBody) values (19, 27, '2022-10-02 15:09:08', 'Integrated multimedia moratorium');
insert into "Post" (id_post, id_author, date, textBody) values (20, 4, '2022-10-13 23:34:45', 'Expanded clear-thinking core');
insert into "Post" (id_post, id_author, date, textBody) values (21, 99, '2022-10-18 11:26:25', 'Mandatory intermediate info-mediaries');
insert into "Post" (id_post, id_author, date, textBody) values (22, 52, '2022-10-14 14:01:08', 'Universal zero defect focus group');
insert into "Post" (id_post, id_author, date, textBody) values (23, 61, '2022-10-04 10:26:48', 'Re-contextualized motivating hub');
insert into "Post" (id_post, id_author, date, textBody) values (24, 42, '2022-10-11 01:44:44', 'Ameliorated executive middleware');
insert into "Post" (id_post, id_author, date, textBody) values (25, 77, '2022-10-03 11:52:53', 'Customer-focused leading edge standardization');
insert into "Post" (id_post, id_author, date, textBody) values (26, 93, '2022-10-16 19:36:55', 'Re-contextualized methodical initiative');
insert into "Post" (id_post, id_author, date, textBody) values (27, 41, '2022-10-18 22:01:25', 'Re-engineered heuristic archive');
insert into "Post" (id_post, id_author, date, textBody) values (28, 68, '2022-10-17 20:54:17', 'Persevering client-driven support');
insert into "Post" (id_post, id_author, date, textBody) values (29, 32, '2022-10-06 13:27:36', 'Adaptive reciprocal hardware');
insert into "Post" (id_post, id_author, date, textBody) values (30, 85, '2022-10-15 23:10:35', 'Mandatory client-server matrices');
insert into "Post" (id_post, id_author, date, textBody) values (31, 60, '2022-10-12 23:38:42', 'Ergonomic discrete frame');
insert into "Post" (id_post, id_author, date, textBody) values (32, 46, '2022-10-16 05:02:01', 'De-engineered 6th generation software');
insert into "Post" (id_post, id_author, date, textBody) values (33, 96, '2022-10-09 20:39:54', 'Digitized executive core');
insert into "Post" (id_post, id_author, date, textBody) values (34, 52, '2022-10-10 23:45:42', 'Multi-lateral coherent pricing structure');
insert into "Post" (id_post, id_author, date, textBody) values (35, 59, '2022-10-05 18:08:08', 'Mandatory solution-oriented model');
insert into "Post" (id_post, id_author, date, textBody) values (36, 32, '2022-10-04 13:48:48', 'Devolved responsive capability');
insert into "Post" (id_post, id_author, date, textBody) values (37, 86, '2022-10-13 18:36:06', 'Polarised full-range ability');
insert into "Post" (id_post, id_author, date, textBody) values (38, 53, '2022-10-18 14:36:03', 'Synergistic attitude-oriented paradigm');
insert into "Post" (id_post, id_author, date, textBody) values (39, 58, '2022-10-01 06:03:31', 'Re-contextualized explicit middleware');
insert into "Post" (id_post, id_author, date, textBody) values (40, 57, '2022-10-15 19:33:49', 'Synergistic didactic knowledge base');
insert into "Post" (id_post, id_author, date, textBody) values (41, 95, '2022-10-14 14:30:14', 'Synergistic client-server core');
insert into "Post" (id_post, id_author, date, textBody) values (42, 85, '2022-10-18 16:06:37', 'User-centric intangible implementation');
insert into "Post" (id_post, id_author, date, textBody) values (43, 78, '2022-10-08 17:13:47', 'Total multi-state process improvement');
insert into "Post" (id_post, id_author, date, textBody) values (44, 99, '2022-10-09 05:11:52', 'Virtual 4th generation adapter');
insert into "Post" (id_post, id_author, date, textBody) values (45, 53, '2022-10-02 14:29:08', 'Quality-focused static intranet');
insert into "Post" (id_post, id_author, date, textBody) values (46, 89, '2022-10-06 10:29:34', 'Monitored content-based application');
insert into "Post" (id_post, id_author, date, textBody) values (47, 51, '2022-10-05 15:47:12', 'Profit-focused scalable budgetary management');
insert into "Post" (id_post, id_author, date, textBody) values (48, 38, '2022-10-14 12:56:29', 'Object-based multi-state access');
insert into "Post" (id_post, id_author, date, textBody) values (49, 81, '2022-10-17 10:37:43', 'Balanced system-worthy framework');
insert into "Post" (id_post, id_author, date, textBody) values (50, 81, '2022-10-13 22:45:07', 'Visionary object-oriented architecture');










insert into "Post" (id_post, id_author, date, textBody) values (51, 62, '2022-10-16 03:30:07', 'Triple-buffered hybrid hierarchy');
insert into "Post" (id_post, id_author, date, textBody) values (52, 41, '2022-10-13 11:12:59', 'Cloned client-driven budgetary management');
insert into "Post" (id_post, id_author, date, textBody) values (53, 56, '2022-10-01 19:18:58', 'Universal zero defect adapter');
insert into "Post" (id_post, id_author, date, textBody) values (54, 71, '2022-10-03 17:41:21', 'Implemented coherent intranet');
insert into "Post" (id_post, id_author, date, textBody) values (55, 25, '2022-10-06 08:18:55', 'Open-source logistical frame');
insert into "Post" (id_post, id_author, date, textBody) values (56, 35, '2022-10-01 04:50:45', 'De-engineered maximized neural-net');
insert into "Post" (id_post, id_author, date, textBody) values (57, 27, '2022-10-02 06:12:59', 'Managed fresh-thinking complexity');
insert into "Post" (id_post, id_author, date, textBody) values (58, 52, '2022-10-13 12:22:54', 'Organic optimizing migration');
insert into "Post" (id_post, id_author, date, textBody) values (59, 22, '2022-10-11 06:56:52', 'Grass-roots national methodology');
insert into "Post" (id_post, id_author, date, textBody) values (60, 69, '2022-10-17 15:04:30', 'Visionary multi-tasking forecast');
insert into "Post" (id_post, id_author, date, textBody) values (61, 43, '2022-10-15 07:51:55', 'Horizontal zero defect standardization');
insert into "Post" (id_post, id_author, date, textBody) values (62, 34, '2022-10-17 16:04:36', 'Face to face analyzing paradigm');
insert into "Post" (id_post, id_author, date, textBody) values (63, 34, '2022-10-05 12:09:09', 'Synergistic eco-centric intranet');
insert into "Post" (id_post, id_author, date, textBody) values (64, 57, '2022-10-10 01:11:19', 'Grass-roots asymmetric matrices');
insert into "Post" (id_post, id_author, date, textBody) values (65, 46, '2022-10-01 21:59:06', 'Focused leading edge migration');
insert into "Post" (id_post, id_author, date, textBody) values (66, 87, '2022-10-16 20:00:56', 'Advanced 24/7 budgetary management');
insert into "Post" (id_post, id_author, date, textBody) values (67, 92, '2022-10-13 00:14:02', 'Programmable non-volatile customer loyalty');
insert into "Post" (id_post, id_author, date, textBody) values (68, 87, '2022-10-16 03:41:15', 'Re-contextualized coherent model');
insert into "Post" (id_post, id_author, date, textBody) values (69, 88, '2022-10-19 17:32:27', 'Networked well-modulated circuit');
insert into "Post" (id_post, id_author, date, textBody) values (70, 54, '2022-10-06 11:44:56', 'Optional 24 hour open architecture');
insert into "Post" (id_post, id_author, date, textBody) values (71, 24, '2022-10-16 05:01:09', 'Fully-configurable reciprocal policy');
insert into "Post" (id_post, id_author, date, textBody) values (72, 37, '2022-10-05 12:12:45', 'Networked incremental application');
insert into "Post" (id_post, id_author, date, textBody) values (73, 3, '2022-10-17 06:36:18', 'Total systemic project');
insert into "Post" (id_post, id_author, date, textBody) values (74, 7, '2022-10-12 20:23:28', 'Up-sized composite capacity');
insert into "Post" (id_post, id_author, date, textBody) values (75, 77, '2022-10-10 22:13:52', 'Integrated zero tolerance instruction set');
insert into "Post" (id_post, id_author, date, textBody) values (76, 12, '2022-10-11 04:40:39', 'Synchronised solution-oriented support');
insert into "Post" (id_post, id_author, date, textBody) values (77, 92, '2022-10-03 11:27:11', 'Profit-focused contextually-based model');
insert into "Post" (id_post, id_author, date, textBody) values (78, 93, '2022-10-06 17:15:51', 'Synergistic background workforce');
insert into "Post" (id_post, id_author, date, textBody) values (79, 40, '2022-10-15 01:18:38', 'Multi-layered attitude-oriented projection');
insert into "Post" (id_post, id_author, date, textBody) values (80, 52, '2022-10-19 18:19:05', 'Automated clear-thinking success');
insert into "Post" (id_post, id_author, date, textBody) values (81, 48, '2022-10-10 22:00:33', 'De-engineered non-volatile data-warehouse');
insert into "Post" (id_post, id_author, date, textBody) values (82, 45, '2022-10-16 05:48:59', 'Up-sized grid-enabled help-desk');
insert into "Post" (id_post, id_author, date, textBody) values (83, 78, '2022-10-10 17:18:57', 'User-friendly zero defect capability');
insert into "Post" (id_post, id_author, date, textBody) values (84, 45, '2022-10-10 13:40:18', 'Right-sized empowering approach');
insert into "Post" (id_post, id_author, date, textBody) values (85, 9, '2022-10-10 08:36:55', 'Operative discrete groupware');
insert into "Post" (id_post, id_author, date, textBody) values (86, 16, '2022-10-02 14:19:31', 'User-centric uniform extranet');
insert into "Post" (id_post, id_author, date, textBody) values (87, 13, '2022-10-18 04:44:41', 'Enterprise-wide 24/7 hierarchy');
insert into "Post" (id_post, id_author, date, textBody) values (88, 51, '2022-10-04 13:14:29', 'Public-key neutral knowledge base');
insert into "Post" (id_post, id_author, date, textBody) values (89, 93, '2022-10-12 22:11:21', 'Implemented didactic software');
insert into "Post" (id_post, id_author, date, textBody) values (90, 52, '2022-10-17 00:09:08', 'Up-sized next generation groupware');
insert into "Post" (id_post, id_author, date, textBody) values (91, 86, '2022-10-18 03:14:18', 'Optimized attitude-oriented data-warehouse');
insert into "Post" (id_post, id_author, date, textBody) values (92, 6, '2022-10-15 16:34:36', 'Multi-layered needs-based policy');
insert into "Post" (id_post, id_author, date, textBody) values (93, 73, '2022-10-09 09:17:33', 'Sharable 24 hour success');
insert into "Post" (id_post, id_author, date, textBody) values (94, 33, '2022-10-05 07:33:04', 'Re-engineered system-worthy protocol');
insert into "Post" (id_post, id_author, date, textBody) values (95, 83, '2022-10-04 02:03:42', 'Proactive coherent challenge');
insert into "Post" (id_post, id_author, date, textBody) values (96, 57, '2022-10-04 09:36:02', 'Optional impactful flexibility');
insert into "Post" (id_post, id_author, date, textBody) values (97, 62, '2022-10-19 19:28:01', 'Centralized executive productivity');
insert into "Post" (id_post, id_author, date, textBody) values (98, 17, '2022-10-13 04:01:42', 'Networked maximized infrastructure');
insert into "Post" (id_post, id_author, date, textBody) values (99, 43, '2022-10-17 13:54:41', 'Open-source systematic orchestration');
insert into "Post" (id_post, id_author, date, textBody) values (100, 29, '2022-10-13 13:37:07', 'Inverse interactive Graphical User Interface');
insert into "Post" (id_post, id_author, date, textBody) values (101, 28, '2022-10-04 10:12:04', 'Diverse 3rd generation extranet');
insert into "Post" (id_post, id_author, date, textBody) values (102, 10, '2022-10-01 07:09:54', 'Stand-alone tangible product');
insert into "Post" (id_post, id_author, date, textBody) values (103, 11, '2022-10-19 05:17:40', 'Cloned 3rd generation archive');
insert into "Post" (id_post, id_author, date, textBody) values (104, 53, '2022-10-07 00:53:56', 'Visionary multi-state array');
insert into "Post" (id_post, id_author, date, textBody) values (105, 64, '2022-10-15 04:32:31', 'Operative transitional strategy');
insert into "Post" (id_post, id_author, date, textBody) values (106, 33, '2022-10-15 10:12:55', 'Quality-focused asynchronous extranet');
insert into "Post" (id_post, id_author, date, textBody) values (107, 19, '2022-10-10 09:59:45', 'Stand-alone heuristic interface');
insert into "Post" (id_post, id_author, date, textBody) values (108, 92, '2022-10-19 14:30:49', 'Secured didactic projection');
insert into "Post" (id_post, id_author, date, textBody) values (109, 3, '2022-10-01 23:49:00', 'Organized full-range intranet');
insert into "Post" (id_post, id_author, date, textBody) values (110, 33, '2022-10-13 17:37:54', 'Devolved mobile ability');










insert into "Post" (id_post, id_author, date, textBody) values (111, 2, '2022-10-08 02:58:14', 'Compatible optimal support');
insert into "Post" (id_post, id_author, date, textBody) values (112, 50, '2022-10-13 15:22:48', 'Persevering mobile Graphic Interface');
insert into "Post" (id_post, id_author, date, textBody) values (113, 72, '2022-10-17 13:03:52', 'Cloned object-oriented framework');
insert into "Post" (id_post, id_author, date, textBody) values (114, 66, '2022-10-14 01:41:26', 'Horizontal 4th generation project');
insert into "Post" (id_post, id_author, date, textBody) values (115, 86, '2022-10-11 16:53:44', 'Down-sized hybrid moderator');
insert into "Post" (id_post, id_author, date, textBody) values (116, 24, '2022-10-07 12:53:49', 'Balanced multi-state throughput');
insert into "Post" (id_post, id_author, date, textBody) values (117, 66, '2022-10-15 11:54:28', 'Reactive modular hub');
insert into "Post" (id_post, id_author, date, textBody) values (118, 92, '2022-10-07 23:54:23', 'Distributed client-server monitoring');
insert into "Post" (id_post, id_author, date, textBody) values (119, 74, '2022-10-10 19:27:18', 'Seamless optimal frame');
insert into "Post" (id_post, id_author, date, textBody) values (120, 89, '2022-10-14 14:45:27', 'Profit-focused hybrid algorithm');
insert into "Post" (id_post, id_author, date, textBody) values (121, 54, '2022-10-15 08:40:43', 'Optimized national complexity');
insert into "Post" (id_post, id_author, date, textBody) values (122, 61, '2022-10-04 22:21:09', 'Intuitive intangible Graphic Interface');
insert into "Post" (id_post, id_author, date, textBody) values (123, 45, '2022-10-18 09:13:41', 'Streamlined global conglomeration');
insert into "Post" (id_post, id_author, date, textBody) values (124, 69, '2022-10-12 11:18:11', 'Inverse exuding application');
insert into "Post" (id_post, id_author, date, textBody) values (125, 85, '2022-10-06 04:20:16', 'Up-sized zero defect archive');
insert into "Post" (id_post, id_author, date, textBody) values (126, 98, '2022-10-17 08:01:32', 'Vision-oriented interactive database');
insert into "Post" (id_post, id_author, date, textBody) values (127, 57, '2022-10-08 01:59:53', 'Centralized hybrid encryption');
insert into "Post" (id_post, id_author, date, textBody) values (128, 45, '2022-10-18 04:10:29', 'Exclusive asymmetric time-frame');
insert into "Post" (id_post, id_author, date, textBody) values (129, 67, '2022-10-05 22:02:15', 'Programmable composite process improvement');
insert into "Post" (id_post, id_author, date, textBody) values (130, 27, '2022-10-01 11:37:31', 'Operative exuding Graphic Interface');
insert into "Post" (id_post, id_author, date, textBody) values (131, 47, '2022-10-03 10:34:22', 'Secured context-sensitive functionalities');
insert into "Post" (id_post, id_author, date, textBody) values (132, 92, '2022-10-06 03:29:45', 'Monitored asymmetric definition');
insert into "Post" (id_post, id_author, date, textBody) values (133, 43, '2022-10-11 10:24:31', 'Adaptive dedicated leverage');
insert into "Post" (id_post, id_author, date, textBody) values (134, 22, '2022-10-07 04:14:56', 'Robust grid-enabled artificial intelligence');
insert into "Post" (id_post, id_author, date, textBody) values (135, 27, '2022-10-15 17:46:45', 'Centralized needs-based matrix');
insert into "Post" (id_post, id_author, date, textBody) values (136, 24, '2022-10-01 15:19:49', 'Focused dynamic product');
insert into "Post" (id_post, id_author, date, textBody) values (137, 7, '2022-10-12 04:42:59', 'Multi-lateral impactful leverage');
insert into "Post" (id_post, id_author, date, textBody) values (138, 1, '2022-10-06 03:07:27', 'Assimilated fault-tolerant strategy');
insert into "Post" (id_post, id_author, date, textBody) values (139, 71, '2022-10-09 07:13:28', 'Centralized bandwidth-monitored function');
insert into "Post" (id_post, id_author, date, textBody) values (140, 85, '2022-10-10 15:55:46', 'Advanced zero tolerance neural-net');



create table "Question" (
                          id_question SERIAL PRIMARY KEY,
                          title TEXT NOT NULL,
                          CONSTRAINT postExists
                              FOREIGN KEY(id_question)
                                  REFERENCES "Post"(id_post)
);


insert into "Question" (id_question, title) values (1, 'Man Who Shot Liberty Valance, The');
insert into "Question" (id_question, title) values (2, 'Dominick and Eugene');
insert into "Question" (id_question, title) values (3, 'Scary Movie 2');
insert into "Question" (id_question, title) values (4, 'Divorcee, The');
insert into "Question" (id_question, title) values (5, '7 Seconds');
insert into "Question" (id_question, title) values (6, 'William Shakespeare''s A Midsummer Night''s Dream');
insert into "Question" (id_question, title) values (7, 'Arthur and the Invisibles');
insert into "Question" (id_question, title) values (8, 'Texas Carnival');
insert into "Question" (id_question, title) values (9, 'Big Steal, The');
insert into "Question" (id_question, title) values (10, 'Happy End');
insert into "Question" (id_question, title) values (11, 'After Hours');
insert into "Question" (id_question, title) values (12, 'Winter Kills');
insert into "Question" (id_question, title) values (13, 'Vibrator');
insert into "Question" (id_question, title) values (14, 'Madhouse');
insert into "Question" (id_question, title) values (15, 'Devil Doll');
insert into "Question" (id_question, title) values (16, 'Harper');
insert into "Question" (id_question, title) values (17, 'Lancelot of the Lake (Lancelot du Lac)');
insert into "Question" (id_question, title) values (18, '2 Days in the Valley');
insert into "Question" (id_question, title) values (19, 'Grotesque (Gurotesuku)');
insert into "Question" (id_question, title) values (20, 'Call Me Kuchu');
insert into "Question" (id_question, title) values (21, '"Post" Mortem');
insert into "Question" (id_question, title) values (22, '''Hellboy'': The Seeds of Creation');
insert into "Question" (id_question, title) values (23, 'Doll, The (Lalka)');
insert into "Question" (id_question, title) values (24, 'Zabriskie Point');
insert into "Question" (id_question, title) values (25, 'This Is the Night');
insert into "Question" (id_question, title) values (26, 'Show Me');
insert into "Question" (id_question, title) values (27, 'Pipe Dream');
insert into "Question" (id_question, title) values (28, 'Special Forces (Forces spéciales)');
insert into "Question" (id_question, title) values (29, 'Blame It on Rio');
insert into "Question" (id_question, title) values (30, 'Year of the Hare, The (Jäniksen vuosi)');
insert into "Question" (id_question, title) values (31, 'Rocky Balboa');
insert into "Question" (id_question, title) values (32, 'Woyzeck');
insert into "Question" (id_question, title) values (33, 'Tales of the Grim Sleeper');
insert into "Question" (id_question, title) values (34, 'Piñero');
insert into "Question" (id_question, title) values (35, 'Ivan the Terrible, Part One (Ivan Groznyy I)');
insert into "Question" (id_question, title) values (36, 'Figures in a Landscape');
insert into "Question" (id_question, title) values (37, 'End of Love, The');
insert into "Question" (id_question, title) values (38, 'Fan, The');
insert into "Question" (id_question, title) values (39, 'Something Wild');
insert into "Question" (id_question, title) values (40, 'Secret Life of Walter Mitty, The');
insert into "Question" (id_question, title) values (41, 'Vanishing, The');
insert into "Question" (id_question, title) values (42, 'Wild Hearts Can''t Be Broken');
insert into "Question" (id_question, title) values (43, 'Tension at Table Rock');
insert into "Question" (id_question, title) values (44, '12 Rounds 2: Reloaded');
insert into "Question" (id_question, title) values (45, 'Jack the Giant Killer');
insert into "Question" (id_question, title) values (46, 'Match Point');
insert into "Question" (id_question, title) values (47, 'Chapayev');
insert into "Question" (id_question, title) values (48, 'Results');
insert into "Question" (id_question, title) values (49, 'Husbands and Wives');
insert into "Question" (id_question, title) values (50, 'Accidental Golfer, The (Den ofrivillige golfaren)');



CREATE TABLE "Answer" (
                        id_answer SERIAL PRIMARY KEY,
                        id_question INT NULL,
                        isSolution BOOLEAN default '0',
                            CONSTRAINT postExists
                                FOREIGN KEY(id_answer)
                                    REFERENCES "Post"(id_post),
                            CONSTRAINT questionExists
                                FOREIGN KEY(id_question)
                                    REFERENCES "Question"(id_question)
);

INSERT INTO "Answer" (id_answer,id_question,isSolution)
VALUES
    (51,19,'1'),
    (52,43,'0'),
    (53,27,'1'),
    (54,23,'0'),
    (55,48,'1'),
    (56,17,'0'),
    (57,47,'1'),
    (58,6,'1'),
    (59,5,'1'),
    (60,31,'0');
INSERT INTO "Answer" (id_answer,id_question,isSolution)
VALUES
    (61,27,'1'),
    (62,41,'1'),
    (63,33,'1'),
    (64,13,'1'),
    (65,45,'0'),
    (66,4,'0'),
    (67,39,'1'),
    (68,19,'0'),
    (69,12,'0'),
    (70,12,'1');
INSERT INTO "Answer" (id_answer,id_question,isSolution)
VALUES
    (71,5,'1'),
    (72,45,'1'),
    (73,19,'1'),
    (74,11,'0'),
    (75,16,'0'),
    (76,27,'0'),
    (77,11,'1'),
    (78,7,'1'),
    (79,26,'0'),
    (80,13,'0');
INSERT INTO "Answer" (id_answer,id_question,isSolution)
VALUES
    (81,38,'1'),
    (82,18,'0'),
    (83,22,'0'),
    (84,20,'1'),
    (85,45,'0'),
    (86,26,'0'),
    (87,41,'1'),
    (88,30,'0'),
    (89,31,'0'),
    (90,21,'0');
INSERT INTO "Answer" (id_answer,id_question,isSolution)
VALUES
    (91,31,'0'),
    (92,24,'1'),
    (93,20,'0'),
    (94,23,'1'),
    (95,41,'1'),
    (96,9,'0'),
    (97,42,'1'),
    (98,28,'1'),
    (99,42,'1'),
    (100,22,'1');
INSERT INTO "Answer" (id_answer,id_question,isSolution)
VALUES
    (101,15,'0'),
    (102,8,'1'),
    (103,45,'0'),
    (104,1,'0'),
    (105,19,'0'),
    (106,35,'1'),
    (107,17,'1'),
    (108,36,'0'),
    (109,40,'1'),
    (110,35,'0');




CREATE TABLE "Comment" (
    id_comment SERIAL PRIMARY KEY,
        CONSTRAINT postExists
            FOREIGN KEY(id_comment)
                REFERENCES "Post"(id_post)
);

INSERT INTO "Comment" (id_comment)
VALUES
    (111),
    (112),
    (113),
    (114),
    (115),
    (116),
    (117),
    (118),
    (119),
    (120);
INSERT INTO "Comment" (id_comment)
VALUES
    (121),
    (122),
    (123),
    (124),
    (125),
    (126),
    (127),
    (128),
    (129),
    (130);
INSERT INTO "Comment" (id_comment)
VALUES
    (131),
    (132),
    (133),
    (134),
    (135),
    (136),
    (137),
    (138),
    (139),
    (140);


CREATE TABLE "Draft" (
                         id_draft SERIAL PRIMARY KEY ,
                         date DATE,
                         id_author integer NOT NULL,
                         title TEXT default NULL,
                         textBody TEXT default NULL,
                             CONSTRAINT authorExists
                             FOREIGN KEY(id_author)
                             REFERENCES "User"(id_user)
);

INSERT INTO "Draft" (id_draft,date,id_author,title,textBody)
VALUES
    (1,'2022-09-18 09:10:41',83,'lorem vitae odio sagittis semper. Nam','placerat, orci lacus vestibulum lorem, sit amet ultricies'),
    (2,'2022-08-10 12:39:59',40,'turpis non enim. Mauris','Fusce fermentum fermentum arcu. Vestibulum ante'),
    (3,'2022-05-14 11:43:14',88,'magnis dis parturient montes, nascetur ridiculus mus.','arcu iaculis enim, sit amet ornare lectus'),
    (4,'2022-08-09 19:37:15',13,'mi enim, condimentum eget, volutpat ornare, facilisis eget,','tempor diam dictum sapien. Aenean massa. Integer vitae nibh. Donec est mauris,'),
    (5,'2022-09-12 09:36:13',46,'Nunc quis arcu vel','commodo at, libero. Morbi accumsan laoreet ipsum. Curabitur consequat, lectus sit amet luctus vulputate, nisi sem semper');



CREATE TABLE "Tag"
(
    id_tag SERIAL PRIMARY KEY,
    name   TEXT NOT NULL UNIQUE
);

INSERT INTO "Tag" (name) VALUES ('eli5');
INSERT INTO "Tag" (name) VALUES ('politics');
INSERT INTO "Tag" (name) VALUES ('economics');
INSERT INTO "Tag" (name) VALUES ('economy');
INSERT INTO "Tag" (name) VALUES ('law');
INSERT INTO "Tag" (name) VALUES ('constitution');
INSERT INTO "Tag" (name) VALUES ('rights');
INSERT INTO "Tag" (name) VALUES ('global');
INSERT INTO "Tag" (name) VALUES ('international');
INSERT INTO "Tag" (name) VALUES ('court');
INSERT INTO "Tag" (name) VALUES ('authoritarian');
INSERT INTO "Tag" (name) VALUES ('libertarian');
INSERT INTO "Tag" (name) VALUES ('left');
INSERT INTO "Tag" (name) VALUES ('right');
INSERT INTO "Tag" (name) VALUES ('extremism');
INSERT INTO "Tag" (name) VALUES ('radical');
INSERT INTO "Tag" (name) VALUES ('capitalism');
INSERT INTO "Tag" (name) VALUES ('communism');
INSERT INTO "Tag" (name) VALUES ('parliament');
INSERT INTO "Tag" (name) VALUES ('government');
INSERT INTO "Tag" (name) VALUES ('judge');
INSERT INTO "Tag" (name) VALUES ('police');
INSERT INTO "Tag" (name) VALUES ('jail');
INSERT INTO "Tag" (name) VALUES ('obligation');
INSERT INTO "Tag" (name) VALUES ('taxes');


CREATE TABLE "QuestionTag" (
                               id_tag INT NOT NULL,
                               id_question INT NOT NULL,
                               PRIMARY KEY (id_tag, id_question),
                                   CONSTRAINT tagExists
                                        FOREIGN KEY(id_tag)
                                            REFERENCES "Tag"(id_tag),
                                    CONSTRAINT questionExists
                                        FOREIGN KEY(id_question)
                                            REFERENCES "Question"(id_question)
);

INSERT INTO "QuestionTag" (id_tag,id_question)
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
INSERT INTO "QuestionTag" (id_tag,id_question)
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
INSERT INTO "QuestionTag" (id_tag,id_question)
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
INSERT INTO "QuestionTag" (id_tag,id_question)
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
INSERT INTO "QuestionTag" (id_tag,id_question)
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
INSERT INTO "QuestionTag" (id_tag,id_question)
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
INSERT INTO "QuestionTag" (id_tag,id_question)
VALUES
    (10,25),
    (18,19),
    (5,34),
    (2,42),
    (5,31),
    (19,5),
    (22,26),
    (25,41);
INSERT INTO "QuestionTag" (id_tag,id_question)
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


