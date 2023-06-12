-- Satellite таблицца, содержащая уровни профессиональной подготовки
CREATE TABLE DegreeSatellite (
    degree_hash varchar NOT NULL,
    record_source varchar(255) NOT NULL,
    load_date time NOT NULL,   
    name varchar(255) NOT NULL,
    PRIMARY KEY (degree_hash)
);

-- Hub для связи уровней профессиональной подготовки с бизнес логикой
CREATE TABLE DegreeHub (
    degree_hash varchar NOT NULL,
    record_source varchar(255) NOT NULL,
    load_date time NOT NULL,
    PRIMARY KEY (degree_hash),
    FOREIGN KEY (degree_hash) REFERENCES DegreeSatellite(degree_hash)
);

-- Satellite таблица, описывающая учебную дисциплину
CREATE TABLE SubjectSatellite (
    subject_hash varchar NOT NULL,
    record_source varchar(255) NOT NULL,
    load_date time NOT NULL,
    subject_name varchar(255) NOT NULL,
    PRIMARY KEY (subject_hash)
);

-- Satellite таблица, содержащая количество часов для различных дисциплин
CREATE TABLE HoursSatellite (
    hours_hash varchar NOT NULL,
    record_source varchar(255) NOT NULL,
    load_date time NOT NULL,
    hours_number int,
    PRIMARY KEY(hours_hash)
);

-- Hub для связи количества часов с бизнес логикой
CREATE TABLE HoursHub (
    hours_hash varchar(255) NOT NULL,
    record_source varchar(255) NOT NULL,
    load_date time NOT NULL,
    PRIMARY KEY (hours_hash),
    FOREIGN KEY (hours_hash) REFERENCES HoursSatellite(hours_hash) 
);

-- Link для формирования количество учебных часов для дисциплин и разных уровней подготовки
CREATE TABLE SubjectLink (
    subject_hash varchar NOT NULL,
    degree_hash_hub varchar NOT NULL,
    hours_hash varchar NOT NULL,
    record_source varchar(255) NOT NULL,
    load_date time NOT NULL,
    PRIMARY KEY(subject_hash),
    FOREIGN KEY(subject_hash) REFERENCES SubjectSatellite(subject_hash),
    FOREIGN KEY(degree_hash_hub) REFERENCES DegreeHub(degree_hash),
    FOREIGN KEY(hours_hash) REFERENCES HoursHub(hours_hash)
);

-- Hub для связи учебных дисциплин с бизнес-логикой
CREATE TABLE SubjectHub (
    subject_hash varchar(255) NOT NULL,
    record_source varchar(255) NOT NULL,
    load_date time NOT NULL,
    PRIMARY KEY (subject_hash),
    FOREIGN KEY (subject_hash) REFERENCES SubjectSatellite(subject_hash)
);

-- Satellite таблица, содержащая информацию о преподавателях
CREATE TABLE LecturerSatellite (
    lecturer_hash varchar NOT NULL,
    lecturer_name varchar(255) NOT NULL,
    lecturer_surname varchar(255) NOT NULL,
    record_source varchar(255) NOT NULL,
    position varchar(255) NOT NULL,
    load_date time NOT NULL,
    PRIMARY KEY (lecturer_hash)
);

-- Hub для связи данных о преподавателях с бизнес логикой
CREATE TABLE LecturerHub (
    lecturer_hash varchar NOT NULL,
    record_source varchar(255) NOT NULL,
    load_date time NOT NULL,
    PRIMARY KEY (lecturer_hash),
    FOREIGN KEY (lecturer_hash) REFERENCES LecturerSatellite(lecturer_hash)
);

-- Satellite таблица, содержащая информация о времени проведение занятий по номеру
CREATE TABLE LectureNumberSatellite (
    number_hash varchar NOT NULL,
    lecture_number int NOT NULL,
    start_time time NOT NULL,
    end_time time not NULL,
    record_source varchar(255) NOT NULL,
    load_date time NOT NULL,
    PRIMARY KEY (number_hash)
);

-- Hub для связи номера занятий по расписанию с бизнес логикой
CREATE TABLE LectureNumberHub (
    number_hash varchar NOT NULL,
    record_source varchar(255) NOT NULL,
    load_date time NOT NULL,
    PRIMARY KEY (number_hash),
    FOREIGN KEY (number_hash) REFERENCES LectureNumberSatellite(number_hash)
);

