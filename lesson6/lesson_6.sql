
/* Практическое задание
 * 
 * 1. Проанализировать запросы, которые выполнялись на занятии, 
 * определить возможные корректировки и/или улучшения (JOIN пока не применять).
 * 
 * Запрос для всех друзей 1: 
SELECT user_id AS from_user_id, friend_id AS to_users_id FROM friendship WHERE user_id = 1 AND request_type_id = 1
UNION
SELECT friend_id AS from_user_id, user_id AS to_users_id FROM friendship WHERE friend_id = 1 AND request_type_id = 1
UNION
SELECT user_id AS from_user_id, friend_id AS to_users_id FROM friendship WHERE user_id = 1 AND request_type_id = 2
UNION
SELECT friend_id AS from_user_id, user_id AS to_users_id FROM friendship WHERE friend_id = 1 AND request_type_id = 2
ORDER BY to_users_id;
 * 
 * Сделать короче благодаря IN:
SELECT user_id AS from_user_id, friend_id AS to_users_id FROM friendship WHERE user_id = 1 AND request_type_id IN (1, 2)
UNION
SELECT friend_id AS from_user_id, user_id AS to_users_id FROM friendship WHERE friend_id = 1 AND request_type_id IN (1, 2)
ORDER BY to_users_id;

Логичнее было считать дружбой подтвержденный запрос (confirmed_at IS NOT NULL) от 1 и к 1, и взаимную подписку, в произведенных 
на уроке запросах друзьями считали всех на кого подписался пользователь и всех, кто подписался на пользователя, а не только
взаимных подписчиков.

Подтвержденные друзья request_type_id = 1 AND confirmed_at IS NOT NULL:
SELECT user_id AS from_user_id, friend_id AS to_users_id FROM friendship 
WHERE (user_id = 1 OR friend_id = 1) AND request_type_id = 1 AND confirmed_at IS NOT NULL;

Взаимная подписка request_type_id = 2:
SELECT user_id AS from_user_id, friend_id AS to_users_id FROM friendship 
WHERE (user_id = 1) AND request_type_id = 2 AND friend_id IN (SELECT user_id FROM friendship 
WHERE (friend_id = 1) AND request_type_id = 2);

 * 
 * 
 * 2. Пусть задан некоторый пользователь (Выберем id = 30). Из всех друзей этого пользователя найдите человека, 
 * который больше всех общался с нашим пользователем.
 */

USE vk;

-- Добавление значений таблицу friendship для запросов от 30 и к 30, т.к. в сгенерир. данных было мало значений для 30
INSERT INTO friendship (user_id, friend_id, request_type_id, requested_at) VALUES 
	(30, FLOOR(RAND() * 29), FLOOR(1 + RAND() * 2.9), NOW()),
	(30, FLOOR(RAND() * 29), FLOOR(1 + RAND() * 2.9), NOW()),
	(30, FLOOR(RAND() * 29), FLOOR(1 + RAND() * 2.9), NOW()),
	(30, FLOOR(RAND() * 29), FLOOR(1 + RAND() * 2.9), NOW()),
	(30, FLOOR(31 + RAND() * 65), FLOOR(1 + RAND() * 2.9), NOW()),
	(30, FLOOR(31 + RAND() * 65), FLOOR(1 + RAND() * 2.9), NOW()),
	(30, FLOOR(31 + RAND() * 65), FLOOR(1 + RAND() * 2.9), NOW()),
	(FLOOR(RAND() * 29), 30, FLOOR(1 + RAND() * 2.9), NOW()),
	(FLOOR(RAND() * 29), 30, FLOOR(1 + RAND() * 2.9), NOW()),
	(FLOOR(31 + RAND() * 65), 30, FLOOR(1 + RAND() * 2.9), NOW()),
	(FLOOR(31 + RAND() * 65), 30, FLOOR(1 + RAND() * 2.9), NOW())
	;



