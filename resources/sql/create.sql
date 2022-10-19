DROP TABLE IF EXISTS post CASCADE; --140
DROP TABLE IF EXISTS question CASCADE; --50
DROP TABLE IF EXISTS answer CASCADE; --60
DROP TABLE IF EXISTS comment CASCADE; --30
DROP TABLE IF EXISTS draft CASCADE; --5
DROP TABLE IF EXISTS tag CASCADE; --25
DROP TABLE IF EXISTS question_tag CASCADE;
DROP TABLE IF EXISTS "user" CASCADE;

--notifs
DROP TABLE IF EXISTS notifications CASCADE;
DROP TABLE IF EXISTS system_Notif CASCADE;
DROP TABLE IF EXISTS follow_tag_notif CASCADE;
DROP TABLE IF EXISTS marked_as_solution_notif CASCADE;
DROP TABLE IF EXISTS new_badge_notif CASCADE;
DROP TABLE IF EXISTS new_answer_notif CASCADE;
DROP TABLE IF EXISTS followed_question_notif CASCADE;

--badges
DROP TABLE IF EXISTS badge CASCADE;
DROP TABLE IF EXISTS badge_given CASCADE; --30
DROP TABLE IF EXISTS follows_tag CASCADE; --100
DROP TABLE IF EXISTS follows_question CASCADE; --15
DROP TABLE IF EXISTS question_vote CASCADE; --200
DROP TABLE IF EXISTS answer_vote CASCADE; --300

DROP TYPE IF EXISTS rank;

create table "user" (
	id_user SERIAL PRIMARY KEY,
	username VARCHAR(50),
	email VARCHAR(50),
	password TEXT,
	profilePicture TEXT,
	personalText TEXT
);

