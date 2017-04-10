/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50536
Source Host           : localhost:3306
Source Database       : sun_lbs

Target Server Type    : MYSQL
Target Server Version : 50536
File Encoding         : 65001

Date: 2016-05-05 15:28:33
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for gas
-- ----------------------------
DROP TABLE IF EXISTS `gas`;
CREATE TABLE `gas` (
  `gid` char(32) NOT NULL,
  `gname` varchar(100) NOT NULL,
  `gtel` varchar(50) DEFAULT NULL,
  `point` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of gas
-- ----------------------------
INSERT INTO `gas` VALUES ('1', '红星加油站', '88880000', '128.2341,30.7521', '价格优惠，服务质量好');
INSERT INTO `gas` VALUES ('2', '宏业加油站', '89990000', '130.1231,28.9751', 'oK');
