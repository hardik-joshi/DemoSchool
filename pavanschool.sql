/*
SQLyog Community v12.2.2 (64 bit)
MySQL - 5.6.21 
*********************************************************************
*/
/*!40101 SET NAMES utf8 */;

create table `student` (
	`grno` int (11),
	`diseno` int (11),
	`fatherid` int (11),
	`personid` int (11),
	`shift` varchar (60),
	`board` varchar (150),
	`enrollmentdate` date ,
	`leavingdate` date ,
	`standardid` int (11),
	`bloodgroup` varchar (30),
	`religion` varchar (90),
	`nationality` varchar (150),
	`category` varchar (60),
	`rollno` int (11),
	`batch` varchar (90),
	`familyincome` int (11),
	`motherid` int (11),
	`studentid` int (11),
	`outstandingfees` int (11),
	`purchasebook` int (11)
); 
insert into `student` (`grno`, `diseno`, `fatherid`, `personid`, `shift`, `board`, `enrollmentdate`, `leavingdate`, `standardid`, `bloodgroup`, `religion`, `nationality`, `category`, `rollno`, `batch`, `familyincome`, `motherid`, `studentid`, `outstandingfees`, `purchasebook`) values('1001','101','46','44',NULL,'GSEB','2015-06-29',NULL,'1','A+','Hinduism','Indian','Open','101','Morning','250000','45','14','200','1');
insert into `student` (`grno`, `diseno`, `fatherid`, `personid`, `shift`, `board`, `enrollmentdate`, `leavingdate`, `standardid`, `bloodgroup`, `religion`, `nationality`, `category`, `rollno`, `batch`, `familyincome`, `motherid`, `studentid`, `outstandingfees`, `purchasebook`) values('1002','102','49','47',NULL,'GSEB','2015-06-29',NULL,'2','B+','Hinduism','Indian','Open','102','Morning','400000','48','15','0','0');
insert into `student` (`grno`, `diseno`, `fatherid`, `personid`, `shift`, `board`, `enrollmentdate`, `leavingdate`, `standardid`, `bloodgroup`, `religion`, `nationality`, `category`, `rollno`, `batch`, `familyincome`, `motherid`, `studentid`, `outstandingfees`, `purchasebook`) values('1003','103','52','50',NULL,'GSEB','2015-06-29',NULL,'1','B+','Hinduism','Indian','Open','103','Morning','350000','51','16','0','0');
insert into `student` (`grno`, `diseno`, `fatherid`, `personid`, `shift`, `board`, `enrollmentdate`, `leavingdate`, `standardid`, `bloodgroup`, `religion`, `nationality`, `category`, `rollno`, `batch`, `familyincome`, `motherid`, `studentid`, `outstandingfees`, `purchasebook`) values('1004','104','55','53',NULL,'GSEB','2015-06-29',NULL,'1','AB+','Hinduism','Indian','Open','104','Morning','280000','54','17','0','1');
insert into `student` (`grno`, `diseno`, `fatherid`, `personid`, `shift`, `board`, `enrollmentdate`, `leavingdate`, `standardid`, `bloodgroup`, `religion`, `nationality`, `category`, `rollno`, `batch`, `familyincome`, `motherid`, `studentid`, `outstandingfees`, `purchasebook`) values('1005','105','58','56',NULL,'GSEB','2015-06-29',NULL,'1','B+','Hinduism','Indian','Open','105','Morning','380000','57','18','0','0');
insert into `student` (`grno`, `diseno`, `fatherid`, `personid`, `shift`, `board`, `enrollmentdate`, `leavingdate`, `standardid`, `bloodgroup`, `religion`, `nationality`, `category`, `rollno`, `batch`, `familyincome`, `motherid`, `studentid`, `outstandingfees`, `purchasebook`) values('1006','106','61','59',NULL,'GSEB','2015-06-29',NULL,'2','O+','Hinduism','Indian','Open','106','Morning','600000','60','19','0','0');
insert into `student` (`grno`, `diseno`, `fatherid`, `personid`, `shift`, `board`, `enrollmentdate`, `leavingdate`, `standardid`, `bloodgroup`, `religion`, `nationality`, `category`, `rollno`, `batch`, `familyincome`, `motherid`, `studentid`, `outstandingfees`, `purchasebook`) values('1007','107','64','62',NULL,'GSEB','2015-06-29',NULL,'2','O+','Hinduism','Indian','Open','107','Morning','800000','63','20','0','0');
insert into `student` (`grno`, `diseno`, `fatherid`, `personid`, `shift`, `board`, `enrollmentdate`, `leavingdate`, `standardid`, `bloodgroup`, `religion`, `nationality`, `category`, `rollno`, `batch`, `familyincome`, `motherid`, `studentid`, `outstandingfees`, `purchasebook`) values('1008','108','67','65',NULL,'GSEB','2015-06-29',NULL,'2','B-','Hinduism','Indian','Open','108','Morning','900000','66','21','0','0');
insert into `student` (`grno`, `diseno`, `fatherid`, `personid`, `shift`, `board`, `enrollmentdate`, `leavingdate`, `standardid`, `bloodgroup`, `religion`, `nationality`, `category`, `rollno`, `batch`, `familyincome`, `motherid`, `studentid`, `outstandingfees`, `purchasebook`) values('1009','109','70','68',NULL,'GSEB','2015-06-29',NULL,'2','A-','Hinduism','Indian','Open','109','Morning','700000','69','22','0','0');
insert into `student` (`grno`, `diseno`, `fatherid`, `personid`, `shift`, `board`, `enrollmentdate`, `leavingdate`, `standardid`, `bloodgroup`, `religion`, `nationality`, `category`, `rollno`, `batch`, `familyincome`, `motherid`, `studentid`, `outstandingfees`, `purchasebook`) values('1010','110','73','71',NULL,'GSEB','2015-06-29',NULL,'2','AB+','Hinduism','Indian','Open','110','Morning','550000','72','23','0','0');
