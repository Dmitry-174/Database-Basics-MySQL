-- Практическое задание

/* 1. Пусть задан некоторый пользователь (выберем 28). Из всех пользователей соц. сети найдите человека,
 который больше всех общался с выбранным пользователем (написал ему сообщений).
 
 Вставим значения сообщений для пользователя 28.*/
 
USE vk;
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (2, 28, 'Pigeon; \'but if you\'ve seen them at dinn--\' she checked herself hastily, and said \'That\'s very curious!\' she thought. \'But everything\'s curious today. I think you\'d take a fancy to herself how this.', 1, 0);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (2, 28, 'Alice. \'Stand up and walking away. \'You insult me by talking such nonsense!\' \'I didn\'t mean it!\' pleaded poor Alice. \'But you\'re so easily offended, you know!\' The Mouse only growled in reply..', 0, 0);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (4, 28, 'Cheshire Cat, she was quite out of this elegant thimble\'; and, when it saw mine coming!\' \'How do you know why it\'s called a whiting?\' \'I never saw one, or heard of one,\' said Alice. \'Why not?\' said.', 0, 1);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (FLOOR(1 + RAND() * 26), 28, 'Alice\'s shoulder as he fumbled over the jury-box with the dream of Wonderland of long ago: and how she would keep, through all her knowledge of history, Alice had begun to think about stopping.', 0, 1);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (FLOOR(1 + RAND() * 26), 28, 'Duchess. An invitation for the moment he was going to happen next. First, she dreamed of little Alice and all sorts of things--I can\'t remember things as I do,\' said the King. (The jury all wrote.', 1, 0);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (FLOOR(1 + RAND() * 26), 28, 'Nobody moved. \'Who cares for fish, Game, or any other dish? Who would not stoop? Soup of the March Hare will be much the same height as herself; and when Alice had learnt several things of this.', 0, 1);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (FLOOR(1 + RAND() * 26), 28, 'Gryphon, and, taking Alice by the pope, was soon submitted to by the time at the March Hare went on. Her listeners were perfectly quiet till she fancied she heard the King sharply. \'Do you know.', 1, 1);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (FLOOR(29 + RAND() * 65), 28, 'As she said to Alice, very much confused, \'I don\'t quite understand you,\' she said, \'and see whether it\'s marked \"poison\" or not\'; for she was saying, and the arm that was trickling down his cheeks,.', 0, 1);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (FLOOR(29 + RAND() * 65), 28, 'As there seemed to be Involved in this way! Stop this moment, and fetch me a good opportunity for making her escape; so she helped herself to about two feet high, and her eyes to see it trot away.', 1, 1);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (FLOOR(29 + RAND() * 65), 28, 'Alice ventured to taste it, and talking over its head. \'Very uncomfortable for the White Rabbit, trotting slowly back again, and we put a white one in by mistake; and if it had no idea what you\'re.', 1, 1);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (FLOOR(29 + RAND() * 65), 28, 'Cheshire Cat, she was quite out of this elegant thimble\'; and, when it saw mine coming!\' \'How do you know why it\'s called a whiting?\' \'I never saw one, or heard of one,\' said Alice. \'Why not?\' said.', 0, 1);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (FLOOR(1 + RAND() * 4), 28, 'Duchess. An invitation for the moment he was going to happen next. First, she dreamed of little Alice and all sorts of things--I can\'t remember things as I do,\' said the King. (The jury all wrote.', 1, 0);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (FLOOR(1 + RAND() * 4), 28, 'Nobody moved. \'Who cares for fish, Game, or any other dish? Who would not stoop? Soup of the March Hare will be much the same height as herself; and when Alice had learnt several things of this.', 0, 1);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (FLOOR(1 + RAND() * 4), 28, 'Duchess. An invitation for the moment he was going to happen next. First, she dreamed of little Alice and all sorts of things--I can\'t remember things as I do,\' said the King. (The jury all wrote.', 1, 0);
INSERT INTO `messages` (`from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`) VALUES (FLOOR(1 + RAND() * 4), 28, 'Nobody moved. \'Who cares for fish, Game, or any other dish? Who would not stoop? Soup of the March Hare will be much the same height as herself; and when Alice had learnt several things of this.', 0, 1);

/* Выведем Имя и Фамилию пользователей, отправлявших сообщения пользователю 28,
сгруппируем по id отправителя и подсчитаем сообщения
выведем в порядке убывания по количеству отправленных сообщений первую строчку */

SELECT first_name, last_name, COUNT(1) AS num_messages_to_28 FROM users
INNER JOIN messages
ON to_user_id = 28 AND users.id = from_user_id
GROUP BY users.id ORDER BY num_messages_to_28 DESC LIMIT 1;

-- 2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..

-- Вставим значения для таблицы likes до 100 полей
INSERT INTO likes (user_id, target_id, target_type_id) VALUES 
	(FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 2.99)),
    (FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 2.99)),
    (FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 2.99)),
    (FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 2.99)),
    (FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 2.99)),
    (FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 2.99)),
    (FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 2.99)),
    (FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 2.99)),
    (FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 2.99)),
    (FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 2.99)),
    (FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 2.99)),
    (FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 2.99)),
    (FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 2.99)),
    (FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 99), FLOOR(1 + RAND() * 2.99));
    
-- Выведем данные пользователей младше 10 лет, получивших лайки и поличество полученых лайков.    
SELECT first_name, last_name, TIMESTAMPDIFF(YEAR, birthday, now()) AS age, COUNT(1) AS get_likes
FROM users
INNER JOIN likes
ON target_id = users.id AND target_type_id = 1
WHERE TIMESTAMPDIFF(YEAR, birthday, now()) < 10
GROUP BY users.id ORDER BY age;

-- посчитаем количество полученых лайков из таблицы выше
WITH younger_likes AS (
	SELECT first_name, last_name, TIMESTAMPDIFF(YEAR, birthday, now()) AS age, COUNT(1) AS get_likes
	FROM users
	INNER JOIN likes
	ON target_id = users.id AND target_type_id = 1
	WHERE TIMESTAMPDIFF(YEAR, birthday, now()) < 10
	GROUP BY users.id ORDER BY age)
SELECT SUM(get_likes) AS total_likes 
FROM younger_likes;
	
/* 3. Определить кто больше поставил лайков (всего): мужчины или женщины.   
 
 Выберем пользователей, ставивших лайки, сгруппируем по полу и выведем первую строку 
 количеству поставленных лайков в обратном порядке */
 
 SELECT gender, count(1) AS set_likes FROM users
 INNER JOIN likes
 ON user_id = users.id
 GROUP BY gender ORDER BY set_likes DESC LIMIT 1;
 
    