-- Добавление сообщений от 30
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (30, 14, 'But there seemed to have changed since her swim in the other: he came trotting along in a hurry to get through the neighbouring pool--she could hear the Rabbit just under the sea,\' the Gryphon.', 1, 0);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (30, 5, 'Gryphon as if she did it at all,\' said Alice: \'I don\'t think--\' \'Then you should say \"With what porpoise?\"\' \'Don\'t you mean that you weren\'t to talk to.\' \'How are you getting on now, my dear?\' it.', 1, 1);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (30, 23, 'I!\' he replied. \'We quarrelled last March--just before HE went mad, you know--\' She had already heard her sentence three of the wood--(she considered him to you, Though they were mine before. If I.', 0, 0);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (30, FLOOR(RAND() * 29), 'The Dormouse had closed its eyes were getting extremely small for a long breath, and said \'What else had you to set about it; and while she was losing her temper. \'Are you content now?\' said the.', 0, 0);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (30, FLOOR(RAND() * 29), 'Alice, and she tried hard to whistle to it; but she got to the other: he came trotting along in a rather offended tone, \'Hm! No accounting for tastes! Sing her \"Turtle Soup,\" will you, won\'t you.', 1, 1);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (30, FLOOR(RAND() * 29), 'I\'m sure _I_ shan\'t be beheaded!\' said Alice, who felt ready to agree to everything that Alice quite hungry to look down and make THEIR eyes bright and eager with many a strange tale, perhaps even.', 0, 1);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (30, FLOOR(RAND() * 29), 'My notion was that it signifies much,\' she said to herself \'This is Bill,\' she gave one sharp kick, and waited to see it pop down a jar from one minute to another! However, I\'ve got to come once a.', 1, 0);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (30, FLOOR(31 + RAND() * 65), 'I THINK I can reach the key; and if the Mock Turtle, and to wonder what was coming. It was the Duchess\'s cook. She carried the pepper-box in her haste, she had peeped into the wood. \'If it had.', 1, 0);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (30, FLOOR(31 + RAND() * 65), 'Bill!\' then the Rabbit\'s voice; and the poor animal\'s feelings. \'I quite forgot you didn\'t sign it,\' said Alice angrily. \'It wasn\'t very civil of you to learn?\' \'Well, there was nothing on it in a.', 1, 1);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (30, FLOOR(31 + RAND() * 65), 'At this moment Alice felt so desperate that she was small enough to look through into the loveliest garden you ever eat a little worried. \'Just about as much as serpents do, you know.\' \'I DON\'T.', 1, 1);

