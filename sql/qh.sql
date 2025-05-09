-- MySQL dump 10.13  Distrib 5.7.24, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: qh
-- ------------------------------------------------------
-- Server version	5.7.24

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tb_job`
--

DROP TABLE IF EXISTS `tb_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_job` (
                          `id` bigint(20) NOT NULL AUTO_INCREMENT,
                          `name` varchar(100) NOT NULL,
                          `description` text COMMENT '岗位职责',
                          `salary_desc` varchar(100) DEFAULT NULL,
                          `location` varchar(255) DEFAULT NULL,
                          `requirement` text COMMENT '要求条件',
                          `etp_id` bigint(20) NOT NULL,
                          `category_ids` varchar(255) DEFAULT NULL COMMENT '分类ID，以逗号分隔',
                          `tag_ids` varchar(255) DEFAULT NULL COMMENT '标签ID，以逗号分隔',
                          `popularity` int(11) DEFAULT '0' COMMENT '岗位热度',
                          `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
                          `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                          `status` tinyint(4) DEFAULT '1',
                          `version` int(11) DEFAULT '1',
                          PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_job`
--

/*!40000 ALTER TABLE `tb_job` DISABLE KEYS */;
INSERT INTO `tb_job` VALUES (1,'研发工程师','123123123','111','23123132','会java',1,'1,6','1,2,3,5',1,'2025-04-27 20:37:41','2025-05-02 16:24:43',1,1);
/*!40000 ALTER TABLE `tb_job` ENABLE KEYS */;

--
-- Table structure for table `sys_logininfor`
--

