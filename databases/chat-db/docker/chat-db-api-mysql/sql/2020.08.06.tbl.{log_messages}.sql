USE `chat_history`;

DROP TABLE IF EXISTS `log_messages`;

CREATE TABLE IF NOT EXISTS `log_messages`
(
    id           BIGINT UNSIGNED            NOT NULL PRIMARY KEY AUTO_INCREMENT,
    message_id   BIGINT UNSIGNED            NOT NULL,
    lesson_id    BIGINT UNSIGNED            NOT NULL,
    message_text TEXT                       NOT NULL, # (!) TEXT columns can not have DEFAULT values in MySQL
    created_at   TIMESTAMP                  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_message_id` (`message_id`)
) ENGINE = InnoDB,
  CHARACTER SET = utf8,
  COLLATE = utf8_unicode_ci;

ALTER TABLE `messages`
    ADD COLUMN `updated_at`  TIMESTAMP      NULL AFTER `created_at`;