-- Satellite таблица, содержащая информацию о днях недели
CREATE TABLE DayOfWeekSatellite (
    day_hash varchar NOT NULL,
    record_source varchar(255) NOT NULL,
    load_date time NOT NULL,
    day_name varchar(255) NOT NULL,
    PRIMARY KEY (day_hash)
);

-- Hub для связи дней недели с бизнес логикой
CREATE TABLE DayOfWeekHub (
    day_hash varchar NOT NULL,
    record_source varchar(255) NOT NULL,
    load_date time NOT NULL,
    PRIMARY KEY (day_hash),
    FOREIGN KEY (day_hash) REFERENCES DayOfWeekSatellite(day_hash)
);

-- Satellite таблица, содержащая статусы занятости
CREATE TABLE BusinessStatusSatellite (
    status_hash varchar NOT NULL,
    record_source varchar(255) NOT NULL,
    load_date time NOT NULL,
    business_status varchar(255) NOT NULL,
    PRIMARY KEY (status_hash)
);

-- Hub для связи статусов занятости с бизнес логикой
CREATE TABLE BusinessStatusHub (
    status_hash varchar NOT NULL,
    record_source varchar(255) NOT NULL,
    load_date time NOT NULL,
    PRIMARY KEY (status_hash),
    FOREIGN KEY (status_hash) REFERENCES BusinessStatusSatellite(status_hash)
);

-- Satellite таблица, содеражащая метаинформацию об учебных группах
CREATE TABLE StudyGroupSatellite (
    group_hash varchar NOT NULL,
    record_source varchar(255) NOT NULL,
    load_date time NOT NULL,
    group_code varchar(255) NOT NULL,
    PRIMARY KEY (group_hash)
);

-- Hub для связи учебных групп с бизнес логикой
CREATE TABLE StudyGroupHub (
    group_hash varchar NOT NULL,
    record_source varchar(255) NOT NULL,
    load_date time NOT NULL,
    PRIMARY KEY (group_hash),
    FOREIGN KEY (group_hash) REFERENCES StudyGroupSatellite(group_hash)
);

-- Satellite таблица, содержащая информациб об аудиториях
CREATE TABLE ClassRoomSatellite (
    room_hash varchar NOT NULL,
    record_source varchar(255) NOT NULL,
    load_date time NOT NULL,
    room_code varchar(255) NOT NULL,
    seats_number int NOT NULL,
    PRIMARY KEY (room_hash)
);

-- Link для формирования расписания занятости учебных аудиторий
CREATE TABLE ClassRoomLink (
    room_hash varchar NOT NULL,
    day_hub_hash varchar NOT NULL,
    lecture_number_hash_hub varchar NOT NULL,
    business_status_hub_hash varchar NOT NULL,
    record_source varchar(255) NOT NULL,
    load_date time NOT NULL,
    PRIMARY KEY (room_hash),
    FOREIGN KEY(room_hash) REFERENCES ClassRoomSatellite(room_hash),
    FOREIGN KEY(day_hub_hash) REFERENCES DayOfWeekHub(day_hash),
    FOREIGN KEY(business_status_hub_hash) REFERENCES BusinessStatusHub(status_hash),
    FOREIGN KEY(lecture_number_hash_hub) REFERENCES LectureNumberHub(number_hash)
);

-- Link для формирования расписания учебных занятий
CREATE TABLE LecturesLink (
    ID int NOT NULL,
    day_hub_hash varchar NOT NULL,
    lecture_number_hash_hub varchar NOT NULL,
    group_hub_hash varchar NOT NULL,
    subject_hub_hash varchar NOT NULL,
    lecturer_hub_hash varchar NOT NULL,
    class_room_hub_hash varchar NOT NULL,
    record_source varchar(255) NOT NULL,
    load_date time NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (day_hub_hash) REFERENCES DayOfWeekHub(day_hash),
    FOREIGN KEY (lecture_number_hash_hub) REFERENCES LectureNumberHub(number_hash),
    FOREIGN KEY (group_hub_hash) REFERENCES StudyGroupHub(group_hash),
    FOREIGN KEY (subject_hub_hash) REFERENCES SubjectHub(subject_hash),
    FOREIGN KEY (lecturer_hub_hash) REFERENCES LecturerHub(lecturer_hash),
    FOREIGN KEY (class_room_hub_hash) REFERENCES ClassRoomSatellite(room_hash)
);