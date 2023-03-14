-- CreateTable
CREATE TABLE `classes` (
    `class_id` INTEGER NOT NULL AUTO_INCREMENT,
    `class_name` VARCHAR(50) NULL,

    PRIMARY KEY (`class_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `courses` (
    `course_id` INTEGER NOT NULL AUTO_INCREMENT,
    `course_name` VARCHAR(50) NULL,
    `teacher_id` INTEGER NULL,
    `class_id` INTEGER NULL,

    INDEX `fk_courses_classes`(`class_id`),
    INDEX `fk_courses_teachers`(`teacher_id`),
    PRIMARY KEY (`course_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `grades` (
    `student_id` INTEGER NOT NULL,
    `course_id` INTEGER NOT NULL,
    `grade` INTEGER NULL,

    INDEX `fk_grades_courses`(`course_id`),
    PRIMARY KEY (`student_id`, `course_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `students` (
    `student_id` INTEGER NOT NULL AUTO_INCREMENT,
    `first_name` VARCHAR(50) NULL,
    `last_name` VARCHAR(50) NULL,
    `gender` ENUM('F', 'M') NULL,
    `class_id` INTEGER NULL,
    `email` VARCHAR(255) NULL,

    UNIQUE INDEX `unique_email_students`(`email`),
    INDEX `fk_students_classes`(`class_id`),
    PRIMARY KEY (`student_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `teachers` (
    `teacher_id` INTEGER NOT NULL AUTO_INCREMENT,
    `first_name` VARCHAR(50) NULL,
    `last_name` VARCHAR(50) NULL,
    `gender` ENUM('F', 'M') NULL,
    `email` VARCHAR(255) NULL,

    UNIQUE INDEX `unique_email_teachers`(`email`),
    PRIMARY KEY (`teacher_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `courses` ADD CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teachers`(`teacher_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `courses` ADD CONSTRAINT `courses_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `classes`(`class_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `grades` ADD CONSTRAINT `fk_grades_courses` FOREIGN KEY (`course_id`) REFERENCES `courses`(`course_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `grades` ADD CONSTRAINT `fk_grades_students` FOREIGN KEY (`student_id`) REFERENCES `students`(`student_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `students` ADD CONSTRAINT `fk_students_classes` FOREIGN KEY (`class_id`) REFERENCES `classes`(`class_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