insert into "user" (id_user, username, email, password, profilePicture, personalText) values (1, 'anuschke0', 'pdaouse0@nature.com', 'Eb3BBl', 'https://robohash.org/etcorporispossimus.png?size=50x50&set=set1', '');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (2, 'bekell1', 'rpennicard1@hao123.com', '9FEnHZkC', 'https://robohash.org/officiaipsamofficiis.png?size=50x50&set=set1', 'maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (3, 'pcalven2', 'bdaudray2@sfgate.com', 'W2l5yKN4Ffj', null, 'vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (4, 'ayorath3', 'gcurmi3@dion.ne.jp', '45z1G3gU6', 'https://robohash.org/quasidebitisaliquid.png?size=50x50&set=set1', 'scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (5, 'fmurray4', 'lshrimplin4@cafepress.com', 'ECpX3g45', null, 'dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (6, 'gmoden5', 'lfollitt5@comsenz.com', 'szV7jLoNHXy', 'https://robohash.org/estrationeaut.png?size=50x50&set=set1', 'a libero nam dui proin leo odio porttitor id');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (7, 'togriffin6', 'kfitzgibbon6@mtv.com', 'GP3rxKQ8', null, 'suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (8, 'hmeddows7', 'dtolson7@1und1.de', 'OQD2If072Up', 'https://robohash.org/nisiexpeditaquidem.png?size=50x50&set=set1', null);
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (9, 'rgerred8', 'ncrat8@bluehost.com', '8eKA1Iq', 'https://robohash.org/aperiamautrepellat.png?size=50x50&set=set1', null);
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (10, 'rvandevelde9', 'dwillingam9@theatlantic.com', 'sjQmy2KUL9va', 'https://robohash.org/nemonecessitatibusnihil.png?size=50x50&set=set1', '');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (11, 'asneakera', 'ndeeslya@fastcompany.com', 'tIvToY', null, 'mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (12, 'bboardb', 'clarmanb@wisc.edu', '9y1KePwc3wo', 'https://robohash.org/laboriosamquidemnulla.png?size=50x50&set=set1', 'augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (13, 'rblakec', 'tgrosvenerc@rakuten.co.jp', 'Hms5ygn', 'https://robohash.org/occaecatidistinctiodicta.png?size=50x50&set=set1', 'erat eros viverra');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (14, 'cburrasd', 'stwiddyd@usa.gov', 'cG3Lyq', 'https://robohash.org/dolorumestpossimus.png?size=50x50&set=set1', null);
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (15, 'bcristofaninie', 'hheliare@skype.com', 'Mox6IKJf7G', null, null);
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (16, 'ghendrenf', 'ahewf@mediafire.com', 'N679OUSLcNcv', 'https://robohash.org/autcorruptiet.png?size=50x50&set=set1', 'odio condimentum id luctus nec molestie sed');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (17, 'bwalbrung', 'fbartrumg@weather.com', 'kEGeA1stzT', null, 'libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (18, 'bchritchleyh', 'adelafonth@photobucket.com', 'uPZvFJmA', null, null);
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (19, 'eclitheroei', 'sbandti@dropbox.com', 'jtV7jjiX', null, 'erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (20, 'jspeakej', 'nlesaunierj@unicef.org', 'gglUvzcRxPi', 'https://robohash.org/quissaepemolestiae.png?size=50x50&set=set1', 'neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (21, 'mjansikk', 'uwolfendellk@ovh.net', 'TEAFeWz', 'https://robohash.org/nobisminusvoluptatibus.png?size=50x50&set=set1', 'pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (22, 'ekiehnel', 'imurrishl@usa.gov', 'L86gXM9', null, 'duis bibendum felis sed interdum');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (23, 'dcayzerm', 'dfullbrookm@facebook.com', 'tCmDGUfq', 'https://robohash.org/praesentiumlaborenecessitatibus.png?size=50x50&set=set1', 'consequat in consequat ut nulla sed accumsan felis ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (24, 'dtucknuttn', 'ajorcken@java.com', 'ZwWsW2otU2Fq', 'https://robohash.org/anobismaxime.png?size=50x50&set=set1', null);
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (25, 'gheaselgraveo', 'acogleo@posterous.com', 'rZkVoMlAA', 'https://robohash.org/impeditnonquibusdam.png?size=50x50&set=set1', null);
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (26, 'rscowcroftp', 'lzarfatp@shop-pro.jp', 'yRbvlP', 'https://robohash.org/architectomodiomnis.png?size=50x50&set=set1', 'non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (27, 'ehanhardtq', 'ckrollq@webeden.co.uk', 'a5rVxUX', 'https://robohash.org/numquamassumendaquo.png?size=50x50&set=set1', 'sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (28, 'dranklinr', 'emohammedr@independent.co.uk', 'Xlfa80x72NL', null, 'magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (29, 'lmathewess', 'glinsteads@omniture.com', 'iJMWbpRhc', null, 'mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (30, 'tmcgauhyt', 'wsinclairt@twitter.com', '0UYf8N1', 'https://robohash.org/totamvoluptatemoccaecati.png?size=50x50&set=set1', 'tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (31, 'ihaeslieru', 'epavelkau@phoca.cz', 'nqW7Fg8VpR', 'https://robohash.org/doloremanimiex.png?size=50x50&set=set1', 'neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (32, 'shartellv', 'ehalmsv@dagondesign.com', 'Kv1i4M9', 'https://robohash.org/aliquidvoluptasunde.png?size=50x50&set=set1', 'amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (33, 'rordeltw', 'jottleyw@salon.com', 'mM0Wh6fS', 'https://robohash.org/idblanditiisfacere.png?size=50x50&set=set1', 'in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (34, 'mnotmanx', 'hlatteyx@simplemachines.org', 'UtEGDO2a', null, 'primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (35, 'kbrisseauy', 'naleksandrovy@unesco.org', 'BMbwgH8N1N', 'https://robohash.org/velarchitectominima.png?size=50x50&set=set1', null);
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (36, 'pmcminnz', 'gboleynz@soundcloud.com', '0NaM7Ok', 'https://robohash.org/nullaeosillo.png?size=50x50&set=set1', 'nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (37, 'cmantripp10', 'deliot10@etsy.com', 'p1418n0', 'https://robohash.org/quasivoluptasut.png?size=50x50&set=set1', 'lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (38, 'aalderson11', 'dconibear11@tripadvisor.com', 'dabl38', null, null);
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (39, 'gajean12', 'scamplen12@trellian.com', 'ghyufTco', 'https://robohash.org/voluptasdoloremreiciendis.png?size=50x50&set=set1', 'amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (40, 'pkop13', 'ginott13@123-reg.co.uk', '4lIdNqdWg', 'https://robohash.org/consecteturiustonulla.png?size=50x50&set=set1', null);
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (41, 'alivingston14', 'vhousaman14@japanpost.jp', 'oYc12WcB8n', 'https://robohash.org/delenitietimpedit.png?size=50x50&set=set1', 'magna at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (42, 'imccosh15', 'cgreim15@sbwire.com', 'Xn0uwrQ25', 'https://robohash.org/velitaliquidquo.png?size=50x50&set=set1', 'odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (43, 'krizzetti16', 'rmccambrois16@shareasale.com', 'hhVPC4', 'https://robohash.org/rerumvoluptatumqui.png?size=50x50&set=set1', null);
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (44, 'glagneaux17', 'hranscome17@360.cn', 'fOcmTyZ', null, 'justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (45, 'fandreucci18', 'ckenner18@etsy.com', 'XHtWAlVm', 'https://robohash.org/dignissimosaccusantiumdeleniti.png?size=50x50&set=set1', null);
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (46, 'nmulleary19', 'kquantick19@dot.gov', '2YDalu8', 'https://robohash.org/recusandaeabquibusdam.png?size=50x50&set=set1', 'felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (47, 'glantoph1a', 'fleftley1a@goodreads.com', '852Qpf', 'https://robohash.org/recusandaeharumvoluptate.png?size=50x50&set=set1', 'sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (48, 'eputtnam1b', 'lfoulgham1b@bizjournals.com', '3pm4sK', 'https://robohash.org/quiquiaoccaecati.png?size=50x50&set=set1', 'tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (49, 'elamberts1c', 'stilt1c@biglobe.ne.jp', 'xTH2Qgo122', 'https://robohash.org/porroautemearum.png?size=50x50&set=set1', 'lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (50, 'mtailour1d', 'nbassil1d@aboutads.info', 'vuRPMFR', 'https://robohash.org/ipsamdoloremprovident.png?size=50x50&set=set1', 'nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (51, 'jneem1e', 'gfelgat1e@chron.com', 'eGBywlZLA', 'https://robohash.org/sedenimsint.png?size=50x50&set=set1', 'tempor convallis nulla neque libero convallis eget eleifend luctus');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (52, 'hpareman1f', 'naishford1f@squarespace.com', 'ULrHVK8w6QFt', 'https://robohash.org/ipsumidporro.png?size=50x50&set=set1', 'lobortis');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (53, 'marnoult1g', 'cnelane1g@lulu.com', 'KBUcJ3R2', null, null);
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (54, 'rfeatherstone1h', 'cbaroch1h@technorati.com', 'q5tpn4', 'https://robohash.org/eosrerumexcepturi.png?size=50x50&set=set1', 'nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (55, 'odellenty1i', 'ainstone1i@ft.com', 'aojpUC', 'https://robohash.org/autemfacilisin.png?size=50x50&set=set1', 'at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (56, 'epiggrem1j', 'obertelsen1j@eepurl.com', 'y5HxfS21Qq', null, null);
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (57, 'eclack1k', 'hnaile1k@nationalgeographic.com', 'caxB3LhOuY', null, 'urna ut tellus nulla ut erat id mauris vulputate elementum');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (58, 'owhetnall1l', 'afelten1l@shinystat.com', 'Fufa464aC', 'https://robohash.org/omnisvelquod.png?size=50x50&set=set1', 'nam nulla integer pede justo');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (59, 'ebuncombe1m', 'jderycot1m@yellowbook.com', 'pKfUikUO5HY', null, 'vel');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (60, 'marmatage1n', 'astrongitharm1n@slate.com', 'mGecI98JzrQq', null, 'potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (61, 'plafuente1o', 'kyurin1o@360.cn', 'QFj8ZyZJaGUY', 'https://robohash.org/quasiimpeditdolor.png?size=50x50&set=set1', 'lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (62, 'lbatchelour1p', 'tbraidon1p@istockphoto.com', 'PnvRNey', null, 'eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (63, 'bhartman1q', 'tbucham1q@simplemachines.org', 'NuLSKYxUlbMJ', 'https://robohash.org/sedquiet.png?size=50x50&set=set1', 'orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (64, 'wdartnall1r', 'dmeech1r@nydailynews.com', 'lbFkEFO', 'https://robohash.org/minimasimiliqueadipisci.png?size=50x50&set=set1', 'turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (65, 'atrevain1s', 'ejosilevich1s@who.int', 'lYvbfnQl9L', 'https://robohash.org/consecteturdoloribusrepudiandae.png?size=50x50&set=set1', 'sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (66, 'amurison1t', 'dgreve1t@amazonaws.com', 'ughj5xa4', 'https://robohash.org/quiperferendisrepudiandae.png?size=50x50&set=set1', null);
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (67, 'agatrill1u', 'akilmary1u@addthis.com', 'L8D1HSYj', 'https://robohash.org/sapientealiquida.png?size=50x50&set=set1', null);
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (68, 'gphizackarley1v', 'cwestwell1v@harvard.edu', 'kWYVsdZQF', 'https://robohash.org/nullafugiatquasi.png?size=50x50&set=set1', 'in');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (69, 'jmetzke1w', 'cpau1w@salon.com', 'DjSmBH2ztsXa', 'https://robohash.org/distinctionobisfacere.png?size=50x50&set=set1', null);
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (70, 'tmarusyak1x', 'kribbon1x@diigo.com', 'Z7qJTznNyR', 'https://robohash.org/porroquiaccusamus.png?size=50x50&set=set1', 'felis sed interdum venenatis turpis enim blandit mi in porttitor pede');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (71, 'rleacock1y', 'agilvary1y@usgs.gov', 'X0t9xh', 'https://robohash.org/temporerepellatiusto.png?size=50x50&set=set1', 'ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (72, 'dwinterbottom1z', 'jbrogi1z@123-reg.co.uk', '0qZrEDi', 'https://robohash.org/quispraesentiumvero.png?size=50x50&set=set1', 'interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis at velit eu est congue elementum in hac habitasse');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (73, 'babbs20', 'vrogan20@hibu.com', 'HuiU5an', null, 'morbi');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (74, 'amotion21', 'pocalleran21@simplemachines.org', 'pJfe7UkDO', 'https://robohash.org/quoautnon.png?size=50x50&set=set1', null);
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (75, 'ehiner22', 'elile22@spiegel.de', '5b2B4SSx2sXp', 'https://robohash.org/consequaturestquia.png?size=50x50&set=set1', null);
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (76, 'rcoop23', 'bsazio23@salon.com', 'Uu6DixN', null, 'posuere');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (77, 'bconring24', 'bwickwarth24@npr.org', 'akneJxjXHWF', 'https://robohash.org/isteetvel.png?size=50x50&set=set1', 'turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (78, 'foneil25', 'bvears25@mtv.com', '42UKiPzbjiiG', null, 'lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (79, 'brendbaek26', 'pdewerson26@pcworld.com', 'jr9TJuBfoFnF', 'https://robohash.org/suscipitquiquidem.png?size=50x50&set=set1', 'vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (80, 'vchatainier27', 'msheppey27@cbsnews.com', 'DoHXG1nL3Ol', null, 'ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (81, 'laronowitz28', 'bseawell28@youtube.com', 'JojJQjRwJ', 'https://robohash.org/etsuscipitlaudantium.png?size=50x50&set=set1', null);
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (82, 'gburlingham29', 'sdossettor29@soup.io', 'LkMlEmk', 'https://robohash.org/eaquoscumque.png?size=50x50&set=set1', 'rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (83, 'ayannoni2a', 'gcampling2a@bloglines.com', '9iKQkE', null, 'in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (84, 'iterzo2b', 'hgrigorushkin2b@plala.or.jp', 'yKnmUjqoBeJM', null, 'justo in');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (85, 'lhars2c', 'cmcclay2c@cargocollective.com', 'CoTQ1937bb', null, 'a suscipit nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (86, 'abowe2d', 'evaskin2d@ocn.ne.jp', 'igJamiWDqwb3', 'https://robohash.org/quosreprehenderitvoluptatem.png?size=50x50&set=set1', 'eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (87, 'lborris2e', 'sdunning2e@wikimedia.org', '81yPQIZkDM', null, null);
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (88, 'ddreini2f', 'npavluk2f@e-recht24.de', 'kO86XBls6', 'https://robohash.org/porroetet.png?size=50x50&set=set1', 'ullamcorper augue a');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (89, 'gjirus2g', 'cdri2g@canalblog.com', 'iuGkbtIqS5', 'https://robohash.org/voluptatumetullam.png?size=50x50&set=set1', 'risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (90, 'lbuttler2h', 'hstratiff2h@globo.com', 'XagcmE2', 'https://robohash.org/ipsumestomnis.png?size=50x50&set=set1', 'a nibh in quis justo');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (91, 'agallienne2i', 'bbarents2i@skype.com', 'oM14lxz', 'https://robohash.org/utrationequaerat.png?size=50x50&set=set1', null);
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (92, 'sbolle2j', 'glancastle2j@google.it', '2xwf8Zvf4S', null, null);
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (93, 'tleggan2k', 'dpeirson2k@mapquest.com', 'jkgGHcfoyE', 'https://robohash.org/accusamussedlibero.png?size=50x50&set=set1', 'nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (94, 'sbrilon2l', 'mbriand2l@lycos.com', '9Oz8h40', null, 'semper interdum');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (95, 'kphelit2m', 'ecampsall2m@fda.gov', '9pMkAOew', 'https://robohash.org/debitisdoloresnulla.png?size=50x50&set=set1', 'viverra pede ac diam cras pellentesque volutpat dui maecenas');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (96, 'gsteuhlmeyer2n', 'mdelacey2n@cam.ac.uk', 'GQXNhyDljvS', 'https://robohash.org/sapientenecessitatibuseos.png?size=50x50&set=set1', 'eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (97, 'acouper2o', 'bcurwood2o@example.com', 'PZnF1QTL', null, null);
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (98, 'htrevett2p', 'jhallybone2p@harvard.edu', 'JSsxNNac', 'https://robohash.org/quidistinctiosit.png?size=50x50&set=set1', 'magna vestibulum aliquet ultrices erat tortor sollicitudin mi');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (99, 'plinnock2q', 'tbetz2q@umn.edu', 'lCLaNotiy', 'https://robohash.org/sintsintvoluptatem.png?size=50x50&set=set1', 'id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo');
insert into "user" (id_user, username, email, password, profilePicture, personalText) values (100, 'mcommings2r', 'bsmithyman2r@spiegel.de', 'Uad8SHcY4', 'https://robohash.org/animicumquenam.png?size=50x50&set=set1', 'sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis');

create table administrator (
    id_admin INT PRIMARY KEY,
          CONSTRAINT userExists
            FOREIGN KEY(id_admin)
              REFERENCES "user"(id_user)
);
insert into administrator (id_admin) values (96);
insert into administrator (id_admin) values (53);

create table moderator (
    id_moderator INT PRIMARY KEY,
          CONSTRAINT userExists
            FOREIGN KEY(id_moderator)
              REFERENCES "user"(id_user)
);
insert into moderator (id_moderator) values (18);
insert into moderator (id_moderator) values (93);
insert into moderator (id_moderator) values (10);
insert into moderator (id_moderator) values (8);
insert into moderator (id_moderator) values (92);
insert into moderator (id_moderator) values (67);
insert into moderator (id_moderator) values (81);

create table post (
                      id_post SERIAL PRIMARY KEY,
                      id_author INT NOT NULL,
                      date DATE NOT NULL,
                      text_body TEXT NOT NULL,
                      CONSTRAINT FK_AUTHOR
                          FOREIGN KEY(id_author)
                              REFERENCES "user"(id_user)

);


insert into post (id_post, id_author, date, text_body) values (1, 42, '2022-10-09 12:05:12', 'Optional logistical matrix');
insert into post (id_post, id_author, date, text_body) values (2, 65, '2022-10-11 09:48:14', 'Synchronised non-volatile knowledge user');
insert into post (id_post, id_author, date, text_body) values (3, 17, '2022-10-16 19:28:21', 'Mandatory neutral instruction set');
insert into post (id_post, id_author, date, text_body) values (4, 13, '2022-10-07 06:46:45', 'Distributed dedicated open architecture');
insert into post (id_post, id_author, date, text_body) values (5, 73, '2022-10-03 12:15:19', 'Re-contextualized web-enabled application');
insert into post (id_post, id_author, date, text_body) values (6, 99, '2022-10-15 02:52:08', 'Virtual eco-centric function');
insert into post (id_post, id_author, date, text_body) values (7, 41, '2022-10-13 18:00:19', 'Balanced regional extranet');
insert into post (id_post, id_author, date, text_body) values (8, 65, '2022-10-18 01:43:52', 'Customizable value-added paradigm');
insert into post (id_post, id_author, date, text_body) values (9, 17, '2022-10-02 09:39:02', 'Profound demand-driven challenge');
insert into post (id_post, id_author, date, text_body) values (10, 56, '2022-10-13 07:45:49', 'Synergized logistical circuit');
insert into post (id_post, id_author, date, text_body) values (11, 29, '2022-10-16 09:11:49', 'Virtual bifurcated structure');
insert into post (id_post, id_author, date, text_body) values (12, 91, '2022-10-04 19:58:15', 'Programmable uniform local area network');
insert into post (id_post, id_author, date, text_body) values (13, 86, '2022-10-04 17:00:02', 'Multi-layered heuristic ability');
insert into post (id_post, id_author, date, text_body) values (14, 18, '2022-10-10 00:45:39', 'Inverse systemic software');
insert into post (id_post, id_author, date, text_body) values (15, 57, '2022-10-18 10:01:21', 'Visionary executive local area network');
insert into post (id_post, id_author, date, text_body) values (16, 62, '2022-10-10 20:37:58', 'Universal systemic throughput');
insert into post (id_post, id_author, date, text_body) values (17, 77, '2022-10-15 16:50:50', 'Reverse-engineered well-modulated pricing structure');
insert into post (id_post, id_author, date, text_body) values (18, 74, '2022-10-15 04:31:29', 'User-friendly multimedia core');
insert into post (id_post, id_author, date, text_body) values (19, 27, '2022-10-02 15:09:08', 'Integrated multimedia moratorium');
insert into post (id_post, id_author, date, text_body) values (20, 4, '2022-10-13 23:34:45', 'Expanded clear-thinking core');
insert into post (id_post, id_author, date, text_body) values (21, 99, '2022-10-18 11:26:25', 'Mandatory intermediate info-mediaries');
insert into post (id_post, id_author, date, text_body) values (22, 52, '2022-10-14 14:01:08', 'Universal zero defect focus group');
insert into post (id_post, id_author, date, text_body) values (23, 61, '2022-10-04 10:26:48', 'Re-contextualized motivating hub');
insert into post (id_post, id_author, date, text_body) values (24, 42, '2022-10-11 01:44:44', 'Ameliorated executive middleware');
insert into post (id_post, id_author, date, text_body) values (25, 77, '2022-10-03 11:52:53', 'Customer-focused leading edge standardization');
insert into post (id_post, id_author, date, text_body) values (26, 93, '2022-10-16 19:36:55', 'Re-contextualized methodical initiative');
insert into post (id_post, id_author, date, text_body) values (27, 41, '2022-10-18 22:01:25', 'Re-engineered heuristic archive');
insert into post (id_post, id_author, date, text_body) values (28, 68, '2022-10-17 20:54:17', 'Persevering client-driven support');
insert into post (id_post, id_author, date, text_body) values (29, 32, '2022-10-06 13:27:36', 'Adaptive reciprocal hardware');
insert into post (id_post, id_author, date, text_body) values (30, 85, '2022-10-15 23:10:35', 'Mandatory client-server matrices');
insert into post (id_post, id_author, date, text_body) values (31, 60, '2022-10-12 23:38:42', 'Ergonomic discrete frame');
insert into post (id_post, id_author, date, text_body) values (32, 46, '2022-10-16 05:02:01', 'De-engineered 6th generation software');
insert into post (id_post, id_author, date, text_body) values (33, 96, '2022-10-09 20:39:54', 'Digitized executive core');
insert into post (id_post, id_author, date, text_body) values (34, 52, '2022-10-10 23:45:42', 'Multi-lateral coherent pricing structure');
insert into post (id_post, id_author, date, text_body) values (35, 59, '2022-10-05 18:08:08', 'Mandatory solution-oriented model');
insert into post (id_post, id_author, date, text_body) values (36, 32, '2022-10-04 13:48:48', 'Devolved responsive capability');
insert into post (id_post, id_author, date, text_body) values (37, 86, '2022-10-13 18:36:06', 'Polarised full-range ability');
insert into post (id_post, id_author, date, text_body) values (38, 53, '2022-10-18 14:36:03', 'Synergistic attitude-oriented paradigm');
insert into post (id_post, id_author, date, text_body) values (39, 58, '2022-10-01 06:03:31', 'Re-contextualized explicit middleware');
insert into post (id_post, id_author, date, text_body) values (40, 57, '2022-10-15 19:33:49', 'Synergistic didactic knowledge base');
insert into post (id_post, id_author, date, text_body) values (41, 95, '2022-10-14 14:30:14', 'Synergistic client-server core');
insert into post (id_post, id_author, date, text_body) values (42, 85, '2022-10-18 16:06:37', 'User-centric intangible implementation');
insert into post (id_post, id_author, date, text_body) values (43, 78, '2022-10-08 17:13:47', 'Total multi-state process improvement');
insert into post (id_post, id_author, date, text_body) values (44, 99, '2022-10-09 05:11:52', 'Virtual 4th generation adapter');
insert into post (id_post, id_author, date, text_body) values (45, 53, '2022-10-02 14:29:08', 'Quality-focused static intranet');
insert into post (id_post, id_author, date, text_body) values (46, 89, '2022-10-06 10:29:34', 'Monitored content-based application');
insert into post (id_post, id_author, date, text_body) values (47, 51, '2022-10-05 15:47:12', 'Profit-focused scalable budgetary management');
insert into post (id_post, id_author, date, text_body) values (48, 38, '2022-10-14 12:56:29', 'Object-based multi-state access');
insert into post (id_post, id_author, date, text_body) values (49, 81, '2022-10-17 10:37:43', 'Balanced system-worthy framework');
insert into post (id_post, id_author, date, text_body) values (50, 81, '2022-10-13 22:45:07', 'Visionary object-oriented architecture');










insert into post (id_post, id_author, date, text_body) values (51, 62, '2022-10-16 03:30:07', 'Triple-buffered hybrid hierarchy');
insert into post (id_post, id_author, date, text_body) values (52, 41, '2022-10-13 11:12:59', 'Cloned client-driven budgetary management');
insert into post (id_post, id_author, date, text_body) values (53, 56, '2022-10-01 19:18:58', 'Universal zero defect adapter');
insert into post (id_post, id_author, date, text_body) values (54, 71, '2022-10-03 17:41:21', 'Implemented coherent intranet');
insert into post (id_post, id_author, date, text_body) values (55, 25, '2022-10-06 08:18:55', 'Open-source logistical frame');
insert into post (id_post, id_author, date, text_body) values (56, 35, '2022-10-01 04:50:45', 'De-engineered maximized neural-net');
insert into post (id_post, id_author, date, text_body) values (57, 27, '2022-10-02 06:12:59', 'Managed fresh-thinking complexity');
insert into post (id_post, id_author, date, text_body) values (58, 52, '2022-10-13 12:22:54', 'Organic optimizing migration');
insert into post (id_post, id_author, date, text_body) values (59, 22, '2022-10-11 06:56:52', 'Grass-roots national methodology');
insert into post (id_post, id_author, date, text_body) values (60, 69, '2022-10-17 15:04:30', 'Visionary multi-tasking forecast');
insert into post (id_post, id_author, date, text_body) values (61, 43, '2022-10-15 07:51:55', 'Horizontal zero defect standardization');
insert into post (id_post, id_author, date, text_body) values (62, 34, '2022-10-17 16:04:36', 'Face to face analyzing paradigm');
insert into post (id_post, id_author, date, text_body) values (63, 34, '2022-10-05 12:09:09', 'Synergistic eco-centric intranet');
insert into post (id_post, id_author, date, text_body) values (64, 57, '2022-10-10 01:11:19', 'Grass-roots asymmetric matrices');
insert into post (id_post, id_author, date, text_body) values (65, 46, '2022-10-01 21:59:06', 'Focused leading edge migration');
insert into post (id_post, id_author, date, text_body) values (66, 87, '2022-10-16 20:00:56', 'Advanced 24/7 budgetary management');
insert into post (id_post, id_author, date, text_body) values (67, 92, '2022-10-13 00:14:02', 'Programmable non-volatile customer loyalty');
insert into post (id_post, id_author, date, text_body) values (68, 87, '2022-10-16 03:41:15', 'Re-contextualized coherent model');
insert into post (id_post, id_author, date, text_body) values (69, 88, '2022-10-19 17:32:27', 'Networked well-modulated circuit');
insert into post (id_post, id_author, date, text_body) values (70, 54, '2022-10-06 11:44:56', 'Optional 24 hour open architecture');
insert into post (id_post, id_author, date, text_body) values (71, 24, '2022-10-16 05:01:09', 'Fully-configurable reciprocal policy');
insert into post (id_post, id_author, date, text_body) values (72, 37, '2022-10-05 12:12:45', 'Networked incremental application');
insert into post (id_post, id_author, date, text_body) values (73, 3, '2022-10-17 06:36:18', 'Total systemic project');
insert into post (id_post, id_author, date, text_body) values (74, 7, '2022-10-12 20:23:28', 'Up-sized composite capacity');
insert into post (id_post, id_author, date, text_body) values (75, 77, '2022-10-10 22:13:52', 'Integrated zero tolerance instruction set');
insert into post (id_post, id_author, date, text_body) values (76, 12, '2022-10-11 04:40:39', 'Synchronised solution-oriented support');
insert into post (id_post, id_author, date, text_body) values (77, 92, '2022-10-03 11:27:11', 'Profit-focused contextually-based model');
insert into post (id_post, id_author, date, text_body) values (78, 93, '2022-10-06 17:15:51', 'Synergistic background workforce');
insert into post (id_post, id_author, date, text_body) values (79, 40, '2022-10-15 01:18:38', 'Multi-layered attitude-oriented projection');
insert into post (id_post, id_author, date, text_body) values (80, 52, '2022-10-19 18:19:05', 'Automated clear-thinking success');
insert into post (id_post, id_author, date, text_body) values (81, 48, '2022-10-10 22:00:33', 'De-engineered non-volatile data-warehouse');
insert into post (id_post, id_author, date, text_body) values (82, 45, '2022-10-16 05:48:59', 'Up-sized grid-enabled help-desk');
insert into post (id_post, id_author, date, text_body) values (83, 78, '2022-10-10 17:18:57', 'User-friendly zero defect capability');
insert into post (id_post, id_author, date, text_body) values (84, 45, '2022-10-10 13:40:18', 'Right-sized empowering approach');
insert into post (id_post, id_author, date, text_body) values (85, 9, '2022-10-10 08:36:55', 'Operative discrete groupware');
insert into post (id_post, id_author, date, text_body) values (86, 16, '2022-10-02 14:19:31', 'User-centric uniform extranet');
insert into post (id_post, id_author, date, text_body) values (87, 13, '2022-10-18 04:44:41', 'Enterprise-wide 24/7 hierarchy');
insert into post (id_post, id_author, date, text_body) values (88, 51, '2022-10-04 13:14:29', 'Public-key neutral knowledge base');
insert into post (id_post, id_author, date, text_body) values (89, 93, '2022-10-12 22:11:21', 'Implemented didactic software');
insert into post (id_post, id_author, date, text_body) values (90, 52, '2022-10-17 00:09:08', 'Up-sized next generation groupware');
insert into post (id_post, id_author, date, text_body) values (91, 86, '2022-10-18 03:14:18', 'Optimized attitude-oriented data-warehouse');
insert into post (id_post, id_author, date, text_body) values (92, 6, '2022-10-15 16:34:36', 'Multi-layered needs-based policy');
insert into post (id_post, id_author, date, text_body) values (93, 73, '2022-10-09 09:17:33', 'Sharable 24 hour success');
insert into post (id_post, id_author, date, text_body) values (94, 33, '2022-10-05 07:33:04', 'Re-engineered system-worthy protocol');
insert into post (id_post, id_author, date, text_body) values (95, 83, '2022-10-04 02:03:42', 'Proactive coherent challenge');
insert into post (id_post, id_author, date, text_body) values (96, 57, '2022-10-04 09:36:02', 'Optional impactful flexibility');
insert into post (id_post, id_author, date, text_body) values (97, 62, '2022-10-19 19:28:01', 'Centralized executive productivity');
insert into post (id_post, id_author, date, text_body) values (98, 17, '2022-10-13 04:01:42', 'Networked maximized infrastructure');
insert into post (id_post, id_author, date, text_body) values (99, 43, '2022-10-17 13:54:41', 'Open-source systematic orchestration');
insert into post (id_post, id_author, date, text_body) values (100, 29, '2022-10-13 13:37:07', 'Inverse interactive Graphical User Interface');
insert into post (id_post, id_author, date, text_body) values (101, 28, '2022-10-04 10:12:04', 'Diverse 3rd generation extranet');
insert into post (id_post, id_author, date, text_body) values (102, 10, '2022-10-01 07:09:54', 'Stand-alone tangible product');
insert into post (id_post, id_author, date, text_body) values (103, 11, '2022-10-19 05:17:40', 'Cloned 3rd generation archive');
insert into post (id_post, id_author, date, text_body) values (104, 53, '2022-10-07 00:53:56', 'Visionary multi-state array');
insert into post (id_post, id_author, date, text_body) values (105, 64, '2022-10-15 04:32:31', 'Operative transitional strategy');
insert into post (id_post, id_author, date, text_body) values (106, 33, '2022-10-15 10:12:55', 'Quality-focused asynchronous extranet');
insert into post (id_post, id_author, date, text_body) values (107, 19, '2022-10-10 09:59:45', 'Stand-alone heuristic interface');
insert into post (id_post, id_author, date, text_body) values (108, 92, '2022-10-19 14:30:49', 'Secured didactic projection');
insert into post (id_post, id_author, date, text_body) values (109, 3, '2022-10-01 23:49:00', 'Organized full-range intranet');
insert into post (id_post, id_author, date, text_body) values (110, 33, '2022-10-13 17:37:54', 'Devolved mobile ability');










insert into post (id_post, id_author, date, text_body) values (111, 2, '2022-10-08 02:58:14', 'Compatible optimal support');
insert into post (id_post, id_author, date, text_body) values (112, 50, '2022-10-13 15:22:48', 'Persevering mobile Graphic Interface');
insert into post (id_post, id_author, date, text_body) values (113, 72, '2022-10-17 13:03:52', 'Cloned object-oriented framework');
insert into post (id_post, id_author, date, text_body) values (114, 66, '2022-10-14 01:41:26', 'Horizontal 4th generation project');
insert into post (id_post, id_author, date, text_body) values (115, 86, '2022-10-11 16:53:44', 'Down-sized hybrid moderator');
insert into post (id_post, id_author, date, text_body) values (116, 24, '2022-10-07 12:53:49', 'Balanced multi-state throughput');
insert into post (id_post, id_author, date, text_body) values (117, 66, '2022-10-15 11:54:28', 'Reactive modular hub');
insert into post (id_post, id_author, date, text_body) values (118, 92, '2022-10-07 23:54:23', 'Distributed client-server monitoring');
insert into post (id_post, id_author, date, text_body) values (119, 74, '2022-10-10 19:27:18', 'Seamless optimal frame');
insert into post (id_post, id_author, date, text_body) values (120, 89, '2022-10-14 14:45:27', 'Profit-focused hybrid algorithm');
insert into post (id_post, id_author, date, text_body) values (121, 54, '2022-10-15 08:40:43', 'Optimized national complexity');
insert into post (id_post, id_author, date, text_body) values (122, 61, '2022-10-04 22:21:09', 'Intuitive intangible Graphic Interface');
insert into post (id_post, id_author, date, text_body) values (123, 45, '2022-10-18 09:13:41', 'Streamlined global conglomeration');
insert into post (id_post, id_author, date, text_body) values (124, 69, '2022-10-12 11:18:11', 'Inverse exuding application');
insert into post (id_post, id_author, date, text_body) values (125, 85, '2022-10-06 04:20:16', 'Up-sized zero defect archive');
insert into post (id_post, id_author, date, text_body) values (126, 98, '2022-10-17 08:01:32', 'Vision-oriented interactive database');
insert into post (id_post, id_author, date, text_body) values (127, 57, '2022-10-08 01:59:53', 'Centralized hybrid encryption');
insert into post (id_post, id_author, date, text_body) values (128, 45, '2022-10-18 04:10:29', 'Exclusive asymmetric time-frame');
insert into post (id_post, id_author, date, text_body) values (129, 67, '2022-10-05 22:02:15', 'Programmable composite process improvement');
insert into post (id_post, id_author, date, text_body) values (130, 27, '2022-10-01 11:37:31', 'Operative exuding Graphic Interface');
insert into post (id_post, id_author, date, text_body) values (131, 47, '2022-10-03 10:34:22', 'Secured context-sensitive functionalities');
insert into post (id_post, id_author, date, text_body) values (132, 92, '2022-10-06 03:29:45', 'Monitored asymmetric definition');
insert into post (id_post, id_author, date, text_body) values (133, 43, '2022-10-11 10:24:31', 'Adaptive dedicated leverage');
insert into post (id_post, id_author, date, text_body) values (134, 22, '2022-10-07 04:14:56', 'Robust grid-enabled artificial intelligence');
insert into post (id_post, id_author, date, text_body) values (135, 27, '2022-10-15 17:46:45', 'Centralized needs-based matrix');
insert into post (id_post, id_author, date, text_body) values (136, 24, '2022-10-01 15:19:49', 'Focused dynamic product');
insert into post (id_post, id_author, date, text_body) values (137, 7, '2022-10-12 04:42:59', 'Multi-lateral impactful leverage');
insert into post (id_post, id_author, date, text_body) values (138, 1, '2022-10-06 03:07:27', 'Assimilated fault-tolerant strategy');
insert into post (id_post, id_author, date, text_body) values (139, 71, '2022-10-09 07:13:28', 'Centralized bandwidth-monitored function');
insert into post (id_post, id_author, date, text_body) values (140, 85, '2022-10-10 15:55:46', 'Advanced zero tolerance neural-net');



create table question (
                          id_question SERIAL PRIMARY KEY,
                          title TEXT NOT NULL,
                          CONSTRAINT FK_POST
                              FOREIGN KEY(id_question)
                                  REFERENCES post(id_post)
);


insert into question (id_question, title) values (1, 'Man Who Shot Liberty Valance, The');
insert into question (id_question, title) values (2, 'Dominick and Eugene');
insert into question (id_question, title) values (3, 'Scary Movie 2');
insert into question (id_question, title) values (4, 'Divorcee, The');
insert into question (id_question, title) values (5, '7 Seconds');
insert into question (id_question, title) values (6, 'William Shakespeare''s A Midsummer Night''s Dream');
insert into question (id_question, title) values (7, 'Arthur and the Invisibles');
insert into question (id_question, title) values (8, 'Texas Carnival');
insert into question (id_question, title) values (9, 'Big Steal, The');
insert into question (id_question, title) values (10, 'Happy End');
insert into question (id_question, title) values (11, 'After Hours');
insert into question (id_question, title) values (12, 'Winter Kills');
insert into question (id_question, title) values (13, 'Vibrator');
insert into question (id_question, title) values (14, 'Madhouse');
insert into question (id_question, title) values (15, 'Devil Doll');
insert into question (id_question, title) values (16, 'Harper');
insert into question (id_question, title) values (17, 'Lancelot of the Lake (Lancelot du Lac)');
insert into question (id_question, title) values (18, '2 Days in the Valley');
insert into question (id_question, title) values (19, 'Grotesque (Gurotesuku)');
insert into question (id_question, title) values (20, 'Call Me Kuchu');
insert into question (id_question, title) values (21, 'post Mortem');
insert into question (id_question, title) values (22, '''Hellboy'': The Seeds of Creation');
insert into question (id_question, title) values (23, 'Doll, The (Lalka)');
insert into question (id_question, title) values (24, 'Zabriskie Point');
insert into question (id_question, title) values (25, 'This Is the Night');
insert into question (id_question, title) values (26, 'Show Me');
insert into question (id_question, title) values (27, 'Pipe Dream');
insert into question (id_question, title) values (28, 'Special Forces (Forces spéciales)');
insert into question (id_question, title) values (29, 'Blame It on Rio');
insert into question (id_question, title) values (30, 'Year of the Hare, The (Jäniksen vuosi)');
insert into question (id_question, title) values (31, 'Rocky Balboa');
insert into question (id_question, title) values (32, 'Woyzeck');
insert into question (id_question, title) values (33, 'Tales of the Grim Sleeper');
insert into question (id_question, title) values (34, 'Piñero');
insert into question (id_question, title) values (35, 'Ivan the Terrible, Part One (Ivan Groznyy I)');
insert into question (id_question, title) values (36, 'Figures in a Landscape');
insert into question (id_question, title) values (37, 'End of Love, The');
insert into question (id_question, title) values (38, 'Fan, The');
insert into question (id_question, title) values (39, 'Something Wild');
insert into question (id_question, title) values (40, 'Secret Life of Walter Mitty, The');
insert into question (id_question, title) values (41, 'Vanishing, The');
insert into question (id_question, title) values (42, 'Wild Hearts Can''t Be Broken');
insert into question (id_question, title) values (43, 'Tension at Table Rock');
insert into question (id_question, title) values (44, '12 Rounds 2: Reloaded');
insert into question (id_question, title) values (45, 'Jack the Giant Killer');
insert into question (id_question, title) values (46, 'Match Point');
insert into question (id_question, title) values (47, 'Chapayev');
insert into question (id_question, title) values (48, 'Results');
insert into question (id_question, title) values (49, 'Husbands and Wives');
insert into question (id_question, title) values (50, 'Accidental Golfer, The (Den ofrivillige golfaren)');



CREATE TABLE answer (
                        id_answer SERIAL PRIMARY KEY,
                        id_question INT NULL,
                        is_solution BOOLEAN default '0',
                            CONSTRAINT FK_POST
                                FOREIGN KEY(id_answer)
                                    REFERENCES post(id_post),
                            CONSTRAINT FK_QUESTION
                                FOREIGN KEY(id_question)
                                    REFERENCES question(id_question)
);

INSERT INTO answer (id_answer,id_question,is_solution)
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
INSERT INTO answer (id_answer,id_question,is_solution)
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
INSERT INTO answer (id_answer,id_question,is_solution)
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
INSERT INTO answer (id_answer,id_question,is_solution)
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
INSERT INTO answer (id_answer,id_question,is_solution)
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
INSERT INTO answer (id_answer,id_question,is_solution)
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




CREATE TABLE comment (
    id_comment SERIAL PRIMARY KEY,
        CONSTRAINT FK_POST
            FOREIGN KEY(id_comment)
                REFERENCES post(id_post)
);

INSERT INTO comment (id_comment)
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
INSERT INTO comment (id_comment)
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
INSERT INTO comment (id_comment)
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


CREATE TABLE draft (
                         id_draft SERIAL PRIMARY KEY ,
                         date DATE,
                         id_author integer NOT NULL,
                         title TEXT default NULL,
                         text_body TEXT default NULL,
                             CONSTRAINT authorExists
                             FOREIGN KEY(id_author)
                             REFERENCES "user"(id_user)
);

INSERT INTO draft (id_draft,date,id_author,title,text_body)
VALUES
    (1,'2022-09-18 09:10:41',83,'lorem vitae odio sagittis semper. Nam','placerat, orci lacus vestibulum lorem, sit amet ultricies'),
    (2,'2022-08-10 12:39:59',40,'turpis non enim. Mauris','Fusce fermentum fermentum arcu. Vestibulum ante'),
    (3,'2022-05-14 11:43:14',88,'magnis dis parturient montes, nascetur ridiculus mus.','arcu iaculis enim, sit amet ornare lectus'),
    (4,'2022-08-09 19:37:15',13,'mi enim, condimentum eget, volutpat ornare, facilisis eget,','tempor diam dictum sapien. Aenean massa. Integer vitae nibh. Donec est mauris,'),
    (5,'2022-09-12 09:36:13',46,'Nunc quis arcu vel','commodo at, libero. Morbi accumsan laoreet ipsum. Curabitur consequat, lectus sit amet luctus vulputate, nisi sem semper');



CREATE TABLE tag
(
    id_tag SERIAL PRIMARY KEY,
    name   TEXT NOT NULL UNIQUE
);

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


CREATE TABLE question_tag (
                               id_tag INT NOT NULL,
                               id_question INT NOT NULL,
                               PRIMARY KEY (id_tag, id_question),
                                   CONSTRAINT FK_TAG
                                        FOREIGN KEY(id_tag)
                                            REFERENCES tag(id_tag),
                                    CONSTRAINT FK_QUESTION
                                        FOREIGN KEY(id_question)
                                            REFERENCES question(id_question)
);

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

CREATE TYPE rank AS ENUM ('Gold', 'Silver', 'Bronze');

CREATE TABLE badge (
    id_badge serial PRIMARY KEY,
    b_rank rank NOT NULL,
    name VARCHAR (50) NOT NULL,
    condition TEXT NOT NULL
);


INSERT INTO badge (id_badge, b_rank, name, condition) VALUES (1, 'Gold', 'Inquisitive Master', 'Ask more than 100 questions');
INSERT INTO badge (id_badge, b_rank, name, condition) VALUES (2, 'Silver', 'Inquisitive Pro', 'Ask more than 50 questions');
INSERT INTO badge (id_badge, b_rank, name, condition) VALUES (3, 'Bronze', 'Inquisitive Beginner', 'Ask more than 10 questions');
INSERT INTO badge (id_badge, b_rank, name, condition) VALUES (4, 'Gold', 'Answer Master', 'Answer more than 100 answers');
INSERT INTO badge (id_badge, b_rank, name, condition) VALUES (5, 'Silver', 'Answer Pro', 'Answer more than 50 answers');
INSERT INTO badge (id_badge, b_rank, name, condition) VALUES (6, 'Bronze', 'Answer Beginner', 'Answer more than 10 answers');
INSERT INTO badge (id_badge, b_rank, name, condition) VALUES (7, 'Gold', 'Commentator Master', 'Comment more than 100 times');
INSERT INTO badge (id_badge, b_rank, name, condition) VALUES (8, 'Silver', 'Commentator Pro', 'Comment more than 100 times');
INSERT INTO badge (id_badge, b_rank, name, condition) VALUES (9, 'Bronze', 'Commentator Beginner', 'Comment more than 100 times');
INSERT INTO badge (id_badge, b_rank, name, condition) VALUES (10, 'Gold', 'Judge Master', 'Vote more than 100 times');
INSERT INTO badge (id_badge, b_rank, name, condition) VALUES (11, 'Silver', 'Judge Pro', 'Vote more than 100 times');
INSERT INTO badge (id_badge, b_rank, name, condition) VALUES (12, 'Bronze', 'Judge Beginner', 'Vote more than 100 times');

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

CREATE TABLE notifications (
	id_notif SERIAL PRIMARY KEY,
	notif_text TEXT NOT NULL,
	dismissed BOOL NOT NULL,
	id_user INT,
    date DATE,
	FOREIGN KEY (id_user) REFERENCES "user"(id_user)
);

insert into notifications (id_notif, notif_text, dismissed, id_user,date) values (1, 'neque sapien placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas', true, 73, '2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user,date) values (2, 'cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula', true, 49,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user,date) values (3, 'sit amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut', false, 71,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user,date) values (4, 'eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse', false, 49,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user,date) values (5, 'aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet', false, 74,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user,date) values (6, 'id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede malesuada in imperdiet', true, 38,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user,date) values (7, 'odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est et tempus semper est', true, 28,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user,date) values (8, 'consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi', true, 92,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user,date) values (9, 'vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit', true, 4,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user,date) values (10, 'pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede', true, 69,'2022-10-02 12:32:23');

insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (11, 'vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut', true, 26,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (12, 'sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo', false, 97,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (13, 'ipsum dolor sit amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum', true, 95,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (14, 'mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam', false, 71,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (15, 'sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a', true, 88,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (16, 'pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare', true, 80,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (17, 'viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus', true, 33,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (18, 'lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis', true, 63,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (19, 'ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam', false, 20,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (20, 'mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet', false, 66,'2022-10-02 12:32:23');

insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (21, 'eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus', true, 94,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (22, 'leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien', true, 60,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (23, 'tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero', true, 9,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (24, 'at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt', false, 74,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (25, 'felis ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar', false, 39,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (26, 'blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae', true, 19,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (27, 'vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget elit sodales', false, 29,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (28, 'orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum', true, 78,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (29, 'in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus', true, 22,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (30, 'nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate', false, 37,'2022-10-02 12:32:23');

insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (31, 'dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam', false, 81,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (32, 'nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu', false, 66,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (33, 'vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat', true, 2,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (34, 'turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor', true, 16,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (35, 'mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id', false, 62,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (36, 'morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo', false, 27,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (37, 'sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis', false, 87,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (38, 'duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus', false, 23,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (39, 'consequat ut nulla sed accumsan felis ut at dolor quis odio consequat', true, 22,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (40, 'aenean auctor gravida sem praesent id massa id nisl venenatis', false, 51,'2022-10-02 12:32:23');

insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (41, 'ornare consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc', true, 76,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (42, 'enim blandit mi in porttitor pede justo eu massa donec dapibus duis at velit eu est congue elementum in hac habitasse', true, 96,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (43, 'cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam nec dui luctus', true, 47,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (44, 'consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas', false, 55,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (45, 'duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla', false, 17,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (46, 'porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet', false, 61,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (47, 'pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus', false, 31,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (48, 'amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in', true, 2,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (49, 'consequat in consequat ut nulla sed accumsan felis ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis odio', false, 90,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user, date) values (50, 'neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel nisl duis', false, 74,'2022-10-02 12:32:23');

insert into notifications (id_notif, notif_text, dismissed, id_user,date) values (51, 'lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus', true, 26,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user,date) values (52, 'erat volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus', false, 80,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user,date) values (53, 'congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis', true, 6,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user,date) values (54, 'vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo', true, 81,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user,date) values (55, 'quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer', false, 61,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user,date) values (56, 'elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim', true, 1,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user,date) values (57, 'in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor', false, 60,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user,date) values (58, 'eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus', true, 40,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user,date) values (59, 'augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit', false, 44,'2022-10-02 12:32:23');
insert into notifications (id_notif, notif_text, dismissed, id_user,date) values (60, 'interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor', false, 32,'2022-10-02 12:32:23');


CREATE TABLE system_notif (
	id_notif INT PRIMARY KEY,
	CONSTRAINT FK_NOTIF FOREIGN KEY (id_notif) REFERENCES notifications (id_notif)
);

insert into system_notif (id_notif) values (1);
insert into system_notif (id_notif) values (2);
insert into system_notif (id_notif) values (3);
insert into system_notif (id_notif) values (4);
insert into system_notif (id_notif) values (5);
insert into system_notif (id_notif) values (6);
insert into system_notif (id_notif) values (7);
insert into system_notif (id_notif) values (8);
insert into system_notif (id_notif) values (9);
insert into system_notif (id_notif) values (10);


CREATE TABLE follow_tag_notif (
	id_notif INT PRIMARY KEY,
	id_tag INT,
	CONSTRAINT FK_NOTIF FOREIGN KEY (id_notif) REFERENCES notifications (id_notif),
	CONSTRAINT FK_TAG FOREIGN KEY (id_tag) REFERENCES tag(id_tag)
);

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


CREATE TABLE marked_as_solution_notif (
	id_notif INT PRIMARY KEY,
	id_answer INT,
	CONSTRAINT FK_NOTIF FOREIGN KEY (id_notif) REFERENCES notifications (id_notif),
	CONSTRAINT FK_ANSWER FOREIGN KEY (id_answer) REFERENCES answer(id_answer)
);


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


CREATE TABLE new_badge_notif (
	id_notif INT PRIMARY KEY,
	id_badge INT,
	CONSTRAINT FK_NOTIF FOREIGN KEY (id_notif) REFERENCES notifications (id_notif),
	CONSTRAINT FK_BADGE FOREIGN KEY (id_badge) REFERENCES badge(id_badge)
);

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

CREATE TABLE new_answer_notif (
	id_notif INT PRIMARY KEY,
	id_answer INT,
	CONSTRAINT FK_NOTIF FOREIGN KEY (id_notif) REFERENCES notifications (id_notif),
	CONSTRAINT FK_ANSWER FOREIGN KEY (id_answer) REFERENCES answer(id_answer)
);

insert into new_answer_notif (id_notif,id_answer) values (41,53);
insert into new_answer_notif (id_notif,id_answer) values (42,64);
insert into new_answer_notif (id_notif,id_answer) values (43,75);
insert into new_answer_notif (id_notif,id_answer) values (44,86);
insert into new_answer_notif (id_notif,id_answer) values (45,97);
insert into new_answer_notif (id_notif,id_answer) values (46,108);
insert into new_answer_notif (id_notif,id_answer) values (47,109);
insert into new_answer_notif (id_notif,id_answer) values (48,55);
insert into new_answer_notif (id_notif,id_answer) values (49,67);
insert into new_answer_notif (id_notif,id_answer) values (50,56);

CREATE TABLE followed_question_notif (
	id_notif INT PRIMARY KEY,
	id_answer INT,
	CONSTRAINT FK_NOTIF FOREIGN KEY (id_notif) REFERENCES notifications (id_notif),
	CONSTRAINT FK_ANSWER FOREIGN KEY (id_answer) REFERENCES answer(id_answer)
);


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



CREATE TABLE follows_tag (
	id_user INT NOT NULL,
    id_tag INT NOT NULL,
    PRIMARY KEY (id_user, id_tag),
	    CONSTRAINT FK_TAG
			FOREIGN KEY(id_tag)
				REFERENCES tag(id_tag),
		CONSTRAINT FK_USER
			FOREIGN KEY(id_user)
				REFERENCES "user"(id_user)
);

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
  
CREATE TABLE follows_question (
	id_user INT NOT NULL,
	id_question INT NOT NULL,
	PRIMARY KEY (id_user, id_question),
		CONSTRAINT FK_QUESTION
			FOREIGN KEY(id_question)
				REFERENCES question(id_question),
		CONSTRAINT FK_USER
			FOREIGN KEY(id_user)
				REFERENCES "user"(id_user)
);

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
  
CREATE TABLE question_vote (
	id_user INT NOT NULL,
	id_question INT NOT NULL,
	score INT NOT NULL,
		CONSTRAINT SCORE_VALUES
			CHECK (score BETWEEN -1 AND 1),
	PRIMARY KEY (id_user, id_question),
		CONSTRAINT FK_QUESTION
			FOREIGN KEY(id_question)
				REFERENCES question(id_question),
		CONSTRAINT FK_USER
			FOREIGN KEY(id_user)
				REFERENCES "user"(id_user)
);


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
  
  
CREATE TABLE answer_vote (
	id_user INT NOT NULL,
	id_answer INT NOT NULL,
	score INT NOT NULL,
		CONSTRAINT SCORE_VALUES
			CHECK (score BETWEEN -1 AND 1),
	PRIMARY KEY (id_user, id_answer),
		CONSTRAINT FK_ANSWER
			FOREIGN KEY(id_answer)
				REFERENCES answer(id_answer),
		CONSTRAINT FK_USER
			FOREIGN KEY(id_user)
				REFERENCES "user"(id_user)
);

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

