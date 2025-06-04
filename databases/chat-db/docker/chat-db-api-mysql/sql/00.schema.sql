USE `chat_history`;

DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages`
(
    id           BIGINT UNSIGNED            NOT NULL PRIMARY KEY AUTO_INCREMENT,
    lesson_id    BIGINT UNSIGNED            NOT NULL,
    trainer_id   BIGINT UNSIGNED            NOT NULL,
    student_id   BIGINT UNSIGNED            NOT NULL,
    sender       ENUM ('student','trainer') NOT NULL,
    message_text TEXT                       NOT NULL, # (!) TEXT columns can not have DEFAULT values in MySQL
    flags        BIGINT                     NOT NULL DEFAULT 0,
    created_at   TIMESTAMP                  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_lesson_id` (`lesson_id`)
) ENGINE = InnoDB,
  CHARACTER SET = utf8,
  COLLATE = utf8_unicode_ci;

DROP TABLE IF EXISTS `events`;
CREATE TABLE `events`
(
    id         BIGINT UNSIGNED            NOT NULL PRIMARY KEY AUTO_INCREMENT,
    lesson_id  BIGINT UNSIGNED            NOT NULL,
    trainer_id BIGINT UNSIGNED            NOT NULL,
    student_id BIGINT UNSIGNED            NOT NULL,
    sender     ENUM ('student','trainer') NOT NULL,
    evt_type   BIGINT UNSIGNED            NOT NULL,
    created_at TIMESTAMP                  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_lesson_id` (`lesson_id`)
) ENGINE = InnoDB,
  CHARACTER SET = utf8,
  COLLATE = utf8_unicode_ci;