DROP TABLE IF EXISTS `sys_logininfor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_logininfor` (
                                  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
                                  `user_name` varchar(50) DEFAULT '' COMMENT '用户账号',
                                  `ipaddr` varchar(128) DEFAULT '' COMMENT '登录IP地址',
                                  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',
                                  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
                                  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
                                  `status` char(1) DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
                                  `msg` varchar(255) DEFAULT '' COMMENT '提示消息',
                                  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
                                  PRIMARY KEY (`info_id`),
                                  KEY `idx_sys_logininfor_s` (`status`),
                                  KEY `idx_sys_logininfor_lt` (`login_time`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8 COMMENT='系统访问记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_logininfor`
--

/*!40000 ALTER TABLE `sys_logininfor` DISABLE KEYS */;
INSERT INTO `sys_logininfor` VALUES (100,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-26 16:39:13'),(101,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-26 18:22:24'),(102,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-26 19:16:00'),(103,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-26 20:04:14'),(104,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','验证码已失效','2025-04-27 14:40:48'),(105,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-27 14:40:53'),(106,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-27 15:43:48'),(107,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-27 17:03:49'),(108,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-27 19:46:14'),(109,'admin','172.17.171.120','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-28 14:28:39'),(110,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-28 14:29:39'),(111,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-28 15:43:09'),(112,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-02 15:36:34'),(113,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-05-02 19:08:05'),(114,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-05-02 19:08:16');
/*!40000 ALTER TABLE `sys_logininfor` ENABLE KEYS */;

--
-- Table structure for table `tb_comment`
--

DROP TABLE IF EXISTS `tb_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_comment` (
                              `id` bigint(20) NOT NULL AUTO_INCREMENT,
                              `operator_id` bigint(20) NOT NULL,
                              `target_type` enum('job','enterprise','job_seeker') NOT NULL COMMENT '评价对象类型',
                              `target_id` bigint(20) NOT NULL COMMENT '被评价的岗位/企业/求职者ID',
                              `score` int(11) DEFAULT NULL,
                              `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
                              `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                              `status` tinyint(4) DEFAULT '1',
                              `version` int(11) DEFAULT '1',
                              PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_comment`
--

/*!40000 ALTER TABLE `tb_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_comment` ENABLE KEYS */;

--
-- Table structure for table `qrtz_paused_trigger_grps`
--

DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_paused_trigger_grps` (
                                            `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
                                            `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
                                            PRIMARY KEY (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='暂停的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_paused_trigger_grps`
--

/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` ENABLE KEYS */;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_role` (
                                 `user_id` bigint(20) NOT NULL COMMENT '用户ID',
                                 `role_id` bigint(20) NOT NULL COMMENT '角色ID',
                                 PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户和角色关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;

--
-- Table structure for table `sys_dict_type`
--

DROP TABLE IF EXISTS `sys_dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_dict_type` (
                                 `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
                                 `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
                                 `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
                                 `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
                                 `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                                 `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                 `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                                 `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                 `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                                 PRIMARY KEY (`dict_id`),
                                 UNIQUE KEY `dict_type` (`dict_type`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8 COMMENT='字典类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_type`
--

/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;
INSERT INTO `sys_dict_type` VALUES (1,'用户性别','sys_user_sex','0','admin','2025-04-26 15:33:18','',NULL,'用户性别列表'),(2,'菜单状态','sys_show_hide','0','admin','2025-04-26 15:33:18','',NULL,'菜单状态列表'),(3,'系统开关','sys_normal_disable','0','admin','2025-04-26 15:33:18','',NULL,'系统开关列表'),(4,'任务状态','sys_job_status','0','admin','2025-04-26 15:33:18','',NULL,'任务状态列表'),(5,'任务分组','sys_job_group','0','admin','2025-04-26 15:33:18','',NULL,'任务分组列表'),(6,'系统是否','sys_yes_no','0','admin','2025-04-26 15:33:18','',NULL,'系统是否列表'),(7,'通知类型','sys_notice_type','0','admin','2025-04-26 15:33:18','',NULL,'通知类型列表'),(8,'通知状态','sys_notice_status','0','admin','2025-04-26 15:33:18','',NULL,'通知状态列表'),(9,'操作类型','sys_oper_type','0','admin','2025-04-26 15:33:18','',NULL,'操作类型列表'),(10,'系统状态','sys_common_status','0','admin','2025-04-26 15:33:18','',NULL,'登录状态列表'),(100,'status字段','tb_any_status','0','admin','2025-04-26 16:53:24','',NULL,NULL),(101,'用户类型','user_type','0','admin','2025-04-26 17:12:21','',NULL,NULL),(102,'沟通消息类型','communicate_content_type','0','admin','2025-05-02 19:17:01','',NULL,NULL);
/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;

--
-- Table structure for table `tb_interview`
--

DROP TABLE IF EXISTS `tb_interview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_interview` (
                                `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                `user_id` bigint(20) NOT NULL,
                                `job_id` bigint(20) NOT NULL,
                                `etp_id` bigint(20) NOT NULL,
                                `interview_status` varchar(50) DEFAULT NULL COMMENT '面试状态',
                                `message` varchar(50) DEFAULT NULL COMMENT '消息',
                                `time` datetime DEFAULT NULL COMMENT '面试时间',
                                `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
                                `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                `status` tinyint(4) DEFAULT '1',
                                `version` int(11) DEFAULT '1',
                                PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_interview`
--

/*!40000 ALTER TABLE `tb_interview` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_interview` ENABLE KEYS */;

--
-- Table structure for table `qrtz_simprop_triggers`
--

DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_simprop_triggers` (
                                         `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
                                         `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
                                         `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
                                         `str_prop_1` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
                                         `str_prop_2` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
                                         `str_prop_3` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
                                         `int_prop_1` int(11) DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
                                         `int_prop_2` int(11) DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
                                         `long_prop_1` bigint(20) DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
                                         `long_prop_2` bigint(20) DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
                                         `dec_prop_1` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
                                         `dec_prop_2` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
                                         `bool_prop_1` varchar(1) DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
                                         `bool_prop_2` varchar(1) DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
                                         PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
                                         CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='同步机制的行锁表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_simprop_triggers`
--

/*!40000 ALTER TABLE `qrtz_simprop_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simprop_triggers` ENABLE KEYS */;

--
-- Table structure for table `sys_job_log`
--

DROP TABLE IF EXISTS `sys_job_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_job_log` (
                               `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
                               `job_name` varchar(64) NOT NULL COMMENT '任务名称',
                               `job_group` varchar(64) NOT NULL COMMENT '任务组名',
                               `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
                               `job_message` varchar(500) DEFAULT NULL COMMENT '日志信息',
                               `status` char(1) DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
                               `exception_info` varchar(2000) DEFAULT '' COMMENT '异常信息',
                               `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                               PRIMARY KEY (`job_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='定时任务调度日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job_log`
--

/*!40000 ALTER TABLE `sys_job_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_job_log` ENABLE KEYS */;

--
-- Table structure for table `tb_tag`
--

DROP TABLE IF EXISTS `tb_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_tag` (
                          `id` bigint(20) NOT NULL AUTO_INCREMENT,
                          `name` varchar(100) NOT NULL,
                          `popularity` int(11) DEFAULT '0' COMMENT '标签热度',
                          `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
                          `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                          `status` tinyint(4) DEFAULT '1',
                          `version` int(11) DEFAULT '1',
                          PRIMARY KEY (`id`),
                          UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_tag`
--

/*!40000 ALTER TABLE `tb_tag` DISABLE KEYS */;
INSERT INTO `tb_tag` VALUES (1,'java',1,'2025-04-28 15:50:43','2025-04-28 15:50:42',1,1),(2,'python',1,'2025-04-28 15:50:52','2025-04-28 15:50:52',1,1),(3,'双休',1,'2025-04-28 15:51:04','2025-04-28 15:51:03',1,1),(4,'996',1,'2025-04-28 15:51:09','2025-04-28 15:51:09',1,1),(5,'777',0,'2025-05-02 16:21:54','2025-05-02 16:21:53',1,1);
/*!40000 ALTER TABLE `tb_tag` ENABLE KEYS */;

--
-- Table structure for table `sys_oper_log`
--

DROP TABLE IF EXISTS `sys_oper_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_oper_log` (
                                `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
                                `title` varchar(50) DEFAULT '' COMMENT '模块标题',
                                `business_type` int(2) DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
                                `method` varchar(200) DEFAULT '' COMMENT '方法名称',
                                `request_method` varchar(10) DEFAULT '' COMMENT '请求方式',
                                `operator_type` int(1) DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
                                `oper_name` varchar(50) DEFAULT '' COMMENT '操作人员',
                                `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
                                `oper_url` varchar(255) DEFAULT '' COMMENT '请求URL',
                                `oper_ip` varchar(128) DEFAULT '' COMMENT '主机地址',
                                `oper_location` varchar(255) DEFAULT '' COMMENT '操作地点',
                                `oper_param` varchar(2000) DEFAULT '' COMMENT '请求参数',
                                `json_result` varchar(2000) DEFAULT '' COMMENT '返回参数',
                                `status` int(1) DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
                                `error_msg` varchar(2000) DEFAULT '' COMMENT '错误消息',
                                `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
                                `cost_time` bigint(20) DEFAULT '0' COMMENT '消耗时间',
                                PRIMARY KEY (`oper_id`),
                                KEY `idx_sys_oper_log_bt` (`business_type`),
                                KEY `idx_sys_oper_log_s` (`status`),
                                KEY `idx_sys_oper_log_ot` (`oper_time`)
) ENGINE=InnoDB AUTO_INCREMENT=197 DEFAULT CHARSET=utf8 COMMENT='操作日志记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oper_log`
--

/*!40000 ALTER TABLE `sys_oper_log` DISABLE KEYS */;
INSERT INTO `sys_oper_log` VALUES (100,'代码生成',6,'com.qh.recruit.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"tb_interview,tb_comment,tb_category,tb_user,tb_tag,tb_resume,tb_job,tb_etp\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 16:41:46',1191),(101,'代码生成',8,'com.qh.recruit.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"tb_tag\"}',NULL,0,NULL,'2025-04-26 16:46:07',731),(102,'字典类型',1,'com.qh.recruit.web.controller.system.SysDictTypeController.add()','POST',1,'admin','研发部门','/system/dict/type','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"dictName\":\"status字段\",\"dictType\":\"tb_any_status\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 16:53:24',17),(103,'字典数据',1,'com.qh.recruit.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"正常\",\"dictSort\":0,\"dictType\":\"tb_any_status\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 16:54:13',59),(104,'字典数据',1,'com.qh.recruit.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"已删除\",\"dictSort\":1,\"dictType\":\"tb_any_status\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 16:54:29',58),(105,'菜单管理',1,'com.qh.recruit.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"build\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"后台管理\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"admin\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 16:58:01',81),(106,'代码生成',2,'com.qh.recruit.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"user\",\"className\":\"User\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":77,\"columnName\":\"id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:46\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Username\",\"columnId\":78,\"columnName\":\"username\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:46\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"username\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Password\",\"columnId\":79,\"columnName\":\"password\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:46\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"password\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserType\",\"columnComment\":\"账号类型：求职者、企业、管理员\",\"columnId\":80,\"columnName\":\"user_type\",\"columnType\":\"enum(\'job_seeker\',\'enterprise\',\'admin\')\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:46\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userType\",\"javaType\":\"Stri','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 17:06:14',47),(107,'代码生成',2,'com.qh.recruit.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"tag\",\"className\":\"Tag\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":70,\"columnName\":\"id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:46\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnId\":71,\"columnName\":\"name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:46\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Popularity\",\"columnComment\":\"标签热度\",\"columnId\":72,\"columnName\":\"popularity\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:46\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"popularity\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CreateTime\",\"columnId\":73,\"columnName\":\"create_time\",\"columnType\":\"datetime\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:46\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":false,\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"0\",\"isRequired\":\"0\",\"javaField\":\"createTime\",\"javaType\":\"Date\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"re','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 17:07:36',30),(108,'字典类型',1,'com.qh.recruit.web.controller.system.SysDictTypeController.add()','POST',1,'admin','研发部门','/system/dict/type','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"dictName\":\"用户类型\",\"dictType\":\"user_type\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 17:12:21',50),(109,'字典数据',1,'com.qh.recruit.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"求职者\",\"dictSort\":0,\"dictType\":\"user_type\",\"dictValue\":\"job_seeker\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 17:13:48',68),(110,'字典数据',1,'com.qh.recruit.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"企业\",\"dictSort\":1,\"dictType\":\"user_type\",\"dictValue\":\"enterprise\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 17:14:08',16),(111,'字典数据',1,'com.qh.recruit.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"管理员\",\"dictSort\":3,\"dictType\":\"user_type\",\"dictValue\":\"admin\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 17:14:22',60),(112,'代码生成',2,'com.qh.recruit.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"user\",\"className\":\"User\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":77,\"columnName\":\"id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:46\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"updateTime\":\"2025-04-26 17:06:14\",\"usableColumn\":false},{\"capJavaField\":\"Username\",\"columnComment\":\"用户名\",\"columnId\":78,\"columnName\":\"username\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:46\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"username\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"updateTime\":\"2025-04-26 17:06:14\",\"usableColumn\":false},{\"capJavaField\":\"Password\",\"columnComment\":\"密码\",\"columnId\":79,\"columnName\":\"password\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:46\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"password\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"updateTime\":\"2025-04-26 17:06:14\",\"usableColumn\":false},{\"capJavaField\":\"UserType\",\"columnComment\":\"账号类型\",\"columnId\":80,\"columnName\":\"user_type\",\"columnType\":\"enum(\'job_seeker\',\'enterprise\',\'admin\')\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:46\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"i','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 17:15:00',111),(113,'代码生成',2,'com.qh.recruit.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"user\",\"className\":\"User\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":77,\"columnName\":\"id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:46\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"updateTime\":\"2025-04-26 17:15:00\",\"usableColumn\":false},{\"capJavaField\":\"Username\",\"columnComment\":\"用户名\",\"columnId\":78,\"columnName\":\"username\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:46\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"username\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"updateTime\":\"2025-04-26 17:15:00\",\"usableColumn\":false},{\"capJavaField\":\"Password\",\"columnComment\":\"密码\",\"columnId\":79,\"columnName\":\"password\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:46\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"password\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"updateTime\":\"2025-04-26 17:15:00\",\"usableColumn\":false},{\"capJavaField\":\"UserType\",\"columnComment\":\"账号类型\",\"columnId\":80,\"columnName\":\"user_type\",\"columnType\":\"enum(\'job_seeker\',\'enterprise\',\'admin\')\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:46\",\"dictType\":\"user_type\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 17:15:53',100),(114,'代码生成',2,'com.qh.recruit.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"tag\",\"className\":\"Tag\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":70,\"columnName\":\"id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:46\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2025-04-26 17:07:36\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnComment\":\"名称\",\"columnId\":71,\"columnName\":\"name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:46\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2025-04-26 17:07:36\",\"usableColumn\":false},{\"capJavaField\":\"Popularity\",\"columnComment\":\"标签热度\",\"columnId\":72,\"columnName\":\"popularity\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:46\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"popularity\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2025-04-26 17:07:36\",\"usableColumn\":false},{\"capJavaField\":\"CreateTime\",\"columnId\":73,\"columnName\":\"create_time\",\"columnType\":\"datetime\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:46\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":false,\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"0\",\"is','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 17:16:13',84),(115,'代码生成',2,'com.qh.recruit.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"category\",\"className\":\"Category\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnId\":2,\"columnName\":\"name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CreateTime\",\"columnId\":3,\"columnName\":\"create_time\",\"columnType\":\"datetime\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"0\",\"isRequired\":\"0\",\"javaField\":\"createTime\",\"javaType\":\"Date\",\"list\":false,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":true,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UpdateTime\",\"columnId\":4,\"columnName\":\"update_time\",\"columnType\":\"datetime\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"0\",\"isRequired\":\"0\",\"javaField\":\"updateTime\",\"javaType\":\"Date\",\"list\":false,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":4,\"superColumn\":true,\"tableId\":1','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 17:17:17',59),(116,'代码生成',2,'com.qh.recruit.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"category\",\"className\":\"Category\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-04-26 17:17:17\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnId\":2,\"columnName\":\"name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-04-26 17:17:17\",\"usableColumn\":false},{\"capJavaField\":\"CreateTime\",\"columnId\":3,\"columnName\":\"create_time\",\"columnType\":\"datetime\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":false,\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"0\",\"isRequired\":\"0\",\"javaField\":\"createTime\",\"javaType\":\"Date\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":true,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-04-26 17:17:17\",\"usableColumn\":false},{\"capJavaField\":\"UpdateTime\",\"columnId\":4,\"columnName\":\"update_time\",\"columnType\":\"datetime\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"0\",\"isRequired\":\"0\",\"javaField\":\"updateTime\",\"javaTy','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 17:17:42',77),(117,'代码生成',2,'com.qh.recruit.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"comment\",\"className\":\"Comment\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":7,\"columnName\":\"id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"OperatorId\",\"columnComment\":\"操作者id\",\"columnId\":8,\"columnName\":\"operator_id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"operatorId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"TargetType\",\"columnComment\":\"评价对象类型\",\"columnId\":9,\"columnName\":\"target_type\",\"columnType\":\"enum(\'job\',\'enterprise\',\'job_seeker\')\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"user_type\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"targetType\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"TargetId\",\"columnComment\":\"评价对象id\",\"columnId\":10,\"columnName\":\"target_id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\"','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 17:20:01',50),(118,'代码生成',2,'com.qh.recruit.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"etp\",\"className\":\"Etp\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":16,\"columnName\":\"id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnId\":17,\"columnName\":\"user_id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"LogoFileId\",\"columnId\":18,\"columnName\":\"logo_file_id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"logoFileId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnId\":19,\"columnName\":\"name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"require','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 17:23:23',149),(119,'代码生成',2,'com.qh.recruit.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"etp\",\"className\":\"Etp\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":16,\"columnName\":\"id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2025-04-26 17:23:23\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"todo\",\"columnId\":17,\"columnName\":\"user_id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2025-04-26 17:23:23\",\"usableColumn\":false},{\"capJavaField\":\"LogoFileId\",\"columnComment\":\"todo\",\"columnId\":18,\"columnName\":\"logo_file_id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"logoFileId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2025-04-26 17:23:23\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnComment\":\"企业名称\",\"columnId\":19,\"columnName\":\"name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInser','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 17:26:48',133),(120,'代码生成',2,'com.qh.recruit.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"interview\",\"className\":\"Interview\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":31,\"columnName\":\"id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"todo\",\"columnId\":32,\"columnName\":\"user_id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"JobId\",\"columnComment\":\"todo\",\"columnId\":33,\"columnName\":\"job_id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"jobId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"EtpId\",\"columnComment\":\"todo\",\"columnId\":34,\"columnName\":\"etp_id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"etpId\",\"javaType\":\"Long\",\"list\":true,\"p','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 17:28:26',97),(121,'代码生成',3,'com.qh.recruit.generator.controller.GenController.remove()','DELETE',1,'admin','研发部门','/tool/gen/4','127.0.0.1','内网IP','[4]','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 18:22:52',57),(122,'代码生成',6,'com.qh.recruit.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"tb_interview\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 18:23:00',100),(123,'代码生成',3,'com.qh.recruit.generator.controller.GenController.remove()','DELETE',1,'admin','研发部门','/tool/gen/9','127.0.0.1','内网IP','[9]','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 18:24:57',20),(124,'代码生成',6,'com.qh.recruit.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"tb_interview\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 18:25:33',87),(125,'代码生成',2,'com.qh.recruit.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"interview\",\"className\":\"Interview\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":95,\"columnName\":\"id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 18:25:33\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":10,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"todo\",\"columnId\":96,\"columnName\":\"user_id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 18:25:33\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":10,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"JobId\",\"columnComment\":\"todo\",\"columnId\":97,\"columnName\":\"job_id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 18:25:33\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"jobId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":10,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"EtpId\",\"columnComment\":\"todo\",\"columnId\":98,\"columnName\":\"etp_id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 18:25:33\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"etpId\",\"javaType\":\"Long\",\"list\":true','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 18:27:46',101),(126,'代码生成',2,'com.qh.recruit.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"job\",\"className\":\"Job\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":40,\"columnName\":\"id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnComment\":\"名称\",\"columnId\":41,\"columnName\":\"name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Description\",\"columnComment\":\"岗位职责\",\"columnId\":42,\"columnName\":\"description\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"description\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"SalaryDesc\",\"columnComment\":\"todo\",\"columnId\":43,\"columnName\":\"salary_desc\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"salaryDesc\",\"javaType\":\"','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 18:31:16',88),(127,'代码生成',2,'com.qh.recruit.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"interview\",\"className\":\"Interview\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":95,\"columnName\":\"id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 18:25:33\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":10,\"updateBy\":\"\",\"updateTime\":\"2025-04-26 18:27:46\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"todo\",\"columnId\":96,\"columnName\":\"user_id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 18:25:33\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":10,\"updateBy\":\"\",\"updateTime\":\"2025-04-26 18:27:46\",\"usableColumn\":false},{\"capJavaField\":\"JobId\",\"columnComment\":\"todo\",\"columnId\":97,\"columnName\":\"job_id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 18:25:33\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"jobId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":10,\"updateBy\":\"\",\"updateTime\":\"2025-04-26 18:27:46\",\"usableColumn\":false},{\"capJavaField\":\"EtpId\",\"columnComment\":\"todo\",\"columnId\":98,\"columnName\":\"etp_id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 18:25:33\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\"','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 18:31:23',66),(128,'代码生成',2,'com.qh.recruit.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"resume\",\"className\":\"Resume\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":54,\"columnName\":\"id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnId\":55,\"columnName\":\"user_id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"AvatarFileId\",\"columnComment\":\"头像文件ID\",\"columnId\":56,\"columnName\":\"avatar_file_id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"avatarFileId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnComment\":\"名称\",\"columnId\":57,\"columnName\":\"name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"pa','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 18:37:16',90),(129,'代码生成',8,'com.qh.recruit.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"tb_interview,tb_tag,tb_user,tb_category,tb_comment,tb_etp,tb_job,tb_resume\"}',NULL,0,NULL,'2025-04-26 18:38:04',858),(130,'企业管理',1,'com.qh.recruit.admin.controller.EtpController.add()','POST',1,'admin','研发部门','/admin/etp','127.0.0.1','内网IP','{\"address\":\"1\",\"createTime\":\"2025-04-26 19:30:58\",\"description\":\"1\",\"email\":\"1\",\"id\":1,\"legalPerson\":\"1\",\"logoFileId\":\"1\",\"name\":\"1\",\"params\":{},\"phone\":\"1\",\"popularity\":1,\"userId\":1,\"website\":\"1\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 19:30:58',30),(131,'用户管理',1,'com.qh.recruit.admin.controller.UserController.add()','POST',1,'admin','研发部门','/admin/user','127.0.0.1','内网IP','{\"createTime\":\"2025-04-26 20:04:26\",\"id\":1,\"params\":{},\"userType\":\"job_seeker\",\"username\":\"zs\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 20:04:26',30),(132,'菜单管理',3,'com.qh.recruit.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/2013','127.0.0.1','内网IP','2013','{\"msg\":\"存在子菜单,不允许删除\",\"code\":601}',0,NULL,'2025-04-26 20:34:30',18),(133,'菜单管理',3,'com.qh.recruit.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/2015','127.0.0.1','内网IP','2015','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 20:34:48',45),(134,'菜单管理',3,'com.qh.recruit.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/2016','127.0.0.1','内网IP','2016','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 20:34:50',16),(135,'菜单管理',3,'com.qh.recruit.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/2017','127.0.0.1','内网IP','2017','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 20:34:54',17),(136,'菜单管理',3,'com.qh.recruit.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/2018','127.0.0.1','内网IP','2018','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 20:34:57',21),(137,'菜单管理',3,'com.qh.recruit.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/2014','127.0.0.1','内网IP','2014','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 20:34:59',15),(138,'菜单管理',3,'com.qh.recruit.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/2013','127.0.0.1','内网IP','2013','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 20:35:03',18),(139,'菜单管理',3,'com.qh.recruit.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/4','127.0.0.1','内网IP','4','{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}',0,NULL,'2025-04-26 20:49:56',14),(140,'菜单管理',2,'com.qh.recruit.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2025-04-26 15:33:13\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 20:50:16',32),(141,'菜单管理',3,'com.qh.recruit.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/4','127.0.0.1','内网IP','4','{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}',0,NULL,'2025-04-26 20:50:20',10),(142,'菜单管理',2,'com.qh.recruit.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2025-04-26 15:33:13\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"1\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 20:51:42',12),(143,'菜单管理',2,'com.qh.recruit.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2025-04-26 15:33:13\",\"icon\":\"monitor\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2,\"menuName\":\"系统监控\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"monitor\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-26 20:52:20',14),(144,'分类管理',1,'com.qh.recruit.admin.controller.CategoryController.add()','POST',1,'admin','研发部门','/admin/category','127.0.0.1','内网IP','{\"createTime\":\"2025-04-27 14:42:47\",\"id\":1,\"name\":\"java\",\"params\":{}}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-27 14:42:47',43),(145,'简历',1,'com.qh.recruit.admin.controller.ResumeController.add()','POST',1,'admin','研发部门','/admin/resume','127.0.0.1','内网IP','{\"age\":1,\"attachmentFileIds\":\"1\",\"avatarFileId\":\"1\",\"createTime\":\"2025-04-27 16:00:29\",\"education\":\"1\",\"email\":\"1\",\"id\":1,\"jobIntention\":\"1\",\"name\":\"1\",\"params\":{},\"phone\":\"1\",\"school\":\"1\",\"userId\":1}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-27 16:00:29',28),(146,'简历',2,'com.qh.recruit.admin.controller.ResumeController.edit()','PUT',1,'admin','研发部门','/admin/resume','127.0.0.1','内网IP','{\"age\":1,\"attachmentFileIds\":\"1\",\"avatarFileId\":\"1\",\"createTime\":\"2025-04-27 16:00:30\",\"education\":\"1\",\"email\":\"1\",\"gender\":\"male\",\"id\":1,\"jobIntention\":\"1\",\"name\":\"xxg\",\"params\":{},\"phone\":\"1\",\"school\":\"1\",\"status\":1,\"updateTime\":\"2025-04-27 16:29:01\",\"userId\":1,\"version\":1}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-27 16:29:02',53),(147,'简历',2,'com.qh.recruit.admin.controller.ResumeController.edit()','PUT',1,'admin','研发部门','/admin/resume','127.0.0.1','内网IP','{\"age\":12,\"attachmentFileIds\":\"1\",\"avatarFileId\":\"1\",\"createTime\":\"2025-04-27 16:00:30\",\"education\":\"大学\",\"email\":\"2920902@qq.com\",\"gender\":\"male\",\"id\":1,\"jobIntention\":\"1\",\"name\":\"xxg\",\"params\":{},\"phone\":\"1234523131\",\"school\":\"福大\",\"status\":1,\"updateTime\":\"2025-04-27 16:34:43\",\"userId\":1,\"version\":1}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-27 16:34:43',18),(148,'代码生成',2,'com.qh.recruit.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"resume\",\"className\":\"Resume\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":54,\"columnName\":\"id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2025-04-26 18:37:16\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnId\":55,\"columnName\":\"user_id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2025-04-26 18:37:16\",\"usableColumn\":false},{\"capJavaField\":\"AvatarFileId\",\"columnComment\":\"头像文件ID\",\"columnId\":56,\"columnName\":\"avatar_file_id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"avatarFileId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2025-04-26 18:37:16\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnComment\":\"名称\",\"columnId\":57,\"columnName\":\"name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-26 16:41:45\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isL','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-27 17:04:58',161),(149,'简历',2,'com.qh.recruit.admin.controller.ResumeController.edit()','PUT',1,'admin','研发部门','/admin/resume','127.0.0.1','内网IP','{\"age\":12,\"attachmentFileIds\":\"/profile/upload/2025/04/27/2201.03545v2_20250427171124A001.pdf\",\"avatarFileId\":\"1\",\"createTime\":\"2025-04-27 16:00:30\",\"education\":\"大学\",\"email\":\"2920902@qq.com\",\"gender\":\"male\",\"id\":1,\"jobIntention\":\"1\",\"name\":\"xxg\",\"params\":{},\"phone\":\"1234523131\",\"school\":\"福大\",\"status\":1,\"updateTime\":\"2025-04-27 17:11:55\",\"userId\":1,\"version\":1}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-27 17:11:55',22),(150,'简历',2,'com.qh.recruit.admin.controller.ResumeController.edit()','PUT',1,'admin','研发部门','/admin/resume','127.0.0.1','内网IP','{\"age\":12,\"attachmentFileIds\":\"/profile/upload/2025/04/27/2201.03545v2_20250427171124A001.pdf,/profile/upload/2025/04/27/Lin 等 - 2017 - Feature Pyramid Networks for Object Detection-mono_20250427172108A001.pdf\",\"avatarFileId\":\"1\",\"createTime\":\"2025-04-27 16:00:30\",\"education\":\"大学\",\"email\":\"2920902@qq.com\",\"gender\":\"male\",\"id\":1,\"jobIntention\":\"1\",\"name\":\"xxg\",\"params\":{},\"phone\":\"1234523131\",\"school\":\"福大\",\"status\":1,\"updateTime\":\"2025-04-27 17:21:11\",\"userId\":1,\"version\":1}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-27 17:21:11',48),(151,'简历',2,'com.qh.recruit.admin.controller.ResumeController.edit()','PUT',1,'admin','研发部门','/admin/resume','127.0.0.1','内网IP','{\"age\":12,\"attachmentFileIds\":\"/profile/upload/2025/04/27/2201.03545v2_20250427171124A001.pdf\",\"avatarFileId\":\"1\",\"createTime\":\"2025-04-27 16:00:30\",\"education\":\"大学\",\"email\":\"2920902@qq.com\",\"gender\":\"male\",\"id\":1,\"jobIntention\":\"1\",\"name\":\"xxg\",\"params\":{},\"phone\":\"1234523131\",\"school\":\"福大\",\"status\":1,\"updateTime\":\"2025-04-27 17:21:53\",\"userId\":1,\"version\":1}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-27 17:21:53',17),(152,'简历',2,'com.qh.recruit.admin.controller.ResumeController.edit()','PUT',1,'admin','研发部门','/admin/resume','127.0.0.1','内网IP','{\"age\":12,\"attachmentFileIds\":\"\",\"avatarFileId\":\"1\",\"createTime\":\"2025-04-27 16:00:30\",\"education\":\"大学\",\"email\":\"2920902@qq.com\",\"gender\":\"male\",\"id\":1,\"jobIntention\":\"1\",\"name\":\"xxg\",\"params\":{},\"phone\":\"1234523131\",\"school\":\"福大\",\"status\":1,\"updateTime\":\"2025-04-27 17:28:28\",\"userId\":1,\"version\":1}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-27 17:28:28',22),(153,'简历',2,'com.qh.recruit.admin.controller.ResumeController.edit()','PUT',1,'admin','研发部门','/admin/resume','127.0.0.1','内网IP','{\"age\":12,\"attachmentFileIds\":\"/profile/upload/2025/04/27/d895a837544e180eb72385ac9ade189fadd705b7b59c1e4faa5cb64fc225a604_20250427174006A002.png\",\"avatarFileId\":\"1\",\"createTime\":\"2025-04-27 16:00:30\",\"education\":\"大学\",\"email\":\"2920902@qq.com\",\"gender\":\"male\",\"id\":1,\"jobIntention\":\"1\",\"name\":\"xxg\",\"params\":{},\"phone\":\"1234523131\",\"school\":\"福大\",\"status\":1,\"updateTime\":\"2025-04-27 17:40:09\",\"userId\":1,\"version\":1}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-27 17:40:09',21),(154,'简历',2,'com.qh.recruit.admin.controller.ResumeController.edit()','PUT',1,'admin','研发部门','/admin/resume','127.0.0.1','内网IP','{\"age\":12,\"attachmentFileIds\":\"/profile/upload/2025/04/27/d895a837544e180eb72385ac9ade189fadd705b7b59c1e4faa5cb64fc225a604_20250427174006A002.png,/profile/upload/2025/04/27/56936267-c6d8b204dabdf5991329f5d56713bc0dacee1fe6ba57379c014c55605c0c2f49_20250427174020A003.png\",\"avatarFileId\":\"1\",\"createTime\":\"2025-04-27 16:00:30\",\"education\":\"大学\",\"email\":\"2920902@qq.com\",\"gender\":\"male\",\"id\":1,\"jobIntention\":\"1\",\"name\":\"xxg\",\"params\":{},\"phone\":\"1234523131\",\"school\":\"福大\",\"status\":1,\"updateTime\":\"2025-04-27 17:40:24\",\"userId\":1,\"version\":1}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-27 17:40:24',19),(155,'企业管理',2,'com.qh.recruit.admin.controller.EtpController.edit()','PUT',1,'admin','研发部门','/admin/etp','127.0.0.1','内网IP','{\"address\":\"fuda1qu\",\"createTime\":\"2025-04-26 19:30:58\",\"description\":\"哈哈哈\",\"email\":\"13213131231\",\"id\":1,\"legalPerson\":\"nhb\",\"logoFileId\":\"1\",\"name\":\"企业1\",\"params\":{},\"phone\":\"1231231231\",\"popularity\":2,\"status\":1,\"updateTime\":\"2025-04-27 20:06:26\",\"userId\":1,\"version\":1,\"website\":\"12312313123123\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-27 20:06:26',31),(156,'企业管理',2,'com.qh.recruit.admin.controller.EtpController.edit()','PUT',1,'admin','研发部门','/admin/etp','127.0.0.1','内网IP','{\"address\":\"fuda1qu\",\"createTime\":\"2025-04-26 19:30:58\",\"description\":\"哈哈哈\",\"email\":\"13213131231\",\"id\":1,\"legalPerson\":\"nhb\",\"logoFileId\":\"/profile/upload/2025/04/27/8277739c0ad0aca092ff804e0c680f4d34ea70e11362320d635cd09019d88c8c_20250427201459A002.png\",\"name\":\"企业1\",\"params\":{},\"phone\":\"1231231231\",\"popularity\":2,\"status\":1,\"updateTime\":\"2025-04-27 20:15:01\",\"userId\":1,\"version\":1,\"website\":\"12312313123123\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-27 20:15:02',10),(157,'企业管理',2,'com.qh.recruit.admin.controller.EtpController.edit()','PUT',1,'admin','研发部门','/admin/etp','127.0.0.1','内网IP','{\"address\":\"fuda1qu\",\"createTime\":\"2025-04-26 19:30:58\",\"description\":\"哈哈哈\",\"email\":\"13213131231\",\"id\":1,\"legalPerson\":\"nhb\",\"logoFileId\":\"/profile/upload/2025/04/27/bg_20250427201550A003.jpg\",\"name\":\"企业1\",\"params\":{},\"phone\":\"1231231231\",\"popularity\":2,\"status\":1,\"updateTime\":\"2025-04-27 20:15:52\",\"userId\":1,\"version\":1,\"website\":\"12312313123123\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-27 20:15:52',6),(158,'简历',2,'com.qh.recruit.admin.controller.ResumeController.edit()','PUT',1,'admin','研发部门','/admin/resume','127.0.0.1','内网IP','{\"age\":12,\"attachmentFileIds\":\"/profile/upload/2025/04/27/d895a837544e180eb72385ac9ade189fadd705b7b59c1e4faa5cb64fc225a604_20250427174006A002.png,/profile/upload/2025/04/27/56936267-c6d8b204dabdf5991329f5d56713bc0dacee1fe6ba57379c014c55605c0c2f49_20250427174020A003.png\",\"avatarFileId\":\"/profile/upload/2025/04/27/bg_20250427202054A004.jpg\",\"createTime\":\"2025-04-27 16:00:30\",\"education\":\"大学\",\"email\":\"2920902@qq.com\",\"gender\":\"male\",\"id\":1,\"jobIntention\":\"1\",\"name\":\"xxg\",\"params\":{},\"phone\":\"1234523131\",\"school\":\"福大\",\"status\":1,\"updateTime\":\"2025-04-27 20:21:09\",\"userId\":1,\"version\":1}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-27 20:21:09',36),(159,'岗位',1,'com.qh.recruit.admin.controller.JobController.add()','POST',1,'admin','研发部门','/admin/job','127.0.0.1','内网IP','{\"categoryIds\":\"1\",\"createTime\":\"2025-04-27 20:37:40\",\"description\":\"123123123\",\"etpId\":1,\"id\":1,\"location\":\"23123132\",\"name\":\"研发工程师\",\"params\":{},\"popularity\":1,\"requirement\":\"会java\",\"salaryDesc\":\"111\",\"tagIds\":\"1\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-27 20:37:40',50),(160,'标签管理',1,'com.qh.recruit.admin.controller.TagController.add()','POST',1,'admin','研发部门','/admin/tag','127.0.0.1','内网IP','{\"createTime\":\"2025-04-28 15:50:42\",\"id\":1,\"name\":\"java\",\"params\":{},\"popularity\":1}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-28 15:50:43',32),(161,'标签管理',1,'com.qh.recruit.admin.controller.TagController.add()','POST',1,'admin','研发部门','/admin/tag','127.0.0.1','内网IP','{\"createTime\":\"2025-04-28 15:50:52\",\"id\":2,\"name\":\"python\",\"params\":{},\"popularity\":1}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-28 15:50:52',18),(162,'标签管理',1,'com.qh.recruit.admin.controller.TagController.add()','POST',1,'admin','研发部门','/admin/tag','127.0.0.1','内网IP','{\"createTime\":\"2025-04-28 15:51:03\",\"id\":3,\"name\":\"双休\",\"params\":{},\"popularity\":1}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-28 15:51:03',16),(163,'标签管理',1,'com.qh.recruit.admin.controller.TagController.add()','POST',1,'admin','研发部门','/admin/tag','127.0.0.1','内网IP','{\"createTime\":\"2025-04-28 15:51:09\",\"id\":4,\"name\":\"996\",\"params\":{},\"popularity\":1}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-28 15:51:09',22),(164,'分类管理',1,'com.qh.recruit.admin.controller.CategoryController.add()','POST',1,'admin','研发部门','/admin/category','127.0.0.1','内网IP','{\"createTime\":\"2025-04-28 15:51:20\",\"id\":2,\"name\":\"计算机\",\"params\":{}}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-28 15:51:20',14),(165,'分类管理',1,'com.qh.recruit.admin.controller.CategoryController.add()','POST',1,'admin','研发部门','/admin/category','127.0.0.1','内网IP','{\"createTime\":\"2025-04-28 15:51:29\",\"id\":3,\"name\":\"福州\",\"params\":{}}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-28 15:51:29',17),(166,'分类管理',1,'com.qh.recruit.admin.controller.CategoryController.add()','POST',1,'admin','研发部门','/admin/category','127.0.0.1','内网IP','{\"createTime\":\"2025-04-28 15:51:40\",\"id\":4,\"name\":\"厦门\",\"params\":{}}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-28 15:51:40',19),(167,'用户管理',1,'com.qh.recruit.admin.controller.UserController.add()','POST',1,'admin','研发部门','/admin/user','127.0.0.1','内网IP','{\"createTime\":\"2025-04-28 16:55:49\",\"id\":2,\"params\":{},\"userType\":\"job_seeker\",\"username\":\"2\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-28 16:55:49',300),(168,'用户管理',2,'com.qh.recruit.admin.controller.UserController.edit()','PUT',1,'admin','研发部门','/admin/user','127.0.0.1','内网IP','{\"createTime\":\"2025-04-28 16:55:49\",\"id\":2,\"params\":{},\"status\":1,\"updateTime\":\"2025-04-28 16:56:07\",\"userType\":\"job_seeker\",\"username\":\"et\",\"version\":1}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-28 16:56:07',14),(169,'用户管理',1,'com.qh.recruit.admin.controller.UserController.add()','POST',1,'admin','研发部门','/admin/user','127.0.0.1','内网IP','{\"createTime\":\"2025-04-28 16:56:12\",\"id\":3,\"params\":{},\"userType\":\"enterprise\",\"username\":\"333\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-28 16:56:12',19),(170,'用户管理',1,'com.qh.recruit.admin.controller.UserController.add()','POST',1,'admin','研发部门','/admin/user','127.0.0.1','内网IP','{\"createTime\":\"2025-04-28 16:56:21\",\"id\":4,\"params\":{},\"userType\":\"enterprise\",\"username\":\"444\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-28 16:56:21',7),(171,'企业管理',1,'com.qh.recruit.admin.controller.EtpController.add()','POST',1,'admin','研发部门','/admin/etp','127.0.0.1','内网IP','{\"address\":\"2\",\"createTime\":\"2025-04-28 17:12:39\",\"description\":\"2\",\"email\":\"2\",\"legalPerson\":\"2\",\"logoFileId\":\"/profile/upload/2025/04/28/bg_20250428171234A001.jpg\",\"name\":\"2\",\"params\":{},\"phone\":\"2\",\"popularity\":2,\"website\":\"2\"}',NULL,1,'\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'user_id\' doesn\'t have a default value\r\n### The error may exist in file [D:\\edge\\20250426152951\\qh\\qh-admin\\target\\classes\\mapper\\admin\\EtpMapper.xml]\r\n### The error may involve com.qh.recruit.admin.mapper.EtpMapper.insertEtp-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into tb_etp          ( logo_file_id,             name,             description,             legal_person,             address,             phone,             email,             website,             popularity,             create_time )           values ( ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'user_id\' doesn\'t have a default value\n; Field \'user_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'user_id\' doesn\'t have a default value','2025-04-28 17:12:39',88),(172,'企业管理',1,'com.qh.recruit.admin.controller.EtpController.add()','POST',1,'admin','研发部门','/admin/etp','127.0.0.1','内网IP','{\"address\":\"2\",\"createTime\":\"2025-04-28 17:14:10\",\"description\":\"2\",\"email\":\"2\",\"id\":2,\"legalPerson\":\"2\",\"logoFileId\":\"/profile/upload/2025/04/28/bg_20250428171405A002.jpg\",\"name\":\"2\",\"params\":{},\"phone\":\"2\",\"popularity\":2,\"userId\":2,\"website\":\"2\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-28 17:14:10',8),(173,'分类管理',1,'com.qh.recruit.admin.controller.CategoryController.add()','POST',1,'admin','研发部门','/admin/category','127.0.0.1','内网IP','{\"createTime\":\"2025-04-28 19:17:08\",\"id\":5,\"name\":\"555\",\"params\":{}}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-28 19:17:08',303),(174,'分类管理',1,'com.qh.recruit.admin.controller.CategoryController.add()','POST',1,'admin','研发部门','/admin/category','127.0.0.1','内网IP','{\"createTime\":\"2025-05-02 16:00:39\",\"id\":6,\"name\":\"666\",\"params\":{}}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-02 16:00:46',7255),(175,'分类管理',1,'com.qh.recruit.admin.controller.CategoryController.add()','POST',1,'admin','研发部门','/admin/category','127.0.0.1','内网IP','{\"createTime\":\"2025-05-02 16:03:47\",\"id\":7,\"name\":\"677\",\"params\":{}}','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createTime\":\"2025-05-02 16:03:47\",\"id\":7,\"name\":\"677\",\"params\":{},\"status\":1,\"updateTime\":\"2025-05-02 16:03:49\",\"version\":1}}',0,NULL,'2025-05-02 16:03:49',2422),(176,'分类管理',1,'com.qh.recruit.admin.controller.CategoryController.add()','POST',1,'admin','研发部门','/admin/category','127.0.0.1','内网IP','{\"createTime\":\"2025-05-02 16:04:37\",\"id\":8,\"name\":\"8\",\"params\":{}}','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createTime\":\"2025-05-02 16:04:38\",\"id\":8,\"name\":\"8\",\"params\":{},\"status\":1,\"updateTime\":\"2025-05-02 16:04:37\",\"version\":1}}',0,NULL,'2025-05-02 16:04:37',16),(177,'分类管理',1,'com.qh.recruit.admin.controller.CategoryController.add()','POST',1,'admin','研发部门','/admin/category','127.0.0.1','内网IP','{\"createTime\":\"2025-05-02 16:07:06\",\"id\":9,\"name\":\"2334\",\"params\":{}}','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createTime\":\"2025-05-02 16:07:06\",\"id\":9,\"name\":\"2334\",\"params\":{},\"status\":1,\"updateTime\":\"2025-05-02 16:07:06\",\"version\":1}}',0,NULL,'2025-05-02 16:07:06',24),(178,'标签管理',1,'com.qh.recruit.admin.controller.TagController.add()','POST',1,'admin','研发部门','/admin/tag','127.0.0.1','内网IP','{\"createTime\":\"2025-05-02 16:21:53\",\"id\":5,\"name\":\"777\",\"params\":{}}','{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createTime\":\"2025-05-02 16:21:54\",\"id\":5,\"name\":\"777\",\"params\":{},\"popularity\":0,\"status\":1,\"updateTime\":\"2025-05-02 16:21:53\",\"version\":1}}',0,NULL,'2025-05-02 16:21:53',24),(179,'岗位',2,'com.qh.recruit.admin.controller.JobController.edit()','PUT',1,'admin','研发部门','/admin/job','127.0.0.1','内网IP','{\"categoryIds\":\"1,6\",\"createTime\":\"2025-04-27 20:37:41\",\"description\":\"123123123\",\"etpId\":1,\"id\":1,\"location\":\"23123132\",\"name\":\"研发工程师\",\"params\":{},\"popularity\":1,\"requirement\":\"会java\",\"salaryDesc\":\"111\",\"status\":1,\"tagIds\":\"1,2,3,5\",\"updateTime\":\"2025-05-02 16:24:43\",\"version\":1}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-02 16:24:43',21),(180,'代码生成',6,'com.qh.recruit.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"tb_communicate\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-02 17:12:56',415),(181,'代码生成',2,'com.qh.recruit.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"communicate\",\"className\":\"Communicate\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":106,\"columnName\":\"id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-05-02 17:12:56\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":11,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"PosterId\",\"columnId\":107,\"columnName\":\"poster_id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-05-02 17:12:56\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"posterId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":11,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ReceiverId\",\"columnId\":108,\"columnName\":\"receiver_id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-05-02 17:12:56\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"receiverId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":11,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"PreviousId\",\"columnId\":109,\"columnName\":\"previous_id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-05-02 17:12:56\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"previousId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\"','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-02 17:15:28',136),(182,'代码生成',8,'com.qh.recruit.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"tb_communicate\"}',NULL,0,NULL,'2025-05-02 17:15:33',918),(183,'代码生成',2,'com.qh.recruit.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"communicate\",\"className\":\"Communicate\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":106,\"columnName\":\"id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-05-02 17:12:56\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":11,\"updateBy\":\"\",\"updateTime\":\"2025-05-02 17:15:28\",\"usableColumn\":false},{\"capJavaField\":\"PosterId\",\"columnComment\":\"发送方\",\"columnId\":107,\"columnName\":\"poster_id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-05-02 17:12:56\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"posterId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":11,\"updateBy\":\"\",\"updateTime\":\"2025-05-02 17:15:28\",\"usableColumn\":false},{\"capJavaField\":\"ReceiverId\",\"columnComment\":\"接收方\",\"columnId\":108,\"columnName\":\"receiver_id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-05-02 17:12:56\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"receiverId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":11,\"updateBy\":\"\",\"updateTime\":\"2025-05-02 17:15:28\",\"usableColumn\":false},{\"capJavaField\":\"PreviousId\",\"columnComment\":\"上一条\",\"columnId\":109,\"columnName\":\"previous_id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-05-02 17:12:56\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":f','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-02 19:11:44',181),(184,'字典类型',1,'com.qh.recruit.web.controller.system.SysDictTypeController.add()','POST',1,'admin','研发部门','/system/dict/type','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"dictName\":\"沟通消息类型\",\"dictType\":\"communicate_content_type\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-02 19:17:01',24),(185,'字典数据',1,'com.qh.recruit.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"文本\",\"dictSort\":0,\"dictType\":\"communicate_content_type\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-02 19:17:26',25),(186,'字典数据',1,'com.qh.recruit.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"图片\",\"dictSort\":1,\"dictType\":\"communicate_content_type\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-02 19:17:36',24),(187,'字典数据',1,'com.qh.recruit.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"附件\",\"dictSort\":2,\"dictType\":\"communicate_content_type\",\"dictValue\":\"2\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-02 19:17:52',23),(188,'代码生成',2,'com.qh.recruit.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"communicate\",\"className\":\"Communicate\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":106,\"columnName\":\"id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-05-02 17:12:56\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":11,\"updateBy\":\"\",\"updateTime\":\"2025-05-02 19:11:44\",\"usableColumn\":false},{\"capJavaField\":\"PosterId\",\"columnComment\":\"发送方\",\"columnId\":107,\"columnName\":\"poster_id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-05-02 17:12:56\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"posterId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":11,\"updateBy\":\"\",\"updateTime\":\"2025-05-02 19:11:44\",\"usableColumn\":false},{\"capJavaField\":\"ReceiverId\",\"columnComment\":\"接收方\",\"columnId\":108,\"columnName\":\"receiver_id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-05-02 17:12:56\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"receiverId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":11,\"updateBy\":\"\",\"updateTime\":\"2025-05-02 19:11:44\",\"usableColumn\":false},{\"capJavaField\":\"PreviousId\",\"columnComment\":\"上一条\",\"columnId\":109,\"columnName\":\"previous_id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-05-02 17:12:56\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"incre','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-02 19:28:35',94),(189,'沟通',1,'com.qh.recruit.admin.controller.CommunicateController.add()','POST',1,'admin','研发部门','/admin/communicate','127.0.0.1','内网IP','{\"content\":\"你好\",\"contentType\":\"0\",\"createTime\":\"2025-05-02 19:41:53\",\"id\":1,\"params\":{},\"posterId\":1,\"previousId\":-1,\"receiverId\":2}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-02 19:41:53',33),(190,'沟通',1,'com.qh.recruit.admin.controller.CommunicateController.add()','POST',1,'admin','研发部门','/admin/communicate','127.0.0.1','内网IP','{\"content\":\"咋啦\",\"contentType\":\"0\",\"createTime\":\"2025-05-02 19:42:02\",\"id\":2,\"params\":{},\"posterId\":2,\"previousId\":1,\"receiverId\":1}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-02 19:42:03',14),(191,'菜单管理',2,'com.qh.recruit.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"admin/communicate/index\",\"createTime\":\"2025-05-02 19:03:54\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2055,\"menuName\":\"沟通管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"communicate\",\"perms\":\"admin:communicate:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-02 19:52:42',31),(192,'菜单管理',2,'com.qh.recruit.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"admin/comment/index\",\"createTime\":\"2025-04-26 19:14:12\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2007,\"menuName\":\"评价管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"comment\",\"perms\":\"admin:comment:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-02 19:52:52',15),(193,'菜单管理',2,'com.qh.recruit.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"admin/interview/index\",\"createTime\":\"2025-04-26 19:14:28\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2025,\"menuName\":\"面试管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"interview\",\"perms\":\"admin:interview:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-02 19:53:00',25),(194,'菜单管理',2,'com.qh.recruit.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"admin/job/index\",\"createTime\":\"2025-04-26 19:14:34\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2031,\"menuName\":\"岗位管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"job\",\"perms\":\"admin:job:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-02 19:53:07',14),(195,'菜单管理',2,'com.qh.recruit.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"admin/resume/index\",\"createTime\":\"2025-04-26 19:14:39\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2037,\"menuName\":\"简历管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"resume\",\"perms\":\"admin:resume:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-05-02 19:53:13',14),(196,'用户管理',5,'com.qh.recruit.admin.controller.UserController.export()','POST',1,'admin','研发部门','/admin/user/export','127.0.0.1','内网IP','{\"pageSize\":\"10\",\"pageNum\":\"1\"}',NULL,0,NULL,'2025-05-02 20:00:35',987);
/*!40000 ALTER TABLE `sys_oper_log` ENABLE KEYS */;

--
-- Table structure for table `qrtz_fired_triggers`
--

DROP TABLE IF EXISTS `qrtz_fired_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_fired_triggers` (
                                       `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
                                       `entry_id` varchar(95) NOT NULL COMMENT '调度器实例id',
                                       `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
                                       `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
                                       `instance_name` varchar(200) NOT NULL COMMENT '调度器实例名',
                                       `fired_time` bigint(13) NOT NULL COMMENT '触发的时间',
                                       `sched_time` bigint(13) NOT NULL COMMENT '定时器制定的时间',
                                       `priority` int(11) NOT NULL COMMENT '优先级',
                                       `state` varchar(16) NOT NULL COMMENT '状态',
                                       `job_name` varchar(200) DEFAULT NULL COMMENT '任务名称',
                                       `job_group` varchar(200) DEFAULT NULL COMMENT '任务组名',
                                       `is_nonconcurrent` varchar(1) DEFAULT NULL COMMENT '是否并发',
                                       `requests_recovery` varchar(1) DEFAULT NULL COMMENT '是否接受恢复执行',
                                       PRIMARY KEY (`sched_name`,`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='已触发的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_fired_triggers`
--

/*!40000 ALTER TABLE `qrtz_fired_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_fired_triggers` ENABLE KEYS */;

--
-- Table structure for table `gen_table`
--

DROP TABLE IF EXISTS `gen_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gen_table` (
                             `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                             `table_name` varchar(200) DEFAULT '' COMMENT '表名称',
                             `table_comment` varchar(500) DEFAULT '' COMMENT '表描述',
                             `sub_table_name` varchar(64) DEFAULT NULL COMMENT '关联子表的表名',
                             `sub_table_fk_name` varchar(64) DEFAULT NULL COMMENT '子表关联的外键名',
                             `class_name` varchar(100) DEFAULT '' COMMENT '实体类名称',
                             `tpl_category` varchar(200) DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
                             `tpl_web_type` varchar(30) DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
                             `package_name` varchar(100) DEFAULT NULL COMMENT '生成包路径',
                             `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
                             `business_name` varchar(30) DEFAULT NULL COMMENT '生成业务名',
                             `function_name` varchar(50) DEFAULT NULL COMMENT '生成功能名',
                             `function_author` varchar(50) DEFAULT NULL COMMENT '生成功能作者',
                             `gen_type` char(1) DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
                             `gen_path` varchar(200) DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
                             `options` varchar(1000) DEFAULT NULL COMMENT '其它生成选项',
                             `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                             `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                             `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                             `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                             `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                             PRIMARY KEY (`table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='代码生成业务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table`
--

/*!40000 ALTER TABLE `gen_table` DISABLE KEYS */;
INSERT INTO `gen_table` VALUES (1,'tb_category','分类',NULL,NULL,'Category','crud','element-ui','com.qh.recruit.admin','admin','category','分类管理','ruoyi','0','/','{\"parentMenuId\":2000}','admin','2025-04-26 16:41:45','','2025-04-26 17:17:42',NULL),(2,'tb_comment','评价',NULL,NULL,'Comment','crud','element-ui','com.qh.recruit.admin','admin','comment','评价','ruoyi','0','/','{\"parentMenuId\":2000}','admin','2025-04-26 16:41:45','','2025-04-26 17:20:01',NULL),(3,'tb_etp','企业',NULL,NULL,'Etp','crud','element-ui','com.qh.recruit.admin','admin','etp','企业管理','ruoyi','0','/','{\"parentMenuId\":2000}','admin','2025-04-26 16:41:45','','2025-04-26 17:26:48',NULL),(5,'tb_job','工作',NULL,NULL,'Job','crud','element-ui','com.qh.recruit.admin','admin','job','岗位','ruoyi','0','/','{\"parentMenuId\":2000}','admin','2025-04-26 16:41:45','','2025-04-26 18:31:16',NULL),(6,'tb_resume','简历',NULL,NULL,'Resume','crud','element-ui','com.qh.recruit.admin','admin','resume','简历','ruoyi','0','/','{\"parentMenuId\":2000}','admin','2025-04-26 16:41:45','','2025-04-27 17:04:58',NULL),(7,'tb_tag','标签管理',NULL,NULL,'Tag','crud','element-ui','com.qh.recruit.admin','admin','tag','标签管理','ruoyi','0','/','{\"parentMenuId\":2000}','admin','2025-04-26 16:41:46','','2025-04-26 17:16:13',NULL),(8,'tb_user','用户',NULL,NULL,'User','crud','element-ui','com.qh.recruit.admin','admin','user','用户管理','ruoyi','0','/','{\"parentMenuId\":2000}','admin','2025-04-26 16:41:46','','2025-04-26 17:15:52',NULL),(10,'tb_interview','面试',NULL,NULL,'Interview','crud','element-ui','com.qh.recruit.admin','admin','interview','面试','ruoyi','0','/','{\"parentMenuId\":2000}','admin','2025-04-26 18:25:33','','2025-04-26 18:31:23',NULL),(11,'tb_communicate','沟通表',NULL,NULL,'Communicate','crud','element-ui','com.qh.recruit.admin','admin','communicate','沟通','ruoyi','0','/','{\"parentMenuId\":2000}','admin','2025-05-02 17:12:56','','2025-05-02 19:28:35',NULL);
/*!40000 ALTER TABLE `gen_table` ENABLE KEYS */;

--
-- Table structure for table `gen_table_column`
--

DROP TABLE IF EXISTS `gen_table_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gen_table_column` (
                                    `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                    `table_id` bigint(20) DEFAULT NULL COMMENT '归属表编号',
                                    `column_name` varchar(200) DEFAULT NULL COMMENT '列名称',
                                    `column_comment` varchar(500) DEFAULT NULL COMMENT '列描述',
                                    `column_type` varchar(100) DEFAULT NULL COMMENT '列类型',
                                    `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
                                    `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
                                    `is_pk` char(1) DEFAULT NULL COMMENT '是否主键（1是）',
                                    `is_increment` char(1) DEFAULT NULL COMMENT '是否自增（1是）',
                                    `is_required` char(1) DEFAULT NULL COMMENT '是否必填（1是）',
                                    `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段（1是）',
                                    `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段（1是）',
                                    `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段（1是）',
                                    `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段（1是）',
                                    `query_type` varchar(200) DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
                                    `html_type` varchar(200) DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
                                    `dict_type` varchar(200) DEFAULT '' COMMENT '字典类型',
                                    `sort` int(11) DEFAULT NULL COMMENT '排序',
                                    `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                                    `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                    `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                                    `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                    PRIMARY KEY (`column_id`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8 COMMENT='代码生成业务表字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table_column`
--

/*!40000 ALTER TABLE `gen_table_column` DISABLE KEYS */;
INSERT INTO `gen_table_column` VALUES (1,1,'id',NULL,'bigint(20)','Long','id','1','1','0','0',NULL,NULL,NULL,'EQ','input','',1,'admin','2025-04-26 16:41:45','','2025-04-26 17:17:42'),(2,1,'name',NULL,'varchar(100)','String','name','0','0','1','1','1','1','1','LIKE','input','',2,'admin','2025-04-26 16:41:45','','2025-04-26 17:17:42'),(3,1,'create_time',NULL,'datetime','Date','createTime','0','0','0','0',NULL,'1',NULL,'EQ','datetime','',3,'admin','2025-04-26 16:41:45','','2025-04-26 17:17:42'),(4,1,'update_time',NULL,'datetime','Date','updateTime','0','0','0','0','0','1',NULL,'EQ','datetime','',4,'admin','2025-04-26 16:41:45','','2025-04-26 17:17:42'),(5,1,'status',NULL,'tinyint(4)','Integer','status','0','0','0','1','0','0','0','EQ','radio','',5,'admin','2025-04-26 16:41:45','','2025-04-26 17:17:42'),(6,1,'version',NULL,'int(11)','Long','version','0','0','0','0','0','0','0','EQ','input','',6,'admin','2025-04-26 16:41:45','','2025-04-26 17:17:42'),(7,2,'id',NULL,'bigint(20)','Long','id','1','1','0','0',NULL,NULL,NULL,'EQ','input','',1,'admin','2025-04-26 16:41:45','','2025-04-26 17:20:01'),(8,2,'operator_id','操作者id','bigint(20)','Long','operatorId','0','0','1','1','1','1','1','EQ','input','',2,'admin','2025-04-26 16:41:45','','2025-04-26 17:20:01'),(9,2,'target_type','评价对象类型','enum(\'job\',\'enterprise\',\'job_seeker\')','String','targetType','0','0','1','1','1','1','1','EQ','select','user_type',3,'admin','2025-04-26 16:41:45','','2025-04-26 17:20:01'),(10,2,'target_id','评价对象id','bigint(20)','Long','targetId','0','0','1','1','1','1','1','EQ','input','',4,'admin','2025-04-26 16:41:45','','2025-04-26 17:20:01'),(11,2,'score','分数','int(11)','Long','score','0','0','0','1','1','1','1','EQ','input','',5,'admin','2025-04-26 16:41:45','','2025-04-26 17:20:01'),(12,2,'create_time',NULL,'datetime','Date','createTime','0','0','0','0',NULL,'1',NULL,'EQ','datetime','',6,'admin','2025-04-26 16:41:45','','2025-04-26 17:20:01'),(13,2,'update_time',NULL,'datetime','Date','updateTime','0','0','0','0','0','1',NULL,'EQ','datetime','',7,'admin','2025-04-26 16:41:45','','2025-04-26 17:20:01'),(14,2,'status',NULL,'tinyint(4)','Integer','status','0','0','0','1','1','1','1','EQ','radio','',8,'admin','2025-04-26 16:41:45','','2025-04-26 17:20:01'),(15,2,'version',NULL,'int(11)','Long','version','0','0','0','1','1','1','1','EQ','input','',9,'admin','2025-04-26 16:41:45','','2025-04-26 17:20:01'),(16,3,'id',NULL,'bigint(20)','Long','id','1','1','0','0',NULL,NULL,NULL,'EQ','input','',1,'admin','2025-04-26 16:41:45','','2025-04-26 17:26:48'),(17,3,'user_id','todo','bigint(20)','Long','userId','0','0','1','1','1','1','1','EQ','input','',2,'admin','2025-04-26 16:41:45','','2025-04-26 17:26:48'),(18,3,'logo_file_id','todo','varchar(255)','String','logoFileId','0','0','0','1','1','1','0','EQ','input','',3,'admin','2025-04-26 16:41:45','','2025-04-26 17:26:48'),(19,3,'name','企业名称','varchar(100)','String','name','0','0','1','1','1','1','1','LIKE','input','',4,'admin','2025-04-26 16:41:45','','2025-04-26 17:26:48'),(20,3,'description','宣传信息','text','String','description','0','0','0','1','1','1','0','EQ','textarea','',5,'admin','2025-04-26 16:41:45','','2025-04-26 17:26:48'),(21,3,'legal_person','法人','varchar(100)','String','legalPerson','0','0','1','1','1','1','1','LIKE','input','',6,'admin','2025-04-26 16:41:45','','2025-04-26 17:26:48'),(22,3,'address','地址','varchar(255)','String','address','0','0','0','1','1','1','0','EQ','input','',7,'admin','2025-04-26 16:41:45','','2025-04-26 17:26:48'),(23,3,'phone','电话','varchar(20)','String','phone','0','0','0','1','1','1','1','LIKE','input','',8,'admin','2025-04-26 16:41:45','','2025-04-26 17:26:48'),(24,3,'email','电子邮件','varchar(100)','String','email','0','0','0','1','1','1','0','EQ','input','',9,'admin','2025-04-26 16:41:45','','2025-04-26 17:26:48'),(25,3,'website','官网','varchar(255)','String','website','0','0','0','1','1','1','1','LIKE','input','',10,'admin','2025-04-26 16:41:45','','2025-04-26 17:26:48'),(26,3,'popularity','企业热度','int(11)','Long','popularity','0','0','0','1','1','1','1','EQ','input','',11,'admin','2025-04-26 16:41:45','','2025-04-26 17:26:48'),(27,3,'create_time','创建时间','datetime','Date','createTime','0','0','0','0',NULL,'1',NULL,'EQ','datetime','',12,'admin','2025-04-26 16:41:45','','2025-04-26 17:26:48'),(28,3,'update_time','更新时间','datetime','Date','updateTime','0','0','0','0','0','1',NULL,'EQ','datetime','',13,'admin','2025-04-26 16:41:45','','2025-04-26 17:26:48'),(29,3,'status',NULL,'tinyint(4)','Integer','status','0','0','0','0','0','0','0','EQ','radio','',14,'admin','2025-04-26 16:41:45','','2025-04-26 17:26:48'),(30,3,'version',NULL,'int(11)','Long','version','0','0','0','0','0','0','0','EQ','input','',15,'admin','2025-04-26 16:41:45','','2025-04-26 17:26:48'),(40,5,'id',NULL,'bigint(20)','Long','id','1','1','0','0',NULL,NULL,NULL,'EQ','input','',1,'admin','2025-04-26 16:41:45','','2025-04-26 18:31:16'),(41,5,'name','名称','varchar(100)','String','name','0','0','1','1','1','1','1','LIKE','input','',2,'admin','2025-04-26 16:41:45','','2025-04-26 18:31:16'),(42,5,'description','岗位职责','text','String','description','0','0','1','1','1','1','1','LIKE','textarea','',3,'admin','2025-04-26 16:41:45','','2025-04-26 18:31:16'),(43,5,'salary_desc','todo','varchar(100)','String','salaryDesc','0','0','0','1','1','1','0','EQ','input','',4,'admin','2025-04-26 16:41:45','','2025-04-26 18:31:16'),(44,5,'location','工作地点','varchar(255)','String','location','0','0','0','1','1','1','0','EQ','input','',5,'admin','2025-04-26 16:41:45','','2025-04-26 18:31:16'),(45,5,'requirement','要求条件','text','String','requirement','0','0','0','1','1','1','0','EQ','textarea','',6,'admin','2025-04-26 16:41:45','','2025-04-26 18:31:16'),(46,5,'etp_id',NULL,'bigint(20)','Long','etpId','0','0','0','1','1','1','0','EQ','input','',7,'admin','2025-04-26 16:41:45','','2025-04-26 18:31:16'),(47,5,'category_ids','todo','varchar(255)','String','categoryIds','0','0','0','1','1','1','0','EQ','input','',8,'admin','2025-04-26 16:41:45','','2025-04-26 18:31:16'),(48,5,'tag_ids','标签ID，以逗号分隔','varchar(255)','String','tagIds','0','0','0','1','1','1','0','EQ','input','',9,'admin','2025-04-26 16:41:45','','2025-04-26 18:31:16'),(49,5,'popularity','岗位热度','int(11)','Long','popularity','0','0','0','1','1','1','0','EQ','input','',10,'admin','2025-04-26 16:41:45','','2025-04-26 18:31:16'),(50,5,'create_time',NULL,'datetime','Date','createTime','0','0','0','0',NULL,'1',NULL,'EQ','datetime','',11,'admin','2025-04-26 16:41:45','','2025-04-26 18:31:16'),(51,5,'update_time',NULL,'datetime','Date','updateTime','0','0','0','0','0','1',NULL,'EQ','datetime','',12,'admin','2025-04-26 16:41:45','','2025-04-26 18:31:16'),(52,5,'status',NULL,'tinyint(4)','Integer','status','0','0','0','0','0','0','0','EQ','radio','',13,'admin','2025-04-26 16:41:45','','2025-04-26 18:31:16'),(53,5,'version',NULL,'int(11)','Long','version','0','0','0','0','0','0','0','EQ','input','',14,'admin','2025-04-26 16:41:45','','2025-04-26 18:31:16'),(54,6,'id',NULL,'bigint(20)','Long','id','1','1','0','0',NULL,NULL,NULL,'EQ','input','',1,'admin','2025-04-26 16:41:45','','2025-04-27 17:04:58'),(55,6,'user_id',NULL,'bigint(20)','Long','userId','0','0','1','1','1','1','0','EQ','input','',2,'admin','2025-04-26 16:41:45','','2025-04-27 17:04:58'),(56,6,'avatar_file_id','头像文件ID','varchar(255)','String','avatarFileId','0','0','0','1','1','1','0','EQ','input','',3,'admin','2025-04-26 16:41:45','','2025-04-27 17:04:58'),(57,6,'name','名称','varchar(50)','String','name','0','0','1','1','1','1','1','LIKE','input','',4,'admin','2025-04-26 16:41:45','','2025-04-27 17:04:58'),(58,6,'gender','性别','enum(\'male\',\'female\',\'other\')','String','gender','0','0','1','1','1','1','0','EQ',NULL,'',5,'admin','2025-04-26 16:41:45','','2025-04-27 17:04:58'),(59,6,'age','年龄','int(11)','Long','age','0','0','0','1','1','1','0','EQ','input','',6,'admin','2025-04-26 16:41:45','','2025-04-27 17:04:58'),(60,6,'education','教育经历','varchar(50)','String','education','0','0','0','1','1','1','1','EQ','input','',7,'admin','2025-04-26 16:41:45','','2025-04-27 17:04:58'),(61,6,'school','毕业院校','varchar(100)','String','school','0','0','0','1','1','1','1','EQ','input','',8,'admin','2025-04-26 16:41:45','','2025-04-27 17:04:58'),(62,6,'phone','联系电话','varchar(20)','String','phone','0','0','0','1','1','1','1','EQ','input','',9,'admin','2025-04-26 16:41:45','','2025-04-27 17:04:58'),(63,6,'email','电子邮件','varchar(100)','String','email','0','0','0','1','1','1','1','EQ','input','',10,'admin','2025-04-26 16:41:45','','2025-04-27 17:04:58'),(64,6,'job_intention',NULL,'varchar(255)','String','jobIntention','0','0','0','1','1','1','0','EQ','textarea','',11,'admin','2025-04-26 16:41:45','','2025-04-27 17:04:58'),(65,6,'attachment_file_ids','简历附件','text','String','attachmentFileIds','0','0','0','1','1','1','0','EQ','fileUpload','',12,'admin','2025-04-26 16:41:45','','2025-04-27 17:04:58'),(66,6,'create_time',NULL,'datetime','Date','createTime','0','0','0','0',NULL,'1',NULL,'EQ','datetime','',13,'admin','2025-04-26 16:41:45','','2025-04-27 17:04:58'),(67,6,'update_time',NULL,'datetime','Date','updateTime','0','0','0','0','0','1',NULL,'EQ','datetime','',14,'admin','2025-04-26 16:41:46','','2025-04-27 17:04:58'),(68,6,'status',NULL,'tinyint(4)','Integer','status','0','0','0','0','0','0','0','EQ','radio','',15,'admin','2025-04-26 16:41:46','','2025-04-27 17:04:58'),(69,6,'version',NULL,'int(11)','Long','version','0','0','0','0','0','0','0','EQ','input','',16,'admin','2025-04-26 16:41:46','','2025-04-27 17:04:58'),(70,7,'id',NULL,'bigint(20)','Long','id','1','1','0','0',NULL,NULL,NULL,'EQ','input','',1,'admin','2025-04-26 16:41:46','','2025-04-26 17:16:13'),(71,7,'name','名称','varchar(100)','String','name','0','0','1','1','1','1','1','LIKE','input','',2,'admin','2025-04-26 16:41:46','','2025-04-26 17:16:13'),(72,7,'popularity','标签热度','int(11)','Long','popularity','0','0','0','1','1','1','0','EQ','input','',3,'admin','2025-04-26 16:41:46','','2025-04-26 17:16:13'),(73,7,'create_time',NULL,'datetime','Date','createTime','0','0','0','0',NULL,'1',NULL,'EQ','datetime','',4,'admin','2025-04-26 16:41:46','','2025-04-26 17:16:13'),(74,7,'update_time',NULL,'datetime','Date','updateTime','0','0','0','0','0','1',NULL,'EQ','datetime','',5,'admin','2025-04-26 16:41:46','','2025-04-26 17:16:13'),(75,7,'status',NULL,'tinyint(4)','Integer','status','0','0','0','0','0','0','0','EQ','radio','',6,'admin','2025-04-26 16:41:46','','2025-04-26 17:16:13'),(76,7,'version',NULL,'int(11)','Long','version','0','0','0','0','0','0','0','EQ','input','',7,'admin','2025-04-26 16:41:46','','2025-04-26 17:16:13'),(77,8,'id',NULL,'bigint(20)','Long','id','1','1','0','0',NULL,NULL,NULL,'EQ','input','',1,'admin','2025-04-26 16:41:46','','2025-04-26 17:15:52'),(78,8,'username','用户名','varchar(100)','String','username','0','0','1','1','1','1','1','LIKE','input','',2,'admin','2025-04-26 16:41:46','','2025-04-26 17:15:52'),(79,8,'password','密码','varchar(255)','String','password','0','0','1','1','1','1','1','EQ','input','',3,'admin','2025-04-26 16:41:46','','2025-04-26 17:15:53'),(80,8,'user_type','账号类型','enum(\'job_seeker\',\'enterprise\',\'admin\')','String','userType','0','0','1','1','1','1','1','EQ','select','user_type',4,'admin','2025-04-26 16:41:46','','2025-04-26 17:15:53'),(81,8,'create_time','创建时间','datetime','Date','createTime','0','0','0','0',NULL,'1',NULL,'EQ','datetime','',5,'admin','2025-04-26 16:41:46','','2025-04-26 17:15:53'),(82,8,'update_time','修改时间','datetime','Date','updateTime','0','0','0','0','0','1',NULL,'EQ','datetime','',6,'admin','2025-04-26 16:41:46','','2025-04-26 17:15:53'),(83,8,'status','状态','tinyint(4)','Integer','status','0','0','0','0','0','0','0','EQ','radio','',7,'admin','2025-04-26 16:41:46','','2025-04-26 17:15:53'),(84,8,'version',NULL,'int(11)','Long','version','0','0','0','0','0','0','0','EQ','input','',8,'admin','2025-04-26 16:41:46','','2025-04-26 17:15:53'),(95,10,'id',NULL,'bigint(20)','Long','id','1','1','0','0',NULL,NULL,NULL,'EQ','input','',1,'admin','2025-04-26 18:25:33','','2025-04-26 18:31:23'),(96,10,'user_id','todo','bigint(20)','Long','userId','0','0','1','1','1','1','1','EQ','input','',2,'admin','2025-04-26 18:25:33','','2025-04-26 18:31:23'),(97,10,'job_id','todo','bigint(20)','Long','jobId','0','0','1','1','1','1','1','EQ','input','',3,'admin','2025-04-26 18:25:33','','2025-04-26 18:31:23'),(98,10,'etp_id','todo','bigint(20)','Long','etpId','0','0','1','1','1','1','1','EQ','input','',4,'admin','2025-04-26 18:25:33','','2025-04-26 18:31:23'),(99,10,'interview_status','面试状态','varchar(50)','String','interviewStatus','0','0','0','1','1','1','0','EQ','radio','',5,'admin','2025-04-26 18:25:33','','2025-04-26 18:31:23'),(100,10,'message','消息','varchar(50)','String','message','0','0','0','1','1','1','0','EQ','textarea','',6,'admin','2025-04-26 18:25:33','','2025-04-26 18:31:23'),(101,10,'time','面试时间','datetime','Date','time','0','0','0','1','1','1','0','EQ','datetime','',7,'admin','2025-04-26 18:25:33','','2025-04-26 18:31:23'),(102,10,'create_time',NULL,'datetime','Date','createTime','0','0','0','0',NULL,'1',NULL,'EQ','datetime','',8,'admin','2025-04-26 18:25:33','','2025-04-26 18:31:23'),(103,10,'update_time',NULL,'datetime','Date','updateTime','0','0','0','0','0','1',NULL,'EQ','datetime','',9,'admin','2025-04-26 18:25:33','','2025-04-26 18:31:23'),(104,10,'status',NULL,'tinyint(4)','Integer','status','0','0','0','0','0','0','0','EQ','radio','',10,'admin','2025-04-26 18:25:33','','2025-04-26 18:31:23'),(105,10,'version',NULL,'int(11)','Long','version','0','0','0','0','0','0','0','EQ','input','',11,'admin','2025-04-26 18:25:33','','2025-04-26 18:31:23'),(106,11,'id','id','bigint(20)','Long','id','1','1','0','0',NULL,'1',NULL,'EQ','input','',1,'admin','2025-05-02 17:12:56','','2025-05-02 19:28:35'),(107,11,'poster_id','发送方','bigint(20)','Long','posterId','0','0','1','1','1','1','0','EQ','input','',2,'admin','2025-05-02 17:12:56','','2025-05-02 19:28:35'),(108,11,'receiver_id','接收方','bigint(20)','Long','receiverId','0','0','1','1','1','1','0','EQ','input','',3,'admin','2025-05-02 17:12:56','','2025-05-02 19:28:35'),(109,11,'previous_id','上一条','bigint(20)','Long','previousId','0','0','1','1','1','1','0','EQ','input','',4,'admin','2025-05-02 17:12:56','','2025-05-02 19:28:35'),(110,11,'content','内容','text','String','content','0','0','0','1','1','1','1','EQ','textarea','',5,'admin','2025-05-02 17:12:56','','2025-05-02 19:28:35'),(111,11,'content_type','内容类型','enum(\'text\',\'image\',\'file\')','String','contentType','0','0','0','1','1','1','1','EQ','select','communicate_content_type',6,'admin','2025-05-02 17:12:56','','2025-05-02 19:28:35'),(112,11,'create_time','创建时间','datetime','Date','createTime','0','0','0','0',NULL,'1',NULL,'EQ','datetime','',7,'admin','2025-05-02 17:12:56','','2025-05-02 19:28:35'),(113,11,'update_time','修改时间','datetime','Date','updateTime','0','0','0','0','0','1',NULL,'EQ','datetime','',8,'admin','2025-05-02 17:12:56','','2025-05-02 19:28:35'),(114,11,'status','状态','tinyint(4)','Integer','status','0','0','0','0','0','0','0','EQ','radio','',9,'admin','2025-05-02 17:12:56','','2025-05-02 19:28:35'),(115,11,'version','锁','int(11)','Long','version','0','0','0','0','0','0','0','EQ','input','',10,'admin','2025-05-02 17:12:56','','2025-05-02 19:28:35');
/*!40000 ALTER TABLE `gen_table_column` ENABLE KEYS */;

--
-- Table structure for table `sys_config`
--

DROP TABLE IF EXISTS `sys_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_config` (
                              `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
                              `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',
                              `config_key` varchar(100) DEFAULT '' COMMENT '参数键名',
                              `config_value` varchar(500) DEFAULT '' COMMENT '参数键值',
                              `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
                              `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                              `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                              `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                              `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                              `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                              PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='参数配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_config`
--

/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;
INSERT INTO `sys_config` VALUES (1,'主框架页-默认皮肤样式名称','sys.index.skinName','skin-blue','Y','admin','2025-04-26 15:33:19','',NULL,'蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),(2,'用户管理-账号初始密码','sys.user.initPassword','123456','Y','admin','2025-04-26 15:33:19','',NULL,'初始化密码 123456'),(3,'主框架页-侧边栏主题','sys.index.sideTheme','theme-dark','Y','admin','2025-04-26 15:33:19','',NULL,'深色主题theme-dark，浅色主题theme-light'),(4,'账号自助-验证码开关','sys.account.captchaEnabled','true','Y','admin','2025-04-26 15:33:19','',NULL,'是否开启验证码功能（true开启，false关闭）'),(5,'账号自助-是否开启用户注册功能','sys.account.registerUser','false','Y','admin','2025-04-26 15:33:19','',NULL,'是否开启注册用户功能（true开启，false关闭）'),(6,'用户登录-黑名单列表','sys.login.blackIPList','','Y','admin','2025-04-26 15:33:19','',NULL,'设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_menu` (
                            `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
                            `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
                            `parent_id` bigint(20) DEFAULT '0' COMMENT '父菜单ID',
                            `order_num` int(4) DEFAULT '0' COMMENT '显示顺序',
                            `path` varchar(200) DEFAULT '' COMMENT '路由地址',
                            `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
                            `query` varchar(255) DEFAULT NULL COMMENT '路由参数',
                            `route_name` varchar(50) DEFAULT '' COMMENT '路由名称',
                            `is_frame` int(1) DEFAULT '1' COMMENT '是否为外链（0是 1否）',
                            `is_cache` int(1) DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
                            `menu_type` char(1) DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
                            `visible` char(1) DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
                            `status` char(1) DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
                            `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',
                            `icon` varchar(100) DEFAULT '#' COMMENT '菜单图标',
                            `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                            `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                            `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                            `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                            `remark` varchar(500) DEFAULT '' COMMENT '备注',
                            PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2061 DEFAULT CHARSET=utf8 COMMENT='菜单权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,'系统管理',0,1,'system',NULL,'','',1,0,'M','0','0','','system','admin','2025-04-26 15:33:13','',NULL,'系统管理目录'),(2,'系统监控',0,2,'monitor',NULL,'','',1,0,'M','1','0','','monitor','admin','2025-04-26 15:33:13','admin','2025-04-26 20:52:20','系统监控目录'),(3,'系统工具',0,3,'tool',NULL,'','',1,0,'M','0','0','','tool','admin','2025-04-26 15:33:13','',NULL,'系统工具目录'),(4,'若依官网',0,4,'http://ruoyi.vip',NULL,'','',0,0,'M','1','1','','guide','admin','2025-04-26 15:33:13','admin','2025-04-26 20:51:42','若依官网地址'),(100,'用户管理',1,1,'user','system/user/index','','',1,0,'C','0','0','system:user:list','user','admin','2025-04-26 15:33:13','',NULL,'用户管理菜单'),(101,'角色管理',1,2,'role','system/role/index','','',1,0,'C','0','0','system:role:list','peoples','admin','2025-04-26 15:33:13','',NULL,'角色管理菜单'),(102,'菜单管理',1,3,'menu','system/menu/index','','',1,0,'C','0','0','system:menu:list','tree-table','admin','2025-04-26 15:33:13','',NULL,'菜单管理菜单'),(103,'部门管理',1,4,'dept','system/dept/index','','',1,0,'C','0','0','system:dept:list','tree','admin','2025-04-26 15:33:13','',NULL,'部门管理菜单'),(104,'岗位管理',1,5,'post','system/post/index','','',1,0,'C','0','0','system:post:list','post','admin','2025-04-26 15:33:13','',NULL,'岗位管理菜单'),(105,'字典管理',1,6,'dict','system/dict/index','','',1,0,'C','0','0','system:dict:list','dict','admin','2025-04-26 15:33:13','',NULL,'字典管理菜单'),(106,'参数设置',1,7,'config','system/config/index','','',1,0,'C','0','0','system:config:list','edit','admin','2025-04-26 15:33:13','',NULL,'参数设置菜单'),(107,'通知公告',1,8,'notice','system/notice/index','','',1,0,'C','0','0','system:notice:list','message','admin','2025-04-26 15:33:13','',NULL,'通知公告菜单'),(108,'日志管理',1,9,'log','','','',1,0,'M','0','0','','log','admin','2025-04-26 15:33:13','',NULL,'日志管理菜单'),(109,'在线用户',2,1,'online','monitor/online/index','','',1,0,'C','0','0','monitor:online:list','online','admin','2025-04-26 15:33:13','',NULL,'在线用户菜单'),(110,'定时任务',2,2,'job','monitor/job/index','','',1,0,'C','0','0','monitor:job:list','job','admin','2025-04-26 15:33:13','',NULL,'定时任务菜单'),(111,'数据监控',2,3,'druid','monitor/druid/index','','',1,0,'C','0','0','monitor:druid:list','druid','admin','2025-04-26 15:33:13','',NULL,'数据监控菜单'),(112,'服务监控',2,4,'server','monitor/server/index','','',1,0,'C','0','0','monitor:server:list','server','admin','2025-04-26 15:33:13','',NULL,'服务监控菜单'),(113,'缓存监控',2,5,'cache','monitor/cache/index','','',1,0,'C','0','0','monitor:cache:list','redis','admin','2025-04-26 15:33:13','',NULL,'缓存监控菜单'),(114,'缓存列表',2,6,'cacheList','monitor/cache/list','','',1,0,'C','0','0','monitor:cache:list','redis-list','admin','2025-04-26 15:33:13','',NULL,'缓存列表菜单'),(115,'表单构建',3,1,'build','tool/build/index','','',1,0,'C','0','0','tool:build:list','build','admin','2025-04-26 15:33:13','',NULL,'表单构建菜单'),(116,'代码生成',3,2,'gen','tool/gen/index','','',1,0,'C','0','0','tool:gen:list','code','admin','2025-04-26 15:33:13','',NULL,'代码生成菜单'),(117,'系统接口',3,3,'swagger','tool/swagger/index','','',1,0,'C','0','0','tool:swagger:list','swagger','admin','2025-04-26 15:33:13','',NULL,'系统接口菜单'),(500,'操作日志',108,1,'operlog','monitor/operlog/index','','',1,0,'C','0','0','monitor:operlog:list','form','admin','2025-04-26 15:33:13','',NULL,'操作日志菜单'),(501,'登录日志',108,2,'logininfor','monitor/logininfor/index','','',1,0,'C','0','0','monitor:logininfor:list','logininfor','admin','2025-04-26 15:33:13','',NULL,'登录日志菜单'),(1000,'用户查询',100,1,'','','','',1,0,'F','0','0','system:user:query','#','admin','2025-04-26 15:33:13','',NULL,''),(1001,'用户新增',100,2,'','','','',1,0,'F','0','0','system:user:add','#','admin','2025-04-26 15:33:14','',NULL,''),(1002,'用户修改',100,3,'','','','',1,0,'F','0','0','system:user:edit','#','admin','2025-04-26 15:33:14','',NULL,''),(1003,'用户删除',100,4,'','','','',1,0,'F','0','0','system:user:remove','#','admin','2025-04-26 15:33:14','',NULL,''),(1004,'用户导出',100,5,'','','','',1,0,'F','0','0','system:user:export','#','admin','2025-04-26 15:33:14','',NULL,''),(1005,'用户导入',100,6,'','','','',1,0,'F','0','0','system:user:import','#','admin','2025-04-26 15:33:14','',NULL,''),(1006,'重置密码',100,7,'','','','',1,0,'F','0','0','system:user:resetPwd','#','admin','2025-04-26 15:33:14','',NULL,''),(1007,'角色查询',101,1,'','','','',1,0,'F','0','0','system:role:query','#','admin','2025-04-26 15:33:14','',NULL,''),(1008,'角色新增',101,2,'','','','',1,0,'F','0','0','system:role:add','#','admin','2025-04-26 15:33:14','',NULL,''),(1009,'角色修改',101,3,'','','','',1,0,'F','0','0','system:role:edit','#','admin','2025-04-26 15:33:14','',NULL,''),(1010,'角色删除',101,4,'','','','',1,0,'F','0','0','system:role:remove','#','admin','2025-04-26 15:33:14','',NULL,''),(1011,'角色导出',101,5,'','','','',1,0,'F','0','0','system:role:export','#','admin','2025-04-26 15:33:14','',NULL,''),(1012,'菜单查询',102,1,'','','','',1,0,'F','0','0','system:menu:query','#','admin','2025-04-26 15:33:14','',NULL,''),(1013,'菜单新增',102,2,'','','','',1,0,'F','0','0','system:menu:add','#','admin','2025-04-26 15:33:14','',NULL,''),(1014,'菜单修改',102,3,'','','','',1,0,'F','0','0','system:menu:edit','#','admin','2025-04-26 15:33:14','',NULL,''),(1015,'菜单删除',102,4,'','','','',1,0,'F','0','0','system:menu:remove','#','admin','2025-04-26 15:33:14','',NULL,''),(1016,'部门查询',103,1,'','','','',1,0,'F','0','0','system:dept:query','#','admin','2025-04-26 15:33:14','',NULL,''),(1017,'部门新增',103,2,'','','','',1,0,'F','0','0','system:dept:add','#','admin','2025-04-26 15:33:14','',NULL,''),(1018,'部门修改',103,3,'','','','',1,0,'F','0','0','system:dept:edit','#','admin','2025-04-26 15:33:14','',NULL,''),(1019,'部门删除',103,4,'','','','',1,0,'F','0','0','system:dept:remove','#','admin','2025-04-26 15:33:14','',NULL,''),(1020,'岗位查询',104,1,'','','','',1,0,'F','0','0','system:post:query','#','admin','2025-04-26 15:33:14','',NULL,''),(1021,'岗位新增',104,2,'','','','',1,0,'F','0','0','system:post:add','#','admin','2025-04-26 15:33:14','',NULL,''),(1022,'岗位修改',104,3,'','','','',1,0,'F','0','0','system:post:edit','#','admin','2025-04-26 15:33:14','',NULL,''),(1023,'岗位删除',104,4,'','','','',1,0,'F','0','0','system:post:remove','#','admin','2025-04-26 15:33:14','',NULL,''),(1024,'岗位导出',104,5,'','','','',1,0,'F','0','0','system:post:export','#','admin','2025-04-26 15:33:14','',NULL,''),(1025,'字典查询',105,1,'#','','','',1,0,'F','0','0','system:dict:query','#','admin','2025-04-26 15:33:14','',NULL,''),(1026,'字典新增',105,2,'#','','','',1,0,'F','0','0','system:dict:add','#','admin','2025-04-26 15:33:14','',NULL,''),(1027,'字典修改',105,3,'#','','','',1,0,'F','0','0','system:dict:edit','#','admin','2025-04-26 15:33:14','',NULL,''),(1028,'字典删除',105,4,'#','','','',1,0,'F','0','0','system:dict:remove','#','admin','2025-04-26 15:33:14','',NULL,''),(1029,'字典导出',105,5,'#','','','',1,0,'F','0','0','system:dict:export','#','admin','2025-04-26 15:33:14','',NULL,''),(1030,'参数查询',106,1,'#','','','',1,0,'F','0','0','system:config:query','#','admin','2025-04-26 15:33:14','',NULL,''),(1031,'参数新增',106,2,'#','','','',1,0,'F','0','0','system:config:add','#','admin','2025-04-26 15:33:14','',NULL,''),(1032,'参数修改',106,3,'#','','','',1,0,'F','0','0','system:config:edit','#','admin','2025-04-26 15:33:14','',NULL,''),(1033,'参数删除',106,4,'#','','','',1,0,'F','0','0','system:config:remove','#','admin','2025-04-26 15:33:14','',NULL,''),(1034,'参数导出',106,5,'#','','','',1,0,'F','0','0','system:config:export','#','admin','2025-04-26 15:33:14','',NULL,''),(1035,'公告查询',107,1,'#','','','',1,0,'F','0','0','system:notice:query','#','admin','2025-04-26 15:33:15','',NULL,''),(1036,'公告新增',107,2,'#','','','',1,0,'F','0','0','system:notice:add','#','admin','2025-04-26 15:33:15','',NULL,''),(1037,'公告修改',107,3,'#','','','',1,0,'F','0','0','system:notice:edit','#','admin','2025-04-26 15:33:15','',NULL,''),(1038,'公告删除',107,4,'#','','','',1,0,'F','0','0','system:notice:remove','#','admin','2025-04-26 15:33:15','',NULL,''),(1039,'操作查询',500,1,'#','','','',1,0,'F','0','0','monitor:operlog:query','#','admin','2025-04-26 15:33:15','',NULL,''),(1040,'操作删除',500,2,'#','','','',1,0,'F','0','0','monitor:operlog:remove','#','admin','2025-04-26 15:33:15','',NULL,''),(1041,'日志导出',500,3,'#','','','',1,0,'F','0','0','monitor:operlog:export','#','admin','2025-04-26 15:33:15','',NULL,''),(1042,'登录查询',501,1,'#','','','',1,0,'F','0','0','monitor:logininfor:query','#','admin','2025-04-26 15:33:15','',NULL,''),(1043,'登录删除',501,2,'#','','','',1,0,'F','0','0','monitor:logininfor:remove','#','admin','2025-04-26 15:33:15','',NULL,''),(1044,'日志导出',501,3,'#','','','',1,0,'F','0','0','monitor:logininfor:export','#','admin','2025-04-26 15:33:15','',NULL,''),(1045,'账户解锁',501,4,'#','','','',1,0,'F','0','0','monitor:logininfor:unlock','#','admin','2025-04-26 15:33:15','',NULL,''),(1046,'在线查询',109,1,'#','','','',1,0,'F','0','0','monitor:online:query','#','admin','2025-04-26 15:33:15','',NULL,''),(1047,'批量强退',109,2,'#','','','',1,0,'F','0','0','monitor:online:batchLogout','#','admin','2025-04-26 15:33:15','',NULL,''),(1048,'单条强退',109,3,'#','','','',1,0,'F','0','0','monitor:online:forceLogout','#','admin','2025-04-26 15:33:15','',NULL,''),(1049,'任务查询',110,1,'#','','','',1,0,'F','0','0','monitor:job:query','#','admin','2025-04-26 15:33:15','',NULL,''),(1050,'任务新增',110,2,'#','','','',1,0,'F','0','0','monitor:job:add','#','admin','2025-04-26 15:33:15','',NULL,''),(1051,'任务修改',110,3,'#','','','',1,0,'F','0','0','monitor:job:edit','#','admin','2025-04-26 15:33:15','',NULL,''),(1052,'任务删除',110,4,'#','','','',1,0,'F','0','0','monitor:job:remove','#','admin','2025-04-26 15:33:15','',NULL,''),(1053,'状态修改',110,5,'#','','','',1,0,'F','0','0','monitor:job:changeStatus','#','admin','2025-04-26 15:33:15','',NULL,''),(1054,'任务导出',110,6,'#','','','',1,0,'F','0','0','monitor:job:export','#','admin','2025-04-26 15:33:15','',NULL,''),(1055,'生成查询',116,1,'#','','','',1,0,'F','0','0','tool:gen:query','#','admin','2025-04-26 15:33:15','',NULL,''),(1056,'生成修改',116,2,'#','','','',1,0,'F','0','0','tool:gen:edit','#','admin','2025-04-26 15:33:15','',NULL,''),(1057,'生成删除',116,3,'#','','','',1,0,'F','0','0','tool:gen:remove','#','admin','2025-04-26 15:33:15','',NULL,''),(1058,'导入代码',116,4,'#','','','',1,0,'F','0','0','tool:gen:import','#','admin','2025-04-26 15:33:15','',NULL,''),(1059,'预览代码',116,5,'#','','','',1,0,'F','0','0','tool:gen:preview','#','admin','2025-04-26 15:33:15','',NULL,''),(1060,'生成代码',116,6,'#','','','',1,0,'F','0','0','tool:gen:code','#','admin','2025-04-26 15:33:15','',NULL,''),(2000,'后台管理',0,4,'admin',NULL,NULL,'',1,0,'M','0','0',NULL,'build','admin','2025-04-26 16:58:01','',NULL,''),(2001,'分类管理',2000,1,'category','admin/category/index',NULL,'',1,0,'C','0','0','admin:category:list','#','admin','2025-04-26 19:14:00','',NULL,'分类管理菜单'),(2002,'分类管理查询',2001,1,'#','',NULL,'',1,0,'F','0','0','admin:category:query','#','admin','2025-04-26 19:14:01','',NULL,''),(2003,'分类管理新增',2001,2,'#','',NULL,'',1,0,'F','0','0','admin:category:add','#','admin','2025-04-26 19:14:01','',NULL,''),(2004,'分类管理修改',2001,3,'#','',NULL,'',1,0,'F','0','0','admin:category:edit','#','admin','2025-04-26 19:14:01','',NULL,''),(2005,'分类管理删除',2001,4,'#','',NULL,'',1,0,'F','0','0','admin:category:remove','#','admin','2025-04-26 19:14:01','',NULL,''),(2006,'分类管理导出',2001,5,'#','',NULL,'',1,0,'F','0','0','admin:category:export','#','admin','2025-04-26 19:14:01','',NULL,''),(2007,'评价管理',2000,1,'comment','admin/comment/index',NULL,'',1,0,'C','0','0','admin:comment:list','#','admin','2025-04-26 19:14:12','admin','2025-05-02 19:52:52','评价菜单'),(2008,'评价查询',2007,1,'#','',NULL,'',1,0,'F','0','0','admin:comment:query','#','admin','2025-04-26 19:14:12','',NULL,''),(2009,'评价新增',2007,2,'#','',NULL,'',1,0,'F','0','0','admin:comment:add','#','admin','2025-04-26 19:14:12','',NULL,''),(2010,'评价修改',2007,3,'#','',NULL,'',1,0,'F','0','0','admin:comment:edit','#','admin','2025-04-26 19:14:12','',NULL,''),(2011,'评价删除',2007,4,'#','',NULL,'',1,0,'F','0','0','admin:comment:remove','#','admin','2025-04-26 19:14:12','',NULL,''),(2012,'评价导出',2007,5,'#','',NULL,'',1,0,'F','0','0','admin:comment:export','#','admin','2025-04-26 19:14:12','',NULL,''),(2019,'企业管理',2000,1,'etp','admin/etp/index',NULL,'',1,0,'C','0','0','admin:etp:list','#','admin','2025-04-26 19:14:23','',NULL,'企业管理菜单'),(2020,'企业管理查询',2019,1,'#','',NULL,'',1,0,'F','0','0','admin:etp:query','#','admin','2025-04-26 19:14:23','',NULL,''),(2021,'企业管理新增',2019,2,'#','',NULL,'',1,0,'F','0','0','admin:etp:add','#','admin','2025-04-26 19:14:24','',NULL,''),(2022,'企业管理修改',2019,3,'#','',NULL,'',1,0,'F','0','0','admin:etp:edit','#','admin','2025-04-26 19:14:24','',NULL,''),(2023,'企业管理删除',2019,4,'#','',NULL,'',1,0,'F','0','0','admin:etp:remove','#','admin','2025-04-26 19:14:24','',NULL,''),(2024,'企业管理导出',2019,5,'#','',NULL,'',1,0,'F','0','0','admin:etp:export','#','admin','2025-04-26 19:14:24','',NULL,''),(2025,'面试管理',2000,1,'interview','admin/interview/index',NULL,'',1,0,'C','0','0','admin:interview:list','#','admin','2025-04-26 19:14:28','admin','2025-05-02 19:53:00','面试菜单'),(2026,'面试查询',2025,1,'#','',NULL,'',1,0,'F','0','0','admin:interview:query','#','admin','2025-04-26 19:14:28','',NULL,''),(2027,'面试新增',2025,2,'#','',NULL,'',1,0,'F','0','0','admin:interview:add','#','admin','2025-04-26 19:14:28','',NULL,''),(2028,'面试修改',2025,3,'#','',NULL,'',1,0,'F','0','0','admin:interview:edit','#','admin','2025-04-26 19:14:28','',NULL,''),(2029,'面试删除',2025,4,'#','',NULL,'',1,0,'F','0','0','admin:interview:remove','#','admin','2025-04-26 19:14:28','',NULL,''),(2030,'面试导出',2025,5,'#','',NULL,'',1,0,'F','0','0','admin:interview:export','#','admin','2025-04-26 19:14:28','',NULL,''),(2031,'岗位管理',2000,1,'job','admin/job/index',NULL,'',1,0,'C','0','0','admin:job:list','#','admin','2025-04-26 19:14:34','admin','2025-05-02 19:53:07','岗位菜单'),(2032,'岗位查询',2031,1,'#','',NULL,'',1,0,'F','0','0','admin:job:query','#','admin','2025-04-26 19:14:34','',NULL,''),(2033,'岗位新增',2031,2,'#','',NULL,'',1,0,'F','0','0','admin:job:add','#','admin','2025-04-26 19:14:34','',NULL,''),(2034,'岗位修改',2031,3,'#','',NULL,'',1,0,'F','0','0','admin:job:edit','#','admin','2025-04-26 19:14:34','',NULL,''),(2035,'岗位删除',2031,4,'#','',NULL,'',1,0,'F','0','0','admin:job:remove','#','admin','2025-04-26 19:14:34','',NULL,''),(2036,'岗位导出',2031,5,'#','',NULL,'',1,0,'F','0','0','admin:job:export','#','admin','2025-04-26 19:14:34','',NULL,''),(2037,'简历管理',2000,1,'resume','admin/resume/index',NULL,'',1,0,'C','0','0','admin:resume:list','#','admin','2025-04-26 19:14:39','admin','2025-05-02 19:53:13','简历菜单'),(2038,'简历查询',2037,1,'#','',NULL,'',1,0,'F','0','0','admin:resume:query','#','admin','2025-04-26 19:14:39','',NULL,''),(2039,'简历新增',2037,2,'#','',NULL,'',1,0,'F','0','0','admin:resume:add','#','admin','2025-04-26 19:14:39','',NULL,''),(2040,'简历修改',2037,3,'#','',NULL,'',1,0,'F','0','0','admin:resume:edit','#','admin','2025-04-26 19:14:39','',NULL,''),(2041,'简历删除',2037,4,'#','',NULL,'',1,0,'F','0','0','admin:resume:remove','#','admin','2025-04-26 19:14:39','',NULL,''),(2042,'简历导出',2037,5,'#','',NULL,'',1,0,'F','0','0','admin:resume:export','#','admin','2025-04-26 19:14:39','',NULL,''),(2043,'标签管理',2000,1,'tag','admin/tag/index',NULL,'',1,0,'C','0','0','admin:tag:list','#','admin','2025-04-26 19:14:44','',NULL,'标签管理菜单'),(2044,'标签管理查询',2043,1,'#','',NULL,'',1,0,'F','0','0','admin:tag:query','#','admin','2025-04-26 19:14:44','',NULL,''),(2045,'标签管理新增',2043,2,'#','',NULL,'',1,0,'F','0','0','admin:tag:add','#','admin','2025-04-26 19:14:44','',NULL,''),(2046,'标签管理修改',2043,3,'#','',NULL,'',1,0,'F','0','0','admin:tag:edit','#','admin','2025-04-26 19:14:44','',NULL,''),(2047,'标签管理删除',2043,4,'#','',NULL,'',1,0,'F','0','0','admin:tag:remove','#','admin','2025-04-26 19:14:44','',NULL,''),(2048,'标签管理导出',2043,5,'#','',NULL,'',1,0,'F','0','0','admin:tag:export','#','admin','2025-04-26 19:14:44','',NULL,''),(2049,'用户管理',2000,1,'user','admin/user/index',NULL,'',1,0,'C','0','0','admin:user:list','#','admin','2025-04-26 19:14:49','',NULL,'用户管理菜单'),(2050,'用户管理查询',2049,1,'#','',NULL,'',1,0,'F','0','0','admin:user:query','#','admin','2025-04-26 19:14:49','',NULL,''),(2051,'用户管理新增',2049,2,'#','',NULL,'',1,0,'F','0','0','admin:user:add','#','admin','2025-04-26 19:14:49','',NULL,''),(2052,'用户管理修改',2049,3,'#','',NULL,'',1,0,'F','0','0','admin:user:edit','#','admin','2025-04-26 19:14:49','',NULL,''),(2053,'用户管理删除',2049,4,'#','',NULL,'',1,0,'F','0','0','admin:user:remove','#','admin','2025-04-26 19:14:49','',NULL,''),(2054,'用户管理导出',2049,5,'#','',NULL,'',1,0,'F','0','0','admin:user:export','#','admin','2025-04-26 19:14:49','',NULL,''),(2055,'沟通管理',2000,1,'communicate','admin/communicate/index',NULL,'',1,0,'C','0','0','admin:communicate:list','#','admin','2025-05-02 19:03:54','admin','2025-05-02 19:52:42','沟通菜单'),(2056,'沟通查询',2055,1,'#','',NULL,'',1,0,'F','0','0','admin:communicate:query','#','admin','2025-05-02 19:03:54','',NULL,''),(2057,'沟通新增',2055,2,'#','',NULL,'',1,0,'F','0','0','admin:communicate:add','#','admin','2025-05-02 19:03:55','',NULL,''),(2058,'沟通修改',2055,3,'#','',NULL,'',1,0,'F','0','0','admin:communicate:edit','#','admin','2025-05-02 19:03:55','',NULL,''),(2059,'沟通删除',2055,4,'#','',NULL,'',1,0,'F','0','0','admin:communicate:remove','#','admin','2025-05-02 19:03:55','',NULL,''),(2060,'沟通导出',2055,5,'#','',NULL,'',1,0,'F','0','0','admin:communicate:export','#','admin','2025-05-02 19:03:55','',NULL,'');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;

--
-- Table structure for table `qrtz_simple_triggers`
--

DROP TABLE IF EXISTS `qrtz_simple_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_simple_triggers` (
                                        `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
                                        `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
                                        `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
                                        `repeat_count` bigint(7) NOT NULL COMMENT '重复的次数统计',
                                        `repeat_interval` bigint(12) NOT NULL COMMENT '重复的间隔时间',
                                        `times_triggered` bigint(10) NOT NULL COMMENT '已经触发的次数',
                                        PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
                                        CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='简单触发器的信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_simple_triggers`
--

/*!40000 ALTER TABLE `qrtz_simple_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simple_triggers` ENABLE KEYS */;

--
-- Table structure for table `qrtz_scheduler_state`
--

DROP TABLE IF EXISTS `qrtz_scheduler_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_scheduler_state` (
                                        `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
                                        `instance_name` varchar(200) NOT NULL COMMENT '实例名称',
                                        `last_checkin_time` bigint(13) NOT NULL COMMENT '上次检查时间',
                                        `checkin_interval` bigint(13) NOT NULL COMMENT '检查间隔时间',
                                        PRIMARY KEY (`sched_name`,`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='调度器状态表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_scheduler_state`
--

/*!40000 ALTER TABLE `qrtz_scheduler_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_scheduler_state` ENABLE KEYS */;

--
-- Table structure for table `qrtz_locks`
--

DROP TABLE IF EXISTS `qrtz_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_locks` (
                              `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
                              `lock_name` varchar(40) NOT NULL COMMENT '悲观锁名称',
                              PRIMARY KEY (`sched_name`,`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存储的悲观锁信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_locks`
--

/*!40000 ALTER TABLE `qrtz_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_locks` ENABLE KEYS */;

--
-- Table structure for table `sys_notice`
--

DROP TABLE IF EXISTS `sys_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_notice` (
                              `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
                              `notice_title` varchar(50) NOT NULL COMMENT '公告标题',
                              `notice_type` char(1) NOT NULL COMMENT '公告类型（1通知 2公告）',
                              `notice_content` longblob COMMENT '公告内容',
                              `status` char(1) DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
                              `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                              `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                              `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                              `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                              `remark` varchar(255) DEFAULT NULL COMMENT '备注',
                              PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='通知公告表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_notice`
--

/*!40000 ALTER TABLE `sys_notice` DISABLE KEYS */;
INSERT INTO `sys_notice` VALUES (1,'温馨提醒：2018-07-01 若依新版本发布啦','2',_binary '新版本内容','0','admin','2025-04-26 15:33:19','',NULL,'管理员'),(2,'维护通知：2018-07-01 若依系统凌晨维护','1',_binary '维护内容','0','admin','2025-04-26 15:33:19','',NULL,'管理员');
/*!40000 ALTER TABLE `sys_notice` ENABLE KEYS */;

--
-- Table structure for table `qrtz_job_details`
--

DROP TABLE IF EXISTS `qrtz_job_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_job_details` (
                                    `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
                                    `job_name` varchar(200) NOT NULL COMMENT '任务名称',
                                    `job_group` varchar(200) NOT NULL COMMENT '任务组名',
                                    `description` varchar(250) DEFAULT NULL COMMENT '相关介绍',
                                    `job_class_name` varchar(250) NOT NULL COMMENT '执行任务类名称',
                                    `is_durable` varchar(1) NOT NULL COMMENT '是否持久化',
                                    `is_nonconcurrent` varchar(1) NOT NULL COMMENT '是否并发',
                                    `is_update_data` varchar(1) NOT NULL COMMENT '是否更新数据',
                                    `requests_recovery` varchar(1) NOT NULL COMMENT '是否接受恢复执行',
                                    `job_data` blob COMMENT '存放持久化job对象',
                                    PRIMARY KEY (`sched_name`,`job_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务详细信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_job_details`
--

/*!40000 ALTER TABLE `qrtz_job_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_job_details` ENABLE KEYS */;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role` (
                            `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
                            `role_name` varchar(30) NOT NULL COMMENT '角色名称',
                            `role_key` varchar(100) NOT NULL COMMENT '角色权限字符串',
                            `role_sort` int(4) NOT NULL COMMENT '显示顺序',
                            `data_scope` char(1) DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
                            `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
                            `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
                            `status` char(1) NOT NULL COMMENT '角色状态（0正常 1停用）',
                            `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
                            `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                            `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                            `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                            `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                            `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                            PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='角色信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'超级管理员','admin',1,'1',1,1,'0','0','admin','2025-04-26 15:33:13','',NULL,'超级管理员'),(2,'普通角色','common',2,'2',1,1,'0','0','admin','2025-04-26 15:33:13','',NULL,'普通角色');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;

--
-- Table structure for table `tb_resume`
--

DROP TABLE IF EXISTS `tb_resume`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_resume` (
                             `id` bigint(20) NOT NULL AUTO_INCREMENT,
                             `user_id` bigint(20) NOT NULL,
                             `avatar_file_id` varchar(255) DEFAULT NULL COMMENT '头像文件ID',
                             `name` varchar(50) NOT NULL,
                             `gender` enum('male','female','other') NOT NULL,
                             `age` int(11) DEFAULT NULL,
                             `education` varchar(50) DEFAULT NULL,
                             `school` varchar(100) DEFAULT NULL,
                             `phone` varchar(20) DEFAULT NULL,
                             `email` varchar(100) DEFAULT NULL,
                             `job_intention` varchar(255) DEFAULT NULL,
                             `attachment_file_ids` text COMMENT '简历附件，多个文件ID以逗号分隔',
                             `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
                             `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                             `status` tinyint(4) DEFAULT '1',
                             `version` int(11) DEFAULT '1',
                             PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_resume`
--

/*!40000 ALTER TABLE `tb_resume` DISABLE KEYS */;
INSERT INTO `tb_resume` VALUES (1,1,'/profile/upload/2025/04/27/bg_20250427202054A004.jpg','xxg','male',12,'大学','福大','1234523131','2920902@qq.com','1','/profile/upload/2025/04/27/d895a837544e180eb72385ac9ade189fadd705b7b59c1e4faa5cb64fc225a604_20250427174006A002.png,/profile/upload/2025/04/27/56936267-c6d8b204dabdf5991329f5d56713bc0dacee1fe6ba57379c014c55605c0c2f49_20250427174020A003.png','2025-04-27 16:00:30','2025-04-27 20:21:10',1,1);
/*!40000 ALTER TABLE `tb_resume` ENABLE KEYS */;

--
-- Table structure for table `sys_job`
--

DROP TABLE IF EXISTS `sys_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_job` (
                           `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
                           `job_name` varchar(64) NOT NULL DEFAULT '' COMMENT '任务名称',
                           `job_group` varchar(64) NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
                           `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
                           `cron_expression` varchar(255) DEFAULT '' COMMENT 'cron执行表达式',
                           `misfire_policy` varchar(20) DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
                           `concurrent` char(1) DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
                           `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1暂停）',
                           `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                           `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                           `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                           `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                           `remark` varchar(500) DEFAULT '' COMMENT '备注信息',
                           PRIMARY KEY (`job_id`,`job_name`,`job_group`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='定时任务调度表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job`
--

/*!40000 ALTER TABLE `sys_job` DISABLE KEYS */;
INSERT INTO `sys_job` VALUES (1,'系统默认（无参）','DEFAULT','ryTask.ryNoParams','0/10 * * * * ?','3','1','1','admin','2025-04-26 15:33:19','',NULL,''),(2,'系统默认（有参）','DEFAULT','ryTask.ryParams(\'ry\')','0/15 * * * * ?','3','1','1','admin','2025-04-26 15:33:19','',NULL,''),(3,'系统默认（多参）','DEFAULT','ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)','0/20 * * * * ?','3','1','1','admin','2025-04-26 15:33:19','',NULL,'');
/*!40000 ALTER TABLE `sys_job` ENABLE KEYS */;

--
-- Table structure for table `sys_post`
--

DROP TABLE IF EXISTS `sys_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_post` (
                            `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
                            `post_code` varchar(64) NOT NULL COMMENT '岗位编码',
                            `post_name` varchar(50) NOT NULL COMMENT '岗位名称',
                            `post_sort` int(4) NOT NULL COMMENT '显示顺序',
                            `status` char(1) NOT NULL COMMENT '状态（0正常 1停用）',
                            `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                            `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                            `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                            `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                            `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                            PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='岗位信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_post`
--

/*!40000 ALTER TABLE `sys_post` DISABLE KEYS */;
INSERT INTO `sys_post` VALUES (1,'ceo','董事长',1,'0','admin','2025-04-26 15:33:12','',NULL,''),(2,'se','项目经理',2,'0','admin','2025-04-26 15:33:12','',NULL,''),(3,'hr','人力资源',3,'0','admin','2025-04-26 15:33:12','',NULL,''),(4,'user','普通员工',4,'0','admin','2025-04-26 15:33:12','',NULL,'');
/*!40000 ALTER TABLE `sys_post` ENABLE KEYS */;

--
-- Table structure for table `tb_communicate`
--

DROP TABLE IF EXISTS `tb_communicate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_communicate` (
                                  `id` bigint(20) NOT NULL AUTO_INCREMENT,
                                  `poster_id` bigint(20) NOT NULL,
                                  `receiver_id` bigint(20) NOT NULL,
                                  `previous_id` bigint(20) NOT NULL DEFAULT '-1',
                                  `content` text,
                                  `content_type` enum('text','image','file') DEFAULT 'text',
                                  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
                                  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                  `status` tinyint(4) DEFAULT '1',
                                  `version` int(11) DEFAULT '1',
                                  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_communicate`
--

/*!40000 ALTER TABLE `tb_communicate` DISABLE KEYS */;
INSERT INTO `tb_communicate` VALUES (1,1,2,-1,'你好','','2025-05-02 19:41:53','2025-05-02 19:41:53',1,1),(2,2,1,1,'咋啦','','2025-05-02 19:42:03','2025-05-02 19:42:02',1,1);
/*!40000 ALTER TABLE `tb_communicate` ENABLE KEYS */;

--
-- Table structure for table `sys_role_dept`
--

DROP TABLE IF EXISTS `sys_role_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_dept` (
                                 `role_id` bigint(20) NOT NULL COMMENT '角色ID',
                                 `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
                                 PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色和部门关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_dept`
--

/*!40000 ALTER TABLE `sys_role_dept` DISABLE KEYS */;
INSERT INTO `sys_role_dept` VALUES (2,100),(2,101),(2,105);
/*!40000 ALTER TABLE `sys_role_dept` ENABLE KEYS */;

--
-- Table structure for table `sys_user_post`
--

DROP TABLE IF EXISTS `sys_user_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_post` (
                                 `user_id` bigint(20) NOT NULL COMMENT '用户ID',
                                 `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
                                 PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户与岗位关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_post`
--

/*!40000 ALTER TABLE `sys_user_post` DISABLE KEYS */;
INSERT INTO `sys_user_post` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `sys_user_post` ENABLE KEYS */;

--
-- Table structure for table `tb_user`
--

DROP TABLE IF EXISTS `tb_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_user` (
                           `id` bigint(20) NOT NULL AUTO_INCREMENT,
                           `username` varchar(100) NOT NULL,
                           `password` varchar(255) NOT NULL,
                           `user_type` enum('job_seeker','enterprise','admin') NOT NULL COMMENT '账号类型：求职者、企业、管理员',
                           `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
                           `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                           `status` tinyint(4) DEFAULT '1' COMMENT '状态：1-正常，0-禁用',
                           `version` int(11) DEFAULT '1',
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_user`
--

/*!40000 ALTER TABLE `tb_user` DISABLE KEYS */;
INSERT INTO `tb_user` VALUES (1,'zs','123456','job_seeker','2025-04-26 20:04:27','2025-04-26 20:04:26',1,1),(2,'et','123456','job_seeker','2025-04-28 16:55:49','2025-04-28 16:56:08',1,1),(3,'333','333','enterprise','2025-04-28 16:56:13','2025-04-28 16:56:12',1,1),(4,'444','444','enterprise','2025-04-28 16:56:21','2025-04-28 16:56:21',1,1);
/*!40000 ALTER TABLE `tb_user` ENABLE KEYS */;

--
-- Table structure for table `sys_dept`
--

DROP TABLE IF EXISTS `sys_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_dept` (
                            `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
                            `parent_id` bigint(20) DEFAULT '0' COMMENT '父部门id',
                            `ancestors` varchar(50) DEFAULT '' COMMENT '祖级列表',
                            `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',
                            `order_num` int(4) DEFAULT '0' COMMENT '显示顺序',
                            `leader` varchar(20) DEFAULT NULL COMMENT '负责人',
                            `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
                            `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
                            `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
                            `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
                            `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                            `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                            `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                            `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                            PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8 COMMENT='部门表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dept`
--

/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;
INSERT INTO `sys_dept` VALUES (100,0,'0','若依科技',0,'若依','15888888888','ry@qq.com','0','0','admin','2025-04-26 15:33:12','',NULL),(101,100,'0,100','深圳总公司',1,'若依','15888888888','ry@qq.com','0','0','admin','2025-04-26 15:33:12','',NULL),(102,100,'0,100','长沙分公司',2,'若依','15888888888','ry@qq.com','0','0','admin','2025-04-26 15:33:12','',NULL),(103,101,'0,100,101','研发部门',1,'若依','15888888888','ry@qq.com','0','0','admin','2025-04-26 15:33:12','',NULL),(104,101,'0,100,101','市场部门',2,'若依','15888888888','ry@qq.com','0','0','admin','2025-04-26 15:33:12','',NULL),(105,101,'0,100,101','测试部门',3,'若依','15888888888','ry@qq.com','0','0','admin','2025-04-26 15:33:12','',NULL),(106,101,'0,100,101','财务部门',4,'若依','15888888888','ry@qq.com','0','0','admin','2025-04-26 15:33:12','',NULL),(107,101,'0,100,101','运维部门',5,'若依','15888888888','ry@qq.com','0','0','admin','2025-04-26 15:33:12','',NULL),(108,102,'0,100,102','市场部门',1,'若依','15888888888','ry@qq.com','0','0','admin','2025-04-26 15:33:12','',NULL),(109,102,'0,100,102','财务部门',2,'若依','15888888888','ry@qq.com','0','0','admin','2025-04-26 15:33:12','',NULL);
/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;

--
-- Table structure for table `tb_etp`
--

DROP TABLE IF EXISTS `tb_etp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_etp` (
                          `id` bigint(20) NOT NULL AUTO_INCREMENT,
                          `user_id` bigint(20) NOT NULL,
                          `logo_file_id` varchar(255) DEFAULT NULL,
                          `name` varchar(100) NOT NULL,
                          `description` text COMMENT '宣传信息',
                          `legal_person` varchar(100) DEFAULT NULL,
                          `address` varchar(255) DEFAULT NULL,
                          `phone` varchar(20) DEFAULT NULL,
                          `email` varchar(100) DEFAULT NULL,
                          `website` varchar(255) DEFAULT NULL,
                          `popularity` int(11) DEFAULT '0' COMMENT '企业热度',
                          `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
                          `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                          `status` tinyint(4) DEFAULT '1',
                          `version` int(11) DEFAULT '1',
                          PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_etp`
--

/*!40000 ALTER TABLE `tb_etp` DISABLE KEYS */;
INSERT INTO `tb_etp` VALUES (1,1,'/profile/upload/2025/04/27/bg_20250427201550A003.jpg','企业1','哈哈哈','nhb','fuda1qu','1231231231','13213131231','12312313123123',2,'2025-04-26 19:30:58','2025-04-27 20:15:52',1,1),(2,2,'/profile/upload/2025/04/28/bg_20250428171405A002.jpg','2','2','2','2','2','2','2',2,'2025-04-28 17:14:10','2025-04-28 17:14:10',1,1);
/*!40000 ALTER TABLE `tb_etp` ENABLE KEYS */;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user` (
                            `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
                            `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
                            `user_name` varchar(30) NOT NULL COMMENT '用户账号',
                            `nick_name` varchar(30) NOT NULL COMMENT '用户昵称',
                            `user_type` varchar(2) DEFAULT '00' COMMENT '用户类型（00系统用户）',
                            `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
                            `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
                            `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
                            `avatar` varchar(100) DEFAULT '' COMMENT '头像地址',
                            `password` varchar(100) DEFAULT '' COMMENT '密码',
                            `status` char(1) DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
                            `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
                            `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',
                            `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
                            `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                            `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                            `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                            `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                            `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                            PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,103,'admin','若依','00','ry@163.com','15888888888','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2025-05-02 19:08:17','admin','2025-04-26 15:33:12','','2025-05-02 19:08:16','管理员'),(2,105,'ry','若依','00','ry@qq.com','15666666666','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2025-04-26 15:33:12','admin','2025-04-26 15:33:12','',NULL,'测试员');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;

--
-- Table structure for table `qrtz_calendars`
--

DROP TABLE IF EXISTS `qrtz_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_calendars` (
                                  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
                                  `calendar_name` varchar(200) NOT NULL COMMENT '日历名称',
                                  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
                                  PRIMARY KEY (`sched_name`,`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日历信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_calendars`
--

/*!40000 ALTER TABLE `qrtz_calendars` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_calendars` ENABLE KEYS */;

--
-- Table structure for table `qrtz_blob_triggers`
--

DROP TABLE IF EXISTS `qrtz_blob_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_blob_triggers` (
                                      `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
                                      `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
                                      `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
                                      `blob_data` blob COMMENT '存放持久化Trigger对象',
                                      PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
                                      CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Blob类型的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_blob_triggers`
--

/*!40000 ALTER TABLE `qrtz_blob_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_blob_triggers` ENABLE KEYS */;

--
-- Table structure for table `qrtz_triggers`
--

DROP TABLE IF EXISTS `qrtz_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_triggers` (
                                 `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
                                 `trigger_name` varchar(200) NOT NULL COMMENT '触发器的名字',
                                 `trigger_group` varchar(200) NOT NULL COMMENT '触发器所属组的名字',
                                 `job_name` varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
                                 `job_group` varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
                                 `description` varchar(250) DEFAULT NULL COMMENT '相关介绍',
                                 `next_fire_time` bigint(13) DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
                                 `prev_fire_time` bigint(13) DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
                                 `priority` int(11) DEFAULT NULL COMMENT '优先级',
                                 `trigger_state` varchar(16) NOT NULL COMMENT '触发器状态',
                                 `trigger_type` varchar(8) NOT NULL COMMENT '触发器的类型',
                                 `start_time` bigint(13) NOT NULL COMMENT '开始时间',
                                 `end_time` bigint(13) DEFAULT NULL COMMENT '结束时间',
                                 `calendar_name` varchar(200) DEFAULT NULL COMMENT '日程表名称',
                                 `misfire_instr` smallint(2) DEFAULT NULL COMMENT '补偿执行的策略',
                                 `job_data` blob COMMENT '存放持久化job对象',
                                 PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
                                 KEY `sched_name` (`sched_name`,`job_name`,`job_group`),
                                 CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='触发器详细信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_triggers`
--

/*!40000 ALTER TABLE `qrtz_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_triggers` ENABLE KEYS */;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_menu` (
                                 `role_id` bigint(20) NOT NULL COMMENT '角色ID',
                                 `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
                                 PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色和菜单关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
INSERT INTO `sys_role_menu` VALUES (2,1),(2,2),(2,3),(2,4),(2,100),(2,101),(2,102),(2,103),(2,104),(2,105),(2,106),(2,107),(2,108),(2,109),(2,110),(2,111),(2,112),(2,113),(2,114),(2,115),(2,116),(2,117),(2,500),(2,501),(2,1000),(2,1001),(2,1002),(2,1003),(2,1004),(2,1005),(2,1006),(2,1007),(2,1008),(2,1009),(2,1010),(2,1011),(2,1012),(2,1013),(2,1014),(2,1015),(2,1016),(2,1017),(2,1018),(2,1019),(2,1020),(2,1021),(2,1022),(2,1023),(2,1024),(2,1025),(2,1026),(2,1027),(2,1028),(2,1029),(2,1030),(2,1031),(2,1032),(2,1033),(2,1034),(2,1035),(2,1036),(2,1037),(2,1038),(2,1039),(2,1040),(2,1041),(2,1042),(2,1043),(2,1044),(2,1045),(2,1046),(2,1047),(2,1048),(2,1049),(2,1050),(2,1051),(2,1052),(2,1053),(2,1054),(2,1055),(2,1056),(2,1057),(2,1058),(2,1059),(2,1060);
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;

--
-- Table structure for table `tb_category`
--

DROP TABLE IF EXISTS `tb_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_category` (
                               `id` bigint(20) NOT NULL AUTO_INCREMENT,
                               `name` varchar(100) NOT NULL,
                               `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
                               `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                               `status` tinyint(4) DEFAULT '1',
                               `version` int(11) DEFAULT '1',
                               PRIMARY KEY (`id`),
                               UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_category`
--

/*!40000 ALTER TABLE `tb_category` DISABLE KEYS */;
INSERT INTO `tb_category` VALUES (1,'java','2025-04-27 14:42:48','2025-04-27 14:42:47',1,1),(2,'计算机','2025-04-28 15:51:20','2025-04-28 15:51:20',1,1),(3,'福州','2025-04-28 15:51:29','2025-04-28 15:51:29',1,1),(4,'厦门','2025-04-28 15:51:40','2025-04-28 15:51:40',1,1),(5,'555','2025-04-28 19:17:09','2025-04-28 19:17:08',1,1),(6,'666','2025-05-02 16:00:39','2025-05-02 16:00:41',1,1),(7,'677','2025-05-02 16:03:47','2025-05-02 16:03:49',1,1),(8,'8','2025-05-02 16:04:38','2025-05-02 16:04:37',1,1),(9,'2334','2025-05-02 16:07:06','2025-05-02 16:07:06',1,1);
/*!40000 ALTER TABLE `tb_category` ENABLE KEYS */;

--
-- Table structure for table `qrtz_cron_triggers`
--

DROP TABLE IF EXISTS `qrtz_cron_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_cron_triggers` (
                                      `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
                                      `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
                                      `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
                                      `cron_expression` varchar(200) NOT NULL COMMENT 'cron表达式',
                                      `time_zone_id` varchar(80) DEFAULT NULL COMMENT '时区',
                                      PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
                                      CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cron类型的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_cron_triggers`
--

/*!40000 ALTER TABLE `qrtz_cron_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_cron_triggers` ENABLE KEYS */;

--
-- Table structure for table `sys_dict_data`
--

DROP TABLE IF EXISTS `sys_dict_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_dict_data` (
                                 `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
                                 `dict_sort` int(4) DEFAULT '0' COMMENT '字典排序',
                                 `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
                                 `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
                                 `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
                                 `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
                                 `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
                                 `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
                                 `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
                                 `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                                 `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                 `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                                 `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                 `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                                 PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8 COMMENT='字典数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_data`
--

/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;
INSERT INTO `sys_dict_data` VALUES (1,1,'男','0','sys_user_sex','','','Y','0','admin','2025-04-26 15:33:18','',NULL,'性别男'),(2,2,'女','1','sys_user_sex','','','N','0','admin','2025-04-26 15:33:18','',NULL,'性别女'),(3,3,'未知','2','sys_user_sex','','','N','0','admin','2025-04-26 15:33:18','',NULL,'性别未知'),(4,1,'显示','0','sys_show_hide','','primary','Y','0','admin','2025-04-26 15:33:18','',NULL,'显示菜单'),(5,2,'隐藏','1','sys_show_hide','','danger','N','0','admin','2025-04-26 15:33:18','',NULL,'隐藏菜单'),(6,1,'正常','0','sys_normal_disable','','primary','Y','0','admin','2025-04-26 15:33:18','',NULL,'正常状态'),(7,2,'停用','1','sys_normal_disable','','danger','N','0','admin','2025-04-26 15:33:18','',NULL,'停用状态'),(8,1,'正常','0','sys_job_status','','primary','Y','0','admin','2025-04-26 15:33:18','',NULL,'正常状态'),(9,2,'暂停','1','sys_job_status','','danger','N','0','admin','2025-04-26 15:33:18','',NULL,'停用状态'),(10,1,'默认','DEFAULT','sys_job_group','','','Y','0','admin','2025-04-26 15:33:18','',NULL,'默认分组'),(11,2,'系统','SYSTEM','sys_job_group','','','N','0','admin','2025-04-26 15:33:18','',NULL,'系统分组'),(12,1,'是','Y','sys_yes_no','','primary','Y','0','admin','2025-04-26 15:33:18','',NULL,'系统默认是'),(13,2,'否','N','sys_yes_no','','danger','N','0','admin','2025-04-26 15:33:18','',NULL,'系统默认否'),(14,1,'通知','1','sys_notice_type','','warning','Y','0','admin','2025-04-26 15:33:18','',NULL,'通知'),(15,2,'公告','2','sys_notice_type','','success','N','0','admin','2025-04-26 15:33:18','',NULL,'公告'),(16,1,'正常','0','sys_notice_status','','primary','Y','0','admin','2025-04-26 15:33:18','',NULL,'正常状态'),(17,2,'关闭','1','sys_notice_status','','danger','N','0','admin','2025-04-26 15:33:18','',NULL,'关闭状态'),(18,99,'其他','0','sys_oper_type','','info','N','0','admin','2025-04-26 15:33:18','',NULL,'其他操作'),(19,1,'新增','1','sys_oper_type','','info','N','0','admin','2025-04-26 15:33:18','',NULL,'新增操作'),(20,2,'修改','2','sys_oper_type','','info','N','0','admin','2025-04-26 15:33:18','',NULL,'修改操作'),(21,3,'删除','3','sys_oper_type','','danger','N','0','admin','2025-04-26 15:33:19','',NULL,'删除操作'),(22,4,'授权','4','sys_oper_type','','primary','N','0','admin','2025-04-26 15:33:19','',NULL,'授权操作'),(23,5,'导出','5','sys_oper_type','','warning','N','0','admin','2025-04-26 15:33:19','',NULL,'导出操作'),(24,6,'导入','6','sys_oper_type','','warning','N','0','admin','2025-04-26 15:33:19','',NULL,'导入操作'),(25,7,'强退','7','sys_oper_type','','danger','N','0','admin','2025-04-26 15:33:19','',NULL,'强退操作'),(26,8,'生成代码','8','sys_oper_type','','warning','N','0','admin','2025-04-26 15:33:19','',NULL,'生成操作'),(27,9,'清空数据','9','sys_oper_type','','danger','N','0','admin','2025-04-26 15:33:19','',NULL,'清空操作'),(28,1,'成功','0','sys_common_status','','primary','N','0','admin','2025-04-26 15:33:19','',NULL,'正常状态'),(29,2,'失败','1','sys_common_status','','danger','N','0','admin','2025-04-26 15:33:19','',NULL,'停用状态'),(100,0,'正常','0','tb_any_status',NULL,'default','N','0','admin','2025-04-26 16:54:13','',NULL,NULL),(101,1,'已删除','1','tb_any_status',NULL,'default','N','0','admin','2025-04-26 16:54:29','',NULL,NULL),(102,0,'求职者','job_seeker','user_type',NULL,'default','N','0','admin','2025-04-26 17:13:48','',NULL,NULL),(103,1,'企业','enterprise','user_type',NULL,'default','N','0','admin','2025-04-26 17:14:08','',NULL,NULL),(104,3,'管理员','admin','user_type',NULL,'default','N','0','admin','2025-04-26 17:14:21','',NULL,NULL),(105,0,'文本','0','communicate_content_type',NULL,'default','N','0','admin','2025-05-02 19:17:26','',NULL,NULL),(106,1,'图片','1','communicate_content_type',NULL,'default','N','0','admin','2025-05-02 19:17:36','',NULL,NULL),(107,2,'附件','2','communicate_content_type',NULL,'default','N','0','admin','2025-05-02 19:17:52','',NULL,NULL);
/*!40000 ALTER TABLE `sys_dict_data` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-09 18:12:01
