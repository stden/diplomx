-- Скрипт сгенерирован Devart dbForge Studio for MySQL, Версия 5.0.63.1
-- Домашняя страница продукта: http://www.devart.com/ru/dbforge/mysql/studio
-- Дата скрипта: 16.02.2012 20:15:06
-- Версия сервера: 5.1.40-community
-- Версия клиента: 4.1

-- 
-- Отключение внешних ключей
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Установка кодировки, с использованием которой клиент будет посылать запросы на сервер
--
SET NAMES 'utf8';

-- 
-- Установка базы данных по умолчанию
--
USE chpu;

--
-- Описание для таблицы chertezh
--
DROP TABLE IF EXISTS chertezh;
CREATE TABLE chertezh (
  id INT(11) NOT NULL AUTO_INCREMENT,
  programma_id INT(11) NOT NULL,
  link VARCHAR(255) NOT NULL COMMENT 'Имя файла',
  extension VARCHAR(255) NOT NULL COMMENT 'Расширение файла',
  PRIMARY KEY (id),
  INDEX FK_chertezh_programma_id (programma_id),
  CONSTRAINT FK_chertezh_programma_id FOREIGN KEY (programma_id)
    REFERENCES programma(id) ON DELETE RESTRICT ON UPDATE RESTRICT
)
ENGINE = INNODB
AUTO_INCREMENT = 2
AVG_ROW_LENGTH = 16384
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Чертёж - картинка (JPEG, BMP и т.д.)';

--
-- Описание для таблицы programma
--
DROP TABLE IF EXISTS programma;
CREATE TABLE programma (
  id INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор программы',
  name VARCHAR(255) NOT NULL COMMENT 'Название программы',
  user_id INT(11) NOT NULL COMMENT 'Автор программы',
  vid_stanka_id INT(11) DEFAULT NULL COMMENT 'Для какого станка предназначена',
  data_sozdaniya TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время добавления',
  PRIMARY KEY (id),
  INDEX FK_programma_user_id (user_id),
  INDEX FK_programma_vid_stanka_id (vid_stanka_id),
  CONSTRAINT FK_programma_user_id FOREIGN KEY (user_id)
    REFERENCES user(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT FK_programma_vid_stanka_id FOREIGN KEY (vid_stanka_id)
    REFERENCES vid_stanka(id) ON DELETE RESTRICT ON UPDATE RESTRICT
)
ENGINE = INNODB
AUTO_INCREMENT = 4
AVG_ROW_LENGTH = 5461
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Программа';

--
-- Описание для таблицы stanok
--
DROP TABLE IF EXISTS stanok;
CREATE TABLE stanok (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) DEFAULT NULL COMMENT 'Идентифицирующее имя станка',
  vid_stanka_id INT(11) NOT NULL COMMENT 'Вид станка',
  network_path VARCHAR(255) DEFAULT NULL COMMENT 'Сетевой путь к станку',
  PRIMARY KEY (id),
  INDEX FK_stanok_vid_stanka_id (vid_stanka_id),
  CONSTRAINT FK_stanok_vid_stanka_id FOREIGN KEY (vid_stanka_id)
    REFERENCES vid_stanka(id) ON DELETE RESTRICT ON UPDATE RESTRICT
)
ENGINE = INNODB
AUTO_INCREMENT = 3
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Конкретный станок';

--
-- Описание для таблицы text_programmy
--
DROP TABLE IF EXISTS text_programmy;
CREATE TABLE text_programmy (
  id INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор версии',
  programma_id INT(11) NOT NULL COMMENT 'Программа',
  `text` TEXT NOT NULL COMMENT 'Текст программы',
  modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `comment` VARCHAR(255) DEFAULT NULL COMMENT 'Комментарий к изменениям',
  user_id INT(11) NOT NULL COMMENT 'Пользователь',
  PRIMARY KEY (id),
  INDEX FK_text_programmy_programma_id (programma_id),
  INDEX FK_text_programmy_user_id (user_id),
  CONSTRAINT FK_text_programmy_programma_id FOREIGN KEY (programma_id)
    REFERENCES programma(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT FK_text_programmy_user_id FOREIGN KEY (user_id)
    REFERENCES user(id) ON DELETE RESTRICT ON UPDATE RESTRICT
)
ENGINE = INNODB
AUTO_INCREMENT = 4
AVG_ROW_LENGTH = 5461
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Версии программы';

--
-- Описание для таблицы user
--
DROP TABLE IF EXISTS user;
CREATE TABLE user (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'Фамилия Имя Отчество',
  email VARCHAR(255) NOT NULL COMMENT 'e-mail',
  `password` VARCHAR(32) DEFAULT NULL COMMENT 'md5-хеш пароля',
  is_admin TINYINT(1) DEFAULT 0 COMMENT 'Является ли администратором?',
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 3
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Пользователи системы';

--
-- Описание для таблицы vid_stanka
--
DROP TABLE IF EXISTS vid_stanka;
CREATE TABLE vid_stanka (
  id INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор вида станка',
  name VARCHAR(255) NOT NULL COMMENT 'Название вида',
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 4
AVG_ROW_LENGTH = 5461
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Тип станка';

-- 
-- Вывод данных для таблицы chertezh
--
INSERT INTO chertezh VALUES 
  (1, 3, 'Вал-Муфта', '121');

-- 
-- Вывод данных для таблицы programma
--
INSERT INTO programma VALUES 
  (1, '700A.01.103-4', 1, 1, '2011-12-02 22:25:58'),
  (2, '701Б.03.134-1', 2, 2, '2020-02-20 11:00:00'),
  (3, 'Вал-Муфта ПТЗ 45', 1, 1, '2020-02-20 11:00:00');

-- 
-- Вывод данных для таблицы stanok
--
INSERT INTO stanok VALUES 
  (1, 'ВХ20, станок №1', 1, NULL),
  (2, 'Токарный станок 2', 1, NULL);

-- 
-- Вывод данных для таблицы text_programmy
--
INSERT INTO text_programmy VALUES 
  (1, 1, 'Program Code \r\nHello world! \r\n', '2011-12-02 22:51:06', NULL, 1),
  (2, 3, 'Версия для RNC-500', '2012-02-16 19:40:13', NULL, 1),
  (3, 3, 'Версия для 43-их кулачков на RNC-400', '2012-02-16 19:40:55', NULL, 1);

-- 
-- Вывод данных для таблицы user
--
INSERT INTO user VALUES 
  (1, 'Кудрявцев Иван', 'admin@mail.ru', '202cb962ac59075b964b07152d234b70', 0),
  (2, 'Иванов Иван Иванович', 'ivanov@mail.ru', '4dfe6e220d16e7b633cfdd92bcc8050b', 0);

-- 
-- Вывод данных для таблицы vid_stanka
--
INSERT INTO vid_stanka VALUES 
  (1, 'Токарный '),
  (2, 'Зубодолбёжный'),
  (3, 'Зубофрезерный');

-- 
-- Включение внешних ключей
-- 
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;