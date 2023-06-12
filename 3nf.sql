-- Таблица, описывающая учебную дисциплину
CREATE TABLE Subject (
    ID int NOT NULL,
    subject_name varchar(255) NOT NULL,
    PRIMARY KEY (ID)
);

-- Таблица, содержащая уровни профессиональной подготовки
CREATE TABLE Degree (
    ID int NOT NULL,
    name varchar(255) NOT NULL,
    PRIMARY KEY (ID)
);

-- Таблица, которая содержит учебный план по дисциплине
CREATE TABLE SubjectEducationPLan (
    ID int NOT NULL,
    subject_hours int NOT NULL,
    subjectID int,
    degreeID int,
    PRIMARY KEY (ID),
    FOREIGN KEY (subjectID) REFERENCES Subject(ID),
    FOREIGN KEY (degreeID) REFERENCES Degree(ID)
);

-- Должности преподавателей
CREATE TABLE LecturerPosition (
    ID int NOT NULL,
    lecturer_position_name varchar(255) NOT NULL,
    lecture_hours int NOT NULL,
    PRIMARY KEY (ID)
);

-- Таблица, содержащая преподавателей
CREATE TABLE Lecturer (
    ID int NOT NULL,
    lecturer_name varchar(255) NOT NULL,
    lecturer_surname varchar(255) NOT NULL,
    positionID int,
    PRIMARY KEY (ID),
    FOREIGN KEY (positionID) REFERENCES LecturerPosition(ID)
);

-- Номер пары и время, в которое они проходят
CREATE TABLE LectureNumber (
    ID int NOT NULL,
    lecture_number int NOT NULL,
    start_time time NOT NULL,
    end_time time not NULL,
    PRIMARY KEY (ID)
);

-- Таблица с днями недели
CREATE TABLE DayOfWeek (
    ID int NOT NULL,
    day_name varchar(255) NOT NULL,
    PRIMARY KEY (ID)
);

-- Таблица, содержащая аудитории и метаинформацию о них
CREATE TABLE ClassRoom (
    ID int NOT NULL,
    room_code varchar(255) NOT NULL,
    seats_number int NOT NULL,
    PRIMARY KEY (ID)
);

-- Таблица, содержащая статусы занятости
-- Необходимо для составления таблиц занятости аудиторий
CREATE TABLE BusinessStatus (
    ID int NOT NULL,
    business_status varchar(255) NOT NULL,
    PRIMARY KEY (ID)
);

-- Таблица, содержащая расписание занятости аудиторий
CREATE TABLE ClassRoomSchedule (
    ID int not NULL,
    class_roomID int,
    day_of_weekID int,
    business_statusID int,
    lecture_numberID int,
    PRIMARY KEY (ID),
    FOREIGN KEY (class_roomID) REFERENCES ClassRoom(ID),
    FOREIGN KEY (day_of_weekID) REFERENCES DayOfWeek(ID),
    FOREIGN KEY (business_statusID) REFERENCES BusinessStatus(ID),
    FOREIGN KEY (lecture_numberID) REFERENCES LectureNumber(ID)
);

-- Таблица, содержащая информацию об учебных группах
CREATE TABLE StudyGroup (
    ID int NOT NULL,
    group_code varchar(255) NOT NULL,
    PRIMARY KEY (ID)
);

-- Таблица, содержащая расписание
CREATE TABLE LecturesSchedule (
    ID int NOT NULL,
    day_of_weekID int,
    lecture_numberID int,
    study_groupID int,
    subjectID int,
    lecturerID int,
    class_roomID int,
    PRIMARY KEY (ID),
    FOREIGN KEY (day_of_weekID) REFERENCES DayOfWeek(ID),
    FOREIGN KEY (lecture_numberID) REFERENCES LectureNumber(ID),
    FOREIGN KEY (study_groupID) REFERENCES StudyGroup(ID),
    FOREIGN KEY (subjectID) REFERENCES Subject(ID),
    FOREIGN KEY (lecturerID) REFERENCES Lecturer(ID),
    FOREIGN KEY (class_roomID) REFERENCES ClassRoom(ID)
);
