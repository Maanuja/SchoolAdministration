-- Create tables
CREATE TABLE classes (
    class_id INT PRIMARY KEY AUTO_INCREMENT,
    class_name VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender ENUM('F', 'M'),
    class_id INT,
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
) ENGINE=InnoDB;

CREATE TABLE teachers (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender ENUM('F', 'M')
) ENGINE=InnoDB;

CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(50),
    teacher_id INT,
    class_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id),
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
) ENGINE=InnoDB;

CREATE TABLE grades (
    student_id INT,
    course_id INT,
    grade INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
) ENGINE=InnoDB;

-- Add constraints
ALTER TABLE students ADD CONSTRAINT fk_students_classes
    FOREIGN KEY (class_id) REFERENCES classes(class_id);

ALTER TABLE courses ADD CONSTRAINT fk_courses_teachers
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id);

ALTER TABLE courses ADD CONSTRAINT fk_courses_classes
    FOREIGN KEY (class_id) REFERENCES classes(class_id);

ALTER TABLE grades ADD CONSTRAINT fk_grades_students
    FOREIGN KEY (student_id) REFERENCES students(student_id);

ALTER TABLE grades ADD CONSTRAINT fk_grades_courses
    FOREIGN KEY (course_id) REFERENCES courses(course_id);


ALTER TABLE teachers ADD email VARCHAR(255);
ALTER TABLE students ADD email VARCHAR(255);

ALTER TABLE students
ADD CONSTRAINT unique_email_students UNIQUE (email);
ALTER TABLE teachers
ADD CONSTRAINT unique_email_teachers UNIQUE (email);

