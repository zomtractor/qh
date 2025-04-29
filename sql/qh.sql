-- 用户表
CREATE TABLE tb_user (
                         id BIGINT AUTO_INCREMENT PRIMARY KEY,
                         username VARCHAR(100) NOT NULL,
                         password VARCHAR(255) NOT NULL,
                         user_type ENUM('job_seeker', 'enterprise', 'admin') NOT NULL COMMENT '账号类型：求职者、企业、管理员',

                         create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                         update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                         status TINYINT DEFAULT 1 COMMENT '状态：1-正常，0-禁用',
                         version INT DEFAULT 1
);

-- 简历表
CREATE TABLE tb_resume (
                           id BIGINT AUTO_INCREMENT PRIMARY KEY,
                           user_id BIGINT NOT NULL, -- 外键: tb_user.id
                           avatar_file_id VARCHAR(255) COMMENT '头像文件ID',
                           name VARCHAR(50) NOT NULL,
                           gender ENUM('male', 'female', 'other') NOT NULL,
                           age INT,
                           education VARCHAR(50),
                           school VARCHAR(100),
                           phone VARCHAR(20),
                           email VARCHAR(100),
                           job_intention VARCHAR(255),
                           attachment_file_ids TEXT COMMENT '简历附件，多个文件ID以逗号分隔',

                           create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                           update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                           status TINYINT DEFAULT 1,
                           version INT DEFAULT 1
);

-- 企业信息表
CREATE TABLE tb_etp (
                        id BIGINT AUTO_INCREMENT PRIMARY KEY,
                        user_id BIGINT NOT NULL, -- 外键: tb_user.id
                        logo_file_id VARCHAR(255),
                        name VARCHAR(100) NOT NULL,
                        description TEXT COMMENT '宣传信息',
                        legal_person VARCHAR(100),
                        address VARCHAR(255),
                        phone VARCHAR(20),
                        email VARCHAR(100),
                        website VARCHAR(255),
                        popularity INT DEFAULT 0 COMMENT '企业热度',

                        create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                        update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                        status TINYINT DEFAULT 1,
                        version INT DEFAULT 1
);

-- 岗位表
CREATE TABLE tb_job (
                        id BIGINT AUTO_INCREMENT PRIMARY KEY,
                        name VARCHAR(100) NOT NULL,
                        description TEXT COMMENT '岗位职责',
                        salary_desc VARCHAR(100),
                        location VARCHAR(255),
                        requirement TEXT COMMENT '要求条件',
                        etp_id BIGINT NOT NULL, -- 外键: tb_etp.id
                        category_ids VARCHAR(255) COMMENT '分类ID，以逗号分隔',
                        tag_ids VARCHAR(255) COMMENT '标签ID，以逗号分隔',
                        popularity INT DEFAULT 0 COMMENT '岗位热度',

                        create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                        update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                        status TINYINT DEFAULT 1,
                        version INT DEFAULT 1
);

-- 标签表
CREATE TABLE tb_tag (
                        id BIGINT AUTO_INCREMENT PRIMARY KEY,
                        name VARCHAR(100) NOT NULL,
                        popularity INT DEFAULT 0 COMMENT '标签热度',

                        create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                        update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                        status TINYINT DEFAULT 1,
                        version INT DEFAULT 1
);

-- 分类表
CREATE TABLE tb_category (
                             id BIGINT AUTO_INCREMENT PRIMARY KEY,
                             name VARCHAR(100) NOT NULL,

                             create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                             update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                             status TINYINT DEFAULT 1,
                             version INT DEFAULT 1
);

-- 面试表
CREATE TABLE tb_interview (
                              id BIGINT AUTO_INCREMENT PRIMARY KEY,
                              user_id BIGINT NOT NULL, -- 外键: tb_user.id（求职者）
                              job_id BIGINT NOT NULL, -- 外键: tb_job.id
                              etp_id BIGINT NOT NULL, -- 外键: tb_etp.id
                              interview_status VARCHAR(50) COMMENT '面试状态',
                              message VARCHAR(50) COMMENT '消息',
                              time DATETIME COMMENT '面试时间',

                              create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                              update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                              status TINYINT DEFAULT 1,
                              version INT DEFAULT 1
);

-- 评价表
CREATE TABLE tb_comment (
                            id BIGINT AUTO_INCREMENT PRIMARY KEY,
                            operator_id BIGINT NOT NULL, -- 外键: tb_user.id
                            target_type ENUM('job', 'enterprise', 'job_seeker') NOT NULL COMMENT '评价对象类型',
                            target_id BIGINT NOT NULL COMMENT '被评价的岗位/企业/求职者ID',
                            score INT CHECK (score >= 1 AND score <= 5),

                            create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                            update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                            status TINYINT DEFAULT 1,
                            version INT DEFAULT 1
);

create table tb_communicate
(
    id          bigint AUTO_INCREMENT PRIMARY KEY,
    poster_id   bigint    not null,
    receiver_id bigint    not null,
    previous_id bigint not null default -1,
    content     text      null,
    content_type   ENUM('text', 'image', 'file') default 'text',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    status TINYINT DEFAULT 1,
    version INT DEFAULT 1
);