-- Добавление сообщений к 30
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (40, 30, 'Pigeon; \'but if you\'ve seen them at dinn--\' she checked herself hastily, and said \'That\'s very curious!\' she thought. \'But everything\'s curious today. I think you\'d take a fancy to herself how this.', 1, 0);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (42, 30, 'Alice. \'Stand up and walking away. \'You insult me by talking such nonsense!\' \'I didn\'t mean it!\' pleaded poor Alice. \'But you\'re so easily offended, you know!\' The Mouse only growled in reply..', 0, 0);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (62, 30, 'Cheshire Cat, she was quite out of this elegant thimble\'; and, when it saw mine coming!\' \'How do you know why it\'s called a whiting?\' \'I never saw one, or heard of one,\' said Alice. \'Why not?\' said.', 0, 1);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (FLOOR(RAND() * 29), 30, 'Alice\'s shoulder as he fumbled over the jury-box with the dream of Wonderland of long ago: and how she would keep, through all her knowledge of history, Alice had begun to think about stopping.', 0, 1);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (FLOOR(RAND() * 29), 30, 'Duchess. An invitation for the moment he was going to happen next. First, she dreamed of little Alice and all sorts of things--I can\'t remember things as I do,\' said the King. (The jury all wrote.', 1, 0);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (FLOOR(RAND() * 29), 30, 'Nobody moved. \'Who cares for fish, Game, or any other dish? Who would not stoop? Soup of the March Hare will be much the same height as herself; and when Alice had learnt several things of this.', 0, 1);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (FLOOR(RAND() * 29), 30, 'Gryphon, and, taking Alice by the pope, was soon submitted to by the time at the March Hare went on. Her listeners were perfectly quiet till she fancied she heard the King sharply. \'Do you know.', 1, 1);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (FLOOR(31 + RAND() * 65), 30, 'As she said to Alice, very much confused, \'I don\'t quite understand you,\' she said, \'and see whether it\'s marked \"poison\" or not\'; for she was saying, and the arm that was trickling down his cheeks,.', 0, 1);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (FLOOR(31 + RAND() * 65), 30, 'As there seemed to be Involved in this way! Stop this moment, and fetch me a good opportunity for making her escape; so she helped herself to about two feet high, and her eyes to see it trot away.', 1, 1);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (FLOOR(31 + RAND() * 65), 30, 'Alice ventured to taste it, and talking over its head. \'Very uncomfortable for the White Rabbit, trotting slowly back again, and we put a white one in by mistake; and if it had no idea what you\'re.', 1, 1);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (23, 30, 'Cheshire Cat, she was quite out of this elegant thimble\'; and, when it saw mine coming!\' \'How do you know why it\'s called a whiting?\' \'I never saw one, or heard of one,\' said Alice. \'Why not?\' said.', 0, 1);

-- Подтвержденные друзья (запрос request_type_id = 1 от 30 и к 30 подтверждены confirmed_at IS NOT NULL)
SELECT user_id AS from_user_id, friend_id AS to_users_id FROM friendship 
WHERE (user_id = 30 OR friend_id = 30) AND request_type_id = 1 AND confirmed_at IS NOT NULL;

-- Взаимные подписки (на кого подписался 30 request_type_id = 2, среди тех, кто подписался на 30)
SELECT user_id AS from_user_id, friend_id AS to_users_id FROM friendship 
WHERE (user_id = 30) AND request_type_id = 2 AND friend_id IN (SELECT user_id FROM friendship 
WHERE (friend_id = 30) AND request_type_id = 2);

-- Создадим объединенный запрос для друзей 
SELECT user_id AS from_user_id, friend_id AS to_users_id FROM friendship 
WHERE (user_id = 30) AND request_type_id = 1 AND confirmed_at IS NOT NULL
UNION 
SELECT friend_id AS from_user_id, user_id AS to_users_id FROM friendship 
WHERE (friend_id = 30) AND request_type_id = 1 AND confirmed_at IS NOT NULL
UNION
SELECT user_id AS from_user_id, friend_id AS to_users_id FROM friendship 
WHERE (user_id = 30) AND request_type_id = 2 AND friend_id IN (SELECT user_id FROM friendship 
WHERE (friend_id = 30) AND request_type_id = 2);

-- Создадим именованый запрос друзей 30
WITH friends AS (
	SELECT friend_id AS to_users_id FROM friendship 
	WHERE (user_id = 30) AND request_type_id = 1 AND confirmed_at IS NOT NULL
	UNION 
	SELECT user_id AS to_users_id FROM friendship 
	WHERE (friend_id = 30) AND request_type_id = 1 AND confirmed_at IS NOT NULL
	UNION
	SELECT friend_id AS to_users_id FROM friendship 
	WHERE (user_id = 30) AND request_type_id = 2 AND friend_id IN (SELECT user_id FROM friendship 
	WHERE (friend_id = 30) AND request_type_id = 2)
	)
SELECT * FROM friends;

