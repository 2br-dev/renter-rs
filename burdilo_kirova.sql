-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Фев 15 2022 г., 10:45
-- Версия сервера: 5.6.39-83.1
-- Версия PHP: 7.1.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `burdilo_kirova`
--

-- --------------------------------------------------------

--
-- Структура таблицы `kir_access_menu`
--

CREATE TABLE IF NOT EXISTS `kir_access_menu` (
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `menu_id` varchar(50) DEFAULT NULL COMMENT 'ID пункта меню',
  `menu_type` enum('user','admin') NOT NULL DEFAULT 'user' COMMENT 'Тип меню',
  `user_id` int(11) DEFAULT NULL COMMENT 'ID пользователя',
  `group_alias` varchar(50) DEFAULT NULL COMMENT 'ID группы',
  KEY `site_id_menu_type` (`site_id`,`menu_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_access_menu`
--

INSERT INTO `kir_access_menu` (`site_id`, `menu_id`, `menu_type`, `user_id`, `group_alias`) VALUES
(1, '-1', 'user', NULL, 'admins'),
(1, '-2', 'admin', NULL, 'admins'),
(1, '-1', 'user', NULL, 'clients'),
(1, '-1', 'user', NULL, 'guest');

-- --------------------------------------------------------

--
-- Структура таблицы `kir_access_module`
--

CREATE TABLE IF NOT EXISTS `kir_access_module` (
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `module` varchar(150) DEFAULT NULL COMMENT 'Идентификатор модуля',
  `user_id` int(11) DEFAULT NULL COMMENT 'ID пользователя',
  `group_alias` varchar(50) DEFAULT NULL COMMENT 'ID группы',
  `access` int(11) DEFAULT NULL COMMENT 'Уровень доступа',
  UNIQUE KEY `site_id_module_user_id_group_alias` (`site_id`,`module`,`user_id`,`group_alias`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_access_module_right`
--

CREATE TABLE IF NOT EXISTS `kir_access_module_right` (
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `group_alias` varchar(50) DEFAULT NULL COMMENT 'ID группы',
  `module` varchar(50) DEFAULT NULL COMMENT 'Идентификатор модуля',
  `right` varchar(150) DEFAULT NULL COMMENT 'Идентификатор права',
  `access` enum('allow','disallow') NOT NULL DEFAULT 'allow' COMMENT 'Уровень доступа',
  UNIQUE KEY `site_id_group_alias_module_right` (`site_id`,`group_alias`,`module`,`right`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_access_site`
--

CREATE TABLE IF NOT EXISTS `kir_access_site` (
  `group_alias` varchar(50) DEFAULT NULL COMMENT 'ID группы',
  `user_id` int(11) DEFAULT NULL COMMENT 'ID пользователя',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта, к которому разрешен доступ',
  UNIQUE KEY `site_id_group_alias` (`site_id`,`group_alias`),
  UNIQUE KEY `site_id_user_id` (`site_id`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_access_site`
--

INSERT INTO `kir_access_site` (`group_alias`, `user_id`, `site_id`) VALUES
('admins', NULL, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `kir_additional`
--

CREATE TABLE IF NOT EXISTS `kir_additional` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `number` varchar(255) DEFAULT NULL COMMENT 'Номер дополнительного соглашения',
  `date` date DEFAULT NULL COMMENT 'Дата доп. соглашения',
  `contract_id` int(11) DEFAULT NULL COMMENT 'Арендатор',
  `_room` varchar(255) DEFAULT NULL COMMENT 'Помещение (сериализованное)',
  `date_start` date DEFAULT NULL COMMENT 'Дата начала аренды',
  `sum` double DEFAULT NULL COMMENT 'Сумма арнеды в месяц',
  `sum_discount` double DEFAULT NULL COMMENT 'Сумма со скидкой',
  `date_finish` date DEFAULT NULL COMMENT 'Дата окончания аренды',
  `date_start_additional` date DEFAULT NULL COMMENT 'Дата вступления в силу',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_additional`
--

INSERT INTO `kir_additional` (`id`, `number`, `date`, `contract_id`, `_room`, `date_start`, `sum`, `sum_discount`, `date_finish`, `date_start_additional`) VALUES
(1, '1', '2021-12-01', 19, 'a:1:{i:0;s:2:\"13\";}', NULL, 9920, 8900, NULL, '2021-12-01'),
(3, '2', '2021-12-01', 1, 'a:0:{}', NULL, 0, 0, NULL, '2021-12-01'),
(4, '1', '2021-12-22', 8, 'a:1:{i:0;s:2:\"50\";}', NULL, 79640, 68000, NULL, '2022-01-01'),
(5, '1', '2021-12-30', 12, 'a:0:{}', NULL, 0, 0, '2022-02-28', '2022-01-01'),
(6, '1', '2021-08-31', 15, 'a:1:{i:0;s:2:\"43\";}', NULL, 16500, 14850, NULL, '2021-09-01'),
(7, '2', '2021-11-01', 15, 'a:2:{i:0;s:2:\"43\";i:1;s:2:\"44\";}', NULL, 28300, 25470, NULL, '2021-11-01');

-- --------------------------------------------------------

--
-- Структура таблицы `kir_article`
--

CREATE TABLE IF NOT EXISTS `kir_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `title` varchar(150) DEFAULT NULL COMMENT 'Название',
  `alias` varchar(150) DEFAULT NULL COMMENT 'Псевдоним(Ан.яз)',
  `content` mediumtext COMMENT 'Содержимое',
  `parent` int(11) DEFAULT NULL COMMENT 'Рубрика',
  `dateof` datetime DEFAULT NULL COMMENT 'Дата и время',
  `dont_show_before_date` int(11) NOT NULL DEFAULT '0' COMMENT 'Не показывать до указанной даты',
  `image` varchar(255) DEFAULT NULL COMMENT 'Картинка',
  `user_id` bigint(11) DEFAULT NULL COMMENT 'Автор',
  `rating` decimal(3,1) DEFAULT '0.0' COMMENT 'Средний балл(рейтинг)',
  `comments` int(11) DEFAULT '0' COMMENT 'Кол-во комментариев к статье',
  `public` int(1) NOT NULL DEFAULT '1' COMMENT 'Публичный',
  `attached_products` varchar(10000) DEFAULT NULL COMMENT 'Прикреплённые товары',
  `short_content` mediumtext COMMENT 'Краткий текст',
  `meta_title` varchar(1000) DEFAULT NULL COMMENT 'Заголовок',
  `meta_keywords` varchar(1000) DEFAULT NULL COMMENT 'Ключевые слова',
  `meta_description` varchar(1000) DEFAULT NULL COMMENT 'Описание',
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_id_parent_alias` (`site_id`,`parent`,`alias`),
  KEY `site_id_parent` (`site_id`,`parent`),
  KEY `alias` (`alias`),
  KEY `parent` (`parent`),
  KEY `dateof` (`dateof`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_article_category`
--

CREATE TABLE IF NOT EXISTS `kir_article_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `title` varchar(150) DEFAULT NULL COMMENT 'Название',
  `alias` varchar(150) DEFAULT NULL COMMENT 'Псевдоним(Ан.яз)',
  `parent` int(11) DEFAULT NULL COMMENT 'Родительская категория',
  `public` int(1) DEFAULT '1' COMMENT 'Показывать на сайте?',
  `sortn` int(11) DEFAULT NULL COMMENT 'Сортировочный индекс',
  `use_in_sitemap` int(11) DEFAULT NULL COMMENT 'Добавлять в sitemap',
  `meta_title` varchar(1000) DEFAULT NULL COMMENT 'Заголовок',
  `meta_keywords` varchar(1000) DEFAULT NULL COMMENT 'Ключевые слова',
  `meta_description` varchar(1000) DEFAULT NULL COMMENT 'Описание',
  `mobile_public` int(1) DEFAULT '0' COMMENT 'Показывать в мобильном приложении',
  `mobile_image` varchar(50) DEFAULT NULL COMMENT 'Идентификатор картинки Ionic 2',
  PRIMARY KEY (`id`),
  UNIQUE KEY `parent_site_id_alias` (`parent`,`site_id`,`alias`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_banner`
--

CREATE TABLE IF NOT EXISTS `kir_banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `title` varchar(255) DEFAULT NULL COMMENT 'Название баннера',
  `file` varchar(255) DEFAULT NULL COMMENT 'Баннер',
  `use_original_file` int(11) DEFAULT NULL COMMENT 'Использовать оригинал файла для вставки',
  `link` varchar(255) DEFAULT NULL COMMENT 'Ссылка',
  `targetblank` int(11) DEFAULT NULL COMMENT 'Открывать ссылку в новом окне',
  `info` mediumtext COMMENT 'Дополнительная информация',
  `public` int(1) DEFAULT NULL COMMENT 'Публичный',
  `weight` int(11) DEFAULT '100' COMMENT 'Вес от 1 до 100',
  `use_schedule` varchar(255) DEFAULT '0' COMMENT 'Использовать показ по расписанию?',
  `date_start` datetime DEFAULT NULL COMMENT 'Дата начала показа',
  `date_end` datetime DEFAULT NULL COMMENT 'Дата окончания показа',
  `mobile_banner_type` varchar(255) DEFAULT '0' COMMENT 'Тип баннера',
  `mobile_link` varchar(255) DEFAULT '' COMMENT 'Страницы для показа пользователю',
  `mobile_menu_id` int(11) DEFAULT '0' COMMENT 'Страницы для показа пользователю',
  `mobile_product_id` int(11) DEFAULT '0' COMMENT 'Товар для показа пользователю',
  `mobile_category_id` int(11) DEFAULT '0' COMMENT 'Категория для показа пользователю',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_banner_x_zone`
--

CREATE TABLE IF NOT EXISTS `kir_banner_x_zone` (
  `zone_id` int(11) DEFAULT NULL COMMENT 'ID зоны',
  `banner_id` int(11) DEFAULT NULL COMMENT 'ID баннера',
  UNIQUE KEY `zone_id_banner_id` (`zone_id`,`banner_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_banner_zone`
--

CREATE TABLE IF NOT EXISTS `kir_banner_zone` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `title` varchar(255) DEFAULT NULL COMMENT 'Название',
  `alias` varchar(255) DEFAULT NULL COMMENT 'Симв. идентификатор',
  `width` int(11) DEFAULT NULL COMMENT 'Ширина области, px',
  `height` int(11) DEFAULT NULL COMMENT 'Высота области, px',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_blocked_ip`
--

CREATE TABLE IF NOT EXISTS `kir_blocked_ip` (
  `ip` varchar(100) NOT NULL COMMENT 'IP-адрес',
  `expire` datetime DEFAULT NULL COMMENT 'Дата разблокировки',
  `comment` varchar(255) DEFAULT NULL COMMENT 'Комментарий',
  PRIMARY KEY (`ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_brand`
--

CREATE TABLE IF NOT EXISTS `kir_brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `title` varchar(250) DEFAULT NULL COMMENT 'Название бренда',
  `alias` varchar(255) DEFAULT NULL COMMENT 'URL имя',
  `public` int(1) DEFAULT '1' COMMENT 'Публичный',
  `image` varchar(255) DEFAULT NULL COMMENT 'Картинка',
  `description` mediumtext COMMENT 'Описание',
  `xml_id` varchar(255) DEFAULT NULL COMMENT 'Идентификатор в системе 1C',
  `sortn` int(11) DEFAULT NULL COMMENT 'Сортировочный номер',
  `meta_title` varchar(1000) DEFAULT NULL COMMENT 'Заголовок',
  `meta_keywords` varchar(1000) DEFAULT NULL COMMENT 'Ключевые слова',
  `meta_description` varchar(1000) DEFAULT NULL COMMENT 'Описание',
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_id_alias` (`site_id`,`alias`),
  KEY `public` (`public`),
  KEY `sortn` (`sortn`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_cart`
--

CREATE TABLE IF NOT EXISTS `kir_cart` (
  `uniq` varchar(10) NOT NULL COMMENT 'ID в рамках одной корзины',
  `type` enum('product','service','coupon') DEFAULT NULL COMMENT 'Тип записи товар, услуга, скидочный купон',
  `entity_id` varchar(50) DEFAULT NULL COMMENT 'ID объекта type',
  `offer` int(11) DEFAULT NULL COMMENT 'Комплектация',
  `multioffers` mediumtext COMMENT 'Многомерные комплектации',
  `amount` decimal(11,3) DEFAULT '1.000' COMMENT 'Количество',
  `title` varchar(255) DEFAULT NULL COMMENT 'Название',
  `extra` mediumtext COMMENT 'Дополнительные сведения (сериализованные)',
  `site_id` int(11) NOT NULL COMMENT 'ID сайта',
  `session_id` varchar(32) NOT NULL COMMENT 'ID сессии',
  `dateof` datetime DEFAULT NULL COMMENT 'Дата добавления',
  `user_id` bigint(11) DEFAULT NULL COMMENT 'Пользователь',
  PRIMARY KEY (`site_id`,`session_id`,`uniq`),
  KEY `site_id_user_id` (`site_id`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_comments`
--

CREATE TABLE IF NOT EXISTS `kir_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `type` varchar(150) DEFAULT NULL COMMENT 'Класс комментария',
  `aid` int(12) DEFAULT NULL COMMENT 'Идентификатор объект',
  `dateof` datetime DEFAULT NULL COMMENT 'Дата',
  `user_id` int(11) DEFAULT NULL COMMENT 'Пользователь',
  `user_name` varchar(100) DEFAULT NULL COMMENT 'Имя пользователя',
  `message` mediumtext COMMENT 'Сообщение',
  `moderated` int(1) DEFAULT NULL COMMENT 'Проверено',
  `rate` int(5) DEFAULT NULL COMMENT 'Оценка (от 1 до 5)',
  `help_yes` int(11) NOT NULL COMMENT 'Ответ помог',
  `help_no` int(11) NOT NULL COMMENT 'Ответ не помог',
  `ip` varchar(15) DEFAULT NULL COMMENT 'IP адрес',
  `useful` int(11) NOT NULL COMMENT 'Полезность',
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_comments_votes`
--

CREATE TABLE IF NOT EXISTS `kir_comments_votes` (
  `ip` varchar(255) DEFAULT NULL COMMENT 'IP пользователя, который оставил комментарий',
  `comment_id` int(11) DEFAULT NULL COMMENT 'ID комментария',
  `help` int(11) DEFAULT NULL COMMENT 'Оценка полезности комментария',
  UNIQUE KEY `ip_comment_id` (`ip`,`comment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_connect_form`
--

CREATE TABLE IF NOT EXISTS `kir_connect_form` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `title` varchar(150) DEFAULT NULL COMMENT 'Название',
  `sortn` int(11) DEFAULT NULL COMMENT 'Сортировочный индекс',
  `email` varchar(250) DEFAULT NULL COMMENT 'Email получения писем',
  `subject` varchar(255) DEFAULT 'Получение письма из формы' COMMENT 'Заголовок письма',
  `template` varchar(255) DEFAULT '%feedback%/mail/default.tpl' COMMENT 'Путь к шаблону письма',
  `successMessage` varchar(255) DEFAULT NULL COMMENT 'Сообщение об успешной отправке формы',
  `public` int(1) DEFAULT '1' COMMENT 'Публичная',
  `use_captcha` int(1) DEFAULT NULL COMMENT 'Использовать каптчу',
  `use_csrf_protection` int(11) DEFAULT NULL COMMENT 'Использовать CSRF защиту',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_connect_form`
--

INSERT INTO `kir_connect_form` (`id`, `site_id`, `title`, `sortn`, `email`, `subject`, `template`, `successMessage`, `public`, `use_captcha`, `use_csrf_protection`) VALUES
(1, 1, 'Обратная связь', NULL, NULL, 'Получение письма из формы', '%feedback%/mail/default.tpl', NULL, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `kir_connect_form_field`
--

CREATE TABLE IF NOT EXISTS `kir_connect_form_field` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `title` varchar(150) DEFAULT NULL COMMENT 'Название',
  `alias` varchar(150) DEFAULT NULL COMMENT 'Псевдоним(Ан.яз)',
  `hint` varchar(150) DEFAULT NULL COMMENT 'Подпись поля',
  `form_id` int(11) DEFAULT NULL COMMENT 'Форма',
  `required` int(11) DEFAULT NULL COMMENT 'Обязательное поле',
  `length` int(11) DEFAULT NULL COMMENT 'Длина поля',
  `show_type` varchar(10) DEFAULT NULL COMMENT 'Тип',
  `anwer_list` mediumtext COMMENT 'Значения списка',
  `show_list_as` varchar(255) DEFAULT NULL COMMENT 'Отображать список как',
  `file_size` int(11) DEFAULT '8192' COMMENT 'Макс. размер файлов (Кб)',
  `file_ext` varchar(150) DEFAULT NULL COMMENT 'Допустимые форматы файлов',
  `use_mask` varchar(20) DEFAULT NULL COMMENT 'Маска проверки',
  `mask` varchar(255) DEFAULT NULL COMMENT 'Произвольная маска проверки',
  `attributes` mediumtext COMMENT 'Список дополнительных атрибутов поля в сериализованном виде',
  `error_text` varchar(255) DEFAULT NULL COMMENT 'Текст ошибки',
  `sortn` int(11) DEFAULT NULL COMMENT 'Сортировочный индекс',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_connect_form_field`
--

INSERT INTO `kir_connect_form_field` (`id`, `site_id`, `title`, `alias`, `hint`, `form_id`, `required`, `length`, `show_type`, `anwer_list`, `show_list_as`, `file_size`, `file_ext`, `use_mask`, `mask`, `attributes`, `error_text`, `sortn`) VALUES
(1, 1, 'Имя', 'name', 'Представьтесь, пожалуйста', 1, 1, NULL, 'string', '', NULL, 8192, '', '', '', NULL, '', 1),
(2, 1, 'E-mail', 'email', 'Электронный ящик, на который будет направлен ответ', 1, 1, NULL, 'email', '', NULL, 8192, '', '', '', NULL, '', 2),
(3, 1, 'Сообщение', 'message', '', 1, 1, NULL, 'text', '', NULL, 8192, '', '', '', NULL, '', 3);

-- --------------------------------------------------------

--
-- Структура таблицы `kir_connect_form_result`
--

CREATE TABLE IF NOT EXISTS `kir_connect_form_result` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `form_id` int(11) DEFAULT NULL COMMENT 'Форма',
  `title` varchar(150) DEFAULT NULL COMMENT 'Название',
  `dateof` datetime DEFAULT NULL COMMENT 'Дата отправки',
  `status` enum('new','viewed') NOT NULL DEFAULT 'new' COMMENT 'Статус',
  `ip` varchar(150) DEFAULT NULL COMMENT 'IP Пользователя',
  `sending_url` varchar(255) DEFAULT NULL COMMENT 'URL с которого отравлена форма',
  `stext` mediumtext COMMENT 'Содержимое результата формы',
  `answer` mediumtext COMMENT 'Ответ',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_contract`
--

CREATE TABLE IF NOT EXISTS `kir_contract` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `number` varchar(255) DEFAULT NULL COMMENT 'Номер договора',
  `renter` int(11) DEFAULT NULL COMMENT 'Арендатор',
  `_renter` varchar(255) DEFAULT NULL COMMENT 'Арендатор (serialize)',
  `date` date DEFAULT NULL COMMENT 'Дата договора',
  `_room` varchar(255) DEFAULT NULL COMMENT 'Помещение (сериализованное)',
  `date_start` date DEFAULT NULL COMMENT 'Дата начала аренды',
  `date_finish` date DEFAULT NULL COMMENT 'Дата окончания аренды',
  `sum` double DEFAULT NULL COMMENT 'Сумма арнеды в месяц',
  `sum_discount` double DEFAULT NULL COMMENT 'Сумма со скидкой',
  `peni` double DEFAULT NULL COMMENT 'Размер пени',
  `start_payment` date DEFAULT NULL COMMENT 'Дата начала оплаты',
  `start_peni` int(11) DEFAULT NULL COMMENT 'С какого дня начислять пени',
  `has_dop` int(11) DEFAULT '0' COMMENT 'Есть доп. соглашение?',
  `balance` double DEFAULT NULL COMMENT 'Баланс',
  `status` int(11) DEFAULT '1' COMMENT 'Статус',
  `start_balance` double DEFAULT NULL COMMENT 'Стартовый баланс договора',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_contract`
--

INSERT INTO `kir_contract` (`id`, `number`, `renter`, `_renter`, `date`, `_room`, `date_start`, `date_finish`, `sum`, `sum_discount`, `peni`, `start_payment`, `start_peni`, `has_dop`, `balance`, `status`, `start_balance`) VALUES
(1, '0/000/00-00-0000', 1, 'a:1:{i:0;s:1:\"1\";}', '2021-07-01', 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', '2021-07-01', '2022-08-31', 20000, 10000, 0.5, '2021-07-01', 11, 1, 0, 0, NULL),
(2, '2/210/26-07-2021', 2, NULL, '2021-07-26', 'a:1:{i:0;s:2:\"25\";}', '2021-07-26', '2022-06-30', 9500, 8550, 0.5, '2021-07-26', 11, 0, -48624.5, 0, 0),
(3, '4/001/01-07-2021', 3, NULL, '2021-07-01', 'a:3:{i:0;s:2:\"34\";i:1;s:2:\"35\";i:2;s:2:\"36\";}', '2021-07-01', '2022-05-31', 29445, 26500, 0.5, '2021-07-01', 11, NULL, 0, 1, NULL),
(4, '4/002/01-07-2021', 4, NULL, '2021-07-01', 'a:3:{i:0;s:2:\"37\";i:1;s:2:\"38\";i:2;s:2:\"45\";}', '2021-07-01', '2022-05-31', 34635, 31000, 0.5, '2021-07-01', 11, NULL, 0, 1, NULL),
(12, '01-07/21', 12, NULL, '2021-07-01', 'a:1:{i:0;s:2:\"12\";}', '2021-07-01', '2021-12-31', 14630, 13000, 0.5, '2021-07-01', 0, 0, -13260, 0, 0),
(5, '1/101/01-11-2021', 5, NULL, '2021-11-01', 'a:1:{i:0;s:1:\"2\";}', '2021-11-01', '2022-09-30', 8700, 7830, 0.5, '2021-11-01', 11, NULL, 0, 1, NULL),
(6, '1/102/01-10-2021', 6, NULL, '2021-10-01', 'a:1:{i:0;s:1:\"3\";}', '2021-10-01', '2022-08-31', 9500, 8550, 0.5, '2021-10-01', 11, NULL, 950, 1, NULL),
(7, '1/103/01-08-2021', 7, NULL, '2021-08-01', 'a:2:{i:0;s:1:\"4\";i:1;s:2:\"10\";}', '2021-08-01', '2022-05-31', 34342, 30900, 0.5, '2021-08-01', 11, NULL, -68684, 1, NULL),
(8, '1/103а/01-04-2021', 8, NULL, '2021-04-01', 'a:3:{i:0;s:1:\"5\";i:1;s:1:\"7\";i:2;s:1:\"8\";}', '2021-04-01', '2022-02-28', 66220, 59500, 0.5, '2021-04-01', 11, 1, 0, 100, NULL),
(9, '1/104/01-06-2021', 9, NULL, '2021-06-01', 'a:1:{i:0;s:1:\"6\";}', '2021-06-01', '2022-04-30', 18000, 16000, 0.5, '2021-06-01', 11, NULL, 0, 1, NULL),
(10, '1/107/01-09-2021', 10, NULL, '2021-09-01', 'a:1:{i:0;s:1:\"9\";}', '2021-09-01', '2022-07-31', 15500, 14000, 0.5, '2021-09-01', 11, NULL, 0, 1, NULL),
(11, '1/109/01-04-2021', 11, NULL, '2021-04-01', 'a:1:{i:0;s:2:\"11\";}', '2021-04-01', '2022-02-28', 10000, 9000, 0.5, '2021-04-01', 11, NULL, 0, 100, NULL),
(13, '2/212/01-06-2021', 13, NULL, '2021-06-01', 'a:1:{i:0;s:2:\"27\";}', '2021-06-01', '2022-04-30', 7500, 6790, 0.5, '2021-06-01', 11, NULL, 0, 1, NULL),
(14, '3/301/01-12-2021', 14, NULL, '2021-12-01', 'a:1:{i:0;s:2:\"33\";}', '2021-12-01', '2022-10-31', 11970, 10700, 0.5, '2021-12-01', 11, NULL, 0, 1, NULL),
(15, '4/003/01-06-2021', 15, NULL, '2021-06-01', 'a:2:{i:0;s:2:\"43\";i:1;s:2:\"44\";}', '2021-06-01', '2022-04-30', 34645, 31150, 0.5, '2021-06-01', 11, 1, 28320, 1, 0),
(16, '4/002/01-04-2021', 16, NULL, '2021-04-01', 'a:4:{i:0;s:2:\"40\";i:1;s:2:\"42\";i:2;s:2:\"48\";i:3;s:2:\"49\";}', '2021-04-01', '2022-02-28', 79632, 70000, 0.5, '2021-04-01', 11, NULL, 19264, 100, NULL),
(17, '2/217/01-10-2021', 17, NULL, '2021-10-01', 'a:1:{i:0;s:2:\"32\";}', '2021-10-01', '2022-08-31', 11550, 10395, 0.5, '2021-10-01', 11, NULL, 0, 1, NULL),
(18, '4/413/01-08-2021', 18, NULL, '2021-08-01', 'a:1:{i:0;s:2:\"46\";}', '2021-08-01', '2022-06-30', 21000, 18900, 0.5, '2021-08-01', 11, NULL, 2100, 1, NULL),
(19, '1/110/01-06-2021', 19, NULL, '2021-06-01', 'a:2:{i:0;s:2:\"11\";i:1;s:2:\"13\";}', '2021-06-01', '2022-04-30', 19866, 17800, 0.5, '2021-06-01', 11, 1, 0, 1, 0),
(20, '1/112/01-06-2021', 20, NULL, '2021-06-01', 'a:1:{i:0;s:2:\"15\";}', '2021-06-01', '2022-04-30', 9600, 8640, 0.5, '2021-06-01', 11, 0, 0, 1, 0),
(21, '2/204/16-11-2021', 21, NULL, '2021-11-16', 'a:1:{i:0;s:2:\"19\";}', '2021-11-16', '2022-09-30', 10500, 9450, 0.5, '2021-11-22', 11, 0, 0, 1, 0),
(22, '2/205/01-09-2021', 22, NULL, '2021-09-01', 'a:1:{i:0;s:2:\"20\";}', '2021-09-01', '2022-07-31', 10500, 9450, 0.5, '2021-09-01', 11, 0, 0, 1, 0),
(23, '2/206/01-09-2021', 23, NULL, '2021-09-01', 'a:1:{i:0;s:2:\"21\";}', '2021-09-01', '2022-07-31', 10500, 9450, 0.5, '2021-09-01', 11, 0, 0, 1, 0),
(24, '2/207/01-09-2021', 24, NULL, '2021-09-01', 'a:1:{i:0;s:2:\"22\";}', '2021-09-01', '2022-05-31', 15100, 13590, 0.5, '2021-09-01', 11, 0, 0, 1, 0),
(25, '2/209/06-07-2021', 25, NULL, '2021-07-06', 'a:1:{i:0;s:2:\"24\";}', '2021-07-06', '2022-06-30', 9500, 8550, 0.5, '2021-07-06', 11, 0, 2018, 1, 0),
(26, '2/210/01-11-2021', 26, NULL, '2021-11-01', 'a:1:{i:0;s:2:\"25\";}', '2021-11-01', '2022-09-30', 9675, 8700, 0.5, '2021-11-01', 11, 0, 0, 1, 0),
(27, '2/211/01-12-2021', 27, NULL, '2021-12-01', 'a:1:{i:0;s:2:\"26\";}', '2021-12-01', '2022-10-31', 9375, 8430, 0.5, '2021-12-01', 11, 0, 0, 1, 0),
(28, '2/213/01-09-2021', 28, NULL, '2021-09-01', 'a:1:{i:0;s:2:\"28\";}', '2021-09-01', '2022-07-31', 3570, 3200, 0.5, '2021-09-01', 11, 0, 0, 1, 0),
(29, '2/215/01-07-2021', 29, NULL, '2021-07-01', 'a:1:{i:0;s:2:\"30\";}', '2021-07-01', '2022-05-31', 9000, 8100, 0.5, '2021-07-01', 11, 0, 0, 1, 0),
(30, '3/002/01-07-2021', 30, NULL, '2021-07-01', 'a:9:{i:0;s:2:\"51\";i:1;s:2:\"52\";i:2;s:2:\"53\";i:3;s:2:\"54\";i:4;s:2:\"55\";i:5;s:2:\"56\";i:6;s:2:\"57\";i:7;s:2:\"58\";i:8;s:2:\"59\";}', '2021-07-01', '2022-06-30', 99720, 99720, 0.5, '2021-07-01', 11, 0, -30846, 1, 0),
(31, '3/304/01-05-2021', 31, NULL, '2021-05-01', 'a:1:{i:0;s:2:\"60\";}', '2021-05-01', '2022-03-31', 9000, 8100, 0.5, '2021-05-01', 11, 0, 900, 1, 0),
(32, '3/305/01-06-2021', 32, NULL, '2021-06-01', 'a:1:{i:0;s:2:\"61\";}', '2021-06-01', '2022-04-30', 27300, 24000, 0.5, '2021-06-01', 11, 0, 0, 1, 0),
(33, '3/306/01-01-2022', 33, NULL, '2022-01-01', 'a:1:{i:0;s:2:\"62\";}', '2022-01-01', '2022-11-30', 9300, 8350, 0.5, '2022-01-01', 11, 0, -18600, 1, 0),
(34, '4/406/01-06-2021', 34, NULL, '2021-06-01', 'a:1:{i:0;s:2:\"39\";}', '2021-06-01', '2022-04-30', 7700, 6900, 0.5, '2021-06-01', 11, 0, 400, 1, 0),
(35, '0/008/01-06-2021', 35, NULL, '2021-06-01', 'a:1:{i:0;s:2:\"63\";}', '2021-06-01', '2022-04-30', 31924, 27500, 0.5, '2021-06-01', 11, 0, 0, 1, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `kir_crm_autotaskrule`
--

CREATE TABLE IF NOT EXISTS `kir_crm_autotaskrule` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `title` varchar(255) DEFAULT NULL COMMENT 'Название',
  `enable` int(11) DEFAULT NULL COMMENT 'Включено',
  `rule_if_class` varchar(255) DEFAULT 'crm-createorder' COMMENT 'Когда создавать задачи?',
  `rule_if_data` mediumtext COMMENT 'Дополнительные параметры',
  `rule_then_data` mediumtext COMMENT 'Данные, которые описывают создание связанных задач',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_crm_custom_data`
--

CREATE TABLE IF NOT EXISTS `kir_crm_custom_data` (
  `object_type_alias` varchar(50) NOT NULL COMMENT 'Тип объекта, к которому привязан статус',
  `object_id` int(11) NOT NULL COMMENT 'ID объекта',
  `field` varchar(255) NOT NULL COMMENT 'Идентификатор поля',
  `value_float` float DEFAULT NULL COMMENT 'Числовое значение для поиска',
  `value_string` varchar(100) DEFAULT NULL COMMENT 'Строковое значение для поиска',
  `value` mediumtext COMMENT 'Текстовое значение',
  PRIMARY KEY (`object_type_alias`,`object_id`,`field`),
  KEY `object_type_alias_object_id_value_float` (`object_type_alias`,`object_id`,`value_float`),
  KEY `object_type_alias_object_id_value_string` (`object_type_alias`,`object_id`,`value_string`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_crm_deal`
--

CREATE TABLE IF NOT EXISTS `kir_crm_deal` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `deal_num` varchar(20) DEFAULT NULL COMMENT 'Уникальный номер сделки',
  `title` varchar(255) DEFAULT NULL COMMENT 'Название сделки',
  `status_id` int(11) DEFAULT NULL COMMENT 'Статус',
  `manager_id` bigint(11) DEFAULT NULL COMMENT 'Менеджер, создавший сделку',
  `client_type` enum('guest','user') DEFAULT 'guest' COMMENT 'Тип клиента',
  `client_name` varchar(255) DEFAULT NULL COMMENT 'Имя клиента',
  `client_id` bigint(11) DEFAULT NULL COMMENT 'Клиент, для которого создается сделка',
  `date_of_create` datetime DEFAULT NULL COMMENT 'Дата создания',
  `message` mediumtext COMMENT 'Комментарий',
  `cost` decimal(20,2) DEFAULT NULL COMMENT 'Сумма сделки',
  `board_sortn` int(11) DEFAULT NULL COMMENT 'Сортировочный индекс на доске',
  `is_archived` int(11) NOT NULL COMMENT 'Сделка архивная?',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deal_num` (`deal_num`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_crm_interaction`
--

CREATE TABLE IF NOT EXISTS `kir_crm_interaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `title` varchar(255) DEFAULT NULL COMMENT 'Короткое описание',
  `date_of_create` datetime DEFAULT NULL COMMENT 'Дата создания',
  `duration` varchar(255) DEFAULT NULL COMMENT 'Продолжительность',
  `creator_user_id` bigint(11) DEFAULT NULL COMMENT 'Создатель взаимодействия',
  `message` mediumtext COMMENT 'Комментарий',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_crm_link`
--

CREATE TABLE IF NOT EXISTS `kir_crm_link` (
  `source_type` varchar(50) DEFAULT NULL COMMENT 'Тип объекта источника',
  `source_id` int(11) DEFAULT NULL COMMENT 'ID объекта источника',
  `link_type` varchar(50) DEFAULT NULL COMMENT 'Тип связываемого объекта ',
  `link_id` int(11) DEFAULT NULL COMMENT 'ID связываемого объекта',
  UNIQUE KEY `source_type_source_id_link_type_link_id` (`source_type`,`source_id`,`link_type`,`link_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_crm_statuses`
--

CREATE TABLE IF NOT EXISTS `kir_crm_statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `object_type_alias` varchar(50) DEFAULT NULL COMMENT 'Тип объекта, к которому привязан статус',
  `title` varchar(255) DEFAULT NULL COMMENT 'Наименование статуса',
  `alias` varchar(50) NOT NULL COMMENT 'Англ. идентификатор',
  `color` varchar(7) DEFAULT NULL COMMENT 'Цвет',
  `sortn` int(11) DEFAULT NULL COMMENT 'Порядок',
  `is_status_complete` int(11) DEFAULT NULL COMMENT 'Этот статус означает, что задача завершена?',
  PRIMARY KEY (`id`),
  UNIQUE KEY `object_type_alias_alias` (`object_type_alias`,`alias`),
  KEY `object_type_alias` (`object_type_alias`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_crm_statuses`
--

INSERT INTO `kir_crm_statuses` (`id`, `object_type_alias`, `title`, `alias`, `color`, `sortn`, `is_status_complete`) VALUES
(1, 'crm-task', 'Новая', 'new', '#cc4b83', 1, NULL),
(2, 'crm-task', 'Сделать', 'todo', '#edaf3b', 2, NULL),
(3, 'crm-task', 'В работе', 'in-work', '#d1cd5a', 3, NULL),
(4, 'crm-task', 'На проверке', 'review', '#6fb3f2', 4, NULL),
(5, 'crm-task', 'Выполнена', 'complete', '#28c950', 5, NULL),
(6, 'crm-deal', 'Новая', 'new', '#c6d460', 1, NULL),
(7, 'crm-deal', 'В работе', 'in-work', '#4c4cf5', 2, NULL),
(8, 'crm-deal', 'Успешно завершена', 'success', '#3bc753', 3, NULL),
(9, 'crm-deal', 'Отменена', 'fail', '#f21d1d', 4, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `kir_crm_task`
--

CREATE TABLE IF NOT EXISTS `kir_crm_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `task_num` varchar(20) DEFAULT NULL COMMENT 'Уникальный номер задачи',
  `title` varchar(255) DEFAULT NULL COMMENT 'Суть задачи',
  `status_id` int(11) DEFAULT NULL COMMENT 'Статус',
  `description` mediumtext COMMENT 'Описание',
  `date_of_create` datetime DEFAULT NULL COMMENT 'Дата создания',
  `date_of_planned_end` datetime DEFAULT NULL COMMENT 'Планируемая дата завершения задачи',
  `date_of_end` datetime DEFAULT NULL COMMENT 'Фактическая дата завершения задачи',
  `expiration_notice_time` int(11) DEFAULT '300' COMMENT 'Уведомить исполнителя о скором истечении срока выполнении задачи за...',
  `expiration_notice_is_send` int(11) DEFAULT NULL COMMENT 'Было ли отправлено уведомление об истечении срока выполнения задачи?',
  `creator_user_id` bigint(11) DEFAULT NULL COMMENT 'Создатель задачи',
  `implementer_user_id` bigint(11) DEFAULT NULL COMMENT 'Исполнитель задачи',
  `board_sortn` int(11) DEFAULT NULL COMMENT 'Сортировочный индекс на доске',
  `is_archived` int(11) NOT NULL COMMENT 'Задача архивная?',
  `autotask_index` int(11) DEFAULT NULL COMMENT 'Порядковый номер автозадачи',
  `autotask_group` int(11) DEFAULT NULL COMMENT 'Идентификатор группы связанных заказов',
  `is_autochange_status` int(11) DEFAULT NULL COMMENT 'Включить автосмену статуса',
  `autochange_status_rule` mediumtext COMMENT 'Условия для смены статуса',
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_num` (`task_num`),
  KEY `expiration_notice_is_send_date_of_planned_end_status_id` (`expiration_notice_is_send`,`date_of_planned_end`,`status_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_crm_task_filter`
--

CREATE TABLE IF NOT EXISTS `kir_crm_task_filter` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `user_id` bigint(11) DEFAULT NULL COMMENT 'Пользователь, для которого настраивается фильтр',
  `title` varchar(255) DEFAULT NULL COMMENT 'Название выборки',
  `filters` mediumtext COMMENT 'Значения фильтров',
  `sortn` int(11) DEFAULT NULL COMMENT 'Порядок',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_crm_tel_call_history`
--

CREATE TABLE IF NOT EXISTS `kir_crm_tel_call_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `provider` varchar(255) DEFAULT NULL COMMENT 'Провайдер тефонных услуг',
  `call_id` varchar(255) DEFAULT NULL COMMENT 'Внутренний ID вызова',
  `call_api_id` varchar(255) DEFAULT NULL COMMENT 'Внешний ID вызова',
  `caller_number` varchar(255) DEFAULT NULL COMMENT 'Номер вызывающего абонента',
  `caller_id` varchar(255) DEFAULT NULL COMMENT 'ID вызывающего абонента',
  `called_number` varchar(255) DEFAULT NULL COMMENT 'Номер вызываемого абонента',
  `called_id` varchar(255) DEFAULT NULL COMMENT 'ID вызываемого абонента',
  `called_public_number` varchar(255) DEFAULT NULL COMMENT 'Публичный номер на который звонит абонент',
  `event_time` datetime DEFAULT NULL COMMENT 'Дата и время звонка',
  `duration` bigint(11) DEFAULT NULL COMMENT 'Время разговора, в микросекундах',
  `record_id` varchar(255) NOT NULL COMMENT 'ID файла записи разговора',
  `call_status` varchar(255) DEFAULT NULL COMMENT 'Статус звонка',
  `call_sub_status` varchar(255) DEFAULT NULL COMMENT 'Результат звонка',
  `call_flow` enum('in','out') DEFAULT NULL COMMENT 'Направление вызова',
  `_custom_data` mediumtext COMMENT 'Произвольные данные',
  `is_closed` int(11) NOT NULL COMMENT 'Звонок принудительно закрыт пользователем',
  PRIMARY KEY (`id`),
  UNIQUE KEY `call_id` (`call_id`),
  KEY `caller_number` (`caller_number`),
  KEY `called_number` (`called_number`),
  KEY `record_id` (`record_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_csv_map`
--

CREATE TABLE IF NOT EXISTS `kir_csv_map` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `schema` varchar(255) DEFAULT NULL COMMENT 'Схема импорта-экспорта',
  `type` enum('export','import') DEFAULT NULL COMMENT 'Тип операции',
  `title` varchar(255) DEFAULT NULL COMMENT 'Название предустановки',
  `_columns` varchar(5000) DEFAULT NULL COMMENT 'Информация о колонках',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_currency`
--

CREATE TABLE IF NOT EXISTS `kir_currency` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `title` varchar(3) DEFAULT NULL COMMENT 'Трехсимвольный идентификатор валюты (Ан. яз)',
  `stitle` varchar(10) DEFAULT NULL COMMENT 'Символ валюты',
  `is_base` int(11) DEFAULT NULL COMMENT 'Это базовая валюта?',
  `ratio` float DEFAULT NULL COMMENT 'Коэффициент относительно базовой валюты',
  `public` int(11) DEFAULT NULL COMMENT 'Видимость',
  `default` int(11) DEFAULT NULL COMMENT 'Выбирать по-умолчанию',
  `percent` float DEFAULT '0' COMMENT 'Увеличивать/уменьшать курс на %',
  PRIMARY KEY (`id`),
  UNIQUE KEY `title_site_id` (`title`,`site_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_currency`
--

INSERT INTO `kir_currency` (`id`, `site_id`, `title`, `stitle`, `is_base`, `ratio`, `public`, `default`, `percent`) VALUES
(1, 1, 'RUB', 'р.', 1, 1, 1, 1, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `kir_delivery_cdek_regions`
--

CREATE TABLE IF NOT EXISTS `kir_delivery_cdek_regions` (
  `code` int(11) DEFAULT NULL COMMENT 'Код населенного пункта СДЭК',
  `city` varchar(100) DEFAULT NULL COMMENT 'Название населенного пункта',
  `fias_guid` varchar(36) DEFAULT NULL COMMENT 'Уникальный идентификатор ФИАС населенного пункта',
  `kladr_code` varchar(255) DEFAULT NULL COMMENT 'Код КЛАДР населенного пункта',
  `country` varchar(50) DEFAULT NULL COMMENT 'Название страны населенного пункта',
  `region` varchar(100) DEFAULT NULL COMMENT 'Название региона населенного пункта',
  `sub_region` varchar(50) DEFAULT NULL COMMENT 'Название района региона населенного пункта',
  `processed` int(11) DEFAULT NULL COMMENT 'Флаг "обработан"',
  UNIQUE KEY `country_region_sub_region_city` (`country`,`region`,`sub_region`,`city`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_delivery_order`
--

CREATE TABLE IF NOT EXISTS `kir_delivery_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `external_id` varchar(255) DEFAULT NULL COMMENT 'Внешний идентификатор',
  `order_id` int(11) DEFAULT NULL COMMENT 'id заказа',
  `delivery_type` varchar(255) DEFAULT NULL COMMENT 'Расчётный клас доставки',
  `number` varchar(255) DEFAULT NULL COMMENT 'Номер заказа на доставку',
  `_data` varchar(10000) DEFAULT NULL COMMENT 'Сохранённые данные (сериализованные)',
  `_extra` varchar(5000) DEFAULT NULL COMMENT 'Дополнительные данные (сериализованные)',
  `creation_date` datetime DEFAULT NULL COMMENT 'Дата создания',
  `address` varchar(255) DEFAULT NULL COMMENT 'Адрес на который создан заказ',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_disabled_routes`
--

CREATE TABLE IF NOT EXISTS `kir_disabled_routes` (
  `route_id` varchar(255) NOT NULL COMMENT 'ID отключенного маршрута',
  PRIMARY KEY (`route_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_document_inventorization`
--

CREATE TABLE IF NOT EXISTS `kir_document_inventorization` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `applied` int(11) DEFAULT '1' COMMENT 'Проведен',
  `comment` mediumtext COMMENT 'Комментарий',
  `warehouse` int(250) DEFAULT NULL COMMENT 'Склад',
  `fact_amount` int(11) DEFAULT NULL COMMENT 'Фактическое кол-во',
  `calc_amount` int(11) DEFAULT NULL COMMENT 'Расчетное кол-во',
  `dif_amount` int(11) DEFAULT NULL COMMENT 'Разница',
  `date` datetime DEFAULT NULL COMMENT 'Дата',
  `type` varchar(255) DEFAULT NULL COMMENT 'Тип документа',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_document_inventory`
--

CREATE TABLE IF NOT EXISTS `kir_document_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `applied` int(11) DEFAULT '1' COMMENT 'Проведен',
  `comment` mediumtext COMMENT 'Комментарий',
  `archived` int(11) DEFAULT '0' COMMENT 'Заархивирован?',
  `warehouse` int(250) DEFAULT NULL COMMENT 'Склад',
  `date` datetime DEFAULT NULL COMMENT 'Дата',
  `provider` int(11) DEFAULT NULL COMMENT 'Поставщик',
  `type` enum('arrival','waiting','reserve','write_off') DEFAULT NULL COMMENT 'Тип документа',
  `items_count` int(11) DEFAULT NULL COMMENT 'Количество товаров',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_document_inventory_products`
--

CREATE TABLE IF NOT EXISTS `kir_document_inventory_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `title` varchar(250) DEFAULT NULL COMMENT 'Название',
  `fact_amount` int(11) DEFAULT NULL COMMENT 'Фактическое кол-во',
  `calc_amount` int(11) DEFAULT NULL COMMENT 'Расчетное кол-во',
  `dif_amount` int(11) DEFAULT NULL COMMENT 'Разница',
  `uniq` varchar(250) DEFAULT NULL COMMENT 'uniq',
  `product_id` int(250) DEFAULT NULL COMMENT 'id товара',
  `offer_id` int(250) DEFAULT NULL COMMENT 'id комплектации',
  `document_id` int(250) DEFAULT NULL COMMENT 'id документа',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_document_links`
--

CREATE TABLE IF NOT EXISTS `kir_document_links` (
  `source_id` int(11) DEFAULT NULL COMMENT 'id источника',
  `source_type` varchar(255) DEFAULT NULL COMMENT 'тип источника',
  `document_id` varchar(255) DEFAULT NULL COMMENT 'id документа',
  `document_type` varchar(255) DEFAULT NULL COMMENT 'тип документа',
  `order_num` varchar(255) DEFAULT NULL COMMENT 'Номер заказа'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_document_movement`
--

CREATE TABLE IF NOT EXISTS `kir_document_movement` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `applied` int(11) DEFAULT '1' COMMENT 'Проведен',
  `comment` mediumtext COMMENT 'Комментарий',
  `warehouse_from` int(250) DEFAULT NULL COMMENT 'Со склада',
  `warehouse_to` int(250) DEFAULT NULL COMMENT 'На склад',
  `date` datetime DEFAULT NULL COMMENT 'Дата',
  `type` varchar(255) DEFAULT NULL COMMENT 'Тип документа',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_document_movement_products`
--

CREATE TABLE IF NOT EXISTS `kir_document_movement_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `title` varchar(250) DEFAULT NULL COMMENT 'Название',
  `amount` int(11) DEFAULT NULL COMMENT 'Количество',
  `uniq` varchar(250) DEFAULT NULL COMMENT 'uniq',
  `product_id` int(250) DEFAULT NULL COMMENT 'id товара',
  `offer_id` int(250) DEFAULT NULL COMMENT 'id комплектации',
  `document_id` int(250) DEFAULT NULL COMMENT 'id документа',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_document_products`
--

CREATE TABLE IF NOT EXISTS `kir_document_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `title` varchar(250) DEFAULT NULL COMMENT 'Название',
  `amount` varchar(250) DEFAULT NULL COMMENT 'Количество',
  `uniq` varchar(250) DEFAULT NULL COMMENT 'Уникальный Идентификатор',
  `product_id` int(250) DEFAULT NULL COMMENT 'Id товара',
  `offer_id` int(250) DEFAULT NULL COMMENT 'Id комплектации',
  `warehouse` int(250) DEFAULT NULL COMMENT 'Id склада',
  `document_id` int(250) DEFAULT NULL COMMENT 'Id документа',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `product_id_offer_id_warehouse` (`product_id`,`offer_id`,`warehouse`),
  KEY `document_id` (`document_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_document_products_archive`
--

CREATE TABLE IF NOT EXISTS `kir_document_products_archive` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `title` varchar(250) DEFAULT NULL COMMENT 'Название',
  `amount` varchar(250) DEFAULT NULL COMMENT 'Количество',
  `uniq` varchar(250) DEFAULT NULL COMMENT 'Уникальный Идентификатор',
  `product_id` int(250) DEFAULT NULL COMMENT 'Id товара',
  `offer_id` int(250) DEFAULT NULL COMMENT 'Id комплектации',
  `warehouse` int(250) DEFAULT NULL COMMENT 'Id склада',
  `document_id` int(250) DEFAULT NULL COMMENT 'Id документа',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `product_id_offer_id_warehouse` (`product_id`,`offer_id`,`warehouse`),
  KEY `document_id` (`document_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_document_products_start_num`
--

CREATE TABLE IF NOT EXISTS `kir_document_products_start_num` (
  `product_id` int(11) DEFAULT NULL COMMENT 'ID товара',
  `offer_id` int(11) DEFAULT NULL COMMENT 'ID комплектации',
  `warehouse_id` int(11) DEFAULT NULL COMMENT 'ID склада',
  `stock` decimal(11,3) DEFAULT '0.000' COMMENT 'Доступно',
  `reserve` decimal(11,3) DEFAULT '0.000' COMMENT 'Резерв',
  `waiting` decimal(11,3) DEFAULT '0.000' COMMENT 'Ожидание',
  `remains` decimal(11,3) DEFAULT '0.000' COMMENT 'Остаток',
  UNIQUE KEY `product_id_offer_id_warehouse_id` (`product_id`,`offer_id`,`warehouse_id`),
  KEY `offer_id` (`offer_id`),
  KEY `warehouse_id` (`warehouse_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_export_external_link`
--

CREATE TABLE IF NOT EXISTS `kir_export_external_link` (
  `profile_id` int(11) DEFAULT NULL COMMENT 'id профиля экспорта',
  `product_id` int(11) DEFAULT NULL COMMENT 'id товара на сайте',
  `offer_id` int(11) DEFAULT NULL COMMENT 'id комплектации',
  `ext_id` int(11) DEFAULT NULL COMMENT 'id товара во внешней системе',
  `ext_data` varchar(4000) DEFAULT NULL COMMENT 'произвольные json данные связи',
  `has_changed` int(11) DEFAULT NULL COMMENT 'флаг изменения товара',
  `hash` varchar(50) DEFAULT NULL COMMENT 'Хэш от последних выгруженных данных',
  UNIQUE KEY `profile_id_product_id_offer_id` (`profile_id`,`product_id`,`offer_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_export_profile`
--

CREATE TABLE IF NOT EXISTS `kir_export_profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `title` varchar(255) DEFAULT NULL COMMENT 'Название',
  `alias` varchar(150) DEFAULT NULL COMMENT 'URL имя',
  `class` varchar(255) DEFAULT NULL COMMENT 'Класс экспорта',
  `life_time` int(11) DEFAULT NULL COMMENT 'Период экспорта',
  `url_params` varchar(255) DEFAULT NULL COMMENT 'Дополнительные параметры<br/> для ссылки на товар',
  `_serialized` mediumtext,
  `is_exporting` int(11) DEFAULT NULL COMMENT 'Флаг незавершенного экспорта',
  `is_enabled` int(1) DEFAULT '1' COMMENT 'Включен',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_export_vk_cat`
--

CREATE TABLE IF NOT EXISTS `kir_export_vk_cat` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `profile_id` int(11) DEFAULT NULL COMMENT 'ID профиля',
  `title` varchar(255) DEFAULT NULL COMMENT 'Название категории в ВК',
  `parent_id` int(11) DEFAULT NULL COMMENT 'ID родителя',
  `vk_id` int(11) DEFAULT NULL COMMENT 'ID категории ВКонтакте',
  PRIMARY KEY (`id`),
  UNIQUE KEY `profile_id_vk_id` (`profile_id`,`vk_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_export_vk_cat_link`
--

CREATE TABLE IF NOT EXISTS `kir_export_vk_cat_link` (
  `dir_id` int(11) NOT NULL COMMENT 'ID категории RS',
  `profile_id` int(11) NOT NULL COMMENT 'ID профиля',
  `vk_cat_id` int(11) NOT NULL COMMENT 'ID категории ВКонтакте',
  PRIMARY KEY (`dir_id`,`profile_id`,`vk_cat_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_external_api_log`
--

CREATE TABLE IF NOT EXISTS `kir_external_api_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `dateof` datetime DEFAULT NULL COMMENT 'Дата совершения запроса',
  `request_uri` mediumtext COMMENT 'URL запроса к API',
  `request_params` blob COMMENT 'Параметры запроса',
  `response` mediumblob COMMENT 'Ответ на запрос',
  `ip` varchar(255) DEFAULT NULL COMMENT 'IP-адрес',
  `user_id` int(11) DEFAULT NULL COMMENT 'Пользователь',
  `token` varchar(255) DEFAULT NULL COMMENT 'Авторизационный токен',
  `client_id` varchar(255) DEFAULT NULL COMMENT 'Идентификатор клиента',
  `method` varchar(255) DEFAULT NULL COMMENT 'Метод API',
  `error_code` varchar(255) DEFAULT NULL COMMENT 'Код ошибки',
  PRIMARY KEY (`id`),
  KEY `dateof` (`dateof`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_external_api_token`
--

CREATE TABLE IF NOT EXISTS `kir_external_api_token` (
  `token` varchar(255) DEFAULT NULL COMMENT 'Авторизационный токен',
  `user_id` bigint(11) DEFAULT NULL COMMENT 'ID Пользователя',
  `app_type` varchar(255) DEFAULT NULL COMMENT 'Класс приложения',
  `ip` varchar(255) DEFAULT NULL COMMENT 'IP-адрес',
  `dateofcreate` datetime DEFAULT NULL COMMENT 'Дата создания',
  `expire` int(11) DEFAULT NULL COMMENT 'Срок истечения авторизационного токена'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_external_api_user_allow_methods`
--

CREATE TABLE IF NOT EXISTS `kir_external_api_user_allow_methods` (
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `user_id` bigint(11) DEFAULT NULL COMMENT 'Пользователь',
  `api_method` varchar(255) DEFAULT NULL COMMENT 'Имя метода API'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_external_request_cache`
--

CREATE TABLE IF NOT EXISTS `kir_external_request_cache` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `date` datetime DEFAULT NULL COMMENT 'Время запроса',
  `source_id` varchar(255) DEFAULT NULL COMMENT 'Идентификатор инициатора запроса',
  `request_url` varchar(255) DEFAULT NULL COMMENT 'URL запроса',
  `request_headers` blob COMMENT 'Заголовки запроса',
  `request_params` blob COMMENT 'Параметры запроса',
  `request_hash` varchar(255) DEFAULT NULL COMMENT 'Хэш параметров запроса',
  `idempotence_key` varchar(255) DEFAULT NULL COMMENT 'Ключ идемпотентности',
  `response_status` int(11) DEFAULT NULL COMMENT 'Статус ответа',
  `response_headers` blob COMMENT 'Заголовки ответа',
  `response_body` mediumblob COMMENT 'Тело ответа',
  PRIMARY KEY (`id`),
  KEY `date` (`date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_fast_link`
--

CREATE TABLE IF NOT EXISTS `kir_fast_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `title` varchar(255) DEFAULT NULL COMMENT 'Название ссылки',
  `link` varchar(255) DEFAULT NULL COMMENT 'Ссылка',
  `target` enum('window','blank') DEFAULT NULL COMMENT 'Открывать',
  `icon` varchar(255) DEFAULT 'zmdi-open-in-new' COMMENT 'Иконка',
  `bgcolor` varchar(7) DEFAULT '#eeeeee' COMMENT 'Цвет фона иконки',
  `sortn` int(11) DEFAULT NULL COMMENT 'Порядок',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_files`
--

CREATE TABLE IF NOT EXISTS `kir_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `servername` varchar(50) DEFAULT NULL COMMENT 'Имя файла на сервере',
  `name` varchar(255) DEFAULT NULL COMMENT 'Название файла',
  `description` mediumtext COMMENT 'Описание',
  `size` varchar(255) DEFAULT NULL COMMENT 'Размер файла',
  `mime` varchar(255) DEFAULT NULL COMMENT 'Mime тип файла',
  `access` varchar(255) DEFAULT NULL COMMENT 'Уровень доступа',
  `sortn` int(11) DEFAULT NULL COMMENT 'Порядковый номер',
  `link_type_class` varchar(100) DEFAULT NULL COMMENT 'Класс типа связываемых объектов',
  `link_id` int(11) DEFAULT NULL COMMENT 'ID связанного объекта',
  `xml_id` varchar(255) DEFAULT NULL COMMENT 'Идентификатор в сторонней системе',
  `uniq` varchar(32) DEFAULT NULL COMMENT 'Уникальный идентификатор',
  `uniq_name` varchar(255) DEFAULT NULL COMMENT 'Уникальное название файла (url-имя)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `servername_link_type_class_link_id` (`servername`,`link_type_class`,`link_id`),
  UNIQUE KEY `xml_id` (`xml_id`),
  UNIQUE KEY `uniq` (`uniq`),
  UNIQUE KEY `uniq_name` (`uniq_name`),
  KEY `access` (`access`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_hash_store`
--

CREATE TABLE IF NOT EXISTS `kir_hash_store` (
  `hash` bigint(12) NOT NULL COMMENT 'Хэш ключа',
  `value` varchar(4000) DEFAULT NULL COMMENT 'Значение для ключа',
  PRIMARY KEY (`hash`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_hash_store`
--

INSERT INTO `kir_hash_store` (`hash`, `value`) VALUES
(1508169505, 'b:1;'),
(3227350232, 'b:1;'),
(3203139685, 'b:1;'),
(1318362129, 'b:1;'),
(792215500, 'b:1;'),
(876603600, 'b:1;'),
(1263585396, 'b:1;'),
(2721279297, 'b:1;'),
(2774444376, 'b:1;'),
(3410143375, 'b:1;'),
(1380710709, 'b:1;'),
(330477605, 'b:1;'),
(1689616563, 'b:1;'),
(3671498173, 'b:1;'),
(2299022469, 'b:1;'),
(4030504467, 'b:1;'),
(330825122, 'b:1;'),
(3938926908, 'b:1;'),
(2392926377, 'b:1;'),
(2045954494, 'b:1;'),
(2467047061, 'b:1;'),
(2051278907, 'b:1;'),
(2830556431, 'b:1;'),
(880788988, 'b:1;'),
(3492685472, 'b:1;'),
(1658998507, 'b:1;'),
(3540042858, 'b:1;'),
(2270996553, 'b:1;'),
(3796323324, 'b:1;'),
(3681538968, 'b:1;'),
(2363953823, 'b:1;'),
(617101625, 'b:1;'),
(1453263790, 'b:1;'),
(2420634801, 'b:1;'),
(3196438845, 'b:1;'),
(685793120, 'b:1;'),
(1599035878, 'b:1;'),
(1763814139, 'b:1;'),
(626166410, 'b:1;'),
(3614776887, 'b:1;'),
(1233211065, 'b:1;'),
(2840897447, 'b:1;'),
(4160181905, 'b:1;'),
(3945304734, 'b:1;'),
(2638322274, 'b:1;'),
(2773365246, 'b:1;'),
(2887763448, 'b:1;'),
(2253723831, 'b:1;'),
(1865858434, 'b:1;'),
(4131384376, 'b:1;'),
(105347148, 'b:1;'),
(1982696643, 'b:1;'),
(2552491503, 'b:1;'),
(1757201611, 'b:1;'),
(1906832778, 'b:1;'),
(2839650087, 'b:1;'),
(2618964412, 'b:1;'),
(4170269845, 'b:1;'),
(1770614713, 'b:1;'),
(3848435729, 'b:1;'),
(841392839, 'b:1;'),
(725455750, 'b:1;'),
(3000203793, 'b:1;'),
(1294996616, 'b:1;'),
(22065818, 'b:1;'),
(2448404235, 'b:1;'),
(2454582507, 'b:1;'),
(803055673, 'b:1;'),
(1793915437, 'b:1;'),
(166591280, 'b:1;'),
(632122602, 'b:1;'),
(3150575945, 'b:1;'),
(3302029545, 's:25:\"4394733642-97901945779841\";'),
(3606101029, 's:3:\"171\";'),
(2287582876, 's:3:\"255\";'),
(3236832156, 'b:1;'),
(2098456608, 's:32:\"44d2733be3f25d16a1029a737a6dabf6\";'),
(2191385798, 'a:8:{s:6:\"domain\";s:13:\"trest.2-br.ru\";s:13:\"is_activation\";i:1;s:12:\"check_domain\";i:0;s:6:\"person\";s:52:\"Антон Анатольевич Кононович\";s:12:\"company_name\";s:3:\"2Br\";s:3:\"inn\";s:0:\"\";s:5:\"phone\";s:12:\"+79183192279\";s:5:\"email\";s:14:\"92279@inbox.ru\";}'),
(1165203481, 's:3:\"254\";');

-- --------------------------------------------------------

--
-- Структура таблицы `kir_images`
--

CREATE TABLE IF NOT EXISTS `kir_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `servername` varchar(25) DEFAULT NULL COMMENT 'Имя файла на сервере',
  `filename` varchar(255) DEFAULT NULL COMMENT 'Оригинальное имя файла',
  `view_count` int(11) DEFAULT NULL COMMENT 'Количество просмотров',
  `size` int(11) DEFAULT NULL COMMENT 'Размер файла',
  `mime` varchar(20) DEFAULT NULL COMMENT 'Mime тип изображения',
  `sortn` int(11) NOT NULL COMMENT 'Порядковый номер',
  `title` mediumtext COMMENT 'Подпись изображения',
  `type` varchar(20) DEFAULT NULL COMMENT 'Название объекта, которому принадлежат изображения',
  `linkid` int(11) DEFAULT NULL COMMENT 'Идентификатор объекта, которому принадлежит изображение',
  `extra` varchar(255) DEFAULT NULL COMMENT 'Дополнительный символьный идентификатор изображения',
  `hash` varchar(50) DEFAULT NULL COMMENT 'Хэш содержимого файла',
  PRIMARY KEY (`id`),
  UNIQUE KEY `servername_type_linkid` (`servername`,`type`,`linkid`),
  KEY `linkid_type` (`linkid`,`type`),
  KEY `linkid_sortn` (`linkid`,`sortn`),
  KEY `servername` (`servername`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_images`
--

INSERT INTO `kir_images` (`id`, `site_id`, `servername`, `filename`, `view_count`, `size`, `mime`, `sortn`, `title`, `type`, `linkid`, `extra`, `hash`) VALUES
(1, 1, 'h/nuhhf93jl8u0qyx.jpg', '1.jpg', NULL, 130333, 'image/jpeg', 0, '', 'room', 1, NULL, '6263a6073eca4a0e8da3658b3941c854');

-- --------------------------------------------------------

--
-- Структура таблицы `kir_invoice`
--

CREATE TABLE IF NOT EXISTS `kir_invoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `number` int(11) DEFAULT NULL COMMENT 'Номер',
  `date` date DEFAULT NULL COMMENT 'Дата',
  `renter_string` varchar(255) DEFAULT NULL COMMENT 'Арендатор',
  `renter_id` int(11) DEFAULT NULL COMMENT 'Арендатор (id)',
  `contract_id` int(11) DEFAULT NULL COMMENT 'Договор (id)',
  `period_month` varchar(255) DEFAULT NULL COMMENT 'Период (месяц)',
  `period_year` varchar(255) DEFAULT NULL COMMENT 'Период (год)',
  `sum` double DEFAULT NULL COMMENT 'Сумма',
  `discount_sum` double DEFAULT NULL COMMENT 'Сумма со скидкой',
  `is_discount` int(11) DEFAULT NULL COMMENT 'Со скидкой?',
  `is_modified` int(11) DEFAULT NULL COMMENT 'Модифицирова?',
  `amount` double DEFAULT NULL COMMENT 'Количество',
  `finish_discount` date DEFAULT NULL COMMENT 'Окончание периода для оплты со скидкой (timestamp)',
  `forced_discount` int(11) DEFAULT '0' COMMENT 'Принудительно со скидкой',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=295 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_invoice`
--

INSERT INTO `kir_invoice` (`id`, `number`, `date`, `renter_string`, `renter_id`, `contract_id`, `period_month`, `period_year`, `sum`, `discount_sum`, `is_discount`, `is_modified`, `amount`, `finish_discount`, `forced_discount`) VALUES
(42, 2, '2021-11-01', 'Общество с ограниченной ответственностью &quot;Бриз&quot;', 4, 4, '11', '2021', 34635, 31000, 1, 0, 1, '2021-11-06', 0),
(41, 1, '2021-11-01', 'Общество с ограниченной ответственностью &quot;Проект-Инвест&quot;', 3, 3, '11', '2021', 29445, 26500, 1, 0, 1, '2021-11-06', 0),
(116, 74, '2021-07-01', 'Общество с ограниченной ответственностью «ЛЕВИТЭК»', 12, 12, '07', '2021', 14630, 13000, 1, 0, 1, '2021-07-11', 0),
(44, 4, '2021-11-01', 'Общество с ограниченной ответственностью «Лидерстрой»', 7, 7, '11', '2021', 34342, 30900, 1, 0, 1, '2021-11-06', 0),
(45, 5, '2021-11-01', 'Общество с ограниченной ответственностью &quot;ТрансРегион&quot;', 8, 8, '11', '2021', 66220, 59500, 1, 0, 1, '2021-11-06', 0),
(46, 6, '2021-11-01', 'Общество с ограниченной ответственностью «ПКО Аркон»', 9, 9, '11', '2021', 18000, 16000, 0, 0, 1, '2021-11-06', 0),
(47, 7, '2021-11-01', 'Общество с ограниченной ответственностью «ЛенаСибУголь» ', 13, 13, '11', '2021', 7500, 6790, 0, 0, 1, '2021-11-06', 0),
(65, 25, '2021-10-01', 'Общество с ограниченной ответственностью «ЛАККИ»', 17, 17, '10', '2021', 11550, 10395, 0, 0, 1, NULL, 0),
(49, 9, '2021-11-01', 'Общество с ограниченной ответственностью &quot;Кастор&quot;', 15, 15, '11', '2021', 28300, 25470, 0, 0, 1, '2021-11-06', 0),
(50, 10, '2021-11-01', 'Общество с ограниченной ответственностью &quot;СибНедра&quot; ', 16, 16, '11', '2021', 79632, 70000, 1, 0, 1, '2021-11-06', 0),
(51, 11, '2021-11-01', 'Общество с ограниченной ответственностью «ЛАККИ»', 17, 17, '11', '2021', 11550, 10395, 0, 0, 1, '2021-11-06', 0),
(52, 12, '2021-11-01', 'Общество с ограниченной ответственностью &quot;Гарант&quot;', 18, 18, '11', '2021', 21000, 18900, 0, 0, 1, '2021-11-06', 0),
(53, 13, '2021-12-01', 'Общество с ограниченной ответственностью &quot;Проект-Инвест&quot;', 3, 3, '12', '2021', 29445, 26500, 0, 0, 1, '2021-12-06', 0),
(54, 14, '2021-12-01', 'Общество с ограниченной ответственностью &quot;Бриз&quot;', 4, 4, '12', '2021', 34635, 31000, 0, 0, 1, '2021-12-06', 0),
(117, 75, '2021-08-01', 'Общество с ограниченной ответственностью «ЛЕВИТЭК»', 12, 12, '08', '2021', 14630, 13000, 0, 0, 1, '2021-08-06', 0),
(56, 16, '2021-12-01', 'Общество с ограниченной ответственностью «Лидерстрой»', 7, 7, '12', '2021', 34342, 30900, 0, 0, 1, '2021-12-06', 0),
(57, 17, '2021-12-01', 'Общество с ограниченной ответственностью &quot;ТрансРегион&quot;', 8, 8, '12', '2021', 66220, 59500, 0, 0, 1, '2021-12-06', 0),
(58, 18, '2021-12-01', 'Общество с ограниченной ответственностью «ПКО Аркон»', 9, 9, '12', '2021', 18000, 16000, 0, 0, 1, '2021-12-06', 0),
(59, 19, '2021-12-01', 'Общество с ограниченной ответственностью «ЛенаСибУголь» ', 13, 13, '12', '2021', 7500, 6790, 0, 0, 1, '2021-12-06', 0),
(60, 20, '2021-12-01', 'Общество с ограниченной ответственностью «Сервис Групп»', 14, 14, '12', '2021', 11970, 10700, 1, 0, 1, '2021-12-06', 0),
(61, 21, '2021-12-01', 'Общество с ограниченной ответственностью &quot;Кастор&quot;', 15, 15, '12', '2021', 28300, 25470, 0, 0, 1, '2021-12-06', 0),
(62, 22, '2021-12-01', 'Общество с ограниченной ответственностью &quot;СибНедра&quot; ', 16, 16, '12', '2021', 79632, 70000, 1, 0, 1, '2021-12-06', 0),
(63, 23, '2021-12-01', 'Общество с ограниченной ответственностью «ЛАККИ»', 17, 17, '12', '2021', 11550, 10395, 1, 0, 1, '2021-12-06', 0),
(64, 24, '2021-12-01', 'Общество с ограниченной ответственностью &quot;Гарант&quot;', 18, 18, '12', '2021', 21000, 18900, 0, 0, 1, '2021-12-06', 0),
(66, 26, '2021-04-01', 'Общество с ограниченной ответственностью &quot;СибНедра&quot; ', 16, 16, '04', '2021', 79632, 70000, 0, 0, 1, '2021-04-11', 0),
(67, 27, '2021-05-01', 'Общество с ограниченной ответственностью &quot;СибНедра&quot; ', 16, 16, '05', '2021', 79632, 70000, 0, 0, 1, '2021-05-06', 0),
(68, 28, '2021-06-01', 'Общество с ограниченной ответственностью &quot;СибНедра&quot; ', 16, 16, '06', '2021', 79632, 70000, 1, 0, 1, '2021-06-06', 0),
(69, 29, '2021-07-01', 'Общество с ограниченной ответственностью &quot;СибНедра&quot; ', 16, 16, '07', '2021', 79632, 70000, 0, 0, 1, '2021-07-06', 0),
(70, 30, '2021-08-01', 'Общество с ограниченной ответственностью &quot;СибНедра&quot; ', 16, 16, '08', '2021', 79632, 70000, 0, 0, 1, '2021-08-06', 0),
(71, 31, '2021-09-01', 'Общество с ограниченной ответственностью &quot;СибНедра&quot; ', 16, 16, '09', '2021', 79632, 70000, 1, 0, 1, '2021-09-06', 0),
(72, 32, '2021-10-01', 'Общество с ограниченной ответственностью &quot;СибНедра&quot; ', 16, 16, '10', '2021', 79632, 70000, 1, 0, 1, '2021-10-06', 0),
(81, 39, '2021-06-01', 'Индивидуальный предприниматель Помигалов Игорь Юрьевич', 19, 19, '06', '2021', 19866, 17800, 1, 0, 1, '2021-06-11', 0),
(74, 34, '2021-07-01', 'Индивидуальный предприниматель Помигалов Игорь Юрьевич', 19, 19, '07', '2021', 19866, 17800, 1, 0, 1, '2021-07-06', 0),
(75, 35, '2021-08-01', 'Индивидуальный предприниматель Помигалов Игорь Юрьевич', 19, 19, '08', '2021', 19866, 17800, 1, 0, 1, '2021-08-06', 0),
(76, 36, '2021-09-01', 'Индивидуальный предприниматель Помигалов Игорь Юрьевич', 19, 19, '09', '2021', 19866, 17800, 1, 0, 1, '2021-09-06', 0),
(77, 37, '2021-10-01', 'Индивидуальный предприниматель Помигалов Игорь Юрьевич', 19, 19, '10', '2021', 19866, 17800, 1, 0, 1, '2021-10-06', 0),
(78, 38, '2021-11-01', 'Индивидуальный предприниматель Помигалов Игорь Юрьевич', 19, 19, '11', '2021', 19866, 17800, 1, 0, 1, '2021-11-06', 0),
(82, 40, '2021-12-01', 'Индивидуальный предприниматель Помигалов Игорь Юрьевич', 19, 19, '12', '2021', 9920, 8900, 1, 0, 1, '2021-12-06', 0),
(83, 41, '2021-04-01', 'Общество с ограниченной ответственностью &quot;ТрансРегион&quot;', 8, 8, '04', '2021', 66220, 59500, 1, 0, 1, '2021-04-11', 0),
(84, 42, '2021-05-01', 'Общество с ограниченной ответственностью &quot;ТрансРегион&quot;', 8, 8, '05', '2021', 66220, 59500, 1, 0, 1, '2021-05-06', 0),
(85, 43, '2021-06-01', 'Общество с ограниченной ответственностью &quot;ТрансРегион&quot;', 8, 8, '06', '2021', 66220, 59500, 1, 0, 1, '2021-06-06', 0),
(86, 44, '2021-07-01', 'Общество с ограниченной ответственностью &quot;ТрансРегион&quot;', 8, 8, '07', '2021', 66220, 59500, 1, 0, 1, '2021-07-06', 0),
(87, 45, '2021-08-01', 'Общество с ограниченной ответственностью &quot;ТрансРегион&quot;', 8, 8, '08', '2021', 66220, 59500, 1, 0, 1, '2021-08-06', 0),
(88, 46, '2021-09-01', 'Общество с ограниченной ответственностью &quot;ТрансРегион&quot;', 8, 8, '09', '2021', 66220, 59500, 0, 0, 1, '2021-09-06', 0),
(89, 47, '2021-10-01', 'Общество с ограниченной ответственностью &quot;ТрансРегион&quot;', 8, 8, '10', '2021', 66220, 59500, 1, 0, 1, '2021-10-06', 0),
(90, 48, '2021-11-01', 'Общество с ограниченной ответственностью &quot;Алькор&quot;', 5, 5, '11', '2021', 8700, 7830, 1, 0, 1, '2021-11-11', 0),
(91, 49, '2021-12-01', 'Общество с ограниченной ответственностью &quot;Алькор&quot;', 5, 5, '12', '2021', 8700, 7830, 1, 0, 1, '2021-12-06', 0),
(92, 50, '2021-10-01', 'Урадовских Кристина Владимировна', 6, 6, '10', '2021', 9500, 8550, 1, 0, 1, '2021-10-11', 0),
(93, 51, '2021-11-01', 'Урадовских Кристина Владимировна', 6, 6, '11', '2021', 9500, 8550, 0, 0, 1, '2021-11-06', 0),
(94, 52, '2021-12-01', 'Урадовских Кристина Владимировна', 6, 6, '12', '2021', 9500, 8550, 0, 0, 1, '2021-12-06', 0),
(95, 53, '2021-08-01', 'Общество с ограниченной ответственностью «Лидерстрой»', 7, 7, '08', '2021', 34342, 30900, 0, 0, 1, '2021-08-11', 0),
(96, 54, '2021-09-01', 'Общество с ограниченной ответственностью «Лидерстрой»', 7, 7, '09', '2021', 34342, 30900, 0, 0, 1, '2021-09-06', 0),
(97, 55, '2021-10-01', 'Общество с ограниченной ответственностью «Лидерстрой»', 7, 7, '10', '2021', 34342, 30900, 0, 0, 1, '2021-10-06', 0),
(98, 56, '2021-06-01', 'Общество с ограниченной ответственностью «ПКО Аркон»', 9, 9, '06', '2021', 18000, 16000, 0, 0, 1, '2021-06-11', 0),
(99, 57, '2021-07-01', 'Общество с ограниченной ответственностью «ПКО Аркон»', 9, 9, '07', '2021', 18000, 16000, 0, 0, 1, '2021-07-06', 0),
(100, 58, '2021-08-01', 'Общество с ограниченной ответственностью «ПКО Аркон»', 9, 9, '08', '2021', 18000, 16000, 0, 0, 1, '2021-08-06', 0),
(101, 59, '2021-09-01', 'Общество с ограниченной ответственностью «ПКО Аркон»', 9, 9, '09', '2021', 18000, 16000, 0, 0, 1, '2021-09-06', 0),
(102, 60, '2021-10-01', 'Общество с ограниченной ответственностью «ПКО Аркон»', 9, 9, '10', '2021', 18000, 16000, 0, 0, 1, '2021-10-06', 0),
(103, 61, '2021-09-01', 'Индивидуальный предприниматель Куликова Татьяна Сергеевна', 10, 10, '09', '2021', 15500, 14000, 0, 0, 1, '2021-09-11', 0),
(104, 62, '2021-10-01', 'Индивидуальный предприниматель Куликова Татьяна Сергеевна', 10, 10, '10', '2021', 15500, 14000, 0, 0, 1, '2021-10-06', 0),
(105, 63, '2021-11-01', 'Индивидуальный предприниматель Куликова Татьяна Сергеевна', 10, 10, '11', '2021', 15500, 14000, 0, 0, 1, '2021-11-06', 0),
(106, 64, '2021-12-01', 'Индивидуальный предприниматель Куликова Татьяна Сергеевна', 10, 10, '12', '2021', 15500, 14000, 0, 0, 1, '2021-12-06', 0),
(107, 65, '2021-04-01', 'Сокольская Зинаида Владимировна', 11, 11, '04', '2021', 10000, 9000, 1, 0, 1, '2021-04-11', 0),
(108, 66, '2021-05-01', 'Сокольская Зинаида Владимировна', 11, 11, '05', '2021', 10000, 9000, 1, 0, 1, '2021-05-06', 0),
(109, 67, '2021-06-01', 'Сокольская Зинаида Владимировна', 11, 11, '06', '2021', 10000, 9000, 1, 0, 1, '2021-06-06', 0),
(110, 68, '2021-07-01', 'Сокольская Зинаида Владимировна', 11, 11, '07', '2021', 10000, 9000, 1, 0, 1, '2021-07-06', 0),
(111, 69, '2021-08-01', 'Сокольская Зинаида Владимировна', 11, 11, '08', '2021', 10000, 9000, 1, 0, 1, '2021-08-06', 0),
(112, 70, '2021-09-01', 'Сокольская Зинаида Владимировна', 11, 11, '09', '2021', 10000, 9000, 1, 0, 1, '2021-09-06', 0),
(113, 71, '2021-10-01', 'Сокольская Зинаида Владимировна', 11, 11, '10', '2021', 10000, 9000, 1, 0, 1, '2021-10-06', 0),
(114, 72, '2021-11-01', 'Сокольская Зинаида Владимировна', 11, 11, '11', '2021', 10000, 9000, 1, 0, 1, '2021-11-06', 0),
(115, 73, '2021-12-01', 'Сокольская Зинаида Владимировна', 11, 11, '12', '2021', 10000, 9000, 1, 0, 1, '2021-12-06', 0),
(118, 76, '2021-09-01', 'Общество с ограниченной ответственностью «ЛЕВИТЭК»', 12, 12, '09', '2021', 14630, 13000, 0, 0, 1, '2021-09-06', 0),
(119, 77, '2021-10-01', 'Общество с ограниченной ответственностью «ЛЕВИТЭК»', 12, 12, '10', '2021', 14630, 13000, 0, 0, 1, '2021-10-06', 0),
(120, 78, '2021-11-01', 'Общество с ограниченной ответственностью «ЛЕВИТЭК»', 12, 12, '11', '2021', 14630, 13000, 0, 0, 1, '2021-11-06', 0),
(121, 79, '2021-12-01', 'Общество с ограниченной ответственностью «ЛЕВИТЭК»', 12, 12, '12', '2021', 14630, 13000, 0, 0, 1, '2021-12-06', 0),
(124, 1, '2022-01-01', 'Красильникова Юлия Александровна', 2, 2, '01', '2022', 9500, 8550, 0, 0, 1, '2022-01-06', 0),
(125, 2, '2022-01-01', 'Общество с ограниченной ответственностью &quot;ТрансРегион&quot;', 8, 8, '01', '2022', 79640, 68000, 0, 0, 1, '2022-01-06', 0),
(126, 3, '2022-01-01', 'Общество с ограниченной ответственностью «ЛЕВИТЭК»', 12, 12, '01', '2022', 14630, 13000, 0, 0, 1, '2022-01-06', 0),
(127, 4, '2021-07-01', 'Общество с ограниченной ответственностью &quot;Проект-Инвест&quot;', 3, 3, '07', '2021', 29445, 26500, 0, 0, 1, '2021-07-11', 0),
(128, 5, '2021-08-01', 'Общество с ограниченной ответственностью &quot;Проект-Инвест&quot;', 3, 3, '08', '2021', 29445, 26500, 1, 0, 1, '2021-08-06', 0),
(129, 6, '2021-09-01', 'Общество с ограниченной ответственностью &quot;Проект-Инвест&quot;', 3, 3, '09', '2021', 29445, 26500, 1, 0, 1, '2021-09-06', 0),
(130, 7, '2021-10-01', 'Общество с ограниченной ответственностью &quot;Проект-Инвест&quot;', 3, 3, '10', '2021', 29445, 26500, 1, 0, 1, '2021-10-06', 0),
(131, 8, '2022-01-01', 'Общество с ограниченной ответственностью &quot;Проект-Инвест&quot;', 3, 3, '01', '2022', 29445, 26500, 0, 0, 1, '2022-01-06', 0),
(132, 9, '2022-01-01', 'Общество с ограниченной ответственностью &quot;Алькор&quot;', 5, 5, '01', '2022', 8700, 7830, 1, 0, 1, '2022-01-06', 0),
(133, 10, '2022-01-01', 'Урадовских Кристина Владимировна', 6, 6, '01', '2022', 9500, 8550, 0, 0, 1, '2022-01-06', 0),
(134, 11, '2022-01-01', 'Общество с ограниченной ответственностью «Лидерстрой»', 7, 7, '01', '2022', 34342, 30900, 0, 0, 1, '2022-01-06', 0),
(135, 12, '2022-01-01', 'Общество с ограниченной ответственностью «ПКО Аркон»', 9, 9, '01', '2022', 18000, 16000, 0, 0, 1, '2022-01-06', 0),
(136, 13, '2022-01-01', 'Индивидуальный предприниматель Куликова Татьяна Сергеевна', 10, 10, '01', '2022', 15500, 14000, 0, 0, 1, '2022-01-06', 0),
(137, 14, '2022-01-01', 'Сокольская Зинаида Владимировна', 11, 11, '01', '2022', 10000, 9000, 1, 0, 1, '2022-01-06', 0),
(138, 15, '2022-01-01', 'Индивидуальный предприниматель Помигалов Игорь Юрьевич', 19, 19, '01', '2022', 9920, 8900, 1, 0, 1, '2022-01-06', 0),
(139, 16, '2022-01-01', 'Общество с ограниченной ответственностью «ЛенаСибУголь» ', 13, 13, '01', '2022', 7500, 6790, 0, 0, 1, '2022-01-06', 0),
(140, 17, '2022-01-01', 'Общество с ограниченной ответственностью «ЛАККИ»', 17, 17, '01', '2022', 11550, 10395, 1, 0, 1, '2022-01-06', 0),
(141, 18, '2022-01-01', 'Общество с ограниченной ответственностью «Сервис Групп»', 14, 14, '01', '2022', 11970, 10700, 0, 0, 1, '2022-01-06', 0),
(142, 19, '2022-01-01', 'Общество с ограниченной ответственностью &quot;СибНедра&quot; ', 16, 16, '01', '2022', 79632, 70000, 1, 0, 1, '2022-01-06', 0),
(143, 20, '2022-01-01', 'Общество с ограниченной ответственностью &quot;Бриз&quot;', 4, 4, '01', '2022', 34635, 31000, 0, 0, 1, '2022-01-06', 0),
(144, 21, '2022-01-01', 'Общество с ограниченной ответственностью &quot;Кастор&quot;', 15, 15, '01', '2022', 28300, 25470, 1, 0, 1, '2022-01-06', 0),
(146, 22, '2022-01-01', 'Общество с ограниченной ответственностью &quot;Гарант&quot;', 18, 18, '01', '2022', 21000, 18900, 0, 0, 1, '2022-01-06', 0),
(147, 23, '2021-06-01', 'Общество с ограниченной ответственностью &quot;Кастор&quot;', 15, 15, '06', '2021', 34645, 31150, 1, 0, 1, '2021-06-11', 0),
(148, 24, '2021-07-01', 'Общество с ограниченной ответственностью &quot;Кастор&quot;', 15, 15, '07', '2021', 34645, 31150, 1, 0, 1, '2021-07-06', 0),
(149, 25, '2021-08-01', 'Общество с ограниченной ответственностью &quot;Кастор&quot;', 15, 15, '08', '2021', 34645, 31150, 1, 0, 1, '2021-08-06', 0),
(150, 26, '2021-09-01', 'Общество с ограниченной ответственностью &quot;Кастор&quot;', 15, 15, '09', '2021', 16500, 14850, 1, 0, 1, '2021-09-06', 0),
(151, 27, '2021-10-01', 'Общество с ограниченной ответственностью &quot;Кастор&quot;', 15, 15, '10', '2021', 16500, 14850, 1, 0, 1, '2021-10-06', 0),
(152, 28, '2021-07-27', 'Красильникова Юлия Александровна', 2, 2, '07', '2021', 1805, 1624.5, 1, 0, 0.19, '2021-08-05', 0),
(153, 29, '2021-08-01', 'Красильникова Юлия Александровна', 2, 2, '08', '2021', 9500, 8550, 0, 0, 1, '2021-08-06', 0),
(154, 30, '2021-09-01', 'Красильникова Юлия Александровна', 2, 2, '09', '2021', 9500, 8550, 0, 0, 1, '2021-09-06', 0),
(155, 31, '2021-10-01', 'Красильникова Юлия Александровна', 2, 2, '10', '2021', 9500, 8550, 0, 0, 1, '2021-10-06', 0),
(156, 32, '2021-11-01', 'Красильникова Юлия Александровна', 2, 2, '11', '2021', 9500, 8550, 0, 0, 1, '2021-11-06', 0),
(157, 33, '2021-12-01', 'Красильникова Юлия Александровна', 2, 2, '12', '2021', 9500, 8550, 0, 0, 1, '2021-12-06', 0),
(158, 34, '2021-06-01', 'Общество с ограниченной ответственностью «ЛенаСибУголь» ', 13, 13, '06', '2021', 7500, 6790, 0, 0, 1, '2021-06-11', 0),
(159, 35, '2021-07-01', 'Общество с ограниченной ответственностью «ЛенаСибУголь» ', 13, 13, '07', '2021', 7500, 6790, 0, 0, 1, '2021-07-06', 0),
(160, 36, '2021-08-01', 'Общество с ограниченной ответственностью «ЛенаСибУголь» ', 13, 13, '08', '2021', 7500, 6790, 0, 0, 1, '2021-08-06', 0),
(161, 37, '2021-09-01', 'Общество с ограниченной ответственностью «ЛенаСибУголь» ', 13, 13, '09', '2021', 7500, 6790, 0, 0, 1, '2021-09-06', 0),
(162, 38, '2021-10-01', 'Общество с ограниченной ответственностью «ЛенаСибУголь» ', 13, 13, '10', '2021', 7500, 6790, 0, 0, 1, '2021-10-06', 0),
(163, 39, '2021-07-01', 'Общество с ограниченной ответственностью &quot;Бриз&quot;', 4, 4, '07', '2021', 34635, 31000, 0, 0, 1, '2021-07-11', 0),
(164, 40, '2021-08-01', 'Общество с ограниченной ответственностью &quot;Бриз&quot;', 4, 4, '08', '2021', 34635, 31000, 1, 0, 1, '2021-08-06', 0),
(165, 41, '2021-09-01', 'Общество с ограниченной ответственностью &quot;Бриз&quot;', 4, 4, '09', '2021', 34635, 31000, 1, 0, 1, '2021-09-06', 0),
(166, 42, '2021-10-01', 'Общество с ограниченной ответственностью &quot;Бриз&quot;', 4, 4, '10', '2021', 34635, 31000, 1, 0, 1, '2021-10-06', 0),
(167, 43, '2021-08-01', 'Общество с ограниченной ответственностью &quot;Гарант&quot;', 18, 18, '08', '2021', 21000, 18900, 0, 0, 1, '2021-08-11', 0),
(168, 44, '2021-09-01', 'Общество с ограниченной ответственностью &quot;Гарант&quot;', 18, 18, '09', '2021', 21000, 18900, 0, 0, 1, '2021-09-06', 0),
(169, 45, '2021-10-01', 'Общество с ограниченной ответственностью &quot;Гарант&quot;', 18, 18, '10', '2021', 21000, 18900, 0, 0, 1, '2021-10-06', 0),
(170, 46, '2021-06-01', 'Индивидуальный предприниматель Атанасова М.И.', 20, 20, '06', '2021', 9600, 8640, 1, 0, 1, '2021-06-11', 0),
(171, 47, '2021-07-01', 'Индивидуальный предприниматель Атанасова М.И.', 20, 20, '07', '2021', 9600, 8640, 0, 0, 1, '2021-07-06', 0),
(172, 48, '2021-08-01', 'Индивидуальный предприниматель Атанасова М.И.', 20, 20, '08', '2021', 9600, 8640, 1, 0, 1, '2021-08-06', 0),
(173, 49, '2021-09-01', 'Индивидуальный предприниматель Атанасова М.И.', 20, 20, '09', '2021', 9600, 8640, 1, 0, 1, '2021-09-06', 0),
(174, 50, '2021-10-01', 'Индивидуальный предприниматель Атанасова М.И.', 20, 20, '10', '2021', 9600, 8640, 1, 0, 1, '2021-10-06', 0),
(175, 51, '2021-11-01', 'Индивидуальный предприниматель Атанасова М.И.', 20, 20, '11', '2021', 9600, 8640, 1, 0, 1, '2021-11-06', 0),
(176, 52, '2021-12-01', 'Индивидуальный предприниматель Атанасова М.И.', 20, 20, '12', '2021', 9600, 8640, 1, 0, 1, '2021-12-06', 0),
(177, 53, '2022-01-01', 'Индивидуальный предприниматель Атанасова М.И.', 20, 20, '01', '2022', 9600, 8640, 1, 0, 1, '2022-01-06', 0),
(178, 54, '2021-11-23', 'Пожарская Екатерина Андреевна', 21, 21, '11', '2021', 3150, 2835, 0, 0, 0.3, '2021-12-02', 0),
(179, 55, '2021-12-01', 'Пожарская Екатерина Андреевна', 21, 21, '12', '2021', 10500, 9450, 1, 0, 1, '2021-12-06', 0),
(180, 56, '2022-01-01', 'Пожарская Екатерина Андреевна', 21, 21, '01', '2022', 10500, 9450, 1, 0, 1, '2022-01-06', 0),
(181, 57, '2021-09-01', 'Винокурова Евгения Валерьевна', 22, 22, '09', '2021', 10500, 9450, 1, 0, 1, '2021-09-11', 0),
(182, 58, '2021-10-01', 'Винокурова Евгения Валерьевна', 22, 22, '10', '2021', 10500, 9450, 1, 0, 1, '2021-10-06', 0),
(183, 59, '2021-11-01', 'Винокурова Евгения Валерьевна', 22, 22, '11', '2021', 10500, 9450, 1, 0, 1, '2021-11-06', 0),
(184, 60, '2021-12-01', 'Винокурова Евгения Валерьевна', 22, 22, '12', '2021', 10500, 9450, 0, 0, 1, '2021-12-06', 0),
(185, 61, '2022-01-01', 'Винокурова Евгения Валерьевна', 22, 22, '01', '2022', 10500, 9450, 0, 0, 1, '2022-01-06', 0),
(186, 62, '2021-09-01', 'Кудряшова Наталья Викторовна', 23, 23, '09', '2021', 10500, 9450, 1, 0, 1, '2021-09-11', 0),
(187, 63, '2021-10-01', 'Кудряшова Наталья Викторовна', 23, 23, '10', '2021', 10500, 9450, 1, 0, 1, '2021-10-06', 0),
(188, 64, '2021-11-01', 'Кудряшова Наталья Викторовна', 23, 23, '11', '2021', 10500, 9450, 1, 0, 1, '2021-11-06', 0),
(189, 65, '2021-12-01', 'Кудряшова Наталья Викторовна', 23, 23, '12', '2021', 10500, 9450, 1, 0, 1, '2021-12-06', 0),
(190, 66, '2022-01-01', 'Кудряшова Наталья Викторовна', 23, 23, '01', '2022', 10500, 9450, 1, 0, 1, '2022-01-06', 0),
(191, 67, '2021-09-01', 'Маркелова Дарья Дмитриевна', 24, 24, '09', '2021', 15100, 13590, 0, 0, 1, '2021-09-11', 0),
(192, 68, '2021-10-01', 'Маркелова Дарья Дмитриевна', 24, 24, '10', '2021', 15100, 13590, 0, 0, 1, '2021-10-06', 0),
(193, 69, '2021-11-01', 'Маркелова Дарья Дмитриевна', 24, 24, '11', '2021', 15100, 13590, 0, 0, 1, '2021-11-06', 0),
(194, 70, '2021-12-01', 'Маркелова Дарья Дмитриевна', 24, 24, '12', '2021', 15100, 13590, 0, 0, 1, '2021-12-06', 0),
(195, 71, '2022-01-01', 'Маркелова Дарья Дмитриевна', 24, 24, '01', '2022', 15100, 13590, 0, 0, 1, '2022-01-06', 0),
(196, 72, '2021-07-07', 'Швецова Юлия Андреевна', 25, 25, '07', '2021', 7980, 7182, 1, 0, 0.84, '2021-07-16', 0),
(197, 73, '2021-08-01', 'Швецова Юлия Андреевна', 25, 25, '08', '2021', 9500, 8550, 1, 0, 1, '2021-08-06', 0),
(198, 74, '2021-09-01', 'Швецова Юлия Андреевна', 25, 25, '09', '2021', 9500, 8550, 1, 0, 1, '2021-09-06', 0),
(199, 75, '2021-10-01', 'Швецова Юлия Андреевна', 25, 25, '10', '2021', 9500, 8550, 1, 0, 1, '2021-10-06', 0),
(200, 76, '2021-11-01', 'Швецова Юлия Андреевна', 25, 25, '11', '2021', 9500, 8550, 1, 0, 1, '2021-11-06', 0),
(201, 77, '2021-12-01', 'Швецова Юлия Андреевна', 25, 25, '12', '2021', 9500, 8550, 1, 0, 1, '2021-12-06', 0),
(202, 78, '2022-01-01', 'Швецова Юлия Андреевна', 25, 25, '01', '2022', 9500, 8550, 1, 0, 1, '2022-01-06', 0),
(203, 79, '2021-11-01', 'Добролюбова Наталья Александровна', 26, 26, '11', '2021', 9675, 8700, 1, 0, 1, '2021-11-11', 0),
(204, 80, '2021-12-01', 'Добролюбова Наталья Александровна', 26, 26, '12', '2021', 9675, 8700, 1, 0, 1, '2021-12-06', 0),
(205, 81, '2022-01-01', 'Добролюбова Наталья Александровна', 26, 26, '01', '2022', 9675, 8700, 1, 0, 1, '2022-01-06', 0),
(206, 82, '2021-12-01', 'Федотова Ирина Витальевна', 27, 27, '12', '2021', 7900, 7900, 1, 1, 1, '2021-12-11', 0),
(207, 83, '2022-01-01', 'Федотова Ирина Витальевна', 27, 27, '01', '2022', 7900, 7900, 1, 1, 1, '2022-01-06', 0),
(208, 84, '2021-09-01', 'Иванченко Ксения Ивановна', 28, 28, '09', '2021', 3570, 3200, 0, 0, 1, '2021-09-11', 0),
(209, 85, '2021-10-01', 'Иванченко Ксения Ивановна', 28, 28, '10', '2021', 3570, 3200, 0, 0, 1, '2021-10-06', 0),
(210, 86, '2021-11-01', 'Иванченко Ксения Ивановна', 28, 28, '11', '2021', 3570, 3200, 0, 0, 1, '2021-11-06', 0),
(211, 87, '2021-12-01', 'Иванченко Ксения Ивановна', 28, 28, '12', '2021', 3570, 3200, 0, 0, 1, '2021-12-06', 0),
(212, 88, '2022-01-01', 'Иванченко Ксения Ивановна', 28, 28, '01', '2022', 3570, 3200, 0, 0, 1, '2022-01-06', 0),
(213, 89, '2021-07-01', 'Дубкова Наталья Сергеевна', 29, 29, '07', '2021', 9000, 8100, 1, 0, 1, '2021-07-11', 0),
(214, 90, '2021-08-01', 'Дубкова Наталья Сергеевна', 29, 29, '08', '2021', 9000, 8100, 0, 0, 1, '2021-08-06', 0),
(215, 91, '2021-09-01', 'Дубкова Наталья Сергеевна', 29, 29, '09', '2021', 9000, 8100, 0, 0, 1, '2021-09-06', 0),
(216, 92, '2021-10-01', 'Дубкова Наталья Сергеевна', 29, 29, '10', '2021', 9000, 8100, 0, 0, 1, '2021-10-06', 0),
(217, 93, '2021-11-01', 'Дубкова Наталья Сергеевна', 29, 29, '11', '2021', 9000, 8100, 1, 0, 1, '2021-11-06', 0),
(218, 94, '2021-12-01', 'Дубкова Наталья Сергеевна', 29, 29, '12', '2021', 9000, 8100, 0, 0, 1, '2021-12-06', 0),
(219, 95, '2022-01-01', 'Дубкова Наталья Сергеевна', 29, 29, '01', '2022', 9000, 8100, 0, 0, 1, '2022-01-06', 0),
(220, 96, '2021-07-01', 'ЧАСТНОЕ УЧРЕЖДЕНИЕ ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ ИРКУТСКИЙ ГУМАНИТАРНО-ТЕХНИЧЕСКИСКИЙ КОЛЛЕДЖ (г. УСТЬ-КУТ)', 30, 30, '07', '2021', 99720, 99720, 0, 0, 1, '2021-07-11', 0),
(221, 97, '2021-08-01', 'ЧАСТНОЕ УЧРЕЖДЕНИЕ ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ ИРКУТСКИЙ ГУМАНИТАРНО-ТЕХНИЧЕСКИСКИЙ КОЛЛЕДЖ (г. УСТЬ-КУТ)', 30, 30, '08', '2021', 99720, 99720, 0, 0, 1, '2021-08-06', 0),
(222, 98, '2021-09-01', 'ЧАСТНОЕ УЧРЕЖДЕНИЕ ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ ИРКУТСКИЙ ГУМАНИТАРНО-ТЕХНИЧЕСКИСКИЙ КОЛЛЕДЖ (г. УСТЬ-КУТ)', 30, 30, '09', '2021', 99720, 99720, 0, 0, 1, '2021-09-06', 0),
(223, 99, '2021-10-01', 'ЧАСТНОЕ УЧРЕЖДЕНИЕ ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ ИРКУТСКИЙ ГУМАНИТАРНО-ТЕХНИЧЕСКИСКИЙ КОЛЛЕДЖ (г. УСТЬ-КУТ)', 30, 30, '10', '2021', 99720, 99720, 0, 0, 1, '2021-10-06', 0),
(224, 100, '2021-11-01', 'ЧАСТНОЕ УЧРЕЖДЕНИЕ ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ ИРКУТСКИЙ ГУМАНИТАРНО-ТЕХНИЧЕСКИСКИЙ КОЛЛЕДЖ (г. УСТЬ-КУТ)', 30, 30, '11', '2021', 99720, 99720, 0, 0, 1, '2021-11-06', 0),
(225, 101, '2021-12-01', 'ЧАСТНОЕ УЧРЕЖДЕНИЕ ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ ИРКУТСКИЙ ГУМАНИТАРНО-ТЕХНИЧЕСКИСКИЙ КОЛЛЕДЖ (г. УСТЬ-КУТ)', 30, 30, '12', '2021', 99720, 99720, 0, 0, 1, '2021-12-06', 0),
(226, 102, '2022-01-01', 'ЧАСТНОЕ УЧРЕЖДЕНИЕ ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ ИРКУТСКИЙ ГУМАНИТАРНО-ТЕХНИЧЕСКИСКИЙ КОЛЛЕДЖ (г. УСТЬ-КУТ)', 30, 30, '01', '2022', 99720, 99720, 0, 0, 1, '2022-01-06', 0),
(227, 103, '2021-05-01', 'Купрякова Алёна Александровна', 31, 31, '05', '2021', 9000, 8100, 1, 0, 1, '2021-05-11', 0),
(228, 104, '2021-06-01', 'Купрякова Алёна Александровна', 31, 31, '06', '2021', 9000, 8100, 1, 0, 1, '2021-06-06', 0),
(229, 105, '2021-07-01', 'Купрякова Алёна Александровна', 31, 31, '07', '2021', 9000, 8100, 1, 0, 1, '2021-07-06', 0),
(230, 106, '2021-08-01', 'Купрякова Алёна Александровна', 31, 31, '08', '2021', 9000, 8100, 1, 0, 1, '2021-08-06', 0),
(231, 107, '2021-09-01', 'Купрякова Алёна Александровна', 31, 31, '09', '2021', 9000, 8100, 1, 0, 1, '2021-09-06', 0),
(232, 108, '2021-10-01', 'Купрякова Алёна Александровна', 31, 31, '10', '2021', 9000, 8100, 1, 0, 1, '2021-10-06', 0),
(233, 109, '2021-11-01', 'Купрякова Алёна Александровна', 31, 31, '11', '2021', 9000, 8100, 1, 0, 1, '2021-11-06', 0),
(234, 110, '2021-12-01', 'Купрякова Алёна Александровна', 31, 31, '12', '2021', 9000, 8100, 1, 0, 1, '2021-12-06', 0),
(235, 111, '2022-01-01', 'Купрякова Алёна Александровна', 31, 31, '01', '2022', 9000, 8100, 1, 0, 1, '2022-01-06', 0),
(236, 112, '2022-02-01', 'Купрякова Алёна Александровна', 31, 31, '02', '2022', 9000, 8100, 1, 0, 1, '2022-02-06', 0),
(237, 113, '2021-06-01', 'Общество с ограниченной ответственностью &quot;КасСервис&quot;', 32, 32, '06', '2021', 27300, 24000, 1, 0, 1, '2021-06-11', 0),
(238, 114, '2021-07-01', 'Общество с ограниченной ответственностью &quot;КасСервис&quot;', 32, 32, '07', '2021', 27300, 24000, 1, 0, 1, '2021-07-06', 0),
(239, 115, '2021-08-01', 'Общество с ограниченной ответственностью &quot;КасСервис&quot;', 32, 32, '08', '2021', 27300, 24000, 1, 0, 1, '2021-08-06', 0),
(240, 116, '2021-09-01', 'Общество с ограниченной ответственностью &quot;КасСервис&quot;', 32, 32, '09', '2021', 27300, 24000, 1, 0, 1, '2021-09-06', 0),
(241, 117, '2021-10-01', 'Общество с ограниченной ответственностью &quot;КасСервис&quot;', 32, 32, '10', '2021', 27300, 24000, 1, 0, 1, '2021-10-06', 0),
(242, 118, '2021-11-01', 'Общество с ограниченной ответственностью &quot;КасСервис&quot;', 32, 32, '11', '2021', 27300, 24000, 1, 0, 1, '2021-11-06', 0),
(243, 119, '2021-12-01', 'Общество с ограниченной ответственностью &quot;КасСервис&quot;', 32, 32, '12', '2021', 27300, 24000, 1, 0, 1, '2021-12-06', 0),
(244, 120, '2022-01-01', 'Общество с ограниченной ответственностью &quot;КасСервис&quot;', 32, 32, '01', '2022', 27300, 24000, 1, 0, 1, '2022-01-06', 0),
(245, 121, '2022-02-01', 'Общество с ограниченной ответственностью &quot;КасСервис&quot;', 32, 32, '02', '2022', 27300, 24000, 1, 0, 1, '2022-02-06', 0),
(246, 122, '2022-01-01', 'Исаков Роман Иванович', 33, 33, '01', '2022', 9300, 8350, 0, 0, 1, '2022-01-11', 0),
(247, 123, '2022-02-01', 'Исаков Роман Иванович', 33, 33, '02', '2022', 9300, 8350, 0, 0, 1, '2022-02-06', 0),
(248, 124, '2021-06-01', 'Попова Кристина Александровна', 34, 34, '06', '2021', 7700, 6900, 1, 0, 1, '2021-06-11', 0),
(249, 125, '2021-07-01', 'Попова Кристина Александровна', 34, 34, '07', '2021', 7700, 6900, 1, 0, 1, '2021-07-06', 0),
(250, 126, '2021-08-01', 'Попова Кристина Александровна', 34, 34, '08', '2021', 7700, 6900, 1, 0, 1, '2021-08-06', 0),
(251, 127, '2021-09-01', 'Попова Кристина Александровна', 34, 34, '09', '2021', 7700, 6900, 1, 0, 1, '2021-09-06', 0),
(252, 128, '2021-10-01', 'Попова Кристина Александровна', 34, 34, '10', '2021', 7700, 6900, 1, 0, 1, '2021-10-06', 0),
(253, 129, '2021-11-01', 'Попова Кристина Александровна', 34, 34, '11', '2021', 7700, 6900, 1, 0, 1, '2021-11-06', 0),
(254, 130, '2021-12-01', 'Попова Кристина Александровна', 34, 34, '12', '2021', 7700, 6900, 1, 0, 1, '2021-12-06', 0),
(255, 131, '2022-01-01', 'Попова Кристина Александровна', 34, 34, '01', '2022', 7700, 6900, 0, 0, 1, '2022-01-06', 0),
(256, 132, '2022-02-01', 'Попова Кристина Александровна', 34, 34, '02', '2022', 7700, 6900, 0, 0, 1, '2022-02-06', 0),
(257, 133, '2021-06-01', 'Индивидуальный предприниматель Горбунова Ольга Владимировна', 35, 35, '06', '2021', 31924, 27500, 1, 0, 1, '2021-06-11', 0),
(258, 134, '2021-07-01', 'Индивидуальный предприниматель Горбунова Ольга Владимировна', 35, 35, '07', '2021', 31924, 27500, 1, 0, 1, '2021-07-06', 0),
(259, 135, '2021-08-01', 'Индивидуальный предприниматель Горбунова Ольга Владимировна', 35, 35, '08', '2021', 31924, 27500, 1, 0, 1, '2021-08-06', 0),
(260, 136, '2021-09-01', 'Индивидуальный предприниматель Горбунова Ольга Владимировна', 35, 35, '09', '2021', 31924, 27500, 1, 0, 1, '2021-09-06', 0),
(261, 137, '2021-10-01', 'Индивидуальный предприниматель Горбунова Ольга Владимировна', 35, 35, '10', '2021', 31924, 27500, 1, 0, 1, '2021-10-06', 0),
(262, 138, '2021-11-01', 'Индивидуальный предприниматель Горбунова Ольга Владимировна', 35, 35, '11', '2021', 31924, 27500, 1, 0, 1, '2021-11-06', 0),
(263, 139, '2021-12-01', 'Индивидуальный предприниматель Горбунова Ольга Владимировна', 35, 35, '12', '2021', 31924, 27500, 1, 0, 1, '2021-12-06', 0),
(264, 140, '2022-01-01', 'Индивидуальный предприниматель Горбунова Ольга Владимировна', 35, 35, '01', '2022', 31924, 27500, 1, 0, 1, '2022-01-06', 0),
(265, 141, '2022-02-01', 'Индивидуальный предприниматель Горбунова Ольга Владимировна', 35, 35, '02', '2022', 31924, 27500, 1, 0, 1, '2022-02-06', 0),
(266, 142, '2022-02-01', 'Общество с ограниченной ответственностью &quot;Алькор&quot;', 5, 5, '02', '2022', 8700, 7830, 1, 0, 1, '2022-02-06', 0),
(267, 143, '2022-02-01', 'Урадовских Кристина Владимировна', 6, 6, '02', '2022', 9500, 8550, 1, 0, 1, '2022-02-06', 0),
(268, 144, '2022-02-01', 'Общество с ограниченной ответственностью «Лидерстрой»', 7, 7, '02', '2022', 34342, 30900, 0, 0, 1, '2022-02-06', 0),
(269, 145, '2022-02-01', 'Общество с ограниченной ответственностью «ПКО Аркон»', 9, 9, '02', '2022', 18000, 16000, 0, 0, 1, '2022-02-06', 0),
(270, 146, '2022-02-01', 'Индивидуальный предприниматель Куликова Татьяна Сергеевна', 10, 10, '02', '2022', 15500, 14000, 0, 0, 1, '2022-02-06', 0),
(271, 147, '2022-02-01', 'Сокольская Зинаида Владимировна', 11, 11, '02', '2022', 10000, 9000, 1, 0, 1, '2022-02-06', 0),
(272, 148, '2022-02-01', 'Индивидуальный предприниматель Атанасова М.И.', 20, 20, '02', '2022', 9600, 8640, 1, 0, 1, '2022-02-06', 0),
(273, 149, '2022-02-01', 'Пожарская Екатерина Андреевна', 21, 21, '02', '2022', 10500, 9450, 1, 0, 1, '2022-02-06', 0),
(274, 150, '2022-02-01', 'Винокурова Евгения Валерьевна', 22, 22, '02', '2022', 10500, 9450, 0, 0, 1, '2022-02-06', 0),
(275, 151, '2022-02-01', 'Кудряшова Наталья Викторовна', 23, 23, '02', '2022', 10500, 9450, 1, 0, 1, '2022-02-06', 0),
(276, 152, '2022-02-01', 'Маркелова Дарья Дмитриевна', 24, 24, '02', '2022', 15100, 13590, 0, 0, 1, '2022-02-06', 0),
(277, 153, '2022-02-01', 'Швецова Юлия Андреевна', 25, 25, '02', '2022', 9500, 8550, 1, 0, 1, '2022-02-06', 0),
(278, 154, '2022-02-01', 'Добролюбова Наталья Александровна', 26, 26, '02', '2022', 9675, 8700, 1, 0, 1, '2022-02-06', 0),
(279, 155, '2022-02-01', 'Федотова Ирина Витальевна', 27, 27, '02', '2022', 9375, 8430, 1, 0, 1, '2022-02-06', 0),
(280, 156, '2022-02-01', 'Общество с ограниченной ответственностью «ЛенаСибУголь» ', 13, 13, '02', '2022', 7500, 6790, 1, 0, 1, '2022-02-06', 0),
(281, 157, '2022-02-01', 'Иванченко Ксения Ивановна', 28, 28, '02', '2022', 3570, 3200, 0, 0, 1, '2022-02-06', 0),
(282, 158, '2022-02-01', 'Дубкова Наталья Сергеевна', 29, 29, '02', '2022', 9000, 8100, 0, 0, 1, '2022-02-06', 0),
(283, 159, '2022-02-01', 'Общество с ограниченной ответственностью «ЛАККИ»', 17, 17, '02', '2022', 11550, 10395, 1, 0, 1, '2022-02-06', 0),
(284, 160, '2022-02-01', 'ЧАСТНОЕ УЧРЕЖДЕНИЕ ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ ИРКУТСКИЙ ГУМАНИТАРНО-ТЕХНИЧЕСКИСКИЙ КОЛЛЕДЖ (г. УСТЬ-КУТ)', 30, 30, '02', '2022', 99720, 99720, 0, 0, 1, '2022-02-06', 0),
(285, 161, '2022-02-01', 'Общество с ограниченной ответственностью «Сервис Групп»', 14, 14, '02', '2022', 11970, 10700, 1, 0, 1, '2022-02-06', 0),
(286, 162, '2022-02-01', 'Общество с ограниченной ответственностью &quot;Проект-Инвест&quot;', 3, 3, '02', '2022', 29445, 26500, 0, 0, 1, '2022-02-06', 0),
(287, 163, '2022-02-01', 'Общество с ограниченной ответственностью &quot;СибНедра&quot; ', 16, 16, '02', '2022', 79632, 70000, 1, 0, 1, '2022-02-06', 0),
(288, 164, '2022-02-01', 'Общество с ограниченной ответственностью &quot;Бриз&quot;', 4, 4, '02', '2022', 34635, 31000, 0, 0, 1, '2022-02-06', 0),
(289, 165, '2022-02-01', 'Общество с ограниченной ответственностью &quot;Гарант&quot;', 18, 18, '02', '2022', 21000, 18900, 1, 0, 1, '2022-02-06', 0),
(292, 166, '2022-02-01', 'Индивидуальный предприниматель Помигалов Игорь Юрьевич', 19, 19, '02', '2022', 9920, 8900, 1, 0, 1, '2022-02-06', 0),
(293, 167, '2022-02-01', 'Общество с ограниченной ответственностью &quot;ТрансРегион&quot;', 8, 8, '02', '2022', 79640, 68000, 1, 0, 1, '2022-02-06', 0),
(294, 168, '2022-02-01', 'Общество с ограниченной ответственностью &quot;Кастор&quot;', 15, 15, '02', '2022', 28300, 25470, 0, 0, 1, '2022-02-06', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `kir_license`
--

CREATE TABLE IF NOT EXISTS `kir_license` (
  `license` varchar(24) NOT NULL COMMENT 'Лицензионный номер',
  `data` blob,
  `crypt_type` varchar(255) DEFAULT 'mcrypt',
  `type` varchar(50) DEFAULT NULL COMMENT 'Тип лицензии',
  PRIMARY KEY (`license`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_license`
--

INSERT INTO `kir_license` (`license`, `data`, `crypt_type`, `type`) VALUES
('WSVQ-UJQF-MR2N-GFAM-1D33', 0x454b6d5749365950594d464b7868704c46366a487545573453495a7036796865782f4e4d6a44344a4a767934704237676d76377767634734715a6c316a776a45336b517a593143614961502f675a30443855775442792f5865664a48382b6e456c526c706c4c7068527158662b70636636364777696d4a664c717a4f5862374a37425543485333432f4b7950503558766a2b6b7336554a6f6e67764c4a4f314b5a6b4f4d73354f33356c526b7259324a77345738345a79436c56446d516f5961625a4f6138705a424c536e44624351382f47726b33506b7945556d3047344878616735684677756f3244334f376c3052466e4f50437874337143594b3263466e7a5776683156656d716175747338482f36334c6e496c6a4e33487142744c756433436b7276496c487a384d4859643834516d763370716831613269393745692f56737759746478372f68544438334f58444651775a34736e762f503148644f68786261474848774a4f58616c3556315159706e76514f6c36554c776c4e746b4d51696f6b2b6854764e43355246396e535336496e62736e53527a30396c644b6951454441344a54346156757767494e365370345276496239426a774b536c636241577872616e366e53687a675433614e7449706b456d79384a3166674e3850634739596357677262314e746963374c72396436464d4c796565586231744e364d666634624b6e596437704e374768494e4c794971543134674f656770374a494a7145654972776167752f796357666c314b7769587050754a345a4b453348796e6574573364696a33734e3650543255386754594e734848792b7232772f613957592b7437796865354f4542355a5144654a46613559374a4871356f6d745a5a38584e65614a4e786b716a39697a794f686366614a4e32714b6a586557446f4a5964356c41384275574d4c383d, 'openssl', 'script');

-- --------------------------------------------------------

--
-- Структура таблицы `kir_long_polling_event`
--

CREATE TABLE IF NOT EXISTS `kir_long_polling_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `user_id` bigint(11) DEFAULT NULL COMMENT 'Пользователь-адресат',
  `date_create` datetime DEFAULT NULL COMMENT 'Дата создания события',
  `event_name` varchar(255) DEFAULT NULL COMMENT 'Имя события',
  `json_data` mediumtext COMMENT 'JSON данные, которые следует передать с событием',
  `expire` datetime DEFAULT NULL COMMENT 'Время потери актуальности',
  PRIMARY KEY (`id`),
  KEY `expire_user_id` (`expire`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_menu`
--

CREATE TABLE IF NOT EXISTS `kir_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `menutype` varchar(70) DEFAULT NULL COMMENT 'Тип меню',
  `title` varchar(150) DEFAULT NULL COMMENT 'Название',
  `hide_from_url` int(1) DEFAULT NULL COMMENT 'Не использовать для построения URL',
  `alias` varchar(150) DEFAULT NULL COMMENT 'Симв. идентификатор',
  `parent` int(11) DEFAULT '0' COMMENT 'Родитель',
  `public` int(1) DEFAULT '1' COMMENT 'Публичный',
  `typelink` varchar(20) DEFAULT 'article' COMMENT 'Тип элемента',
  `sortn` int(11) DEFAULT NULL COMMENT 'Порядк. №',
  `content` mediumtext COMMENT 'Статья',
  `link` varchar(255) DEFAULT NULL COMMENT 'Ссылка',
  `target_blank` int(1) DEFAULT '0' COMMENT 'Открывать ссылку в новом окне',
  `link_template` varchar(255) DEFAULT NULL COMMENT 'Шаблон',
  `mobile_public` int(1) DEFAULT '0' COMMENT 'Показывать в мобильном приложении',
  `mobile_image` varchar(50) DEFAULT NULL COMMENT 'Идентификатор картинки Ionic 2',
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_id_alias_parent` (`site_id`,`alias`,`parent`),
  KEY `parent_sortn` (`parent`,`sortn`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_module_config`
--

CREATE TABLE IF NOT EXISTS `kir_module_config` (
  `site_id` int(11) NOT NULL COMMENT 'ID сайта',
  `module` varchar(150) NOT NULL COMMENT 'Имя модуля',
  `data` mediumtext COMMENT 'Данные модуля',
  PRIMARY KEY (`site_id`,`module`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_module_config`
--

INSERT INTO `kir_module_config` (`site_id`, `module`, `data`) VALUES
(1, 'menu', 'a:4:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838673;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;}'),
(1, 'site', 'a:4:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838673;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;}'),
(1, 'main', 'a:27:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838675;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;s:13:\"image_quality\";s:2:\"95\";s:9:\"watermark\";N;s:15:\"wmark_min_width\";s:3:\"300\";s:16:\"wmark_min_height\";s:3:\"300\";s:11:\"wmark_pos_x\";s:6:\"center\";s:11:\"wmark_pos_y\";s:6:\"middle\";s:13:\"wmark_opacity\";s:3:\"100\";s:18:\"webp_generate_only\";N;s:21:\"webp_disable_on_apple\";N;s:11:\"csv_charset\";s:12:\"windows-1251\";s:13:\"csv_delimiter\";s:1:\";\";s:17:\"csv_check_timeout\";s:1:\"1\";s:11:\"csv_timeout\";s:2:\"26\";s:14:\"geo_ip_service\";s:9:\"ipgeobase\";s:12:\"dadata_token\";N;s:23:\"long_polling_can_enable\";s:1:\"1\";s:24:\"long_polling_timeout_sec\";s:2:\"20\";s:38:\"long_polling_event_listen_interval_sec\";s:1:\"1\";s:22:\"yandex_js_api_geocoder\";N;s:14:\"dadata_api_key\";N;s:17:\"dadata_secret_key\";N;s:17:\"dadata_enable_log\";i:0;s:21:\"enable_remote_support\";s:1:\"1\";}'),
(1, 'users', 'a:32:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838679;s:7:\"enabled\";i:1;s:11:\"deactivated\";N;s:24:\"generate_password_length\";i:8;s:26:\"replace_country_phone_code\";i:8;s:20:\"country_phone_length\";i:11;s:26:\"default_country_phone_code\";i:7;s:25:\"generate_password_symbols\";s:64:\"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789#?\";s:10:\"userfields\";a:0:{}s:19:\"clear_for_last_time\";i:2160;s:12:\"clear_random\";i:5;s:9:\"type_auth\";i:0;s:18:\"type_code_provider\";s:3:\"sms\";s:15:\"two_factor_auth\";i:2;s:19:\"two_factor_register\";i:1;s:18:\"two_factor_recover\";i:0;s:31:\"lifetime_resolved_session_hours\";i:2;s:17:\"register_by_phone\";i:0;s:16:\"send_count_limit\";i:5;s:20:\"resend_delay_seconds\";i:60;s:19:\"block_delay_minutes\";i:20;s:22:\"lifetime_session_hours\";i:2;s:15:\"try_count_limit\";i:10;s:21:\"lifetime_code_minutes\";i:10;s:22:\"ip_limit_session_count\";i:30;s:11:\"code_length\";i:4;s:20:\"two_factor_demo_mode\";i:0;s:14:\"visible_fields\";a:1:{i:0;s:7:\"midname\";}s:14:\"require_fields\";a:5:{i:0;s:5:\"login\";i:1;s:6:\"e_mail\";i:2;s:5:\"phone\";i:3;s:4:\"name\";i:4;s:7:\"surname\";}s:12:\"login_fields\";a:1:{i:0;s:5:\"login\";}s:18:\"user_one_fio_field\";i:0;}'),
(1, 'modcontrol', 'a:4:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838679;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;}'),
(1, 'alerts', 'a:9:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838680;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;s:16:\"sms_sender_class\";s:9:\"smsuslugi\";s:16:\"sms_sender_login\";N;s:15:\"sms_sender_pass\";N;s:25:\"notice_items_delete_hours\";s:3:\"120\";s:17:\"allow_user_groups\";a:2:{i:0;s:10:\"supervisor\";i:1;s:6:\"admins\";}}'),
(1, 'article', 'a:6:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838681;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;s:21:\"preview_list_pagesize\";s:2:\"10\";s:13:\"search_fields\";a:4:{i:0;s:5:\"title\";i:1;s:13:\"short_content\";i:2;s:7:\"content\";i:3;s:13:\"meta_keywords\";}}'),
(1, 'atolonline', 'a:13:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838682;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;s:11:\"service_url\";N;s:14:\"_load_settings\";N;s:5:\"login\";N;s:4:\"pass\";N;s:10:\"group_code\";N;s:3:\"inn\";N;s:3:\"sno\";N;s:6:\"domain\";N;s:11:\"api_version\";s:1:\"3\";}'),
(1, 'banners', 'a:4:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838684;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;}'),
(1, 'comments', 'a:8:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838685;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;s:13:\"need_moderate\";s:1:\"N\";s:19:\"allow_more_comments\";s:1:\"0\";s:14:\"need_authorize\";s:1:\"N\";s:23:\"widget_newlist_pagesize\";s:1:\"8\";}'),
(0, 'crm', 'a:19:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838689;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;s:20:\"widget_task_pagesize\";s:2:\"15\";s:31:\"expiration_task_notice_statuses\";a:1:{i:0;s:1:\"0\";}s:35:\"expiration_task_default_notice_time\";a:1:{i:0;s:3:\"300\";}s:23:\"implementer_user_groups\";a:2:{i:0;s:10:\"supervisor\";i:1;s:6:\"admins\";}s:15:\"deal_userfields\";N;s:22:\"interaction_userfields\";N;s:15:\"task_userfields\";N;s:14:\"tel_secret_key\";N;s:19:\"tel_active_provider\";N;s:28:\"tel_enable_call_notification\";s:1:\"1\";s:20:\"tel_bottom_offset_px\";s:1:\"0\";s:14:\"telphin_app_id\";N;s:18:\"telphin_app_secret\";N;s:16:\"telphin_user_map\";N;s:23:\"telphin_download_record\";N;}'),
(1, 'designer', 'a:6:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838691;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;s:14:\"ya_map_api_key\";N;s:17:\"designer_settings\";N;}'),
(1, 'emailsubscribe', 'a:6:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838691;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;s:17:\"dialog_open_delay\";s:1:\"0\";s:18:\"send_confirm_email\";s:1:\"1\";}'),
(1, 'export', 'a:5:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838693;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;s:20:\"check_product_change\";N;}'),
(1, 'extcsv', 'a:7:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838697;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;s:13:\"csv_id_fields\";a:1:{i:0;s:7:\"barcode\";}s:24:\"csv_recommended_id_field\";s:5:\"title\";s:24:\"csv_concomitant_id_field\";s:5:\"title\";}'),
(1, 'externalapi', 'a:13:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838698;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;s:12:\"allow_domain\";N;s:7:\"api_key\";s:8:\"mds9jg1h\";s:15:\"enable_api_help\";s:1:\"0\";s:27:\"show_internal_error_details\";s:1:\"0\";s:14:\"token_lifetime\";s:8:\"31536000\";s:19:\"default_api_version\";s:1:\"1\";s:18:\"enable_request_log\";N;s:18:\"disable_image_webp\";s:1:\"1\";s:17:\"allow_api_methods\";a:1:{i:0;s:3:\"all\";}}'),
(1, 'feedback', 'a:4:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838699;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;}'),
(1, 'files', 'a:4:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838702;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;}'),
(1, 'install', 'a:4:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838702;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;}'),
(1, 'kaptcha', 'a:12:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838703;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;s:26:\"rs_captcha_allowed_symbols\";s:29:\"123456789abcdefghikmnpqrstuvw\";s:17:\"rs_captcha_length\";s:1:\"6\";s:16:\"rs_captcha_width\";s:3:\"100\";s:17:\"rs_captcha_height\";s:2:\"42\";s:21:\"recaptcha_v3_site_key\";N;s:23:\"recaptcha_v3_secret_key\";N;s:26:\"recaptcha_v3_success_score\";s:3:\"0.5\";s:25:\"recaptcha_v3_hide_sticker\";N;}'),
(1, 'marketplace', 'a:5:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838704;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;s:20:\"allow_remote_install\";i:1;}'),
(1, 'mobilemanagerapp', 'a:6:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838704;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;s:17:\"allow_user_groups\";a:2:{i:0;s:10:\"supervisor\";i:1;s:6:\"admins\";}s:11:\"push_enable\";s:1:\"1\";}'),
(1, 'mobilesiteapp', 'a:21:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838705;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;s:13:\"default_theme\";s:13:\"mobilesiteapp\";s:17:\"allow_user_groups\";a:4:{i:0;s:10:\"supervisor\";i:1;s:6:\"admins\";i:2;s:7:\"clients\";i:3;s:5:\"guest\";}s:11:\"disable_buy\";s:1:\"0\";s:11:\"push_enable\";s:1:\"1\";s:11:\"banner_zone\";s:1:\"0\";s:12:\"mobile_phone\";s:0:\"\";s:8:\"root_dir\";s:1:\"0\";s:21:\"tablet_root_dir_sizes\";s:10:\"ssMssMssss\";s:17:\"products_pagesize\";s:2:\"20\";s:13:\"menu_root_dir\";s:1:\"0\";s:16:\"top_products_dir\";s:1:\"0\";s:21:\"top_products_pagesize\";s:1:\"8\";s:18:\"top_products_order\";s:5:\"title\";s:20:\"mobile_products_size\";s:1:\"6\";s:20:\"tablet_products_size\";s:1:\"4\";s:21:\"article_root_category\";N;s:18:\"enable_app_sticker\";s:1:\"1\";}'),
(1, 'notes', 'a:5:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838708;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;s:22:\"widget_notes_page_size\";s:2:\"10\";}'),
(1, 'pageseo', 'a:4:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838709;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;}'),
(1, 'photo', 'a:8:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838710;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;s:22:\"original_photos_resize\";s:1:\"1\";s:21:\"original_photos_width\";s:4:\"1500\";s:22:\"original_photos_height\";s:4:\"1500\";s:23:\"product_sort_photo_desc\";s:1:\"0\";}'),
(1, 'photogalleries', 'a:4:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838712;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;}'),
(1, 'pushsender', 'a:6:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838713;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;s:20:\"googlefcm_server_key\";N;s:10:\"enable_log\";N;}'),
(1, 'search', 'a:8:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838713;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;s:14:\"search_service\";s:26:\"\\Search\\Model\\Engine\\Mysql\";s:11:\"search_type\";s:4:\"like\";s:41:\"search_type_likeplus_spell_checker_enable\";s:1:\"0\";s:35:\"search_type_likeplus_ignore_symbols\";s:50:\"`~!@#$%^&amp;*()-_=+\\|[]{};:&quot;\',.&lt;&gt;/?№\";}'),
(1, 'sitemap', 'a:11:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838714;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;s:8:\"priority\";s:3:\"0.5\";s:10:\"changefreq\";s:8:\"disabled\";s:28:\"set_generate_time_as_lastmod\";N;s:8:\"lifetime\";s:4:\"1440\";s:8:\"add_urls\";N;s:12:\"exclude_urls\";N;s:20:\"max_chunk_item_count\";s:5:\"50000\";}'),
(1, 'siteupdate', 'a:5:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838714;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;s:26:\"file_download_part_size_mb\";s:1:\"7\";}'),
(1, 'support', 'a:6:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838715;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;s:25:\"send_admin_message_notice\";s:1:\"Y\";s:24:\"send_user_message_notice\";s:1:\"Y\";}'),
(1, 'tags', 'a:4:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838717;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;}'),
(1, 'templates', 'a:4:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838719;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;}'),
(1, 'catalog', 'a:74:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838729;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;s:12:\"default_cost\";i:1;s:8:\"old_cost\";s:1:\"0\";s:23:\"hide_unobtainable_goods\";s:1:\"N\";s:14:\"list_page_size\";s:2:\"12\";s:13:\"items_on_page\";N;s:18:\"list_default_order\";s:5:\"sortn\";s:28:\"list_default_order_direction\";s:3:\"asc\";s:23:\"list_order_instok_first\";i:0;s:20:\"list_default_view_as\";s:6:\"blocks\";s:12:\"default_unit\";s:10:\"грамм\";s:15:\"concat_dir_meta\";s:1:\"1\";s:12:\"auto_barcode\";s:6:\"a{n|6}\";s:20:\"disable_search_index\";s:1:\"0\";s:11:\"price_round\";s:4:\"0.01\";s:8:\"cbr_link\";N;s:24:\"cbr_auto_update_interval\";i:1440;s:18:\"cbr_percent_update\";i:0;s:14:\"use_offer_unit\";s:1:\"0\";s:21:\"import_photos_timeout\";s:2:\"20\";s:15:\"use_seo_filters\";s:1:\"0\";s:17:\"show_all_products\";s:1:\"0\";s:17:\"price_like_slider\";s:1:\"0\";s:13:\"search_fields\";a:5:{i:0;s:10:\"properties\";i:1;s:7:\"barcode\";i:2;s:5:\"brand\";i:3;s:17:\"short_description\";i:4;s:13:\"meta_keywords\";}s:23:\"not_public_category_404\";s:1:\"0\";s:22:\"not_public_product_404\";s:1:\"1\";s:27:\"not_public_property_dir_404\";s:1:\"1\";s:29:\"link_property_to_offer_amount\";N;s:17:\"dependent_filters\";s:1:\"0\";s:11:\"clickfields\";N;s:13:\"buyinoneclick\";s:1:\"1\";s:18:\"dont_buy_when_null\";s:1:\"0\";s:22:\"oneclick_name_required\";s:1:\"1\";s:13:\"csv_id_fields\";a:2:{i:0;s:5:\"title\";i:1;s:7:\"barcode\";}s:30:\"csv_offer_product_search_field\";s:5:\"title\";s:22:\"csv_offer_search_field\";s:5:\"sortn\";s:22:\"csv_dont_delete_stocks\";N;s:21:\"csv_dont_delete_costs\";N;s:20:\"csv_file_upload_type\";s:1:\"0\";s:22:\"csv_file_upload_access\";s:6:\"hidden\";s:22:\"brand_products_specdir\";s:1:\"0\";s:18:\"brand_products_cnt\";s:1:\"8\";s:32:\"brand_products_hide_unobtainable\";N;s:16:\"warehouse_sticks\";s:12:\"1,5,15,25,50\";s:24:\"inventory_control_enable\";s:1:\"0\";s:16:\"ic_enable_button\";i:0;s:19:\"provider_user_group\";N;s:16:\"csv_id_fields_ic\";s:7:\"barcode\";s:19:\"yuml_import_setting\";s:1:\"0\";s:18:\"import_yml_timeout\";s:2:\"20\";s:18:\"import_yml_cost_id\";N;s:22:\"catalog_element_action\";N;s:22:\"catalog_section_action\";N;s:19:\"save_product_public\";s:1:\"1\";s:16:\"save_product_dir\";s:1:\"1\";s:18:\"dont_update_fields\";N;s:14:\"use_htmlentity\";i:0;s:13:\"increase_cost\";i:0;s:14:\"use_vendorcode\";s:8:\"offer_id\";s:26:\"default_product_meta_title\";N;s:29:\"default_product_meta_keywords\";N;s:32:\"default_product_meta_description\";N;s:14:\"default_weight\";s:1:\"0\";s:11:\"weight_unit\";s:1:\"g\";s:23:\"property_product_length\";N;s:22:\"default_product_length\";s:1:\"0\";s:22:\"property_product_width\";N;s:21:\"default_product_width\";s:1:\"0\";s:23:\"property_product_height\";N;s:22:\"default_product_height\";s:1:\"0\";s:15:\"dimensions_unit\";s:2:\"sm\";}'),
(1, 'shop', 'a:76:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838737;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;s:14:\"basketminlimit\";s:1:\"0\";s:20:\"basketminweightlimit\";N;s:14:\"check_quantity\";s:1:\"0\";s:28:\"allow_buy_num_less_min_order\";N;s:40:\"allow_buy_all_stock_ignoring_amount_step\";N;s:19:\"check_cost_for_zero\";N;s:18:\"first_order_status\";i:2;s:21:\"user_orders_page_size\";s:2:\"10\";s:11:\"reservation\";s:1:\"0\";s:27:\"reservation_required_fields\";s:11:\"phone_email\";s:28:\"allow_concomitant_count_edit\";s:1:\"0\";s:11:\"source_cost\";N;s:18:\"auto_change_status\";N;s:24:\"auto_change_timeout_days\";N;s:23:\"auto_change_from_status\";N;s:21:\"auto_change_to_status\";N;s:23:\"auto_send_supply_notice\";s:1:\"1\";s:18:\"courier_user_group\";N;s:15:\"ban_courier_del\";s:1:\"0\";s:25:\"remove_nopublic_from_cart\";s:1:\"0\";s:28:\"show_number_of_lines_in_cart\";s:1:\"1\";s:17:\"default_region_id\";s:1:\"0\";s:23:\"use_geolocation_address\";s:1:\"1\";s:32:\"use_selected_address_in_checkout\";s:1:\"1\";s:43:\"regions_marked_when_change_selected_address\";N;s:20:\"use_personal_account\";s:1:\"1\";s:20:\"nds_personal_account\";N;s:31:\"personal_account_payment_method\";s:7:\"advance\";s:32:\"personal_account_payment_subject\";s:7:\"payment\";s:10:\"userfields\";N;s:13:\"checkout_type\";s:9:\"four_step\";s:24:\"checkout_register_option\";s:12:\"user_chooses\";s:22:\"require_choose_address\";i:0;s:29:\"register_user_default_checked\";s:1:\"0\";s:20:\"default_checkout_tab\";s:6:\"person\";s:15:\"default_zipcode\";s:0:\"\";s:15:\"require_country\";s:1:\"1\";s:14:\"require_region\";s:1:\"1\";s:12:\"require_city\";s:1:\"1\";s:15:\"require_zipcode\";s:1:\"0\";s:15:\"require_address\";s:1:\"1\";s:13:\"check_captcha\";s:1:\"1\";s:19:\"show_contact_person\";s:1:\"1\";s:27:\"require_email_in_noregister\";s:1:\"1\";s:27:\"require_phone_in_noregister\";s:1:\"0\";s:26:\"myself_delivery_is_default\";i:0;s:21:\"require_license_agree\";N;s:17:\"license_agreement\";N;s:23:\"use_generated_order_num\";s:1:\"0\";s:23:\"generated_ordernum_mask\";s:3:\"{n}\";s:26:\"generated_ordernum_numbers\";s:1:\"6\";s:13:\"hide_delivery\";s:1:\"0\";s:12:\"hide_payment\";s:1:\"0\";s:13:\"manager_group\";i:0;s:18:\"set_random_manager\";N;s:18:\"cashregister_class\";s:10:\"atolonline\";s:30:\"cashregister_enable_auto_check\";s:1:\"1\";s:3:\"ofd\";s:11:\"platformofd\";s:14:\"payment_method\";s:15:\"full_prepayment\";s:13:\"return_enable\";s:1:\"0\";s:12:\"return_rules\";s:2104:\"\n            <p>Статья 25. Право потребителя на обмен товара надлежащего качества</p>\n            <p>1. Потребитель вправе обменять непродовольственный товар надлежащего качества на аналогичный товар у продавца, у которого этот товар был\n            приобретен, если указанный товар не подошел по форме, габаритам, фасону, расцветке, размеру или комплектации.\n            Потребитель имеет право на обмен непродовольственного товара надлежащего качества в течение четырнадцати дней, не считая дня его покупки.\n            Обмен непродовольственного товара надлежащего качества проводится, если указанный товар не был в употреблении, сохранены его товарный вид,\n            потребительские свойства, пломбы, фабричные ярлыки, а также имеется товарный чек или кассовый чек либо иной подтверждающий оплату указанного\n            товара документ. Отсутствие у потребителя товарного чека или кассового чека либо иного подтверждающего оплату товара документа не лишает его\n            возможности ссылаться на свидетельские показания.</p>\n            <p>Перечень товаров, не подлежащих обмену по основаниям, указанным в настоящей статье, утверждается Правительством Российской Федерации.</p>\n            \n        \";s:21:\"return_print_form_tpl\";s:26:\"%shop%/return/pdf_form.tpl\";s:17:\"discount_code_len\";s:2:\"10\";s:32:\"fixed_discount_max_order_percent\";s:3:\"100\";s:20:\"discount_combination\";s:3:\"max\";s:26:\"old_cost_delta_as_discount\";N;s:22:\"cart_item_max_discount\";s:3:\"100\";s:31:\"check_conformity_uit_to_barcode\";s:1:\"1\";s:28:\"create_receipt_upon_shipment\";N;s:27:\"recurring_show_methods_menu\";s:1:\"0\";s:21:\"cdek_default_delivery\";s:1:\"0\";s:17:\"cdek_webhook_uuid\";N;}'),
(1, 'codegen', 'a:4:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838793;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;}'),
(1, 'kirova', 'a:6:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621838869;s:7:\"enabled\";i:1;s:11:\"deactivated\";N;s:17:\"day_with_discount\";i:5;s:24:\"first_month_discount_day\";i:10;}'),
(0, 'ormeditor', 'a:4:{s:9:\"installed\";b:1;s:10:\"lastupdate\";i:1621841161;s:7:\"enabled\";b:1;s:11:\"deactivated\";N;}');

-- --------------------------------------------------------

--
-- Структура таблицы `kir_module_license`
--

CREATE TABLE IF NOT EXISTS `kir_module_license` (
  `module` varchar(255) NOT NULL COMMENT 'Имя модуля',
  `data` blob COMMENT 'Данные лицензии',
  PRIMARY KEY (`module`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_module_license`
--

INSERT INTO `kir_module_license` (`module`, `data`) VALUES
('designer', 0x3735353830363861343333336133623032663035396233613234353731343830353539323264323832656663343734663335313038353665326261313436346561326236633638333738346663643934326436323537333366376362666139353931653565633633623436376239303237323165363838336534326464316363346634383164663434353665333934396135306630393336656563383261376432616363316164366164366535656462316236643039343862636366346531396361396339636634353963633463386535323262393538633366346239303962323039653236356135306334623331636635656139386337396166316462613261643362663234336665386236393761616366626663306439326531313163376635343537313933383538643734303231633366343666326637623365303938373631613361643261323631373034333839663233363262373031306665316333663130643265343764393731633235386232396162626461393933623562613637666633326262356230633663303937386231363962373465343663323637366562666661303532376437646363336561653738336535306335303731666363643933373139613765356333643630393661326532323731316163636462346630356164653135343635656239383636613934376136316235313762336439),
('#default', 0x6330333530613164353830373436623361363961376365333733393664653933623362663430393361356338383537656135633430346635353662383464656638336133316265386362323738323937383738323430613737623437613363663731393838356565633564383864386539306536633034303138636463646537666361316433393637643238343965393334313562303835343766666538353962643062386537356430313062306334383262303634376631343933643664363533616433336531613938383966646132376438383635386364663330333134636135386131616264363664346135383034376637386161306462623333343563323434346562333232316635646132626431383763326662623836396533353337393861653135346265616438303137376533303861373238306632616233303236363533636439386462373566653035363430393635353337383865353937373235623837333665613333346335643131373735356233613162323465373734373263336237313434336537306433386464643533396461303366633732343537663738373964633939653566613865303266316235626338663736306534333864656261663833623766363130343131323162613761663861666462383031356238326133383038316261363937613464646637626166343137396263),
('#fashion', 0x3366383862376464633634363865393262633035633435626437643566623338636638363065336134383835383632353931383730643464363931316361383034346333393363363237316566373536613763653362376138363931343133313034313461373538656538306232663332343864333061363636303264636133366162336132323231666533303531353463653265343565376338336431336430343836326362343466643730353334666161353538633466373130613339633231323235316536656635363132396162366534363936383161646361333938303535653762373566626264616161633663646539653561633835653337343362333432303166323532363965343565663135393664393037616466353465373633343566626533393534303336393635316661386335333930653336663535303262356364666561386335336138333163323539383063343535666461616230623763643838636264666561386533393230353538363137643432366434376531393261353530303833386532336661386233326533316630643633313333313762393264353863663031383236353261626265356230633661653562353036386336323335663537326462373339303735366330393337636263336433646239306236376565626632393936306234373634366634623962346362353733),
('#flatlines', 0x3762643936626237303664666539616637326261666661303831306631353234326236333831346163653039376230323161653264616564616530303034656362626231323866646662343032633163646635656436633639366139663636613464373330396661363136356361316562373037653534626137316264313166383635646634313837653465356337623334656437343663353564393365643664653065626535343264643135666466343164316533616137353137376339663736356364366231623130343231343536316665303233613631303361353961306661643336353933666363653632373461323961656262326337633337653766363135336232363262326661366631623433666237613930333131326264353661353465386437626537376661623662316231333837363832646332316430333239373136653064636363356163323563656332666232323032666131613763656565356365363932383866366664366437353136363264353938303035343062323037633435313339386131326565643964663839623131316666333936363066333339353761376635393935386263323830303366303766373034376664613232663231303634313136373333613833353537626337303636633238623233653965333434323965653761363632316631643861376134383936643664),
('#kirova18', 0x3163303561366430313166623462303334303937343037653739343565323765333033626662376331656664383835643335313933613864346364623035373262396364303239343666666661653235343434326663633933386166376666643264373335363939323133336265643738363138313139386265343766316262636433316431643262393830393833353530346135373332386661386330646164613335383331616166653336653133636135383132653266386538633162663337646264623062633632393239343632636464306464316365643235663937393833353831336362356562613630643231623532633261303139363063313533396139383235653766616631386235666637336439313539656462626230336335653131643666653166333962386430666563653738653065343035306133616462306338333835363262616364326364356262616261303435343937303230626465323862633039633033393963366564386264643932653363613962643635353066313932666166623966646661646130353731613638363865626463643862656663323362656565636533613265663634316539343735393266643138316661323330303231356262633139626361663065613064313338343534323136396465613339396239656464633261376163316234313536396637353737),
('#perfume', 0x3462393066393066303339636239366638623238326537306261643530666462346161396262656232353635663730303236303865653361346438396337366335386636323664303238613633633336623738383835383463393266393235613737376533356461306664316663323434376164373932333364333733363666376634363364616466623437353737313937646563313565303730363233386135396139653339393935643263653136656239626465356539326666386566363534396564616430393061633362303663303637333935333264326132336461346339616430316438303733363563326133363132633035343935323933366362346664623237396234663430313533396135383335363336333237623838666231303965656665633136343863306433316135376566333266343239363561336337386566646361323365383965376361346163333535666334386539386134343930316233326465376432353566666635323730323933613937323934613762376462333862366138613435346631623531623337316630353439646162646165323566616261616531393761396563626566646330623033303239366534333339626637623638623238303939343662663834653534336161313731333738393637643261633435363434623432613933633436613533613030313961),
('#young', 0x3062643963623766353536646639313462633563323861663732303961363466623434306361326265383566613462356637633266636630373137366364323332626333326262313362316162393430376162373035333139373564376263373461333563663266353737633731343661623537313238303863393938316466303732393435303661336165663236373335633435373732376233373962623330316339623236663463356439373361646131653464303438383636376163393562663238366563643734303262363432386536653136373134333965643139336137373234656538346135616564356562356237343036373664326434346634376637653961653733343235386534643265633963623632323635393566343664326532383265373862336531626564323537636339333130653935313633366165653833336462306134316532633564366338633237653264643838663966376362386434646630353832653064346639326132663866343565616433386339666637623266396637386162363939396237333664376137326163343634353536656638353232376263643738653362323338386134356439306431623862326366656533393530346566366163386665306566383730626366343063653565323638373436363961663263633339373664356435343637623261663937),
('codegen', 0x6138313163343237643031353332393137653235373866613435613632656433656331653133373466623161616263303937633665386664376239633765656138653036633230333065636438313832316131373434306433386636366431656236376435663964313763623039326432343130346139623033613061613265393563656437363335633536633233633862643735643964333166636266333232373032383661643962386531363630366438343063333838363830386238343361356232383062633634306261656565646439663132363864383164393738643866636330313239313766633233613336373938366338303938316364356134356663626132373839396664323166646439613631326261656162393161313861383662613430373862633731386462353765643233346433613366306161616466353232373564383731356462653363333539643035303438636130663534323931303461636131613765613364643565663865386462306634303662383234313933353639383236623734623232353964303337653537306537333139363235393036396437336137623765643565646234393039396133356239633934373734623164306566353632376565633639393133396634363435663939643237303165623166373538613063636363303139623432373433383338366563),
('kirova', 0x3962356334343138653337386362376461373339646237623834333938396131303534643462623637383639623663623637613330383239646364346264326236393761653163363266393530313065383333353732633466363734366130356237656662396136383639313133396135613335393163353061623234383731613666353031343031373663386135396665393466653938643930633735613932613635656639633436636338373266373133623438636535653365613134313832376235653831343732306130653937346665636139643261396339376539633535303134326263326230623937666264363238643933663032323838633963666562393063333130363931383334343535643664336533353265633632636434646261303832313232383439363936313633376334396330383138626364313662323430323436396534336533653535623932666539366633643239623163306639346161623064636532316436326264636339636366353037313164386363386432346162366338303239653838303064326566663838386231616132303965636562626531343866393264383239306239346237666566353561653162343838333561396239313530646366626662383636306333383633303634613236313463326631643765633834363966623638323565353836613261663437),
('ormeditor', 0x3063393034326237326562646362323232393363303533666161376437346361653265393163656637643139323963653034353863666563366462326230346165323638613465326337653935393065383162383665326533333262643435323231623265636236336666323065306634353664613232656134363563373632636632656361383539333835316265613162666432313231396434663139643139636234383137656564646433623662313733353863343836323863393163663039396436303537303834396366323335373633636266626433333938366438303861366338633137626361333735316235636136323831353264316666376535656234666133643665323262343434663266373861613032346231633664633734343739613566366233373133653763356164646164353539666335333165336463366231346565323064616266386534303636353331363832613162373536626365356235646630303932653833303933376237613165363436303233646166313934613537343335653937656464333861663965373765663230343536663336333538306463626234386130623432363033313337363761633438303939306466313365623564663937383764343830346239666531346239376261616436333038393464633361336132353566306232333264666534383364396162);

-- --------------------------------------------------------

--
-- Структура таблицы `kir_notes_note`
--

CREATE TABLE IF NOT EXISTS `kir_notes_note` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `title` varchar(255) DEFAULT NULL COMMENT 'Краткий текст заметки',
  `status` enum('open','inwork','close') DEFAULT 'open' COMMENT 'Статус',
  `message` mediumtext COMMENT 'Сообщение',
  `date_of_create` datetime DEFAULT NULL COMMENT 'Дата создания заметки',
  `date_of_update` datetime DEFAULT NULL COMMENT 'Дата последнего обновления',
  `creator_user_id` bigint(11) DEFAULT NULL COMMENT 'Создатель заметки',
  `is_private` int(11) NOT NULL COMMENT 'Видна только мне',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `creator_user_id` (`creator_user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_notice_config`
--

CREATE TABLE IF NOT EXISTS `kir_notice_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `enable_email` int(1) NOT NULL DEFAULT '1' COMMENT 'Отправка E-mail',
  `enable_sms` int(1) NOT NULL DEFAULT '1' COMMENT 'Отправка SMS',
  `enable_desktop` int(1) NOT NULL DEFAULT '1' COMMENT 'Отправка на ПК',
  `class` varchar(255) DEFAULT NULL COMMENT 'Класс уведомления',
  `template_email` varchar(255) DEFAULT NULL COMMENT 'E-Mail шаблон',
  `template_sms` varchar(255) DEFAULT NULL COMMENT 'SMS шаблон',
  `template_desktop` varchar(255) DEFAULT NULL COMMENT 'ПК шаблон',
  `additional_recipients` varchar(255) DEFAULT NULL COMMENT 'Дополнительные e-mail получателей',
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_id_class` (`site_id`,`class`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_notice_config`
--

INSERT INTO `kir_notice_config` (`id`, `site_id`, `enable_email`, `enable_sms`, `enable_desktop`, `class`, `template_email`, `template_sms`, `template_desktop`, `additional_recipients`) VALUES
(1, 1, 1, 1, 1, '\\Install\\Model\\Notice\\InstallSuccess', NULL, NULL, NULL, NULL),
(2, 1, 1, 1, 1, '\\Users\\Model\\Notice\\UserRegisterUser', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `kir_notice_item`
--

CREATE TABLE IF NOT EXISTS `kir_notice_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `dateofcreate` datetime DEFAULT NULL COMMENT 'Дата создания',
  `title` varchar(255) DEFAULT NULL COMMENT 'Заголовок уведомления',
  `short_message` varchar(400) DEFAULT NULL COMMENT 'Короткий текст уведомления',
  `full_message` mediumtext COMMENT 'Полный текст уведомления',
  `link` varchar(255) DEFAULT NULL COMMENT 'Ссылка',
  `link_title` varchar(255) DEFAULT NULL COMMENT 'Подпись к ссылке',
  `notice_type` varchar(255) DEFAULT NULL COMMENT 'Тип уведомления',
  `destination_user_id` int(11) NOT NULL COMMENT 'Пользователь-адресат уведомления',
  PRIMARY KEY (`id`),
  KEY `destination_user_id_notice_type` (`destination_user_id`,`notice_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_notice_lock`
--

CREATE TABLE IF NOT EXISTS `kir_notice_lock` (
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `user_id` int(11) DEFAULT NULL COMMENT 'Пользователь',
  `notice_type` varchar(100) DEFAULT NULL COMMENT 'Тип Desktop уведомления',
  UNIQUE KEY `site_id_user_id_notice_type` (`site_id`,`user_id`,`notice_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_one_click`
--

CREATE TABLE IF NOT EXISTS `kir_one_click` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `user_id` bigint(11) DEFAULT NULL COMMENT 'Пользователь',
  `user_fio` varchar(255) DEFAULT NULL COMMENT 'Ф.И.О. пользователя',
  `user_phone` varchar(50) DEFAULT NULL COMMENT 'Телефон пользователя',
  `title` varchar(150) DEFAULT NULL COMMENT 'Номер сообщения',
  `dateof` datetime DEFAULT NULL COMMENT 'Дата отправки',
  `status` enum('new','viewed','cancelled') NOT NULL DEFAULT 'new' COMMENT 'Статус',
  `ip` varchar(150) DEFAULT NULL COMMENT 'IP Пользователя',
  `currency` varchar(5) DEFAULT NULL COMMENT 'Трехсимвольный идентификатор валюты на момент покупки',
  `sext_fields` mediumtext COMMENT 'Дополнительными сведения',
  `stext` mediumtext COMMENT 'Cведения о товарах',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_order`
--

CREATE TABLE IF NOT EXISTS `kir_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `order_num` varchar(20) DEFAULT NULL COMMENT 'Уникальный идентификатор номера заказа',
  `user_id` bigint(11) NOT NULL COMMENT 'ID покупателя',
  `currency` varchar(5) DEFAULT NULL COMMENT 'Трехсимвольный идентификатор валюты на момент оформления заказа',
  `currency_ratio` float DEFAULT NULL COMMENT 'Курс относительно базовой валюты',
  `currency_stitle` varchar(10) DEFAULT NULL COMMENT 'Символ валюты',
  `ip` varchar(15) DEFAULT NULL COMMENT 'IP',
  `manager_user_id` int(11) NOT NULL COMMENT 'Менеджер заказа',
  `create_refund_receipt` int(11) DEFAULT NULL COMMENT 'Выбить чек возврата',
  `dateof` datetime DEFAULT NULL COMMENT 'Дата заказа',
  `dateofupdate` datetime DEFAULT NULL COMMENT 'Дата обновления',
  `totalcost` decimal(15,2) NOT NULL COMMENT 'Общая стоимость',
  `profit` decimal(15,2) DEFAULT NULL COMMENT 'Доход',
  `user_delivery_cost` decimal(15,2) DEFAULT NULL COMMENT 'Стоимость доставки, определенная администратором',
  `is_payed` int(1) DEFAULT NULL COMMENT 'Заказ полностью оплачен?',
  `status` int(11) DEFAULT NULL COMMENT 'Статус',
  `admin_comments` mediumtext COMMENT 'Комментарии администратора (не отображаются пользователю)',
  `user_text` mediumtext COMMENT 'Текст для покупателя',
  `_serialized` mediumtext COMMENT 'Дополнительные сведения',
  `userfields` mediumtext COMMENT 'Дополнительные сведения',
  `hash` varchar(32) DEFAULT NULL,
  `is_exported` int(1) DEFAULT '0' COMMENT 'Выгружен ли заказ',
  `delivery_order_id` varchar(255) DEFAULT NULL COMMENT 'Идентификатор заказа доставки',
  `delivery_shipment_id` varchar(255) DEFAULT NULL COMMENT 'Идентификатор партии заказов доставки',
  `track_number` varchar(30) DEFAULT NULL COMMENT 'Трек-номер',
  `saved_payment_method_id` int(11) DEFAULT NULL COMMENT 'Выбранный "сохранённый метод оплаты"',
  `contact_person` varchar(255) DEFAULT NULL COMMENT 'Контактное лицо',
  `use_addr` int(11) DEFAULT NULL COMMENT 'ID адреса доставки',
  `delivery` int(11) DEFAULT NULL COMMENT 'Доставка',
  `courier_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Курьер',
  `warehouse` int(11) DEFAULT NULL COMMENT 'Склад',
  `payment` int(11) DEFAULT NULL COMMENT 'Тип оплаты',
  `comments` mediumtext COMMENT 'Комментарий',
  `substatus` int(11) DEFAULT NULL COMMENT 'Причина отклонения заказа',
  `user_fio` varchar(255) DEFAULT NULL COMMENT 'Ф.И.О.',
  `user_email` varchar(255) DEFAULT NULL COMMENT 'E-mail',
  `user_phone` varchar(100) DEFAULT NULL COMMENT 'Телефон',
  `is_mobile_checkout` int(1) DEFAULT NULL COMMENT 'Оформлен через мобильное приложение?',
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_id_order_num` (`site_id`,`order_num`),
  KEY `manager_user_id` (`manager_user_id`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_order_action_template`
--

CREATE TABLE IF NOT EXISTS `kir_order_action_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `title` varchar(255) DEFAULT NULL COMMENT 'Название действия (коротко)',
  `client_sms_message` mediumtext COMMENT 'Текст SMS сообщения, направляемого клиенту',
  `client_email_message` mediumtext COMMENT 'Текст Email сообщения, направляемого клиенту',
  `public` int(11) DEFAULT NULL COMMENT 'Включен',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_order_address`
--

CREATE TABLE IF NOT EXISTS `kir_order_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `user_id` int(11) DEFAULT '0' COMMENT 'Пользователь',
  `order_id` int(11) DEFAULT '0' COMMENT 'Заказ пользователя',
  `zipcode` varchar(20) DEFAULT NULL COMMENT 'Индекс',
  `country` varchar(100) DEFAULT NULL COMMENT 'Страна',
  `region` varchar(100) DEFAULT NULL COMMENT 'Регион',
  `city` varchar(100) DEFAULT NULL COMMENT 'Город',
  `address` varchar(255) DEFAULT NULL COMMENT 'Адрес',
  `street` varchar(100) DEFAULT NULL COMMENT 'Улица',
  `house` varchar(20) DEFAULT NULL COMMENT 'Дом',
  `block` varchar(20) DEFAULT NULL COMMENT 'Корпус',
  `apartment` varchar(20) DEFAULT NULL COMMENT 'Квартира',
  `entrance` varchar(20) DEFAULT NULL COMMENT 'Подъезд',
  `entryphone` varchar(20) DEFAULT NULL COMMENT 'Домофон',
  `floor` varchar(20) DEFAULT NULL COMMENT 'Этаж',
  `subway` varchar(20) DEFAULT NULL COMMENT 'Станция метро',
  `city_id` int(11) DEFAULT NULL COMMENT 'ID города',
  `region_id` int(11) DEFAULT NULL COMMENT 'ID региона',
  `country_id` int(11) DEFAULT NULL COMMENT 'ID страны',
  `deleted` int(1) DEFAULT '0' COMMENT 'Удалён?',
  `_extra` varchar(1000) DEFAULT NULL COMMENT 'Дополнительные данные (упакованные)',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_order_delivery`
--

CREATE TABLE IF NOT EXISTS `kir_order_delivery` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `title` varchar(255) DEFAULT NULL COMMENT 'Название',
  `admin_suffix` varchar(255) DEFAULT NULL COMMENT 'Пояснение',
  `description` mediumtext COMMENT 'Описание',
  `picture` varchar(255) DEFAULT NULL COMMENT 'Логотип',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Категория',
  `free_price` int(11) NOT NULL DEFAULT '0' COMMENT 'Сумма заказа для бесплатной доставки',
  `first_status` int(11) DEFAULT NULL COMMENT 'Стартовый статус заказа',
  `user_type` enum('all','user','company') NOT NULL COMMENT 'Категория пользователей для данного способа доставки',
  `extrachange_discount` float DEFAULT '0' COMMENT 'Наценка/скидка на доставку',
  `extrachange_discount_type` int(1) DEFAULT '0' COMMENT 'Тип скидки или наценки',
  `extrachange_discount_implementation` float DEFAULT '1' COMMENT 'Наценка/скидка расчитывается от стоимости',
  `public` int(1) DEFAULT '1' COMMENT 'Публичный',
  `default` int(1) DEFAULT '0' COMMENT 'По умолчанию',
  `payment_method` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Признак способа расчета для чека',
  `class` varchar(255) DEFAULT NULL COMMENT 'Расчетный класс (тип доставки)',
  `_serialized` mediumtext COMMENT 'Параметры расчетного класса',
  `sortn` int(11) DEFAULT NULL COMMENT 'Сорт. индекс',
  `min_price` decimal(20,2) DEFAULT NULL COMMENT 'Минимальная сумма заказа',
  `max_price` decimal(20,2) DEFAULT NULL COMMENT 'Максимальная сумма заказа',
  `min_weight` float DEFAULT NULL COMMENT 'Минимальный вес заказа',
  `max_weight` float DEFAULT NULL COMMENT 'Максимальный вес заказа',
  `min_cnt` int(11) NOT NULL DEFAULT '0' COMMENT 'Минимальное количество товаров в заказе',
  `_delivery_periods` mediumtext COMMENT 'Сроки доставки в регионы (Сохранение данных)',
  `_tax_ids` varchar(255) DEFAULT NULL COMMENT 'Налоги (сериализованные)',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_order_delivery_dir`
--

CREATE TABLE IF NOT EXISTS `kir_order_delivery_dir` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `title` varchar(255) DEFAULT NULL COMMENT 'Название',
  `sortn` int(11) DEFAULT NULL COMMENT 'Сорт. номер',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_order_delivery_x_zone`
--

CREATE TABLE IF NOT EXISTS `kir_order_delivery_x_zone` (
  `delivery_id` int(11) DEFAULT NULL COMMENT 'ID Доставки',
  `zone_id` int(11) DEFAULT NULL COMMENT 'ID Зоны',
  UNIQUE KEY `delivery_id_zone_id` (`delivery_id`,`zone_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_order_discount`
--

CREATE TABLE IF NOT EXISTS `kir_order_discount` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `code` varchar(50) DEFAULT NULL COMMENT 'Код',
  `descr` varchar(2000) DEFAULT NULL COMMENT 'Описание скидки',
  `active` int(1) DEFAULT NULL COMMENT 'Включен',
  `sproducts` mediumtext COMMENT 'Список товаров, на которые распространяется скидка',
  `period` enum('timelimit','forever') DEFAULT NULL COMMENT 'Срок действия',
  `endtime` datetime DEFAULT NULL COMMENT 'Время окончания действия скидки',
  `min_order_price` decimal(20,2) DEFAULT NULL COMMENT 'Минимальная сумма заказа',
  `discount` decimal(20,2) DEFAULT NULL COMMENT 'Скидка',
  `discount_type` enum('','%','base') DEFAULT NULL COMMENT 'Скидка указана в процентах или в базовой валюте?',
  `round` int(1) DEFAULT NULL COMMENT 'Округлять скидку до целых чисел?',
  `uselimit` int(5) DEFAULT NULL COMMENT 'Лимит использования, раз',
  `oneuserlimit` int(5) DEFAULT NULL COMMENT 'Лимит использования одним пользователем, раз',
  `wasused` int(5) NOT NULL DEFAULT '0' COMMENT 'Была использована, раз',
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_id_code` (`site_id`,`code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_order_items`
--

CREATE TABLE IF NOT EXISTS `kir_order_items` (
  `uniq` varchar(10) NOT NULL COMMENT 'ID в рамках одной корзины',
  `type` enum('product','coupon','commission','tax','delivery','order_discount','subtotal') DEFAULT NULL COMMENT 'Тип записи товар, услуга, скидочный купон',
  `entity_id` varchar(50) DEFAULT NULL COMMENT 'ID объекта type',
  `offer` int(11) DEFAULT NULL COMMENT 'Комплектация',
  `multioffers` mediumtext COMMENT 'Многомерные комплектации',
  `amount` decimal(11,3) DEFAULT '1.000' COMMENT 'Количество',
  `title` varchar(255) DEFAULT NULL COMMENT 'Название',
  `extra` mediumtext COMMENT 'Дополнительные сведения (сериализованные)',
  `order_id` int(11) NOT NULL COMMENT 'ID заказа',
  `barcode` varchar(100) DEFAULT NULL COMMENT 'Артикул',
  `sku` varchar(50) DEFAULT NULL COMMENT 'Штрихкод',
  `model` varchar(255) DEFAULT NULL COMMENT 'Модель',
  `single_weight` double DEFAULT NULL COMMENT 'Вес',
  `single_cost` decimal(20,2) DEFAULT NULL COMMENT 'Цена за единицу продукции',
  `price` decimal(20,2) DEFAULT '0.00' COMMENT 'Стоимость',
  `profit` decimal(20,2) DEFAULT '0.00' COMMENT 'Доход',
  `discount` decimal(20,2) DEFAULT '0.00' COMMENT 'Скидка',
  `sortn` int(11) DEFAULT NULL COMMENT 'Порядок',
  PRIMARY KEY (`order_id`,`uniq`),
  KEY `type_entity_id` (`type`,`entity_id`),
  KEY `type` (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_order_item_uit`
--

CREATE TABLE IF NOT EXISTS `kir_order_item_uit` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `order_id` int(11) DEFAULT NULL COMMENT 'ID заказа',
  `order_item_uniq` varchar(255) DEFAULT NULL COMMENT 'ID позиции в рамках заказа',
  `gtin` varchar(14) DEFAULT NULL COMMENT 'Глобальный номер предмета торговли (GTIN)',
  `serial` varchar(30) DEFAULT NULL COMMENT 'Серийный номер',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_order_payment`
--

CREATE TABLE IF NOT EXISTS `kir_order_payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `title` varchar(255) DEFAULT NULL COMMENT 'Название',
  `admin_suffix` varchar(255) DEFAULT NULL COMMENT 'Пояснение',
  `description` mediumtext COMMENT 'Описание',
  `picture` varchar(255) DEFAULT NULL COMMENT 'Логотип',
  `first_status` int(11) DEFAULT NULL COMMENT 'Стартовый статус заказа',
  `user_type` enum('all','user','company') NOT NULL COMMENT 'Категория пользователей для данного типа оплаты',
  `target` enum('all','orders','refill') NOT NULL COMMENT 'Область применения',
  `_delivery` varchar(1500) DEFAULT NULL COMMENT 'Связь с доставками',
  `public` int(1) DEFAULT '1' COMMENT 'Публичный',
  `default_payment` int(1) DEFAULT '0' COMMENT 'Оплата по-умолчанию?',
  `commission` float DEFAULT '0' COMMENT 'Комиссия за оплату в %',
  `commission_include_delivery` int(1) DEFAULT '0' COMMENT 'Включать стоимость доставки в комиссию',
  `commission_as_product_discount` int(1) DEFAULT '0' COMMENT 'Присваивать комиссию в качестве скидки или наценки к товарам',
  `class` varchar(255) DEFAULT NULL COMMENT 'Расчетный класс (тип оплаты)',
  `_serialized` mediumtext COMMENT 'Параметры рассчетного класса',
  `sortn` int(11) DEFAULT NULL COMMENT 'Сорт. индекс',
  `min_price` decimal(20,2) DEFAULT NULL COMMENT 'Минимальная сумма заказа',
  `max_price` decimal(20,2) DEFAULT NULL COMMENT 'Максимальная сумма заказа',
  `success_status` int(11) DEFAULT '0' COMMENT 'Статус заказа в случае успешной оплаты',
  `holding_status` int(11) DEFAULT '0' COMMENT 'Статус заказа в случае холдирования',
  `holding_cancel_status` int(11) DEFAULT '0' COMMENT 'Статус заказа в случае отмены холдирования',
  `create_cash_receipt` int(1) DEFAULT '0' COMMENT 'Выбить чек после оплаты?',
  `payment_method` varchar(255) DEFAULT '0' COMMENT 'Признак способа расчета в чеке у заказа с этим способом оплаты',
  `create_order_transaction` int(11) DEFAULT '0' COMMENT 'Создавать транзакцию при создании заказа',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_order_payment_saved_method`
--

CREATE TABLE IF NOT EXISTS `kir_order_payment_saved_method` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `external_id` varchar(255) DEFAULT NULL COMMENT 'Внешний идентификатор способа платежа',
  `type` varchar(255) NOT NULL COMMENT 'Тип способа платежа',
  `subtype` varchar(255) NOT NULL COMMENT 'Подтип способа платежа',
  `title` varchar(255) NOT NULL COMMENT 'Имя способа платежа',
  `user_id` int(11) DEFAULT NULL COMMENT 'id полпользователя',
  `payment_type` varchar(255) DEFAULT NULL COMMENT 'Класс типа оплаты',
  `payment_type_unique` varchar(255) DEFAULT NULL COMMENT 'Идентификатор в рамках класса',
  `save_date` datetime DEFAULT NULL COMMENT 'Дата сохранения',
  `_data` varchar(1000) DEFAULT NULL COMMENT 'Данные способа платежа (сериализованные)',
  `is_default` int(1) NOT NULL DEFAULT '0' COMMENT 'Способ по умолчанию',
  `deleted` int(1) NOT NULL DEFAULT '0' COMMENT 'Удалён',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_order_products_return`
--

CREATE TABLE IF NOT EXISTS `kir_order_products_return` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `return_num` varchar(20) DEFAULT NULL COMMENT 'Номер возврата',
  `order_id` int(20) DEFAULT NULL COMMENT 'Id заказа',
  `user_id` bigint(11) NOT NULL COMMENT 'ID пользователя',
  `status` enum('new','in_progress','complete','refused') NOT NULL COMMENT 'Статус возврата',
  `name` varchar(255) DEFAULT NULL COMMENT 'Имя пользователя',
  `surname` varchar(255) DEFAULT NULL COMMENT 'Фамилия пользователя',
  `midname` varchar(255) DEFAULT NULL COMMENT 'Отчество пользователя',
  `passport_series` varchar(50) DEFAULT NULL COMMENT 'Серия паспорта',
  `passport_number` varchar(50) DEFAULT NULL COMMENT 'Номер паспорта',
  `passport_issued_by` varchar(100) DEFAULT NULL COMMENT 'Кем выдан паспорт',
  `phone` varchar(50) DEFAULT NULL COMMENT 'Номер телефона',
  `dateof` datetime DEFAULT NULL COMMENT 'Дата оформления возврата',
  `date_exec` datetime DEFAULT NULL COMMENT 'Дата выполнения возврата',
  `return_reason` varchar(200) DEFAULT NULL COMMENT 'Причина возврата',
  `bank_name` varchar(100) DEFAULT NULL COMMENT 'Название банка',
  `bik` varchar(50) DEFAULT NULL COMMENT 'БИК',
  `bank_account` varchar(100) DEFAULT NULL COMMENT 'Рассчетный счет',
  `correspondent_account` varchar(100) DEFAULT NULL COMMENT 'Корреспондентский счет',
  `cost_total` decimal(10,0) DEFAULT NULL COMMENT 'Сумма возврата',
  `currency` varchar(20) DEFAULT NULL COMMENT 'Id валюты',
  `currency_ratio` decimal(20,0) DEFAULT NULL COMMENT 'Курс на момент оформления заказа',
  `currency_stitle` varchar(20) DEFAULT NULL COMMENT 'Символ курса валюты',
  PRIMARY KEY (`id`),
  UNIQUE KEY `return_num` (`return_num`),
  KEY `order_id` (`order_id`),
  KEY `dateof` (`dateof`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_order_products_return_item`
--

CREATE TABLE IF NOT EXISTS `kir_order_products_return_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL,
  `uniq` varchar(20) DEFAULT NULL COMMENT 'Уникальный идентификатор',
  `return_id` int(20) DEFAULT NULL COMMENT 'Id возврата',
  `entity_id` int(11) DEFAULT NULL COMMENT 'Id товара',
  `offer` int(11) DEFAULT NULL COMMENT 'Номер комплектации',
  `amount` int(20) DEFAULT NULL COMMENT 'Количество товара',
  `cost` decimal(20,0) DEFAULT NULL COMMENT 'Цена товара',
  `barcode` varchar(255) DEFAULT NULL COMMENT 'Артикул',
  `model` varchar(255) DEFAULT NULL COMMENT 'Модель',
  `title` varchar(255) DEFAULT NULL COMMENT 'Название',
  PRIMARY KEY (`id`),
  KEY `return_id` (`return_id`),
  KEY `entity_id` (`entity_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_order_regions`
--

CREATE TABLE IF NOT EXISTS `kir_order_regions` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `title` varchar(255) DEFAULT NULL COMMENT 'Название',
  `parent_id` int(11) DEFAULT NULL COMMENT 'Родитель',
  `zipcode` varchar(20) DEFAULT NULL COMMENT 'Индекс',
  `is_city` int(1) DEFAULT '0' COMMENT 'Является городом?',
  `area` varchar(255) DEFAULT NULL COMMENT 'Муниципальный район',
  `sortn` int(11) DEFAULT '100' COMMENT 'Порядок',
  `fias_guid` varchar(36) DEFAULT NULL COMMENT 'Идентификатор ФИАС',
  `kladr_id` varchar(255) DEFAULT NULL COMMENT 'ID по КЛАДР',
  `type_short` varchar(30) DEFAULT NULL COMMENT 'Тип субъекта, населенного пункта сокращенно',
  `processed` int(11) DEFAULT NULL COMMENT 'Обновлено только что',
  `russianpost_arriveinfo` varchar(255) DEFAULT NULL COMMENT 'Срок доставки Почтой России (строка)',
  `russianpost_arrive_min` varchar(10) DEFAULT NULL COMMENT 'Минимальное количество дней доставки Почтой России',
  `russianpost_arrive_max` varchar(10) DEFAULT NULL COMMENT 'Максимальное количество дней доставки Почтой России',
  `cdek_city_id` int(11) DEFAULT NULL COMMENT 'ID населенного пункта в СДЭК',
  PRIMARY KEY (`id`),
  KEY `site_id_parent_id_is_city` (`site_id`,`parent_id`,`is_city`),
  KEY `title` (`title`)
) ENGINE=MyISAM AUTO_INCREMENT=1205 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_order_regions`
--

INSERT INTO `kir_order_regions` (`id`, `site_id`, `title`, `parent_id`, `zipcode`, `is_city`, `area`, `sortn`, `fias_guid`, `kladr_id`, `type_short`, `processed`, `russianpost_arriveinfo`, `russianpost_arrive_min`, `russianpost_arrive_max`, `cdek_city_id`) VALUES
(1, 1, 'Россия', 0, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(2, 1, 'Мурманская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(3, 1, 'Мордовия', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(4, 1, 'Чувашия', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(5, 1, 'Оренбургская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(6, 1, 'Свердловская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(7, 1, 'Новгородская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(8, 1, 'Башкортостан', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(9, 1, 'Астраханская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(10, 1, 'Орловская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(11, 1, 'Пермский край', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(12, 1, 'Саха (Якутия)', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(13, 1, 'Северная Осетия', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(14, 1, 'Татарстан', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(15, 1, 'Тверская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(16, 1, 'Тульская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(17, 1, 'Псковская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(18, 1, 'Чечня', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(19, 1, 'Усть-Ордынский Бурятский АО', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(20, 1, 'Смоленская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(21, 1, 'Удмуртия', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(22, 1, 'Иркутская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(23, 1, 'Липецкая область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(24, 1, 'Курская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(25, 1, 'Курганская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(26, 1, 'Самарская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(27, 1, 'Кемеровская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(28, 1, 'Карачаево-Черкессия', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(29, 1, 'Калининградская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(30, 1, 'Красноярский край', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(31, 1, 'Дагестан', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(32, 1, 'Воронежская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(33, 1, 'Московская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(34, 1, 'Москва', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(35, 1, 'Крым', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(36, 1, 'Ярославская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(37, 1, 'Ростовская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(38, 1, 'Нижегородская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(39, 1, 'Ненецкий АО', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(40, 1, 'Омская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(41, 1, 'Новосибирская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(42, 1, 'Белгородская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(43, 1, 'Пензенская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(44, 1, 'Сахалинская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(45, 1, 'Ульяновская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(46, 1, 'Ханты-Мансийский АО', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(47, 1, 'Хакасия', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(48, 1, 'Томская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(49, 1, 'Тыва (Тува)', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(50, 1, 'Челябинская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(51, 1, 'Хабаровский край', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(52, 1, 'Тамбовская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(53, 1, 'Ставропольский край', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(54, 1, 'Тюменская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(55, 1, 'Приморский край', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(56, 1, 'Ингушетия', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(57, 1, 'Ямало-Ненецкий АО', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(58, 1, 'Коми', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(59, 1, 'Магаданская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(60, 1, 'Ленинградская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(61, 1, 'Рязанская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(62, 1, 'Кировская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(63, 1, 'Кабардино-Балкария', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(64, 1, 'Забайкальский край', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(65, 1, 'Карелия', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(66, 1, 'Камчатский край', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(67, 1, 'Калужская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(68, 1, 'Калмыкия', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(69, 1, 'Саратовская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(70, 1, 'Чукотский АО', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(71, 1, 'Ивановская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(72, 1, 'Брянская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(73, 1, 'Адыгея', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(74, 1, 'Алтай', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(75, 1, 'Амурская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(76, 1, 'Архангельская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(77, 1, 'Краснодарский край', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(78, 1, 'Еврейская АО', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(79, 1, 'Алтайский край', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(80, 1, 'Вологодская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(81, 1, 'Волгоградская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(82, 1, 'Владимирская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(83, 1, 'Бурятия', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(84, 1, 'Марий-Эл', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(85, 1, 'Костромская область', 1, '', 0, NULL, 100, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(86, 1, 'Буй', 85, '157000', 1, NULL, 100, NULL, '4400300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(87, 1, 'Волгореченск', 85, '156901', 1, NULL, 100, NULL, '4400000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(88, 1, 'Галич', 85, '', 1, NULL, 100, NULL, '4400500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(89, 1, 'Кологрив', 85, '157440', 1, NULL, 100, NULL, '4400700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(90, 1, 'Кострома', 85, '156000', 1, NULL, 100, NULL, '4400000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(91, 1, 'Макарьев', 85, '157461', 1, NULL, 100, NULL, '4400900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(92, 1, 'Мантурово', 85, '157300', 1, NULL, 100, NULL, '4401000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(93, 1, 'Нерехта', 85, '157800', 1, NULL, 100, NULL, '4401300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(94, 1, 'Нея', 85, '157330', 1, NULL, 100, NULL, '4401200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(95, 1, 'Солигалич', 85, '157170', 1, NULL, 100, NULL, '4402000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(96, 1, 'Чухлома', 85, '157130', 1, NULL, 100, NULL, '4402300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(97, 1, 'Шарья', 85, '157500', 1, NULL, 100, NULL, '4402400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(98, 1, 'Апрелевка', 33, '143362', 1, NULL, 100, NULL, '5002000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(99, 1, 'Балашиха', 33, '143900', 1, NULL, 100, NULL, '5000003600000', NULL, NULL, NULL, NULL, NULL, NULL),
(100, 1, 'Бронницы', 33, '140170', 1, NULL, 100, NULL, '5000000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(101, 1, 'Верея', 33, '143330', 1, NULL, 100, NULL, '5002000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(102, 1, 'Видное', 33, '142700', 1, NULL, 100, NULL, '5001400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(103, 1, 'Волоколамск', 33, '143600', 1, NULL, 100, NULL, '5000300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(104, 1, 'Воскресенск', 33, '140200', 1, NULL, 100, NULL, '5000400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(105, 1, 'Высоковск', 33, '141650', 1, NULL, 100, NULL, '5001100200000', NULL, NULL, NULL, NULL, NULL, NULL),
(106, 1, 'Голицыно', 33, '143040', 1, NULL, 100, NULL, '5002200300000', NULL, NULL, NULL, NULL, NULL, NULL),
(107, 1, 'Дедовск', 33, '143530', 1, NULL, 100, NULL, '5000900200000', NULL, NULL, NULL, NULL, NULL, NULL),
(108, 1, 'Дзержинский', 33, '140090', 1, NULL, 100, NULL, '5000002300000', NULL, NULL, NULL, NULL, NULL, NULL),
(109, 1, 'Дмитров', 33, '141800', 1, NULL, 100, NULL, '5000006100000', NULL, NULL, NULL, NULL, NULL, NULL),
(110, 1, 'Долгопрудный', 33, '141700', 1, NULL, 100, NULL, '5000002900000', NULL, NULL, NULL, NULL, NULL, NULL),
(111, 1, 'Домодедово', 33, '142000', 1, NULL, 100, NULL, '5000000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(112, 1, 'Дрезна', 33, '142660', 1, NULL, 100, NULL, '5002400200000', NULL, NULL, NULL, NULL, NULL, NULL),
(113, 1, 'Дубна', 33, '141980', 1, NULL, 100, NULL, '5000000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(114, 1, 'Егорьевск', 33, '140300', 1, NULL, 100, NULL, '5000003900000', NULL, NULL, NULL, NULL, NULL, NULL),
(115, 1, 'Жуковский', 33, '140180', 1, NULL, 100, NULL, '5000000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(116, 1, 'Зарайск', 33, '140600', 1, NULL, 100, NULL, '5000004600000', NULL, NULL, NULL, NULL, NULL, NULL),
(117, 1, 'Звенигород', 33, '143180', 1, NULL, 100, NULL, '5000000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(118, 1, 'Ивантеевка', 33, '141280', 1, NULL, 100, NULL, '5000000700000', NULL, NULL, NULL, NULL, NULL, NULL),
(119, 1, 'Истра', 33, '143500', 1, NULL, 100, NULL, '5000005700000', NULL, NULL, NULL, NULL, NULL, NULL),
(120, 1, 'Кашира', 33, '142900', 1, NULL, 100, NULL, '5000003800000', NULL, NULL, NULL, NULL, NULL, NULL),
(121, 1, 'Климовск', 33, '142180', 1, NULL, 100, NULL, '5000000800000', NULL, NULL, NULL, NULL, NULL, NULL),
(122, 1, 'Клин', 33, '141600', 1, NULL, 100, NULL, '5000005500000', NULL, NULL, NULL, NULL, NULL, NULL),
(123, 1, 'Коломна', 33, '140400', 1, NULL, 100, NULL, '5000002700000', NULL, NULL, NULL, NULL, NULL, NULL),
(124, 1, 'Королев', 33, '141071', 1, NULL, 100, NULL, '5000000900000', NULL, NULL, NULL, NULL, NULL, NULL),
(125, 1, 'Котельники', 33, '140054', 1, NULL, 100, NULL, '5000003200000', NULL, NULL, NULL, NULL, NULL, NULL),
(126, 1, 'Красноармейск', 33, '141290', 1, NULL, 100, NULL, '5000001000000', NULL, NULL, NULL, NULL, NULL, NULL),
(127, 1, 'Красногорск', 33, '143401', 1, NULL, 100, NULL, '5000004900000', NULL, NULL, NULL, NULL, NULL, NULL),
(128, 1, 'Краснозаводск', 33, '141321', 1, NULL, 100, NULL, '5003000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(129, 1, 'Кубинка', 33, '143070', 1, NULL, 100, NULL, '5002200400000', NULL, NULL, NULL, NULL, NULL, NULL),
(130, 1, 'Куровское', 33, '142620', 1, NULL, 100, NULL, '5002400300000', NULL, NULL, NULL, NULL, NULL, NULL),
(131, 1, 'Ликино-Дулево', 33, '142672', 1, NULL, 100, NULL, '5000005800000', NULL, NULL, NULL, NULL, NULL, NULL),
(132, 1, 'Лобня', 33, '141730', 1, NULL, 100, NULL, '5000001200000', NULL, NULL, NULL, NULL, NULL, NULL),
(133, 1, 'Лосино-Петровский', 33, '141150', 1, NULL, 100, NULL, '5000003100000', NULL, NULL, NULL, NULL, NULL, NULL),
(134, 1, 'Луховицы', 33, '140500', 1, NULL, 100, NULL, '5000004800000', NULL, NULL, NULL, NULL, NULL, NULL),
(135, 1, 'Лыткарино', 33, '140080', 1, NULL, 100, NULL, '5000001300000', NULL, NULL, NULL, NULL, NULL, NULL),
(136, 1, 'Люберцы', 33, '140000', 1, NULL, 100, NULL, '5000005000000', NULL, NULL, NULL, NULL, NULL, NULL),
(137, 1, 'Можайск', 33, '143204', 1, NULL, 100, NULL, '5000005600000', NULL, NULL, NULL, NULL, NULL, NULL),
(138, 1, 'Москва', 33, '101000', 1, NULL, 100, NULL, '7700000000000', NULL, NULL, NULL, NULL, NULL, NULL),
(139, 1, 'Мытищи', 33, '141000', 1, NULL, 100, NULL, '5000004400000', NULL, NULL, NULL, NULL, NULL, NULL),
(140, 1, 'Наро-Фоминск', 33, '143300', 1, NULL, 100, NULL, '5000005200000', NULL, NULL, NULL, NULL, NULL, NULL),
(141, 1, 'Ногинск', 33, '142400', 1, NULL, 100, NULL, '5000006000000', NULL, NULL, NULL, NULL, NULL, NULL),
(142, 1, 'Одинцово', 33, '143000', 1, NULL, 100, NULL, '5002200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(143, 1, 'Озеры', 33, '140560', 1, NULL, 100, NULL, '5000004000000', NULL, NULL, NULL, NULL, NULL, NULL),
(144, 1, 'Орехово-Зуево', 33, '142600', 1, NULL, 100, NULL, '5000002600000', NULL, NULL, NULL, NULL, NULL, NULL),
(145, 1, 'Павловский Посад', 33, '142500', 1, NULL, 100, NULL, '5000004700000', NULL, NULL, NULL, NULL, NULL, NULL),
(146, 1, 'Пересвет', 33, '141320', 1, NULL, 100, NULL, '5003000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(147, 1, 'Подольск', 33, '142100', 1, NULL, 100, NULL, '5000002400000', NULL, NULL, NULL, NULL, NULL, NULL),
(148, 1, 'Протвино', 33, '142280', 1, NULL, 100, NULL, '5000001400000', NULL, NULL, NULL, NULL, NULL, NULL),
(149, 1, 'Пушкино', 33, '141200', 1, NULL, 100, NULL, '5002700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(150, 1, 'Пущино', 33, '142290', 1, NULL, 100, NULL, '5000001500000', NULL, NULL, NULL, NULL, NULL, NULL),
(151, 1, 'Раменское', 33, '140100', 1, NULL, 100, NULL, '5002800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(152, 1, 'Реутов', 33, '143960', 1, NULL, 100, NULL, '5000001600000', NULL, NULL, NULL, NULL, NULL, NULL),
(153, 1, 'Рошаль', 33, '140730', 1, NULL, 100, NULL, '5000001700000', NULL, NULL, NULL, NULL, NULL, NULL),
(154, 1, 'Руза', 33, '143100', 1, NULL, 100, NULL, '5000004500000', NULL, NULL, NULL, NULL, NULL, NULL),
(155, 1, 'Сергиев Посад', 33, '141300', 1, NULL, 100, NULL, '5003000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(156, 1, 'Сергиев Посад-7', 33, '141315', 1, NULL, 100, NULL, '5003000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(157, 1, 'Серпухов', 33, '142200', 1, NULL, 100, NULL, '5000002800000', NULL, NULL, NULL, NULL, NULL, NULL),
(158, 1, 'Солнечногорск', 33, '141501', 1, NULL, 100, NULL, '5003300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(159, 1, 'Солнечногорск-2', 33, '141502', 1, NULL, 100, NULL, '5003300400000', NULL, NULL, NULL, NULL, NULL, NULL),
(160, 1, 'Солнечногорск-25', 33, '141501', 1, NULL, 100, NULL, '5003300400000', NULL, NULL, NULL, NULL, NULL, NULL),
(161, 1, 'Солнечногорск-30', 33, '141504', 1, NULL, 100, NULL, '5003300500000', NULL, NULL, NULL, NULL, NULL, NULL),
(162, 1, 'Солнечногорск-7', 33, '141507', 1, NULL, 100, NULL, '5003300300000', NULL, NULL, NULL, NULL, NULL, NULL),
(163, 1, 'Старая Купавна', 33, '142450', 1, NULL, 100, NULL, '5002100400000', NULL, NULL, NULL, NULL, NULL, NULL),
(164, 1, 'Ступино', 33, '142800', 1, NULL, 100, NULL, '5000005400000', NULL, NULL, NULL, NULL, NULL, NULL),
(165, 1, 'Талдом', 33, '141900', 1, NULL, 100, NULL, '5000005900000', NULL, NULL, NULL, NULL, NULL, NULL),
(166, 1, 'Фрязино', 33, '141190', 1, NULL, 100, NULL, '5000001900000', NULL, NULL, NULL, NULL, NULL, NULL),
(167, 1, 'Химки', 33, '141400', 1, NULL, 100, NULL, '5000003000000', NULL, NULL, NULL, NULL, NULL, NULL),
(168, 1, 'Хотьково', 33, '141372', 1, NULL, 100, NULL, '5003000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(169, 1, 'Черноголовка', 33, '142432', 1, NULL, 100, NULL, '5000003500000', NULL, NULL, NULL, NULL, NULL, NULL),
(170, 1, 'Чехов', 33, '142300', 1, NULL, 100, NULL, '5003700100051', NULL, NULL, NULL, NULL, NULL, NULL),
(171, 1, 'Чехов-2', 33, '142302', 1, NULL, 100, NULL, '5003700200000', NULL, NULL, NULL, NULL, NULL, NULL),
(172, 1, 'Чехов-3', 33, '142303', 1, NULL, 100, NULL, '5003700300000', NULL, NULL, NULL, NULL, NULL, NULL),
(173, 1, 'Чехов-8', 33, '142302', 1, NULL, 100, NULL, '5003700500000', NULL, NULL, NULL, NULL, NULL, NULL),
(174, 1, 'Шатура', 33, '140700', 1, NULL, 100, NULL, '5000005100000', NULL, NULL, NULL, NULL, NULL, NULL),
(175, 1, 'Щелково', 33, '141100', 1, NULL, 100, NULL, '5004000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(176, 1, 'Электрогорск', 33, '142530', 1, NULL, 100, NULL, '5000003300000', NULL, NULL, NULL, NULL, NULL, NULL),
(177, 1, 'Электросталь', 33, '144000', 1, NULL, 100, NULL, '5000002100000', NULL, NULL, NULL, NULL, NULL, NULL),
(178, 1, 'Электроугли', 33, '142455', 1, NULL, 100, NULL, '5002100200000', NULL, NULL, NULL, NULL, NULL, NULL),
(179, 1, 'Яхрома', 33, '141840', 1, NULL, 100, NULL, '5000500200000', NULL, NULL, NULL, NULL, NULL, NULL),
(180, 1, 'Волжск', 84, '425000', 1, NULL, 100, NULL, '1200000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(181, 1, 'Звенигово', 84, '425060', 1, NULL, 100, NULL, '1200400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(182, 1, 'Йошкар-Ола', 84, '424000', 1, NULL, 100, NULL, '1200000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(183, 1, 'Козьмодемьянск', 84, '425350', 1, NULL, 100, NULL, '1200000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(184, 1, 'Бабушкин', 83, '671950', 1, NULL, 100, NULL, '0300900200000', NULL, NULL, NULL, NULL, NULL, NULL),
(185, 1, 'Гусиноозерск', 83, '671160', 1, NULL, 100, NULL, '0301800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(186, 1, 'Закаменск', 83, '671950', 1, NULL, 100, NULL, '0300700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(187, 1, 'Кяхта', 83, '446722', 1, NULL, 100, NULL, '0301200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(188, 1, 'Северобайкальск', 83, '671700', 1, NULL, 100, NULL, '0300000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(189, 1, 'Улан-Удэ', 83, '670000', 1, NULL, 100, NULL, '0300000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(190, 1, 'Александров', 82, '347233', 1, NULL, 100, NULL, '3300200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(191, 1, 'Владимир', 82, '600000', 1, NULL, 100, NULL, '3300000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(192, 1, 'Вязники', 82, '601440', 1, NULL, 100, NULL, '3300300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(193, 1, 'Гороховец', 82, '601480', 1, NULL, 100, NULL, '3300400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(194, 1, 'Гусь-Хрустальный', 82, '601500', 1, NULL, 100, NULL, '3300000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(195, 1, 'Камешково', 82, '601301', 1, NULL, 100, NULL, '3300600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(196, 1, 'Карабаново', 82, '601640', 1, NULL, 100, NULL, '3300200200000', NULL, NULL, NULL, NULL, NULL, NULL),
(197, 1, 'Киржач', 82, '601010', 1, NULL, 100, NULL, '3300700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(198, 1, 'Ковров', 82, '601900', 1, NULL, 100, NULL, '3300000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(199, 1, 'Кольчугино', 82, '297551', 1, NULL, 100, NULL, '3300900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(200, 1, 'Костерево', 82, '601110', 1, NULL, 100, NULL, '3301200200000', NULL, NULL, NULL, NULL, NULL, NULL),
(201, 1, 'Курлово', 82, '601570', 1, NULL, 100, NULL, '3300500200000', NULL, NULL, NULL, NULL, NULL, NULL),
(202, 1, 'Лакинск', 82, '601240', 1, NULL, 100, NULL, '3301400200000', NULL, NULL, NULL, NULL, NULL, NULL),
(203, 1, 'Меленки', 82, '602100', 1, NULL, 100, NULL, '3301000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(204, 1, 'Муром', 82, '309257', 1, NULL, 100, NULL, '3300000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(205, 1, 'Петушки', 82, '601144', 1, NULL, 100, NULL, '3301200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(206, 1, 'Покров', 82, '601120', 1, NULL, 100, NULL, '3301200300000', NULL, NULL, NULL, NULL, NULL, NULL),
(207, 1, 'Радужный', 82, '600910', 1, NULL, 100, NULL, '3300000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(208, 1, 'Собинка', 82, '601204', 1, NULL, 100, NULL, '3301400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(209, 1, 'Струнино', 82, '601670', 1, NULL, 100, NULL, '3300200300000', NULL, NULL, NULL, NULL, NULL, NULL),
(210, 1, 'Судогда', 82, '601351', 1, NULL, 100, NULL, '3301500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(211, 1, 'Суздаль', 82, '601293', 1, NULL, 100, NULL, '3301600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(212, 1, 'Юрьев-Польский', 82, '601800', 1, NULL, 100, NULL, '3301700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(213, 1, 'Волгоград', 81, '400000', 1, NULL, 100, NULL, '3400000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(214, 1, 'Волжский', 81, '404100', 1, NULL, 100, NULL, '3400000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(215, 1, 'Дубовка', 81, '356210', 1, NULL, 100, NULL, '3400600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(216, 1, 'Жирновск', 81, '403790', 1, NULL, 100, NULL, '3400800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(217, 1, 'Калач-на-Дону', 81, '404500', 1, NULL, 100, NULL, '3401000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(218, 1, 'Камышин', 81, '403870', 1, NULL, 100, NULL, '3400000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(219, 1, 'Котельниково', 81, '404350', 1, NULL, 100, NULL, '3401400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(220, 1, 'Котово', 81, '403805', 1, NULL, 100, NULL, '3401500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(221, 1, 'Краснослободск', 81, '404160', 1, NULL, 100, NULL, '3402800200000', NULL, NULL, NULL, NULL, NULL, NULL),
(222, 1, 'Ленинск', 81, '404620', 1, NULL, 100, NULL, '3401700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(223, 1, 'Михайловка', 81, '161306', 1, NULL, 100, NULL, '3400000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(224, 1, 'Николаевск', 81, '404030', 1, NULL, 100, NULL, '3402000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(225, 1, 'Новоаннинский', 81, '403950', 1, NULL, 100, NULL, '3402100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(226, 1, 'Палласовка', 81, '404260', 1, NULL, 100, NULL, '3402400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(227, 1, 'Петров Вал', 81, '403840', 1, NULL, 100, NULL, '3401100200000', NULL, NULL, NULL, NULL, NULL, NULL),
(228, 1, 'Серафимович', 81, '403440', 1, NULL, 100, NULL, '3402700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(229, 1, 'Суровикино', 81, '404415', 1, NULL, 100, NULL, '3403000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(230, 1, 'Урюпинск', 81, '403110', 1, NULL, 100, NULL, '3400000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(231, 1, 'Фролово', 81, '403531', 1, NULL, 100, NULL, '3400000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(232, 1, 'Бабаево', 80, '162483', 1, NULL, 100, NULL, '3500200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(233, 1, 'Белозерск', 80, '161201', 1, NULL, 100, NULL, '3500400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(234, 1, 'Великий Устюг', 80, '162390', 1, NULL, 100, NULL, '3500600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(235, 1, 'Вологда', 80, '160000', 1, NULL, 100, NULL, '3500000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(236, 1, 'Вытегра', 80, '162900', 1, NULL, 100, NULL, '3500900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(237, 1, 'Грязовец', 80, '162000', 1, NULL, 100, NULL, '3501000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(238, 1, 'Кадников', 80, '162107', 1, NULL, 100, NULL, '3501700200000', NULL, NULL, NULL, NULL, NULL, NULL),
(239, 1, 'Кириллов', 80, '161101', 1, NULL, 100, NULL, '3501200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(240, 1, 'Красавино', 80, '161390', 1, NULL, 100, NULL, '3500600200000', NULL, NULL, NULL, NULL, NULL, NULL),
(241, 1, 'Никольск', 80, '161440', 1, NULL, 100, NULL, '3501500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(242, 1, 'Сокол', 80, '162130', 1, NULL, 100, NULL, '3501700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(243, 1, 'Тотьма', 80, '161300', 1, NULL, 100, NULL, '3502000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(244, 1, 'Устюжна', 80, '162840', 1, NULL, 100, NULL, '3502200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(245, 1, 'Харовск', 80, '162250', 1, NULL, 100, NULL, '3502300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(246, 1, 'Череповец', 80, '162600', 1, NULL, 100, NULL, '3500000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(247, 1, 'Бобров', 32, '397700', 1, NULL, 100, NULL, '3600300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(248, 1, 'Богучар', 32, '396790', 1, NULL, 100, NULL, '3600400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(249, 1, 'Борисоглебск', 32, '397160', 1, NULL, 100, NULL, '3600500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(250, 1, 'Бутурлиновка', 32, '397500', 1, NULL, 100, NULL, '3600600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(251, 1, 'Воронеж', 32, '394000', 1, NULL, 100, NULL, '3600000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(252, 1, 'Калач', 32, '397600', 1, NULL, 100, NULL, '3601100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(253, 1, 'Лиски', 32, '397900', 1, NULL, 100, NULL, '3601500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(254, 1, 'Нововоронеж', 32, '396070', 1, NULL, 100, NULL, '3600000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(255, 1, 'Новохоперск', 32, '397400', 1, NULL, 100, NULL, '3601800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(256, 1, 'Острогожск', 32, '397850', 1, NULL, 100, NULL, '3602000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(257, 1, 'Павловск', 32, '196620', 1, NULL, 100, NULL, '3602100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(258, 1, 'Поворино', 32, '397350', 1, NULL, 100, NULL, '3602400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(259, 1, 'Россошь', 32, '346073', 1, NULL, 100, NULL, '3602800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(260, 1, 'Семилуки', 32, '396900', 1, NULL, 100, NULL, '3602900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(261, 1, 'Эртиль', 32, '397030', 1, NULL, 100, NULL, '3603300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(262, 1, 'Алейск', 79, '658130', 1, NULL, 100, NULL, '2200000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(263, 1, 'Барнаул', 79, '656000', 1, NULL, 100, NULL, '2200000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(264, 1, 'Белокуриха', 79, '659900', 1, NULL, 100, NULL, '2200000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(265, 1, 'Бийск', 79, '659300', 1, NULL, 100, NULL, '2200000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(266, 1, 'Горняк', 79, '658423', 1, NULL, 100, NULL, '2202700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(267, 1, 'Заринск', 79, '659100', 1, NULL, 100, NULL, '2200001100000', NULL, NULL, NULL, NULL, NULL, NULL),
(268, 1, 'Змеиногорск', 79, '658480', 1, NULL, 100, NULL, '2201500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(269, 1, 'Камень-на-Оби', 79, '658700', 1, NULL, 100, NULL, '2201800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(270, 1, 'Новоалтайск', 79, '658091', 1, NULL, 100, NULL, '2200000800000', NULL, NULL, NULL, NULL, NULL, NULL),
(271, 1, 'Рубцовск', 79, '658200', 1, NULL, 100, NULL, '2200000900000', NULL, NULL, NULL, NULL, NULL, NULL),
(272, 1, 'Славгород', 79, '658820', 1, NULL, 100, NULL, '2200001000000', NULL, NULL, NULL, NULL, NULL, NULL),
(273, 1, 'Яровое', 79, '627227', 1, NULL, 100, NULL, '2200001200000', NULL, NULL, NULL, NULL, NULL, NULL),
(274, 1, 'Буйнакск', 31, '368220', 1, NULL, 100, NULL, '0500001000000', NULL, NULL, NULL, NULL, NULL, NULL),
(275, 1, 'Дагестанские Огни', 31, '368670', 1, NULL, 100, NULL, '0500000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(276, 1, 'Дербент', 31, '368607', 1, NULL, 100, NULL, '0500000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(277, 1, 'Избербаш', 31, '368500', 1, NULL, 100, NULL, '0500000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(278, 1, 'Каспийск', 31, '368300', 1, NULL, 100, NULL, '0500000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(279, 1, 'Кизилюрт', 31, '368120', 1, NULL, 100, NULL, '0500000700000', NULL, NULL, NULL, NULL, NULL, NULL),
(280, 1, 'Кизляр', 31, '363709', 1, NULL, 100, NULL, '0500000800000', NULL, NULL, NULL, NULL, NULL, NULL),
(281, 1, 'Махачкала', 31, '367000', 1, NULL, 100, NULL, '0500000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(282, 1, 'Хасавюрт', 31, '368000', 1, NULL, 100, NULL, '0500000900000', NULL, NULL, NULL, NULL, NULL, NULL),
(283, 1, 'Южно-Сухокумск', 31, '368890', 1, NULL, 100, NULL, '0500000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(284, 1, 'Биробиджан', 78, '679000', 1, NULL, 100, NULL, '7900000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(285, 1, 'Облучье', 78, '679100', 1, NULL, 100, NULL, '7900300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(286, 1, 'Абинск', 77, '353320', 1, NULL, 100, NULL, '2300200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(287, 1, 'Анапа', 77, '353457', 1, NULL, 100, NULL, '2300300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(288, 1, 'Апшеронск', 77, '352690', 1, NULL, 100, NULL, '2300400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(289, 1, 'Армавир', 77, '352900', 1, NULL, 100, NULL, '2300000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(290, 1, 'Белореченск', 77, '352635', 1, NULL, 100, NULL, '2300600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(291, 1, 'Геленджик', 77, '353460', 1, NULL, 100, NULL, '2300000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(292, 1, 'Горячий Ключ', 77, '353290', 1, NULL, 100, NULL, '2300000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(293, 1, 'Гулькевичи', 77, '352190', 1, NULL, 100, NULL, '2300900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(294, 1, 'Ейск', 77, '353680', 1, NULL, 100, NULL, '2301100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(295, 1, 'Кореновск', 77, '353182', 1, NULL, 100, NULL, '2301500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(296, 1, 'Краснодар', 77, '350000', 1, NULL, 100, NULL, '2300000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(297, 1, 'Кропоткин', 77, '352380', 1, NULL, 100, NULL, '2301200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(298, 1, 'Крымск', 77, '353389', 1, NULL, 100, NULL, '2301800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(299, 1, 'Курганинск', 77, '352430', 1, NULL, 100, NULL, '2301900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(300, 1, 'Лабинск', 77, '352500', 1, NULL, 100, NULL, '2302100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(301, 1, 'Новокубанск', 77, '352240', 1, NULL, 100, NULL, '2302400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(302, 1, 'Новороссийск', 77, '353900', 1, NULL, 100, NULL, '2300000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(303, 1, 'Приморско-Ахтарск', 77, '353861', 1, NULL, 100, NULL, '2302800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(304, 1, 'Славянск-на-Кубани', 77, '353560', 1, NULL, 100, NULL, '2303000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(305, 1, 'Сочи', 77, '354000', 1, NULL, 100, NULL, '2300000700000', NULL, NULL, NULL, NULL, NULL, NULL),
(306, 1, 'Темрюк', 77, '353500', 1, NULL, 100, NULL, '2303300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(307, 1, 'Тимашевск', 77, '352700', 1, NULL, 100, NULL, '2303400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(308, 1, 'Тихорецк', 77, '352120', 1, NULL, 100, NULL, '2303500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(309, 1, 'Туапсе', 77, '352800', 1, NULL, 100, NULL, '2303600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(310, 1, 'Усть-Лабинск', 77, '352330', 1, NULL, 100, NULL, '2303800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(311, 1, 'Хадыженск', 77, '352681', 1, NULL, 100, NULL, '2300400200000', NULL, NULL, NULL, NULL, NULL, NULL),
(312, 1, 'Артемовск', 30, '662951', 1, NULL, 100, NULL, '2402400200000', NULL, NULL, NULL, NULL, NULL, NULL),
(313, 1, 'Ачинск', 30, '662150', 1, NULL, 100, NULL, '2400001200000', NULL, NULL, NULL, NULL, NULL, NULL),
(314, 1, 'Боготол', 30, '662060', 1, NULL, 100, NULL, '2400001300000', NULL, NULL, NULL, NULL, NULL, NULL),
(315, 1, 'Бородино', 30, '663980', 1, NULL, 100, NULL, '2400000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(316, 1, 'Дивногорск', 30, '663090', 1, NULL, 100, NULL, '2400000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(317, 1, 'Дудинка', 30, '647000', 1, NULL, 100, NULL, '2404800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(318, 1, 'Енисейск', 30, '663180', 1, NULL, 100, NULL, '2400001400000', NULL, NULL, NULL, NULL, NULL, NULL),
(319, 1, 'Железногорск', 30, '307170', 1, NULL, 100, NULL, '2400000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(320, 1, 'Заозерный', 30, '663960', 1, NULL, 100, NULL, '2403301500000', NULL, NULL, NULL, NULL, NULL, NULL),
(321, 1, 'Зеленогорск', 30, '663694', 1, NULL, 100, NULL, '2400000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(322, 1, 'Игарка', 30, '663200', 1, NULL, 100, NULL, '2403801700000', NULL, NULL, NULL, NULL, NULL, NULL),
(323, 1, 'Иланский', 30, '663800', 1, NULL, 100, NULL, '2401600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(324, 1, 'Канск', 30, '663600', 1, NULL, 100, NULL, '2400001600000', NULL, NULL, NULL, NULL, NULL, NULL),
(325, 1, 'Кодинск', 30, '663491', 1, NULL, 100, NULL, '2402100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(326, 1, 'Красноярск', 30, '660000', 1, NULL, 100, NULL, '2400000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(327, 1, 'Лесосибирск', 30, '662540', 1, NULL, 100, NULL, '2400000800000', NULL, NULL, NULL, NULL, NULL, NULL),
(328, 1, 'Минусинск', 30, '662600', 1, NULL, 100, NULL, '2400001700000', NULL, NULL, NULL, NULL, NULL, NULL),
(329, 1, 'Назарово', 30, '662206', 1, NULL, 100, NULL, '2400001800000', NULL, NULL, NULL, NULL, NULL, NULL),
(330, 1, 'Норильск', 30, '663300', 1, NULL, 100, NULL, '2400000900000', NULL, NULL, NULL, NULL, NULL, NULL),
(331, 1, 'Сосновоборск', 30, '442570', 1, NULL, 100, NULL, '2400001000000', NULL, NULL, NULL, NULL, NULL, NULL),
(332, 1, 'Ужур', 30, '662250', 1, NULL, 100, NULL, '2404000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(333, 1, 'Уяр', 30, '663920', 1, NULL, 100, NULL, '2404100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(334, 1, 'Шарыпово', 30, '662310', 1, NULL, 100, NULL, '2400001900000', NULL, NULL, NULL, NULL, NULL, NULL),
(335, 1, 'Архангельск', 76, '163000', 1, NULL, 100, NULL, '2900000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(336, 1, 'Вельск', 76, '165151', 1, NULL, 100, NULL, '2900200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(337, 1, 'Каргополь', 76, '164110', 1, NULL, 100, NULL, '2900600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(338, 1, 'Коряжма', 76, '165650', 1, NULL, 100, NULL, '2900000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(339, 1, 'Котлас', 76, '165300', 1, NULL, 100, NULL, '2900800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(340, 1, 'Мезень', 76, '164750', 1, NULL, 100, NULL, '2901200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(341, 1, 'Мирный', 76, '162236', 1, NULL, 100, NULL, '2900000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(342, 1, 'Новодвинск', 76, '164900', 1, NULL, 100, NULL, '2900000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(343, 1, 'Няндома', 76, '164200', 1, NULL, 100, NULL, '2901300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(344, 1, 'Онега', 76, '164844', 1, NULL, 100, NULL, '2901400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(345, 1, 'Северодвинск', 76, '164500', 1, NULL, 100, NULL, '2900000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(346, 1, 'Сольвычегодск', 76, '165330', 1, NULL, 100, NULL, '2900800300000', NULL, NULL, NULL, NULL, NULL, NULL),
(347, 1, 'Шенкурск', 76, '165160', 1, NULL, 100, NULL, '2901900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(348, 1, 'Белогорск', 75, '676853', 1, NULL, 100, NULL, '2800000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(349, 1, 'Благовещенск', 75, '675000', 1, NULL, 100, NULL, '2800000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(350, 1, 'Завитинск', 75, '676471', 1, NULL, 100, NULL, '2800500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(351, 1, 'Зея', 75, '675824', 1, NULL, 100, NULL, '2800000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(352, 1, 'Райчихинск', 75, '676770', 1, NULL, 100, NULL, '2800000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(353, 1, 'Свободный', 75, '346958', 1, NULL, 100, NULL, '2800000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(354, 1, 'Сковородино', 75, '676010', 1, NULL, 100, NULL, '2801700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(355, 1, 'Тында', 75, '675828', 1, NULL, 100, NULL, '2800000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(356, 1, 'Циолковский', 75, '676470', 1, NULL, 100, NULL, '2800001000000', NULL, NULL, NULL, NULL, NULL, NULL),
(357, 1, 'Шимановск', 75, '676301', 1, NULL, 100, NULL, '2800000700000', NULL, NULL, NULL, NULL, NULL, NULL),
(358, 1, 'Горно-Алтайск', 74, '649000', 1, NULL, 100, NULL, '0400000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(359, 1, 'Адыгейск', 73, '385200', 1, NULL, 100, NULL, '0100000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(360, 1, 'Майкоп', 73, '385000', 1, NULL, 100, NULL, '0100000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(361, 1, 'Брянск', 72, '241000', 1, NULL, 100, NULL, '3200000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(362, 1, 'Дятьково', 72, '242600', 1, NULL, 100, NULL, '3200600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(363, 1, 'Жуковка', 72, '242700', 1, NULL, 100, NULL, '3200800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(364, 1, 'Злынка', 72, '243600', 1, NULL, 100, NULL, '3200900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(365, 1, 'Карачев', 72, '242500', 1, NULL, 100, NULL, '3201000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(366, 1, 'Клинцы', 72, '243140', 1, NULL, 100, NULL, '3200000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(367, 1, 'Мглин', 72, '243220', 1, NULL, 100, NULL, '3201600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(368, 1, 'Новозыбков', 72, '243020', 1, NULL, 100, NULL, '3200000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(369, 1, 'Почеп', 72, '243400', 1, NULL, 100, NULL, '3202000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(370, 1, 'Севск', 72, '242440', 1, NULL, 100, NULL, '3202200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(371, 1, 'Сельцо', 72, '187052', 1, NULL, 100, NULL, '3200000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(372, 1, 'Стародуб', 72, '243240', 1, NULL, 100, NULL, '3200000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(373, 1, 'Сураж', 72, '243500', 1, NULL, 100, NULL, '3202500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(374, 1, 'Трубчевск', 72, '242220', 1, NULL, 100, NULL, '3202600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(375, 1, 'Унеча', 72, '243300', 1, NULL, 100, NULL, '3202700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(376, 1, 'Фокино', 72, '242610', 1, NULL, 100, NULL, '3200000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(377, 1, 'Вичуга', 71, '155331', 1, NULL, 100, NULL, '3700300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(378, 1, 'Гаврилов Посад', 71, '155000', 1, NULL, 100, NULL, '3700400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(379, 1, 'Заволжск', 71, '155410', 1, NULL, 100, NULL, '3700500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(380, 1, 'Иваново', 71, '153023', 1, NULL, 100, NULL, '3700000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(381, 1, 'Кинешма', 71, '155800', 1, NULL, 100, NULL, '3700000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(382, 1, 'Комсомольск', 71, '155150', 1, NULL, 100, NULL, '3700800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(383, 1, 'Кохма', 71, '153510', 1, NULL, 100, NULL, '3700100200000', NULL, NULL, NULL, NULL, NULL, NULL),
(384, 1, 'Наволоки', 71, '155830', 1, NULL, 100, NULL, '3700700200000', NULL, NULL, NULL, NULL, NULL, NULL),
(385, 1, 'Плес', 71, '155555', 1, NULL, 100, NULL, '3701300200000', NULL, NULL, NULL, NULL, NULL, NULL),
(386, 1, 'Приволжск', 71, '155550', 1, NULL, 100, NULL, '3701300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(387, 1, 'Пучеж', 71, '155360', 1, NULL, 100, NULL, '3701400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(388, 1, 'Родники', 71, '140143', 1, NULL, 100, NULL, '3701500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(389, 1, 'Тейково', 71, '155040', 1, NULL, 100, NULL, '3701700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(390, 1, 'Фурманов', 71, '155520', 1, NULL, 100, NULL, '3701800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(391, 1, 'Шуя', 71, '155900', 1, NULL, 100, NULL, '3701900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(392, 1, 'Южа', 71, '155630', 1, NULL, 100, NULL, '3702000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(393, 1, 'Юрьевец', 71, '155450', 1, NULL, 100, NULL, '3702100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(394, 1, 'Анадырь', 70, '689000', 1, NULL, 100, NULL, '8700000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(395, 1, 'Билибино', 70, '689450', 1, NULL, 100, NULL, '8700300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(396, 1, 'Певек', 70, '689400', 1, NULL, 100, NULL, '8700600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(397, 1, 'Аркадак', 69, '412210', 1, NULL, 100, NULL, '6400300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(398, 1, 'Аткарск', 69, '412420', 1, NULL, 100, NULL, '6400000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(399, 1, 'Балаково', 69, '413853', 1, NULL, 100, NULL, '6400000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(400, 1, 'Балашов', 69, '412315', 1, NULL, 100, NULL, '6400000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(401, 1, 'Вольск', 69, '412900', 1, NULL, 100, NULL, '6400000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(402, 1, 'Вольск-18', 69, '412918', 1, NULL, 100, NULL, '6400000602500', NULL, NULL, NULL, NULL, NULL, NULL),
(403, 1, 'Ершов', 69, '413500', 1, NULL, 100, NULL, '6401400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(404, 1, 'Калининск', 69, '412481', 1, NULL, 100, NULL, '6401600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(405, 1, 'Красный Кут', 69, '413235', 1, NULL, 100, NULL, '6401800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(406, 1, 'Маркс', 69, '413089', 1, NULL, 100, NULL, '6400000800000', NULL, NULL, NULL, NULL, NULL, NULL),
(407, 1, 'Новоузенск', 69, '413360', 1, NULL, 100, NULL, '6402300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(408, 1, 'Петровск', 69, '412540', 1, NULL, 100, NULL, '6400000900000', NULL, NULL, NULL, NULL, NULL, NULL),
(409, 1, 'Пугачев', 69, '413720', 1, NULL, 100, NULL, '6400001000000', NULL, NULL, NULL, NULL, NULL, NULL),
(410, 1, 'Ртищево', 69, '303719', 1, NULL, 100, NULL, '6400001100000', NULL, NULL, NULL, NULL, NULL, NULL),
(411, 1, 'Саратов', 69, '410000', 1, NULL, 100, NULL, '6400000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(412, 1, 'Хвалынск', 69, '412780', 1, NULL, 100, NULL, '6400001200000', NULL, NULL, NULL, NULL, NULL, NULL),
(413, 1, 'Шиханы', 69, '412950', 1, NULL, 100, NULL, '6400000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(414, 1, 'Энгельс', 69, '413100', 1, NULL, 100, NULL, '6400001300000', NULL, NULL, NULL, NULL, NULL, NULL),
(415, 1, 'Багратионовск', 29, '238420', 1, NULL, 100, NULL, '3900200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(416, 1, 'Балтийск', 29, '238520', 1, NULL, 100, NULL, '3901500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(417, 1, 'Гвардейск', 29, '238210', 1, NULL, 100, NULL, '3900300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(418, 1, 'Гурьевск', 29, '238300', 1, NULL, 100, NULL, '3900400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(419, 1, 'Гусев', 29, '238050', 1, NULL, 100, NULL, '3900500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(420, 1, 'Зеленоградск', 29, '238326', 1, NULL, 100, NULL, '3900600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(421, 1, 'Калининград', 29, '236001', 1, NULL, 100, NULL, '3900000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(422, 1, 'Краснознаменск', 29, '143090', 1, NULL, 100, NULL, '3900700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(423, 1, 'Ладушкин', 29, '238460', 1, NULL, 100, NULL, '3900000800000', NULL, NULL, NULL, NULL, NULL, NULL),
(424, 1, 'Мамоново', 29, '238450', 1, NULL, 100, NULL, '3900000900000', NULL, NULL, NULL, NULL, NULL, NULL),
(425, 1, 'Неман', 29, '238710', 1, NULL, 100, NULL, '3900800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(426, 1, 'Нестеров', 29, '238010', 1, NULL, 100, NULL, '3900900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(427, 1, 'Озерск', 29, '238120', 1, NULL, 100, NULL, '3901000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(428, 1, 'Пионерский', 29, '161061', 1, NULL, 100, NULL, '3900000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(429, 1, 'Полесск', 29, '238630', 1, NULL, 100, NULL, '3901100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(430, 1, 'Правдинск', 29, '238400', 1, NULL, 100, NULL, '3901200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(431, 1, 'Приморск', 29, '188910', 1, NULL, 100, NULL, '3901500200000', NULL, NULL, NULL, NULL, NULL, NULL),
(432, 1, 'Светлогорск', 29, '238560', 1, NULL, 100, NULL, '3901600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(433, 1, 'Светлый', 29, '164557', 1, NULL, 100, NULL, '3900000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(434, 1, 'Славск', 29, '238600', 1, NULL, 100, NULL, '3901300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(435, 1, 'Советск', 29, '236876', 1, NULL, 100, NULL, '3900000700000', NULL, NULL, NULL, NULL, NULL, NULL),
(436, 1, 'Черняховск', 29, '236816', 1, NULL, 100, NULL, '3901400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(437, 1, 'Городовиковск', 68, '359050', 1, NULL, 100, NULL, '0800200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(438, 1, 'Лагань', 68, '359220', 1, NULL, 100, NULL, '0800600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(439, 1, 'Элиста', 68, '358000', 1, NULL, 100, NULL, '0800000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(440, 1, 'Балабаново', 67, '249000', 1, NULL, 100, NULL, '4000400200000', NULL, NULL, NULL, NULL, NULL, NULL),
(441, 1, 'Белоусово', 67, '162930', 1, NULL, 100, NULL, '4000900200000', NULL, NULL, NULL, NULL, NULL, NULL),
(442, 1, 'Боровск', 67, '249010', 1, NULL, 100, NULL, '4000400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(443, 1, 'Ермолино', 67, '141923', 1, NULL, 100, NULL, '4000400400000', NULL, NULL, NULL, NULL, NULL, NULL),
(444, 1, 'Жиздра', 67, '249340', 1, NULL, 100, NULL, '4000800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(445, 1, 'Жуков', 67, '249190', 1, NULL, 100, NULL, '4000900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(446, 1, 'Калуга', 67, '248000', 1, NULL, 100, NULL, '4000000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(447, 1, 'Киров', 67, '249440', 1, NULL, 100, NULL, '4001100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(448, 1, 'Козельск', 67, '249141', 1, NULL, 100, NULL, '4001200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(449, 1, 'Кондрово', 67, '249830', 1, NULL, 100, NULL, '4000600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(450, 1, 'Кременки', 67, '249185', 1, NULL, 100, NULL, '4000900400000', NULL, NULL, NULL, NULL, NULL, NULL),
(451, 1, 'Людиново', 67, '249342', 1, NULL, 100, NULL, '4001400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(452, 1, 'Малоярославец', 67, '249091', 1, NULL, 100, NULL, '4001500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(453, 1, 'Медынь', 67, '249950', 1, NULL, 100, NULL, '4001600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(454, 1, 'Мещовск', 67, '249240', 1, NULL, 100, NULL, '4001700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(455, 1, 'Мосальск', 67, '249930', 1, NULL, 100, NULL, '4001800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(456, 1, 'Обнинск', 67, '249030', 1, NULL, 100, NULL, '4000000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(457, 1, 'Сосенский', 67, '249710', 1, NULL, 100, NULL, '4001200200000', NULL, NULL, NULL, NULL, NULL, NULL),
(458, 1, 'Спас-Деменск', 67, '249610', 1, NULL, 100, NULL, '4000500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(459, 1, 'Сухиничи', 67, '249270', 1, NULL, 100, NULL, '4002000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(460, 1, 'Таруса', 67, '249100', 1, NULL, 100, NULL, '4002100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(461, 1, 'Юхнов', 67, '249910', 1, NULL, 100, NULL, '4002500200000', NULL, NULL, NULL, NULL, NULL, NULL),
(462, 1, 'Вилючинск', 66, '684090', 1, NULL, 100, NULL, '4100000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(463, 1, 'Елизово', 66, '684000', 1, NULL, 100, NULL, '4100500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(464, 1, 'Петропавловск-Камчатский', 66, '683000', 1, NULL, 100, NULL, '4100000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(465, 1, 'Карачаевск', 28, '369200', 1, NULL, 100, NULL, '0900000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(466, 1, 'Теберда', 28, '369210', 1, NULL, 100, NULL, '0900000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(467, 1, 'Усть-Джегута', 28, '369300', 1, NULL, 100, NULL, '0900800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(468, 1, 'Черкесск', 28, '369000', 1, NULL, 100, NULL, '0900000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(469, 1, 'Беломорск', 65, '186500', 1, NULL, 100, NULL, '1000200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(470, 1, 'Кемь', 65, '186610', 1, NULL, 100, NULL, '1000400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(471, 1, 'Кондопога', 65, '186215', 1, NULL, 100, NULL, '1000500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(472, 1, 'Костомукша', 65, '186930', 1, NULL, 100, NULL, '1000000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(473, 1, 'Лахденпохья', 65, '186730', 1, NULL, 100, NULL, '1000600100000', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `kir_order_regions` (`id`, `site_id`, `title`, `parent_id`, `zipcode`, `is_city`, `area`, `sortn`, `fias_guid`, `kladr_id`, `type_short`, `processed`, `russianpost_arriveinfo`, `russianpost_arrive_min`, `russianpost_arrive_max`, `cdek_city_id`) VALUES
(474, 1, 'Медвежьегорск', 65, '186302', 1, NULL, 100, NULL, '1000800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(475, 1, 'Олонец', 65, '186000', 1, NULL, 100, NULL, '1001000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(476, 1, 'Петрозаводск', 65, '185000', 1, NULL, 100, NULL, '1000000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(477, 1, 'Питкяранта', 65, '186810', 1, NULL, 100, NULL, '1001100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(478, 1, 'Пудож', 65, '186150', 1, NULL, 100, NULL, '1001300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(479, 1, 'Сегежа', 65, '186420', 1, NULL, 100, NULL, '1001400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(480, 1, 'Сортавала', 65, '186790', 1, NULL, 100, NULL, '1000000700000', NULL, NULL, NULL, NULL, NULL, NULL),
(481, 1, 'Суоярви', 65, '186870', 1, NULL, 100, NULL, '1001500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(482, 1, 'Анжеро-Судженск', 27, '652470', 1, NULL, 100, NULL, '4200000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(483, 1, 'Белово', 27, '157138', 1, NULL, 100, NULL, '4200001500000', NULL, NULL, NULL, NULL, NULL, NULL),
(484, 1, 'Березовский', 27, '249355', 1, NULL, 100, NULL, '4200000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(485, 1, 'Калтан', 27, '652740', 1, NULL, 100, NULL, '4200000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(486, 1, 'Кемерово', 27, '650000', 1, NULL, 100, NULL, '4200000900000', NULL, NULL, NULL, NULL, NULL, NULL),
(487, 1, 'Киселевск', 27, '652700', 1, NULL, 100, NULL, '4200000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(488, 1, 'Ленинск-Кузнецкий', 27, '652500', 1, NULL, 100, NULL, '4200001000000', NULL, NULL, NULL, NULL, NULL, NULL),
(489, 1, 'Мариинск', 27, '652150', 1, NULL, 100, NULL, '4200700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(490, 1, 'Междуреченск', 27, '169260', 1, NULL, 100, NULL, '4200001600000', NULL, NULL, NULL, NULL, NULL, NULL),
(491, 1, 'Мыски', 27, '652840', 1, NULL, 100, NULL, '4200000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(492, 1, 'Новокузнецк', 27, '654000', 1, NULL, 100, NULL, '4200001200000', NULL, NULL, NULL, NULL, NULL, NULL),
(493, 1, 'Осинники', 27, '652800', 1, NULL, 100, NULL, '4200000700000', NULL, NULL, NULL, NULL, NULL, NULL),
(494, 1, 'Полысаево', 27, '652560', 1, NULL, 100, NULL, '4200001100000', NULL, NULL, NULL, NULL, NULL, NULL),
(495, 1, 'Прокопьевск', 27, '653000', 1, NULL, 100, NULL, '4200001300000', NULL, NULL, NULL, NULL, NULL, NULL),
(496, 1, 'Салаир', 27, '652770', 1, NULL, 100, NULL, '4200300200000', NULL, NULL, NULL, NULL, NULL, NULL),
(497, 1, 'Тайга', 27, '164644', 1, NULL, 100, NULL, '4200000800000', NULL, NULL, NULL, NULL, NULL, NULL),
(498, 1, 'Таштагол', 27, '652990', 1, NULL, 100, NULL, '4201200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(499, 1, 'Топки', 27, '303187', 1, NULL, 100, NULL, '4201400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(500, 1, 'Юрга', 27, '652050', 1, NULL, 100, NULL, '4200001400000', NULL, NULL, NULL, NULL, NULL, NULL),
(501, 1, 'Балей', 64, '673450', 1, NULL, 100, NULL, '7500400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(502, 1, 'Борзя', 64, '674600', 1, NULL, 100, NULL, '7500500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(503, 1, 'Краснокаменск', 64, '662955', 1, NULL, 100, NULL, '7501100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(504, 1, 'Могоча', 64, '673730', 1, NULL, 100, NULL, '7501400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(505, 1, 'Нерчинск', 64, '672840', 1, NULL, 100, NULL, '7501500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(506, 1, 'Петровск-Забайкальский', 64, '672801', 1, NULL, 100, NULL, '7501900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(507, 1, 'Сретенск', 64, '673500', 1, NULL, 100, NULL, '7502100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(508, 1, 'Хилок', 64, '673200', 1, NULL, 100, NULL, '7502500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(509, 1, 'Чита', 64, '422792', 1, NULL, 100, NULL, '7500000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(510, 1, 'Шилка', 64, '673302', 1, NULL, 100, NULL, '7502800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(511, 1, 'Баксан', 63, '361530', 1, NULL, 100, NULL, '0700000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(512, 1, 'Майский', 63, '160508', 1, NULL, 100, NULL, '3500100000900', NULL, NULL, NULL, NULL, NULL, NULL),
(513, 1, 'Нальчик', 63, '360000', 1, NULL, 100, NULL, '0700000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(514, 1, 'Нарткала', 63, '361330', 1, NULL, 100, NULL, '0700700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(515, 1, 'Прохладный', 63, '361040', 1, NULL, 100, NULL, '0700000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(516, 1, 'Терек', 63, '356837', 1, NULL, 100, NULL, '2600700001200', NULL, NULL, NULL, NULL, NULL, NULL),
(517, 1, 'Тырныауз', 63, '361621', 1, NULL, 100, NULL, '0701000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(518, 1, 'Чегем', 63, '361400', 1, NULL, 100, NULL, '0700800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(519, 1, 'Белая Холуница', 62, '613200', 1, NULL, 100, NULL, '4300400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(520, 1, 'Вятские Поляны', 62, '612960', 1, NULL, 100, NULL, '4300800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(521, 1, 'Зуевка', 62, '306137', 1, NULL, 100, NULL, '4301000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(522, 1, 'Кирово-Чепецк', 62, '613040', 1, NULL, 100, NULL, '4300000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(523, 1, 'Кирс', 62, '612820', 1, NULL, 100, NULL, '4300600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(524, 1, 'Котельнич', 62, '612600', 1, NULL, 100, NULL, '4301400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(525, 1, 'Луза', 62, '612423', 1, NULL, 100, NULL, '4301700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(526, 1, 'Малмыж', 62, '612920', 1, NULL, 100, NULL, '4301800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(527, 1, 'Мураши', 62, '613710', 1, NULL, 100, NULL, '4301900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(528, 1, 'Нолинск', 62, '613440', 1, NULL, 100, NULL, '4302200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(529, 1, 'Омутнинск', 62, '612704', 1, NULL, 100, NULL, '4302300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(530, 1, 'Орлов', 62, '347135', 1, NULL, 100, NULL, '4302600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(531, 1, 'Слободской', 62, '346652', 1, NULL, 100, NULL, '4303100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(532, 1, 'Сосновка', 62, '140576', 1, NULL, 100, NULL, '4300800200000', NULL, NULL, NULL, NULL, NULL, NULL),
(533, 1, 'Уржум', 62, '613530', 1, NULL, 100, NULL, '4303600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(534, 1, 'Яранск', 62, '612260', 1, NULL, 100, NULL, '4304000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(535, 1, 'Жигулевск', 26, '445350', 1, NULL, 100, NULL, '6300000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(536, 1, 'Кинель', 26, '446430', 1, NULL, 100, NULL, '6300001000000', NULL, NULL, NULL, NULL, NULL, NULL),
(537, 1, 'Нефтегорск', 26, '352685', 1, NULL, 100, NULL, '6301700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(538, 1, 'Новокуйбышевск', 26, '446200', 1, NULL, 100, NULL, '6300000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(539, 1, 'Октябрьск', 26, '445240', 1, NULL, 100, NULL, '6300000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(540, 1, 'Отрадный', 26, '346605', 1, NULL, 100, NULL, '6300000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(541, 1, 'Похвистнево', 26, '446450', 1, NULL, 100, NULL, '6300000900000', NULL, NULL, NULL, NULL, NULL, NULL),
(542, 1, 'Самара', 26, '443000', 1, NULL, 100, NULL, '6300000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(543, 1, 'Сызрань', 26, '446000', 1, NULL, 100, NULL, '6300000800000', NULL, NULL, NULL, NULL, NULL, NULL),
(544, 1, 'Тольятти', 26, '445000', 1, NULL, 100, NULL, '6300000700000', NULL, NULL, NULL, NULL, NULL, NULL),
(545, 1, 'Чапаевск', 26, '446100', 1, NULL, 100, NULL, '6300000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(546, 1, 'Касимов', 61, '391300', 1, NULL, 100, NULL, '6200000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(547, 1, 'Кораблино', 61, '390515', 1, NULL, 100, NULL, '6200700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(548, 1, 'Михайлов', 61, '347071', 1, NULL, 100, NULL, '6200900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(549, 1, 'Новомичуринск', 61, '391160', 1, NULL, 100, NULL, '6201200200000', NULL, NULL, NULL, NULL, NULL, NULL),
(550, 1, 'Рыбное', 61, '391110', 1, NULL, 100, NULL, '6201400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(551, 1, 'Ряжск', 61, '391960', 1, NULL, 100, NULL, '6201500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(552, 1, 'Рязань', 61, '390000', 1, NULL, 100, NULL, '6200000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(553, 1, 'Сасово', 61, '391430', 1, NULL, 100, NULL, '6200000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(554, 1, 'Скопин', 61, '391800', 1, NULL, 100, NULL, '6200000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(555, 1, 'Спас-Клепики', 61, '391030', 1, NULL, 100, NULL, '6200600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(556, 1, 'Спасск-Рязанский', 61, '391050', 1, NULL, 100, NULL, '6202000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(557, 1, 'Шацк', 61, '391550', 1, NULL, 100, NULL, '6202400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(558, 1, 'Далматово', 25, '641730', 1, NULL, 100, NULL, '4500500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(559, 1, 'Катайск', 25, '641700', 1, NULL, 100, NULL, '4500800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(560, 1, 'Курган', 25, '618613', 1, NULL, 100, NULL, '4500000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(561, 1, 'Куртамыш', 25, '641430', 1, NULL, 100, NULL, '4501000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(562, 1, 'Макушино', 25, '182340', 1, NULL, 100, NULL, '4501200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(563, 1, 'Петухово', 25, '641640', 1, NULL, 100, NULL, '4501500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(564, 1, 'Шадринск', 25, '641804', 1, NULL, 100, NULL, '4500000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(565, 1, 'Шумиха', 25, '622921', 1, NULL, 100, NULL, '4502300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(566, 1, 'Щучье', 25, '172468', 1, NULL, 100, NULL, '4502400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(567, 1, 'Дмитриев', 24, '307500', 1, NULL, 100, NULL, '4600600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(568, 1, 'Курск', 24, '188442', 1, NULL, 100, NULL, '4600000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(569, 1, 'Курчатов', 24, '307250', 1, NULL, 100, NULL, '4600000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(570, 1, 'Льгов', 24, '303944', 1, NULL, 100, NULL, '4600000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(571, 1, 'Обоянь', 24, '306230', 1, NULL, 100, NULL, '4601600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(572, 1, 'Рыльск', 24, '307331', 1, NULL, 100, NULL, '4602000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(573, 1, 'Суджа', 24, '307800', 1, NULL, 100, NULL, '4602300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(574, 1, 'Фатеж', 24, '307100', 1, NULL, 100, NULL, '4602500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(575, 1, 'Щигры', 24, '306509', 1, NULL, 100, NULL, '4600000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(576, 1, 'Бокситогорск', 60, '187650', 1, NULL, 100, NULL, '4700200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(577, 1, 'Волосово', 60, '188410', 1, NULL, 100, NULL, '4700300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(578, 1, 'Волхов', 60, '187401', 1, NULL, 100, NULL, '4700400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(579, 1, 'Всеволожск', 60, '188640', 1, NULL, 100, NULL, '4700500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(580, 1, 'Выборг', 60, '188800', 1, NULL, 100, NULL, '4700600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(581, 1, 'Высоцк', 60, '188909', 1, NULL, 100, NULL, '4700600200000', NULL, NULL, NULL, NULL, NULL, NULL),
(582, 1, 'Гатчина', 60, '188300', 1, NULL, 100, NULL, '4700700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(583, 1, 'Ивангород', 60, '188490', 1, NULL, 100, NULL, '4700801100000', NULL, NULL, NULL, NULL, NULL, NULL),
(584, 1, 'Каменногорск', 60, '188950', 1, NULL, 100, NULL, '4700600300000', NULL, NULL, NULL, NULL, NULL, NULL),
(585, 1, 'Кингисепп', 60, '188452', 1, NULL, 100, NULL, '4700800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(586, 1, 'Кириши', 60, '187110', 1, NULL, 100, NULL, '4700900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(587, 1, 'Кировск', 60, '184250', 1, NULL, 100, NULL, '4701000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(588, 1, 'Коммунар', 60, '188320', 1, NULL, 100, NULL, '4700700200000', NULL, NULL, NULL, NULL, NULL, NULL),
(589, 1, 'Лодейное Поле', 60, '187700', 1, NULL, 100, NULL, '4701100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(590, 1, 'Луга', 60, '188229', 1, NULL, 100, NULL, '4701300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(591, 1, 'Любань', 60, '187050', 1, NULL, 100, NULL, '4701800400000', NULL, NULL, NULL, NULL, NULL, NULL),
(592, 1, 'Никольское', 60, '143724', 1, NULL, 100, NULL, '4701800300000', NULL, NULL, NULL, NULL, NULL, NULL),
(593, 1, 'Новая Ладога', 60, '187450', 1, NULL, 100, NULL, '4700400200000', NULL, NULL, NULL, NULL, NULL, NULL),
(594, 1, 'Отрадное', 60, '143442', 1, NULL, 100, NULL, '4701000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(595, 1, 'Пикалево', 60, '187602', 1, NULL, 100, NULL, '4700200200000', NULL, NULL, NULL, NULL, NULL, NULL),
(596, 1, 'Подпорожье', 60, '186164', 1, NULL, 100, NULL, '4701400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(597, 1, 'Приозерск', 60, '188760', 1, NULL, 100, NULL, '4701500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(598, 1, 'Санкт-Петербург', 60, '190000', 1, NULL, 100, NULL, '7800000000000', NULL, NULL, NULL, NULL, NULL, NULL),
(599, 1, 'Светогорск', 60, '188990', 1, NULL, 100, NULL, '4700600500000', NULL, NULL, NULL, NULL, NULL, NULL),
(600, 1, 'Сертолово', 60, '188650', 1, NULL, 100, NULL, '4700500200000', NULL, NULL, NULL, NULL, NULL, NULL),
(601, 1, 'Сланцы', 60, '188560', 1, NULL, 100, NULL, '4701600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(602, 1, 'Сосновый Бор', 60, '182277', 1, NULL, 100, NULL, '4700000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(603, 1, 'Сясьстрой', 60, '187420', 1, NULL, 100, NULL, '4700400300000', NULL, NULL, NULL, NULL, NULL, NULL),
(604, 1, 'Тихвин', 60, '187549', 1, NULL, 100, NULL, '4701700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(605, 1, 'Тосно', 60, '187000', 1, NULL, 100, NULL, '4701800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(606, 1, 'Шлиссельбург', 60, '187320', 1, NULL, 100, NULL, '4701000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(607, 1, 'Грязи', 23, '399050', 1, NULL, 100, NULL, '4800300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(608, 1, 'Данков', 23, '399835', 1, NULL, 100, NULL, '4800400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(609, 1, 'Елец', 23, '399002', 1, NULL, 100, NULL, '4800000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(610, 1, 'Задонск', 23, '399200', 1, NULL, 100, NULL, '4800900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(611, 1, 'Лебедянь', 23, '399610', 1, NULL, 100, NULL, '4801200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(612, 1, 'Липецк', 23, '398000', 1, NULL, 100, NULL, '4800000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(613, 1, 'Усмань', 23, '399370', 1, NULL, 100, NULL, '4801600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(614, 1, 'Чаплыгин', 23, '352185', 1, NULL, 100, NULL, '4801800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(615, 1, 'Магадан', 59, '685000', 1, NULL, 100, NULL, '4900000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(616, 1, 'Сусуман', 59, '686314', 1, NULL, 100, NULL, '4900600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(617, 1, 'Воркута', 58, '169900', 1, NULL, 100, NULL, '1100000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(618, 1, 'Вуктыл', 58, '169570', 1, NULL, 100, NULL, '1100000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(619, 1, 'Емва', 58, '169200', 1, NULL, 100, NULL, '1100600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(620, 1, 'Инта', 58, '169840', 1, NULL, 100, NULL, '1100000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(621, 1, 'Микунь', 58, '169060', 1, NULL, 100, NULL, '1101700200000', NULL, NULL, NULL, NULL, NULL, NULL),
(622, 1, 'Печора', 58, '169600', 1, NULL, 100, NULL, '1100000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(623, 1, 'Сосногорск', 58, '169500', 1, NULL, 100, NULL, '1100000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(624, 1, 'Сыктывкар', 58, '167000', 1, NULL, 100, NULL, '1100000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(625, 1, 'Усинск', 58, '169710', 1, NULL, 100, NULL, '1100000700000', NULL, NULL, NULL, NULL, NULL, NULL),
(626, 1, 'Ухта', 58, '169300', 1, NULL, 100, NULL, '1100000800000', NULL, NULL, NULL, NULL, NULL, NULL),
(627, 1, 'Губкинский', 57, '629830', 1, NULL, 100, NULL, '8900000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(628, 1, 'Лабытнанги', 57, '629400', 1, NULL, 100, NULL, '8900000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(629, 1, 'Муравленко', 57, '629601', 1, NULL, 100, NULL, '8900000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(630, 1, 'Надым', 57, '629730', 1, NULL, 100, NULL, '8900000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(631, 1, 'Новый Уренгой', 57, '629300', 1, NULL, 100, NULL, '8900000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(632, 1, 'Ноябрьск', 57, '629800', 1, NULL, 100, NULL, '8900000700000', NULL, NULL, NULL, NULL, NULL, NULL),
(633, 1, 'Салехард', 57, '629000', 1, NULL, 100, NULL, '8900000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(634, 1, 'Тарко-Сале', 57, '629850', 1, NULL, 100, NULL, '8900400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(635, 1, 'Алзамай', 22, '665160', 1, NULL, 100, NULL, '3801600200000', NULL, NULL, NULL, NULL, NULL, NULL),
(636, 1, 'Ангарск', 22, '665800', 1, NULL, 100, NULL, '3800000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(637, 1, 'Байкальск', 22, '665930', 1, NULL, 100, NULL, '3801800200000', NULL, NULL, NULL, NULL, NULL, NULL),
(638, 1, 'Бирюсинск', 22, '665050', 1, NULL, 100, NULL, '3801900200000', NULL, NULL, NULL, NULL, NULL, NULL),
(639, 1, 'Бодайбо', 22, '666900', 1, NULL, 100, NULL, '3800000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(640, 1, 'Братск', 22, '664899', 1, NULL, 100, NULL, '3800000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(641, 1, 'Вихоревка', 22, '665770', 1, NULL, 100, NULL, '3800500200000', NULL, NULL, NULL, NULL, NULL, NULL),
(642, 1, 'Железногорск-Илимский', 22, '665650', 1, NULL, 100, NULL, '3801500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(643, 1, 'Зима', 22, '665382', 1, NULL, 100, NULL, '3800000700000', NULL, NULL, NULL, NULL, NULL, NULL),
(644, 1, 'Иркутск', 22, '664000', 1, NULL, 100, NULL, '3800000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(645, 1, 'Киренск', 22, '666700', 1, NULL, 100, NULL, '3801200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(646, 1, 'Нижнеудинск', 22, '664810', 1, NULL, 100, NULL, '3800000800000', NULL, NULL, NULL, NULL, NULL, NULL),
(647, 1, 'Саянск', 22, '662654', 1, NULL, 100, NULL, '3800000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(648, 1, 'Свирск', 22, '665420', 1, NULL, 100, NULL, '3800001600000', NULL, NULL, NULL, NULL, NULL, NULL),
(649, 1, 'Слюдянка', 22, '665900', 1, NULL, 100, NULL, '3801800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(650, 1, 'Тайшет', 22, '664802', 1, NULL, 100, NULL, '3800000900000', NULL, NULL, NULL, NULL, NULL, NULL),
(651, 1, 'Тулун', 22, '665250', 1, NULL, 100, NULL, '3800001000000', NULL, NULL, NULL, NULL, NULL, NULL),
(652, 1, 'Усолье-Сибирское', 22, '665450', 1, NULL, 100, NULL, '3800001100000', NULL, NULL, NULL, NULL, NULL, NULL),
(653, 1, 'Усть-Илимск', 22, '666670', 1, NULL, 100, NULL, '3800001200000', NULL, NULL, NULL, NULL, NULL, NULL),
(654, 1, 'Усть-Кут', 22, '666780', 1, NULL, 100, NULL, '3800001300000', NULL, NULL, NULL, NULL, NULL, NULL),
(655, 1, 'Черемхово', 22, '665400', 1, NULL, 100, NULL, '3800001400000', NULL, NULL, NULL, NULL, NULL, NULL),
(656, 1, 'Шелехов', 22, '666031', 1, NULL, 100, NULL, '3800001500000', NULL, NULL, NULL, NULL, NULL, NULL),
(657, 1, 'Карабулак', 56, '386230', 1, NULL, 100, NULL, '0600000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(658, 1, 'Магас', 56, '386001', 1, NULL, 100, NULL, '0600000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(659, 1, 'Малгобек', 56, '386300', 1, NULL, 100, NULL, '0600000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(660, 1, 'Назрань', 56, '386100', 1, NULL, 100, NULL, '0600000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(661, 1, 'Арсеньев', 55, '692330', 1, NULL, 100, NULL, '2500000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(662, 1, 'Артем', 55, '692486', 1, NULL, 100, NULL, '2500000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(663, 1, 'Большой Камень', 55, '628107', 1, NULL, 100, NULL, '2500000700000', NULL, NULL, NULL, NULL, NULL, NULL),
(664, 1, 'Владивосток', 55, '690000', 1, NULL, 100, NULL, '2500000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(665, 1, 'Дальнегорск', 55, '692441', 1, NULL, 100, NULL, '2500000800000', NULL, NULL, NULL, NULL, NULL, NULL),
(666, 1, 'Дальнереченск', 55, '692102', 1, NULL, 100, NULL, '2500000900000', NULL, NULL, NULL, NULL, NULL, NULL),
(667, 1, 'Лесозаводск', 55, '692031', 1, NULL, 100, NULL, '2500001200000', NULL, NULL, NULL, NULL, NULL, NULL),
(668, 1, 'Находка', 55, '629360', 1, NULL, 100, NULL, '2500000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(669, 1, 'Партизанск', 55, '663404', 1, NULL, 100, NULL, '2500000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(670, 1, 'Спасск-Дальний', 55, '692230', 1, NULL, 100, NULL, '2500001000000', NULL, NULL, NULL, NULL, NULL, NULL),
(671, 1, 'Уссурийск', 55, '692500', 1, NULL, 100, NULL, '2500001100000', NULL, NULL, NULL, NULL, NULL, NULL),
(672, 1, 'Воткинск', 21, '427430', 1, NULL, 100, NULL, '1800000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(673, 1, 'Глазов', 21, '427601', 1, NULL, 100, NULL, '1800000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(674, 1, 'Ижевск', 21, '426000', 1, NULL, 100, NULL, '1800000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(675, 1, 'Камбарка', 21, '427950', 1, NULL, 100, NULL, '1801100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(676, 1, 'Можга', 21, '427327', 1, NULL, 100, NULL, '1800000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(677, 1, 'Сарапул', 21, '427960', 1, NULL, 100, NULL, '1800000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(678, 1, 'Заводоуковск', 54, '627139', 1, NULL, 100, NULL, '7200000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(679, 1, 'Ишим', 54, '627705', 1, NULL, 100, NULL, '7200000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(680, 1, 'Тобольск', 54, '626147', 1, NULL, 100, NULL, '7200000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(681, 1, 'Тюмень', 54, '625000', 1, NULL, 100, NULL, '7200000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(682, 1, 'Ялуторовск', 54, '625805', 1, NULL, 100, NULL, '7200000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(683, 1, 'Велиж', 20, '216290', 1, NULL, 100, NULL, '6700200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(684, 1, 'Вязьма', 20, '215110', 1, NULL, 100, NULL, '6700300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(685, 1, 'Гагарин', 20, '215010', 1, NULL, 100, NULL, '6700400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(686, 1, 'Демидов', 20, '216240', 1, NULL, 100, NULL, '6700600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(687, 1, 'Десногорск', 20, '216400', 1, NULL, 100, NULL, '6700000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(688, 1, 'Дорогобуж', 20, '215710', 1, NULL, 100, NULL, '6700700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(689, 1, 'Духовщина', 20, '216200', 1, NULL, 100, NULL, '6700800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(690, 1, 'Ельня', 20, '216330', 1, NULL, 100, NULL, '6700900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(691, 1, 'Починок', 20, '157195', 1, NULL, 100, NULL, '6701500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(692, 1, 'Рославль', 20, '216500', 1, NULL, 100, NULL, '6701600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(693, 1, 'Рудня', 20, '216790', 1, NULL, 100, NULL, '6701700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(694, 1, 'Сафоново', 20, '164767', 1, NULL, 100, NULL, '6701800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(695, 1, 'Смоленск', 20, '214000', 1, NULL, 100, NULL, '6700000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(696, 1, 'Сычевка', 20, '215279', 1, NULL, 100, NULL, '6701900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(697, 1, 'Ярцево', 20, '215800', 1, NULL, 100, NULL, '6702500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(698, 1, 'Благодарный', 53, '356420', 1, NULL, 100, NULL, '2600600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(699, 1, 'Буденновск', 53, '356800', 1, NULL, 100, NULL, '2600700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(700, 1, 'Георгиевск', 53, '357820', 1, NULL, 100, NULL, '2600000900000', NULL, NULL, NULL, NULL, NULL, NULL),
(701, 1, 'Ессентуки', 53, '357600', 1, NULL, 100, NULL, '2600000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(702, 1, 'Железноводск', 53, '357400', 1, NULL, 100, NULL, '2600000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(703, 1, 'Зеленокумск', 53, '357910', 1, NULL, 100, NULL, '2602300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(704, 1, 'Изобильный', 53, '347674', 1, NULL, 100, NULL, '2601000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(705, 1, 'Ипатово', 53, '356630', 1, NULL, 100, NULL, '2601100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(706, 1, 'Кисловодск', 53, '357700', 1, NULL, 100, NULL, '2600000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(707, 1, 'Лермонтов', 53, '357340', 1, NULL, 100, NULL, '2600000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(708, 1, 'Минеральные Воды', 53, '357200', 1, NULL, 100, NULL, '2601700200000', NULL, NULL, NULL, NULL, NULL, NULL),
(709, 1, 'Невинномысск', 53, '357100', 1, NULL, 100, NULL, '2600000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(710, 1, 'Нефтекумск', 53, '356880', 1, NULL, 100, NULL, '2601800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(711, 1, 'Новоалександровск', 53, '356000', 1, NULL, 100, NULL, '2601900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(712, 1, 'Новопавловск', 53, '357300', 1, NULL, 100, NULL, '2601200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(713, 1, 'Пятигорск', 53, '357500', 1, NULL, 100, NULL, '2600000700000', NULL, NULL, NULL, NULL, NULL, NULL),
(714, 1, 'Светлоград', 53, '356530', 1, NULL, 100, NULL, '2602100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(715, 1, 'Ставрополь', 53, '355000', 1, NULL, 100, NULL, '2600000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(716, 1, 'Жердевка', 52, '393670', 1, NULL, 100, NULL, '6800400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(717, 1, 'Кирсанов', 52, '393360', 1, NULL, 100, NULL, '6800000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(718, 1, 'Котовск', 52, '393190', 1, NULL, 100, NULL, '6800000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(719, 1, 'Мичуринск', 52, '393013', 1, NULL, 100, NULL, '6800000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(720, 1, 'Моршанск', 52, '393931', 1, NULL, 100, NULL, '6800000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(721, 1, 'Рассказово', 52, '393250', 1, NULL, 100, NULL, '6800000700000', NULL, NULL, NULL, NULL, NULL, NULL),
(722, 1, 'Тамбов', 52, '392000', 1, NULL, 100, NULL, '6800000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(723, 1, 'Уварово', 52, '172882', 1, NULL, 100, NULL, '6800000800000', NULL, NULL, NULL, NULL, NULL, NULL),
(724, 1, 'Амурск', 51, '682640', 1, NULL, 100, NULL, '2700000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(725, 1, 'Бикин', 51, '682970', 1, NULL, 100, NULL, '2700000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(726, 1, 'Вяземский', 51, '682950', 1, NULL, 100, NULL, '2700700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(727, 1, 'Комсомольск-на-Амуре', 51, '680801', 1, NULL, 100, NULL, '2700000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(728, 1, 'Николаевск-на-Амуре', 51, '682455', 1, NULL, 100, NULL, '2700000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(729, 1, 'Советская Гавань', 51, '680881', 1, NULL, 100, NULL, '2700000700000', NULL, NULL, NULL, NULL, NULL, NULL),
(730, 1, 'Хабаровск', 51, '680000', 1, NULL, 100, NULL, '2700000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(731, 1, 'Аргун', 18, '366281', 1, NULL, 100, NULL, '2000000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(732, 1, 'Грозный', 18, '364000', 1, NULL, 100, NULL, '2000000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(733, 1, 'Гудермес', 18, '366200', 1, NULL, 100, NULL, '2000500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(734, 1, 'Урус-Мартан', 18, '366500', 1, NULL, 100, NULL, '2001000000100', NULL, NULL, NULL, NULL, NULL, NULL),
(735, 1, 'Шали', 18, '366300', 1, NULL, 100, NULL, '2001200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(736, 1, 'Аша', 50, '456010', 1, NULL, 100, NULL, '7400200300000', NULL, NULL, NULL, NULL, NULL, NULL),
(737, 1, 'Бакал', 50, '456900', 1, NULL, 100, NULL, '7401700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(738, 1, 'Верхнеуральск', 50, '457670', 1, NULL, 100, NULL, '7402900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(739, 1, 'Верхний Уфалей', 50, '456800', 1, NULL, 100, NULL, '7400000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(740, 1, 'Еманжелинск', 50, '456580', 1, NULL, 100, NULL, '7404400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(741, 1, 'Златоуст', 50, '456200', 1, NULL, 100, NULL, '7400000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(742, 1, 'Карабаш', 50, '423229', 1, NULL, 100, NULL, '7400000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(743, 1, 'Карталы', 50, '457350', 1, NULL, 100, NULL, '7400700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(744, 1, 'Касли', 50, '456830', 1, NULL, 100, NULL, '7400900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(745, 1, 'Катав-Ивановск', 50, '456110', 1, NULL, 100, NULL, '7401000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(746, 1, 'Копейск', 50, '456600', 1, NULL, 100, NULL, '7400000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(747, 1, 'Коркино', 50, '187045', 1, NULL, 100, NULL, '7404500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(748, 1, 'Куса', 50, '456940', 1, NULL, 100, NULL, '7403400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(749, 1, 'Кыштым', 50, '456870', 1, NULL, 100, NULL, '7400000800000', NULL, NULL, NULL, NULL, NULL, NULL),
(750, 1, 'Магнитогорск', 50, '455000', 1, NULL, 100, NULL, '7400000900000', NULL, NULL, NULL, NULL, NULL, NULL),
(751, 1, 'Миасс', 50, '456300', 1, NULL, 100, NULL, '7400001000000', NULL, NULL, NULL, NULL, NULL, NULL),
(752, 1, 'Миньяр', 50, '456007', 1, NULL, 100, NULL, '7400200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(753, 1, 'Нязепетровск', 50, '456970', 1, NULL, 100, NULL, '7403600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(754, 1, 'Пласт', 50, '457020', 1, NULL, 100, NULL, '7404600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(755, 1, 'Сатка', 50, '456910', 1, NULL, 100, NULL, '7401700200000', NULL, NULL, NULL, NULL, NULL, NULL),
(756, 1, 'Сим', 50, '456020', 1, NULL, 100, NULL, '7400200200000', NULL, NULL, NULL, NULL, NULL, NULL),
(757, 1, 'Снежинск', 50, '456770', 1, NULL, 100, NULL, '7400001300000', NULL, NULL, NULL, NULL, NULL, NULL),
(758, 1, 'Трехгорный', 50, '456080', 1, NULL, 100, NULL, '7400001400000', NULL, NULL, NULL, NULL, NULL, NULL),
(759, 1, 'Усть-Катав', 50, '456040', 1, NULL, 100, NULL, '7400001500000', NULL, NULL, NULL, NULL, NULL, NULL),
(760, 1, 'Чебаркуль', 50, '456438', 1, NULL, 100, NULL, '7400003500000', NULL, NULL, NULL, NULL, NULL, NULL),
(761, 1, 'Челябинск', 50, '454000', 1, NULL, 100, NULL, '7400000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(762, 1, 'Южноуральск', 50, '457018', 1, NULL, 100, NULL, '7400001600000', NULL, NULL, NULL, NULL, NULL, NULL),
(763, 1, 'Юрюзань', 50, '456120', 1, NULL, 100, NULL, '7401000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(764, 1, 'Великие Луки', 17, '182100', 1, NULL, 100, NULL, '6000000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(765, 1, 'Великие Луки-1', 17, '182171', 1, NULL, 100, NULL, '6000300100051', NULL, NULL, NULL, NULL, NULL, NULL),
(766, 1, 'Гдов', 17, '181600', 1, NULL, 100, NULL, '6000400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(767, 1, 'Дно', 17, '182670', 1, NULL, 100, NULL, '6000600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(768, 1, 'Невель', 17, '182500', 1, NULL, 100, NULL, '6001000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(769, 1, 'Новоржев', 17, '182440', 1, NULL, 100, NULL, '6001100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(770, 1, 'Новосокольники', 17, '182200', 1, NULL, 100, NULL, '6001200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(771, 1, 'Опочка', 17, '182330', 1, NULL, 100, NULL, '6001300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(772, 1, 'Остров', 17, '152235', 1, NULL, 100, NULL, '6001400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(773, 1, 'Печоры', 17, '181500', 1, NULL, 100, NULL, '6001600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(774, 1, 'Порхов', 17, '182620', 1, NULL, 100, NULL, '6001800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(775, 1, 'Псков', 17, '180000', 1, NULL, 100, NULL, '6000000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(776, 1, 'Пустошка', 17, '182300', 1, NULL, 100, NULL, '6001900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(777, 1, 'Пыталово', 17, '181410', 1, NULL, 100, NULL, '6002100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(778, 1, 'Себеж', 17, '182250', 1, NULL, 100, NULL, '6002200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(779, 1, 'Ак-Довурак', 49, '668050', 1, NULL, 100, NULL, '1700000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(780, 1, 'Кызыл', 49, '667000', 1, NULL, 100, NULL, '1700000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(781, 1, 'Туран', 49, '668510', 1, NULL, 100, NULL, '1700900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(782, 1, 'Чадан', 49, '668110', 1, NULL, 100, NULL, '1700400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(783, 1, 'Шагонар', 49, '668210', 1, NULL, 100, NULL, '1701400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(784, 1, 'Алексин', 16, '301360', 1, NULL, 100, NULL, '7100200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(785, 1, 'Белев', 16, '301530', 1, NULL, 100, NULL, '7100400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(786, 1, 'Богородицк', 16, '301830', 1, NULL, 100, NULL, '7100500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(787, 1, 'Болохово', 16, '301280', 1, NULL, 100, NULL, '7101400200000', NULL, NULL, NULL, NULL, NULL, NULL),
(788, 1, 'Венев', 16, '301320', 1, NULL, 100, NULL, '7100600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(789, 1, 'Донской', 16, '301760', 1, NULL, 100, NULL, '7100000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(790, 1, 'Ефремов', 16, '301840', 1, NULL, 100, NULL, '7101000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(791, 1, 'Кимовск', 16, '301720', 1, NULL, 100, NULL, '7101300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(792, 1, 'Киреевск', 16, '301260', 1, NULL, 100, NULL, '7101400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(793, 1, 'Липки', 16, '216461', 1, NULL, 100, NULL, '7101400300000', NULL, NULL, NULL, NULL, NULL, NULL),
(794, 1, 'Новомосковск', 16, '301650', 1, NULL, 100, NULL, '7101700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(795, 1, 'Плавск', 16, '301470', 1, NULL, 100, NULL, '7101900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(796, 1, 'Суворов', 16, '301430', 1, NULL, 100, NULL, '7102000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(797, 1, 'Тула', 16, '300000', 1, NULL, 100, NULL, '7100000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(798, 1, 'Узловая', 16, '301600', 1, NULL, 100, NULL, '7102200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(799, 1, 'Чекалин', 16, '301414', 1, NULL, 100, NULL, '7102000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(800, 1, 'Щекино', 16, '162361', 1, NULL, 100, NULL, '7102400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(801, 1, 'Ясногорск', 16, '301030', 1, NULL, 100, NULL, '7102500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(802, 1, 'Асино', 48, '636840', 1, NULL, 100, NULL, '7000300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(803, 1, 'Кедровый', 48, '628544', 1, NULL, 100, NULL, '7000000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(804, 1, 'Колпашево', 48, '636460', 1, NULL, 100, NULL, '7000900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(805, 1, 'Северск', 48, '636000', 1, NULL, 100, NULL, '7000000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(806, 1, 'Стрежевой', 48, '634878', 1, NULL, 100, NULL, '7000000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(807, 1, 'Томск', 48, '634000', 1, NULL, 100, NULL, '7000000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(808, 1, 'Андреаполь', 15, '172800', 1, NULL, 100, NULL, '6900200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(809, 1, 'Бежецк', 15, '171980', 1, NULL, 100, NULL, '6900300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(810, 1, 'Белый', 15, '172530', 1, NULL, 100, NULL, '6900400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(811, 1, 'Бологое', 15, '171070', 1, NULL, 100, NULL, '6900500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(812, 1, 'Весьегонск', 15, '171720', 1, NULL, 100, NULL, '6900600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(813, 1, 'Вышний Волочек', 15, '171147', 1, NULL, 100, NULL, '6900000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(814, 1, 'Западная Двина', 15, '172610', 1, NULL, 100, NULL, '6900900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(815, 1, 'Зубцов', 15, '172332', 1, NULL, 100, NULL, '6901000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(816, 1, 'Калязин', 15, '171571', 1, NULL, 100, NULL, '6901100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(817, 1, 'Кашин', 15, '171591', 1, NULL, 100, NULL, '6900000900000', NULL, NULL, NULL, NULL, NULL, NULL),
(818, 1, 'Кимры', 15, '171500', 1, NULL, 100, NULL, '6900000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(819, 1, 'Конаково', 15, '171250', 1, NULL, 100, NULL, '6901500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(820, 1, 'Красный Холм', 15, '171660', 1, NULL, 100, NULL, '6901600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(821, 1, 'Кувшиново', 15, '172110', 1, NULL, 100, NULL, '6901700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(822, 1, 'Лихославль', 15, '171210', 1, NULL, 100, NULL, '6901900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(823, 1, 'Нелидово', 15, '143628', 1, NULL, 100, NULL, '6900000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(824, 1, 'Осташков', 15, '172218', 1, NULL, 100, NULL, '6900000800000', NULL, NULL, NULL, NULL, NULL, NULL),
(825, 1, 'Ржев', 15, '172380', 1, NULL, 100, NULL, '6900000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(826, 1, 'Старица', 15, '171360', 1, NULL, 100, NULL, '6903200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(827, 1, 'Тверь', 15, '170000', 1, NULL, 100, NULL, '6900000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(828, 1, 'Торжок', 15, '172000', 1, NULL, 100, NULL, '6900000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(829, 1, 'Торопец', 15, '172840', 1, NULL, 100, NULL, '6903400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(830, 1, 'Удомля', 15, '171841', 1, NULL, 100, NULL, '6900000700000', NULL, NULL, NULL, NULL, NULL, NULL),
(831, 1, 'Агрыз', 14, '422230', 1, NULL, 100, NULL, '1600200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(832, 1, 'Азнакаево', 14, '423330', 1, NULL, 100, NULL, '1600300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(833, 1, 'Альметьевск', 14, '423403', 1, NULL, 100, NULL, '1600800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(834, 1, 'Арск', 14, '422000', 1, NULL, 100, NULL, '1601000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(835, 1, 'Бавлы', 14, '423930', 1, NULL, 100, NULL, '1601200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(836, 1, 'Болгар', 14, '422840', 1, NULL, 100, NULL, '1603800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(837, 1, 'Бугульма', 14, '423230', 1, NULL, 100, NULL, '1601400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(838, 1, 'Буинск', 14, '422430', 1, NULL, 100, NULL, '1601500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(839, 1, 'Елабуга', 14, '423600', 1, NULL, 100, NULL, '1601900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(840, 1, 'Заинск', 14, '423520', 1, NULL, 100, NULL, '1602000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(841, 1, 'Зеленодольск', 14, '422540', 1, NULL, 100, NULL, '1602100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(842, 1, 'Иннополис', 14, '420500', 1, NULL, 100, NULL, '1601600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(843, 1, 'Казань', 14, '420000', 1, NULL, 100, NULL, '1600000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(844, 1, 'Лаишево', 14, '422610', 1, NULL, 100, NULL, '1602500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(845, 1, 'Лениногорск', 14, '423250', 1, NULL, 100, NULL, '1602600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(846, 1, 'Мамадыш', 14, '422190', 1, NULL, 100, NULL, '1602700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(847, 1, 'Менделеевск', 14, '423650', 1, NULL, 100, NULL, '1602800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(848, 1, 'Мензелинск', 14, '423700', 1, NULL, 100, NULL, '1602900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(849, 1, 'Набережные Челны', 14, '423800', 1, NULL, 100, NULL, '1600000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(850, 1, 'Нижнекамск', 14, '423544', 1, NULL, 100, NULL, '1603100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(851, 1, 'Нурлат', 14, '423040', 1, NULL, 100, NULL, '1603300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(852, 1, 'Тетюши', 14, '422370', 1, NULL, 100, NULL, '1603900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(853, 1, 'Чистополь', 14, '422980', 1, NULL, 100, NULL, '1604300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(854, 1, 'Абаза', 47, '655750', 1, NULL, 100, NULL, '1900000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(855, 1, 'Абакан', 47, '655000', 1, NULL, 100, NULL, '1900000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(856, 1, 'Саяногорск', 47, '655602', 1, NULL, 100, NULL, '1900000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(857, 1, 'Сорск', 47, '655111', 1, NULL, 100, NULL, '1900000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(858, 1, 'Черногорск', 47, '655151', 1, NULL, 100, NULL, '1900000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(859, 1, 'Белоярский', 46, '412561', 1, NULL, 100, NULL, '6402200000400', NULL, NULL, NULL, NULL, NULL, NULL),
(860, 1, 'Когалым', 46, '628481', 1, NULL, 100, NULL, '8600000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(861, 1, 'Лангепас', 46, '628671', 1, NULL, 100, NULL, '8600000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(862, 1, 'Лянтор', 46, '628449', 1, NULL, 100, NULL, '8600900200000', NULL, NULL, NULL, NULL, NULL, NULL),
(863, 1, 'Мегион', 46, '628680', 1, NULL, 100, NULL, '8600000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(864, 1, 'Нефтеюганск', 46, '628301', 1, NULL, 100, NULL, '8600001400000', NULL, NULL, NULL, NULL, NULL, NULL),
(865, 1, 'Нижневартовск', 46, '628600', 1, NULL, 100, NULL, '8600001100000', NULL, NULL, NULL, NULL, NULL, NULL),
(866, 1, 'Нягань', 46, '628180', 1, NULL, 100, NULL, '8600000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(867, 1, 'Покачи', 46, '628660', 1, NULL, 100, NULL, '8600000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(868, 1, 'Пыть-Ях', 46, '628380', 1, NULL, 100, NULL, '8600000700000', NULL, NULL, NULL, NULL, NULL, NULL),
(869, 1, 'Советский', 46, '157433', 1, NULL, 100, NULL, '4401100004000', NULL, NULL, NULL, NULL, NULL, NULL),
(870, 1, 'Сургут', 46, '446551', 1, NULL, 100, NULL, '8600001000000', NULL, NULL, NULL, NULL, NULL, NULL),
(871, 1, 'Урай', 46, '628280', 1, NULL, 100, NULL, '8600000900000', NULL, NULL, NULL, NULL, NULL, NULL),
(872, 1, 'Ханты-Мансийск', 46, '628000', 1, NULL, 100, NULL, '8600000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(873, 1, 'Югорск', 46, '628260', 1, NULL, 100, NULL, '8600001600000', NULL, NULL, NULL, NULL, NULL, NULL),
(874, 1, 'Барыш', 45, '433750', 1, NULL, 100, NULL, '7300000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(875, 1, 'Димитровград', 45, '433500', 1, NULL, 100, NULL, '7300000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(876, 1, 'Инза', 45, '433030', 1, NULL, 100, NULL, '7300500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(877, 1, 'Новоульяновск', 45, '433300', 1, NULL, 100, NULL, '7300000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(878, 1, 'Сенгилей', 45, '433380', 1, NULL, 100, NULL, '7301500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(879, 1, 'Ульяновск', 45, '432000', 1, NULL, 100, NULL, '7300000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(880, 1, 'Алагир', 13, '363240', 1, NULL, 100, NULL, '1500200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(881, 1, 'Ардон', 13, '363330', 1, NULL, 100, NULL, '1500300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(882, 1, 'Беслан', 13, '363020', 1, NULL, 100, NULL, '1500800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(883, 1, 'Владикавказ', 13, '362000', 1, NULL, 100, NULL, '1500000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(884, 1, 'Дигора', 13, '363410', 1, NULL, 100, NULL, '1500400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(885, 1, 'Моздок', 13, '362028', 1, NULL, 100, NULL, '1500700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(886, 1, 'Алдан', 12, '678900', 1, NULL, 100, NULL, '1400300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(887, 1, 'Верхоянск', 12, '678530', 1, NULL, 100, NULL, '1401000000000', NULL, NULL, NULL, NULL, NULL, NULL),
(888, 1, 'Вилюйск', 12, '678200', 1, NULL, 100, NULL, '1401100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(889, 1, 'Ленск', 12, '617452', 1, NULL, 100, NULL, '1401500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(890, 1, 'Нерюнгри', 12, '678960', 1, NULL, 100, NULL, '1400000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(891, 1, 'Нюрба', 12, '678450', 1, NULL, 100, NULL, '1402100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(892, 1, 'Олекминск', 12, '678100', 1, NULL, 100, NULL, '1402300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(893, 1, 'Покровск', 12, '249718', 1, NULL, 100, NULL, '4001200001200', NULL, NULL, NULL, NULL, NULL, NULL),
(894, 1, 'Среднеколымск', 12, '678790', 1, NULL, 100, NULL, '1402500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(895, 1, 'Томмот', 12, '678953', 1, NULL, 100, NULL, '1400300200000', NULL, NULL, NULL, NULL, NULL, NULL),
(896, 1, 'Удачный', 12, '678188', 1, NULL, 100, NULL, '1401700200000', NULL, NULL, NULL, NULL, NULL, NULL),
(897, 1, 'Якутск', 12, '677000', 1, NULL, 100, NULL, '1400000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(898, 1, 'Александровск-Сахалинский', 44, '694420', 1, NULL, 100, NULL, '6501800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(899, 1, 'Анива', 44, '694030', 1, NULL, 100, NULL, '6500200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(900, 1, 'Долинск', 44, '694051', 1, NULL, 100, NULL, '6500300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(901, 1, 'Корсаков', 44, '694020', 1, NULL, 100, NULL, '6500400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(902, 1, 'Курильск', 44, '694530', 1, NULL, 100, NULL, '6500500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(903, 1, 'Макаров', 44, '694140', 1, NULL, 100, NULL, '6500600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(904, 1, 'Невельск', 44, '694740', 1, NULL, 100, NULL, '6500700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(905, 1, 'Оха', 44, '694490', 1, NULL, 100, NULL, '6500900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(906, 1, 'Поронайск', 44, '694240', 1, NULL, 100, NULL, '6501000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(907, 1, 'Северо-Курильск', 44, '694550', 1, NULL, 100, NULL, '6501100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(908, 1, 'Томари', 44, '694820', 1, NULL, 100, NULL, '6501300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(909, 1, 'Холмск', 44, '694620', 1, NULL, 100, NULL, '6501600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(910, 1, 'Шахтерск', 44, '694910', 1, NULL, 100, NULL, '6501500200000', NULL, NULL, NULL, NULL, NULL, NULL),
(911, 1, 'Южно-Сахалинск', 44, '693000', 1, NULL, 100, NULL, '6500000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(912, 1, 'Александровск', 11, '618320', 1, NULL, 100, NULL, '5900000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(913, 1, 'Березники', 11, '152183', 1, NULL, 100, NULL, '5900000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(914, 1, 'Верещагино', 11, '152334', 1, NULL, 100, NULL, '5900500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(915, 1, 'Горнозаводск', 11, '618820', 1, NULL, 100, NULL, '5900600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(916, 1, 'Гремячинск', 11, '618270', 1, NULL, 100, NULL, '5900000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(917, 1, 'Губаха', 11, '618250', 1, NULL, 100, NULL, '5900000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(918, 1, 'Добрянка', 11, '618740', 1, NULL, 100, NULL, '5900000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(919, 1, 'Кизел', 11, '618350', 1, NULL, 100, NULL, '5900000700000', NULL, NULL, NULL, NULL, NULL, NULL),
(920, 1, 'Красновишерск', 11, '618590', 1, NULL, 100, NULL, '5901300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(921, 1, 'Краснокамск', 11, '617060', 1, NULL, 100, NULL, '5900001500000', NULL, NULL, NULL, NULL, NULL, NULL),
(922, 1, 'Кудымкар', 11, '619000', 1, NULL, 100, NULL, '5900001400000', NULL, NULL, NULL, NULL, NULL, NULL),
(923, 1, 'Кунгур', 11, '617470', 1, NULL, 100, NULL, '5900000900000', NULL, NULL, NULL, NULL, NULL, NULL),
(924, 1, 'Лысьва', 11, '618441', 1, NULL, 100, NULL, '5900001000000', NULL, NULL, NULL, NULL, NULL, NULL),
(925, 1, 'Нытва', 11, '617000', 1, NULL, 100, NULL, '5901400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(926, 1, 'Оса', 11, '612621', 1, NULL, 100, NULL, '5901600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(927, 1, 'Оханск', 11, '618100', 1, NULL, 100, NULL, '5901800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(928, 1, 'Очер', 11, '617140', 1, NULL, 100, NULL, '5901900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(929, 1, 'Пермь', 11, '614000', 1, NULL, 100, NULL, '5900000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(930, 1, 'Соликамск', 11, '618540', 1, NULL, 100, NULL, '5900001100000', NULL, NULL, NULL, NULL, NULL, NULL),
(931, 1, 'Усолье', 11, '446733', 1, NULL, 100, NULL, '5902400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(932, 1, 'Чайковский', 11, '617760', 1, NULL, 100, NULL, '5900001200000', NULL, NULL, NULL, NULL, NULL, NULL),
(933, 1, 'Чердынь', 11, '618601', 1, NULL, 100, NULL, '5902700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(934, 1, 'Чермоз', 11, '617040', 1, NULL, 100, NULL, '5900800200000', NULL, NULL, NULL, NULL, NULL, NULL),
(935, 1, 'Чернушка', 11, '613573', 1, NULL, 100, NULL, '5902800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(936, 1, 'Чусовой', 11, '618200', 1, NULL, 100, NULL, '5900001300000', NULL, NULL, NULL, NULL, NULL, NULL),
(937, 1, 'Белинский', 43, '442250', 1, NULL, 100, NULL, '5800500100000', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `kir_order_regions` (`id`, `site_id`, `title`, `parent_id`, `zipcode`, `is_city`, `area`, `sortn`, `fias_guid`, `kladr_id`, `type_short`, `processed`, `russianpost_arriveinfo`, `russianpost_arrive_min`, `russianpost_arrive_max`, `cdek_city_id`) VALUES
(938, 1, 'Городище', 43, '142811', 1, NULL, 100, NULL, '5800800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(939, 1, 'Заречный', 43, '442960', 1, NULL, 100, NULL, '5800000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(940, 1, 'Каменка', 43, '141894', 1, NULL, 100, NULL, '5801100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(941, 1, 'Кузнецк', 43, '442530', 1, NULL, 100, NULL, '5800000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(942, 1, 'Кузнецк-12', 43, '442542', 1, NULL, 100, NULL, '5800000300200', NULL, NULL, NULL, NULL, NULL, NULL),
(943, 1, 'Кузнецк-8', 43, '442538', 1, NULL, 100, NULL, '5800000300100', NULL, NULL, NULL, NULL, NULL, NULL),
(944, 1, 'Нижний Ломов', 43, '442150', 1, NULL, 100, NULL, '5802200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(945, 1, 'Пенза', 43, '440000', 1, NULL, 100, NULL, '5800000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(946, 1, 'Сердобск', 43, '442890', 1, NULL, 100, NULL, '5802500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(947, 1, 'Спасск', 43, '442600', 1, NULL, 100, NULL, '5800300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(948, 1, 'Сурск', 43, '442300', 1, NULL, 100, NULL, '5800800200000', NULL, NULL, NULL, NULL, NULL, NULL),
(949, 1, 'Болхов', 10, '303140', 1, NULL, 100, NULL, '5700200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(950, 1, 'Дмитровск', 10, '303240', 1, NULL, 100, NULL, '5700500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(951, 1, 'Ливны', 10, '303850', 1, NULL, 100, NULL, '5700000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(952, 1, 'Малоархангельск', 10, '303369', 1, NULL, 100, NULL, '5701400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(953, 1, 'Мценск', 10, '303030', 1, NULL, 100, NULL, '5700000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(954, 1, 'Новосиль', 10, '303500', 1, NULL, 100, NULL, '5701700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(955, 1, 'Орел', 10, '181603', 1, NULL, 100, NULL, '5700000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(956, 1, 'Астрахань', 9, '414000', 1, NULL, 100, NULL, '3000000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(957, 1, 'Ахтубинск', 9, '416500', 1, NULL, 100, NULL, '3000200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(958, 1, 'Знаменск', 9, '238200', 1, NULL, 100, NULL, '3000000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(959, 1, 'Камызяк', 9, '416340', 1, NULL, 100, NULL, '3000600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(960, 1, 'Нариманов', 9, '416111', 1, NULL, 100, NULL, '3000900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(961, 1, 'Харабали', 9, '416009', 1, NULL, 100, NULL, '3001100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(962, 1, 'Агидель', 8, '452920', 1, NULL, 100, NULL, '0200000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(963, 1, 'Баймак', 8, '453630', 1, NULL, 100, NULL, '0200600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(964, 1, 'Белебей', 8, '452000', 1, NULL, 100, NULL, '0200900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(965, 1, 'Белорецк', 8, '453500', 1, NULL, 100, NULL, '0201100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(966, 1, 'Бирск', 8, '452450', 1, NULL, 100, NULL, '0201300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(967, 1, 'Давлеканово', 8, '453400', 1, NULL, 100, NULL, '0205900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(968, 1, 'Дюртюли', 8, '452320', 1, NULL, 100, NULL, '0206000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(969, 1, 'Ишимбай', 8, '453200', 1, NULL, 100, NULL, '0202600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(970, 1, 'Кумертау', 8, '453300', 1, NULL, 100, NULL, '0200000700000', NULL, NULL, NULL, NULL, NULL, NULL),
(971, 1, 'Межгорье', 8, '453570', 1, NULL, 100, NULL, '0200000800000', NULL, NULL, NULL, NULL, NULL, NULL),
(972, 1, 'Мелеуз', 8, '453850', 1, NULL, 100, NULL, '0203500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(973, 1, 'Нефтекамск', 8, '452680', 1, NULL, 100, NULL, '0200000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(974, 1, 'Октябрьский', 8, '140060', 1, NULL, 100, NULL, '0200000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(975, 1, 'Салават', 8, '453250', 1, NULL, 100, NULL, '0200000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(976, 1, 'Сибай', 8, '453830', 1, NULL, 100, NULL, '0200000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(977, 1, 'Стерлитамак', 8, '453100', 1, NULL, 100, NULL, '0200001400000', NULL, NULL, NULL, NULL, NULL, NULL),
(978, 1, 'Туймазы', 8, '452750', 1, NULL, 100, NULL, '0204400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(979, 1, 'Уфа', 8, '450000', 1, NULL, 100, NULL, '0200000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(980, 1, 'Учалы', 8, '453700', 1, NULL, 100, NULL, '0204600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(981, 1, 'Янаул', 8, '452800', 1, NULL, 100, NULL, '0205200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(982, 1, 'Алексеевка', 42, '181309', 1, NULL, 100, NULL, '3100200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(983, 1, 'Белгород', 42, '308000', 1, NULL, 100, NULL, '3100000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(984, 1, 'Бирюч', 42, '309910', 1, NULL, 100, NULL, '3101200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(985, 1, 'Валуйки', 42, '309990', 1, NULL, 100, NULL, '3100400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(986, 1, 'Грайворон', 42, '309370', 1, NULL, 100, NULL, '3100700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(987, 1, 'Губкин', 42, '309180', 1, NULL, 100, NULL, '3100000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(988, 1, 'Короча', 42, '309210', 1, NULL, 100, NULL, '3101000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(989, 1, 'Новый Оскол', 42, '309626', 1, NULL, 100, NULL, '3101400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(990, 1, 'Старый Оскол', 42, '309500', 1, NULL, 100, NULL, '3100000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(991, 1, 'Строитель', 42, '309062', 1, NULL, 100, NULL, '3102100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(992, 1, 'Шебекино', 42, '309290', 1, NULL, 100, NULL, '3100000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(993, 1, 'Барабинск', 41, '630833', 1, NULL, 100, NULL, '5400301200000', NULL, NULL, NULL, NULL, NULL, NULL),
(994, 1, 'Бердск', 41, '633000', 1, NULL, 100, NULL, '5400000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(995, 1, 'Болотное', 41, '633340', 1, NULL, 100, NULL, '5400400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(996, 1, 'Искитим', 41, '633200', 1, NULL, 100, NULL, '5400000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(997, 1, 'Карасук', 41, '632860', 1, NULL, 100, NULL, '5400900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(998, 1, 'Каргат', 41, '632400', 1, NULL, 100, NULL, '5401000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(999, 1, 'Куйбышев', 41, '404146', 1, NULL, 100, NULL, '5401501800000', NULL, NULL, NULL, NULL, NULL, NULL),
(1000, 1, 'Купино', 41, '309263', 1, NULL, 100, NULL, '5401600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1001, 1, 'Новосибирск', 41, '630000', 1, NULL, 100, NULL, '5400000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1002, 1, 'Обь', 41, '633100', 1, NULL, 100, NULL, '5400000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(1003, 1, 'Татарск', 41, '216156', 1, NULL, 100, NULL, '5402302200000', NULL, NULL, NULL, NULL, NULL, NULL),
(1004, 1, 'Тогучин', 41, '633450', 1, NULL, 100, NULL, '5402400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1005, 1, 'Черепаново', 41, '461227', 1, NULL, 100, NULL, '5402800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1006, 1, 'Чулым', 41, '632550', 1, NULL, 100, NULL, '5403000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1007, 1, 'Чулым-3', 41, '632553', 1, NULL, 100, NULL, '5403000005700', NULL, NULL, NULL, NULL, NULL, NULL),
(1008, 1, 'Боровичи', 7, '174400', 1, NULL, 100, NULL, '5300300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1009, 1, 'Валдай', 7, '175400', 1, NULL, 100, NULL, '5300400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1010, 1, 'Великий Новгород', 7, '173000', 1, NULL, 100, NULL, '5300000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1011, 1, 'Малая Вишера', 7, '174260', 1, NULL, 100, NULL, '5300900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1012, 1, 'Окуловка', 7, '174350', 1, NULL, 100, NULL, '5301200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1013, 1, 'Пестово', 7, '174510', 1, NULL, 100, NULL, '5301400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1014, 1, 'Сольцы', 7, '175040', 1, NULL, 100, NULL, '5301600200000', NULL, NULL, NULL, NULL, NULL, NULL),
(1015, 1, 'Сольцы 2', 7, '175042', 1, NULL, 100, NULL, '5301600200000', NULL, NULL, NULL, NULL, NULL, NULL),
(1016, 1, 'Старая Русса', 7, '175200', 1, NULL, 100, NULL, '5301700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1017, 1, 'Холм', 7, '152876', 1, NULL, 100, NULL, '5301900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1018, 1, 'Чудово', 7, '174210', 1, NULL, 100, NULL, '5302000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1019, 1, 'Алапаевск', 6, '624600', 1, NULL, 100, NULL, '6600002400000', NULL, NULL, NULL, NULL, NULL, NULL),
(1020, 1, 'Арамиль', 6, '624000', 1, NULL, 100, NULL, '6602500200000', NULL, NULL, NULL, NULL, NULL, NULL),
(1021, 1, 'Артемовский', 6, '623780', 1, NULL, 100, NULL, '6600300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1022, 1, 'Асбест', 6, '624260', 1, NULL, 100, NULL, '6600000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(1023, 1, 'Богданович', 6, '623530', 1, NULL, 100, NULL, '6600800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1024, 1, 'Верхний Тагил', 6, '624162', 1, NULL, 100, NULL, '6600003700000', NULL, NULL, NULL, NULL, NULL, NULL),
(1025, 1, 'Верхняя Пышма', 6, '624090', 1, NULL, 100, NULL, '6600000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(1026, 1, 'Верхняя Салда', 6, '624760', 1, NULL, 100, NULL, '6600004500000', NULL, NULL, NULL, NULL, NULL, NULL),
(1027, 1, 'Верхняя Тура', 6, '624320', 1, NULL, 100, NULL, '6600004000000', NULL, NULL, NULL, NULL, NULL, NULL),
(1028, 1, 'Верхотурье', 6, '624380', 1, NULL, 100, NULL, '6601000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1029, 1, 'Волчанск', 6, '624941', 1, NULL, 100, NULL, '6600003900000', NULL, NULL, NULL, NULL, NULL, NULL),
(1030, 1, 'Дегтярск', 6, '623271', 1, NULL, 100, NULL, '6600004100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1031, 1, 'Екатеринбург', 6, '620000', 1, NULL, 100, NULL, '6600000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1032, 1, 'Ивдель', 6, '624445', 1, NULL, 100, NULL, '6600000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(1033, 1, 'Ирбит', 6, '623850', 1, NULL, 100, NULL, '6600002900000', NULL, NULL, NULL, NULL, NULL, NULL),
(1034, 1, 'Каменск-Уральский', 6, '623400', 1, NULL, 100, NULL, '6600002200000', NULL, NULL, NULL, NULL, NULL, NULL),
(1035, 1, 'Камышлов', 6, '624860', 1, NULL, 100, NULL, '6600003000000', NULL, NULL, NULL, NULL, NULL, NULL),
(1036, 1, 'Карпинск', 6, '624930', 1, NULL, 100, NULL, '6600000700000', NULL, NULL, NULL, NULL, NULL, NULL),
(1037, 1, 'Качканар', 6, '624350', 1, NULL, 100, NULL, '6600000800000', NULL, NULL, NULL, NULL, NULL, NULL),
(1038, 1, 'Кировград', 6, '624140', 1, NULL, 100, NULL, '6600000900000', NULL, NULL, NULL, NULL, NULL, NULL),
(1039, 1, 'Краснотурьинск', 6, '624440', 1, NULL, 100, NULL, '6600001000000', NULL, NULL, NULL, NULL, NULL, NULL),
(1040, 1, 'Красноуральск', 6, '461348', 1, NULL, 100, NULL, '6600001100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1041, 1, 'Красноуфимск', 6, '623300', 1, NULL, 100, NULL, '6600003100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1042, 1, 'Кушва', 6, '624300', 1, NULL, 100, NULL, '6600001200000', NULL, NULL, NULL, NULL, NULL, NULL),
(1043, 1, 'Лесной', 6, '140451', 1, NULL, 100, NULL, '6600001300000', NULL, NULL, NULL, NULL, NULL, NULL),
(1044, 1, 'Михайловск', 6, '356240', 1, NULL, 100, NULL, '6601700200000', NULL, NULL, NULL, NULL, NULL, NULL),
(1045, 1, 'Невьянск', 6, '624191', 1, NULL, 100, NULL, '6600004300000', NULL, NULL, NULL, NULL, NULL, NULL),
(1046, 1, 'Нижние Серги', 6, '623090', 1, NULL, 100, NULL, '6601700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1047, 1, 'Нижние Серги-3', 6, '623093', 1, NULL, 100, NULL, '6601700000100', NULL, NULL, NULL, NULL, NULL, NULL),
(1048, 1, 'Нижний Тагил', 6, '622000', 1, NULL, 100, NULL, '6600002300000', NULL, NULL, NULL, NULL, NULL, NULL),
(1049, 1, 'Нижняя Салда', 6, '624740', 1, NULL, 100, NULL, '6600002700000', NULL, NULL, NULL, NULL, NULL, NULL),
(1050, 1, 'Нижняя Тура', 6, '624220', 1, NULL, 100, NULL, '6600001400000', NULL, NULL, NULL, NULL, NULL, NULL),
(1051, 1, 'Новая Ляля', 6, '624400', 1, NULL, 100, NULL, '6601800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1052, 1, 'Новоуральск', 6, '462232', 1, NULL, 100, NULL, '6600001500000', NULL, NULL, NULL, NULL, NULL, NULL),
(1053, 1, 'Первоуральск', 6, '623100', 1, NULL, 100, NULL, '6600001600000', NULL, NULL, NULL, NULL, NULL, NULL),
(1054, 1, 'Полевской', 6, '623380', 1, NULL, 100, NULL, '6600001700000', NULL, NULL, NULL, NULL, NULL, NULL),
(1055, 1, 'Ревда', 6, '184580', 1, NULL, 100, NULL, '6600001800000', NULL, NULL, NULL, NULL, NULL, NULL),
(1056, 1, 'Реж', 6, '623750', 1, NULL, 100, NULL, '6602100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1057, 1, 'Североуральск', 6, '624480', 1, NULL, 100, NULL, '6600002100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1058, 1, 'Серов', 6, '624980', 1, NULL, 100, NULL, '6600003400000', NULL, NULL, NULL, NULL, NULL, NULL),
(1059, 1, 'Среднеуральск', 6, '624070', 1, NULL, 100, NULL, '6600003800000', NULL, NULL, NULL, NULL, NULL, NULL),
(1060, 1, 'Сухой Лог', 6, '624800', 1, NULL, 100, NULL, '6602400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1061, 1, 'Сысерть', 6, '624021', 1, NULL, 100, NULL, '6602500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1062, 1, 'Тавда', 6, '623950', 1, NULL, 100, NULL, '6600004200000', NULL, NULL, NULL, NULL, NULL, NULL),
(1063, 1, 'Талица', 6, '155456', 1, NULL, 100, NULL, '6602800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1064, 1, 'Туринск', 6, '623900', 1, NULL, 100, NULL, '6603000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1065, 1, 'Исилькуль', 40, '646020', 1, NULL, 100, NULL, '5500700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1066, 1, 'Калачинск', 40, '646900', 1, NULL, 100, NULL, '5500800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1067, 1, 'Называевск', 40, '646100', 1, NULL, 100, NULL, '5501600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1068, 1, 'Омск', 40, '644000', 1, NULL, 100, NULL, '5500000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1069, 1, 'Тара', 40, '646530', 1, NULL, 100, NULL, '5502800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1070, 1, 'Тюкалинск', 40, '646330', 1, NULL, 100, NULL, '5503000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1071, 1, 'Абдулино', 5, '461740', 1, NULL, 100, NULL, '5605500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1072, 1, 'Бугуруслан', 5, '461630', 1, NULL, 100, NULL, '5600000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(1073, 1, 'Бузулук', 5, '461040', 1, NULL, 100, NULL, '5600000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(1074, 1, 'Гай', 5, '462631', 1, NULL, 100, NULL, '5600000700000', NULL, NULL, NULL, NULL, NULL, NULL),
(1075, 1, 'Кувандык', 5, '462240', 1, NULL, 100, NULL, '5600000800000', NULL, NULL, NULL, NULL, NULL, NULL),
(1076, 1, 'Медногорск', 5, '462271', 1, NULL, 100, NULL, '5600000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(1077, 1, 'Новотроицк', 5, '462351', 1, NULL, 100, NULL, '5600000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(1078, 1, 'Оренбург', 5, '460000', 1, NULL, 100, NULL, '5600000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1079, 1, 'Орск', 5, '462400', 1, NULL, 100, NULL, '5600000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(1080, 1, 'Соль-Илецк', 5, '461500', 1, NULL, 100, NULL, '5601500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1081, 1, 'Сорочинск', 5, '461900', 1, NULL, 100, NULL, '5600000900000', NULL, NULL, NULL, NULL, NULL, NULL),
(1082, 1, 'Ясный', 5, '462781', 1, NULL, 100, NULL, '5600001000000', NULL, NULL, NULL, NULL, NULL, NULL),
(1083, 1, 'Алатырь', 4, '429805', 1, NULL, 100, NULL, '2100002200000', NULL, NULL, NULL, NULL, NULL, NULL),
(1084, 1, 'Канаш', 4, '422584', 1, NULL, 100, NULL, '1601600002000', NULL, NULL, NULL, NULL, NULL, NULL),
(1085, 1, 'Козловка', 4, '216527', 1, NULL, 100, NULL, '2100800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1086, 1, 'Мариинский Посад', 4, '429570', 1, NULL, 100, NULL, '2101200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1087, 1, 'Новочебоксарск', 4, '429950', 1, NULL, 100, NULL, '2100002400000', NULL, NULL, NULL, NULL, NULL, NULL),
(1088, 1, 'Цивильск', 4, '429900', 1, NULL, 100, NULL, '2101600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1089, 1, 'Чебоксары', 4, '428000', 1, NULL, 100, NULL, '2100000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1090, 1, 'Шумерля', 4, '429120', 1, NULL, 100, NULL, '2100002500000', NULL, NULL, NULL, NULL, NULL, NULL),
(1091, 1, 'Ядрин', 4, '429060', 1, NULL, 100, NULL, '2102000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1092, 1, 'Ардатов', 3, '431860', 1, NULL, 100, NULL, '1300200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1093, 1, 'Инсар', 3, '431430', 1, NULL, 100, NULL, '1301000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1094, 1, 'Ковылкино', 3, '431350', 1, NULL, 100, NULL, '1300000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(1095, 1, 'Рузаевка', 3, '431440', 1, NULL, 100, NULL, '1300000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(1096, 1, 'Саранск', 3, '430000', 1, NULL, 100, NULL, '1300000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1097, 1, 'Темников', 3, '431220', 1, NULL, 100, NULL, '1302000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1098, 1, 'Апатиты', 2, '184200', 1, NULL, 100, NULL, '5100000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(1099, 1, 'Гаджиево', 2, '184670', 1, NULL, 100, NULL, '5100001200000', NULL, NULL, NULL, NULL, NULL, NULL),
(1100, 1, 'Заозерск', 2, '184310', 1, NULL, 100, NULL, '5100000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(1101, 1, 'Заполярный', 2, '184430', 1, NULL, 100, NULL, '5100500200000', NULL, NULL, NULL, NULL, NULL, NULL),
(1102, 1, 'Кандалакша', 2, '184012', 1, NULL, 100, NULL, '5100100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1103, 1, 'Ковдор', 2, '184141', 1, NULL, 100, NULL, '5100200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1104, 1, 'Кола', 2, '184380', 1, NULL, 100, NULL, '5100300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1105, 1, 'Мончегорск', 2, '184505', 1, NULL, 100, NULL, '5100000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(1106, 1, 'Мурманск', 2, '183000', 1, NULL, 100, NULL, '5100000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1107, 1, 'Оленегорск', 2, '184530', 1, NULL, 100, NULL, '5100000700000', NULL, NULL, NULL, NULL, NULL, NULL),
(1108, 1, 'Оленегорск-1', 2, '184531', 1, NULL, 100, NULL, '5100001500000', NULL, NULL, NULL, NULL, NULL, NULL),
(1109, 1, 'Оленегорск-2', 2, '184532', 1, NULL, 100, NULL, '5100001600000', NULL, NULL, NULL, NULL, NULL, NULL),
(1110, 1, 'Островной', 2, '184640', 1, NULL, 100, NULL, '5100000800000', NULL, NULL, NULL, NULL, NULL, NULL),
(1111, 1, 'Полярные Зори', 2, '184230', 1, NULL, 100, NULL, '5100000900000', NULL, NULL, NULL, NULL, NULL, NULL),
(1112, 1, 'Полярный', 2, '184650', 1, NULL, 100, NULL, '5100001000000', NULL, NULL, NULL, NULL, NULL, NULL),
(1113, 1, 'Североморск', 2, '184601', 1, NULL, 100, NULL, '5100001100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1114, 1, 'Снежногорск', 2, '184682', 1, NULL, 100, NULL, '5100001300000', NULL, NULL, NULL, NULL, NULL, NULL),
(1115, 1, 'Нарьян-Мар', 39, '166000', 1, NULL, 100, NULL, '8300000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1116, 1, 'Арзамас', 38, '607220', 1, NULL, 100, NULL, '5200000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(1117, 1, 'Балахна', 38, '399221', 1, NULL, 100, NULL, '5200400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1118, 1, 'Богородск', 38, '168057', 1, NULL, 100, NULL, '5200500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1119, 1, 'Бор', 38, '606443', 1, NULL, 100, NULL, '5200000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(1120, 1, 'Ветлуга', 38, '606860', 1, NULL, 100, NULL, '5201300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1121, 1, 'Володарск', 38, '606070', 1, NULL, 100, NULL, '5201600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1122, 1, 'Ворсма', 38, '606120', 1, NULL, 100, NULL, '5203200200000', NULL, NULL, NULL, NULL, NULL, NULL),
(1123, 1, 'Выкса', 38, '607060', 1, NULL, 100, NULL, '5200000700000', NULL, NULL, NULL, NULL, NULL, NULL),
(1124, 1, 'Горбатов', 38, '606125', 1, NULL, 100, NULL, '5203200300000', NULL, NULL, NULL, NULL, NULL, NULL),
(1125, 1, 'Городец', 38, '606504', 1, NULL, 100, NULL, '5202000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1126, 1, 'Дзержинск', 38, '606000', 1, NULL, 100, NULL, '5200000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(1127, 1, 'Заволжье', 38, '606520', 1, NULL, 100, NULL, '5202000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(1128, 1, 'Княгинино', 38, '606340', 1, NULL, 100, NULL, '5202300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1129, 1, 'Кстово', 38, '607650', 1, NULL, 100, NULL, '5202700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1130, 1, 'Кулебаки', 38, '607010', 1, NULL, 100, NULL, '5200001000000', NULL, NULL, NULL, NULL, NULL, NULL),
(1131, 1, 'Лукоянов', 38, '607800', 1, NULL, 100, NULL, '5202900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1132, 1, 'Лысково', 38, '606210', 1, NULL, 100, NULL, '5203000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1133, 1, 'Навашино', 38, '607100', 1, NULL, 100, NULL, '5203100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1134, 1, 'Нижний Новгород', 38, '603000', 1, NULL, 100, NULL, '5200000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1135, 1, 'Павлово', 38, '606100', 1, NULL, 100, NULL, '5203200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1136, 1, 'Первомайск', 38, '431530', 1, NULL, 100, NULL, '5200000800000', NULL, NULL, NULL, NULL, NULL, NULL),
(1137, 1, 'Перевоз', 38, '607400', 1, NULL, 100, NULL, '5203400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1138, 1, 'Саров', 38, '607180', 1, NULL, 100, NULL, '5200000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(1139, 1, 'Семенов', 38, '606650', 1, NULL, 100, NULL, '5200000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(1140, 1, 'Сергач', 38, '607510', 1, NULL, 100, NULL, '5203800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1141, 1, 'Урень', 38, '606800', 1, NULL, 100, NULL, '5204500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1142, 1, 'Чкаловск', 38, '606540', 1, NULL, 100, NULL, '5204600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1143, 1, 'Шахунья', 38, '606910', 1, NULL, 100, NULL, '5200000900000', NULL, NULL, NULL, NULL, NULL, NULL),
(1144, 1, 'Азов', 37, '346780', 1, NULL, 100, NULL, '6100001300000', NULL, NULL, NULL, NULL, NULL, NULL),
(1145, 1, 'Аксай', 37, '346720', 1, NULL, 100, NULL, '6100300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1146, 1, 'Батайск', 37, '346880', 1, NULL, 100, NULL, '6100000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(1147, 1, 'Белая Калитва', 37, '347040', 1, NULL, 100, NULL, '6100500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1148, 1, 'Волгодонск', 37, '346686', 1, NULL, 100, NULL, '6100000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(1149, 1, 'Гуково', 37, '346399', 1, NULL, 100, NULL, '6100000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(1150, 1, 'Донецк', 37, '346330', 1, NULL, 100, NULL, '6100000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(1151, 1, 'Зверево', 37, '346310', 1, NULL, 100, NULL, '6100000700000', NULL, NULL, NULL, NULL, NULL, NULL),
(1152, 1, 'Зерноград', 37, '347740', 1, NULL, 100, NULL, '6101300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1153, 1, 'Каменск-Шахтинский', 37, '347800', 1, NULL, 100, NULL, '6100000800000', NULL, NULL, NULL, NULL, NULL, NULL),
(1154, 1, 'Константиновск', 37, '347250', 1, NULL, 100, NULL, '6101800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1155, 1, 'Красный Сулин', 37, '346350', 1, NULL, 100, NULL, '6101900100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1156, 1, 'Миллерово', 37, '346130', 1, NULL, 100, NULL, '6102300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1157, 1, 'Морозовск', 37, '347210', 1, NULL, 100, NULL, '6102500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1158, 1, 'Новочеркасск', 37, '346400', 1, NULL, 100, NULL, '6100000900000', NULL, NULL, NULL, NULL, NULL, NULL),
(1159, 1, 'Новошахтинск', 37, '346900', 1, NULL, 100, NULL, '6100001000000', NULL, NULL, NULL, NULL, NULL, NULL),
(1160, 1, 'Пролетарск', 37, '347540', 1, NULL, 100, NULL, '6103200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1161, 1, 'Ростов-на-Дону', 37, '344000', 1, NULL, 100, NULL, '6100000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1162, 1, 'Сальск', 37, '347630', 1, NULL, 100, NULL, '6103500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1163, 1, 'Семикаракорск', 37, '346630', 1, NULL, 100, NULL, '6103600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1164, 1, 'Таганрог', 37, '347900', 1, NULL, 100, NULL, '6100001100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1165, 1, 'Цимлянск', 37, '347320', 1, NULL, 100, NULL, '6104200100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1166, 1, 'Шахты', 37, '346500', 1, NULL, 100, NULL, '6100001200000', NULL, NULL, NULL, NULL, NULL, NULL),
(1167, 1, 'Гаврилов-Ям', 36, '152240', 1, NULL, 100, NULL, '7600500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1168, 1, 'Данилов', 36, '152070', 1, NULL, 100, NULL, '7600600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1169, 1, 'Любим', 36, '152470', 1, NULL, 100, NULL, '7600700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1170, 1, 'Мышкин', 36, '152830', 1, NULL, 100, NULL, '7600800100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1171, 1, 'Переславль-Залесский', 36, '152020', 1, NULL, 100, NULL, '7600000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(1172, 1, 'Пошехонье', 36, '152850', 1, NULL, 100, NULL, '7601300100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1173, 1, 'Ростов', 36, '152150', 1, NULL, 100, NULL, '7601400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1174, 1, 'Рыбинск', 36, '152900', 1, NULL, 100, NULL, '7601500100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1175, 1, 'Тутаев', 36, '152300', 1, NULL, 100, NULL, '7601600100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1176, 1, 'Углич', 36, '152610', 1, NULL, 100, NULL, '7601700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1177, 1, 'Ярославль', 36, '150000', 1, NULL, 100, NULL, '7600000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1178, 1, 'Алупка', 35, '298600', 1, NULL, 100, NULL, '9100000800100', NULL, NULL, NULL, NULL, NULL, NULL),
(1179, 1, 'Алушта', 35, '298500', 1, NULL, 100, NULL, '9100001100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1180, 1, 'Армянск', 35, '296012', 1, NULL, 100, NULL, '9100000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(1181, 1, 'Бахчисарай', 35, '298400', 1, NULL, 100, NULL, '9100100100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1182, 1, 'Джанкой', 35, '296100', 1, NULL, 100, NULL, '9100000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(1183, 1, 'Евпатория', 35, '297402', 1, NULL, 100, NULL, '9100000900000', NULL, NULL, NULL, NULL, NULL, NULL),
(1184, 1, 'Керчь', 35, '298233', 1, NULL, 100, NULL, '9100000100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1185, 1, 'Красноперекопск', 35, '296000', 1, NULL, 100, NULL, '9100000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(1186, 1, 'Саки', 35, '296500', 1, NULL, 100, NULL, '9100000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(1187, 1, 'Симферополь', 35, '295000', 1, NULL, 100, NULL, '9100000700000', NULL, NULL, NULL, NULL, NULL, NULL),
(1188, 1, 'Старый Крым', 35, '297345', 1, NULL, 100, NULL, '9100400100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1189, 1, 'Судак', 35, '298000', 1, NULL, 100, NULL, '9100000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(1190, 1, 'Феодосия', 35, '297183', 1, NULL, 100, NULL, '9100001000000', NULL, NULL, NULL, NULL, NULL, NULL),
(1191, 1, 'Щелкино', 35, '298213', 1, NULL, 100, NULL, '9100700100000', NULL, NULL, NULL, NULL, NULL, NULL),
(1192, 1, 'Ялта', 35, '298600', 1, NULL, 100, NULL, '9100000800000', NULL, NULL, NULL, NULL, NULL, NULL),
(1193, 1, 'Зеленоград', 34, '124489', 1, NULL, 100, NULL, '7700000200000', NULL, NULL, NULL, NULL, NULL, NULL),
(1194, 1, 'Московский', 34, '142784', 1, NULL, 100, NULL, '7701100100051', NULL, NULL, NULL, NULL, NULL, NULL),
(1195, 1, 'Троицк', 34, '142190', 1, NULL, 100, NULL, '7700000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(1196, 1, 'Щербинка', 34, '142170', 1, NULL, 100, NULL, '7700000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(1197, 1, 'Санкт-Петербург', 1, NULL, 0, NULL, 100, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1198, 1, 'Колпино', 1197, '196650', 1, NULL, 100, NULL, '7800000300000', NULL, NULL, NULL, NULL, NULL, NULL),
(1199, 1, 'Красное Село', 1197, '198301', 1, NULL, 100, NULL, '7800000400000', NULL, NULL, NULL, NULL, NULL, NULL),
(1200, 1, 'Кронштадт', 1197, '197760', 1, NULL, 100, NULL, '7800000500000', NULL, NULL, NULL, NULL, NULL, NULL),
(1201, 1, 'Ломоносов', 1197, '198411', 1, NULL, 100, NULL, '7800000600000', NULL, NULL, NULL, NULL, NULL, NULL),
(1202, 1, 'Петергоф', 1197, '198504', 1, NULL, 100, NULL, '7800000800000', NULL, NULL, NULL, NULL, NULL, NULL),
(1203, 1, 'Пушкин', 1197, '196601', 1, NULL, 100, NULL, '7800000900000', NULL, NULL, NULL, NULL, NULL, NULL),
(1204, 1, 'Сестрорецк', 1197, '197701', 1, NULL, 100, NULL, '7800001000000', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `kir_order_shipment`
--

CREATE TABLE IF NOT EXISTS `kir_order_shipment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `order_id` int(11) DEFAULT NULL COMMENT 'id заказа',
  `date` datetime DEFAULT NULL COMMENT 'Дата',
  `info_order_num` varchar(255) DEFAULT NULL COMMENT 'Номер заказа',
  `info_total_sum` decimal(10,2) DEFAULT NULL COMMENT 'Сумма отгрузки',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_order_shipment_item`
--

CREATE TABLE IF NOT EXISTS `kir_order_shipment_item` (
  `order_id` int(11) DEFAULT NULL COMMENT 'id заказа',
  `shipment_id` int(11) DEFAULT NULL COMMENT 'id отгрузки',
  `order_item_uniq` varchar(255) DEFAULT NULL COMMENT 'Идентификатор товарной позиции',
  `amount` decimal(10,3) DEFAULT NULL COMMENT 'Количество',
  `uit_id` int(11) DEFAULT NULL COMMENT 'УИТ',
  `cost` decimal(15,2) DEFAULT NULL COMMENT 'Сумма',
  UNIQUE KEY `order_id_shipment_id_order_item_uniq_uit_id` (`order_id`,`shipment_id`,`order_item_uniq`,`uit_id`),
  KEY `shipment_id` (`shipment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_order_substatus`
--

CREATE TABLE IF NOT EXISTS `kir_order_substatus` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `title` varchar(255) DEFAULT NULL COMMENT 'Название статуса',
  `alias` varchar(255) DEFAULT NULL COMMENT 'Псевдоним',
  `sortn` int(11) DEFAULT NULL COMMENT 'Порядок сортировки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_id_alias` (`site_id`,`alias`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_order_substatus`
--

INSERT INTO `kir_order_substatus` (`id`, `site_id`, `title`, `alias`, `sortn`) VALUES
(1, 1, 'Магазин не обработал заказ вовремя', 'processing_expired', 1),
(2, 1, 'Покупатель изменяет состав заказа', 'replacing_order', 2),
(3, 1, 'Покупатель не завершил оформление зарезервированного заказа вовремя', 'reservation_expired', 3),
(4, 1, 'Магазин не может выполнить заказ', 'shop_failed', 4),
(5, 1, 'Покупатель отменил заказ по собственным причинам', 'user_changed_mind', 5),
(6, 1, 'Покупатель не оплатил заказ', 'user_not_paid', 6),
(7, 1, 'Покупателя не устраивают условия доставки', 'user_refused_delivery', 7),
(8, 1, 'Покупателю не подошел товар', 'user_refused_product', 8),
(9, 1, 'Покупателя не устраивает качество товара', 'user_refused_quality', 9),
(10, 1, 'Не удалось связаться с покупателем', 'user_unreachable', 10);

-- --------------------------------------------------------

--
-- Структура таблицы `kir_order_tax`
--

CREATE TABLE IF NOT EXISTS `kir_order_tax` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `title` varchar(255) DEFAULT NULL COMMENT 'Название',
  `alias` varchar(255) DEFAULT NULL COMMENT 'Идентификатор (Английские буквы или цифры)',
  `description` varchar(255) DEFAULT NULL COMMENT 'Описание',
  `enabled` int(11) DEFAULT NULL COMMENT 'Включен',
  `user_type` enum('all','user','company') DEFAULT NULL COMMENT 'Тип плательщиков',
  `included` int(11) DEFAULT NULL COMMENT 'Входит в цену',
  `is_nds` int(11) DEFAULT '1' COMMENT 'Это НДС',
  `sortn` int(11) DEFAULT NULL COMMENT 'Порядок применения',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_order_tax_rate`
--

CREATE TABLE IF NOT EXISTS `kir_order_tax_rate` (
  `tax_id` int(11) DEFAULT NULL COMMENT 'Название',
  `region_id` int(11) DEFAULT NULL COMMENT 'ID региона',
  `rate` decimal(12,4) DEFAULT NULL COMMENT 'Ставка налога',
  UNIQUE KEY `tax_id_region_id` (`tax_id`,`region_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_order_userstatus`
--

CREATE TABLE IF NOT EXISTS `kir_order_userstatus` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `title` varchar(255) DEFAULT NULL COMMENT 'Статус',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Родитель',
  `bgcolor` varchar(7) DEFAULT NULL COMMENT 'Цвет фона',
  `type` varchar(50) DEFAULT NULL COMMENT 'Идентификатор(Англ.яз)',
  `copy_type` varchar(20) DEFAULT NULL COMMENT 'Дублирует системный статус',
  `is_system` int(1) NOT NULL DEFAULT '0' COMMENT 'Это системный статус. (его нельзя удалять)',
  `sortn` int(11) DEFAULT NULL COMMENT 'Сорт. номер',
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_id_type` (`site_id`,`type`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_order_userstatus`
--

INSERT INTO `kir_order_userstatus` (`id`, `site_id`, `title`, `parent_id`, `bgcolor`, `type`, `copy_type`, `is_system`, `sortn`) VALUES
(1, 1, 'Новый', 0, '#83b7b3', 'new', NULL, 1, 1),
(2, 1, 'Ожидает оплату', 0, '#687482', 'waitforpay', NULL, 1, 2),
(3, 1, 'Выбран метод оплаты', 0, '#4d76ad', 'payment_method_selected', NULL, 1, 3),
(4, 1, 'В обработке', 0, '#f2aa17', 'inprogress', NULL, 1, 4),
(5, 1, 'Ожидание чека', 0, '#808000', 'needreceipt', NULL, 1, 5),
(6, 1, 'Выполнен и закрыт', 0, '#5f8456', 'success', NULL, 1, 6),
(7, 1, 'Отменен', 0, '#ef533a', 'cancelled', NULL, 1, 7);

-- --------------------------------------------------------

--
-- Структура таблицы `kir_order_x_region`
--

CREATE TABLE IF NOT EXISTS `kir_order_x_region` (
  `zone_id` int(11) DEFAULT NULL COMMENT 'ID Зоны',
  `region_id` int(11) DEFAULT NULL COMMENT 'ID Региона',
  UNIQUE KEY `zone_id_region_id` (`zone_id`,`region_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_order_x_region`
--

INSERT INTO `kir_order_x_region` (`zone_id`, `region_id`) VALUES
(1, 12),
(1, 22),
(1, 64),
(1, 75),
(1, 83),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 6),
(2, 7),
(2, 8),
(2, 9),
(2, 11),
(2, 13),
(2, 14),
(2, 17),
(2, 18),
(2, 21),
(2, 26),
(2, 28),
(2, 29),
(2, 37),
(2, 39),
(2, 42),
(2, 43),
(2, 45),
(2, 50),
(2, 53),
(2, 56),
(2, 58),
(2, 60),
(2, 62),
(2, 63),
(2, 65),
(2, 68),
(2, 69),
(2, 73),
(2, 76),
(2, 77),
(2, 81),
(2, 84),
(3, 44),
(3, 51),
(3, 55),
(3, 59),
(3, 66),
(3, 70),
(3, 78),
(4, 10),
(4, 15),
(4, 16),
(4, 20),
(4, 23),
(4, 24),
(4, 32),
(4, 33),
(4, 34),
(4, 36),
(4, 38),
(4, 52),
(4, 61),
(4, 67),
(4, 71),
(4, 72),
(4, 80),
(4, 82),
(4, 85),
(4, 1197),
(5, 25),
(5, 27),
(5, 30),
(5, 31),
(5, 40),
(5, 41),
(5, 46),
(5, 47),
(5, 48),
(5, 49),
(5, 54),
(5, 57),
(5, 74),
(5, 79);

-- --------------------------------------------------------

--
-- Структура таблицы `kir_order_zone`
--

CREATE TABLE IF NOT EXISTS `kir_order_zone` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `title` varchar(255) DEFAULT NULL COMMENT 'Название',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_order_zone`
--

INSERT INTO `kir_order_zone` (`id`, `site_id`, `title`) VALUES
(1, 1, 'Магистральный пояс 4'),
(2, 1, 'Магистральный пояс 2'),
(3, 1, 'Магистральный пояс 5'),
(4, 1, 'Магистральный пояс 1'),
(5, 1, 'Магистральный пояс 3');

-- --------------------------------------------------------

--
-- Структура таблицы `kir_ormeditor_customfield`
--

CREATE TABLE IF NOT EXISTS `kir_ormeditor_customfield` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `orm_class` varchar(255) DEFAULT NULL COMMENT 'Расширяемый класс ORM объекта',
  `tab` varchar(255) DEFAULT NULL COMMENT 'Вкладка',
  `field` varchar(255) DEFAULT NULL COMMENT 'Свойство для расширения',
  `hide` varchar(255) DEFAULT NULL COMMENT 'Скрыть',
  `is_base` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL COMMENT 'Тип поля',
  `description` varchar(255) DEFAULT NULL COMMENT 'Описание поля',
  `default` varchar(255) DEFAULT NULL COMMENT 'Значение по умолчанию',
  `allow_empty` int(11) DEFAULT NULL COMMENT 'Разрешить NULL',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_page_seo`
--

CREATE TABLE IF NOT EXISTS `kir_page_seo` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `route_id` varchar(255) DEFAULT NULL COMMENT 'Маршрут',
  `meta_title` varchar(1000) DEFAULT NULL COMMENT 'Заголовок',
  `meta_keywords` varchar(1000) DEFAULT NULL COMMENT 'Ключевые слова',
  `meta_description` varchar(1000) DEFAULT NULL COMMENT 'Описание',
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_id_route_id` (`site_id`,`route_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_payment`
--

CREATE TABLE IF NOT EXISTS `kir_payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `date` date DEFAULT NULL COMMENT 'Дата',
  `number` int(11) DEFAULT NULL COMMENT 'Номер',
  `sum` double DEFAULT NULL COMMENT 'Сумма',
  `renter_id` int(11) DEFAULT NULL COMMENT 'Арендатор',
  `contract_id` int(11) DEFAULT NULL COMMENT 'Договор',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=240 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_payment`
--

INSERT INTO `kir_payment` (`id`, `date`, `number`, `sum`, `renter_id`, `contract_id`) VALUES
(5, '2021-07-28', 1, 10000, 2, 2),
(8, '2021-10-22', 408, 11550, 17, 17),
(7, '2021-12-01', 581, 11550, 17, 17),
(6, '2021-12-01', 580, 11550, 17, 17),
(9, '2021-05-26', 417, 40167, 16, 16),
(10, '2021-05-26', 418, 79632, 16, 16),
(11, '2021-05-26', 416, 70000, 16, 16),
(12, '2021-08-13', 2103, 159264, 16, 16),
(13, '2021-09-03', 2422, 159264, 16, 16),
(14, '2021-11-03', 3038, 140000, 16, 16),
(15, '2021-12-14', 3544, 70000, 16, 16),
(16, '2021-06-04', 33, 17800, 19, 19),
(17, '2021-07-04', 39, 17800, 19, 19),
(18, '2021-08-04', 45, 17800, 19, 19),
(19, '2021-09-05', 51, 17800, 19, 19),
(20, '2021-10-05', 56, 17800, 19, 19),
(21, '2021-11-01', 62, 17800, 19, 19),
(22, '2021-12-04', 69, 8900, 19, 19),
(23, '2021-04-05', 493, 59500, 8, 8),
(24, '2021-04-30', 679, 59500, 8, 8),
(25, '2021-06-03', 954, 59500, 8, 8),
(26, '2021-07-02', 1183, 59500, 8, 8),
(27, '2021-08-03', 1462, 59500, 8, 8),
(28, '2021-09-14', 1866, 59500, 8, 8),
(29, '2021-09-15', 1891, 6720, 8, 8),
(30, '2021-10-04', 1982, 59500, 8, 8),
(31, '2021-11-03', 2289, 59500, 8, 8),
(32, '2021-12-06', 2658, 59500, 8, 8),
(33, '2021-10-25', 22, 7830, 5, 5),
(34, '2021-11-22', 26, 7830, 5, 5),
(35, '2021-12-24', 27, 7830, 5, 5),
(36, '2021-10-05', 466193, 8550, 6, 6),
(37, '2021-11-06', 4518, 8550, 6, 6),
(38, '2021-12-06', 201381, 8550, 6, 6),
(39, '2021-08-16', 5527, 32550, 7, 7),
(40, '2021-09-07', 6010, 32550, 7, 7),
(41, '2021-11-01', 7709, 30900, 7, 7),
(42, '2021-11-01', 7708, 37926, 7, 7),
(43, '2021-12-15', 8640, 34342, 7, 7),
(44, '2021-06-25', 51, 18000, 9, 9),
(45, '2021-07-08', 57, 16000, 9, 9),
(46, '2021-08-10', 70, 16000, 9, 9),
(47, '2021-09-02', 89, 16000, 9, 9),
(48, '2021-09-30', 103, 16000, 9, 9),
(49, '2021-11-02', 116, 16000, 9, 9),
(50, '2021-12-01', 128, 16000, 9, 9),
(51, '2021-09-19', 23565, 15500, 10, 10),
(52, '2021-10-24', 40343, 15500, 10, 10),
(53, '2021-12-04', 63509, 15500, 10, 10),
(54, '2021-03-25', 517368, 9000, 11, 11),
(55, '2021-05-03', 41785, 9000, 11, 11),
(56, '2021-06-02', 573185, 9000, 11, 11),
(57, '2021-07-04', 39241, 9000, 11, 11),
(58, '2021-08-02', 945218, 9000, 11, 11),
(59, '2021-09-04', 62905, 9000, 11, 11),
(60, '2021-10-02', 84055, 9000, 11, 11),
(61, '2021-11-02', 452032, 9000, 11, 11),
(62, '2021-12-04', 58323, 9000, 11, 11),
(63, '2021-06-29', 2857, 13000, 12, 12),
(64, '2021-10-29', 1006, 43890, 12, 12),
(65, '2021-12-02', 1082, 14630, 12, 12),
(66, '2021-12-27', 2230, 31000, 4, 4),
(67, '2021-08-05', 4579, 29445, 3, 3),
(68, '2021-08-05', 4580, 26500, 3, 3),
(69, '2021-09-03', 5922, 26500, 3, 3),
(70, '2021-10-05', 7500, 26500, 3, 3),
(71, '2021-11-03', 9008, 26500, 3, 3),
(72, '2021-12-06', 40423, 26500, 3, 3),
(73, '2021-12-27', 41655, 26500, 3, 3),
(74, '2021-12-29', 6976, 16000, 12, 12),
(75, '2022-01-11', 1, 11970, 14, 14),
(76, '2021-06-02', 956, 31150, 15, 15),
(77, '2021-06-30', 1153, 31150, 15, 15),
(78, '2021-08-02', 1465, 31150, 15, 15),
(79, '2021-09-01', 1830, 31150, 15, 15),
(80, '2021-09-20', 2072, 14850, 15, 15),
(81, '2021-12-20', 3286, 28300, 15, 15),
(82, '2021-12-20', 3285, 28300, 15, 15),
(83, '2021-12-22', 3318, 14850, 15, 15),
(84, '2022-01-05', 44135, 8550, 6, 6),
(85, '2021-12-30', 2921, 68000, 8, 8),
(86, '2022-01-03', 1, 16000, 9, 9),
(87, '2021-12-28', 356473, 15500, 10, 10),
(88, '2021-12-27', 521214, 9000, 11, 11),
(89, '2021-12-28', 75, 8900, 19, 19),
(90, '2021-06-30', 102, 7500, 13, 13),
(91, '2021-07-15', 110, 7500, 13, 13),
(92, '2021-08-05', 136, 7500, 13, 13),
(93, '2021-09-14', 166, 7500, 13, 13),
(94, '2021-10-11', 191, 7500, 13, 13),
(95, '2021-11-15', 221, 7500, 13, 13),
(96, '2021-12-13', 243, 7500, 13, 13),
(97, '2022-01-10', 1, 7500, 13, 13),
(98, '2021-12-28', 676, 9240, 17, 17),
(99, '2021-12-03', 391, 10700, 14, 14),
(100, '2021-08-05', 1260, 34635, 4, 4),
(101, '2021-08-05', 1261, 31000, 4, 4),
(102, '2021-09-03', 1453, 31000, 4, 4),
(103, '2021-10-05', 1671, 31000, 4, 4),
(104, '2021-11-03', 1868, 31000, 4, 4),
(105, '2021-12-07', 2086, 31000, 4, 4),
(106, '2021-10-12', 302273, 17700, 18, 18),
(107, '2021-10-01', 302273, 17700, 18, 18),
(108, '2021-06-04', 508152, 8640, 20, 20),
(109, '2021-07-13', 575599, 9600, 20, 20),
(110, '2021-08-03', 350832, 8640, 20, 20),
(111, '2021-09-02', 576822, 8640, 20, 20),
(112, '2021-10-04', 283819, 8640, 20, 20),
(113, '2021-11-02', 620179, 8640, 20, 20),
(114, '2021-12-01', 656746, 8640, 20, 20),
(115, '2022-01-05', 13162, 8640, 20, 20),
(116, '2021-12-05', 732266, 3150, 21, 21),
(117, '2021-12-05', 746136, 9450, 21, 21),
(118, '2022-01-05', 652143, 9450, 21, 21),
(119, '2021-09-03', 373919, 9450, 22, 22),
(120, '2021-10-03', 9986, 9450, 22, 22),
(121, '2021-11-05', 63458, 9450, 22, 22),
(122, '2021-12-06', 346178, 9450, 22, 22),
(123, '2022-01-04', 35786, 9450, 22, 22),
(124, '2021-09-02', 331733, 9450, 23, 23),
(125, '2021-10-03', 28192, 9450, 23, 23),
(126, '2021-11-03', 420089, 9450, 23, 23),
(127, '2021-12-02', 935891, 9450, 23, 23),
(128, '2021-12-31', 681441, 9450, 23, 23),
(129, '2021-09-25', 13599, 15100, 24, 24),
(130, '2021-10-16', 14919, 15100, 24, 24),
(131, '2021-12-07', 506039, 15100, 24, 24),
(132, '2021-07-10', 73847, 9500, 25, 25),
(133, '2021-08-02', 728397, 8500, 25, 25),
(134, '2021-09-01', 722999, 8500, 25, 25),
(135, '2021-10-01', 463193, 8500, 25, 25),
(136, '2021-11-01', 101162, 8500, 25, 25),
(137, '2021-12-03', 753172, 8500, 25, 25),
(138, '2022-01-01', 33297, 8500, 25, 25),
(139, '2021-11-03', 556461, 8700, 26, 26),
(140, '2021-12-03', 543481, 8700, 26, 26),
(141, '2021-12-31', 707682, 8700, 26, 26),
(145, '2021-11-20', 40580, 7900, 27, 27),
(146, '2021-12-20', 393087, 7900, 27, 27),
(147, '2022-01-17', 409624, 8430, 27, 27),
(148, '2021-12-31', 698760, 3700, 28, 28),
(149, '2021-07-07', 485436, 9000, 29, 29),
(150, '2021-08-09', 849245, 9000, 29, 29),
(151, '2021-09-08', 656935, 9000, 29, 29),
(152, '2021-10-09', 88278, 9000, 29, 29),
(153, '2021-11-04', 51318, 8100, 29, 29),
(154, '2021-12-07', 600050, 9000, 29, 29),
(155, '2022-01-07', 7978, 9000, 29, 29),
(156, '2021-07-28', 102, 68874, 30, 30),
(157, '2021-08-13', 119, 99720, 30, 30),
(158, '2021-08-30', 125, 99720, 30, 30),
(159, '2021-10-29', 146, 99720, 30, 30),
(160, '2021-11-28', 160, 99720, 30, 30),
(161, '2021-11-28', 159, 99720, 30, 30),
(162, '2021-12-26', 172, 99720, 30, 30),
(163, '2021-05-08', 12623, 9000, 31, 31),
(164, '2021-06-04', 813771, 8100, 31, 31),
(165, '2021-06-26', 69999, 8100, 31, 31),
(166, '2021-08-01', 11066, 8100, 31, 31),
(167, '2021-09-05', 12655, 8100, 31, 31),
(168, '2021-10-02', 54525, 8100, 31, 31),
(169, '2021-11-03', 392521, 8100, 31, 31),
(170, '2021-12-05', 41140, 8100, 31, 31),
(171, '2021-12-27', 438883, 8100, 31, 31),
(172, '2021-05-19', 91, 24000, 32, 32),
(173, '2021-06-22', 113, 24000, 32, 32),
(174, '2021-07-22', 134, 24000, 32, 32),
(175, '2021-08-21', 150, 24000, 32, 32),
(176, '2021-09-28', 162, 24000, 32, 32),
(177, '2021-10-28', 181, 24000, 32, 32),
(178, '2021-11-29', 197, 24000, 32, 32),
(179, '2021-12-20', 209, 24000, 32, 32),
(180, '2022-01-31', 8, 24000, 32, 32),
(181, '2021-06-05', 2698, 6900, 34, 34),
(182, '2021-07-04', 14814, 6900, 34, 34),
(183, '2021-08-05', 756658, 6900, 34, 34),
(184, '2021-09-02', 376478, 6900, 34, 34),
(185, '2021-10-04', 561214, 6900, 34, 34),
(186, '2021-11-05', 74027, 6900, 34, 34),
(187, '2021-12-04', 85444, 6900, 34, 34),
(188, '2022-01-06', 907689, 6900, 34, 34),
(189, '2021-05-29', 59699, 27500, 35, 35),
(190, '2021-07-02', 349992, 27500, 35, 35),
(191, '2021-08-03', 568380, 27500, 35, 35),
(192, '2021-09-02', 634944, 27500, 35, 35),
(193, '2021-10-04', 121253, 27500, 35, 35),
(194, '2021-11-03', 620170, 27500, 35, 35),
(195, '2021-12-03', 550658, 27500, 35, 35),
(196, '2022-01-03', 998578, 27500, 35, 35),
(197, '2022-02-01', 430897, 27500, 35, 35),
(198, '2022-01-25', 5, 7830, 5, 5),
(199, '2022-01-31', 991529, 8550, 25, 25),
(200, '2022-01-24', 10395, 10395, 17, 17),
(201, '2022-01-31', 9, 99720, 30, 30),
(202, '2022-01-21', 122, 70000, 16, 16),
(203, '2022-02-04', 423967, 9500, 6, 6),
(204, '2022-02-01', 190, 68000, 8, 8),
(205, '2022-02-03', 202, 6720, 8, 8),
(206, '2022-02-03', 203, 11640, 8, 8),
(207, '2022-02-05', 141295, 9450, 21, 21),
(208, '2022-02-05', 5153, 8640, 20, 20),
(209, '2022-02-05', 4776, 6900, 34, 34),
(210, '2022-02-03', 403866, 21000, 18, 18),
(211, '2022-02-04', 803834, 90600, 18, 18),
(212, '2022-02-04', 186, 31000, 4, 4),
(213, '2022-02-04', 549171, 2850, 6, 6),
(214, '2022-02-04', 1576, 26500, 3, 3),
(215, '2022-02-04', 375199, 9450, 22, 22),
(216, '2022-02-04', 7, 8900, 19, 19),
(217, '2022-02-03', 969353, 8500, 26, 26),
(218, '2022-02-03', 969353, 200, 26, 26),
(219, '2022-02-03', 960221, 15500, 10, 10),
(220, '2022-02-03', 563565, 8100, 31, 31),
(221, '2022-02-02', 886152, 9450, 23, 23),
(222, '2022-02-02', 13, 6790, 13, 13),
(223, '2022-02-02', 39, 16000, 9, 9),
(224, '2022-02-02', 454703, 9000, 11, 11),
(225, '2022-02-01', 818598, 15200, 24, 24),
(226, '2022-02-01', 44, 10700, 14, 14),
(227, '2022-01-31', 315, 25470, 15, 15),
(228, '2022-02-11', 242, 10905, 4, 4),
(229, '2022-02-11', 2008, 8835, 3, 3),
(230, '2022-02-09', 436, 25470, 15, 15),
(231, '2022-02-08', 594849, 3150, 22, 22),
(232, '2022-02-08', 580514, 8100, 29, 29),
(233, '2022-02-07', 879749, 7000, 28, 28),
(234, '2022-02-07', 825849, 2000, 34, 34),
(235, '2022-02-07', 801171, 22000, 24, 24),
(236, '2022-02-14', 41, 16000, 9, 9),
(237, '2022-02-13', 25283, 29800, 10, 10),
(238, '2022-02-12', 77263, 8100, 24, 24),
(239, '2022-02-14', 848004, 10720, 28, 28);

-- --------------------------------------------------------

--
-- Структура таблицы `kir_photogalleries_album`
--

CREATE TABLE IF NOT EXISTS `kir_photogalleries_album` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `title` varchar(250) DEFAULT NULL COMMENT 'Название альбома',
  `alias` varchar(255) DEFAULT NULL COMMENT 'URL имя',
  `public` int(1) DEFAULT '1' COMMENT 'Публичный',
  `sortn` int(11) DEFAULT NULL COMMENT 'Сорт. индекс',
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_id_alias` (`site_id`,`alias`),
  KEY `public` (`public`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_product`
--

CREATE TABLE IF NOT EXISTS `kir_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `title` varchar(255) DEFAULT NULL COMMENT 'Короткое название',
  `alias` varchar(150) DEFAULT NULL COMMENT 'URL имя',
  `short_description` mediumtext COMMENT 'Краткое описание',
  `description` mediumtext COMMENT 'Описание товара',
  `barcode` varchar(50) DEFAULT NULL COMMENT 'Артикул',
  `weight` float DEFAULT NULL COMMENT 'Вес',
  `dateof` datetime DEFAULT NULL COMMENT 'Дата поступления',
  `num` decimal(11,3) NOT NULL COMMENT 'Доступно',
  `waiting` decimal(11,3) NOT NULL COMMENT 'Ожидание',
  `reserve` decimal(11,3) NOT NULL COMMENT 'Зарезервировано',
  `remains` decimal(11,3) NOT NULL COMMENT 'Остаток',
  `amount_step` decimal(11,3) NOT NULL DEFAULT '0.000' COMMENT 'Шаг изменения количества товара в корзине',
  `unit` int(11) DEFAULT NULL COMMENT 'Единица измерения',
  `min_order` decimal(11,3) DEFAULT NULL COMMENT 'Минимальное количество товара для заказа',
  `max_order` decimal(11,3) DEFAULT NULL COMMENT 'Максимальное количество товара для заказа',
  `public` int(1) DEFAULT NULL COMMENT 'Показывать товар',
  `no_export` int(1) DEFAULT '0' COMMENT 'Не экспортировать',
  `maindir` int(11) DEFAULT NULL COMMENT 'Основная категория',
  `reservation` enum('default','throughout','forced') NOT NULL DEFAULT 'default' COMMENT 'Предварительный заказ',
  `brand_id` int(11) DEFAULT '0' COMMENT 'Бренд товара',
  `format` varchar(20) DEFAULT NULL COMMENT 'Загружен из',
  `rating` decimal(3,1) DEFAULT NULL COMMENT 'Средний балл(рейтинг)',
  `comments` int(11) DEFAULT NULL COMMENT 'Кол-во комментариев',
  `last_id` varchar(36) DEFAULT NULL COMMENT 'Прошлый ID',
  `processed` int(2) DEFAULT NULL,
  `is_new` int(1) DEFAULT NULL COMMENT 'Служебное поле',
  `group_id` varchar(255) DEFAULT NULL COMMENT 'Идентификатор группы товаров',
  `xml_id` varchar(255) DEFAULT NULL COMMENT 'Идентификатор в системе 1C',
  `import_hash` varchar(32) DEFAULT NULL COMMENT 'Хэш данных импорта',
  `sku` varchar(50) DEFAULT NULL COMMENT 'Штрихкод',
  `sortn` int(11) DEFAULT '100' COMMENT 'Сортировочный вес',
  `recommended` varchar(4000) DEFAULT NULL COMMENT 'Рекомендуемые товары',
  `concomitant` varchar(4000) DEFAULT NULL COMMENT 'Сопутствующие товары',
  `offer_caption` varchar(200) DEFAULT NULL COMMENT 'Подпись к комплектациям',
  `meta_title` varchar(1000) DEFAULT NULL COMMENT 'SEO Заголовок',
  `meta_keywords` varchar(1000) DEFAULT NULL COMMENT 'SEO Ключевые слова(keywords)',
  `meta_description` varchar(1000) DEFAULT NULL COMMENT 'SEO Описание(description)',
  `market_sku` varchar(255) DEFAULT NULL COMMENT 'SKU на Яндекс.Маркете (market-sku)',
  `disallow_manually_add_to_cart` int(1) DEFAULT '0' COMMENT 'Запретить ручное добавление товара в корзину',
  `payment_subject` varchar(255) DEFAULT 'commodity' COMMENT 'Признак предмета расчета для чека',
  `payment_method` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Признак способа расчета для чека',
  `tax_ids` varchar(255) DEFAULT 'category' COMMENT 'Налоги',
  `marked_class` varchar(255) DEFAULT '' COMMENT 'Класс маркируемых товаров',
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_id_xml_id` (`site_id`,`xml_id`),
  UNIQUE KEY `site_id_alias` (`site_id`,`alias`),
  KEY `site_id_public_num` (`site_id`,`public`,`num`),
  KEY `site_id_public_dateof` (`site_id`,`public`,`dateof`),
  KEY `site_id_public_sortn` (`site_id`,`public`,`sortn`),
  KEY `site_id_group_id` (`site_id`,`group_id`),
  KEY `barcode` (`barcode`),
  KEY `dateof` (`dateof`),
  KEY `public` (`public`),
  KEY `maindir` (`maindir`),
  KEY `brand_id` (`brand_id`),
  KEY `format` (`format`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_product_dir`
--

CREATE TABLE IF NOT EXISTS `kir_product_dir` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `name` varchar(255) DEFAULT NULL COMMENT 'Название категории',
  `alias` varchar(150) DEFAULT NULL COMMENT 'Псевдоним',
  `parent` int(11) DEFAULT NULL COMMENT 'Родитель',
  `public` int(1) DEFAULT NULL COMMENT 'Публичный',
  `sortn` int(11) DEFAULT NULL COMMENT 'Порядк. N',
  `is_spec_dir` varchar(1) DEFAULT NULL COMMENT 'Это спец. список?',
  `is_label` int(1) NOT NULL DEFAULT '0' COMMENT 'Показывать как ярлык у товаров',
  `itemcount` int(11) DEFAULT NULL COMMENT 'Количество элементов',
  `level` int(11) DEFAULT NULL COMMENT 'Уровень вложенности',
  `image` varchar(255) DEFAULT NULL COMMENT 'Изображение',
  `weight` int(11) DEFAULT NULL COMMENT 'Вес товара по умолчанию, грамм',
  `xml_id` varchar(255) DEFAULT NULL COMMENT 'Идентификатор в системе 1C',
  `processed` int(2) DEFAULT NULL,
  `description` mediumtext COMMENT 'Описание категории',
  `meta_title` varchar(1000) DEFAULT NULL COMMENT 'Заголовок',
  `meta_keywords` varchar(1000) DEFAULT NULL COMMENT 'Ключевые слова',
  `meta_description` varchar(1000) DEFAULT NULL COMMENT 'Описание',
  `product_meta_title` varchar(1000) DEFAULT NULL COMMENT 'Заголовок товаров',
  `product_meta_keywords` varchar(1000) DEFAULT NULL COMMENT 'Ключевые слова товаров',
  `product_meta_description` varchar(1000) DEFAULT NULL COMMENT 'Описание товаров',
  `in_list_properties` mediumtext COMMENT 'Характеристики списка',
  `is_virtual` int(11) DEFAULT NULL COMMENT 'Включить подбор товаров',
  `virtual_data` mediumtext COMMENT 'Параметры выборки товаров',
  `export_name` varchar(255) DEFAULT NULL COMMENT 'Название категории при экспорте',
  `recommended` varchar(4000) DEFAULT NULL COMMENT 'Рекомендуемые товары',
  `concomitant` varchar(4000) DEFAULT NULL COMMENT 'Сопутствующие товары',
  `mobile_background_color` varchar(11) DEFAULT '#E0E0E0' COMMENT 'Цвет фона для планшета',
  `mobile_tablet_background_image` varchar(255) DEFAULT NULL COMMENT 'Картинка для планшета',
  `mobile_tablet_icon` varchar(255) DEFAULT NULL COMMENT 'Картинка для мобильной версии',
  `tax_ids` varchar(255) DEFAULT 'all' COMMENT 'Налоги',
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_id_xml_id` (`site_id`,`xml_id`),
  UNIQUE KEY `site_id_alias` (`site_id`,`alias`),
  KEY `site_id_parent` (`site_id`,`parent`),
  KEY `site_id_name_parent` (`site_id`,`name`,`parent`),
  KEY `level` (`level`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_product_favorite`
--

CREATE TABLE IF NOT EXISTS `kir_product_favorite` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `guest_id` varchar(50) DEFAULT NULL COMMENT 'id гостя',
  `user_id` int(11) DEFAULT NULL COMMENT 'id пользователя',
  `product_id` int(11) DEFAULT NULL COMMENT 'id товара',
  PRIMARY KEY (`id`),
  UNIQUE KEY `guest_id_user_id_product_id` (`guest_id`,`user_id`,`product_id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_product_multioffer`
--

CREATE TABLE IF NOT EXISTS `kir_product_multioffer` (
  `product_id` int(11) DEFAULT NULL COMMENT 'id товара',
  `prop_id` int(11) DEFAULT NULL COMMENT 'id характеристики',
  `title` varchar(255) DEFAULT NULL COMMENT 'Название уровня',
  `is_photo` int(11) DEFAULT '0' COMMENT 'Представление в виде фото?',
  `sortn` int(11) DEFAULT '0' COMMENT 'Индекс сортировки',
  UNIQUE KEY `product_id_prop_id` (`product_id`,`prop_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_product_offer`
--

CREATE TABLE IF NOT EXISTS `kir_product_offer` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `product_id` int(11) DEFAULT NULL COMMENT 'ID товара',
  `title` varchar(300) DEFAULT NULL COMMENT 'Название',
  `barcode` varchar(50) NOT NULL COMMENT 'Артикул',
  `weight` float DEFAULT '0' COMMENT 'Вес',
  `pricedata` text COMMENT 'Цена (сериализован)',
  `propsdata` text COMMENT 'Характеристики комплектации (сериализован)',
  `num` decimal(11,3) NOT NULL DEFAULT '0.000' COMMENT 'Остаток на складе',
  `waiting` decimal(11,3) NOT NULL COMMENT 'Ожидание',
  `reserve` decimal(11,3) NOT NULL COMMENT 'Зарезервировано',
  `remains` decimal(11,3) NOT NULL COMMENT 'Остаток',
  `photos` varchar(1000) DEFAULT NULL COMMENT 'Фотографии комплектаций',
  `sortn` int(11) DEFAULT NULL COMMENT 'Порядковый номер',
  `unit` int(11) DEFAULT '0' COMMENT 'Единица измерения',
  `processed` int(2) DEFAULT NULL COMMENT 'Флаг обработанной во время импорта комплектации',
  `xml_id` varchar(255) DEFAULT NULL COMMENT 'Идентификатор товара в системе 1C',
  `import_hash` varchar(32) DEFAULT NULL COMMENT 'Хэш данных импорта',
  `sku` varchar(50) DEFAULT NULL COMMENT 'Штрихкод',
  `market_sku` varchar(255) DEFAULT NULL COMMENT 'SKU на Яндекс.Маркете (market-sku)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_id_xml_id` (`site_id`,`xml_id`),
  KEY `product_id` (`product_id`),
  KEY `barcode` (`barcode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_product_prop`
--

CREATE TABLE IF NOT EXISTS `kir_product_prop` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `title` varchar(255) DEFAULT NULL COMMENT 'Название характеристики',
  `alias` varchar(255) DEFAULT NULL COMMENT 'Англ. псевдоним',
  `type` varchar(10) DEFAULT 'string' COMMENT 'Тип',
  `description` mediumtext COMMENT 'Описание',
  `sortn` int(11) DEFAULT NULL COMMENT 'Сорт. индекс',
  `parent_sortn` int(11) DEFAULT NULL COMMENT 'Сорт. индекс группы',
  `unit` varchar(30) DEFAULT NULL COMMENT 'Единица измерения',
  `unit_export` varchar(30) DEFAULT NULL COMMENT 'Размерная сетка',
  `name_for_export` varchar(30) DEFAULT NULL COMMENT 'Имя, выгружаемое на Яндекс маркет',
  `xml_id` varchar(255) DEFAULT NULL COMMENT 'Идентификатор товара в системе 1C',
  `parent_id` int(11) NOT NULL COMMENT 'Группа',
  `int_hide_inputs` int(1) DEFAULT '0' COMMENT 'Скрывать поля ввода границ диапазона',
  `hidden` int(1) DEFAULT '0' COMMENT 'Не отображать в карточке товара',
  `no_export` int(1) DEFAULT '0' COMMENT 'Не экспортировать',
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_id_alias` (`site_id`,`alias`),
  UNIQUE KEY `site_id_xml_id` (`site_id`,`xml_id`),
  KEY `title` (`title`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_product_prop_dir`
--

CREATE TABLE IF NOT EXISTS `kir_product_prop_dir` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `title` varchar(255) DEFAULT NULL COMMENT 'Название',
  `hidden` int(1) DEFAULT '0' COMMENT 'Не отображать в карточке товара',
  `sortn` int(11) DEFAULT NULL COMMENT 'Сорт. номер',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_product_prop_link`
--

CREATE TABLE IF NOT EXISTS `kir_product_prop_link` (
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `prop_id` int(11) DEFAULT NULL COMMENT 'ID характеристики',
  `product_id` int(11) DEFAULT NULL COMMENT 'ID товара',
  `group_id` int(11) DEFAULT NULL COMMENT 'ID группы товаров',
  `val_str` varchar(255) DEFAULT NULL COMMENT 'Строковое значение',
  `val_int` float DEFAULT NULL COMMENT 'Числовое значение',
  `val_list_id` int(11) DEFAULT NULL COMMENT 'Списковое значение',
  `available` int(1) NOT NULL DEFAULT '1' COMMENT 'Есть в наличии товары с такой характеристикой',
  `public` int(1) DEFAULT NULL COMMENT 'Участие в фильтрах. Для group_id>0',
  `is_expanded` int(1) NOT NULL DEFAULT '0' COMMENT 'Показывать всегда развернутым',
  `xml_id` varchar(255) DEFAULT NULL COMMENT 'Идентификатор товара в системе 1C',
  `extra` varchar(255) DEFAULT NULL COMMENT 'Дополнительное поле для данных',
  UNIQUE KEY `site_id_product_id_group_id` (`site_id`,`product_id`,`group_id`),
  KEY `site_id_prop_id` (`site_id`,`prop_id`),
  KEY `product_id_prop_id_val_str_available` (`product_id`,`prop_id`,`val_str`,`available`),
  KEY `product_id_prop_id_val_int_available` (`product_id`,`prop_id`,`val_int`,`available`),
  KEY `product_id_prop_id_val_list_id_available` (`product_id`,`prop_id`,`val_list_id`,`available`),
  KEY `prop_id_val_list_id` (`prop_id`,`val_list_id`),
  KEY `group_id_public` (`group_id`,`public`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_product_prop_value`
--

CREATE TABLE IF NOT EXISTS `kir_product_prop_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `prop_id` int(11) DEFAULT NULL COMMENT 'Характеристика',
  `value` varchar(255) DEFAULT NULL COMMENT 'Значение характеристики',
  `alias` varchar(255) DEFAULT NULL COMMENT 'Англ. псевдоним',
  `color` varchar(7) DEFAULT NULL COMMENT 'Цвет',
  `image` varchar(255) DEFAULT NULL COMMENT 'Изображение',
  `sortn` int(11) DEFAULT NULL COMMENT 'Порядок',
  `xml_id` varchar(255) DEFAULT NULL COMMENT 'Внешний идентификатор',
  PRIMARY KEY (`id`),
  UNIQUE KEY `prop_id_value` (`prop_id`,`value`),
  UNIQUE KEY `site_id_xml_id` (`site_id`,`xml_id`),
  UNIQUE KEY `site_id_alias_prop_id` (`site_id`,`alias`,`prop_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_product_reservation`
--

CREATE TABLE IF NOT EXISTS `kir_product_reservation` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `product_id` int(11) DEFAULT NULL COMMENT 'ID товара',
  `product_barcode` varchar(255) DEFAULT NULL COMMENT 'Артикул товара',
  `product_title` varchar(255) DEFAULT NULL COMMENT 'Название товара',
  `offer` varchar(255) DEFAULT NULL COMMENT 'Название комплектации товара',
  `offer_id` int(11) DEFAULT NULL COMMENT 'Комплектация товара',
  `currency` varchar(255) DEFAULT NULL COMMENT 'Валюта на момент оформления заявки',
  `multioffer` varchar(255) DEFAULT NULL COMMENT 'Многомерная комплектация товара',
  `amount` decimal(11,3) DEFAULT NULL COMMENT 'Количество',
  `phone` varchar(50) DEFAULT NULL COMMENT 'Телефон пользователя',
  `email` varchar(255) DEFAULT NULL COMMENT 'E-mail пользователя',
  `is_notify` enum('1','0') NOT NULL DEFAULT '0' COMMENT 'Уведомлять о поступлении на склад',
  `dateof` datetime DEFAULT NULL COMMENT 'Дата заказа',
  `user_id` bigint(11) DEFAULT NULL COMMENT 'ID пользователя',
  `status` enum('open','close') NOT NULL COMMENT 'Статус',
  `comment` mediumtext COMMENT 'Комментарий администратора',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_product_typecost`
--

CREATE TABLE IF NOT EXISTS `kir_product_typecost` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `xml_id` varchar(255) DEFAULT NULL COMMENT 'Идентификатор в системе 1C',
  `title` varchar(150) DEFAULT NULL COMMENT 'Название',
  `type` enum('manual','auto') DEFAULT 'manual' COMMENT 'Тип цены',
  `val_znak` varchar(1) DEFAULT NULL COMMENT 'Знак значения',
  `val` float DEFAULT NULL COMMENT 'Величина увеличения стоимости',
  `val_type` enum('sum','percent') DEFAULT NULL COMMENT 'Тип увеличения стоимости',
  `depend` int(11) DEFAULT NULL COMMENT 'Цена, от которой ведется расчет',
  `round` decimal(10,2) DEFAULT NULL COMMENT 'Округление',
  `old_cost` int(11) NOT NULL DEFAULT '0' COMMENT 'Старая(зачеркнутая) цена',
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_id_xml_id` (`site_id`,`xml_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_product_typecost`
--

INSERT INTO `kir_product_typecost` (`id`, `site_id`, `xml_id`, `title`, `type`, `val_znak`, `val`, `val_type`, `depend`, `round`, `old_cost`) VALUES
(1, 1, NULL, 'Розничная', 'manual', NULL, NULL, NULL, NULL, '0.00', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `kir_product_unit`
--

CREATE TABLE IF NOT EXISTS `kir_product_unit` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `code` int(11) DEFAULT NULL COMMENT 'Код ОКЕИ',
  `icode` varchar(25) DEFAULT NULL COMMENT 'Международное сокращение',
  `title` varchar(70) DEFAULT NULL COMMENT 'Полное название единицы измерения',
  `stitle` varchar(25) DEFAULT NULL COMMENT 'Короткое обозначение',
  `amount_step` decimal(11,3) NOT NULL DEFAULT '1.000' COMMENT 'Шаг изменения количества товара в корзине',
  `min_order_quantity` decimal(11,3) DEFAULT NULL COMMENT 'Минимальное количество товара для заказа',
  `max_order_quantity` decimal(11,3) DEFAULT NULL COMMENT 'Максимальное количество товара для заказа',
  `sortn` int(11) DEFAULT NULL COMMENT 'Сорт. номер',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_product_x_cost`
--

CREATE TABLE IF NOT EXISTS `kir_product_x_cost` (
  `product_id` int(11) DEFAULT NULL COMMENT 'ID товара',
  `cost_id` int(11) DEFAULT NULL COMMENT 'ID цены',
  `cost_val` decimal(20,2) NOT NULL COMMENT 'Рассчитанная цена в базовой валюте',
  `cost_original_val` decimal(20,2) NOT NULL COMMENT 'Оригинальная цена товара',
  `cost_original_currency` int(11) NOT NULL DEFAULT '0' COMMENT 'ID валюты оригинальной цены товара',
  UNIQUE KEY `product_id_cost_id` (`product_id`,`cost_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_product_x_dir`
--

CREATE TABLE IF NOT EXISTS `kir_product_x_dir` (
  `product_id` int(11) DEFAULT NULL COMMENT 'ID товара',
  `dir_id` int(11) DEFAULT NULL COMMENT 'ID категории',
  UNIQUE KEY `dir_id_product_id` (`dir_id`,`product_id`),
  KEY `product_id` (`product_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_product_x_stock`
--

CREATE TABLE IF NOT EXISTS `kir_product_x_stock` (
  `product_id` int(11) DEFAULT NULL COMMENT 'ID товара',
  `offer_id` int(11) DEFAULT NULL COMMENT 'ID комплектации',
  `warehouse_id` int(11) DEFAULT NULL COMMENT 'ID склада',
  `stock` decimal(11,3) DEFAULT '0.000' COMMENT 'Доступно',
  `reserve` decimal(11,3) DEFAULT '0.000' COMMENT 'Резерв',
  `waiting` decimal(11,3) DEFAULT '0.000' COMMENT 'Ожидание',
  `remains` decimal(11,3) DEFAULT '0.000' COMMENT 'Остаток',
  UNIQUE KEY `product_id_offer_id_warehouse_id` (`product_id`,`offer_id`,`warehouse_id`),
  KEY `offer_id` (`offer_id`),
  KEY `warehouse_id` (`warehouse_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_pushsender_push_lock`
--

CREATE TABLE IF NOT EXISTS `kir_pushsender_push_lock` (
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `user_id` int(11) DEFAULT NULL COMMENT 'Пользователь',
  `app` varchar(100) DEFAULT NULL COMMENT 'Приложение',
  `push_class` varchar(100) DEFAULT NULL COMMENT 'Класс уведомлений, all - запретить все',
  UNIQUE KEY `site_id_user_id_app_push_class` (`site_id`,`user_id`,`app`,`push_class`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_pushsender_user_token`
--

CREATE TABLE IF NOT EXISTS `kir_pushsender_user_token` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `user_id` int(11) DEFAULT NULL COMMENT 'ID пользователя',
  `push_token` varchar(300) DEFAULT NULL COMMENT 'Токен пользователя в Firebase',
  `dateofcreate` datetime DEFAULT NULL COMMENT 'Дата создания',
  `app` varchar(50) DEFAULT NULL COMMENT 'Приложение, для которого выписан token',
  `uuid` varchar(255) DEFAULT NULL COMMENT 'Уникальный идентификатор устройства',
  `model` varchar(80) DEFAULT NULL COMMENT 'Модель устройства',
  `manufacturer` varchar(80) DEFAULT NULL COMMENT 'Производитель',
  `platform` varchar(50) DEFAULT NULL COMMENT 'Платформа на устройстве',
  `version` varchar(255) DEFAULT NULL COMMENT 'Версия платформы на устройстве',
  `cordova` varchar(255) DEFAULT NULL COMMENT 'Версия cordova js',
  `ip` varchar(20) DEFAULT NULL COMMENT 'IP адрес',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_push_token` (`user_id`,`push_token`),
  UNIQUE KEY `app_uuid` (`app`,`uuid`),
  KEY `model_platform` (`model`,`platform`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_readed_item`
--

CREATE TABLE IF NOT EXISTS `kir_readed_item` (
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `user_id` bigint(11) DEFAULT NULL COMMENT 'Пользователь',
  `entity` varchar(50) DEFAULT NULL COMMENT 'Тип прочитанного объекта',
  `entity_id` int(11) DEFAULT NULL COMMENT 'ID прочитанного объекта',
  `last_id` int(11) DEFAULT NULL COMMENT 'ID последнего прочитанного объекта',
  UNIQUE KEY `site_id_user_id_entity_entity_id` (`site_id`,`user_id`,`entity`,`entity_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_receipt`
--

CREATE TABLE IF NOT EXISTS `kir_receipt` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `sign` varchar(255) DEFAULT NULL COMMENT 'Подпись чека',
  `uniq_id` varchar(255) DEFAULT NULL COMMENT 'Идентификатор транзакции от провайдера',
  `type` enum('sell','sell_refund','sell_correction') NOT NULL COMMENT 'Тип чека',
  `provider` varchar(50) DEFAULT NULL COMMENT 'Провайдер',
  `url` varchar(255) DEFAULT NULL COMMENT 'Ссылка на чек покупателю',
  `dateof` datetime DEFAULT NULL COMMENT 'Дата транзакции',
  `transaction_id` int(11) DEFAULT NULL COMMENT 'ID связанной транзакции',
  `total` decimal(20,2) DEFAULT NULL COMMENT 'Сумма в чеке',
  `status` enum('success','fail','wait') NOT NULL COMMENT 'Статус чека',
  `error` mediumtext COMMENT 'Ошибка',
  `extra` mediumtext COMMENT 'Дополнительное поле для данных',
  PRIMARY KEY (`id`),
  KEY `sign` (`sign`),
  KEY `uniq_id` (`uniq_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_renter`
--

CREATE TABLE IF NOT EXISTS `kir_renter` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `title` varchar(255) DEFAULT NULL COMMENT 'Наименование',
  `short_title` varchar(255) DEFAULT NULL COMMENT 'Краткое наименование',
  `form` varchar(255) DEFAULT NULL COMMENT 'Форма',
  `inn` varchar(255) DEFAULT NULL COMMENT 'ИНН',
  `kpp` int(11) DEFAULT NULL COMMENT 'КПП',
  `orgn` varchar(255) DEFAULT NULL COMMENT 'ОГРН/ОГРНИП',
  `pasport` varchar(255) DEFAULT NULL COMMENT 'Паспортные данные',
  `phone` varchar(255) DEFAULT NULL COMMENT 'Телефон',
  `e_mail` varchar(255) DEFAULT NULL COMMENT 'Email',
  `ur_address` varchar(255) DEFAULT NULL COMMENT 'Юридический адрес',
  `post_address` varchar(255) DEFAULT NULL COMMENT 'Почтовый адрес',
  `position_leader` varchar(255) DEFAULT NULL COMMENT 'Должность руководителя',
  `fio_leader` varchar(255) DEFAULT NULL COMMENT 'ФИО руководителя',
  `phone_leader` varchar(255) DEFAULT NULL COMMENT 'Телефон руководителя',
  `email_leader` varchar(255) DEFAULT NULL COMMENT 'Email руководителя',
  `fio_accountant` varchar(255) DEFAULT NULL COMMENT 'ФИО Бухгалтера',
  `phone_accountant` varchar(255) DEFAULT NULL COMMENT 'Телефон бухгалтера',
  `email_accountant` varchar(255) DEFAULT NULL COMMENT 'Email бухгалтера',
  `balance` double DEFAULT NULL COMMENT 'Баланс',
  `login` varchar(255) DEFAULT NULL COMMENT 'Логин',
  `password` varchar(255) DEFAULT NULL COMMENT 'Пароль',
  `start_balance` double DEFAULT NULL COMMENT 'Стартовый баланс арендатора',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_renter`
--

INSERT INTO `kir_renter` (`id`, `title`, `short_title`, `form`, `inn`, `kpp`, `orgn`, `pasport`, `phone`, `e_mail`, `ur_address`, `post_address`, `position_leader`, `fio_leader`, `phone_leader`, `email_leader`, `fio_accountant`, `phone_accountant`, `email_accountant`, `balance`, `login`, `password`, `start_balance`) VALUES
(1, 'Общество с ограниченной ответственностью &quot;Круть&quot;', 'ООО &quot;Круть&quot;', 'ooo', '1234567891', 123456, '2147483647', '', '', '', '', '', '', '', '', '', '', '', '', 0, 'krut', '123456', NULL),
(2, 'Красильникова Юлия Александровна', 'Красильникова Ю.А.', 'fiz', '0', 0, '0', '2520 № 885594 выдан 25.02.2021 года ГУ МВД России по Иркутской области, к/п 380-022. ', '', '', '', '', '', '', '', '', '', '', '', 0, 'Krasilnikova_U_A', '4Cs7iRUJ', 0),
(3, 'Общество с ограниченной ответственностью &quot;Проект-Инвест&quot;', 'ООО «Проект-Ивест»', 'ooo', '2147483647', 253901001, '2147483647', '', '', '', '', '', 'Директор', 'Снигерев Кирилл Сергеевич', '', '', '', '', '', 0, 'OOO_Proekt-Invest', 'tc5HM9Yn', 0),
(4, 'Общество с ограниченной ответственностью &quot;Бриз&quot;', 'ООО &quot;Бриз&quot;', 'ooo', '2147483647', 380501001, '2147483647', '', '', '', '665709, Иркутская обл., г. Братск, ж/р Энергетик, строение П', '665709, Иркутская обл., г. Братск, ж/р Энергетик, строение П', 'Директор', 'Конышен Роман Анатольевич', '', '', '', '', '', 0, 'OOO_Briz', 'BSpjYx0Z', 0),
(5, 'Общество с ограниченной ответственностью &quot;Алькор&quot;', 'ООО &quot;Алькор&quot;', 'ooo', '2147483647', 381801001, '2147483647', '', '+7-964-288-91-86', 'slava258@yandex.ru', '666780, Иркутская область, г. Усть-Кут, ул. Калинина д. 4, пом. 51', '666780, Иркутская область, г. Усть-Кут, ул. Строительная 5-49', 'Директор', 'Наумов Вячеслав Михайлович', '', '', '', '', '', 0, 'OOO_Alkor', '0ZcAq6uy', 0),
(6, 'Урадовских Кристина Владимировна', 'Урадовских К.В.', 'fiz', '0', 0, '0', '', '', '', 'Иркутская области, Жигаловский район, пос. Жигалово, ул. Каландарашвили, д. 33', 'Иркутская области, Жигаловский район, пос. Жигалово, ул. Каландарашвили, д. 33', '', '', '', '', '', '', '', 0, 'Uradovskih_K_V', '2yQRcGLq', 0),
(7, 'Общество с ограниченной ответственностью «Лидерстрой»', 'ООО «Лидерстрой»', 'ooo', '2147483647', 312301001, '2147483647', '', '(495) 580-28-10', '', '308013   г. Белгород   ул. Макаренко 25, помещение 11', '308013   г. Белгород   ул. Макаренко 25, помещение 11', 'Генеральный директор', 'Шевелёв Артём Александрович', '', '', '', '', '', 0, 'OOO_Liderstroy', '1obMfDs8', 0),
(8, 'Общество с ограниченной ответственностью &quot;ТрансРегион&quot;', 'ООО &quot;ТрансРегион&quot;', 'ooo', '2147483647', 381001001, '2147483647', '', '+7952-611-66-03', 'transreqion2017@vandex.ru', '666780, Иркутская обл., г. Усть-Кут, ул. Кирова, 18, каб. 105', '666780, Иркутская обл., г. Усть-Кут, ул. Кирова, 18, каб. 105', 'Директор', 'Антипина Марина Леонидовна', '', '', '', '', '', 0, 'OOO_Transregion', 'TpiThvvZ', 0),
(9, 'Общество с ограниченной ответственностью «ПКО Аркон»', 'ООО «ПКО Аркон»', 'ooo', '2147483647', 381801001, '0', '', '', '', '666784, Иркутская область, г. Усть-Кут, ул. Реброва-Денисова, д. 17', '666784, Иркутская область, г. Усть-Кут, ул. Реброва-Денисова, д. 17', 'Директор', 'Кузнецова Людмила Георгиевна', '', '', '', '', '', 0, 'OOO_Arkon', 'gDv9Uq3A', 0),
(10, 'Индивидуальный предприниматель Куликова Татьяна Сергеевна', 'ИП Куликова Т.С.', 'ip', '2147483647', 0, '0', '', '', '', '', '', '', '', '', '', '', '', '', 0, 'Kulikova_T_S', 'hinU6xa1', -14300),
(11, 'Сокольская Зинаида Владимировна', 'Сокольская З.В.', 'fiz', '0', 0, '0', '2506 № 722107 выдан 18.10.2006 ОВД города Усть-Кута Иркутской области, к/п 382-017', '', '', '666784, Иркутская область, г. Усть-Кут, ул. Калинина, д. 4, кв. 40', '666784, Иркутская область, г. Усть-Кут, ул. Калинина, д. 4, кв. 40', '', '', '', '', '', '', '', 0, 'Sokolskaya_Z_V', '1gaQT10j', 0),
(12, 'Общество с ограниченной ответственностью «ЛЕВИТЭК»', 'ООО «ЛЕВИТЭК»', 'ooo', '2147483647', 772201001, '1027720007369', '', '+7(495) 150-33-65', 'reception@levitek.ru', '109029, г. Москва, проезд Автомобильный, дом 4, строение 1, этаж 3, кабинет 13-12', '109029, г. Москва, проезд Автомобильный, дом 4, строение 1, этаж 3, кабинет 13-12', '', '', '', '', '', '', '', 0, 'OOO_Levitek', 'oDnE8C5j', 0),
(13, 'Общество с ограниченной ответственностью «ЛенаСибУголь» ', 'ООО «ЛенаСибУголь»', 'ooo', '2147483647', 381801001, '1193850021474', '', '', '', '666784, Иркутская обл., г. Усть-Кут, ул. Кирова, д.18, оф.212', '666784, Иркутская обл., г. Усть-Кут, ул. Кирова, д.18, оф.212', '', '', '', '', '', '', '', 0, 'OOO_Lenasibugol', 'TXycYDnE', 0),
(14, 'Общество с ограниченной ответственностью «Сервис Групп»', 'ООО «Сервис Групп»', 'ooo', '2147483647', 381801001, '1145009006031', '', '+7 964 283 4306', 'zhajvoronok@esfg.co', 'Россия, 666788, Иркутская область, город Усть-Кут, ул. 2-я Лесная, дом 33', 'Россия, 666788, Иркутская область, город Усть-Кут, ул. 2-я Лесная, дом 33', '', '', '', '', '', '', '', 0, 'OOO_ServiceGroup', '4Sdxo3QP', 0),
(15, 'Общество с ограниченной ответственностью &quot;Кастор&quot;', 'ООО &quot;Кастор&quot;', 'ooo', '2147483647', 381801001, '1145658338528', '', '+7(926)-628-09-78', 'p_masalov@kastor-group.ru', '666780, Иркутская область, г. Усть-Кут, ул. Кирова 18, оф. 410-411', '666780, Иркутская область, г. Усть-Кут, ул. Кирова 18, оф. 410-411', '', '', '', '', '', '', '', 0, 'OOO_Kastor', 'fulqteig', 0),
(16, 'Общество с ограниченной ответственностью &quot;СибНедра&quot; ', 'ООО &quot;СибНедра&quot;', 'ooo', '2147483647', 381001001, '1183850010871', '', '+7-904-156-35-35', 'Sib_nedra@bk.ru', '666784, Иркутская область, г. Усть-Кут, ул. Кирова, д. 93', '666784, Иркутская область, г. Усть-Кут, ул. Кирова, д. 93', '', '', '', '', '', '', '', 0, 'OOO_Sibnedra', 'FIRQLlTB', 39465),
(17, 'Общество с ограниченной ответственностью «ЛАККИ»', 'ООО «ЛАККИ»', 'ooo', '2147483647', 381801001, '1203800021721', '', '', 'lakki-ustk@yandex.ru', '666784, Иркутская область, г. Усть-Кут, ул. Кирова, д. 18', '666784, Иркутская область, г. Усть-Кут, ул. Кирова, д. 18', '', '', '', '', '', '', '', 0, 'OOO_Lakki', 'DO2Vqyq0', 0),
(18, 'Общество с ограниченной ответственностью &quot;Гарант&quot;', 'ООО &quot;Гарант&quot;', 'ooo', '2147483647', 381801001, '1153850050144', '', '8(39565) 5-42-07', '', '666780, Россия, Иркутская область, город Усть-Кут, улица Кирова, дом 18', '666780, Россия, Иркутская область, город Усть-Кут, улица Кирова, дом 18', '', '', '', '', '', '', '', 0, 'OOO_Garant', '61YnKCKg', 0),
(19, 'Индивидуальный предприниматель Помигалов Игорь Юрьевич', 'ИП Помигалов И.Ю.', 'ip', '381800446003', 0, '307381836100010', '', '8 (964) 215-09-11', '', '', '', '', '', '', '', '', '', '', NULL, 'Pomigalov_I_U', '8ZHuE3hi', 0),
(20, 'Индивидуальный предприниматель Атанасова М.И.', 'ИП Атанасова М.И.', 'ip', '381804077734', 0, '309381821700045', '', '', '', '', '', '', '', '', '', '', '', '', NULL, 'Atanasova_M', 'St1XSOAC', 0),
(21, 'Пожарская Екатерина Андреевна', 'Пожарская Е.А.', 'fiz', '', 0, '', '2513 881238, выдан 21.10.2013г. Отделением УФМС России по Иркутской области в гор. Усть-Куте, к/п 380-030', '', '', 'Иркутская область, г. Усть-Кут, ул. Речников, д. 17 «а», кв. 55 ', 'Иркутская область, г. Усть-Кут, ул. Речников, д. 17 «а», кв. 55 ', '', '', '', '', '', '', '', NULL, 'Pogarskaya_EA', 'KYwua8ES', 0),
(22, 'Винокурова Евгения Валерьевна', 'Винокурова Е.В.', 'fiz', '', 0, '', '2506 № 801168 выдан 20.03.2007г. Отделом Внутренних Дел города Усть-Кута Иркутской области, к/п 382-017', '', '', 'Иркутская область, город Усть-Кут, улица Кирова, дом 44, квартира 25', 'Иркутская область, город Усть-Кут, улица Кирова, дом 44, квартира 25', '', '', '', '', '', '', '', NULL, 'Vinokurova_EV', 'ykGtob9e', 0),
(23, 'Кудряшова Наталья Викторовна', 'Кудряшова Н.В.', 'fiz', '', 0, '', '2503 № 965141 выдан 03.09.2003 г. Отделом внутренних дел г. Усть-Кута Иркутской области, к/п 382-017', '', '', 'г. Усть-Кут, пер. Комсомольской, д. 1 корп. А, кв. 56', 'г. Усть-Кут, пер. Комсомольской, д. 1 корп. А, кв. 56', '', '', '', '', '', '', '', NULL, 'Kudryshova_NV', 'gJLatJ3P', 0),
(24, 'Маркелова Дарья Дмитриевна', 'Маркелова Д.Д.', 'fiz', '', 0, '', 'серия 2514 № 984534 выдан 02.09.2014г. Отделом УФМС России по Иркутской области в гор. Усть-Куте, к/п 380-030', '', '', 'Иркутская область, г. Усть-Кут, ул. Кирова, д. 16, кв. 26', 'Иркутская область, г. Усть-Кут, ул. Кирова, д. 16, кв. 26', '', '', '', '', '', '', '', NULL, 'Markelova_DD', 'Ok7sbGid', 0),
(25, 'Швецова Юлия Андреевна', 'Швецова Ю.А.', 'fiz', '', 0, '', 'серия 2516 № 338529 выдан 14.12.2016г. Отделом УФМС России по Иркутской области в гор. Усть-Куте, к/п 380-030', '', '', 'Иркутская область, г. Усть-Кут, ул. Декабристов, д. 17, кв. 6', 'Иркутская область, г. Усть-Кут, ул. Декабристов, д. 17, кв. 6', '', '', '', '', '', '', '', NULL, 'Shvecova_UA', 'RVWKANHq', 0),
(26, 'Добролюбова Наталья Александровна', 'Добролюбова Н.А.', 'fiz', '', 0, '', '2501 583196 выдан 30.06.2001 г. Отделом внутренних дел города Усть-Кута Иркутской области, к/п 382-017', '', '', 'Иркутская область, г. Усть-Кут, ул. Кирова, д. 42 «а», кв. 14', 'Иркутская область, г. Усть-Кут, ул. Кирова, д. 42 «а», кв. 14', '', '', '', '', '', '', '', NULL, 'Dobrolubova_NA', '8rKMT0hF', 0),
(27, 'Федотова Ирина Витальевна', 'Федотова И.В.', 'fiz', '', 0, '', '2510 № 490942 выдан 03.03.2011 г. Отделением УФМС России по Иркутской области в гор. Усть-Куте, к/п 380-030', '', '', 'Иркутская область, гор. Усть-Кут, ул. Кедровая, д. 5, кв. 55  ', 'Иркутская область, гор. Усть-Кут, ул. Кедровая, д. 5, кв. 55  ', '', '', '', '', '', '', '', NULL, 'Fedotova_IV', 'bGGKjWhT', 0),
(28, 'Иванченко Ксения Ивановна', 'Иванченко К.И.', 'fiz', '', 0, '', '2509 № 125736 выдан 24.07.2009 г. ТП УФМС России по Иркутской области в Казачинско-Ленском р-не, к/п 380-036', '', '', 'Иркутская область, гор. Усть-Кут, улица Володарского, дом 73, квартира 34', 'Иркутская область, гор. Усть-Кут, улица Володарского, дом 73, квартира 34', '', '', '', '', '', '', '', NULL, 'Ivanchenko_K', 'phbYlb3B', 0),
(29, 'Дубкова Наталья Сергеевна', 'Дубкова Н.С.', 'fiz', '', 0, '', '2509 № 357034 выдан 11.06.2010 г. Отделением УФМС России по Иркутской области в гор. Усть-Куте, к/п 380-030', '', '', 'Иркутская область, г. Усть-Кут, ул. Речников, д. 38, кв. 80', 'Иркутская область, г. Усть-Кут, ул. Речников, д. 38, кв. 80', '', '', '', '', '', '', '', NULL, 'Dubkova_NS', 'E49FG6X3', 0),
(30, 'ЧАСТНОЕ УЧРЕЖДЕНИЕ ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ ИРКУТСКИЙ ГУМАНИТАРНО-ТЕХНИЧЕСКИСКИЙ КОЛЛЕДЖ (г. УСТЬ-КУТ)', 'ЧУ ПО ИГТК', 'other', '3811181875', 381101001, '1143850032644', '', '8 (39565)50282', '', '', '', '', '', '', '', '', '', '', NULL, 'IGTK', 'DVe31gcM', 0),
(31, 'Купрякова Алёна Александровна', 'Купрякова А.А.', 'fiz', '', 0, '', 'серия 2510 № 406684, выдан 13.08.2010 г. Отделением УФМС России по Иркутской области в гор. Усть-Куте', '', '', 'Иркутская обл., гор. Усть-Кут, ул. Куйбышева, дом 11', 'Иркутская обл., гор. Усть-Кут, ул. Куйбышева, дом 11', '', '', '', '', '', '', '', NULL, 'Kupryakova_AA', 'WOg8NmjD', 0),
(32, 'Общество с ограниченной ответственностью &quot;КасСервис&quot;', 'ООО &quot;КасСервис&quot;', 'ooo', '3818047090', 381801001, '1163850065873', '', '8-908-658-85-25', 'meg74@bk.ru', '66780, Иркутская область, город Усть-Кут, улица Кирова, дом 18, корпус А, квартира 26', '66780, Иркутская область, город Усть-Кут, улица Кирова, дом 18, корпус А, квартира 26', 'Директор', 'Малуш Елена Геннадьевна', '', '', '', '', '', NULL, 'KasService', 'ZzH4BIVS', 0),
(33, 'Исаков Роман Иванович', 'Исаков Р.И.', 'fiz', '', 0, '', 'серия 2504 № 041249 выдан 14.10.2003 г. Отделом Внутренних Дел г. Усть-Кута Иркутской области, к/п 382-017', '', '', 'Иркутская область,  г. Усть-Кут, ул. Хабарова д. 36', 'Иркутская область,  г. Усть-Кут, ул. Хабарова д. 36', '', '', '', '', '', '', '', NULL, 'Isakov_RI', 'r5OmK7lS', 0),
(34, 'Попова Кристина Александровна', 'Попова К.А.', 'fiz', '', 0, '', '2511 № 638684 выдан 18.01.2012 г. Отделением УФМС России по Иркутской области в гор. Усть-Куте, к/п 380-030', '', '', '', '', '', '', '', '', '', '', '', NULL, 'Popova_KA', 'HJjTJf45', 0),
(35, 'Индивидуальный предприниматель Горбунова Ольга Владимировна', 'ИП Горбунова О.В.', 'ip', '381806143213', 0, '309381801100060', '', '8(964)223-44-21', 'Olga200782@mail.ru', 'Иркутская область, г. Усть-Кут, ул. Кирова, д. 34А, кв. 4', 'Иркутская область, г. Усть-Кут, ул. Кирова, д. 34А, кв. 4', '', '', '', '', '', '', '', NULL, 'Gorbunova_OV', 'TjbUjzch', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `kir_room`
--

CREATE TABLE IF NOT EXISTS `kir_room` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `number` varchar(255) DEFAULT NULL COMMENT 'Номер офиса',
  `number_scheme` varchar(255) DEFAULT NULL COMMENT 'Номер помещения на схеме',
  `square` double DEFAULT NULL COMMENT 'Площадь',
  `floor` int(11) DEFAULT NULL COMMENT 'Этаж',
  `free` int(11) DEFAULT '1' COMMENT 'Свободно',
  `need_repair` int(11) DEFAULT '0' COMMENT 'Требуется ремонт',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_room`
--

INSERT INTO `kir_room` (`id`, `number`, `number_scheme`, `square`, `floor`, `free`, `need_repair`) VALUES
(1, '100', '7', 5.8, 1, 1, 1),
(2, '101', '17', 11.3, 1, 0, 0),
(3, '102', '18', 12.4, 1, 0, 0),
(4, '103', '19', 25.6, 1, 1, 0),
(5, '103а', '20', 16.4, 1, 1, 0),
(6, '104', '1', 23.6, 1, 1, 0),
(7, '105', '2', 34.2, 1, 1, 0),
(8, '106', '3,4', 35.4, 1, 1, 0),
(9, '107', '8/1', 18.6, 1, 1, 0),
(10, '108', '8/2', 19, 1, 1, 0),
(11, '109', '8/3', 13, 1, 1, 0),
(12, '110а', '9', 20.9, 1, 1, 0),
(13, '110', '13,14', 25.8, 1, 1, 0),
(14, '111', '15', 12.4, 1, 1, 0),
(15, '112', '16', 12.4, 1, 1, 0),
(16, '201', '10,11', 22, 2, 1, 0),
(17, '202', '12', 12.4, 2, 1, 0),
(18, '203', '13', 12.2, 2, 1, 0),
(19, '204', '6/1', 14, 2, 1, 0),
(20, '205', '6/2', 14, 2, 1, 0),
(21, '206', '6/3', 15, 2, 1, 0),
(22, '207', '7', 20.7, 2, 1, 0),
(23, '208', '14', 11.8, 2, 1, 0),
(24, '209', '21', 12.9, 2, 1, 0),
(25, '210', '20', 12.9, 2, 1, 0),
(26, '211', '19', 12.5, 2, 1, 0),
(27, '212', '17', 9.8, 2, 1, 0),
(28, '213', '18', 5.1, 2, 1, 0),
(29, '214', '1', 41.2, 2, 1, 0),
(30, '215', '2', 12.3, 2, 1, 0),
(31, '216', '4', 17.2, 2, 1, 0),
(32, '217', '5', 16.5, 2, 1, 0),
(33, '301', '4', 17.1, 3, 1, 0),
(34, '401', '9', 11.9, 4, 1, 0),
(35, '402', '11', 20.2, 4, 1, 0),
(36, '403', '12', 13.2, 4, 1, 0),
(37, '404', '13', 11.9, 4, 1, 0),
(38, '405', '14', 11.9, 4, 1, 0),
(39, '406', '15', 11.5, 4, 1, 0),
(40, '407', '16', 38.7, 4, 1, 0),
(41, '408', '17', 11.9, 4, 1, 0),
(42, '409', '18', 13.6, 4, 1, 0),
(43, '410', '1', 24.1, 4, 1, 0),
(44, '411', '2', 17.3, 4, 1, 0),
(45, '412', '3', 17.9, 4, 1, 0),
(46, '413', '4', 35.4, 4, 1, 0),
(47, '414', '8', 35.2, 4, 1, 0),
(48, '415', '5', 24.1, 4, 1, 0),
(49, '416', '6, 7', 50, 4, 1, 0),
(50, '110б', '', 0, 1, 1, 0),
(51, '307', '12', 23.3, 3, 0, 0),
(52, '308', '13', 12.2, 3, 1, 0),
(53, '309', '14', 12.4, 3, 0, 0),
(54, '310', '15', 12.2, 3, 1, 0),
(55, '312', '17', 15.5, 3, 1, 0),
(56, '313', '1', 21.8, 3, 1, 0),
(57, '314', '2', 17.4, 3, 1, 0),
(58, '315,316', '3', 53.7, 3, 1, 0),
(59, '302', '5,6,19', 53.1, 3, 1, 0),
(60, '304', '8', 12.6, 3, 1, 0),
(61, '305', '9,10', 39, 3, 1, 0),
(62, '306', '11', 12.2, 3, 1, 0),
(63, '008', '1', 69.4, 0, 1, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `kir_search_index`
--

CREATE TABLE IF NOT EXISTS `kir_search_index` (
  `result_class` varchar(100) NOT NULL COMMENT 'Класс результата',
  `entity_id` int(11) NOT NULL COMMENT 'id сущности',
  `title` varchar(255) DEFAULT NULL COMMENT 'Заголовок результата',
  `indextext` mediumtext COMMENT 'Описание сущности (индексируемый)',
  `dateof` datetime DEFAULT NULL COMMENT 'Дата добавления в индекс',
  PRIMARY KEY (`result_class`,`entity_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_sections`
--

CREATE TABLE IF NOT EXISTS `kir_sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `page_id` varchar(255) DEFAULT NULL COMMENT 'Страница',
  `parent_id` int(11) DEFAULT NULL COMMENT 'Родительская секция',
  `alias` varchar(255) DEFAULT NULL COMMENT 'Название секции для автоматической вставки модулей',
  `width_xs` int(5) DEFAULT NULL COMMENT 'Ширина (XS)',
  `width_sm` int(5) DEFAULT NULL COMMENT 'Ширина (SM)',
  `width` int(5) DEFAULT NULL COMMENT 'Ширина',
  `width_lg` int(5) DEFAULT NULL COMMENT 'Ширина',
  `width_xl` int(5) DEFAULT NULL COMMENT 'Ширина',
  `inset_align_xs` varchar(255) DEFAULT NULL COMMENT 'Горизонтальное выравнивание',
  `inset_align_sm` varchar(255) DEFAULT NULL COMMENT 'Горизонтальное выравнивание',
  `inset_align` varchar(255) DEFAULT NULL COMMENT 'Горизонтальное выравнивание',
  `inset_align_lg` varchar(255) DEFAULT NULL COMMENT 'Горизонтальное выравнивание',
  `inset_align_xl` varchar(255) DEFAULT NULL COMMENT 'Горизонтальное выравнивание',
  `align_items_xs` varchar(255) DEFAULT NULL COMMENT 'Вертикальное выравнивание',
  `align_items_sm` varchar(255) DEFAULT NULL COMMENT 'Вертикальное выравнивание',
  `align_items` varchar(255) DEFAULT NULL COMMENT 'Вертикальное выравнивание',
  `align_items_lg` varchar(255) DEFAULT NULL COMMENT 'Вертикальное выравнивание',
  `align_items_xl` varchar(255) DEFAULT NULL COMMENT 'Вертикальное выравнивание',
  `prefix_xs` int(11) DEFAULT NULL COMMENT 'Отступ слева (XS)',
  `prefix_sm` int(11) DEFAULT NULL COMMENT 'Отступ слева (SM)',
  `prefix` int(11) DEFAULT NULL COMMENT 'Отступ слева (prefix)',
  `prefix_lg` int(11) DEFAULT NULL COMMENT 'Остступ слева (offset)',
  `prefix_xl` int(11) DEFAULT NULL COMMENT 'Остступ слева (offset)',
  `suffix` int(11) DEFAULT NULL COMMENT 'Отступ справа (suffix)',
  `pull_xs` int(11) DEFAULT NULL COMMENT 'Сдвиг влево (xs)',
  `pull_sm` int(11) DEFAULT NULL COMMENT 'Сдвиг влево (sm)',
  `pull` int(11) DEFAULT NULL COMMENT 'Сдвиг влево (pull)',
  `pull_lg` int(11) DEFAULT NULL COMMENT 'Сдвиг влево (pull)',
  `pull_xl` int(11) DEFAULT NULL COMMENT 'Сдвиг влево (pull)',
  `push_xs` int(11) DEFAULT NULL COMMENT 'Сдвиг вправо (xs)',
  `push_sm` int(11) DEFAULT NULL COMMENT 'Сдвиг вправо (sm)',
  `push` int(11) DEFAULT NULL COMMENT 'Сдвиг вправо (push)',
  `push_lg` int(11) DEFAULT NULL COMMENT 'Сдвиг вправо (push)',
  `push_xl` int(11) DEFAULT NULL COMMENT 'Сдвиг вправо (push)',
  `order_xs` int(5) DEFAULT NULL COMMENT 'Порядок',
  `order_sm` int(5) DEFAULT NULL COMMENT 'Порядок',
  `order` int(5) DEFAULT NULL COMMENT 'Порядок',
  `order_lg` int(5) DEFAULT NULL COMMENT 'Порядок',
  `order_xl` int(5) DEFAULT NULL COMMENT 'Порядок',
  `css_class` varchar(255) DEFAULT NULL COMMENT 'Пользовательский CSS класс',
  `is_clearfix_after` int(1) DEFAULT NULL COMMENT 'Очистка после элемента(clearfix)',
  `clearfix_after_css` varchar(150) DEFAULT NULL COMMENT 'Пользовательский CSS класс для clearfix',
  `inset_template` varchar(255) DEFAULT NULL COMMENT 'Внутренний шаблон',
  `outside_template` varchar(255) DEFAULT NULL COMMENT 'Внешний шаблон',
  `element_type` enum('col','row') NOT NULL COMMENT 'Тип элемента',
  `sortn` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=171 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_section_containers`
--

CREATE TABLE IF NOT EXISTS `kir_section_containers` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `page_id` int(11) DEFAULT NULL,
  `columns` int(11) DEFAULT NULL COMMENT 'Ширина',
  `title` varchar(255) DEFAULT NULL COMMENT 'Название',
  `css_class` varchar(255) DEFAULT NULL COMMENT 'CSS класс',
  `is_fluid` int(1) NOT NULL COMMENT 'Ширина 100%',
  `wrap_element` varchar(255) DEFAULT NULL COMMENT 'Внешний элемент',
  `wrap_css_class` varchar(255) DEFAULT NULL COMMENT 'CSS-класс оборачивающего блока',
  `outside_template` varchar(255) DEFAULT NULL COMMENT 'Внешний шаблон',
  `inside_template` varchar(255) DEFAULT NULL COMMENT 'Внутренний шаблон',
  `type` int(5) DEFAULT NULL COMMENT 'Порядковый номер контейнера на странице',
  PRIMARY KEY (`id`),
  KEY `page_id` (`page_id`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_section_context`
--

CREATE TABLE IF NOT EXISTS `kir_section_context` (
  `site_id` int(11) NOT NULL COMMENT 'ID сайта',
  `context` varchar(50) NOT NULL COMMENT 'Контекст темы оформления',
  `grid_system` enum('none','gs960','bootstrap','bootstrap4') NOT NULL COMMENT 'Тип сеточного фреймворка',
  `options` mediumtext COMMENT 'Настройки темы в сериализованном виде',
  PRIMARY KEY (`site_id`,`context`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_section_context`
--

INSERT INTO `kir_section_context` (`site_id`, `context`, `grid_system`, `options`) VALUES
(1, 'theme', 'none', 'a:11:{s:21:\"enable_one_click_cart\";s:1:\"1\";s:15:\"enable_favorite\";s:1:\"1\";s:14:\"enable_compare\";s:1:\"1\";s:15:\"enable_comments\";s:1:\"1\";s:13:\"phone_number1\";s:15:\"8-800-000-00-00\";s:18:\"phone_description1\";s:31:\"Интернет-магазин\";s:13:\"phone_number2\";s:15:\"8-800-000-00-01\";s:18:\"phone_description2\";s:26:\"Тех. поддержка\";s:29:\"enable_amount_in_product_card\";i:0;s:16:\"enable_page_fade\";i:0;s:22:\"cat_description_bottom\";i:0;}');

-- --------------------------------------------------------

--
-- Структура таблицы `kir_section_modules`
--

CREATE TABLE IF NOT EXISTS `kir_section_modules` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `page_id` int(11) DEFAULT NULL COMMENT 'Страница',
  `section_id` int(11) DEFAULT NULL COMMENT 'ID секции',
  `template_block_id` bigint(11) DEFAULT NULL COMMENT 'id блока в теме без сетки',
  `context` varchar(50) DEFAULT NULL COMMENT 'Дополнительный идентификатор темы',
  `module_controller` varchar(150) DEFAULT NULL COMMENT 'Модуль',
  `public` int(1) DEFAULT '1' COMMENT 'Публичный',
  `sortn` int(11) DEFAULT NULL,
  `params` mediumtext COMMENT 'Параметры',
  PRIMARY KEY (`id`),
  KEY `context` (`context`),
  KEY `page_id` (`page_id`)
) ENGINE=MyISAM AUTO_INCREMENT=123 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_section_page`
--

CREATE TABLE IF NOT EXISTS `kir_section_page` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `route_id` varchar(255) NOT NULL COMMENT 'Маршрут',
  `context` varchar(32) DEFAULT NULL COMMENT 'Дополнительный идентификатор темы',
  `template` varchar(255) DEFAULT NULL COMMENT 'Шаблон',
  `inherit` int(1) DEFAULT '1' COMMENT 'Наследовать шаблон по-умолчанию?',
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_id_route_id_context` (`site_id`,`route_id`,`context`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_section_page`
--

INSERT INTO `kir_section_page` (`id`, `site_id`, `route_id`, `context`, `template`, `inherit`) VALUES
(30, 1, 'main.index', 'theme', 'theme:kirova18/index.tpl', 1),
(29, 1, 'default', 'theme', 'theme:kirova18/wrapper.tpl', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `kir_sites`
--

CREATE TABLE IF NOT EXISTS `kir_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `title` varchar(255) DEFAULT NULL COMMENT 'Краткое название сайта',
  `full_title` varchar(255) DEFAULT NULL COMMENT 'Полное название сайта',
  `domains` mediumtext COMMENT 'Доменные имена (через запятую)',
  `folder` varchar(255) DEFAULT NULL COMMENT 'Папка сайта',
  `language` varchar(255) DEFAULT NULL COMMENT 'Язык',
  `default` int(11) DEFAULT NULL COMMENT 'По умолчанию',
  `redirect_to_main_domain` int(11) NOT NULL COMMENT 'Перенаправлять на основной домен',
  `redirect_to_https` int(11) NOT NULL COMMENT 'Перенаправлять на https',
  `sortn` int(11) DEFAULT NULL COMMENT 'Сортировка',
  `is_closed` int(11) DEFAULT NULL COMMENT 'Закрыть доступ к сайту',
  `close_message` varchar(255) DEFAULT NULL COMMENT 'Причина закрытия сайта',
  `rating` decimal(3,1) DEFAULT '0.0' COMMENT 'Средний балл(рейтинг)',
  `comments` int(11) DEFAULT '0' COMMENT 'Кол-во комментариев к сайту',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_sites`
--

INSERT INTO `kir_sites` (`id`, `title`, `full_title`, `domains`, `folder`, `language`, `default`, `redirect_to_main_domain`, `redirect_to_https`, `sortn`, `is_closed`, `close_message`, `rating`, `comments`) VALUES
(1, 'Сайт kirova.local', 'Сайт kirova.local', 'kirova.local', NULL, 'ru', 1, 0, 0, 1, NULL, NULL, '0.0', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `kir_site_options`
--

CREATE TABLE IF NOT EXISTS `kir_site_options` (
  `site_id` int(11) NOT NULL COMMENT 'ID сайта',
  `admin_email` varchar(150) DEFAULT NULL COMMENT 'E-mail администратора(ов)',
  `admin_phone` varchar(150) DEFAULT NULL COMMENT 'Телефон администратора',
  `theme` varchar(150) DEFAULT NULL COMMENT 'Тема',
  `favicon` varchar(255) DEFAULT NULL COMMENT 'Иконка сайта 16x16 (PNG, ICO)',
  `favicon_svg` varchar(255) DEFAULT NULL COMMENT 'Иконка сайта в формате SVG',
  `logo` varchar(200) DEFAULT NULL COMMENT 'Логотип',
  `slogan` varchar(255) DEFAULT NULL COMMENT 'Лозунг',
  `firm_name` varchar(255) DEFAULT NULL COMMENT 'Наименование организации',
  `firm_inn` varchar(12) DEFAULT NULL COMMENT 'ИНН организации',
  `firm_kpp` varchar(12) DEFAULT NULL COMMENT 'КПП организации',
  `firm_bank` varchar(255) DEFAULT NULL COMMENT 'Наименование банка',
  `firm_bik` varchar(10) DEFAULT NULL COMMENT 'БИК',
  `firm_rs` varchar(20) DEFAULT NULL COMMENT 'Расчетный счет',
  `firm_ks` varchar(20) DEFAULT NULL COMMENT 'Корреспондентский счет',
  `firm_director` varchar(70) DEFAULT NULL COMMENT 'Фамилия, инициалы руководителя',
  `firm_accountant` varchar(70) DEFAULT NULL COMMENT 'Фамилия, инициалы главного бухгалтера',
  `firm_v_lice` varchar(255) DEFAULT NULL COMMENT 'Компания представлена в лице ...',
  `firm_deistvuet` varchar(255) DEFAULT NULL COMMENT 'действует на основании ...',
  `firm_address` varchar(255) DEFAULT NULL COMMENT 'Фактический адрес компании',
  `firm_legal_address` varchar(255) DEFAULT NULL COMMENT 'Юридический адрес компании',
  `firm_email` varchar(255) DEFAULT NULL COMMENT 'Официальный Email компании',
  `notice_from` varchar(255) DEFAULT NULL COMMENT 'Будет указано в письме в поле  ''От''',
  `notice_reply` varchar(255) DEFAULT NULL COMMENT 'Куда присылать ответные письма? (поле Reply)',
  `smtp_is_use` int(11) DEFAULT NULL COMMENT 'Использовать SMTP для отправки писем',
  `smtp_host` varchar(255) DEFAULT NULL COMMENT 'SMTP сервер',
  `smtp_port` varchar(10) DEFAULT NULL COMMENT 'SMTP порт',
  `smtp_secure` varchar(255) DEFAULT NULL COMMENT 'Тип шифрования',
  `smtp_auth` int(11) DEFAULT NULL COMMENT 'Требуется авторизация на SMTP сервере',
  `smtp_username` varchar(100) DEFAULT NULL COMMENT 'Имя пользователя SMTP',
  `smtp_password` varchar(100) DEFAULT NULL COMMENT 'Пароль SMTP',
  `dkim_is_use` int(11) DEFAULT NULL COMMENT 'Устанавливать DKIM подпись с помощью ReadyScript',
  `dkim_domain` varchar(255) DEFAULT NULL COMMENT 'DKIM домен',
  `dkim_private` varchar(255) DEFAULT NULL COMMENT 'Приватный ключ DKIM',
  `dkim_selector` varchar(255) DEFAULT NULL COMMENT 'Селектор DKIM записи в доменной зоне',
  `dkim_passphrase` varchar(255) DEFAULT NULL COMMENT 'Пароль для приватного ключа (если есть)',
  `facebook_group` varchar(255) DEFAULT NULL COMMENT 'Ссылка на группу в Facebook',
  `vkontakte_group` varchar(255) DEFAULT NULL COMMENT 'Ссылка на группу ВКонтакте',
  `twitter_group` varchar(255) DEFAULT NULL COMMENT 'Ссылка на страницу в Twitter',
  `instagram_group` varchar(255) DEFAULT NULL COMMENT 'Ссылка на страницу в Instagram',
  `youtube_group` varchar(255) DEFAULT NULL COMMENT 'Ссылка на страницу в YouTube',
  `viber_group` varchar(255) DEFAULT NULL COMMENT 'Ссылка на Viber',
  `telegram_group` varchar(255) DEFAULT NULL COMMENT 'Ссылка на Telegram',
  `whatsapp_group` varchar(255) DEFAULT NULL COMMENT 'Ссылка на WhatsApp',
  `policy_personal_data` mediumtext COMMENT 'Политика обработки персональных данных (ссылка /policy/)',
  `agreement_personal_data` mediumtext COMMENT 'Соглашение на обработку персональных данных (ссылка /policy-agreement/)',
  `enable_agreement_personal_data` int(11) DEFAULT NULL COMMENT 'Включить отображение соглашения на обработку персональных данных в формах',
  `firm_name_for_notice` varchar(255) DEFAULT NULL COMMENT 'Наименование организации в письмах',
  PRIMARY KEY (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_site_options`
--

INSERT INTO `kir_site_options` (`site_id`, `admin_email`, `admin_phone`, `theme`, `favicon`, `favicon_svg`, `logo`, `slogan`, `firm_name`, `firm_inn`, `firm_kpp`, `firm_bank`, `firm_bik`, `firm_rs`, `firm_ks`, `firm_director`, `firm_accountant`, `firm_v_lice`, `firm_deistvuet`, `firm_address`, `firm_legal_address`, `firm_email`, `notice_from`, `notice_reply`, `smtp_is_use`, `smtp_host`, `smtp_port`, `smtp_secure`, `smtp_auth`, `smtp_username`, `smtp_password`, `dkim_is_use`, `dkim_domain`, `dkim_private`, `dkim_selector`, `dkim_passphrase`, `facebook_group`, `vkontakte_group`, `twitter_group`, `instagram_group`, `youtube_group`, `viber_group`, `telegram_group`, `whatsapp_group`, `policy_personal_data`, `agreement_personal_data`, `enable_agreement_personal_data`, `firm_name_for_notice`) VALUES
(1, '', '', 'kirova18(blue)', NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, '', '', '', 0, NULL, NULL, 0, '', NULL, '', '', '', '', '', '', '', '', '', '', '', '', 0, '');

-- --------------------------------------------------------

--
-- Структура таблицы `kir_subscribe_email`
--

CREATE TABLE IF NOT EXISTS `kir_subscribe_email` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `email` varchar(250) DEFAULT NULL COMMENT 'E-mail',
  `dateof` datetime DEFAULT NULL COMMENT 'Дата подписки',
  `confirm` int(1) DEFAULT '0' COMMENT 'Подтверждён?',
  `signature` varchar(250) DEFAULT NULL COMMENT 'Подпись для E-mail',
  PRIMARY KEY (`id`),
  KEY `email_confirm` (`email`,`confirm`),
  KEY `signature` (`signature`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_support`
--

CREATE TABLE IF NOT EXISTS `kir_support` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `topic` varchar(255) DEFAULT NULL COMMENT 'Тема',
  `user_id` int(11) DEFAULT NULL COMMENT 'Пользователь',
  `dateof` datetime DEFAULT NULL COMMENT 'Дата отправки',
  `message` mediumtext COMMENT 'Сообщение',
  `processed` int(1) DEFAULT NULL COMMENT 'Флаг прочтения',
  `is_admin` int(1) DEFAULT NULL COMMENT 'Это администратор',
  `topic_id` int(11) DEFAULT NULL COMMENT 'ID темы',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_support_topic`
--

CREATE TABLE IF NOT EXISTS `kir_support_topic` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `title` varchar(255) DEFAULT NULL COMMENT 'Тема',
  `user_id` bigint(11) DEFAULT NULL COMMENT 'Пользователь',
  `updated` datetime DEFAULT NULL COMMENT 'Дата обновления',
  `msgcount` int(11) DEFAULT NULL COMMENT 'Всего сообщений',
  `newcount` int(11) DEFAULT NULL COMMENT 'Новых сообщений',
  `newadmcount` int(11) DEFAULT NULL COMMENT 'Новых для администратора',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_tags_links`
--

CREATE TABLE IF NOT EXISTS `kir_tags_links` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `word_id` bigint(11) DEFAULT NULL COMMENT 'ID тега',
  `type` varchar(20) DEFAULT NULL COMMENT 'Тип связи',
  `link_id` int(11) DEFAULT NULL COMMENT 'ID объекта, с которым связан тег',
  PRIMARY KEY (`id`),
  UNIQUE KEY `word_id_type_link_id` (`word_id`,`type`,`link_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_tags_words`
--

CREATE TABLE IF NOT EXISTS `kir_tags_words` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `stemmed` varchar(255) DEFAULT NULL COMMENT 'Тег без окончания',
  `word` varchar(255) DEFAULT NULL COMMENT 'Тег',
  `alias` varchar(255) DEFAULT NULL COMMENT 'Английское название тега',
  PRIMARY KEY (`id`),
  UNIQUE KEY `alias` (`alias`),
  KEY `stemmed` (`stemmed`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_testmodule_kirova`
--

CREATE TABLE IF NOT EXISTS `kir_testmodule_kirova` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `title` varchar(255) DEFAULT NULL COMMENT 'Название',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_tpl_hook_sort`
--

CREATE TABLE IF NOT EXISTS `kir_tpl_hook_sort` (
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `context` varchar(100) DEFAULT NULL COMMENT 'Контекст темы оформления',
  `hook_name` varchar(100) DEFAULT NULL COMMENT 'Идентификатор хука',
  `module` varchar(50) DEFAULT NULL COMMENT 'Идентификатор модуля',
  `sortn` varchar(255) DEFAULT NULL COMMENT 'Порядковый номер',
  UNIQUE KEY `site_id_context_hook_name_module` (`site_id`,`context`,`hook_name`,`module`),
  KEY `sortn` (`sortn`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_tpl_hook_sort`
--

INSERT INTO `kir_tpl_hook_sort` (`site_id`, `context`, `hook_name`, `module`, `sortn`) VALUES
(1, 'theme', 'catalog-product:rating', 'custom', '0'),
(1, 'theme', 'catalog-product:rating', 'demo', '1'),
(1, 'theme', 'catalog-product:images', 'test', '1'),
(1, 'theme', 'catalog-product:images', 'testbuy', '0');

-- --------------------------------------------------------

--
-- Структура таблицы `kir_transaction`
--

CREATE TABLE IF NOT EXISTS `kir_transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `dateof` datetime DEFAULT NULL COMMENT 'Дата транзакции',
  `creator_user_id` int(11) DEFAULT NULL COMMENT 'Создатель транзакции',
  `user_id` bigint(11) DEFAULT NULL COMMENT 'Пользователь',
  `order_id` int(11) DEFAULT NULL COMMENT 'ID заказа',
  `personal_account` int(1) DEFAULT NULL COMMENT 'Транзакция изменяющая баланс лицевого счета',
  `cost` decimal(15,2) DEFAULT NULL COMMENT 'Сумма',
  `comission` decimal(15,2) DEFAULT NULL COMMENT 'Сумма комиссии платежной системы',
  `payment` int(11) DEFAULT NULL COMMENT 'Тип оплаты',
  `saved_payment_method_id` int(11) DEFAULT NULL COMMENT 'id сохранённого способа оплаты',
  `reason` mediumtext COMMENT 'Назначение платежа',
  `error` varchar(255) DEFAULT NULL COMMENT 'Ошибка',
  `status` enum('new','hold','success','fail') NOT NULL COMMENT 'Статус транзакции',
  `receipt` enum('no_receipt','receipt_in_progress','receipt_success','refund_success','fail') NOT NULL DEFAULT 'no_receipt' COMMENT 'Последний статус получения чека',
  `sign` varchar(255) DEFAULT NULL COMMENT 'Подпись транзакции',
  `entity` varchar(50) DEFAULT NULL COMMENT 'Сущность к которой привязана транзакция',
  `entity_id` varchar(50) DEFAULT NULL COMMENT 'ID сущности, к которой привязана транзакция',
  `processors` varchar(255) DEFAULT NULL COMMENT 'Процессоры транзакции',
  `extra` varchar(4096) DEFAULT NULL COMMENT 'Дополнительное поле для данных',
  `cashregister_last_operation_uuid` varchar(255) DEFAULT NULL COMMENT 'Последний уникальный идентификатор полученный в ответ от кассы',
  PRIMARY KEY (`id`),
  KEY `entity_entity_id` (`entity`,`entity_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_transaction_changelog`
--

CREATE TABLE IF NOT EXISTS `kir_transaction_changelog` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `transaction_id` int(11) DEFAULT NULL COMMENT 'id транзакции',
  `date` datetime DEFAULT NULL COMMENT 'Дата изменения',
  `change` varchar(255) DEFAULT NULL COMMENT 'Изменение',
  `entity_type` varchar(255) DEFAULT NULL COMMENT 'Тип связанной сущности',
  `entity_id` int(11) DEFAULT NULL COMMENT 'id связанной сущности',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_try_auth`
--

CREATE TABLE IF NOT EXISTS `kir_try_auth` (
  `ip` varchar(255) NOT NULL COMMENT 'IP-адрес',
  `total` int(11) DEFAULT NULL COMMENT 'Количество попыток авторизации',
  `last_try_dateof` datetime DEFAULT NULL COMMENT 'Дата последней попытки авторизации',
  `try_login` varchar(255) DEFAULT NULL COMMENT 'Логин, последней попытки авторизации',
  PRIMARY KEY (`ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_try_auth`
--

INSERT INTO `kir_try_auth` (`ip`, `total`, `last_try_dateof`, `try_login`) VALUES
('37.29.40.180', 3, '2022-01-20 09:07:04', 'Ирина Федотова'),
('95.215.125.184', 3, '2022-02-04 10:27:44', 'OOO_Garant'),
('176.59.133.54', 2, '2022-01-20 11:03:49', 'Kudryshova_NV'),
('80.83.237.39', 2, '2022-02-02 04:56:44', 'Sokolskaya _Z_V');

-- --------------------------------------------------------

--
-- Структура таблицы `kir_users`
--

CREATE TABLE IF NOT EXISTS `kir_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `name` varchar(100) DEFAULT NULL COMMENT 'Имя',
  `surname` varchar(100) DEFAULT NULL COMMENT 'Фамилия',
  `midname` varchar(100) DEFAULT NULL COMMENT 'Отчество',
  `e_mail` varchar(150) DEFAULT NULL COMMENT 'E-mail',
  `login` varchar(64) DEFAULT NULL COMMENT 'Логин',
  `pass` varchar(32) DEFAULT NULL COMMENT 'Пароль',
  `phone` varchar(50) DEFAULT NULL COMMENT 'Телефон',
  `sex` varchar(1) DEFAULT NULL COMMENT 'Пол',
  `hash` varchar(64) DEFAULT NULL COMMENT 'Ключ',
  `subscribe_on` int(1) DEFAULT NULL COMMENT 'Получать рассылку',
  `dateofreg` datetime DEFAULT NULL COMMENT 'Дата регистрации',
  `balance` decimal(15,2) NOT NULL COMMENT 'Баланс',
  `balance_sign` varchar(255) DEFAULT NULL COMMENT 'Подпись баланса',
  `ban_expire` datetime DEFAULT NULL COMMENT 'Заблокировать до ...',
  `ban_reason` varchar(255) DEFAULT NULL COMMENT 'Причина блокировки',
  `last_visit` datetime DEFAULT NULL COMMENT 'Последний визит',
  `last_ip` varchar(100) DEFAULT NULL COMMENT 'Последний IP, который использовался',
  `registration_ip` varchar(100) DEFAULT NULL COMMENT 'IP пользователя при регистрации',
  `is_enable_two_factor` int(11) NOT NULL COMMENT 'Включить двухфакторную авторизацию для данного пользователя',
  `is_company` int(1) DEFAULT NULL COMMENT 'Это юридическое лицо?',
  `company` varchar(255) DEFAULT NULL COMMENT 'Название организации',
  `company_inn` varchar(12) DEFAULT NULL COMMENT 'ИНН организации',
  `_serialized` mediumtext,
  `cost_id` varchar(1000) DEFAULT NULL COMMENT 'Персональная цена (сериализованная)',
  `manager_user_id` int(11) NOT NULL COMMENT 'Менеджер пользователя',
  `basket_min_limit` decimal(20,2) DEFAULT NULL COMMENT 'Минимальная сумма заказа (в базовой валюте)',
  `full_name` varchar(255) DEFAULT NULL COMMENT 'Полное наименование',
  `short_name` varchar(255) DEFAULT NULL COMMENT 'Короткое наименование',
  `form` varchar(255) DEFAULT 'ip' COMMENT 'Форма собственности',
  `inn` int(11) DEFAULT NULL COMMENT 'ИНН',
  `kpp` int(11) DEFAULT NULL COMMENT 'КПП',
  `ogrn` int(11) DEFAULT NULL COMMENT 'ОГРН/ОГРНИП',
  `uridich_address` varchar(255) DEFAULT NULL COMMENT 'Юридический адрес',
  `post_address` varchar(255) DEFAULT NULL COMMENT 'Почтовый адрес',
  `bank_name` varchar(255) DEFAULT NULL COMMENT 'Наименование банка',
  `bank_bik` varchar(255) DEFAULT NULL COMMENT 'БИК',
  `bank_rs` varchar(255) DEFAULT NULL COMMENT 'Расчетный счет',
  `bank_ks` varchar(255) DEFAULT NULL COMMENT 'Кор. счет',
  `chief_fio` varchar(255) DEFAULT NULL COMMENT 'ФИО Директора',
  `chief_position` varchar(255) DEFAULT NULL COMMENT 'Должность Директора',
  `chief_document` varchar(255) DEFAULT NULL COMMENT 'Документ основане',
  `buh_fio` varchar(255) DEFAULT NULL COMMENT 'ФИО Бухгалтера',
  `buh_phone` varchar(255) DEFAULT NULL COMMENT 'Телефон Бухгалтера',
  `is_admin` int(11) DEFAULT NULL COMMENT 'Админ',
  `renter_id` int(11) DEFAULT NULL COMMENT 'Арендатор',
  PRIMARY KEY (`id`),
  UNIQUE KEY `login` (`login`),
  KEY `hash` (`hash`),
  KEY `manager_user_id` (`manager_user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_users`
--

INSERT INTO `kir_users` (`id`, `name`, `surname`, `midname`, `e_mail`, `login`, `pass`, `phone`, `sex`, `hash`, `subscribe_on`, `dateofreg`, `balance`, `balance_sign`, `ban_expire`, `ban_reason`, `last_visit`, `last_ip`, `registration_ip`, `is_enable_two_factor`, `is_company`, `company`, `company_inn`, `_serialized`, `cost_id`, `manager_user_id`, `basket_min_limit`, `full_name`, `short_name`, `form`, `inn`, `kpp`, `ogrn`, `uridich_address`, `post_address`, `bank_name`, `bank_bik`, `bank_rs`, `bank_ks`, `chief_fio`, `chief_position`, `chief_document`, `buh_fio`, `buh_phone`, `is_admin`, `renter_id`) VALUES
(1, 'Супервизор', 'Кононович', 'Новый', '92279@inbox.ru', '92279@inbox.ru', 'e0892bf642ef4260a141b76a96d6c6c5', '+79183192279', '', '226491a982f611d66c1fa2ef6e5bdcd23606ec482f05601eb9c567f739bf18de', 0, '2021-05-24 09:44:39', '0.00', NULL, NULL, '', '2022-02-15 09:05:18', '93.88.24.48', '127.0.0.1', 0, 0, '', '', 'a:0:{}', 'a:1:{i:1;s:1:\"0\";}', 0, '0.00', '', '', 'ip', 0, 0, 0, '', '', '', '', '', '', '', '', '', '', '', 1, NULL),
(42, NULL, NULL, NULL, NULL, 'OOO_Lakki', '404a373f800cc3117c0e1dd0c5a1dcd0', NULL, NULL, 'f1ed266533277227b1bad1eb54443ac64cc3f1b282bdac0252ad0a2a702eb7f3', NULL, '2021-12-27 11:08:42', '0.00', NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Общество с ограниченной ответственностью «ЛАККИ»', 'ООО «ЛАККИ»', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 17),
(41, NULL, NULL, NULL, NULL, 'OOO_Sibnedra', '9404bd19afd4b4acf01b8971d47d0fb0', NULL, NULL, 'aa1073fb6ee3cb35719664137dd75dcb7f3f7e648fc5d9f1f47035d775b44ba0', NULL, '2021-12-27 11:08:42', '0.00', NULL, NULL, NULL, '2021-12-27 21:45:55', '127.0.0.1', '127.0.0.1', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Общество с ограниченной ответственностью &quot;СибНедра&quot; ', 'ООО &quot;СибНедра&quot;', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 16),
(40, NULL, NULL, NULL, NULL, 'OOO_Kastor', '35a49ce5c5ce82ed52a82c6379e79dd0', NULL, NULL, '04283dff637e298e1502ca36df88ff0b32a3bc2502915d67edd9ac92a1ddb10e', NULL, '2021-12-27 11:08:42', '0.00', NULL, NULL, NULL, '2022-02-15 04:36:44', '185.184.233.132', '127.0.0.1', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Общество с ограниченной ответственностью &quot;Кастор&quot;', 'ООО &quot;Кастор&quot;', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 15),
(39, NULL, NULL, NULL, NULL, 'OOO_ServiceGroup', '6e16950ac8720493b3a46bcf5609a721', NULL, NULL, '0741694d9a6e314ca6ec7609152a15360386b43e5a49a6aa6fc578fba42db210', NULL, '2021-12-27 11:08:42', '0.00', NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Общество с ограниченной ответственностью «Сервис Групп»', 'ООО «Сервис Групп»', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 14),
(38, NULL, NULL, NULL, NULL, 'OOO_Lenasibugol', '66d5ff3feb57eaa0cf7e3be2899c0e4f', NULL, NULL, '9c6c6afb013136433af5e3dc7c827c89d3feb0f1b7894f40e431c9b6fc3e42f1', NULL, '2021-12-27 11:08:42', '0.00', NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Общество с ограниченной ответственностью «ЛенаСибУголь» ', 'ООО «ЛенаСибУголь»', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 13),
(37, NULL, NULL, NULL, NULL, 'OOO_Levitek', 'a610c6cb71c256ba808eb2335f402a4e', NULL, NULL, '83dd761d2b9e6a586349cbea2dffd1d8a4db2191b1bbdd1a31a261eb16855c63', NULL, '2021-12-27 11:08:42', '0.00', NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Общество с ограниченной ответственностью «ЛЕВИТЭК»', 'ООО «ЛЕВИТЭК»', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 12),
(36, NULL, NULL, NULL, NULL, 'Sokolskaya_Z_V', '649421e2b600926d06bc1c01d03d1a66', NULL, NULL, '59c1e3c7ebc91cd7a15845a19f5aa81b95c103e620b5dc389d6e15cffe036b71', NULL, '2021-12-27 11:08:42', '0.00', NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Сокольская Зинаида Владимировна', 'Сокольская З.В.', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 11),
(35, NULL, NULL, NULL, NULL, 'Kulikova_T_S', 'e9e816ccd31712c0026ab0f2209030bf', NULL, NULL, 'e4145d2446ae8422d87d58b0fcb39e09afdd0cc9fe2a98085f7642d8873b60e5', NULL, '2021-12-27 11:08:42', '0.00', NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Индивидуальный предприниматель Куликова Татьяна Сергеевна', 'ИП Куликова Т.С.', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 10),
(34, NULL, NULL, NULL, NULL, 'OOO_Arkon', 'a04bd04fd94d27d1c96635e92e90828d', NULL, NULL, 'e8b9caf5d040e8ba2b8ec1f2e5b93575d75c19d6f14232b04edc696cbda0ad60', NULL, '2021-12-27 11:08:42', '0.00', NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Общество с ограниченной ответственностью «ПКО Аркон»', 'ООО «ПКО Аркон»', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 9),
(33, NULL, NULL, NULL, NULL, 'OOO_Transregion', '6c263ffd46694cb97b56215c6a42c755', NULL, NULL, '433119805afc24aac7a55bbf63ced08da94cac8fa189466c90a63c0032f238db', NULL, '2021-12-27 11:08:42', '0.00', NULL, NULL, NULL, '2022-02-09 09:42:29', '185.184.233.245', '127.0.0.1', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Общество с ограниченной ответственностью &quot;ТрансРегион&quot;', 'ООО &quot;ТрансРегион&quot;', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 8),
(32, NULL, NULL, NULL, NULL, 'OOO_Liderstroy', '0fc87dccb21b88004d23b45de343bad2', NULL, NULL, '24c5beb6fd1d533eeb63806ee427dccb39f7ca1e41c2e908079af4aeebb26fd5', NULL, '2021-12-27 11:08:42', '0.00', NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Общество с ограниченной ответственностью «Лидерстрой»', 'ООО «Лидерстрой»', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 7),
(31, NULL, NULL, NULL, NULL, 'Uradovskih_K_V', 'b5448a8ec5fd9a3ef39d5e9110540d0d', NULL, NULL, 'a2e460b44aa9dc4e50bd470b9d2d7ce735ccf390631d984064545e4e3646462a', NULL, '2021-12-27 11:08:42', '0.00', NULL, NULL, NULL, '2022-02-05 05:29:28', '95.215.124.23', '127.0.0.1', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Урадовских Кристина Владимировна', 'Урадовских К.В.', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 6),
(30, NULL, NULL, NULL, NULL, 'OOO_Alkor', '53df756596fe97ad7f058762aa5aa209', NULL, NULL, 'bba49a2e9dcd038dd9366ca4a1768d2c757b52cb76c5297bd8b4f62d1128510a', NULL, '2021-12-27 11:08:42', '0.00', NULL, NULL, NULL, '2022-02-11 06:37:30', '85.115.243.59', '127.0.0.1', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Общество с ограниченной ответственностью &quot;Алькор&quot;', 'ООО &quot;Алькор&quot;', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 5),
(29, NULL, NULL, NULL, NULL, 'OOO_Briz', '6a487752a577f614c5a060958077c761', NULL, NULL, '52b916714fa71059cc7a87d915059543c84692a8a80a2e58516b43db5a59a008', NULL, '2021-12-27 11:08:42', '0.00', NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Общество с ограниченной ответственностью &quot;Бриз&quot;', 'ООО &quot;Бриз&quot;', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 4),
(28, NULL, NULL, NULL, NULL, 'OOO_Proekt-Invest', 'da525c882a12b1ff0e13ff1991d82274', NULL, NULL, '671f5364f77b4bc23d4eb6aa09697ff9926fea29397ce34e4867f00bd9f9d583', NULL, '2021-12-27 11:08:42', '0.00', NULL, NULL, NULL, '2022-02-08 04:03:54', '185.184.233.189', '127.0.0.1', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Общество с ограниченной ответственностью &quot;Проект-Инвест&quot;', 'ООО «Проект-Ивест»', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 3),
(27, NULL, NULL, NULL, NULL, 'Krasilnikova_U_A', '4b251abb72d029edb6b90e4e94f9ee03', NULL, NULL, '3590e06abe5c7f86a4ccfae5ea3ef38697aed1337de60f91ef63a82014f77cd3', NULL, '2021-12-27 11:08:42', '0.00', NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Красильникова Юлия Александровна', 'Красильникова Ю.А.', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 2),
(26, NULL, NULL, NULL, NULL, 'krut', 'c32729918f4117d13c62f77583ada33d', NULL, NULL, 'f6c729c08f938477419e8ac542e840c6152c2a2361c8d54f4ab1b643854f25be', NULL, '2021-12-27 11:08:42', '0.00', NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Общество с ограниченной ответственностью &quot;Круть&quot;', 'ООО &quot;Круть&quot;', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1),
(43, NULL, NULL, NULL, NULL, 'OOO_Garant', '9aabd23ea2369d38f5ecda2050ec452e', NULL, NULL, 'dbb4fec26c346da37496f83abe0236d15095571a6f2f3842cb4f9e168bb8e894', NULL, '2021-12-27 11:08:42', '0.00', NULL, NULL, NULL, '2022-02-10 17:11:42', '176.59.131.2', '127.0.0.1', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Общество с ограниченной ответственностью &quot;Гарант&quot;', 'ООО &quot;Гарант&quot;', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 18),
(44, NULL, NULL, NULL, NULL, 'Pomigalov_I_U', 'e87a62edd448db02c3e41fc527248706', NULL, NULL, '87fe0f2a88b0b245b1bb7100752520d18cff1f57206d0d5c8f68626377b22c11', NULL, '2021-12-27 11:08:42', '0.00', NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Индивидуальный предприниматель Помигалов Игорь Юрьевич', 'ИП Помигалов И.Ю.', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 19),
(45, NULL, NULL, NULL, NULL, 'Atanasova_M', '411f953a098d786c00fcf6333364eb54', NULL, NULL, '0f0a9cdc5f87ed3249b1ed608b732ce1229ac26eb9a78a4d2647f3f865b2f51a', NULL, '2022-01-20 00:16:21', '0.00', NULL, NULL, NULL, NULL, NULL, '178.155.4.244', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Индивидуальный предприниматель Атанасова М.И.', 'ИП Атанасова М.И.', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 20),
(46, NULL, NULL, NULL, NULL, 'Pogarskaya_EA', '2aaff60d0d17617ef72e7d9dee2e9bcd', NULL, NULL, '7d274e3c8a25afd3a0e8ced5da08ce4ca2346853abebcb28247d807baffde57d', NULL, '2022-01-20 00:31:10', '0.00', NULL, NULL, NULL, '2022-02-07 08:18:42', '95.215.126.113', '178.155.4.244', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Пожарская Екатерина Андреевна', 'Пожарская Е.А.', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 21),
(47, NULL, NULL, NULL, NULL, 'Vinokurova_EV', '271dad65b7c08bedb2cee2a4337ceff0', NULL, NULL, '9ce939babd113cd3122bc9e82b005ce0909b4423db56f427558e5bd15557f356', NULL, '2022-01-20 00:38:38', '0.00', NULL, NULL, NULL, NULL, NULL, '178.155.4.244', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Винокурова Евгения Валерьевна', 'Винокурова Е.В.', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 22),
(48, NULL, NULL, NULL, NULL, 'Kudryshova_NV', '3ac491e8d87d8ba6b3790b3e9cf8ce14', NULL, NULL, '5612c1e7597f682e11ab3c53f055283582d3525ec0a79fd6b88ca45376b4c638', NULL, '2022-01-20 00:48:48', '0.00', NULL, NULL, NULL, NULL, NULL, '178.155.4.244', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Кудряшова Наталья Викторовна', 'Кудряшова Н.В.', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 23),
(49, NULL, NULL, NULL, NULL, 'Markelova_DD', '9c497ee90beacd43383609adffcf22b1', NULL, NULL, 'b6cbf1a4fda0e7491b8fb34b6046a6d5ab64193f6460fe2f1b4c6321c7395309', NULL, '2022-01-20 00:58:27', '0.00', NULL, NULL, NULL, '2022-01-21 06:01:05', '176.59.144.138', '178.155.4.244', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Маркелова Дарья Дмитриевна', 'Маркелова Д.Д.', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 24),
(50, NULL, NULL, NULL, NULL, 'Shvecova_UA', 'c6fe6958e60026c5a1eb1ae35dd8c030', NULL, NULL, '39dda74eee3954b8a27eb95cbfc03a6281c63f8486243cdafa0462eef0d8d17a', NULL, '2022-01-20 01:08:09', '0.00', NULL, NULL, NULL, '2022-02-07 07:51:32', '176.59.137.3', '178.155.4.244', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Швецова Юлия Андреевна', 'Швецова Ю.А.', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 25),
(51, NULL, NULL, NULL, NULL, 'Dobrolubova_NA', 'e47107e2ba37c20a20afdaa136929427', NULL, NULL, 'ef269a71bf696701f6d5eb43ef28ba2e83baf9c3360a309bbd47eed28b728ff8', NULL, '2022-01-20 08:24:31', '0.00', NULL, NULL, NULL, '2022-02-04 10:04:41', '178.155.6.121', '178.155.4.244', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Добролюбова Наталья Александровна', 'Добролюбова Н.А.', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 26),
(52, NULL, NULL, NULL, NULL, 'Fedotova_IV', '163f23502584dc69505eca83e807c9bc', NULL, NULL, '6969e493bf6cbd5356702f8d7f728d8cc22bc63d0f82e5fdab8ce38e0f8e8b62', NULL, '2022-01-20 08:32:05', '0.00', NULL, NULL, NULL, '2022-02-04 11:52:38', '176.114.190.140', '178.155.4.244', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Федотова Ирина Витальевна', 'Федотова И.В.', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 27),
(53, NULL, NULL, NULL, NULL, 'Ivanchenko_K', '1280ad7a6934778826af176ad786bab1', NULL, NULL, '12a995c0eaba68d117c783e49e8c32721390563242f694315e8a87693ad4b022', NULL, '2022-01-20 10:20:17', '0.00', NULL, NULL, NULL, NULL, NULL, '178.155.4.244', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Иванченко Ксения Ивановна', 'Иванченко К.И.', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 28),
(54, NULL, NULL, NULL, NULL, 'Dubkova_NS', 'fb443d1de5e5b1601db0c34b7c05d0e0', NULL, NULL, '10cf0910b300f574027bcbbc2b6d9d10aaa2184bf40ba6e9cc9f2ad2e40bd009', NULL, '2022-01-20 10:32:23', '0.00', NULL, NULL, NULL, '2022-01-31 14:33:15', '37.29.40.12', '178.155.4.244', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Дубкова Наталья Сергеевна', 'Дубкова Н.С.', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 29),
(55, NULL, NULL, NULL, NULL, 'IGTK', 'f89ddf927efc7d741cf7f3a2426ec620', NULL, NULL, '43cd18a34b978067e733d46eb70a32553a809d09cc819a860b3dd16d215629c0', NULL, '2022-01-20 10:50:51', '0.00', NULL, NULL, NULL, NULL, NULL, '178.155.4.244', 0, NULL, NULL, NULL, 'a:0:{}', 'a:0:{}', 0, NULL, 'ЧАСТНОЕ УЧРЕЖДЕНИЕ ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ ИРКУТСКИЙ ГУМАНИТАРНО-ТЕХНИЧЕСКИСКИЙ КОЛЛЕДЖ (г. УСТЬ-КУТ)', 'ЧАСТНОЕ УЧРЕЖДЕНИЕ ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ ИРКУТСКИЙ ГУМАНИТАРНО-ТЕХНИЧЕСКИСКИЙ КОЛЛЕДЖ (г. УСТЬ-КУТ)', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 30),
(56, NULL, NULL, NULL, NULL, 'Kupryakova_AA', 'fffe746d199e2cf4857003b1afa4fcbc', NULL, NULL, '9ec4223adffbe27e8244e3e13013e6d34f46154097eaad7ce71a1097a06aae24', NULL, '2022-02-01 12:16:45', '0.00', NULL, NULL, NULL, '2022-02-07 08:06:42', '178.184.61.141', '178.155.6.35', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Купрякова Алёна Александровна', 'Купрякова А.А.', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 31),
(57, NULL, NULL, NULL, NULL, 'KasService', 'f0d77952c8d5219e92ebc15573169536', NULL, NULL, '95afe5f355e59b725f2f0f1b97d2c39040327364268fe0f16bf02de41b223d7c', NULL, '2022-02-01 14:20:09', '0.00', NULL, NULL, NULL, '2022-02-07 07:59:06', '5.128.87.109', '178.155.6.35', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Общество с ограниченной ответственностью &quot;КасСервис&quot;', 'ООО &quot;КасСервис&quot;', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 32),
(58, NULL, NULL, NULL, NULL, 'Isakov_RI', 'c423b504bfdcdec8dd9fa861a3c2db3d', NULL, NULL, 'e7d8b6f402d98d3326c95bf25a14e7f92b7d554a57dc240c3382319973e4e418', NULL, '2022-02-01 14:32:47', '0.00', NULL, NULL, NULL, NULL, NULL, '178.155.6.35', 0, NULL, NULL, NULL, 'a:0:{}', 'a:0:{}', 0, NULL, 'Исаков Роман Иванович', 'Исаков Роман Иванович', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 33),
(59, NULL, NULL, NULL, NULL, 'Popova_KA', '3869636d25b7dd2865cd299625c88b07', NULL, NULL, '854c73609dfe389800cd482a2f7caee3f61be66dcf780720f18298c3c1e999f1', NULL, '2022-02-01 14:39:36', '0.00', NULL, NULL, NULL, '2022-02-07 14:33:19', '95.215.124.97', '178.155.6.35', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Попова Кристина Александровна', 'Попова К.А.', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 34),
(60, NULL, NULL, NULL, NULL, 'Gorbunova_OV', '45f8e2ffb3b8b8eb269fb7579c8eca64', NULL, NULL, 'd75afbf192b1624331e524e1af340719f91e28209abf8ffd29f853843be9d01d', NULL, '2022-02-01 14:51:38', '0.00', NULL, NULL, NULL, NULL, NULL, '178.155.6.35', 0, NULL, NULL, NULL, 'N;', NULL, 0, NULL, 'Индивидуальный предприниматель Горбунова Ольга Владимировна', 'ИП Горбунова О.В.', 'ip', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 35);

-- --------------------------------------------------------

--
-- Структура таблицы `kir_users_group`
--

CREATE TABLE IF NOT EXISTS `kir_users_group` (
  `alias` varchar(50) NOT NULL COMMENT 'Псевдоним(англ.яз)',
  `name` varchar(100) DEFAULT NULL COMMENT 'Название группы',
  `description` mediumtext COMMENT 'Описание',
  `is_admin` int(1) DEFAULT NULL COMMENT 'Администратор',
  `sortn` int(11) DEFAULT NULL COMMENT 'Сортировочный индекс',
  `cost_id` varchar(1000) DEFAULT NULL COMMENT 'Персональная цена (сериализованная)',
  `basket_min_limit` decimal(20,2) DEFAULT NULL COMMENT 'Минимальная сумма заказа (в базовой валюте)',
  PRIMARY KEY (`alias`),
  KEY `sortn` (`sortn`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_users_group`
--

INSERT INTO `kir_users_group` (`alias`, `name`, `description`, `is_admin`, `sortn`, `cost_id`, `basket_min_limit`) VALUES
('supervisor', 'Супервизоры', 'Пользователь имеющий доступ абсолютно всегда ко всем  модулям и сайтам', 1, 1, NULL, NULL),
('admins', 'Администраторы', 'Пользователи, имеющие права на удаление, добавление, изменение контента', 1, 2, NULL, NULL),
('clients', 'Клиенты', 'Авторизованные пользователи', 0, 3, NULL, NULL),
('guest', 'Гости', 'Неавторизованные пользователи', 0, 4, NULL, NULL),
('renter', 'Арендатор', 'Арендаторы', 0, 5, 'a:1:{i:1;s:1:\"0\";}', '0.00');

-- --------------------------------------------------------

--
-- Структура таблицы `kir_users_in_group`
--

CREATE TABLE IF NOT EXISTS `kir_users_in_group` (
  `user` int(11) NOT NULL COMMENT 'ID пользователя',
  `group` varchar(255) NOT NULL COMMENT 'ID группы пользователей',
  PRIMARY KEY (`user`,`group`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_users_in_group`
--

INSERT INTO `kir_users_in_group` (`user`, `group`) VALUES
(1, 'admins'),
(1, 'renter'),
(1, 'supervisor');

-- --------------------------------------------------------

--
-- Структура таблицы `kir_users_log`
--

CREATE TABLE IF NOT EXISTS `kir_users_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `dateof` datetime DEFAULT NULL COMMENT 'Дата',
  `class` varchar(255) DEFAULT NULL COMMENT 'Класс события',
  `oid` int(11) DEFAULT NULL COMMENT 'ID объекта над которым произошло событие',
  `group` int(11) DEFAULT NULL COMMENT 'ID Группы (перезаписывается, если событие происходит в рамках одной группы)',
  `user_id` bigint(11) DEFAULT NULL COMMENT 'ID Пользователя',
  `_serialized` varchar(4000) DEFAULT NULL COMMENT 'Дополнительные данные (скрыто)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `class_user_id_group` (`class`,`user_id`,`group`),
  KEY `site_id_class` (`site_id`,`class`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_users_log`
--

INSERT INTO `kir_users_log` (`id`, `site_id`, `dateof`, `class`, `oid`, `group`, `user_id`, `_serialized`) VALUES
(8, 1, '2022-01-10 11:09:35', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, -2397875672, 'a:1:{s:2:\"ip\";s:9:\"127.0.0.1\";}'),
(7, 0, '2021-12-27 11:44:45', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, 41, 'a:1:{s:2:\"ip\";s:9:\"127.0.0.1\";}'),
(33, 1, '2022-02-14 04:26:44', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, -254338686, 'a:1:{s:2:\"ip\";s:15:\"185.184.232.113\";}'),
(4, 0, '2021-12-22 10:52:45', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, 2, 'a:1:{s:2:\"ip\";s:9:\"127.0.0.1\";}'),
(5, 1, '2021-12-27 11:03:58', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, -2397875672, 'a:1:{s:2:\"ip\";s:9:\"127.0.0.1\";}'),
(6, 1, '2021-12-27 11:03:59', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, 1, 'a:1:{s:2:\"ip\";s:9:\"127.0.0.1\";}'),
(9, 1, '2022-01-11 13:04:37', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, -2397875672, 'a:1:{s:2:\"ip\";s:9:\"127.0.0.1\";}'),
(10, 0, '2022-01-11 13:27:34', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, 28, 'a:1:{s:2:\"ip\";s:9:\"127.0.0.1\";}'),
(11, 0, '2022-01-17 12:58:01', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, 26, 'a:1:{s:2:\"ip\";s:9:\"127.0.0.1\";}'),
(12, 1, '2022-01-17 13:02:13', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, -2397875672, 'a:1:{s:2:\"ip\";s:9:\"127.0.0.1\";}'),
(13, 1, '2022-01-17 13:09:58', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, -2397875672, 'a:1:{s:2:\"ip\";s:9:\"127.0.0.1\";}'),
(14, 1, '2022-01-19 09:55:11', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, -1572372606, 'a:1:{s:2:\"ip\";s:13:\"178.155.4.244\";}'),
(15, 1, '2022-01-19 10:47:04', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, -1572372606, 'a:1:{s:2:\"ip\";s:13:\"178.155.4.244\";}'),
(16, 1, '2022-01-19 15:58:02', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, -1156762673, 'a:1:{s:2:\"ip\";s:15:\"185.184.232.113\";}'),
(17, 1, '2022-01-19 16:26:27', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, -1864479711, 'a:1:{s:2:\"ip\";s:15:\"185.184.232.113\";}'),
(18, 1, '2022-01-20 03:11:02', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, -857796334, 'a:1:{s:2:\"ip\";s:15:\"185.184.232.113\";}'),
(19, 1, '2022-01-23 07:06:27', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, -2871041299, 'a:1:{s:2:\"ip\";s:15:\"185.184.232.113\";}'),
(20, 1, '2022-01-28 06:47:58', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, -2938295543, 'a:1:{s:2:\"ip\";s:13:\"95.215.126.90\";}'),
(21, 1, '2022-01-31 13:41:55', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, -532385150, 'a:1:{s:2:\"ip\";s:15:\"185.184.232.113\";}'),
(22, 1, '2022-02-01 14:12:41', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, -1572372606, 'a:1:{s:2:\"ip\";s:12:\"178.155.6.35\";}'),
(23, 1, '2022-02-01 15:12:46', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, -1572372606, 'a:1:{s:2:\"ip\";s:12:\"178.155.6.18\";}'),
(24, 1, '2022-02-02 16:28:47', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, -384877269, 'a:1:{s:2:\"ip\";s:15:\"185.184.232.113\";}'),
(25, 1, '2022-02-04 10:04:58', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, -1572372606, 'a:1:{s:2:\"ip\";s:13:\"178.155.6.121\";}'),
(26, 1, '2022-02-04 11:20:46', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, -1572372606, 'a:1:{s:2:\"ip\";s:13:\"178.155.6.121\";}'),
(27, 1, '2022-02-04 12:08:07', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, -1572372606, 'a:1:{s:2:\"ip\";s:13:\"178.155.6.121\";}'),
(28, 1, '2022-02-06 17:13:32', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, -2403272391, 'a:1:{s:2:\"ip\";s:15:\"185.184.232.113\";}'),
(29, 1, '2022-02-07 07:51:21', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, -2657244485, 'a:1:{s:2:\"ip\";s:15:\"185.184.232.113\";}'),
(30, 1, '2022-02-07 14:39:05', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, -4004985342, 'a:1:{s:2:\"ip\";s:15:\"185.184.232.113\";}'),
(31, 1, '2022-02-08 04:28:25', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, -1683736901, 'a:1:{s:2:\"ip\";s:15:\"185.184.232.113\";}'),
(32, 1, '2022-02-10 17:01:17', 'Users\\Model\\Logtype\\AdminAuth', 1, NULL, -1857127347, 'a:1:{s:2:\"ip\";s:15:\"185.184.232.113\";}');

-- --------------------------------------------------------

--
-- Структура таблицы `kir_users_verification_session`
--

CREATE TABLE IF NOT EXISTS `kir_users_verification_session` (
  `uniq` varchar(255) NOT NULL COMMENT 'Уникальный ключ сессии верификации',
  `ip` varchar(50) DEFAULT NULL COMMENT 'IP-адрес пользователя',
  `user_session_id` varchar(255) DEFAULT NULL COMMENT 'ID сессии пользователя',
  `creator_user_id` bigint(11) DEFAULT NULL COMMENT 'Пользователь, создатель сессии',
  `verification_provider` varchar(255) DEFAULT NULL COMMENT 'Идентификатор провайдера доставки кода',
  `phone` varchar(255) DEFAULT NULL COMMENT 'Номер телефона для отправки кода',
  `code_hash` varchar(255) DEFAULT NULL COMMENT 'Хэш от кода верификации',
  `code_debug` varchar(255) DEFAULT NULL COMMENT 'Код врификации в открытом виде (для режима отладки)',
  `code_expire` int(11) DEFAULT NULL COMMENT 'Время истечения действия кода',
  `send_counter` int(11) NOT NULL COMMENT 'Счетчик отправки кодов',
  `send_last_time` int(11) DEFAULT NULL COMMENT 'Последняя дата отправки кода',
  `try_counter` int(11) NOT NULL COMMENT 'Счетчик ввода кодов',
  `try_last_time` int(11) DEFAULT NULL COMMENT 'Последняя дата попытки ввода кода',
  `action` varchar(100) DEFAULT NULL COMMENT 'Идентификатор класса действия',
  `action_data` mediumtext COMMENT 'Данные для действия',
  `last_initialized` int(11) DEFAULT NULL COMMENT 'Последняя дата инициализации сессии',
  `is_resolved` int(1) DEFAULT NULL COMMENT 'Код был введен успешно',
  `resolved_time` int(11) DEFAULT NULL COMMENT 'Время успешного ввода кода',
  PRIMARY KEY (`uniq`),
  KEY `ip_action_is_resolved_last_initialized` (`ip`,`action`,`is_resolved`,`last_initialized`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_warehouse`
--

CREATE TABLE IF NOT EXISTS `kir_warehouse` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `title` varchar(255) DEFAULT NULL COMMENT 'Короткое название',
  `alias` varchar(150) DEFAULT NULL COMMENT 'URL имя',
  `group_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Группа',
  `image` varchar(255) DEFAULT NULL COMMENT 'Картинка',
  `description` mediumtext COMMENT 'Описание',
  `adress` varchar(255) DEFAULT NULL COMMENT 'Адрес',
  `phone` varchar(255) DEFAULT NULL COMMENT 'Телефон',
  `work_time` varchar(255) DEFAULT NULL COMMENT 'Время работы',
  `coor_x` float DEFAULT '55.7533' COMMENT 'Координата X магазина',
  `coor_y` float DEFAULT '37.6226' COMMENT 'Координата Y магазина',
  `default_house` int(1) DEFAULT NULL COMMENT 'Склад по умолчанию',
  `public` int(1) DEFAULT NULL COMMENT 'Показывать склад в карточке товара',
  `checkout_public` int(1) DEFAULT NULL COMMENT 'Показывать склад как пункт самовывоза',
  `dont_change_stocks` int(11) DEFAULT NULL COMMENT 'Не списывать остатки с данного склада',
  `use_in_sitemap` int(11) DEFAULT '0' COMMENT 'Добавлять в sitemap',
  `xml_id` varchar(255) DEFAULT NULL COMMENT 'Идентификатор в системе 1C',
  `sortn` int(11) DEFAULT NULL COMMENT 'Индекс сортировки',
  `meta_title` varchar(1000) DEFAULT NULL COMMENT 'Заголовок',
  `meta_keywords` varchar(1000) DEFAULT NULL COMMENT 'Ключевые слова',
  `meta_description` varchar(1000) DEFAULT NULL COMMENT 'Описание',
  `linked_region_id` int(11) DEFAULT NULL COMMENT 'Город метонахождения',
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_id_xml_id` (`site_id`,`xml_id`),
  UNIQUE KEY `site_id_alias` (`site_id`,`alias`),
  KEY `coor_x_coor_y` (`coor_x`,`coor_y`),
  KEY `alias` (`alias`),
  KEY `public` (`public`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_warehouse`
--

INSERT INTO `kir_warehouse` (`id`, `site_id`, `title`, `alias`, `group_id`, `image`, `description`, `adress`, `phone`, `work_time`, `coor_x`, `coor_y`, `default_house`, `public`, `checkout_public`, `dont_change_stocks`, `use_in_sitemap`, `xml_id`, `sortn`, `meta_title`, `meta_keywords`, `meta_description`, `linked_region_id`) VALUES
(1, 1, 'Основной склад', 'sklad', 0, NULL, '<p>Наш склад находится в центре города. Предусмотрена удобная парковка для автомобилей и велосипедов. </p>', 'г. Краснодар, улица Красных Партизан, 246', '+7(123)456-78-90', 'с 9:00 до 18:00', 45.0483, 38.9745, 1, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `kir_warehouse_group`
--

CREATE TABLE IF NOT EXISTS `kir_warehouse_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `alias` varchar(50) DEFAULT NULL COMMENT 'Идентификатор (англ.яз)',
  `title` varchar(255) DEFAULT NULL COMMENT 'Название',
  `short_description` varchar(255) DEFAULT NULL COMMENT 'Короткое описание',
  `sortn` int(11) DEFAULT NULL COMMENT 'Индекс сортировки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_id_alias` (`site_id`,`alias`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `kir_widgets`
--

CREATE TABLE IF NOT EXISTS `kir_widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор (ID)',
  `site_id` int(11) DEFAULT NULL COMMENT 'ID сайта',
  `user_id` int(11) DEFAULT NULL,
  `mode2_column` int(5) DEFAULT NULL COMMENT 'Колонка виджета в двухколоночной сетке',
  `mode3_column` int(5) DEFAULT NULL COMMENT 'Колонка виджета в трехколоночной сетке',
  `mode1_position` int(5) DEFAULT NULL COMMENT 'Позиция виджета в одноколоночной сетке',
  `mode2_position` int(5) DEFAULT NULL COMMENT 'Позиция виджета в двухколоночной сетке',
  `mode3_position` int(5) DEFAULT NULL COMMENT 'Позиция виджета в трехколоночной сетке',
  `class` varchar(255) DEFAULT NULL,
  `vars` mediumtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_id_user_id_class` (`site_id`,`user_id`,`class`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kir_widgets`
--

INSERT INTO `kir_widgets` (`id`, `site_id`, `user_id`, `mode2_column`, `mode3_column`, `mode1_position`, `mode2_position`, `mode3_position`, `class`, `vars`) VALUES
(1, 1, 1, 2, 2, 0, 0, 2, 'comments-widget-newlist', NULL),
(2, 1, 1, 1, 3, 1, 0, 0, 'users-widget-authlog', NULL),
(3, 1, 1, 2, 2, 2, 1, 1, 'main-widget-bestsellers', NULL),
(4, 1, 1, 2, 2, 3, 2, 3, 'crm-widget-task', NULL),
(5, 1, 1, 2, 2, 4, 3, 0, 'marketplace-widget-newmodules', NULL),
(6, 1, 1, 1, 1, 5, 1, 1, 'notes-widget-notes', NULL),
(7, 1, 1, 1, 1, 6, 2, 0, 'catalog-widget-watchnow', NULL),
(8, 1, 1, 1, 3, 7, 3, 1, 'catalog-widget-oneclick', NULL),
(9, 1, 1, 2, 2, 8, 4, 4, 'shop-widget-sellchart', NULL),
(10, 1, 1, 1, 1, 9, 4, 2, 'shop-widget-lastorders', NULL),
(11, 1, 1, 1, 1, 10, 5, 3, 'shop-widget-orderstatuses', NULL),
(12, 1, 1, 1, 3, 11, 6, 2, 'shop-widget-reservation', NULL);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `kir_search_index`
--
ALTER TABLE `kir_search_index` ADD FULLTEXT KEY `title_indextext` (`title`,`indextext`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
