ALTER TABLE `messages`
    ADD COLUMN `lesson_type`  BIGINT      NULL DEFAULT 1 AFTER `flags`;

ALTER TABLE `events`
    ADD COLUMN `lesson_type`  BIGINT      NULL DEFAULT 1 AFTER `evt_type`;

ALTER TABLE `log_messages`
    ADD COLUMN `lesson_type`  BIGINT      NULL DEFAULT 1 AFTER `message_text`;