-- Создадим запрос для вывода всех сообщений от 30 друзьям и от друзей к 30
WITH friends AS (
	SELECT friend_id AS to_users_id FROM friendship 
	WHERE (user_id = 30) AND request_type_id = 1 AND confirmed_at IS NOT NULL
	UNION 
	SELECT user_id AS to_users_id FROM friendship 
	WHERE (friend_id = 30) AND request_type_id = 1 AND confirmed_at IS NOT NULL
	UNION
	SELECT friend_id AS to_users_id FROM friendship 
	WHERE (user_id = 30) AND request_type_id = 2 AND friend_id IN (SELECT user_id FROM friendship 
	WHERE (friend_id = 30) AND request_type_id = 2)
	)
SELECT * FROM messages 
WHERE 
	(from_user_id = 30 OR to_user_id = 30)
	AND 
	(from_user_id IN (SELECT * FROM friends) OR to_user_id IN (SELECT * FROM friends))
;

/* Создадим запрос для вывода id сообщния и id друга пользователя 30, подсчитаем и сгруппируем сообщения для каждого друга
 * отсортируем по количеству сообщений от каждого друга в обратном порядке и выведем первую строку (с наибольшим кол-вом
 * сообщений
 */
WITH friends AS (
	SELECT friend_id AS to_users_id FROM friendship 
	WHERE (user_id = 30) AND request_type_id = 1 AND confirmed_at IS NOT NULL
	UNION 
	SELECT user_id AS to_users_id FROM friendship 
	WHERE (friend_id = 30) AND request_type_id = 1 AND confirmed_at IS NOT NULL
	UNION
	SELECT friend_id AS to_users_id FROM friendship 
	WHERE (user_id = 30) AND request_type_id = 2 AND friend_id IN (SELECT user_id FROM friendship 
	WHERE (friend_id = 30) AND request_type_id = 2)
	)
	
	
SELECT id, friend_id, count(id) AS num FROM (
	SELECT id, to_user_id AS friend_id FROM messages 
	WHERE 
	from_user_id = 30
	AND 
	(from_user_id IN (SELECT * FROM friends) OR to_user_id IN (SELECT * FROM friends))
	UNION
	SELECT id, from_user_id AS friend_id FROM messages 
	WHERE 
	to_user_id = 30
	AND 
	(from_user_id IN (SELECT * FROM friends) OR to_user_id IN (SELECT * FROM friends))) AS friends_messages 
GROUP BY friend_id ORDER BY num DESC LIMIT 1
	;

-- Найдем данные друга по id
WITH friends AS (
	SELECT friend_id AS to_users_id FROM friendship 
	WHERE (user_id = 30) AND request_type_id = 1 AND confirmed_at IS NOT NULL
	UNION 
	SELECT user_id AS to_users_id FROM friendship 
	WHERE (friend_id = 30) AND request_type_id = 1 AND confirmed_at IS NOT NULL
	UNION
	SELECT friend_id AS to_users_id FROM friendship 
	WHERE (user_id = 30) AND request_type_id = 2 AND friend_id IN (SELECT user_id FROM friendship 
	WHERE (friend_id = 30) AND request_type_id = 2)
	),
	
	best_friend AS (
	SELECT id, friend_id, count(id) AS num FROM (
		SELECT id, to_user_id AS friend_id FROM messages 
		WHERE 
		from_user_id = 30
		AND 
		(from_user_id IN (SELECT * FROM friends) OR to_user_id IN (SELECT * FROM friends))
		UNION
		SELECT id, from_user_id AS friend_id FROM messages 
		WHERE 
		to_user_id = 30
		AND 
		(from_user_id IN (SELECT * FROM friends) OR to_user_id IN (SELECT * FROM friends))) AS friends_messages 
	GROUP BY friend_id ORDER BY num DESC LIMIT 1)

SELECT * FROM users WHERE id = (SELECT friend_id FROM best_friend)
	;


-- 3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

-- Найдем 10 самых молодых пользователей

SELECT id, birthday, TIMESTAMPDIFF(YEAR, birthday, now()) AS age FROM USERS ORDER BY age LIMIT 10;

-- подсчитаем общее количество лайков, которые получили 10 самых молодых пользователей

WITH yongest AS (
	SELECT id, birthday, TIMESTAMPDIFF(YEAR, birthday, now()) AS age FROM USERS ORDER BY age LIMIT 10)

SELECT count(*) FROM likes_users WHERE getter_user_id IN (SELECT id FROM yongest);


-- 4. Определить кто больше поставил лайков (всего) - мужчины или женщины?

-- найдем все лайки от пользователей
SELECT setter_user_id AS user_id, updated_at FROM likes_users
UNION
SELECT user_id, updated_at  FROM likes_media
UNION
SELECT user_id, updated_at  FROM likes_posts;

-- подсчитаем лайки от мужчин и женщин
WITH likes AS (
	SELECT setter_user_id AS user_id, updated_at FROM likes_users
	UNION
	SELECT user_id, updated_at  FROM likes_media
	UNION
	SELECT user_id, updated_at  FROM likes_posts
	)
	
SELECT count(*) AS total, 'Male' AS gender FROM likes WHERE user_id IN (SELECT id FROM users WHERE gender='M')
UNION 
SELECT count(*) AS total, 'Female' AS gender FROM likes WHERE user_id IN (SELECT id FROM users WHERE gender='F');
	

-- Выведем кто больше поставил лайков (всего) - мужчины или женщины
WITH likes AS (
	SELECT setter_user_id AS user_id, updated_at FROM likes_users
	UNION
	SELECT user_id, updated_at  FROM likes_media
	UNION
	SELECT user_id, updated_at  FROM likes_posts
	),
	
likes_by_gender AS (
	SELECT count(*) AS total, 'Male' AS gender FROM likes WHERE user_id IN (SELECT id FROM users WHERE gender='M')
	UNION 
	SELECT count(*) AS total, 'Female' AS gender FROM likes WHERE user_id IN (SELECT id FROM users WHERE gender='F')
	)

SELECT gender FROM likes_by_gender ORDER BY total DESC LIMIT 1;


/* 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
 * 
 * будем давать за каждый лайк, поставленный пользователем, отправленное сообщение и исходящий запрос
 *  на дружбу/подписку по одному баллу. Пользователи, набравшие наименьшее количество баллов, будут считаться наименее
 * активными. */

 -- найдем все лайки от пользователей
SELECT setter_user_id AS user_id, updated_at FROM likes_users
UNION
SELECT user_id, updated_at  FROM likes_media
UNION
SELECT user_id, updated_at  FROM likes_posts;
	
 -- найдем все запросы дружбы от пользователей
SELECT user_id, updated_at FROM friendship;

 -- найдем все сообщения от пользователей
SELECT from_user_id AS user_id, updated_at FROM messages;

-- объединим таблицы, сгруппируем по пользователям, выведем наименее активных пользователей

WITH activity AS (
	SELECT setter_user_id AS user_id, updated_at FROM likes_users
	UNION
	SELECT user_id, updated_at  FROM likes_media
	UNION
	SELECT user_id, updated_at  FROM likes_posts
	UNION
	SELECT user_id, updated_at FROM friendship
	UNION
	SELECT from_user_id AS user_id, updated_at FROM messages
	)
SELECT user_id, count(*) AS points FROM activity GROUP BY user_id ORDER BY points LIMIT 10
	;

-- найдем данные пользователей по id
WITH activity AS (
	SELECT setter_user_id AS user_id, updated_at FROM likes_users
	UNION
	SELECT user_id, updated_at  FROM likes_media
	UNION
	SELECT user_id, updated_at  FROM likes_posts
	UNION
	SELECT user_id, updated_at FROM friendship
	UNION
	SELECT from_user_id AS user_id, updated_at FROM messages
	),
	
	least_activity_users AS (
	SELECT user_id, count(*) AS points FROM activity GROUP BY user_id ORDER BY points LIMIT 10)
	
SELECT * FROM users WHERE id IN (SELECT user_id FROM least_activity_users)
	;
	
