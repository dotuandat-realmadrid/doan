-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: doan
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP DATABASE IF EXISTS doan;
CREATE DATABASE doan;
USE doan;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `id` varchar(36) NOT NULL,
  `createdby` varchar(255) DEFAULT NULL,
  `createddate` datetime(6) DEFAULT NULL,
  `is_active` tinyint NOT NULL,
  `modifiedby` varchar(255) DEFAULT NULL,
  `modifieddate` datetime(6) DEFAULT NULL,
  `detail` varchar(255) NOT NULL,
  `district` varchar(255) NOT NULL,
  `province` varchar(255) NOT NULL,
  `ward` varchar(255) NOT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `unique_address_key` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `phone` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKibojxnhlre8lcn6ag9a35epr1` (`user_id`),
  CONSTRAINT `FKibojxnhlre8lcn6ag9a35epr1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES ('0bcd7042-bf43-4917-b0ca-0707945eabf6','anonymousUser','2025-01-26 18:34:40.615887',1,'pesmobile5404@gmail.com','2025-01-26 23:19:23.261136','Cổng chính trường ĐHCN Hà Nội','Bắc Từ Liêm','Hà Nội','Minh Khai','d435d2b6-34f2-4226-85d4-1149f12c4761','52b559df27fc0005ed6b0a5cc81583e2870ed75e14ac825b5f2f34c004f1fa91','Đỗ Tuấn Đạt','0000000000'),
('0c2c3e40-037e-42cf-8c88-fe803e95cc81','anonymousUser','2025-03-17 01:19:34.732770',1,'anonymousUser','2025-03-17 01:19:34.732770','abc','Quận 6','TP Hồ Chí Minh','Phường 7','dc73d495-715f-4795-97dd-bd05b73e9668','9d08a0322f8d364ad20e48396ff3882fc29b75eaa5be28b435991af4d2599aef','Vũ Văn Lâm','0205671231'),
('0d7a65d4-17f6-406a-9584-ed1520686897','anonymousUser','2025-03-01 20:39:16.697309',0,'dotuandat2004nd@gmail.com','2025-03-10 00:38:22.908289','Abc, ...','Bắc Từ Liêm','Hà Nội','Minh Khai','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02','e7e24770d20dc9119be413aa88279f0e7efebc7a5f2779e83d53e1232687fbf8','Đạt Đỗ','0987654321'),
('19fdeb54-c98e-4427-900d-79b615b8196e','anonymousUser','2025-01-26 23:27:24.195101',1,'dotuandat2004nd@gmail.com','2025-01-26 23:56:18.743512','29a Ngõ 124 Phố Vĩnh Tuy','Hai Bà Trưng','Hà Nội','Vĩnh Phú','ef72e64a-4ba2-41cf-8b49-5be97968f3ad','dd9fbba771c071d05edeee36ec37dd8376c1b28eb94dd53625459da8e5d06f28','Công Phượng','0555555555'),
('1aa3ad91-b456-4a28-8f4a-dbf696ae4111','anonymousUser','2025-03-04 21:47:41.164219',1,'anonymousUser','2025-03-04 21:47:41.164219','x','a','a','Test','dc73d495-715f-4795-97dd-bd05b73e9668','7a5d1cfe2dbcbb3f46f3b0c6037946b4e1d5cf22b427f13a4613ea6ec8ac22e1','Luc Van Hai','0205671231'),
('1edad4b3-e040-4822-86cb-6f5d8aa418f8','anonymousUser','2025-03-04 22:05:12.482000',1,'anonymousUser','2025-03-04 22:05:12.482000','134 cầu Diễn','Bắc Từ Liêm','Hà Nội','Minh Khai','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02','e018bf29e673721081ce42583f4be2d446fcd589c389c3e19a270acf53ef7cef','Nam Nam','0944761755'),
('1f7cbc7f-9ef3-478e-a85d-578088909de8','anonymousUser','2025-03-17 12:32:28.985397',1,'anonymousUser','2025-03-17 12:32:28.985397','abc','abc','abc','abc','a7ddd32e-f737-4ff4-af59-18144fc9a432','2b27b51f0632ca669f388c8abc4ecfc769dfaffc1a02fc6534d6eaf7d9d2c781','ADMIN','0205671231'),
('1fad1d40-f249-41e4-8f5b-6f7e16633596','anonymousUser','2025-03-01 20:39:50.682637',1,'dotuandat2004nd@gmail.com','2025-03-24 09:45:20.740821','abcd','Nam Trực','Nam Định','Nam Giang','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02','277023dc703d27bfc0689a3c645e15974e162ea904005a5045a47848d7536ddb','Đỗ Tuấn Đạt','0944761755'),
('27dece2a-6167-4b2c-b52b-09e20d4d2485','anonymousUser','2025-03-04 21:36:36.107242',0,'dotuandat2004nd@gmail.com','2025-03-12 20:44:39.814145','Test','Test','Test','Test','d0abf087-be2a-4a40-b002-bfff337c026f','853019118507811a90f3ffb6156974d50fedfb80c762420584edda244e78ed51','Luc Van Hai','0944761755'),
('29e1bc87-6d65-4143-842f-accecf7bc9f8','anonymousUser','2025-02-16 12:21:19.256893',0,'dotuandat2004nd@gmail.com','2025-02-16 12:21:44.630890','Số 50, Ngõ 135 Đường Cầu Diễn, Nguyên Xá','Bắc Từ Liêm','Hà Nội','Minh Khai','d435d2b6-34f2-4226-85d4-1149f12c4761','d85fdfdb8ab79ee730ae4d1ecbb3508c2dfcd2663b2503c79d8bc61537818294','ABC','0205671231'),
('2d2a1d37-951f-4e3a-8b44-67c82b825339','anonymousUser','2025-03-12 20:43:24.251894',1,'anonymousUser','2025-03-12 20:43:24.251894','cuối làng Đường Nhạn','Đông Anh','Hà Nội','Xuân Nộn','d0abf087-be2a-4a40-b002-bfff337c026f','5733511c2c7acf887c4e48bbd4e091d097fcc0e029363e2ec969bd57edeea5be','Nguyễn Quang Hải','0389427398'),
('468b1d1c-e91a-40fa-9fd4-bce8f2600012','anonymousUser','2025-03-10 22:14:36.828762',1,'anonymousUser','2025-03-10 22:14:36.828762','Bến xe Kim Mã','Ba Đình','Hà Nội','Kim Mã','a7ddd32e-f737-4ff4-af59-18144fc9a432','ba8f5656a6f88dc75f9551a1460874b2ad28b5be6e3ce49db03af9339544149b','admin','0999999999'),
('48d6ff76-96d1-4252-80e2-52d1c6137d36','anonymousUser','2025-01-15 16:22:04.210183',1,'pesmobile5404@gmail.com','2025-01-26 22:17:46.636230','Cổng Chùa Bi, Tổ 9, Thôn Giáp Ba','Huyện Nam Trực','Nam Định','TT Nam Giang','d435d2b6-34f2-4226-85d4-1149f12c4761','3fe98fad461a409cc8abe8f38f9726b8b57c302e2cf223fa3fb595fa275941e1','Đạt Đỗ Tuấn','0987654321'),
('4a954c4b-6311-4caf-b288-b0b16ec0a971','anonymousUser','2025-03-21 15:57:43.651056',1,'anonymousUser','2025-03-21 15:57:43.651056','abc','ABC','ABC','ABC','e2579cb8-b240-4405-a3ba-e52b55831a33','3698db876784c803be085a9d922cbd7b842edb0506d774b760e012839ea9da13','Hải','0453458493'),
('4c05da47-1a34-44f8-9ce0-4739d112f807','anonymousUser','2025-03-09 01:32:33.639513',0,'dotuandat2004nd@gmail.com','2025-03-09 01:32:49.740375','test','test','test','test','c68506d2-7c97-4f6e-b51a-826f467dbd4e','092aa4b7b870e98b858ccfc4f86499af8902566326a99238a6d9a99d23d177ad','Vũ Văn Abc','0325385098'),
('4e598437-7468-49f0-a714-d48b5e9d582b','anonymousUser','2025-03-24 09:31:28.819189',1,'anonymousUser','2025-03-24 09:31:28.819189','Abc','Abc','Abc','Abc','afff85d7-53e8-40f9-9271-440bde54b151','b3b1884d8c90594a56a89acfefdcf4ae09ba9529676884157b2c091fe867ceb7','Đoàn Thị Yến','0394863943'),
('4efdfc07-ba4e-4c20-b58a-78c091e68808','anonymousUser','2025-01-26 18:29:39.847280',0,'dotuandat2004nd@gmail.com','2025-01-26 23:24:45.363658','Cổng chợ Chùa','Nam Trực','Nam Định','TT Nam Giang','d435d2b6-34f2-4226-85d4-1149f12c4761','02b911288bd7562d989828c72b297a17372cf51e77014ea3982b8d237d833e84','Nam Nam Nam','0987654321'),
('5010a4e9-2b63-4c3c-b8c2-08b88f9857c4','anonymousUser','2025-03-17 01:20:21.565706',1,'anonymousUser','2025-03-17 01:20:21.565706','abc','Test','Hà Nội','Test','8491c9bb-e3a3-4436-abd8-c3d74216d422','c669a043e3634d02f6c167a571c781fccf123a41c3db76bff566cff488553223','phuong','0987654321'),
('5917480b-ce9c-4eab-ae1c-ce74e3e95880','anonymousUser','2025-03-25 19:44:18.130427',1,'anonymousUser','2025-03-25 19:44:18.130427','acb','abc','acb','abc','1e92be5e-320c-4606-854e-27bc0814b803','8a36aa4fbe9de0ee38eefe11b78602210d50a2303c8d0346d22bf1df98f3c2d4','Mai Thị Hồng','0205671231'),
('60364830-2a3a-4159-ba17-41db4c7fdf30','anonymousUser','2025-03-04 21:05:08.945789',1,'anonymousUser','2025-03-04 21:05:08.945789','Test','Test','Test','Test','dc73d495-715f-4795-97dd-bd05b73e9668','aa59829cd08660b534df51e00514de42a55665f1bac178490a89778c055f2e30','TEST & TEST','0000000000'),
('69ff3b0c-fcdd-46cc-b440-2e3be5562925','anonymousUser','2025-03-17 11:44:23.285182',1,'anonymousUser','2025-03-17 11:44:23.285182','adsjk','Nam Trực','Nam Định','Nam Giang','8de76534-51ca-48e5-b776-6dffb98f3835','1ec6709e5430d5c73daa459d860ddf88fe7cb2a823408502a882f3b786d1f28b','Phong T1','0348952893'),
('6b01dc09-aac5-4795-92f5-ad8d6cb61da2','anonymousUser','2025-03-05 21:18:11.726650',0,'dotuandat2004nd@gmail.com','2025-03-05 21:29:20.747678','A','A','Bến Tre','A','b3e71cdf-5efa-4d05-a164-23b46b60750d','f202f65761757d22db24c2a266463c25e1e57fbab1b8ce1a3fb8674720955472','Jack 97','0345235897'),
('710e3dfc-9fc6-4d8d-ae02-03f8e6c2d27e','anonymousUser','2025-03-04 22:06:56.730164',0,'dotuandat2004nd@gmail.com','2025-03-10 00:09:02.052331','Chợ Chùa','Nam Trực','Nam Định','Nam Giang','df365c04-5060-4315-9222-7c2f007a44d3','b4c269e547fb0c552f711c683baf8fa97532ab2a4ce73fa18e6818bcd37c59f9','Vũ Nam','0944761755'),
('7339024f-7baa-4de5-93d2-ae5745b98ecc','anonymousUser','2025-03-10 00:36:20.917831',0,'dotuandat2004nd@gmail.com','2025-03-10 00:42:23.100061','D','B','A','C','21aeec38-45d8-4a94-bb93-e57e12a8e226','2d07c1d0f9234cd33a5d656b2f427a9fb2e1c3ff643aedb5abee77158741cb45','TEST & TEST','0944761755'),
('7b801819-6e35-41db-a396-b742299fdc45','anonymousUser','2025-02-22 12:00:48.801049',0,'dotuandat2004nd@gmail.com','2025-02-22 12:02:53.921251','t','y','x','z','5f169d55-675f-4825-99e4-fe902635ad6a','24c2c56ac9b6c6a6e29fb09007dde709bd667ff645028ae6b2d493726fa5e836','Test Vip','0987654321'),
('7d3cb495-12b6-4028-a718-1311ca69c611','anonymousUser','2025-03-01 20:38:46.590287',0,'dotuandat2004nd@gmail.com','2025-03-10 00:38:11.678610','Xyz, ...','Nam Trực','Nam Định','Nam Giang','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02','5f34b8b5b521733a08375faffcbc04384a2a086ac379a21852d8713cb8bb1b8e','Vũ Nam','0123456789'),
('7fa49ed3-3939-40ba-86f7-1e0e978bc43e','anonymousUser','2025-03-09 15:28:24.220240',1,'anonymousUser','2025-03-09 15:28:24.220240','cuối làng Đường Nhạn','Đông Anh','Hà Nội','Xuân Nộn','d0abf087-be2a-4a40-b002-bfff337c026f','0cfd05dde7dfe637a9ad11bb9a4078cde620e25a5690f17ca9e2241cddcae1f0','Nguyễn Quang Hải','0883883883'),
('84a0848e-a97d-473a-aa2b-87770d9a0ebe','anonymousUser','2025-01-15 15:40:49.315730',1,'admin@gmail.com','2025-01-26 23:16:35.733104','Số 50, Ngõ 134 Đường Cầu Diễn, Nguyên Xá','Bắc Từ Liêm','Hà Nội','Minh Khai','d435d2b6-34f2-4226-85d4-1149f12c4761','37d41c54c0628cdf4694209ce3e651ceb43627c7cb74253e5f0dd92717f796ee','Đạt Đỗ','0123456789'),
('995a1bdf-e09f-4c79-8e5a-e50653fe1580','anonymousUser','2025-03-07 15:31:33.007104',1,'anonymousUser','2025-03-07 15:31:33.007104','abc','ABC','ABC','ABC','024317a8-9e55-419d-bb9e-ed4cb104d020','8fc5549d1187904daf273803249979d09a43ef912f4f3f573019c132866e1c81','Huy 3','0987654321'),
('a387501c-a3fc-4993-91dd-01ed8ded5afe','anonymousUser','2025-03-15 10:10:16.343143',1,'anonymousUser','2025-03-15 10:10:16.343143','abc','Quận 6','TP Hồ Chí Minh','Phường 7','cfdae048-449a-4e64-aabc-1422eb3c0f2b','ac7e58e6658280314f6309fec0f580759729ee9de6a02ceec823598dfefd8d04','Lê Bảo Bình','0359679235'),
('a8a681d2-784d-4b2a-a721-7530ddcb1f93','anonymousUser','2025-03-07 15:11:38.941900',1,'anonymousUser','2025-03-07 15:11:38.941900','abc','ABC','ABC','ABC','024317a8-9e55-419d-bb9e-ed4cb104d020','96842424334e7a707def967c9d0b23bd416d866200917dd452da2cafbadd5037','Huy Quần Hoa','0238974234'),
('afe9bcea-5c3c-46bc-8af2-c0bac4791509','anonymousUser','2025-03-04 22:08:26.617308',0,'dtdat@gmail.com','2025-03-04 22:08:29.033727','s','s','a','s','df365c04-5060-4315-9222-7c2f007a44d3','3d9294b802bd3338dd5f91c5e28317fe60539d17185a627402f052c63db78471','á','0944761755'),
('b7954afc-5861-4f05-94a9-303e0bf6b7c4','anonymousUser','2025-03-04 21:20:46.718806',1,'anonymousUser','2025-03-04 21:20:46.718806','Test','Test','Test','Test','a83217e6-4591-4d14-b822-d7de6b728454','748fedbfed7760a81b590b66ca26eb4f26c9efd7022f86b99dcca4d7a6847b40','TEST & TEST','0000000000'),
('b90cf096-6d7e-4858-a906-41a82f808e28','anonymousUser','2025-03-24 09:38:08.816630',1,'anonymousUser','2025-03-24 09:38:08.816630','abcdef','ABC','Bến Tre','GHI','b3e71cdf-5efa-4d05-a164-23b46b60750d','8072d9a4e50061ef66a2ae181f6628f25dd433520eeb5ae9ca642c2310c0c74c','Phương Tuấn','0938746923'),
('bb3f1a2c-ab26-4cc0-b3e5-45400b445523','anonymousUser','2025-03-11 08:56:19.236093',0,'admin@gmail.com','2025-03-17 12:32:06.489875','d','b','a','c','a7ddd32e-f737-4ff4-af59-18144fc9a432','9f360e490c286cfe6d0abe1b7277adefe985017fc58dca9a70d30c1358bced80','Đỗ Đức Long','0987654321'),
('c021f6e0-9c8e-42ad-a23b-7ecf4eccaa66','anonymousUser','2025-03-04 21:18:16.357435',0,'dotuandat2004nd@gmail.com','2025-03-04 22:17:03.694994','Test','Test','Test','Test','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02','2a378886cf9a456f4b50b60bbdb0af5214f0d7e506df7a88440cb8654a0a94e0','TEST & TEST','0000000000'),
('c2542799-d750-41ea-8cb9-9443110e5b5c','anonymousUser','2025-03-04 21:20:06.459824',0,'dotuandat2004nd@gmail.com','2025-03-04 22:17:04.739038','Test','Test','Test','Test','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02','fcd31ce6a51695c2cb413e2e1a1269722ed043af09ef21e81aefc5ce5ea98448','TEST & TEST','0000000000'),
('c8af3a3e-894f-4c60-9f28-c003c495754c','anonymousUser','2025-03-10 00:16:15.147061',1,'dotuandat2004nd@gmail.com','2025-03-10 00:39:26.365534','50 Đường Abc','Từ Sơn','Bắc Ninh','Phù Khê','21aeec38-45d8-4a94-bb93-e57e12a8e226','86b3995263a5b10a4c63e5c476451fcf7313faedd9b261c892214a1b4c3fc23c','TEST & TEST','0205671231'),
('c8ec6885-65f9-499e-a967-9ac3a069e91f','anonymousUser','2025-03-09 19:35:18.631479',1,'anonymousUser','2025-03-09 19:35:18.631479','50 đường abc','Nam Trực','Nam Định','Nam Giang','dc73d495-715f-4795-97dd-bd05b73e9668','90179e1b02643d56a8a80e032bdc3ad371d744514387e0f305531e46d29dc8a7','Vũ Văn Lâm','0205671231'),
('d88b502f-8d81-4a24-a10a-b4075a9ec09c','anonymousUser','2025-03-17 01:23:57.565343',1,'anonymousUser','2025-03-17 01:23:57.565343','abc','abc','abc','abc','20731af4-0523-4f77-8e17-f800af2bb718','0238dab7b3c5f9f1c3596d9e04e08a7dd8d1899b7ea3660c9923401039904939','QWERTY','0328923235'),
('de011204-b3cb-40b3-8393-96dadf7d8712','anonymousUser','2025-03-05 21:13:19.732299',0,'dotuandat2004nd@gmail.com','2025-03-05 21:28:13.537706','E','C','B','D','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02','b811e89f3724ee6955f16feb48a086b255e9b9f146a00e55d0749591d2ea2e6d','A','0205671231'),
('dea8997f-1da3-4f76-af85-dab8d64ce9ee','anonymousUser','2025-01-26 23:22:48.126174',0,'pesmobile5404@gmail.com','2025-01-26 23:23:19.638740','test test test','test','test','test','d435d2b6-34f2-4226-85d4-1149f12c4761','a3e59e56b0f37b877409238d3e32381ef5c9f63f535fe605a244119bb18fe5cd','Luc Van Hai','0205671231'),
('e0dbbecf-17d9-4b2a-a8f0-9e8aa23c1e14','anonymousUser','2025-03-04 19:51:01.369744',1,'anonymousUser','2025-03-04 19:51:01.369744','Test','Test','Test','Test','7241e571-1d3a-47e8-b1d9-6dc8942b2f3e','b73fc851687518e10d947d6ea8b1df19f5afb0614014b1f03c8744c654ce9c64','TEST & TEST','0000000000'),
('e3912d54-8282-43b7-aeb8-3a1d66621383','anonymousUser','2025-03-09 23:34:26.198151',1,'anonymousUser','2025-03-09 23:34:26.198151','123 đường abc','Từ Sơn','Bắc Ninh','Tân Hồng','0a262bfd-d8c9-426f-a2f7-abaec3b0039c','152dce707793ac60aa8b2a67dbf0d33b142a0aa7226ab17718984f51bc1767e5','Đoàn Thị Trang','0205671231'),
('e4bd3a74-2d34-4d46-be40-103f633dd476','anonymousUser','2025-04-04 16:29:10.316973',1,'anonymousUser','2025-04-04 16:29:10.316973','abc','ABC','ABC','ABC','c68506d2-7c97-4f6e-b51a-826f467dbd4e','1c91119146030d978405bca9fc9e8a23e2c2435a852e4d4fb1806319dc6dcccf','ABC','0205671231'),
('e8874359-5f87-46ed-ab65-7d435e176750','anonymousUser','2025-03-15 10:18:28.403847',1,'anonymousUser','2025-03-15 10:18:28.403847','123, abc','Quận 6','TP Hồ Chí Minh','Phường 7','a90533bf-ce4b-4187-8c5e-77046b70c03e','e7f44ca39ab42a0133805c2be0ebec075e423a79976059435f3653e37d2ea092','Hào Sữa','0894732843'),
('ea23d399-2f70-4d89-b85b-a5a983da6894','anonymousUser','2025-03-04 22:16:38.458421',1,'anonymousUser','2025-03-04 22:16:38.458421','D','B','A','C','8491c9bb-e3a3-4436-abd8-c3d74216d422','97fe25db54e2eea1887c76683d04967de559f8e3f311c531b344ccdec1a63b7a','Elon Musk','0888888888'),
('eb8b8775-6512-48ee-bc7b-ccb199290aeb','anonymousUser','2025-03-07 13:55:27.979867',1,'anonymousUser','2025-03-07 13:55:27.979867','abc','Tiền Hải','Thái Bình','TT. Tiền Hải','2172f496-dfaf-4450-9148-f3fecc0a40f8','6df71d3f0574b7a7099146911a7a8924b8f7e4b68793a5b21076c6ff323e4437','Huy','0345938475'),
('f5c652dc-14dc-4563-8bd6-38fb0012fd86','anonymousUser','2025-03-16 00:07:42.825890',1,'anonymousUser','2025-03-16 00:07:42.825890','113, xyz','Quận 6','TP Hồ Chí Minh','Phường 6','decd643b-2bce-411c-8b04-ffaf9681ac10','502031081c2eb4dde30ae0b77f829672c7b56c2cb874c1e9fd57f3d8cd4aadcb','Bùi Mạnh','0205671231'),
('f96ac8e5-b29a-4c18-886a-6e724f7841c8','anonymousUser','2025-03-09 18:15:06.790230',1,'anonymousUser','2025-03-09 18:15:06.790230','Test','Test','Test','Test','0e285053-f2fd-485d-9f2f-4ea8d6951d17','c60c16e578b99604481c9720f449e38a2e32766ae9bc0a09bd8082b6693507ca','Đặng Văn Lâm','0453245452'),
('f9714155-883e-49b9-bf90-5f1be2226da3','anonymousUser','2025-03-17 11:47:48.273537',1,'anonymousUser','2025-03-17 11:47:48.273537','abc','abc','abc','abc','c2672bf7-d02f-4a99-aefd-6042bbfc374b','16b6de8221ae618f4f48272549372b8bbb546c2fb58a8dc7770925a3247b8f0e','Vũ Thịnh','0350934875'),
('fcea98cb-e68e-46ff-a849-79d03acc849a','anonymousUser','2025-03-04 22:09:46.243736',1,'anonymousUser','2025-03-04 22:09:46.243736','Thôn Nhất','Nam Trực','Nam Định','Nam Giang','93c1c628-da91-4834-a776-4e3c9d7220b6','e35a417a83d5e05ffe65ed1487842a98433c68e82a9647f506f0a7cc07fd5c27','Phong Đoàn','0328923235'),
('fdec56a1-48ad-434c-982f-6b922f9133c4','anonymousUser','2025-03-09 00:40:22.997739',1,'anonymousUser','2025-03-09 00:40:22.997739','123 đường xyz','Ba Đình','Hà Nội','Kim Mã','c68506d2-7c97-4f6e-b51a-826f467dbd4e','49f8987235512670e4850a19a8773a9219a08f2ffe1a00bdabfe6b613e33cc68','Vũ Văn Abc','0345345435'),
('fe8ae9a7-ff9e-4eb8-bd3f-b934e119c5a2','anonymousUser','2025-03-07 15:26:28.532030',1,'anonymousUser','2025-03-07 15:26:28.532030','d','b','a','c','024317a8-9e55-419d-bb9e-ed4cb104d020','035e7129eb3610cdc33bc32489ef19b323846519f3f1546e9692eef2d703cae2','Huy 2','0205671231');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` varchar(36) NOT NULL,
  `createdby` varchar(255) DEFAULT NULL,
  `createddate` datetime(6) DEFAULT NULL,
  `is_active` tinyint NOT NULL,
  `modifiedby` varchar(255) DEFAULT NULL,
  `modifieddate` datetime(6) DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK9emlp6m95v5er2bcqkjsw48he` (`user_id`),
  CONSTRAINT `FKaf0wt8hgkk8v5rfpwdwq7se0t` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES ('259c1b22-7cf5-44ff-b9fa-73e3649eafe8','dotuandat2004nd@gmail.com','2025-04-04 16:29:59.799747',1,'dotuandat2004nd@gmail.com','2025-04-04 16:29:59.799747','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('4aea927c-3611-4fdd-b103-418e8784c050','doanthitrang@gmail.com','2025-03-10 15:14:23.874179',1,'doanthitrang@gmail.com','2025-03-10 15:14:23.874179','0a262bfd-d8c9-426f-a2f7-abaec3b0039c'),
('807331f7-b20d-4e2c-8fd3-5bc3aaa8ead3','xiaolingamingxg@gmail.com','2025-03-11 19:16:36.415698',1,'xiaolingamingxg@gmail.com','2025-03-11 19:16:36.415698','dcecb39a-f6a8-4c92-b0d3-e42e6579bee3');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_item`
--

DROP TABLE IF EXISTS `cart_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_item` (
  `id` varchar(36) NOT NULL,
  `createdby` varchar(255) DEFAULT NULL,
  `createddate` datetime(6) DEFAULT NULL,
  `is_active` tinyint NOT NULL,
  `modifiedby` varchar(255) DEFAULT NULL,
  `modifieddate` datetime(6) DEFAULT NULL,
  `quantity` int NOT NULL,
  `cart_id` varchar(36) NOT NULL,
  `product_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1uobyhgl1wvgt1jpccia8xxs3` (`cart_id`),
  KEY `FKjcyd5wv4igqnw413rgxbfu4nv` (`product_id`),
  CONSTRAINT `FK1uobyhgl1wvgt1jpccia8xxs3` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`),
  CONSTRAINT `FKjcyd5wv4igqnw413rgxbfu4nv` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_item`
--

LOCK TABLES `cart_item` WRITE;
/*!40000 ALTER TABLE `cart_item` DISABLE KEYS */;
INSERT INTO `cart_item` VALUES ('021bedda-3f0c-48a5-9e62-8c2e4cdf3206','doanthitrang@gmail.com','2025-03-10 15:14:23.923963',1,'doanthitrang@gmail.com','2025-03-10 15:14:23.923963',1,'4aea927c-3611-4fdd-b103-418e8784c050','5e2a4f52-906c-4cf8-9ec4-a559524e0879'),
('87e32e4a-db3e-433e-a583-712810ac29b1','xiaolingamingxg@gmail.com','2025-03-11 19:16:36.496291',1,'xiaolingamingxg@gmail.com','2025-03-11 19:16:36.496291',1,'807331f7-b20d-4e2c-8fd3-5bc3aaa8ead3','be924284-9e15-4ecd-873a-ce466aeb702f'),
('9d44375c-2d2b-48e1-8d0a-b7e0f0933147','dotuandat2004nd@gmail.com','2025-04-04 16:29:59.824426',1,'dotuandat2004nd@gmail.com','2025-04-04 16:29:59.824426',1,'259c1b22-7cf5-44ff-b9fa-73e3649eafe8','af3a0e21-1a61-46a0-82b7-cf4697249c07');
/*!40000 ALTER TABLE `cart_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` varchar(36) NOT NULL,
  `createdby` varchar(255) DEFAULT NULL,
  `createddate` datetime(6) DEFAULT NULL,
  `is_active` tinyint NOT NULL,
  `modifiedby` varchar(255) DEFAULT NULL,
  `modifieddate` datetime(6) DEFAULT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKacatplu22q5d1andql2jbvjy7` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES 
('03672617-9174-4944-ae9c-3389d6fddf8b','dotuandat2004nd@gmail.com','2025-03-10 18:56:35.193877',0,'dotuandat2004nd@gmail.com','2025-03-10 18:56:38.172964','rau-cu-qua-huu-co','Rau củ quả hữu cơ'),
('0edeeec4-514e-4423-a95a-9e7e49fa9ed6','admin@gmail.com','2025-02-07 18:53:50.125277',1,'dotuandat2004nd@gmail.com','2025-03-22 12:37:51.603160','rau-an-la','Rau ăn lá'),
('12c833ab-527e-46c6-bb5e-0771a898fc36','dotuandat2004nd@gmail.com','2025-03-15 23:51:06.293939',1,'dotuandat2004nd@gmail.com','2025-03-15 23:51:28.386280','rau-an-cu','Rau ăn củ'),
('1d2299b6-3783-46e0-b0dd-245542d26a4f','dotuandat2004nd@gmail.com','2025-02-15 01:00:04.650160',1,'dotuandat2004nd@gmail.com','2025-02-15 01:00:15.411115','rau-an-qua','Rau ăn quả'),
('293ac549-db0d-458d-87f8-9ece5827e20c','dotuandat2004nd@gmail.com','2025-02-08 01:13:09.303793',0,'dotuandat2004nd@gmail.com','2025-02-18 01:31:52.557013','trai-cay','Trái cây'),
('4ee24d42-77dc-43ce-960f-e06cfb713083','dotuandat2004nd@gmail.com','2025-02-08 01:43:31.160134',1,'dotuandat2004nd@gmail.com','2025-03-22 12:38:56.287486','thit-heo','Thịt heo'),
('6a768ea0-ebf9-4e85-910b-66a353e27923','dotuandat2004nd@gmail.com','2025-03-11 00:39:09.916049',0,'dotuandat2004nd@gmail.com','2025-03-11 00:39:25.848327','thit-ca-hai-san','Thịt cá hải sản'),
('6dd4379e-e7b7-4a8f-9649-0328a0a61d8a','dotuandat2004nd@gmail.com','2025-02-08 01:41:05.310983',0,'dotuandat2004nd@gmail.com','2025-03-22 13:44:04.879496','sua-va-cac-che-pham-tu-sua','Sữa và các chế phẩm từ sữa'),
('8af78245-0016-4e78-8424-82232802e656','admin@gmail.com','2025-02-17 21:01:11.565207',1,'dotuandat2004nd@gmail.com','2025-02-18 01:19:13.518826','gia-vi-nguyen-vat-lieu-nau-an','Gia vị nguyên vật liệu nấu ăn'),
('967602fb-2e2b-4aeb-9eb8-5897ae55c619','admin@gmail.com','2025-02-07 18:55:52.150122',0,'dotuandat2004nd@gmail.com','2025-02-18 01:32:55.973989','do-kho','Đồ khô'),
('a20e7a76-5913-4025-9e0b-9bfcb20c45c6','dotuandat2004nd@gmail.com','2025-03-10 19:22:32.866757',1,'dotuandat2004nd@gmail.com','2025-03-10 19:24:09.185399','cac-loai-hat','Các loại hạt'),
('b738b69a-cb75-4382-8ce4-2ca62f92af02','dotuandat2004nd@gmail.com','2025-02-08 01:40:46.619368',1,'dotuandat2004nd@gmail.com','2025-02-18 01:34:01.141215','super-food','Super food'),
('b75bd02b-6635-4c81-b7bd-d588bd34a28b','dotuandat2004nd@gmail.com','2025-02-08 01:42:20.443321',1,'admin@gmail.com','2025-03-12 21:07:17.018683','do-kho-khac','Đồ khô khác'),
('bc4d7360-ba80-46f7-acb5-b48d760ff07b','dotuandat2004nd@gmail.com','2025-02-18 01:17:19.334172',1,'dotuandat2004nd@gmail.com','2025-02-18 01:19:15.372157','rau-gia-vi','Rau gia vị'),
('d459df02-7e70-4b2e-9f33-0bcd1789c813','dotuandat2004nd@gmail.com','2025-02-08 01:42:30.673051',1,'admin@gmail.com','2025-03-12 21:06:29.138362','nam','Nấm'),
('dc9bdcd0-500c-4511-896e-4d828ecfc210','dotuandat2004nd@gmail.com','2025-03-22 13:27:26.133371',1,'dotuandat2004nd@gmail.com','2025-03-22 13:28:32.721301','combo','COMBO'),
('ee97933d-86ba-4e3c-8536-f9c70212fa09','dotuandat2004nd@gmail.com','2025-02-18 01:17:35.692718',1,'dotuandat2004nd@gmail.com','2025-02-18 01:19:16.889215','trai-cay-trong-nuoc','Trái cây trong nước'),
('f15405dd-ba41-4954-bad6-65232a8309ab','dotuandat2004nd@gmail.com','2025-03-11 00:38:59.109263',1,'dotuandat2004nd@gmail.com','2025-03-22 12:38:18.564978','trai-cay-nhap-khau','Trái cây nhập khẩu'),
('3707cb66-e53a-4295-a5d3-845625c924b6','dotuandat2004nd@gmail.com','2025-03-11 00:38:59.109263',1,'dotuandat2004nd@gmail.com','2025-03-22 12:38:18.564978','trai-cay-say-kho','Trái cây sấy khô'),
('31f57c4c-b50c-485f-993f-4c480877b3f5','dotuandat2004nd@gmail.com','2025-03-11 00:38:59.109263',1,'dotuandat2004nd@gmail.com','2025-03-22 12:38:18.564978','thit-bo','Thịt bò'),
('66e4808b-cc16-40d1-8c4c-511785a8b27e','dotuandat2004nd@gmail.com','2025-03-11 00:38:59.109263',1,'dotuandat2004nd@gmail.com','2025-03-22 12:38:18.564978','thuy-hai-san','Thủy hải sản'),
('4fc28aae-8101-4b95-85ac-2c89f6a0c5b9','dotuandat2004nd@gmail.com','2025-03-11 00:38:59.109263',1,'dotuandat2004nd@gmail.com','2025-03-22 12:38:18.564978','sua-bo','Sữa bò'),
('43175b90-311c-4643-815c-0e9358a27825','dotuandat2004nd@gmail.com','2025-03-11 00:38:59.109263',1,'dotuandat2004nd@gmail.com','2025-03-22 12:38:18.564978','sua-hat','Sữa hạt'),
('220d1e42-3ba9-475b-950a-0392668f583c','dotuandat2004nd@gmail.com','2025-03-11 00:38:59.109263',1,'dotuandat2004nd@gmail.com','2025-03-22 12:38:18.564978','che-pham-tu-sua','Chế phẩm từ sữa'),
('030da7c9-d09e-4016-b885-c2df0ddb5260','dotuandat2004nd@gmail.com','2025-03-11 00:38:59.109263',1,'dotuandat2004nd@gmail.com','2025-03-22 12:38:18.564978','gao-va-cac-loai-dau','Gạo và các loại đậu'),
('3713c508-7713-4d9f-96e8-0e1eb36b979e','dotuandat2004nd@gmail.com','2025-03-11 00:38:59.109263',1,'dotuandat2004nd@gmail.com','2025-03-22 12:38:18.564978','cac-loai-tra','Các loại trà'),
('36dcbb75-2988-4e4c-ae9c-fe57d3f5483f','dotuandat2004nd@gmail.com','2025-03-11 00:38:59.109263',1,'dotuandat2004nd@gmail.com','2025-03-22 12:38:18.564978','thuc-pham-thuc-duong','Thực phẩm thực dưỡng'),
('02aefc7c-a1cf-49e0-ac6a-3da23e1f4131','dotuandat2004nd@gmail.com','2025-03-11 00:38:59.109263',0,'dotuandat2004nd@gmail.com','2025-03-22 12:38:18.564978','cham-soc-co-the','Chăm sóc cơ thể'),
('fcf06f4d-1c0e-4453-b094-6f8c87db70e4','dotuandat2004nd@gmail.com','2025-03-11 00:38:59.109263',1,'dotuandat2004nd@gmail.com','2025-03-22 12:38:18.564978','danh-cho-me','Danh cho mẹ'),
('d71186c3-5756-4ee8-b27d-df635fdb726a','dotuandat2004nd@gmail.com','2025-03-11 00:38:59.109263',1,'dotuandat2004nd@gmail.com','2025-03-22 12:38:18.564978','danh-cho-be','Danh cho bé'),
('cb4b3ec0-3665-4b3e-8bc7-8cfe5626bc2e','dotuandat2004nd@gmail.com','2025-03-11 00:38:59.109263',1,'dotuandat2004nd@gmail.com','2025-03-22 12:38:18.564978','tinh-dau-dat-viet','Tinh dầu đất việt'),
('f57af8cc-bb54-4f3d-9e60-6e2f6f1bf9b1','dotuandat2004nd@gmail.com','2025-03-11 00:38:59.109263',1,'dotuandat2004nd@gmail.com','2025-03-22 12:38:18.564978','toi-la-thao-moc','Tôi là Thảo mộc'),
('adcf99cd-9a49-42e1-9120-b0e5cda6614e','dotuandat2004nd@gmail.com','2025-03-11 00:38:59.109263',0,'dotuandat2004nd@gmail.com','2025-03-22 12:38:18.564978','cham-soc-nha-cua','Chăm sóc nhà cửa'),
('c407c1ba-7d80-4684-b82a-db01e9017106','dotuandat2004nd@gmail.com','2025-03-11 00:38:59.109263',1,'dotuandat2004nd@gmail.com','2025-03-22 12:38:18.564978','nuoc-rua-chen','Nước rửa chén'),
('aba8a146-dc87-4786-9768-676c813040e0','dotuandat2004nd@gmail.com','2025-03-11 00:38:59.109263',1,'dotuandat2004nd@gmail.com','2025-03-22 12:38:18.564978','nuoc-giat-xa','Nước giặt xả'),
('48f8997a-dc5c-4f55-b32d-8a1f3e281fd8','dotuandat2004nd@gmail.com','2025-03-11 00:38:59.109263',1,'dotuandat2004nd@gmail.com','2025-03-22 12:38:18.564978','dung-dich-tay-rua','Dung dịch tẩy rửa'),
('dfbeb19c-21d0-4e24-bc60-091f18db6638','dotuandat2004nd@gmail.com','2025-03-11 00:38:59.109263',1,'dotuandat2004nd@gmail.com','2025-03-22 12:38:18.564978','dung-dich-khac','Dung dịch khác'),
('fc130572-0f12-4889-a874-1ce0e6adbc4f','dotuandat2004nd@gmail.com','2025-03-11 00:38:59.109263',1,'dotuandat2004nd@gmail.com','2025-03-22 12:38:18.564978','hop-gio-qua-bieu-tang','HỘP GIỎ QUÀ BIẾU TẶNG'),
('7941d5cc-3d0d-4978-8321-8246b61fc67d','dotuandat2004nd@gmail.com','2025-03-11 00:38:59.109263',1,'dotuandat2004nd@gmail.com','2025-03-22 12:38:18.564978','combo-di-cho-tiet-kiem','COMBO đi chợ tiết kiệm');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_supplier`
--

DROP TABLE IF EXISTS `category_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_supplier` (
  `category_id` varchar(36) NOT NULL,
  `supplier_id` varchar(36) NOT NULL,
  KEY `FKsim6tqlru56gt5jkbl4a4de62` (`supplier_id`),
  KEY `FKica61pv6q0m724pe4wgj8uusm` (`category_id`),
  CONSTRAINT `FKica61pv6q0m724pe4wgj8uusm` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FKsim6tqlru56gt5jkbl4a4de62` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_supplier`
--

LOCK TABLES `category_supplier` WRITE;
/*!40000 ALTER TABLE `category_supplier` DISABLE KEYS */;
INSERT INTO `category_supplier` VALUES 
('0edeeec4-514e-4423-a95a-9e7e49fa9ed6','a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d'), -- rau-an-la, Dalat Greens
('0edeeec4-514e-4423-a95a-9e7e49fa9ed6','b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e'), -- rau-an-la, Organic Farm VN
('0edeeec4-514e-4423-a95a-9e7e49fa9ed6','c9d0e1f2-a3b4-4c5d-6e7f-9a0b1c2d3e4f'), -- rau-an-la, Natural Farm
('12c833ab-527e-46c6-bb5e-0771a898fc36','a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d'), -- rau-an-cu, Dalat Greens
('12c833ab-527e-46c6-bb5e-0771a898fc36','b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e'), -- rau-an-cu, Organic Farm VN
('1d2299b6-3783-46e0-b0dd-245542d26a4f','a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d'), -- rau-an-qua, Dalat Greens
('1d2299b6-3783-46e0-b0dd-245542d26a4f','b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e'), -- rau-an-qua, Organic Farm VN
('4ee24d42-77dc-43ce-960f-e06cfb713083','c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f'), -- thit-heo, Vissan
('4ee24d42-77dc-43ce-960f-e06cfb713083','d4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a'), -- thit-heo, CP Foods
('8af78245-0016-4e78-8424-82232802e656','a3b4c5d6-e7f8-4a9b-0c1d-3e4f5a6b7c8d'), -- gia-vi-nguyen-vat-lieu-nau-an, Asia Foods
('a20e7a76-5913-4025-9e0b-9bfcb20c45c6','b4c5d6e7-f8a9-4b0c-1d2e-4f5a6b7c8d9e'), -- cac-loai-hat, Hanoi Organics
('b738b69a-cb75-4382-8ce4-2ca62f92af02','b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e'), -- super-food, Tropical Fruit
('b75bd02b-6635-4c81-b7bd-d588bd34a28b','c5d6e7f8-a9b0-4c1d-2e3f-5a6b7c8d9e0f'), -- do-kho-khac, Saigon Fresh
('bc4d7360-ba80-46f7-acb5-b48d760ff07b','a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d'), -- rau-gia-vi, Dalat Greens
('d459df02-7e70-4b2e-9f33-0bcd1789c813','d0e1f2a3-b4c5-4d6e-7f8a-0b1c2d3e4f5a'), -- nam, Fresh Garden
('dc9bdcd0-500c-4511-896e-4d828ecfc210','e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b'), -- combo, Dalat Farm
('ee97933d-86ba-4e3c-8536-f9c70212fa09','f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c'), -- trai-cay-trong-nuoc, Global Fresh
('f15405dd-ba41-4954-bad6-65232a8309ab','e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b'), -- trai-cay-nhap-khau, Fruit Import Co.
('3707cb66-e53a-4295-a5d3-845625c924b6','b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e'), -- trai-cay-say-kho, Tropical Fruit
('31f57c4c-b50c-485f-993f-4c480877b3f5','c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f'), -- thit-bo, Vissan
('66e4808b-cc16-40d1-8c4c-511785a8b27e','d6e7f8a9-b0c1-4d2e-3f4a-6b7c8d9e0f1a'), -- thuy-hai-san, Bac Tom
('4fc28aae-8101-4b95-85ac-2c89f6a0c5b9','e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b'), -- sua-bo, Vinamilk
('43175b90-311c-4643-815c-0e9358a27825','f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c'), -- sua-hat, TH True Milk
('220d1e42-3ba9-475b-950a-0392668f583c','e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b'), -- che-pham-tu-sua, Vinamilk
('c407c1ba-7d80-4684-b82a-db01e9017106','a7b8c9d0-e1f2-4a3b-5c6d-7e8f9a0b1c2d'), -- nuoc-rua-chen, Green Clean
('aba8a146-dc87-4786-9768-676c813040e0','b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e'), -- nuoc-giat-xa, Eco Wash
('48f8997a-dc5c-4f55-b32d-8a1f3e281fd8','a7b8c9d0-e1f2-4a3b-5c6d-7e8f9a0b1c2d'), -- dung-dich-tay-rua, Green Clean
('dfbeb19c-21d0-4e24-bc60-091f18db6638','b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e'), -- dung-dich-khac, Eco Wash
('fc130572-0f12-4889-a874-1ce0e6adbc4f','e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b'), -- hop-gio-qua-bieu-tang, Dalat Farm
('7941d5cc-3d0d-4978-8321-8246b61fc67d','e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b'), -- combo-di-cho-tiet-kiem, Dalat Farm
('03672617-9174-4944-ae9c-3389d6fddf8b','a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d'), -- rau-cu-qua-huu-co, Dalat Greens
('03672617-9174-4944-ae9c-3389d6fddf8b','b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e'), -- rau-cu-qua-huu-co, Organic Farm VN
('03672617-9174-4944-ae9c-3389d6fddf8b','c9d0e1f2-a3b4-4c5d-6e7f-9a0b1c2d3e4f'), -- rau-cu-qua-huu-co, Natural Farm
('293ac549-db0d-458d-87f8-9ece5827e20c','f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c'), -- trai-cay, Global Fresh
('293ac549-db0d-458d-87f8-9ece5827e20c','e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b'), -- trai-cay, Fruit Import Co.
('293ac549-db0d-458d-87f8-9ece5827e20c','b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e'), -- trai-cay, Tropical Fruit
('6a768ea0-ebf9-4e85-910b-66a353e27923','c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f'), -- thit-ca-hai-san, Vissan
('6a768ea0-ebf9-4e85-910b-66a353e27923','d6e7f8a9-b0c1-4d2e-3f4a-6b7c8d9e0f1a'), -- thit-ca-hai-san, Bac Tom
('6a768ea0-ebf9-4e85-910b-66a353e27923','d4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a'), -- thit-ca-hai-san, CP Foods
('6dd4379e-e7b7-4a8f-9649-0328a0a61d8a','e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b'), -- sua-va-cac-che-pham-tu-sua, Vinamilk
('6dd4379e-e7b7-4a8f-9649-0328a0a61d8a','f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c'), -- sua-va-cac-che-pham-tu-sua, TH True Milk
('6dd4379e-e7b7-4a8f-9649-0328a0a61d8a','e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b'), -- sua-va-cac-che-pham-tu-sua, Vinamilk
('967602fb-2e2b-4aeb-9eb8-5897ae55c619','b4c5d6e7-f8a9-4b0c-1d2e-4f5a6b7c8d9e'), -- do-kho, Hanoi Organics
('967602fb-2e2b-4aeb-9eb8-5897ae55c619','b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e'), -- do-kho, Tropical Fruit
('967602fb-2e2b-4aeb-9eb8-5897ae55c619','c5d6e7f8-a9b0-4c1d-2e3f-5a6b7c8d9e0f'), -- do-kho, Saigon Fresh
('02aefc7c-a1cf-49e0-ac6a-3da23e1f4131','e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b'), -- cham-soc-co-the, Dalat Farm
('adcf99cd-9a49-42e1-9120-b0e5cda6614e','a7b8c9d0-e1f2-4a3b-5c6d-7e8f9a0b1c2d'), -- cham-soc-nha-cua, Green Clean
('adcf99cd-9a49-42e1-9120-b0e5cda6614e','b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e'); -- cham-soc-nha-cua, Eco Wash
/*!40000 ALTER TABLE `category_supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact` (
  `id` varchar(36) NOT NULL,
  `createdby` varchar(255) DEFAULT NULL,
  `createddate` datetime(6) DEFAULT NULL,
  `is_active` tinyint NOT NULL,
  `modifiedby` varchar(255) DEFAULT NULL,
  `modifieddate` datetime(6) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `is_read` bit(1) NOT NULL,
  `message` text,
  `phone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` VALUES ('0ffba7e9-8789-401c-b564-c2366ba425a2','anonymousUser','2025-03-11 23:24:33.864595',1,'dotuandat2004nd@gmail.com','2025-03-12 00:59:46.373794','test@gmail.com','Test & Test',_binary '_','test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test ','0283748323'),
('4e18aff3-6e8f-4e78-8258-9dffc001a01b','anonymousUser','2025-03-12 01:31:38.270766',1,'admin@gmail.com','2025-03-12 12:01:35.666727','huyquanhoa@gmail.com','Huy Quần Hoa',_binary '_','abc','0205671231'),
('6ddc0573-b5d0-4c2e-b8f0-c74403f5bfef','anonymousUser','2025-03-11 23:21:55.897569',1,'dotuandat2004nd@gmail.com','2025-03-11 23:25:36.772544','dotuandat2004nd@gmail.com','Đỗ Tuấn Đạt',_binary '_','aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa','0944761755'),
('7f19c8aa-d904-4947-b29e-df04c90b7b86','anonymousUser','2025-03-11 22:48:59.011173',1,'dotuandat2004nd@gmail.com','2025-03-11 23:14:51.940296','nqhai@gmail.com','Nguyễn Quang Hải',_binary '_','abc...','0955996933'),
('8ce6541f-2998-4222-8983-905f731f9120','anonymousUser','2025-03-16 14:39:04.004110',1,'anonymousUser','2025-03-16 14:39:04.004110','lbbinh@gmail.com','Lê Bảo Bình',_binary '\0','xyz','0348973294'),
('a5e96e2c-dc37-4718-acdc-c535c1379fa9','anonymousUser','2025-03-11 19:38:02.064970',1,'dotuandat2004nd@gmail.com','2025-03-11 23:25:40.500985','tradao@gmai.com','Trà Đào',_binary '_','abcxyz','0987654321'),
('cab28b1a-29ec-485c-88ce-759f6dfcc7d9','anonymousUser','2025-03-16 14:38:39.544727',1,'dotuandat2004nd@gmail.com','2025-03-16 14:40:50.546607','adc@gmail.com','ADC',_binary '_','abc','0982349435'),
('e32934ff-c804-483f-8269-07efccc1cc2a','anonymousUser','2025-03-11 19:33:12.037132',1,'dotuandat2004nd@gmail.com','2025-03-12 20:41:24.868125','dotuandat2004nd@gmail.com','Đỗ Tuấn Đạt',_binary '_','test','0944761755');
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discount`
--

DROP TABLE IF EXISTS `discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discount` (
  `id` varchar(36) NOT NULL,
  `createdby` varchar(255) DEFAULT NULL,
  `createddate` datetime(6) DEFAULT NULL,
  `is_active` tinyint NOT NULL,
  `modifiedby` varchar(255) DEFAULT NULL,
  `modifieddate` datetime(6) DEFAULT NULL,
  `end_date` date NOT NULL,
  `name` varchar(255) NOT NULL,
  `percent` double NOT NULL,
  `start_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discount`
--

LOCK TABLES `discount` WRITE;
/*!40000 ALTER TABLE `discount` DISABLE KEYS */;
INSERT INTO `discount` VALUES ('6fb5f136-e2b3-4777-a892-648ebb83040c',NULL,NULL,1,'admin@gmail.com','2025-03-13 22:18:13.800678','2025-03-26','Siêu giảm giá 10%',10,'2025-02-03'),
('e6929ce7-7afb-46d2-9a8e-b3ef6a4b7882',NULL,NULL,1,'dotuandat2004nd@gmail.com','2025-03-13 21:29:04.322704','2025-03-12','Ngày vàng đại hạ giá 15%',15,'2025-02-05'),
('f8a8ddbe-dc8b-465d-b877-f688c4ac2e06',NULL,NULL,1,'dotuandat2004nd@gmail.com','2025-04-04 12:00:27.434122','2025-02-20','30/4 giảm giá 7.5%',7.5,'2025-02-10');
/*!40000 ALTER TABLE `discount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invalidated_token`
--

DROP TABLE IF EXISTS `invalidated_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invalidated_token` (
  `id` varchar(255) NOT NULL,
  `expiry_time` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invalidated_token`
--

LOCK TABLES `invalidated_token` WRITE;
/*!40000 ALTER TABLE `invalidated_token` DISABLE KEYS */;
INSERT INTO `invalidated_token` VALUES ('01187a65-ce0a-42bf-bf55-bff361ef0340','2025-03-18 09:16:09.000000'),
('01317366-7c9c-46a2-b105-aa8a262bd149','2025-03-16 00:52:54.000000'),
('01bf917a-402e-4928-8de7-4ac427e22dad','2025-03-16 00:40:35.000000'),
('02829588-624d-44ad-8a0d-fcdaebc838e4','2025-03-23 16:14:16.000000'),
('02e7dd21-6d5a-4aab-b5ef-d192d9ced5e3','2025-03-18 18:16:00.000000'),
('030e111e-0d1d-4c8f-af6f-34cd60ddb3a3','2025-03-16 19:37:16.000000'),
('034ac82e-677a-4fc9-8273-53d8bfa52d7b','2025-03-22 10:20:44.000000'),
('046fd735-b8d7-4712-a1e2-a0110305ce1e','2025-03-31 09:33:36.000000'),
('04772d87-9f75-4ccb-be08-0d625b57f63f','2025-03-22 22:34:21.000000'),
('04933972-c3f7-4e77-82f4-03d990048549','2025-03-16 17:09:43.000000'),
('062249e0-65a5-4464-9728-032348b6ba88','2025-03-24 11:44:56.000000'),
('06d7ed64-fdc2-40f7-bb1a-61235ab3b6fa','2025-03-24 11:47:55.000000'),
('06feffe6-a7e4-426e-975a-98471a999ae4','2025-03-20 21:57:27.000000'),
('07e93993-487a-4985-a8d6-47a90ee63b8a','2025-03-16 16:54:14.000000'),
('08df0cf4-47b0-40c3-9635-b97227ad9f79','2025-03-14 15:11:49.000000'),
('0ae84748-a685-4037-92e4-960749074b0c','2025-03-23 16:31:03.000000'),
('0bfbf940-af39-4f00-9c59-b554ef7867f4','2025-04-01 19:45:38.000000'),
('0c6ab59d-3a12-4dc4-9b28-96020859ab77','2025-03-29 14:38:12.000000'),
('0f85a9eb-9240-4ccc-9e98-9f9bb128ba0e','2025-03-21 23:34:14.000000'),
('111dba80-f4d1-41da-9dac-9029f7efe767','2025-03-16 16:52:58.000000'),
('1239ba0e-5ef1-4efc-b37f-6b88a50cc8e7','2025-03-18 11:07:51.000000'),
('1250d560-71d5-4a6c-83fd-23cb506853e0','2025-03-27 23:12:54.000000'),
('142f995a-600f-4884-a54f-f20aba180d28','2025-03-16 15:26:45.000000'),
('15e7e0ad-5666-4452-8dca-0e9c864f8dda','2025-03-17 14:04:11.000000'),
('15f8b9f3-01ff-4d57-b490-475a0e9d6c68','2025-03-21 22:31:10.000000'),
('169f2a2e-99c7-46b1-8299-3a94988faeb5','2025-03-16 15:31:57.000000'),
('172470ee-5451-4a6c-9834-abf7149093c5','2025-03-14 13:41:21.000000'),
('17e4e625-52f2-4d52-bf60-8da624466f63','2025-03-14 13:43:52.000000'),
('18814e8b-0a18-468c-9a12-62b54b7f4a13','2025-03-20 00:56:58.000000'),
('19a3949f-1b14-4c3d-8fb6-3e661d745b20','2025-04-01 19:44:59.000000'),
('1c0e7d2a-963f-496c-bef8-3d8cbce08f08','2025-03-14 13:55:49.000000'),
('1c7c1272-d828-40f9-9815-fa3df17fd848','2025-04-11 00:08:49.000000'),
('1e4ed003-5537-4834-84cd-6fb0571c6e52','2025-03-24 01:26:01.000000'),
('1e81bb69-5a2f-4e7e-be1d-b590002505f7','2025-03-28 13:34:01.000000'),
('1f4fb07a-1fb5-484f-a982-a477c59e98ad','2025-03-25 09:03:26.000000'),
('2062ab3e-b43f-4413-886d-bda6434a1101','2025-03-16 17:12:52.000000'),
('21cf1b42-dbe5-4379-a8d8-5edaab70ac52','2025-03-17 17:18:00.000000'),
('227fe260-a31e-4475-9f22-cb96827971d5','2025-03-27 18:26:56.000000'),
('22ea07be-e9bd-452a-b1a2-4c1006ebb135','2025-03-14 13:17:21.000000'),
('23ae25a3-d59c-4c09-b545-e514d6831cbd','2025-03-18 12:15:51.000000'),
('24318228-b4c7-48a3-bb29-f15b5f634c82','2025-03-22 10:22:52.000000'),
('25a14d2e-8e7e-4d18-b1c3-bfec3e023ff8','2025-03-18 19:35:00.000000'),
('25e0ad62-94ad-41cf-9a33-7c3c8c53fc5f','2025-03-18 11:05:42.000000'),
('26971a98-5d7b-4643-aca7-65ad17144129','2025-03-19 18:34:56.000000'),
('26fbc359-348f-4619-8598-ddb0b7b37e23','2025-03-16 12:51:24.000000'),
('280e32c0-ab9d-41f3-89e1-d9d233dc6c98','2025-03-25 23:13:47.000000'),
('2852ac28-19a8-4daa-8457-02b38c79e655','2025-03-23 16:15:03.000000'),
('28653fd9-57e0-4f90-a968-f0f784124751','2025-03-15 21:22:59.000000'),
('28d83ff4-16b3-4e40-a926-043b79722197','2025-04-11 00:09:43.000000'),
('29246132-835a-4423-a06a-1c1f949ed5e7','2025-03-19 00:39:36.000000'),
('2a424b1f-0d32-48f6-b291-8c6f4f6bc40e','2025-03-21 22:30:42.000000'),
('2abd1cfa-df71-4b2a-aa02-19404383f7cc','2025-03-28 18:34:49.000000'),
('2d067bc5-4678-43b4-9c42-527f6749b575','2025-03-23 13:34:52.000000'),
('2deeb4ff-5a27-4935-bdad-a9b84eb62188','2025-03-28 17:57:05.000000'),
('2edbdef0-7f4e-421a-8537-76d6707e7ca3','2025-03-16 21:34:39.000000'),
('2fdedaaf-2288-4ecf-9f4c-2d852b670613','2025-03-19 18:46:11.000000'),
('31869423-bafc-480d-856b-83b9b80d2aa6','2025-03-23 16:34:16.000000'),
('31f93db5-3b28-4d1e-a9b9-e152fad067dd','2025-03-16 18:33:52.000000'),
('31fc081a-0167-49cc-b3e3-4108de3a2754','2025-04-11 15:40:15.000000'),
('33042c1a-b278-47be-9f7d-c0d18d2d239f','2025-03-23 00:05:02.000000'),
('33c1fd50-6693-4e2f-9115-e4324236635f','2025-03-24 11:13:13.000000'),
('33f1ee90-be0d-4118-9589-d31dae0f0a14','2025-03-21 21:49:16.000000'),
('34ebc79b-5ece-49bb-80a8-7d5aaa8f70a7','2025-03-23 16:32:23.000000'),
('3509d29d-69b5-4fb5-894a-4214ece458be','2025-03-14 13:57:57.000000'),
('365e2ea0-91f5-4cb9-8a56-04c29e341d3c','2025-03-19 17:12:26.000000'),
('3895d933-55b9-46bb-9478-f50f1f24bb50','2025-03-16 18:44:35.000000'),
('392a5447-bf9a-4ece-ad96-99e043a91279','2025-03-29 15:20:00.000000'),
('39b4320c-88df-45a2-acc3-85b74d435d7d','2025-03-23 16:14:40.000000'),
('3a681f73-f857-47b6-af3d-3b32d71039b6','2025-03-18 18:13:15.000000'),
('3abac60a-e948-46bd-8d16-dc31eb48c3ed','2025-03-14 13:46:05.000000'),
('3ac0770c-06b4-40de-8d25-f35d03803806','2025-03-15 17:47:22.000000'),
('3b842c0b-b582-482a-8be8-7f41edaa72ab','2025-03-28 15:58:49.000000'),
('3c2b74e3-2cb0-4b1b-9aa2-1ba7861b1d8c','2025-03-21 22:31:50.000000'),
('3cc9b1ba-953b-4c94-a4ff-611039a6c2aa','2025-04-01 07:43:42.000000'),
('3d670af8-5303-4a99-9e31-bbdb9005280b','2025-03-15 22:48:45.000000'),
('3e504a0d-dba1-4c4e-a7f1-cb0003b387bf','2025-03-31 12:13:36.000000'),
('3efab0a1-9e89-465a-a0f5-690babfee410','2025-03-21 22:43:41.000000'),
('3fa83dc7-b635-4a4d-b12d-a5c10ecf1bb1','2025-03-15 21:36:22.000000'),
('3fb3fdf1-2fe3-4d42-841a-fd77750378d0','2025-03-23 16:33:26.000000'),
('40a1fa7c-11d5-4a3d-8197-b441c5486345','2025-03-19 01:10:07.000000'),
('4152efe3-8e4c-461a-966d-2bb215d32439','2025-03-15 17:47:06.000000'),
('42aee976-ec9a-4671-8154-9f32b9340c7f','2025-03-16 17:12:17.000000'),
('42fb21da-b988-471a-b68d-ebf1058bcd05','2025-03-19 20:43:36.000000'),
('4425b78c-1287-4c91-be0b-d77aff143931','2025-03-16 16:46:48.000000'),
('46775a7c-8533-4707-ad41-36c860564d50','2025-03-30 16:50:17.000000'),
('475c3d48-f55c-41f0-aa9a-0c67335b007b','2025-03-15 21:26:35.000000'),
('47709af2-853c-4c5c-a57c-050b9896c836','2025-03-14 13:33:21.000000'),
('47c068c5-46d0-4239-9f16-d51c56148865','2025-03-18 12:00:35.000000'),
('485f5727-fafa-446b-87fa-ae517ead82bc','2025-03-14 13:31:35.000000'),
('48d4b1d9-5334-475e-8096-78da246f3d32','2025-03-26 20:55:24.000000'),
('48ec14d6-b201-4d00-96af-5778f735c588','2025-03-19 17:17:56.000000'),
('4a3b8a37-4f99-4afb-a44f-ee31bfb18f8a','2025-03-22 01:47:24.000000'),
('4b28d2a5-a785-4eb4-8764-cfd79c9b254c','2025-04-01 07:48:49.000000'),
('4b47f66d-144e-4432-98d9-2e192eaaf987','2025-03-14 13:17:47.000000'),
('4c0dc33e-bab3-47e6-845e-c29ba43dba18','2025-03-16 17:07:16.000000'),
('4d4ca87e-efd0-4fbe-8961-cf7fc4599073','2025-03-23 15:27:40.000000'),
('4f8feabd-c678-49d0-ab4e-725aa481728f','2025-04-01 00:29:47.000000'),
('4fa8999b-0b74-460d-bcef-75782a0dba01','2025-04-01 19:31:20.000000'),
('5188f5d3-dfec-4029-87f4-af07b27c57e7','2025-03-14 13:47:35.000000'),
('51d83381-f97f-4090-9a0e-f673c4a6c209','2025-03-21 22:33:12.000000'),
('53a0f432-2306-467b-8f91-69f85dca3b1a','2025-03-23 18:05:56.000000'),
('547658b6-6b68-4128-9ad3-2bac3ed81427','2025-03-19 01:09:12.000000'),
('55562069-2f1d-4248-b3ef-b3fe2227e2f9','2025-03-20 17:56:53.000000'),
('562db112-42fc-431d-8c74-d846165c745e','2025-03-19 01:33:35.000000'),
('5975ee1d-5c8c-461d-a788-89649d46eb4b','2025-03-17 19:52:10.000000'),
('5a3a3be5-87db-4002-b458-a3458814e961','2025-03-15 17:46:38.000000'),
('5a97b1e6-52b4-437c-a1ec-10ff9a764b6b','2025-03-23 16:43:24.000000'),
('5b034c88-57cc-424f-aa81-6b9f406626a8','2025-03-16 12:48:57.000000'),
('5c5e5c36-6cfb-424e-aac5-6a07fd65978f','2025-03-22 08:34:23.000000'),
('5d62c45c-e4a3-4549-b06c-60a010459469','2025-03-20 08:49:33.000000'),
('5d64c9de-be63-493f-9c92-0499b47b53eb','2025-03-14 13:20:18.000000'),
('5e8b5a09-ec6c-484f-b1a7-974ffad1e68f','2025-03-15 16:30:33.000000'),
('5f4f5a97-cf56-44bd-a774-6beafe1e670b','2025-03-17 01:38:32.000000'),
('5fd158e1-d67d-48d6-81c0-baf75648af12','2025-03-28 22:33:10.000000'),
('5fe43a7e-d6df-4723-823f-7777d4c11263','2025-03-14 14:24:22.000000'),
('60b2a241-45bb-4a0a-bedd-6b38672cba91','2025-03-18 00:34:06.000000'),
('61cb4dc3-1192-40a5-97db-dab99c0df328','2025-03-24 12:15:46.000000'),
('62046298-d9f8-4cb3-a0af-90c80b482273','2025-03-19 16:30:52.000000'),
('62f2fc6a-94e2-4fdf-8b1e-282c8b040e15','2025-04-15 20:22:52.000000'),
('637fda3b-e1a6-434c-b371-c22d9b333ef4','2025-03-25 23:20:19.000000'),
('63bfcdfb-b98b-4d5f-9a7c-d667732ded30','2025-03-16 23:34:42.000000'),
('63c0d286-23e2-4741-be36-015386766793','2025-03-24 01:20:31.000000'),
('6403918c-003a-44b9-b3a9-ddb9bb71bb3b','2025-03-22 10:21:54.000000'),
('6543299d-ee43-45a3-857b-5f37d97ac15d','2025-03-24 01:16:20.000000'),
('65f6aa56-c286-48a8-a68f-1ec02e549e05','2025-03-18 07:16:17.000000'),
('66671c62-c81e-4d43-b0cb-4576f0fd9fc8','2025-03-19 17:04:03.000000'),
('68280c83-fb9d-4d99-b9c3-0a2ad6b07fee','2025-03-23 16:43:02.000000'),
('68cd6fce-211b-4c5f-aeab-477dc969cc20','2025-03-19 20:53:37.000000'),
('6910cc7a-794e-4782-be14-492084fa56f3','2025-04-01 08:52:27.000000'),
('6a438765-6aa6-442c-9935-6aefc3ddf04e','2025-03-18 08:54:44.000000'),
('6b568ee9-0bd2-415a-ab2f-06353a7ca136','2025-03-15 18:31:01.000000'),
('6bce9e43-f68f-4dfb-b062-bdb906241a0b','2025-03-17 17:51:42.000000'),
('6c1c42d7-a9c7-4480-9c7b-78c3b9173a33','2025-03-16 15:11:33.000000'),
('6dc06ff8-6463-4d87-82eb-14351dbb1bdb','2025-03-18 11:57:06.000000'),
('6e0790db-3fb9-4f08-b99c-c593ccc9263b','2025-03-14 13:57:11.000000'),
('6e31e340-9e5c-4fce-bd16-54be26935156','2025-03-17 15:14:32.000000'),
('6e723727-3d47-4701-9019-f7f1ef7b222d','2025-03-24 01:26:36.000000'),
('6ed55582-bd7a-43b3-a533-1e2437ba410a','2025-04-11 16:26:41.000000'),
('6ede002b-8cad-4ece-abcc-98d2c5519dfb','2025-03-23 14:39:13.000000'),
('6f605e7d-07ad-4b86-a3ea-a69625287a0d','2025-03-18 19:16:45.000000'),
('7059c27f-1cfb-417b-88eb-211291f019ae','2025-03-31 09:25:07.000000'),
('70e1a23d-e4ce-4020-8bfd-e0b91db73fe4','2025-03-14 13:37:05.000000'),
('72b44bba-c0b5-4a14-b938-6940c19b83a5','2025-03-18 18:11:57.000000'),
('73271c43-bfec-4d96-9f4d-2b5f4937999e','2025-03-14 13:22:27.000000'),
('73e18761-be8c-4380-af71-29b09d64cdc9','2025-03-19 17:14:16.000000'),
('74abcdf6-8a2f-41f0-aa52-8f6e1b07a75b','2025-03-23 16:40:26.000000'),
('75349d1e-b7d4-42b0-a07a-fe07afd74925','2025-03-16 15:32:24.000000'),
('76efcee8-9160-458e-817d-0072966155dc','2025-04-11 00:09:18.000000'),
('779860bf-b67a-4c7b-bbc1-2cbcac183232','2025-03-14 13:25:20.000000'),
('77ce9dd3-974d-4f76-a037-27fb274fec7f','2025-03-19 01:32:56.000000'),
('7823b2cc-86db-49bd-8219-4b38836a7726','2025-03-19 22:56:37.000000'),
('7b853102-322a-46eb-bf75-c794637e745c','2025-03-14 15:31:49.000000'),
('7ee896ea-b396-49b9-974a-b943741bfc6e','2025-03-20 11:24:08.000000'),
('7f02a9a8-42bb-432c-94b7-fc19f9e88244','2025-03-16 18:43:26.000000'),
('7f4b0cc6-05cb-4974-aa40-591220b4e017','2025-03-18 19:16:07.000000'),
('7fd0a865-0faa-4ef5-aff2-fa05e17d155d','2025-03-15 21:33:33.000000'),
('7fee767e-1214-4b45-b803-c6333e06805c','2025-03-16 19:45:21.000000'),
('80102552-5e7c-46dc-ac0a-c16b5b3ade99','2025-04-15 08:02:12.000000'),
('82240487-7d1c-49a8-9221-f519d5032175','2025-03-18 11:32:28.000000'),
('84b5f166-bfb1-446c-b838-56998c4f8506','2025-03-20 22:23:15.000000'),
('85f63326-f0b0-4f08-a185-7fedc6f5494b','2025-03-24 12:35:45.000000'),
('86391b53-d2d0-4511-a098-d44d98ce549b','2025-03-16 17:10:02.000000'),
('8671b6b5-a2aa-49a2-bfb9-b5a0dfb5a5d2','2025-04-11 15:26:53.000000'),
('891f60e6-c777-4872-8020-b8e5b0f9bd1f','2025-03-20 15:56:25.000000'),
('89e03727-664b-40ae-b97f-831f56756e3f','2025-03-18 09:17:00.000000'),
('89ea2110-d186-4d1f-be2c-157ebc265b27','2025-03-26 18:28:48.000000'),
('8b94239e-09d4-4dac-ab29-fe3d1ac1d50c','2025-03-14 13:48:12.000000'),
('8c127bda-2d09-4036-8d98-b62ee9be3805','2025-03-16 17:13:10.000000'),
('8d4f519c-f97a-4926-98cb-feac08adf342','2025-03-16 16:01:59.000000'),
('8e27722a-86ab-4c07-ae92-bb141eb009b8','2025-03-16 16:49:50.000000'),
('8f700e9b-85aa-4ad4-bc35-be8991e8a81a','2025-03-18 22:49:18.000000'),
('8f873943-cfa2-40d8-b107-696916bfb66c','2025-03-19 00:36:41.000000'),
('8fcd0b62-1a3e-4674-baae-12a7cde419b9','2025-03-17 17:39:12.000000'),
('91cac237-d573-4dfd-a88c-823ba241fdeb','2025-03-18 07:19:32.000000'),
('91d8c77b-a57d-4c7b-86e4-cce750bd9eb4','2025-03-16 16:58:20.000000'),
('935449ee-c542-4529-aafc-1167c9b027e2','2025-03-16 16:58:57.000000'),
('9365e824-e5e1-4d0b-a377-56fd407f84b9','2025-03-23 16:31:56.000000'),
('93d35eae-85f8-4924-9211-dca142cae5c7','2025-03-14 13:49:39.000000'),
('93e027b6-f334-4ac8-9c8b-22bc5d97af26','2025-03-26 16:28:00.000000'),
('94a045c5-4e78-4f6d-a9ee-08e8a18b3860','2025-03-18 09:23:04.000000'),
('94b0cc1c-7a34-4854-ba3f-76b559bd8043','2025-03-31 09:38:25.000000'),
('9572cf06-e9d2-4a7b-8c09-7b9cd677433c','2025-03-18 07:23:34.000000'),
('95c73268-194f-452a-b55c-5f56e28bcce9','2025-03-16 17:06:11.000000'),
('95ed1781-8865-4c8d-9e13-2ce45d7db09d','2025-03-21 22:31:26.000000'),
('96c9ac5c-383d-4be5-b80b-7c9e36affbb6','2025-04-18 12:00:48.000000'),
('977334eb-f626-4fe0-9c53-98217f064b18','2025-03-29 15:20:59.000000'),
('97f0a985-758c-46d4-b722-ee0afbdd1719','2025-03-17 15:06:56.000000'),
('9817a3fd-01a3-4fb9-9122-7ab53766835a','2025-03-18 18:14:03.000000'),
('987cf8d9-1e43-431b-b5d9-f7ad564c5bcb','2025-03-19 20:42:57.000000'),
('994cd6c3-4c57-478f-902c-6ba64a0d0ef6','2025-03-16 19:34:36.000000'),
('9abdb561-1099-42b0-a353-19821c908273','2025-03-31 09:27:19.000000'),
('9bed11bb-a9f9-461a-9e11-7466b7f3952a','2025-03-19 19:04:22.000000'),
('9c96f72c-b55e-4089-b945-85ed82ef389e','2025-03-25 07:16:40.000000'),
('9cf61373-7a59-410a-a762-d0ab5b611ce4','2025-03-31 11:38:43.000000'),
('9d208b9d-c602-4d28-a99b-c549f8b73843','2025-03-16 15:35:50.000000'),
('9e2732d9-b803-4fa0-b9e3-f7d3bf41944a','2025-03-20 22:24:27.000000'),
('9edda710-c767-480c-be2a-86abd843cd2e','2025-03-23 16:31:18.000000'),
('9faecf8d-9690-4347-81dd-304a3c9fa207','2025-03-14 11:51:21.000000'),
('9fcd3159-4d78-4d4e-90a4-90468e954aa1','2025-03-22 10:23:30.000000'),
('a04072d7-d86d-49a5-a712-3a3b7a911927','2025-03-16 22:55:13.000000'),
('a0a4c413-82a9-4375-a1f2-38acf957ca69','2025-03-16 00:15:15.000000'),
('a23390fc-86f9-4d93-a923-d069af04e667','2025-03-16 17:05:35.000000'),
('a29c4d08-128b-4ce0-bed5-464c196fea8e','2025-03-14 13:56:38.000000'),
('a2f00c9b-ecb5-422d-b668-b9f102a79e5c','2025-03-17 17:37:07.000000'),
('a3670cce-b930-452c-8d80-587f4099bfc3','2025-03-25 23:15:43.000000'),
('a46c60c2-df1d-4dcb-8798-bccb8c47719b','2025-03-19 15:38:34.000000'),
('a4bd2354-1d10-4d7e-9cac-cabb49a90f1c','2025-03-24 12:40:29.000000'),
('a4f8c8b7-e21c-45d6-9ae5-60ad1fc04d1e','2025-04-01 18:01:11.000000'),
('a5a3233c-9c7e-4676-b0d1-70b2c45c0f48','2025-03-24 01:24:05.000000'),
('a883cd8f-48a4-4d8d-8a51-71b4bef8bdd5','2025-03-18 22:17:47.000000'),
('ab297c4f-023e-402b-9481-917b76191323','2025-03-20 10:59:24.000000'),
('ab2eba51-156c-494a-baad-c3e633279f1f','2025-03-17 21:43:10.000000'),
('ac78ef4f-d175-4dc4-ab01-a5490ef85dd5','2025-03-31 09:33:10.000000'),
('ad0d0c7c-dbd1-4f12-a616-40ac44e378a4','2025-03-21 21:49:39.000000'),
('ad23eede-056a-4285-92e3-f93ca5f2a106','2025-03-18 00:27:56.000000'),
('ad2988b6-b4c4-4074-b968-b2ed3b62db15','2025-03-28 18:36:09.000000'),
('adc2b69b-5397-4f0d-9a8a-e8fb337e527e','2025-03-19 11:58:01.000000'),
('ae1ab359-7407-4ebf-93b2-49a54fed332f','2025-03-19 18:39:14.000000'),
('ae4caaa3-65c6-4336-ad77-48cbb6fc1258','2025-03-14 13:23:16.000000'),
('ae7596ff-0da1-489a-bac6-180a000da13c','2025-03-30 18:53:19.000000'),
('af13f795-9e84-4c37-9229-97d0ab747af3','2025-03-16 01:15:28.000000'),
('b03f3635-73c4-49ae-a27e-453e4d93f92a','2025-03-23 16:43:47.000000'),
('b0501c74-50cc-4f3d-bb11-51a1f99823b4','2025-03-16 17:09:12.000000'),
('b06a2b9f-7f2e-46e9-acfa-b949c2615f21','2025-03-23 18:05:39.000000'),
('b0d9ba42-3cac-4eec-ace0-676526fdd662','2025-03-22 10:23:11.000000'),
('b19c82fe-b907-4dd3-9889-977fd5c5437f','2025-03-17 15:11:07.000000'),
('b1b833f3-06cd-41c2-8df8-8c67f1ce9f40','2025-03-18 11:03:35.000000'),
('b22b017a-3829-4a98-94d2-f93fe03612d7','2025-03-19 01:31:50.000000'),
('b279101d-fccf-4b3f-828b-bb776b8afb0e','2025-03-16 23:29:06.000000'),
('b2edb2df-b0f5-487e-bfb1-e5724baeeff6','2025-03-14 13:33:32.000000'),
('b411b60b-5193-41e1-bf5f-5eb435e6d4b8','2025-03-15 23:03:35.000000'),
('b43b5601-4d40-4eb4-b358-a962fa6c587c','2025-03-18 18:13:43.000000'),
('b4f3b8d0-4a14-4983-8099-fe65a3fa598e','2025-03-18 12:15:15.000000'),
('b55fd964-7160-49e8-b4eb-888576f2389d','2025-03-23 13:34:13.000000'),
('b6cd9b5e-562e-4e96-9c01-fae6332abab3','2025-03-22 10:24:47.000000'),
('b6f92f93-bfb1-431c-a5f9-a231230a8bb3','2025-03-18 09:28:17.000000'),
('b7206fa1-2550-4dbf-961c-8586a81d1223','2025-03-19 18:49:34.000000'),
('b761ca4d-80fa-421b-a4d7-844a8eeb8e7a','2025-03-23 16:32:46.000000'),
('b9424e26-d422-4e04-817f-c07550d61514','2025-03-16 00:14:46.000000'),
('b9a1e517-2121-4e82-b1e9-128c54e4f813','2025-03-15 18:34:36.000000'),
('bd31aa25-dc8d-4d96-8f93-a8c2bfe695ac','2025-03-16 19:45:12.000000'),
('bdbb02ee-2015-46d1-92f2-808af9d40a99','2025-03-29 12:24:08.000000'),
('be4bb9ff-6f72-497e-9255-7941c5cc2c3d','2025-04-11 16:29:23.000000'),
('bece0c18-bb39-40a4-9592-f86f3be0bdaf','2025-03-17 17:39:29.000000'),
('c3ac0d2d-470f-44d9-8eda-293a83a58862','2025-03-15 23:03:46.000000'),
('c4543f03-9418-40f2-8304-3843150bab96','2025-04-15 20:17:16.000000'),
('c5e7c319-1616-42e0-8e9a-4fa6ce3eb453','2025-04-19 16:33:53.000000'),
('c5fd17f3-7253-4b03-8d23-9fdf293a3ff8','2025-03-23 16:44:29.000000'),
('c65cfb15-095b-4ff2-8262-ad46c8393b4a','2025-03-14 13:41:04.000000'),
('c7923bc0-8325-43a8-8287-731493465788','2025-03-23 16:40:47.000000'),
('c7f20620-81ca-4a23-88ad-0b0c939c155c','2025-03-31 09:27:48.000000'),
('c810e73d-461f-41dc-8584-cd9d86408e8e','2025-03-28 18:36:34.000000'),
('c85b0a40-c957-497a-b450-d520d7cecd1c','2025-04-15 20:20:50.000000'),
('c904637f-3b4d-4563-977d-ddb12aaf797c','2025-03-16 17:10:24.000000'),
('c9801b33-fd3b-4e73-8157-0e3ebbae1d37','2025-04-01 00:20:25.000000'),
('cae8e216-7a5d-45ec-a327-d82c2e54f85f','2025-03-19 01:30:44.000000'),
('caeb535c-0157-4223-9f80-dde316ae8966','2025-03-23 16:13:57.000000'),
('cb99a8b6-5400-4b47-83d5-599873b582cd','2025-03-14 13:49:51.000000'),
('cbdfd923-3cc1-4144-a9cc-45c0e6829843','2025-03-16 23:13:49.000000'),
('cd9b3252-bea4-46cb-9415-a97ed266752f','2025-03-19 19:01:51.000000'),
('cdc5ff98-a625-4346-9550-4a3017e8d1c0','2025-03-14 15:13:38.000000'),
('cf41d7d5-bf01-43e4-b202-d0e2c007f8a9','2025-03-19 19:04:50.000000'),
('d00df3c3-a33e-46fb-aeed-7942f1a611ce','2025-03-17 17:35:42.000000'),
('d020a782-3530-4315-a258-46275b9b2999','2025-03-16 22:39:28.000000'),
('d06b5313-727e-47fd-8fd8-e6a2a830e4cf','2025-03-17 15:13:17.000000'),
('d2a15ba3-24f6-4fbc-b12f-9737fb754907','2025-03-16 19:13:27.000000'),
('d318cdb0-fe66-4b6c-bb76-631a5ad1b07a','2025-03-28 15:57:09.000000'),
('d3493aa0-6184-4b6d-8f3d-73743084457a','2025-03-16 18:37:54.000000'),
('d4af7817-f861-432a-825e-eec4fc188202','2025-03-14 13:33:41.000000'),
('d4b4b39c-f3a4-4cc6-9825-f4bd1b41580d','2025-03-16 16:46:37.000000'),
('d50cb67f-ff4b-49d0-a96f-c674867a44a3','2025-03-18 12:14:31.000000'),
('d561a13f-6b2f-4a74-96c9-6f1617d5f61c','2025-03-17 17:34:29.000000'),
('d5966b2f-9521-4759-97d4-734eca641852','2025-03-17 14:08:30.000000'),
('d5d2e37c-ee8e-4aaa-8f18-787bd52d71ac','2025-03-16 15:11:07.000000'),
('d6ec8608-2d92-47fb-9d56-12059b466d04','2025-03-21 21:48:30.000000'),
('d81062dc-d345-4b7c-965a-e54dee7d36fa','2025-03-18 23:24:45.000000'),
('d8244e16-5471-4087-b234-64281a6e2c61','2025-03-29 09:58:09.000000'),
('d848b00d-223c-4f23-b042-8de16f9fa58d','2025-03-22 21:19:34.000000'),
('d87e77d7-398e-43d8-ade3-69cfe6c5a196','2025-03-14 13:34:28.000000'),
('db2e9797-85b7-4eb4-b5e2-c2f2cee9cbfe','2025-03-28 15:34:39.000000'),
('dba897f7-43cb-40b9-8a98-37fad9e9e9a3','2025-03-23 16:42:27.000000'),
('dc20622a-104c-414e-ba66-6679f70b9df8','2025-03-18 12:06:07.000000'),
('dc3fdf95-265a-4bf3-ad76-a14ac03ae8e2','2025-04-01 00:47:28.000000'),
('dc844c66-6afd-497a-9b9b-c64c86ec81b9','2025-03-18 11:32:02.000000'),
('dd47457d-5caf-44d2-81dc-479f63b71d0c','2025-03-17 15:11:25.000000'),
('dd52f518-b16f-4ab4-af11-db11e78f6f88','2025-04-19 16:34:40.000000'),
('ddfdd7a1-74df-4b4e-af38-52a9349de458','2025-03-28 15:35:58.000000'),
('df6a9f65-599d-4347-b301-69ec70f36a31','2025-04-11 11:51:37.000000'),
('df861e07-beaa-4609-b90a-be4d8a20aa0d','2025-03-17 17:39:49.000000'),
('e09b3bc7-3e46-4680-9130-c7ac4433b36f','2025-03-19 00:39:02.000000'),
('e17b846a-eaa7-4826-bdab-417505d5a4fc','2025-03-18 18:15:24.000000'),
('e1849c31-cd26-434c-af87-c85e0ba00560','2025-03-21 23:44:10.000000'),
('e23514c0-dabd-4829-b7f9-87c797352b72','2025-03-15 17:43:19.000000'),
('e383bb4c-dfb2-4368-b74c-d4ac04e8ce95','2025-03-23 02:12:04.000000'),
('e3df271a-e7cf-427d-957d-58a23f103f98','2025-03-23 15:27:17.000000'),
('e3f57aa2-ff6a-4aca-bef4-c38d54c336a5','2025-03-22 14:40:07.000000'),
('e4bfa0a3-daea-4815-8af9-c5800e733447','2025-03-24 12:31:47.000000'),
('e5c06fcc-84e8-4de6-a170-24e0bb4fa4f7','2025-03-21 21:48:55.000000'),
('e755bdce-856d-4cc0-9eb7-ee621a252c1c','2025-03-23 16:30:30.000000'),
('e777c237-63eb-47b9-bc8b-685208c5a9e0','2025-03-15 22:45:08.000000'),
('e7dbeb6e-97b5-48f2-bf55-d7bca11ba605','2025-03-18 22:48:52.000000'),
('e8022f38-1952-4ca5-a25e-68722a936440','2025-03-14 13:36:17.000000'),
('e8240f25-c923-4ca9-bd90-a6c53b653bda','2025-03-18 09:18:35.000000'),
('e861acb9-a758-40e1-977a-0b4b86db21d6','2025-03-14 12:56:01.000000'),
('e8a2e1f9-3cdf-466c-8a92-a6181ea5f314','2025-03-16 15:33:28.000000'),
('ea60a406-135d-4fe5-bdcc-34ac69317add','2025-03-14 15:27:57.000000'),
('ebfa5292-e048-4ba9-b0d5-e3b442689ef5','2025-03-25 23:14:20.000000'),
('ed529137-c1b1-4d6e-8fb7-e94d9b21a7e6','2025-04-11 13:31:59.000000'),
('ed61982d-73b8-4dd3-988c-d7f37eb7b217','2025-03-14 13:50:04.000000'),
('ee5dd14f-e06a-43fd-bbe1-4b42298df395','2025-03-31 12:14:08.000000'),
('f0b78f27-e61c-4f44-b29e-b5dc313bafe2','2025-03-15 01:23:23.000000'),
('f18becc6-b187-4c52-9ba0-17ae1a32c6e9','2025-03-14 13:17:58.000000'),
('f20fe4ce-893f-4e8a-945c-7bb1e9a2fdfd','2025-03-23 18:06:27.000000'),
('f23b88d1-d015-4c26-8a6e-81743b670350','2025-03-14 13:57:24.000000'),
('f24682e5-3e2a-4535-8e24-7efe478d0856','2025-03-18 11:05:27.000000'),
('f315c81a-2b36-4560-a599-e987aafc644e','2025-03-18 11:26:00.000000'),
('f3831e63-412e-4ecd-bbf8-5f217ff67a58','2025-04-11 00:07:14.000000'),
('f4113eaa-44ce-4aa7-b156-b41700718aef','2025-03-14 13:24:57.000000'),
('f50b3e10-bd8b-4b0e-a9c4-82e79456968d','2025-03-18 08:54:14.000000'),
('f6569a71-88f8-429b-8e25-013c3846f88d','2025-03-14 13:10:36.000000'),
('f6d34e94-9a11-477e-9a87-383576c5e6da','2025-03-14 13:41:51.000000'),
('f72771cb-d562-4001-8740-dc115326e0be','2025-03-28 15:55:47.000000'),
('f85504da-4b6a-4e1c-8995-c1ac71be335c','2025-03-31 12:13:53.000000'),
('f89ac151-db14-470a-811a-bb1e13b6d854','2025-03-15 23:07:47.000000'),
('fb3dc6de-31a6-4ff2-b7c4-e77592e02729','2025-03-23 18:06:07.000000'),
('fbf8b9e2-130f-498c-8713-f00f493644ff','2025-03-18 09:17:53.000000'),
('fc06b8d5-b4f3-4e2b-a16c-6a98ca325137','2025-03-23 00:08:03.000000'),
('fc0b7f72-6957-41b6-a3ce-f86e4a2ee148','2025-03-14 13:31:59.000000'),
('fc7f3643-04ac-45be-9793-dc9e9b325df4','2025-03-16 16:56:26.000000'),
('fc9f54b7-e9c2-466f-8f0a-3085be8ea57a','2025-03-16 16:58:34.000000'),
('fdcbe85c-8f78-498c-b100-3b5eb69f53b1','2025-03-19 17:20:06.000000'),
('fe47a5ff-9644-47e5-b535-d56750919f2d','2025-03-28 15:54:32.000000'),
('fe7fbff9-c0f9-479c-a129-25d2ec1e3709','2025-04-01 13:39:58.000000'),
('ff3d167f-426b-4082-9525-d97925e331d4','2025-03-17 17:52:00.000000');
/*!40000 ALTER TABLE `invalidated_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_receipt`
--

DROP TABLE IF EXISTS `inventory_receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_receipt` (
  `id` varchar(36) NOT NULL,
  `createdby` varchar(255) DEFAULT NULL,
  `createddate` datetime(6) DEFAULT NULL,
  `is_active` tinyint NOT NULL,
  `modifiedby` varchar(255) DEFAULT NULL,
  `modifieddate` datetime(6) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `status` enum('CANCELED','COMPLETED','PENDING') DEFAULT NULL,
  `total_amount` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_receipt`
--

LOCK TABLES `inventory_receipt` WRITE;
/*!40000 ALTER TABLE `inventory_receipt` DISABLE KEYS */;
INSERT INTO `inventory_receipt` VALUES ('03001106-df33-4e43-a681-c40e9a60062e','dotuandat2004nd@gmail.com','2025-04-04 11:53:39.736344',1,'dotuandat2004nd@gmail.com','2025-04-04 11:53:39.736344','Tai nghe có dây','PENDING',2072500000),
('06b03f7c-2b25-4a4b-934a-96f5c29e2736','dotuandat2004nd@gmail.com','2025-03-05 21:40:07.292839',1,'dotuandat2004nd@gmail.com','2025-03-05 21:40:22.407761','','COMPLETED',424200000),
('08814390-d044-43ee-a8fe-2ca385f682d1','dotuandat2004nd@gmail.com','2025-03-23 19:28:54.894842',1,'dotuandat2004nd@gmail.com','2025-03-23 19:29:52.468800','','COMPLETED',2273000000),
('0d971c5b-47f3-442b-a8d8-b5203f5ddff2','admin@gmail.com','2025-03-12 23:31:19.315294',1,'dotuandat2004nd@gmail.com','2025-03-13 21:07:30.893145','Realme','COMPLETED',4655000000),
('0dcec000-e12e-4c14-a5a0-456daf28664a','dotuandat2004nd@gmail.com','2025-03-16 19:16:26.442650',1,'dotuandat2004nd@gmail.com','2025-03-16 19:16:53.685402','Xiaomi','COMPLETED',1294000000),
('0e149c35-b9e4-4af1-ba4d-b7285111ffc6','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.396386',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:18.126200','Chuột không dây','COMPLETED',2124000000),
('20665167-67d3-4fff-a198-94f11ce6ff64','admin@gmail.com','2025-03-12 01:35:57.918137',1,'dotuandat2004nd@gmail.com','2025-03-12 20:41:21.698926','','COMPLETED',590800000),
('2613ed26-3981-46f4-9ddb-a9702cc5e8d5','admin@gmail.com','2025-03-11 09:10:02.531984',1,'admin@gmail.com','2025-03-11 09:14:34.779513','','COMPLETED',707000000),
('395c2954-bfe8-4fbe-a05e-ddf2c6b9de3e','dotuandat2004nd@gmail.com','2025-02-23 15:28:33.288924',1,'dotuandat2004nd@gmail.com','2025-02-23 15:28:59.687901','Apple: Lần 2','COMPLETED',2238000000),
('42f5635e-8f51-485a-940b-d0b3afbddc4e','dotuandat2004nd@gmail.com','2025-02-23 15:38:17.080033',1,'dotuandat2004nd@gmail.com','2025-02-23 16:01:23.406506','Apple: Lần 3','CANCELED',6714000000),
('45c43b45-2360-4ffa-87ad-16bebafa9e9b','admin@gmail.com','2025-02-22 14:26:55.753442',1,'dotuandat2004nd@gmail.com','2025-02-23 14:26:51.050757','Nhập kho lần 1','CANCELED',1880000000),
('50db492a-679a-4a21-bad4-b1e45394bab2','dotuandat2004nd@gmail.com','2025-03-05 21:39:09.999286',1,'dotuandat2004nd@gmail.com','2025-03-05 21:40:26.335980','','COMPLETED',3465600000),
('512eff7d-e023-452d-97b8-dfd8e37389da','dotuandat2004nd@gmail.com','2025-03-12 01:05:02.444428',1,'dotuandat2004nd@gmail.com','2025-03-12 01:30:17.366093','','COMPLETED',1949100000),
('523e1850-7467-48b9-9457-02b4427210df','dotuandat2004nd@gmail.com','2025-03-16 19:03:11.599474',1,'dotuandat2004nd@gmail.com','2025-03-16 19:03:25.637381','','COMPLETED',11746000000),
('5acb4348-3815-4c20-94ae-0cc5d71d366e','dotuandat2004nd@gmail.com','2025-03-24 12:46:39.650971',1,'dotuandat2004nd@gmail.com','2025-03-24 12:46:50.802485','','CANCELED',2000),
('5f67d4aa-e7b0-42e3-a6f8-59e5ae56c740','dotuandat2004nd@gmail.com','2025-02-23 13:36:23.162911',1,'dotuandat2004nd@gmail.com','2025-02-23 14:29:50.382564','Apple: Lần 1','COMPLETED',2830000000),
('6c59315f-836c-4434-970a-5c6e9cd9af44','dotuandat2004nd@gmail.com','2025-03-12 00:27:33.460160',1,'dotuandat2004nd@gmail.com','2025-03-12 00:40:47.609441','TCL lần 1','COMPLETED',1643600000),
('6fc0e39f-565d-44f9-99d4-84df16559f27','admin@gmail.com','2025-03-11 09:14:20.743970',1,'admin@gmail.com','2025-03-11 09:14:43.011734','Xiaomi','COMPLETED',6830000000),
('8e8114eb-0b7c-4068-9c09-94c19e742353','dotuandat2004nd@gmail.com','2025-02-28 21:00:06.238211',1,'dotuandat2004nd@gmail.com','2025-02-28 21:56:05.198171','test','CANCELED',0),
('991b858e-886a-48c9-8ff4-71a368edf344','dotuandat2004nd@gmail.com','2025-03-16 18:42:51.544111',1,'dotuandat2004nd@gmail.com','2025-03-16 18:44:21.230574','test','COMPLETED',2850000000),
('a060c6ea-41f0-4b45-87e5-064bb54a5328','dotuandat2004nd@gmail.com','2025-03-24 10:43:19.630437',1,'dotuandat2004nd@gmail.com','2025-03-24 10:43:54.265838','Tai nghe có dây','COMPLETED',2072500000),
('a3ad1e70-a248-413b-8af1-86219b3a1c02','dotuandat2004nd@gmail.com','2025-03-10 16:29:57.996114',1,'dotuandat2004nd@gmail.com','2025-03-10 17:23:26.997520','Sony','COMPLETED',6952000000),
('b927eeb0-927e-4642-afac-7d384e6d9e2d','admin@gmail.com','2025-02-22 14:57:51.865461',1,'dotuandat2004nd@gmail.com','2025-02-28 21:55:54.785035','Test 001','CANCELED',460000),
('bdcc2d5c-b204-40a3-b20f-284d8f2ea6f1','dotuandat2004nd@gmail.com','2025-03-10 15:41:40.727893',1,'dotuandat2004nd@gmail.com','2025-03-10 16:24:43.174496','Vivo','COMPLETED',7506000000),
('be2198fb-f016-48b5-b324-58b32b725882','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.311801',1,'dotuandat2004nd@gmail.com','2025-03-24 10:30:41.877883',NULL,'CANCELED',2124000000),
('c1fc8ce9-ac6f-44b5-a797-be02e16e84b7','dotuandat2004nd@gmail.com','2025-03-04 22:34:22.288734',1,'dotuandat2004nd@gmail.com','2025-03-04 22:34:44.392098','','COMPLETED',104500000),
('c2d7a358-14c3-4107-bac6-3eb564fa4b43','dotuandat2004nd@gmail.com','2025-03-10 17:30:11.162198',1,'dotuandat2004nd@gmail.com','2025-03-10 17:30:26.328130','Nhập hàng LG','COMPLETED',2473500000),
('d72c2816-d523-4527-8628-295919f9cb63','dotuandat2004nd@gmail.com','2025-03-10 17:27:38.641181',1,'dotuandat2004nd@gmail.com','2025-03-10 17:28:39.851896','test','CANCELED',1000003000),
('d9051ce0-f139-4d63-9f62-e555992045cd','dotuandat2004nd@gmail.com','2025-03-10 17:50:51.417057',1,'dotuandat2004nd@gmail.com','2025-03-10 17:52:16.681771','test','CANCELED',300000),
('e7747def-c7aa-4ab4-97a1-414f7c935659','dotuandat2004nd@gmail.com','2025-03-03 15:45:41.758743',1,'dotuandat2004nd@gmail.com','2025-03-03 15:46:42.045936','','COMPLETED',2138000000),
('ebc4e1cf-9331-4407-97e7-fb9d19bf41c8','dotuandat2004nd@gmail.com','2025-02-23 14:31:36.052427',1,'dotuandat2004nd@gmail.com','2025-02-23 14:32:22.351364','Xiaomi: Lần 1','COMPLETED',1500000000),
('f012f7f4-a50a-44bd-88fb-2b162df6d28c','dotuandat2004nd@gmail.com','2025-03-12 01:07:46.066732',1,'dotuandat2004nd@gmail.com','2025-03-12 01:14:39.334056','Acer','COMPLETED',1359600000),
('fc124bfc-aff6-488e-b2f5-cbde4eaeabd4','dotuandat2004nd@gmail.com','2025-03-10 17:32:34.258079',1,'dotuandat2004nd@gmail.com','2025-03-10 17:40:08.639764','Test 001','CANCELED',300000);
/*!40000 ALTER TABLE `inventory_receipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_receipt_detail`
--

DROP TABLE IF EXISTS `inventory_receipt_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_receipt_detail` (
  `id` varchar(36) NOT NULL,
  `createdby` varchar(255) DEFAULT NULL,
  `createddate` datetime(6) DEFAULT NULL,
  `is_active` tinyint NOT NULL,
  `modifiedby` varchar(255) DEFAULT NULL,
  `modifieddate` datetime(6) DEFAULT NULL,
  `price` bigint NOT NULL,
  `quantity` int NOT NULL,
  `product_id` varchar(36) NOT NULL,
  `receipt_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKouqxyr51e121io0ok4x23pecd` (`product_id`),
  KEY `FKnpmn2oar5y7fw9rsjhomoi538` (`receipt_id`),
  CONSTRAINT `FKnpmn2oar5y7fw9rsjhomoi538` FOREIGN KEY (`receipt_id`) REFERENCES `inventory_receipt` (`id`),
  CONSTRAINT `FKouqxyr51e121io0ok4x23pecd` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_receipt_detail`
--

LOCK TABLES `inventory_receipt_detail` WRITE;
/*!40000 ALTER TABLE `inventory_receipt_detail` DISABLE KEYS */;
INSERT INTO `inventory_receipt_detail` VALUES ('038df394-1277-448d-9023-67b0149271ef','pesmobile5404@gmail.com','2025-02-28 21:00:38.185882',1,'pesmobile5404@gmail.com','2025-02-28 21:00:38.185882',0,1,'b2b5d2e3-7f13-49ca-91da-7bd969f794b8','8e8114eb-0b7c-4068-9c09-94c19e742353'),
('03bb7015-340c-40bb-a831-d5067dc0dfbf','pesmobile5404@gmail.com','2025-02-23 14:24:26.904067',1,'pesmobile5404@gmail.com','2025-02-23 14:24:26.904067',2000,30,'04bb4b23-8316-45f5-8534-6766fbca71d1','b927eeb0-927e-4642-afac-7d384e6d9e2d'),
('0871c765-4402-4fef-a0ab-a74d5582f597','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.322196',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.322196',450000,50,'b24e6918-da98-45ab-816d-4f7750420ca3','be2198fb-f016-48b5-b324-58b32b725882'),
('0d86b900-2558-4f09-ac96-20e8d5facd2f','dotuandat2004nd@gmail.com','2025-03-16 19:16:48.487685',1,'dotuandat2004nd@gmail.com','2025-03-16 19:16:48.487685',5190000,20,'a8930bce-5e69-45b4-9653-a4f44e894c9d','0dcec000-e12e-4c14-a5a0-456daf28664a'),
('0dd43e5c-095b-4ad6-8661-7844b275e677','dotuandat2004nd@gmail.com','2025-02-23 15:28:33.396125',1,'dotuandat2004nd@gmail.com','2025-02-23 15:28:33.396125',23000000,20,'e464bb21-5c91-43de-a392-1f75c5446bb0','395c2954-bfe8-4fbe-a05e-ddf2c6b9de3e'),
('0f317ed7-67a7-4b54-885f-6aca40a0e8cc','dotuandat2004nd@gmail.com','2025-03-16 19:03:11.617182',1,'dotuandat2004nd@gmail.com','2025-03-16 19:03:11.617182',27500000,100,'5e2a4f52-906c-4cf8-9ec4-a559524e0879','523e1850-7467-48b9-9457-02b4427210df'),
('0fb27dbf-6e0c-447b-8f08-647aee1c79a7','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.325410',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.325410',1790000,50,'9a0aae00-5dfa-4c86-8f85-4f62faeec6cf','be2198fb-f016-48b5-b324-58b32b725882'),
('10c6beb8-dfa6-49c9-b573-dadc0b04c90d','admin@gmail.com','2025-03-12 23:31:19.334266',1,'admin@gmail.com','2025-03-12 23:31:19.334266',14990000,70,'5acf3d41-2cee-46f9-937e-b8bc074698d4','0d971c5b-47f3-442b-a8d8-b5203f5ddff2'),
('11b44f7d-7af1-4432-a4da-a1a4d409232b','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.397386',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.397386',2390000,50,'350925fb-f69f-41e2-aa90-548c57a40f89','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('124953d7-8959-4336-a223-8f738b7d01e2','admin@gmail.com','2025-03-12 23:31:19.331704',1,'admin@gmail.com','2025-03-12 23:31:19.331704',2690000,70,'c4a9d42f-71a1-4c20-86e8-4c21e3469e6f','0d971c5b-47f3-442b-a8d8-b5203f5ddff2'),
('14830a4b-d356-441b-b0ef-8c15f868547c','dotuandat2004nd@gmail.com','2025-03-24 10:43:45.435177',1,'dotuandat2004nd@gmail.com','2025-03-24 10:43:45.435177',600000,50,'c3fe95e4-d90e-4eb6-90eb-684097c2e74d','a060c6ea-41f0-4b45-87e5-064bb54a5328'),
('16c32245-d8e7-4857-9a22-217fe3fbafed','dotuandat2004nd@gmail.com','2025-03-24 10:43:45.436787',1,'dotuandat2004nd@gmail.com','2025-03-24 10:43:45.436787',2600000,50,'2cf69fe3-a41b-4964-ba98-a122cca81a9d','a060c6ea-41f0-4b45-87e5-064bb54a5328'),
('17b4ddb9-62b3-4ae4-9cf7-ba9ce6bbfa02','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.396386',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.396386',2390000,50,'350925fb-f69f-41e2-aa90-548c57a40f89','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('187a09db-d677-4ebf-97f8-31bf8c0eee84','dotuandat2004nd@gmail.com','2025-03-10 17:23:15.288309',1,'dotuandat2004nd@gmail.com','2025-03-10 17:23:15.288309',58490000,50,'db4f0c9a-f449-4792-a64e-c55963f5e23e','a3ad1e70-a248-413b-8af1-86219b3a1c02'),
('18b41eea-99d2-444a-b721-e41c08935f0d','dotuandat2004nd@gmail.com','2025-02-23 15:38:17.122903',1,'dotuandat2004nd@gmail.com','2025-02-23 15:38:17.122903',16000000,60,'eadecf1a-53dd-4460-a0ed-4d175a2b000a','42f5635e-8f51-485a-940b-d0b3afbddc4e'),
('18ca3cd9-5af9-40c1-94a2-44c058e34e62','dotuandat2004nd@gmail.com','2025-04-04 11:53:39.742341',1,'dotuandat2004nd@gmail.com','2025-04-04 11:53:39.742341',200000,50,'92a24cce-e57a-4502-8a89-e0c9cdcc45ef','03001106-df33-4e43-a681-c40e9a60062e'),
('198b1686-7f6b-4c54-9b8e-8b5db5ce71ea','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.396386',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.396386',2690000,50,'bd0e6c67-f0c8-4848-8cf0-83a0d0194b77','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('1a21d219-71d4-4458-832f-c1727c84e325','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.399383',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.399383',290000,50,'260bc683-3527-4bcd-9ce9-d614f347fd0f','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('1a32e2d7-a14d-48b6-acd6-6a6db993467c','dotuandat2004nd@gmail.com','2025-04-04 11:53:39.742341',1,'dotuandat2004nd@gmail.com','2025-04-04 11:53:39.742341',1000000,50,'135861c7-fba7-4b28-9a3d-fed2093d33ca','03001106-df33-4e43-a681-c40e9a60062e'),
('1a58c062-ebe1-4d81-aafa-f597fee26781','admin@gmail.com','2025-03-12 23:31:19.334794',1,'admin@gmail.com','2025-03-12 23:31:19.334794',3590000,70,'1d5a4adf-d476-4690-a4a2-98906b6c7d7d','0d971c5b-47f3-442b-a8d8-b5203f5ddff2'),
('1a93c040-80d6-4b95-b70d-b18e1bbd085e','dotuandat2004nd@gmail.com','2025-03-16 19:16:48.487685',1,'dotuandat2004nd@gmail.com','2025-03-16 19:16:48.487685',2690000,20,'bb530f69-9702-424d-bca2-fcfd89625c04','0dcec000-e12e-4c14-a5a0-456daf28664a'),
('1aad1cfd-dffc-4ef6-91e6-25569179ec94','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.399383',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.399383',890000,50,'e4557f80-4dcc-4857-9f88-1dcf63544ede','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('1acaf12c-daeb-4ccd-b9c0-9fed2f251270','dotuandat2004nd@gmail.com','2025-03-10 15:41:40.782127',1,'dotuandat2004nd@gmail.com','2025-03-10 15:41:40.782127',18990000,100,'d5321ce2-0cd1-4c9b-a956-93b4c750625c','bdcc2d5c-b204-40a3-b20f-284d8f2ea6f1'),
('1bf6c6fd-f7c1-48bb-82ed-cb9d9e63b341','dotuandat2004nd@gmail.com','2025-03-16 18:43:26.787291',1,'dotuandat2004nd@gmail.com','2025-03-16 18:43:26.787291',28500000,100,'5e2a4f52-906c-4cf8-9ec4-a559524e0879','991b858e-886a-48c9-8ff4-71a368edf344'),
('1d6b1cba-5850-41e6-a7e9-6cec5f093b31','admin@gmail.com','2025-03-12 23:31:19.334266',1,'admin@gmail.com','2025-03-12 23:31:19.334266',890000,70,'298940d0-9254-4cdf-b549-ec663f16fdd9','0d971c5b-47f3-442b-a8d8-b5203f5ddff2'),
('1e0cb2be-15b9-44fa-ba22-d1a28e73b642','admin@gmail.com','2025-03-11 09:14:20.752750',1,'admin@gmail.com','2025-03-11 09:14:20.752750',3090000,100,'387bf7c9-0173-4976-be07-f1ba43845092','6fc0e39f-565d-44f9-99d4-84df16559f27'),
('1e168207-456c-4990-beda-b86446adf1e2','pesmobile5404@gmail.com','2025-03-10 17:37:26.497303',1,'pesmobile5404@gmail.com','2025-03-10 17:37:26.497303',1000,100,'920ac346-8d17-4410-ae52-4563b21e8ed3','fc124bfc-aff6-488e-b2f5-cbde4eaeabd4'),
('21ac9bd9-93ea-450e-967f-30c8b6433a7e','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.397386',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.397386',590000,50,'b9dc0806-4e27-4cde-86da-ce5eda3ab7b5','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('21b32491-6aed-417f-afc1-edd0835ed2db','dotuandat2004nd@gmail.com','2025-03-05 21:40:07.297004',1,'dotuandat2004nd@gmail.com','2025-03-05 21:40:07.297004',2990000,60,'74efbec6-3bfa-4745-ad2a-f0c7a7ebddcf','06b03f7c-2b25-4a4b-934a-96f5c29e2736'),
('22347129-bba9-44c6-942c-44a18b657d19','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.324415',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.324415',490000,50,'a444a1a5-96fb-47fd-b67a-9f3db1d67105','be2198fb-f016-48b5-b324-58b32b725882'),
('22ab5ef8-e2cf-48aa-bfaa-54cd172b99fc','dotuandat2004nd@gmail.com','2025-04-04 11:53:39.742341',1,'dotuandat2004nd@gmail.com','2025-04-04 11:53:39.742341',800000,50,'f71f2e64-3edf-4994-8d2a-e21b81447c44','03001106-df33-4e43-a681-c40e9a60062e'),
('23bbeb27-3424-40fb-b9d1-97555e34c03b','dotuandat2004nd@gmail.com','2025-03-03 15:45:41.775744',1,'dotuandat2004nd@gmail.com','2025-03-03 15:45:41.775744',35000000,20,'fcaf6f68-f963-4dce-af8f-c524767834ea','e7747def-c7aa-4ab4-97a1-414f7c935659'),
('25ffe83b-c805-4c58-9cbd-94ac4123b35e','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.323397',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.323397',490000,50,'a444a1a5-96fb-47fd-b67a-9f3db1d67105','be2198fb-f016-48b5-b324-58b32b725882'),
('2672e100-23b8-4ca1-bf9c-a95ba912399e','dotuandat2004nd@gmail.com','2025-04-04 11:53:39.741347',1,'dotuandat2004nd@gmail.com','2025-04-04 11:53:39.741347',1600000,50,'6dfeb536-6fbf-4cd3-afbc-c14626917c80','03001106-df33-4e43-a681-c40e9a60062e'),
('276f5dfc-9b59-4e6a-8c0b-516c786b250a','dotuandat2004nd@gmail.com','2025-03-10 17:28:20.090698',1,'dotuandat2004nd@gmail.com','2025-03-10 17:28:20.090698',1000,1,'4b18aa0a-ce30-4ccd-8fe6-e4217b97df71','d72c2816-d523-4527-8628-295919f9cb63'),
('28f7ea42-2653-4323-978b-bea258f0f0d7','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.400721',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.400721',250000,50,'5642f7cf-1a10-430b-ace8-b491918064b9','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('291116e6-6190-4161-a656-0cb82196830d','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.400721',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.400721',890000,50,'e4557f80-4dcc-4857-9f88-1dcf63544ede','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('291c4f60-cbd8-49de-99b0-a4d49936c569','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.323397',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.323397',290000,50,'260bc683-3527-4bcd-9ce9-d614f347fd0f','be2198fb-f016-48b5-b324-58b32b725882'),
('2949d540-8d9e-4807-b1ea-45cdc977cfa1','dotuandat2004nd@gmail.com','2025-03-05 21:40:07.295197',1,'dotuandat2004nd@gmail.com','2025-03-05 21:40:07.295197',2490000,60,'16f1cf00-9b54-49df-b0a8-9935877ecad9','06b03f7c-2b25-4a4b-934a-96f5c29e2736'),
('2cc38516-7883-4846-98cd-777f16afb16d','dotuandat2004nd@gmail.com','2025-03-03 15:45:41.775744',1,'dotuandat2004nd@gmail.com','2025-03-03 15:45:41.775744',36900000,20,'f75b73a8-353b-4412-8e85-040e376e94e5','e7747def-c7aa-4ab4-97a1-414f7c935659'),
('2cf7dd2d-ba19-499d-9b89-28a5deeaaceb','dotuandat2004nd@gmail.com','2025-02-23 14:32:10.122133',1,'dotuandat2004nd@gmail.com','2025-02-23 14:32:10.122133',15000000,20,'53622008-8cea-4304-a861-2e32869c0c45','ebc4e1cf-9331-4407-97e7-fb9d19bf41c8'),
('2da0bfc6-7719-4139-ad7d-72629ad987f1','admin@gmail.com','2025-03-11 09:14:20.752750',1,'admin@gmail.com','2025-03-11 09:14:20.752750',1390000,100,'0ebf1a90-739d-49af-bf50-023441bbb245','6fc0e39f-565d-44f9-99d4-84df16559f27'),
('2e106798-1985-4bb4-a889-1e7fd0d4b9f7','admin@gmail.com','2025-03-12 23:31:19.333244',1,'admin@gmail.com','2025-03-12 23:31:19.333244',5290000,70,'ab93e3b9-2e84-4dfb-8e9e-2b907505143e','0d971c5b-47f3-442b-a8d8-b5203f5ddff2'),
('2ef83c62-41a7-417f-91c1-4013e4492c0a','admin@gmail.com','2025-03-11 09:14:20.750453',1,'admin@gmail.com','2025-03-11 09:14:20.750453',8090000,100,'807b3a15-5c2c-4fe6-be2a-a3056d8e42cd','6fc0e39f-565d-44f9-99d4-84df16559f27'),
('2f395712-87fc-4e4f-b21e-787ae941e71b','pesmobile5404@gmail.com','2025-03-10 17:37:26.496299',1,'pesmobile5404@gmail.com','2025-03-10 17:37:26.496299',1000,100,'bd26bd43-71b8-427e-852f-bfb95e4066f1','fc124bfc-aff6-488e-b2f5-cbde4eaeabd4'),
('2f98dd45-3422-4d88-9e5b-55886e6a4030','dotuandat2004nd@gmail.com','2025-03-12 01:05:02.458292',1,'dotuandat2004nd@gmail.com','2025-03-12 01:05:02.458292',20990000,30,'af3a0e21-1a61-46a0-82b7-cf4697249c07','512eff7d-e023-452d-97b8-dfd8e37389da'),
('3079b636-88b6-41ca-9cc6-36575590c34f','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.326408',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.326408',250000,50,'5642f7cf-1a10-430b-ace8-b491918064b9','be2198fb-f016-48b5-b324-58b32b725882'),
('3094d169-be66-4934-a61e-77f72196bfad','dotuandat2004nd@gmail.com','2025-04-04 11:53:39.742341',1,'dotuandat2004nd@gmail.com','2025-04-04 11:53:39.742341',5400000,50,'559a3f11-a62d-4615-9a48-4f2db168cac8','03001106-df33-4e43-a681-c40e9a60062e'),
('30f1a08e-64ec-45ef-8c91-a6d433157518','dotuandat2004nd@gmail.com','2025-04-04 11:53:39.742341',1,'dotuandat2004nd@gmail.com','2025-04-04 11:53:39.742341',2600000,50,'2cf69fe3-a41b-4964-ba98-a122cca81a9d','03001106-df33-4e43-a681-c40e9a60062e'),
('33256a9f-b631-4472-8e36-98f52ad54124','admin@gmail.com','2025-03-11 09:10:02.541052',1,'admin@gmail.com','2025-03-11 09:10:02.541052',2890000,100,'4f80115f-9d53-4e40-b4d8-e363aff005bd','2613ed26-3981-46f4-9ddb-a9702cc5e8d5'),
('3392c0a2-2bdc-4eb4-b01b-9c07d1877cb3','dotuandat2004nd@gmail.com','2025-03-16 19:03:11.617182',1,'dotuandat2004nd@gmail.com','2025-03-16 19:03:11.617182',27990000,100,'eadecf1a-53dd-4460-a0ed-4d175a2b000a','523e1850-7467-48b9-9457-02b4427210df'),
('340fd0f8-3385-4dfe-8754-763bc1476b44','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.399383',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.399383',1790000,50,'9a0aae00-5dfa-4c86-8f85-4f62faeec6cf','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('3539e77f-a194-4a8a-8622-5f6afc6d2af6','dotuandat2004nd@gmail.com','2025-03-16 19:03:11.615180',1,'dotuandat2004nd@gmail.com','2025-03-16 19:03:11.615180',23990000,100,'e464bb21-5c91-43de-a392-1f75c5446bb0','523e1850-7467-48b9-9457-02b4427210df'),
('3620c767-d84a-46e4-9a5a-564359aec0ff','dotuandat2004nd@gmail.com','2025-03-10 17:28:20.091240',1,'dotuandat2004nd@gmail.com','2025-03-10 17:28:20.091240',1000,1,'a16d1150-402d-45c4-8915-3e7e602511f6','d72c2816-d523-4527-8628-295919f9cb63'),
('3658022c-4869-411e-bc21-1cf866ef27f6','dotuandat2004nd@gmail.com','2025-02-23 15:38:17.122903',1,'dotuandat2004nd@gmail.com','2025-02-23 15:38:17.122903',20000000,60,'5e2a4f52-906c-4cf8-9ec4-a559524e0879','42f5635e-8f51-485a-940b-d0b3afbddc4e'),
('3672916e-d081-4603-9d35-005d2539e944','pesmobile5404@gmail.com','2025-03-10 17:51:50.884166',1,'pesmobile5404@gmail.com','2025-03-10 17:51:50.884166',100000,1,'34e6cde9-3e81-4237-b426-366c9f5aca04','d9051ce0-f139-4d63-9f62-e555992045cd'),
('38307388-f6c8-4633-a36e-c5102737082a','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.398390',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.398390',2390000,50,'350925fb-f69f-41e2-aa90-548c57a40f89','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('38d65aef-9d2b-416b-9ee8-c93dd4b17f87','dotuandat2004nd@gmail.com','2025-03-10 15:41:40.777941',1,'dotuandat2004nd@gmail.com','2025-03-10 15:41:40.777941',3090000,100,'8f418ffb-2f47-478b-8262-deb06702f20b','bdcc2d5c-b204-40a3-b20f-284d8f2ea6f1'),
('390791a9-239a-452e-9b61-4ea0aa06ab2f','dotuandat2004nd@gmail.com','2025-03-12 00:38:33.470331',1,'dotuandat2004nd@gmail.com','2025-03-12 00:38:33.470331',15990000,70,'f53fb25d-f92d-4628-bd09-513cc3d90273','6c59315f-836c-4434-970a-5c6e9cd9af44'),
('396b88f4-0407-48ee-9c23-26c78dd7d89c','dotuandat2004nd@gmail.com','2025-03-10 17:23:15.288309',1,'dotuandat2004nd@gmail.com','2025-03-10 17:23:15.288309',8090000,50,'1a33f67d-7bda-422e-be33-9d5c2a3c600a','a3ad1e70-a248-413b-8af1-86219b3a1c02'),
('39b7e223-7744-4ec8-b824-c5e6fe6c054f','dotuandat2004nd@gmail.com','2025-04-04 11:53:39.743347',1,'dotuandat2004nd@gmail.com','2025-04-04 11:53:39.743347',6000000,50,'1d9912ea-00bb-4b0e-beae-a702a8b5f4ed','03001106-df33-4e43-a681-c40e9a60062e'),
('3ab5f6ff-0577-484a-af10-94154a6c887b','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.400721',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.400721',1790000,50,'9a0aae00-5dfa-4c86-8f85-4f62faeec6cf','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('3adeed2b-ee34-48b7-8622-985e771548d3','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.325410',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.325410',490000,50,'a444a1a5-96fb-47fd-b67a-9f3db1d67105','be2198fb-f016-48b5-b324-58b32b725882'),
('3de40faf-a15b-42d5-9570-b3fee921ab04','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.322196',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.322196',2690000,50,'bd0e6c67-f0c8-4848-8cf0-83a0d0194b77','be2198fb-f016-48b5-b324-58b32b725882'),
('3e8c5089-ab4c-422d-a1a5-101e531e92fd','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.323397',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.323397',590000,50,'b9dc0806-4e27-4cde-86da-ce5eda3ab7b5','be2198fb-f016-48b5-b324-58b32b725882'),
('3f3e3ac4-d117-4dfe-860c-06769bc01bec','dotuandat2004nd@gmail.com','2025-04-04 11:53:39.742341',1,'dotuandat2004nd@gmail.com','2025-04-04 11:53:39.742341',2500000,50,'13fda409-9408-4831-ae22-f74e0775f80d','03001106-df33-4e43-a681-c40e9a60062e'),
('3f727497-3f4d-4e87-8fce-bffdbc9056e0','admin@gmail.com','2025-03-11 09:10:02.540045',1,'admin@gmail.com','2025-03-11 09:10:02.540045',2090000,100,'7bb03083-df68-4336-ae50-5e8d26d5f689','2613ed26-3981-46f4-9ddb-a9702cc5e8d5'),
('406641ad-f607-42e3-a5d7-82e5e0a3bae4','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.322196',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.322196',1790000,50,'9a0aae00-5dfa-4c86-8f85-4f62faeec6cf','be2198fb-f016-48b5-b324-58b32b725882'),
('418e9d48-2560-495c-b84b-e8419974a75a','dotuandat2004nd@gmail.com','2025-03-12 00:38:33.470331',1,'dotuandat2004nd@gmail.com','2025-03-12 00:38:33.470331',7490000,70,'6beb1cca-0011-4142-9dad-10c12e24c3a6','6c59315f-836c-4434-970a-5c6e9cd9af44'),
('41958709-a516-44e7-9e24-9f53a80e3ca6','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.325410',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.325410',790000,50,'c873e3c6-4459-4134-9ea8-a5163db96242','be2198fb-f016-48b5-b324-58b32b725882'),
('47f37a38-0972-4117-80b8-547b285b6989','dotuandat2004nd@gmail.com','2025-03-23 19:29:43.665680',1,'dotuandat2004nd@gmail.com','2025-03-23 19:29:43.665680',3890000,50,'fcaf6f68-f963-4dce-af8f-c524767834ea','08814390-d044-43ee-a8fe-2ca385f682d1'),
('484df3ab-c4ec-4cd3-b528-ae28cda3612e','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.398390',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.398390',1790000,50,'9a0aae00-5dfa-4c86-8f85-4f62faeec6cf','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('48935336-74f1-48d2-99bd-50c3d05ec91b','dotuandat2004nd@gmail.com','2025-02-23 15:28:33.394081',1,'dotuandat2004nd@gmail.com','2025-02-23 15:28:33.394081',20000000,20,'349c97b3-d00f-4afd-ab38-899e3b1bd15b','395c2954-bfe8-4fbe-a05e-ddf2c6b9de3e'),
('48fc4a8c-0c7b-41d0-9d9f-74a165bcd90d','dotuandat2004nd@gmail.com','2025-03-24 10:43:45.431274',1,'dotuandat2004nd@gmail.com','2025-03-24 10:43:45.431274',800000,50,'80272589-b7c3-40f8-9a18-11dfaf34cf83','a060c6ea-41f0-4b45-87e5-064bb54a5328'),
('49614d44-5726-4b59-a585-581ee347e965','admin@gmail.com','2025-03-12 23:31:19.334266',1,'admin@gmail.com','2025-03-12 23:31:19.334266',4690000,70,'5b786e42-97b0-4cd9-9234-9d77160ab555','0d971c5b-47f3-442b-a8d8-b5203f5ddff2'),
('4af725c4-2b14-43f8-a50f-dc9ea8630e81','dotuandat2004nd@gmail.com','2025-04-04 11:53:39.741347',1,'dotuandat2004nd@gmail.com','2025-04-04 11:53:39.741347',400000,50,'dba4d96f-f938-4f7b-84fe-bfb1ed385e94','03001106-df33-4e43-a681-c40e9a60062e'),
('4c8ab078-c47a-4afa-a20e-e0f43fd6b1e8','dotuandat2004nd@gmail.com','2025-03-24 10:43:45.435747',1,'dotuandat2004nd@gmail.com','2025-03-24 10:43:45.435747',1600000,50,'6dfeb536-6fbf-4cd3-afbc-c14626917c80','a060c6ea-41f0-4b45-87e5-064bb54a5328'),
('4d60db0c-e8e5-48a8-ada4-8f006cad3208','dotuandat2004nd@gmail.com','2025-03-23 19:29:43.665680',1,'dotuandat2004nd@gmail.com','2025-03-23 19:29:43.665680',28990000,50,'4f688179-ba15-4207-a3a9-bc00f5cb9b69','08814390-d044-43ee-a8fe-2ca385f682d1'),
('4e728f7f-a796-419e-b868-86e9b42f8468','dotuandat2004nd@gmail.com','2025-04-04 11:53:39.743347',1,'dotuandat2004nd@gmail.com','2025-04-04 11:53:39.743347',600000,50,'c3fe95e4-d90e-4eb6-90eb-684097c2e74d','03001106-df33-4e43-a681-c40e9a60062e'),
('4ed0f445-fc05-4fce-830a-df39ae4b8053','admin@gmail.com','2025-03-11 09:14:20.752750',1,'admin@gmail.com','2025-03-11 09:14:20.752750',21990000,100,'0cb1fccc-eb7b-4a58-8b4e-09d3dc1c7d4a','6fc0e39f-565d-44f9-99d4-84df16559f27'),
('50215266-39b1-4ee2-a965-99099d1ea550','dotuandat2004nd@gmail.com','2025-03-10 17:23:15.287671',1,'dotuandat2004nd@gmail.com','2025-03-10 17:23:15.287671',22990000,50,'22e8cfa1-10ec-43eb-831c-5722554bf637','a3ad1e70-a248-413b-8af1-86219b3a1c02'),
('5084cf06-2303-42c5-bf92-a24e64104341','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.399383',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.399383',2390000,50,'350925fb-f69f-41e2-aa90-548c57a40f89','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('50f79d7d-5b03-4c9b-a4d9-68ed0ea45963','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.396386',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.396386',450000,50,'b24e6918-da98-45ab-816d-4f7750420ca3','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('51dd7dcb-b77d-4850-9d51-e693d8fa90af','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.326408',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.326408',590000,50,'b9dc0806-4e27-4cde-86da-ce5eda3ab7b5','be2198fb-f016-48b5-b324-58b32b725882'),
('55088cd0-f01a-46ab-9618-e6321a342bdb','dotuandat2004nd@gmail.com','2025-04-04 11:53:39.742341',1,'dotuandat2004nd@gmail.com','2025-04-04 11:53:39.742341',900000,50,'5f6d2805-6f5b-4036-8f5b-17e5fbe1a504','03001106-df33-4e43-a681-c40e9a60062e'),
('5536bd74-50c3-43c0-b63d-c76d6c6eb7f1','dotuandat2004nd@gmail.com','2025-03-05 21:39:10.029296',1,'dotuandat2004nd@gmail.com','2025-03-05 21:39:10.029296',30990000,40,'bf125273-6496-45a4-8d19-18050fad5746','50db492a-679a-4a21-bad4-b1e45394bab2'),
('5629a831-4aef-40bc-9520-d11f5c68a030','dotuandat2004nd@gmail.com','2025-03-16 19:16:48.490679',1,'dotuandat2004nd@gmail.com','2025-03-16 19:16:48.490679',890000,20,'0e4353ac-d554-48cc-bee4-fa16af1552f7','0dcec000-e12e-4c14-a5a0-456daf28664a'),
('587ee362-4d61-424b-ae99-b2a08f2677bd','dotuandat2004nd@gmail.com','2025-03-05 21:39:10.030295',1,'dotuandat2004nd@gmail.com','2025-03-05 21:39:10.030295',22990000,40,'22e8cfa1-10ec-43eb-831c-5722554bf637','50db492a-679a-4a21-bad4-b1e45394bab2'),
('5920f10a-ce59-41af-ad4d-11a643b60114','admin@gmail.com','2025-03-12 01:35:57.921405',1,'admin@gmail.com','2025-03-12 01:35:57.921405',7590000,40,'1a71e553-885e-44bc-9927-648731ea0962','20665167-67d3-4fff-a198-94f11ce6ff64'),
('5aef9b56-a709-4f70-9bc2-cd0bf0100e96','dotuandat2004nd@gmail.com','2025-02-23 14:32:10.122133',1,'dotuandat2004nd@gmail.com','2025-02-23 14:32:10.122133',32000000,20,'387bf7c9-0173-4976-be07-f1ba43845092','ebc4e1cf-9331-4407-97e7-fb9d19bf41c8'),
('5bae4749-e9e9-4f9a-85f3-aaa211f9e5e5','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.400721',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.400721',490000,50,'a444a1a5-96fb-47fd-b67a-9f3db1d67105','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('5cde3e6a-0219-41f0-b913-91b2023285a7','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.322196',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.322196',590000,50,'b9dc0806-4e27-4cde-86da-ce5eda3ab7b5','be2198fb-f016-48b5-b324-58b32b725882'),
('5e011e9f-338f-4fe0-914e-cdb06d1f9e66','dotuandat2004nd@gmail.com','2025-03-10 17:30:11.163380',1,'dotuandat2004nd@gmail.com','2025-03-10 17:30:11.163380',10490000,50,'4b18aa0a-ce30-4ccd-8fe6-e4217b97df71','c2d7a358-14c3-4107-bac6-3eb564fa4b43'),
('5e374fe2-2514-416b-914f-58ff1b0f8d1a','pesmobile5404@gmail.com','2025-03-10 17:51:50.884166',1,'pesmobile5404@gmail.com','2025-03-10 17:51:50.884166',100000,1,'2c886de1-a3bd-4348-ad31-7d7001a060fd','d9051ce0-f139-4d63-9f62-e555992045cd'),
('5ee217c8-3880-40d5-be20-454e56978cbb','pesmobile5404@gmail.com','2025-03-10 17:51:50.884166',1,'pesmobile5404@gmail.com','2025-03-10 17:51:50.884166',100000,1,'184b7e9b-7caf-48fd-9bd2-e4c404f77c4e','d9051ce0-f139-4d63-9f62-e555992045cd'),
('61e3c636-0959-4b93-8fb8-41d4c255e7a4','dotuandat2004nd@gmail.com','2025-03-10 17:23:15.288309',1,'dotuandat2004nd@gmail.com','2025-03-10 17:23:15.288309',3490000,50,'b5e3fe75-5fd3-451a-bf1d-4a212d14fa8a','a3ad1e70-a248-413b-8af1-86219b3a1c02'),
('62058b09-d961-4edb-8a61-b61d1e2f0b2e','pesmobile5404@gmail.com','2025-02-28 21:00:38.185882',1,'pesmobile5404@gmail.com','2025-02-28 21:00:38.185882',0,1,'b35565b0-c07f-4313-9fff-6c942c57dd00','8e8114eb-0b7c-4068-9c09-94c19e742353'),
('62c18a82-2fd0-4a6e-87ff-890d00c03776','dotuandat2004nd@gmail.com','2025-03-24 10:43:45.436787',1,'dotuandat2004nd@gmail.com','2025-03-24 10:43:45.436787',450000,50,'28e0713e-e72a-4665-b102-2671f8087a63','a060c6ea-41f0-4b45-87e5-064bb54a5328'),
('65467847-3ccf-4ca2-8b8f-77d542cd4abb','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.323397',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.323397',450000,50,'b24e6918-da98-45ab-816d-4f7750420ca3','be2198fb-f016-48b5-b324-58b32b725882'),
('6718d331-90e6-412d-942e-ae22d8779930','admin@gmail.com','2025-03-12 23:31:19.334266',1,'admin@gmail.com','2025-03-12 23:31:19.334266',17990000,70,'3e6b46aa-612d-4873-b8ac-d0041fe4e53b','0d971c5b-47f3-442b-a8d8-b5203f5ddff2'),
('69c48b80-6640-47c2-bba7-2c316f575c8c','pesmobile5404@gmail.com','2025-02-23 14:25:47.967821',1,'pesmobile5404@gmail.com','2025-02-23 14:25:47.967821',17000000,80,'0cb1fccc-eb7b-4a58-8b4e-09d3dc1c7d4a','45c43b45-2360-4ffa-87ad-16bebafa9e9b'),
('6a808ae8-bd7f-4b37-8c7a-8eaf3e070774','dotuandat2004nd@gmail.com','2025-03-24 10:43:45.437772',1,'dotuandat2004nd@gmail.com','2025-03-24 10:43:45.437772',900000,50,'5f6d2805-6f5b-4036-8f5b-17e5fbe1a504','a060c6ea-41f0-4b45-87e5-064bb54a5328'),
('6b024610-3a47-4fc4-8d7e-64e11d4fb5c7','dotuandat2004nd@gmail.com','2025-03-12 01:07:46.067829',1,'dotuandat2004nd@gmail.com','2025-03-12 01:07:46.067829',12990000,20,'148f186c-acc4-4f5d-b802-80e2a1aed04c','f012f7f4-a50a-44bd-88fb-2b162df6d28c'),
('6da1c6e6-080d-4734-976f-0b2113f4cec5','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.398390',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.398390',790000,50,'c873e3c6-4459-4134-9ea8-a5163db96242','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('727401ae-2824-4929-9261-d70b1fa2a2cf','dotuandat2004nd@gmail.com','2025-03-16 19:03:11.616181',1,'dotuandat2004nd@gmail.com','2025-03-16 19:03:11.616181',19990000,100,'349c97b3-d00f-4afd-ab38-899e3b1bd15b','523e1850-7467-48b9-9457-02b4427210df'),
('74261346-6e41-43ed-8dc0-7dcade4de621','admin@gmail.com','2025-03-11 09:14:20.749450',1,'admin@gmail.com','2025-03-11 09:14:20.749450',3690000,100,'bb530f69-9702-424d-bca2-fcfd89625c04','6fc0e39f-565d-44f9-99d4-84df16559f27'),
('74a080e1-aeab-4299-b016-bdd2face6fb7','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.398390',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.398390',450000,50,'b24e6918-da98-45ab-816d-4f7750420ca3','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('74cbbdd6-842d-4c1c-8da3-17529d117db4','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.322196',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.322196',890000,50,'e4557f80-4dcc-4857-9f88-1dcf63544ede','be2198fb-f016-48b5-b324-58b32b725882'),
('769fb279-8adf-4761-a33e-6cd99171b9fd','dotuandat2004nd@gmail.com','2025-03-10 17:30:11.163380',1,'dotuandat2004nd@gmail.com','2025-03-10 17:30:11.163380',22990000,50,'a16d1150-402d-45c4-8915-3e7e602511f6','c2d7a358-14c3-4107-bac6-3eb564fa4b43'),
('778ab780-43f2-4729-b9ec-be6b4f863c4f','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.322196',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.322196',250000,50,'5642f7cf-1a10-430b-ace8-b491918064b9','be2198fb-f016-48b5-b324-58b32b725882'),
('779bf3c9-fc34-4141-8332-9914f5ad43a5','dotuandat2004nd@gmail.com','2025-02-23 15:28:33.395610',1,'dotuandat2004nd@gmail.com','2025-02-23 15:28:33.395610',27000000,20,'5e2a4f52-906c-4cf8-9ec4-a559524e0879','395c2954-bfe8-4fbe-a05e-ddf2c6b9de3e'),
('77dfce3d-9ca5-48f4-ae40-94e871e65358','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.398390',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.398390',450000,50,'b24e6918-da98-45ab-816d-4f7750420ca3','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('78190b49-3413-433e-bab1-60e658edce3c','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.398390',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.398390',590000,50,'b9dc0806-4e27-4cde-86da-ce5eda3ab7b5','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('79233f62-acaf-4a05-88e3-8b7384417c33','dotuandat2004nd@gmail.com','2025-03-24 10:43:45.436787',1,'dotuandat2004nd@gmail.com','2025-03-24 10:43:45.436787',1000000,50,'135861c7-fba7-4b28-9a3d-fed2093d33ca','a060c6ea-41f0-4b45-87e5-064bb54a5328'),
('79518093-e748-4336-8c35-cdc03505c611','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.324415',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.324415',250000,50,'5642f7cf-1a10-430b-ace8-b491918064b9','be2198fb-f016-48b5-b324-58b32b725882'),
('799e3d61-5af7-4fe3-b430-1855df0d367a','dotuandat2004nd@gmail.com','2025-03-24 10:43:45.437772',1,'dotuandat2004nd@gmail.com','2025-03-24 10:43:45.437772',450000,50,'e9593383-23fa-41b6-a6e2-fff3cc4ffbb1','a060c6ea-41f0-4b45-87e5-064bb54a5328'),
('7b371139-656b-4f06-bc79-80b2f01690e9','dotuandat2004nd@gmail.com','2025-03-16 19:16:48.491679',1,'dotuandat2004nd@gmail.com','2025-03-16 19:16:48.491679',2490000,20,'6ac21426-8242-4345-b406-cf55e082a560','0dcec000-e12e-4c14-a5a0-456daf28664a'),
('7b8c46e2-84df-4785-b67e-176d3ef7490f','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.323397',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.323397',790000,50,'c873e3c6-4459-4134-9ea8-a5163db96242','be2198fb-f016-48b5-b324-58b32b725882'),
('7c450317-0bbe-4098-9f41-75ad088a5b9e','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.397386',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.397386',790000,50,'c873e3c6-4459-4134-9ea8-a5163db96242','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('7c65169a-f152-4c51-b247-523dde58254d','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.326408',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.326408',290000,50,'260bc683-3527-4bcd-9ce9-d614f347fd0f','be2198fb-f016-48b5-b324-58b32b725882'),
('7d7581be-a4e8-4d6b-8d6b-db9ab99e44a0','dotuandat2004nd@gmail.com','2025-03-24 10:43:45.435747',1,'dotuandat2004nd@gmail.com','2025-03-24 10:43:45.435747',400000,50,'dba4d96f-f938-4f7b-84fe-bfb1ed385e94','a060c6ea-41f0-4b45-87e5-064bb54a5328'),
('7eb01433-b25a-42f7-804b-5791d54ab501','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.398390',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.398390',490000,50,'a444a1a5-96fb-47fd-b67a-9f3db1d67105','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('7f4de4fa-3a46-4974-9bf0-f80ed077a445','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.324415',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.324415',450000,50,'b24e6918-da98-45ab-816d-4f7750420ca3','be2198fb-f016-48b5-b324-58b32b725882'),
('7fa5946b-e27b-4098-9c88-b5e11aeb9dee','admin@gmail.com','2025-03-11 09:10:02.541052',1,'admin@gmail.com','2025-03-11 09:10:02.541052',2090000,100,'ed919e14-5063-4b42-bcee-6c881db5d21c','2613ed26-3981-46f4-9ddb-a9702cc5e8d5'),
('81df68ca-d128-4f98-a8f6-81b08d602e20','dotuandat2004nd@gmail.com','2025-03-04 22:34:22.306124',1,'dotuandat2004nd@gmail.com','2025-03-04 22:34:22.306124',2090000,50,'ed919e14-5063-4b42-bcee-6c881db5d21c','c1fc8ce9-ac6f-44b5-a797-be02e16e84b7'),
('823359ed-78c4-4760-ba62-ee972aa9af40','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.399383',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.399383',790000,50,'c873e3c6-4459-4134-9ea8-a5163db96242','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('847159fe-6bf9-4a59-882a-db68d834d5f8','dotuandat2004nd@gmail.com','2025-03-12 01:07:46.067829',1,'dotuandat2004nd@gmail.com','2025-03-12 01:07:46.067829',54990000,20,'80b4f151-0089-4dd9-a239-5eb61d09bfb7','f012f7f4-a50a-44bd-88fb-2b162df6d28c'),
('85bbc305-7038-4160-8c43-54bdab4811d3','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.398390',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.398390',290000,50,'260bc683-3527-4bcd-9ce9-d614f347fd0f','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('86ce2990-e513-446f-a92f-71107c852484','pesmobile5404@gmail.com','2025-02-28 21:00:38.185882',1,'pesmobile5404@gmail.com','2025-02-28 21:00:38.185882',0,1,'af3a0e21-1a61-46a0-82b7-cf4697249c07','8e8114eb-0b7c-4068-9c09-94c19e742353'),
('8802efd2-b345-468f-8e27-f1ad6fd5e0a6','dotuandat2004nd@gmail.com','2025-03-10 15:41:40.777941',1,'dotuandat2004nd@gmail.com','2025-03-10 15:41:40.777941',12000000,100,'bffb2145-7ced-4094-9ed6-3631f7132bcf','bdcc2d5c-b204-40a3-b20f-284d8f2ea6f1'),
('8ab808f1-40ae-4dad-a442-e65031ff5337','pesmobile5404@gmail.com','2025-02-23 14:25:47.967821',1,'pesmobile5404@gmail.com','2025-02-23 14:25:47.967821',9000000,30,'04bb4b23-8316-45f5-8534-6766fbca71d1','45c43b45-2360-4ffa-87ad-16bebafa9e9b'),
('8ac65357-f6b5-47ce-b560-329454b5afbe','dotuandat2004nd@gmail.com','2025-02-23 15:38:17.122903',1,'dotuandat2004nd@gmail.com','2025-02-23 15:38:17.122903',25900000,60,'e464bb21-5c91-43de-a392-1f75c5446bb0','42f5635e-8f51-485a-940b-d0b3afbddc4e'),
('8ac6e8ec-bf28-48fb-a5bd-9b664cb30668','dotuandat2004nd@gmail.com','2025-03-16 19:16:48.489735',1,'dotuandat2004nd@gmail.com','2025-03-16 19:16:48.489735',16990000,20,'53622008-8cea-4304-a861-2e32869c0c45','0dcec000-e12e-4c14-a5a0-456daf28664a'),
('8b9d3b12-44a4-4a86-8ff2-f7b6aee00151','dotuandat2004nd@gmail.com','2025-03-24 12:46:39.660974',1,'dotuandat2004nd@gmail.com','2025-03-24 12:46:39.660974',1000,1,'ed919e14-5063-4b42-bcee-6c881db5d21c','5acb4348-3815-4c20-94ae-0cc5d71d366e'),
('8dca4ba0-d9f7-4709-8865-5556f8d09a64','admin@gmail.com','2025-03-12 23:31:19.334794',1,'admin@gmail.com','2025-03-12 23:31:19.334794',4090000,70,'f75b73a8-353b-4412-8e85-040e376e94e5','0d971c5b-47f3-442b-a8d8-b5203f5ddff2'),
('8ebdce66-d843-460f-8ae5-84fea0c04ae6','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.324415',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.324415',290000,50,'260bc683-3527-4bcd-9ce9-d614f347fd0f','be2198fb-f016-48b5-b324-58b32b725882'),
('92625417-6181-4b0f-9f0f-5d8e58284c0b','dotuandat2004nd@gmail.com','2025-03-24 10:43:45.435747',1,'dotuandat2004nd@gmail.com','2025-03-24 10:43:45.435747',6000000,50,'1d9912ea-00bb-4b0e-beae-a702a8b5f4ed','a060c6ea-41f0-4b45-87e5-064bb54a5328'),
('940f7623-23c4-4d0a-bcb0-f9338282a024','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.398390',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.398390',890000,50,'e4557f80-4dcc-4857-9f88-1dcf63544ede','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('9447dec4-e63c-4df0-b820-6a1027ec74a4','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.397386',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.397386',250000,50,'5642f7cf-1a10-430b-ace8-b491918064b9','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('9460f3c1-64eb-45b6-88b4-d17d330f4a31','admin@gmail.com','2025-03-11 09:14:20.753765',1,'admin@gmail.com','2025-03-11 09:14:20.753765',17990000,100,'53622008-8cea-4304-a861-2e32869c0c45','6fc0e39f-565d-44f9-99d4-84df16559f27'),
('947dd596-6128-4ed7-ae53-11b7962a53ff','dotuandat2004nd@gmail.com','2025-03-10 17:28:20.090127',1,'dotuandat2004nd@gmail.com','2025-03-10 17:28:20.090127',1000,1,'be924284-9e15-4ecd-873a-ce466aeb702f','d72c2816-d523-4527-8628-295919f9cb63'),
('9513e3e4-1278-4dbb-ba24-51cf7830468f','admin@gmail.com','2025-03-12 23:31:19.333244',1,'admin@gmail.com','2025-03-12 23:31:19.333244',10990000,70,'7257ecd7-5ae9-4d99-bb31-b0aa99617451','0d971c5b-47f3-442b-a8d8-b5203f5ddff2'),
('95e5f333-51aa-48cf-b516-7230f5ba0883','dotuandat2004nd@gmail.com','2025-03-16 19:03:11.618187',1,'dotuandat2004nd@gmail.com','2025-03-16 19:03:11.618187',17990000,100,'71ab414c-9228-430a-a356-523fefcf3691','523e1850-7467-48b9-9457-02b4427210df'),
('95f81aa0-a494-4f80-8e82-39fcf82cc7c2','dotuandat2004nd@gmail.com','2025-03-24 10:43:45.435747',1,'dotuandat2004nd@gmail.com','2025-03-24 10:43:45.435747',2500000,50,'13fda409-9408-4831-ae22-f74e0775f80d','a060c6ea-41f0-4b45-87e5-064bb54a5328'),
('96b11339-8d0f-46c5-b8d1-c62b30b515bf','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.324415',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.324415',1790000,50,'9a0aae00-5dfa-4c86-8f85-4f62faeec6cf','be2198fb-f016-48b5-b324-58b32b725882'),
('96ee0842-4514-41a7-bb77-2712cbc5caaa','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.323397',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.323397',2690000,50,'bd0e6c67-f0c8-4848-8cf0-83a0d0194b77','be2198fb-f016-48b5-b324-58b32b725882'),
('96f1c4d7-07b0-49d2-b3ad-c4355e9e780d','dotuandat2004nd@gmail.com','2025-04-04 11:53:39.742341',1,'dotuandat2004nd@gmail.com','2025-04-04 11:53:39.742341',450000,50,'e9593383-23fa-41b6-a6e2-fff3cc4ffbb1','03001106-df33-4e43-a681-c40e9a60062e'),
('97d91f7d-7d1f-4f70-8beb-a669921bdfa6','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.398390',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.398390',490000,50,'a444a1a5-96fb-47fd-b67a-9f3db1d67105','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('984db868-8242-4c60-816e-fd6bac0458ed','dotuandat2004nd@gmail.com','2025-03-24 12:46:39.659978',1,'dotuandat2004nd@gmail.com','2025-03-24 12:46:39.659978',1000,1,'fcaf6f68-f963-4dce-af8f-c524767834ea','5acb4348-3815-4c20-94ae-0cc5d71d366e'),
('9c136846-74c1-4454-adb8-d54f4b20e065','admin@gmail.com','2025-03-11 09:14:20.750453',1,'admin@gmail.com','2025-03-11 09:14:20.750453',5090000,100,'a8930bce-5e69-45b4-9653-a4f44e894c9d','6fc0e39f-565d-44f9-99d4-84df16559f27'),
('9cbbfe98-89e5-4823-b93b-dd793a13c39d','pesmobile5404@gmail.com','2025-02-23 14:25:03.475826',1,'pesmobile5404@gmail.com','2025-02-23 14:25:03.475826',15000000,20,'71ab414c-9228-430a-a356-523fefcf3691','5f67d4aa-e7b0-42e3-a6f8-59e5ae56c740'),
('9cd77acc-9ff9-4b8f-8960-9ff20d9059e0','dotuandat2004nd@gmail.com','2025-03-16 19:16:48.488730',1,'dotuandat2004nd@gmail.com','2025-03-16 19:16:48.488730',3390000,20,'734e4fe0-4074-4055-a713-f719c19f26e0','0dcec000-e12e-4c14-a5a0-456daf28664a'),
('9e636b91-b96c-4ce2-9320-425e650c26e2','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.399383',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.399383',250000,50,'5642f7cf-1a10-430b-ace8-b491918064b9','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('9f87a058-acbe-486d-a5fa-94d659350155','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.397386',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.397386',1790000,50,'9a0aae00-5dfa-4c86-8f85-4f62faeec6cf','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('a0728ead-7ff6-4066-944c-25737cf2af94','dotuandat2004nd@gmail.com','2025-03-24 10:43:45.435747',1,'dotuandat2004nd@gmail.com','2025-03-24 10:43:45.435747',350000,50,'1b30f875-77c5-4f3e-af60-cdb09a1e2861','a060c6ea-41f0-4b45-87e5-064bb54a5328'),
('a0a534ef-aabc-44eb-b157-69418200bdfb','dotuandat2004nd@gmail.com','2025-03-16 19:16:48.486684',1,'dotuandat2004nd@gmail.com','2025-03-16 19:16:48.486684',8390000,20,'807b3a15-5c2c-4fe6-be2a-a3056d8e42cd','0dcec000-e12e-4c14-a5a0-456daf28664a'),
('a0aba8d1-98e3-4c4e-afd0-e6810b1476df','dotuandat2004nd@gmail.com','2025-03-05 21:39:10.028292',1,'dotuandat2004nd@gmail.com','2025-03-05 21:39:10.028292',8190000,40,'1a33f67d-7bda-422e-be33-9d5c2a3c600a','50db492a-679a-4a21-bad4-b1e45394bab2'),
('a52f0a21-775d-4e46-874a-737ae98aa0cb','pesmobile5404@gmail.com','2025-02-28 21:00:38.186886',1,'pesmobile5404@gmail.com','2025-02-28 21:00:38.186886',0,1,'349c97b3-d00f-4afd-ab38-899e3b1bd15b','8e8114eb-0b7c-4068-9c09-94c19e742353'),
('a55918a9-6957-41dc-8ca0-ee85d692443f','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.397386',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.397386',890000,50,'e4557f80-4dcc-4857-9f88-1dcf63544ede','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('a5691efa-35a0-47b4-afdd-c94d8ab9bf70','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.322196',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.322196',290000,50,'260bc683-3527-4bcd-9ce9-d614f347fd0f','be2198fb-f016-48b5-b324-58b32b725882'),
('a897f988-3b6c-47d2-82a2-5f120f710d72','dotuandat2004nd@gmail.com','2025-04-04 11:53:39.740344',1,'dotuandat2004nd@gmail.com','2025-04-04 11:53:39.740344',800000,50,'80272589-b7c3-40f8-9a18-11dfaf34cf83','03001106-df33-4e43-a681-c40e9a60062e'),
('aa48f8dc-bb0f-4c3f-a6b4-96287da9223e','pesmobile5404@gmail.com','2025-02-23 14:25:47.967821',1,'pesmobile5404@gmail.com','2025-02-23 14:25:47.967821',25000000,10,'bd26bd43-71b8-427e-852f-bfb95e4066f1','45c43b45-2360-4ffa-87ad-16bebafa9e9b'),
('ab522e1d-770b-478d-9c34-fbb24ae91812','dotuandat2004nd@gmail.com','2025-03-10 15:41:40.776939',1,'dotuandat2004nd@gmail.com','2025-03-10 15:41:40.776939',8990000,100,'6b077250-e483-499f-95e3-01e183edd55d','bdcc2d5c-b204-40a3-b20f-284d8f2ea6f1'),
('ac2a3b45-54d6-4975-b8df-bac97a51085e','dotuandat2004nd@gmail.com','2025-03-16 19:16:48.490679',1,'dotuandat2004nd@gmail.com','2025-03-16 19:16:48.490679',1590000,20,'0ebf1a90-739d-49af-bf50-023441bbb245','0dcec000-e12e-4c14-a5a0-456daf28664a'),
('acdb8e6b-dd7c-4e1b-b739-4b45b2ac9644','dotuandat2004nd@gmail.com','2025-03-05 21:39:10.030295',1,'dotuandat2004nd@gmail.com','2025-03-05 21:39:10.030295',14990000,40,'439ba2b8-d61d-4e5e-ab1a-ff32f2c78fd8','50db492a-679a-4a21-bad4-b1e45394bab2'),
('adde9b73-23d6-4136-b838-a6fb901fd2c1','dotuandat2004nd@gmail.com','2025-03-23 19:29:43.664658',1,'dotuandat2004nd@gmail.com','2025-03-23 19:29:43.664658',1590000,50,'0ebf1a90-739d-49af-bf50-023441bbb245','08814390-d044-43ee-a8fe-2ca385f682d1'),
('aeb92f43-67a2-44cc-883a-2db687cd6bcd','dotuandat2004nd@gmail.com','2025-04-04 11:53:39.742341',1,'dotuandat2004nd@gmail.com','2025-04-04 11:53:39.742341',300000,50,'110c1813-8460-4067-9d0b-f0b8619c3dfa','03001106-df33-4e43-a681-c40e9a60062e'),
('afa763c9-3e1c-4662-baa5-6fcc1ad86be1','dotuandat2004nd@gmail.com','2025-03-16 19:16:48.488730',1,'dotuandat2004nd@gmail.com','2025-03-16 19:16:48.488730',19990000,20,'0cb1fccc-eb7b-4a58-8b4e-09d3dc1c7d4a','0dcec000-e12e-4c14-a5a0-456daf28664a'),
('afad706b-7b26-48d0-98e9-d8b7cd0ae2c8','admin@gmail.com','2025-03-11 09:14:20.753765',1,'admin@gmail.com','2025-03-11 09:14:20.753765',990000,100,'0e4353ac-d554-48cc-bee4-fa16af1552f7','6fc0e39f-565d-44f9-99d4-84df16559f27'),
('afbb1f81-e55b-4374-a060-0a916009a2bc','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.321089',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.321089',2390000,50,'350925fb-f69f-41e2-aa90-548c57a40f89','be2198fb-f016-48b5-b324-58b32b725882'),
('afbe48f9-e96a-478f-94ec-fb9f7b1fe334','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.399383',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.399383',2690000,50,'bd0e6c67-f0c8-4848-8cf0-83a0d0194b77','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('aff82f4e-c474-4d68-94ba-819378314c22','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.324415',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.324415',890000,50,'e4557f80-4dcc-4857-9f88-1dcf63544ede','be2198fb-f016-48b5-b324-58b32b725882'),
('b1b68517-ed85-4878-a068-facc44b3ba20','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.323397',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.323397',890000,50,'e4557f80-4dcc-4857-9f88-1dcf63544ede','be2198fb-f016-48b5-b324-58b32b725882'),
('b203e7e8-d734-4aaf-9e88-0a2e4fc9fb52','dotuandat2004nd@gmail.com','2025-03-24 10:43:45.437772',1,'dotuandat2004nd@gmail.com','2025-03-24 10:43:45.437772',200000,50,'92a24cce-e57a-4502-8a89-e0c9cdcc45ef','a060c6ea-41f0-4b45-87e5-064bb54a5328'),
('b38d44d9-7f9e-4eb9-b54b-b6afd77a0bfe','pesmobile5404@gmail.com','2025-03-10 17:37:26.497303',1,'pesmobile5404@gmail.com','2025-03-10 17:37:26.497303',1000,100,'e58f1305-8b66-449d-b56d-a4f8f207f9b3','fc124bfc-aff6-488e-b2f5-cbde4eaeabd4'),
('b46581ff-a766-4d0f-9301-5bd895532f31','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.324415',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.324415',2690000,50,'bd0e6c67-f0c8-4848-8cf0-83a0d0194b77','be2198fb-f016-48b5-b324-58b32b725882'),
('b8163e6f-7597-4cc7-9973-a9816502a134','dotuandat2004nd@gmail.com','2025-02-23 15:38:17.121180',1,'dotuandat2004nd@gmail.com','2025-02-23 15:38:17.121180',23000000,60,'349c97b3-d00f-4afd-ab38-899e3b1bd15b','42f5635e-8f51-485a-940b-d0b3afbddc4e'),
('b9124f6c-2641-40cc-87e8-5b7396f3417a','dotuandat2004nd@gmail.com','2025-02-23 14:32:10.122133',1,'dotuandat2004nd@gmail.com','2025-02-23 14:32:10.122133',8000000,20,'0e4353ac-d554-48cc-bee4-fa16af1552f7','ebc4e1cf-9331-4407-97e7-fb9d19bf41c8'),
('b96a1332-5801-40e5-891e-28100c323e61','dotuandat2004nd@gmail.com','2025-04-04 11:53:39.743347',1,'dotuandat2004nd@gmail.com','2025-04-04 11:53:39.743347',7500000,50,'06066a00-bf92-4e2b-8099-b834ca442e2c','03001106-df33-4e43-a681-c40e9a60062e'),
('bb2ed5ac-dd21-4749-b518-31adee0a5fc8','dotuandat2004nd@gmail.com','2025-03-23 19:29:43.664658',1,'dotuandat2004nd@gmail.com','2025-03-23 19:29:43.664658',10990000,50,'ed9ef5ce-5cb6-4672-8a87-0f112214098c','08814390-d044-43ee-a8fe-2ca385f682d1'),
('bcc4974a-9949-4535-9822-ae9cc37f5ced','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.324415',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.324415',790000,50,'c873e3c6-4459-4134-9ea8-a5163db96242','be2198fb-f016-48b5-b324-58b32b725882'),
('bce62e06-d29d-471f-80be-455112836d4a','admin@gmail.com','2025-03-12 01:35:57.921405',1,'admin@gmail.com','2025-03-12 01:35:57.921405',3890000,40,'b2b5d2e3-7f13-49ca-91da-7bd969f794b8','20665167-67d3-4fff-a198-94f11ce6ff64'),
('bd08bc7d-f46d-4380-82e1-56207c02f800','dotuandat2004nd@gmail.com','2025-04-04 11:53:39.741347',1,'dotuandat2004nd@gmail.com','2025-04-04 11:53:39.741347',450000,50,'28e0713e-e72a-4665-b102-2671f8087a63','03001106-df33-4e43-a681-c40e9a60062e'),
('bd5f178b-1c6d-4716-8684-c3917ae6e398','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.398390',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.398390',2690000,50,'bd0e6c67-f0c8-4848-8cf0-83a0d0194b77','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('be885381-9ba2-4a53-9a36-07dd5f2afa46','dotuandat2004nd@gmail.com','2025-03-10 17:30:11.163380',1,'dotuandat2004nd@gmail.com','2025-03-10 17:30:11.163380',15990000,50,'be924284-9e15-4ecd-873a-ce466aeb702f','c2d7a358-14c3-4107-bac6-3eb564fa4b43'),
('c204be93-068f-4329-8449-00b4d5fb597b','dotuandat2004nd@gmail.com','2025-04-04 11:53:39.742341',1,'dotuandat2004nd@gmail.com','2025-04-04 11:53:39.742341',1900000,50,'eee070b2-016f-4411-bd36-8eb4e07182e5','03001106-df33-4e43-a681-c40e9a60062e'),
('c206a903-2419-42b7-b4f4-afa19c2002af','dotuandat2004nd@gmail.com','2025-03-16 19:16:48.485699',1,'dotuandat2004nd@gmail.com','2025-03-16 19:16:48.485699',3090000,20,'387bf7c9-0173-4976-be07-f1ba43845092','0dcec000-e12e-4c14-a5a0-456daf28664a'),
('c24f50c1-7f31-4a9f-ae32-11ab60be099b','dotuandat2004nd@gmail.com','2025-04-04 11:53:39.742341',1,'dotuandat2004nd@gmail.com','2025-04-04 11:53:39.742341',1100000,50,'be9b7393-24af-4d4a-b1ee-de629043ba9a','03001106-df33-4e43-a681-c40e9a60062e'),
('c302c710-b47c-4775-a56c-8853a924fbf8','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.322196',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.322196',490000,50,'a444a1a5-96fb-47fd-b67a-9f3db1d67105','be2198fb-f016-48b5-b324-58b32b725882'),
('c344bbd7-cd40-4e3d-ba23-dbc5f1f7ad93','pesmobile5404@gmail.com','2025-02-28 21:00:38.185882',1,'pesmobile5404@gmail.com','2025-02-28 21:00:38.185882',0,1,'b413354a-d216-40cc-8cbf-2d34f0a34e1b','8e8114eb-0b7c-4068-9c09-94c19e742353'),
('c3510244-dc84-424f-a7c6-ef80aa260129','admin@gmail.com','2025-03-11 09:14:20.751450',1,'admin@gmail.com','2025-03-11 09:14:20.751450',3490000,100,'734e4fe0-4074-4055-a713-f719c19f26e0','6fc0e39f-565d-44f9-99d4-84df16559f27'),
('c39234fa-c007-40e5-b1a1-c98e2872f466','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.399383',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.399383',590000,50,'b9dc0806-4e27-4cde-86da-ce5eda3ab7b5','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('c3e143d9-1183-4034-9d02-95ba270191aa','dotuandat2004nd@gmail.com','2025-03-05 21:39:10.029296',1,'dotuandat2004nd@gmail.com','2025-03-05 21:39:10.029296',5990000,40,'db4f0c9a-f449-4792-a64e-c55963f5e23e','50db492a-679a-4a21-bad4-b1e45394bab2'),
('c56d24ec-fd02-4b5f-998d-771e01ccf06c','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.400721',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.400721',590000,50,'b9dc0806-4e27-4cde-86da-ce5eda3ab7b5','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('c5bfd212-b410-4b3c-bce7-8552ff6b7e3d','dotuandat2004nd@gmail.com','2025-03-10 17:23:15.287076',1,'dotuandat2004nd@gmail.com','2025-03-10 17:23:15.287076',14990000,50,'439ba2b8-d61d-4e5e-ab1a-ff32f2c78fd8','a3ad1e70-a248-413b-8af1-86219b3a1c02'),
('c655ea2a-2b13-45f1-80fc-b8be1a480d5f','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.325410',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.325410',450000,50,'b24e6918-da98-45ab-816d-4f7750420ca3','be2198fb-f016-48b5-b324-58b32b725882'),
('c8c3f775-96d1-44bb-a797-3565e0b6f30a','dotuandat2004nd@gmail.com','2025-03-24 10:43:45.436787',1,'dotuandat2004nd@gmail.com','2025-03-24 10:43:45.436787',6600000,50,'0cea1533-4a29-49b1-9671-1c804661ab67','a060c6ea-41f0-4b45-87e5-064bb54a5328'),
('c8fd8f21-da36-4a68-952b-74ac658c1059','pesmobile5404@gmail.com','2025-02-23 14:25:03.475826',1,'pesmobile5404@gmail.com','2025-02-23 14:25:03.475826',24000000,70,'5e2a4f52-906c-4cf8-9ec4-a559524e0879','5f67d4aa-e7b0-42e3-a6f8-59e5ae56c740'),
('c9e24453-3be2-4f04-8f64-eb52e9ac4909','dotuandat2004nd@gmail.com','2025-04-04 11:53:39.742341',1,'dotuandat2004nd@gmail.com','2025-04-04 11:53:39.742341',6600000,50,'0cea1533-4a29-49b1-9671-1c804661ab67','03001106-df33-4e43-a681-c40e9a60062e'),
('caf66d8e-1f7b-4e54-95e1-fe76d8a54d31','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.323397',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.323397',2390000,50,'350925fb-f69f-41e2-aa90-548c57a40f89','be2198fb-f016-48b5-b324-58b32b725882'),
('cb448f22-d515-419a-b74f-18a23ed84952','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.400721',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.400721',290000,50,'260bc683-3527-4bcd-9ce9-d614f347fd0f','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('cb9c170f-ef49-4a06-8122-3b160e016f38','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.322196',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.322196',2390000,50,'350925fb-f69f-41e2-aa90-548c57a40f89','be2198fb-f016-48b5-b324-58b32b725882'),
('ccded776-5aac-489c-a375-df55d0ba9588','dotuandat2004nd@gmail.com','2025-02-23 15:28:33.396125',1,'dotuandat2004nd@gmail.com','2025-02-23 15:28:33.396125',25900000,20,'eadecf1a-53dd-4460-a0ed-4d175a2b000a','395c2954-bfe8-4fbe-a05e-ddf2c6b9de3e'),
('cdabb686-56b3-4b0b-9372-df6121d50465','dotuandat2004nd@gmail.com','2025-03-24 10:43:45.437772',1,'dotuandat2004nd@gmail.com','2025-03-24 10:43:45.437772',800000,50,'f71f2e64-3edf-4994-8d2a-e21b81447c44','a060c6ea-41f0-4b45-87e5-064bb54a5328'),
('cdf6955a-99cb-4f97-b86d-3feaabc5d91d','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.321089',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.321089',2690000,50,'bd0e6c67-f0c8-4848-8cf0-83a0d0194b77','be2198fb-f016-48b5-b324-58b32b725882'),
('d01f84f1-9dc0-4849-8b73-cc32595e168d','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.400721',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.400721',450000,50,'b24e6918-da98-45ab-816d-4f7750420ca3','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('d05749f7-66f5-40c7-80ef-a95c1defc3b9','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.398390',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.398390',2690000,50,'bd0e6c67-f0c8-4848-8cf0-83a0d0194b77','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('d1f14d98-d825-4634-8f1e-974036221ff3','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.324415',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.324415',590000,50,'b9dc0806-4e27-4cde-86da-ce5eda3ab7b5','be2198fb-f016-48b5-b324-58b32b725882'),
('d285db86-84cd-4134-b1cd-60d785cf1872','admin@gmail.com','2025-03-12 01:35:57.920872',1,'admin@gmail.com','2025-03-12 01:35:57.920872',3290000,40,'cd38996d-e369-424f-bbb0-93c6ece6280a','20665167-67d3-4fff-a198-94f11ce6ff64'),
('d5ad1c31-3a59-419f-a56f-5ba4e9c3d692','dotuandat2004nd@gmail.com','2025-02-23 14:32:10.122133',1,'dotuandat2004nd@gmail.com','2025-02-23 14:32:10.122133',20000000,20,'0cb1fccc-eb7b-4a58-8b4e-09d3dc1c7d4a','ebc4e1cf-9331-4407-97e7-fb9d19bf41c8'),
('d614cc58-003b-43b7-9377-aa382fffea3e','dotuandat2004nd@gmail.com','2025-02-23 15:38:17.122903',1,'dotuandat2004nd@gmail.com','2025-02-23 15:38:17.122903',27000000,60,'71ab414c-9228-430a-a356-523fefcf3691','42f5635e-8f51-485a-940b-d0b3afbddc4e'),
('d86ce486-be60-4d99-8e37-90df7f4e0d98','dotuandat2004nd@gmail.com','2025-03-05 21:40:07.295795',1,'dotuandat2004nd@gmail.com','2025-03-05 21:40:07.295795',1590000,60,'e4369512-d437-4cf0-9bbd-c4e6fc7829fe','06b03f7c-2b25-4a4b-934a-96f5c29e2736'),
('d90791e1-7fc7-41d3-b207-3bea69157d73','dotuandat2004nd@gmail.com','2025-02-23 15:28:33.396125',1,'dotuandat2004nd@gmail.com','2025-02-23 15:28:33.396125',16000000,20,'71ab414c-9228-430a-a356-523fefcf3691','395c2954-bfe8-4fbe-a05e-ddf2c6b9de3e'),
('d9e7e636-dd30-4ae6-b0d2-f5441f495546','admin@gmail.com','2025-03-12 23:31:19.334266',1,'admin@gmail.com','2025-03-12 23:31:19.334266',1290000,70,'1ed493f3-53bc-46d3-b1b4-2d90be4f22fe','0d971c5b-47f3-442b-a8d8-b5203f5ddff2'),
('d9e8ef6b-2a4d-4e27-bfe0-8d52a200e62e','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.323397',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.323397',250000,50,'5642f7cf-1a10-430b-ace8-b491918064b9','be2198fb-f016-48b5-b324-58b32b725882'),
('d9f9e915-72f5-469a-ac6e-ceff43148495','dotuandat2004nd@gmail.com','2025-03-24 10:43:45.436787',1,'dotuandat2004nd@gmail.com','2025-03-24 10:43:45.436787',1100000,50,'be9b7393-24af-4d4a-b1ee-de629043ba9a','a060c6ea-41f0-4b45-87e5-064bb54a5328'),
('da01f885-702d-4a20-b879-9b2381aa1a0a','dotuandat2004nd@gmail.com','2025-03-03 15:45:41.774747',1,'dotuandat2004nd@gmail.com','2025-03-03 15:45:41.774747',35000000,20,'ff7a2db9-ade5-431b-96da-de04db3ba72a','e7747def-c7aa-4ab4-97a1-414f7c935659'),
('dc065323-fa11-4990-8b98-27be11767607','admin@gmail.com','2025-03-11 09:14:20.751450',1,'admin@gmail.com','2025-03-11 09:14:20.751450',2490000,100,'6ac21426-8242-4345-b406-cf55e082a560','6fc0e39f-565d-44f9-99d4-84df16559f27'),
('dcce9f29-b1b4-4798-92a4-c380787daed0','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.322196',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.322196',790000,50,'c873e3c6-4459-4134-9ea8-a5163db96242','be2198fb-f016-48b5-b324-58b32b725882'),
('defb25ac-aa4d-4f82-93bb-764465c14e1b','dotuandat2004nd@gmail.com','2025-03-05 21:39:10.026292',1,'dotuandat2004nd@gmail.com','2025-03-05 21:39:10.026292',3490000,40,'b5e3fe75-5fd3-451a-bf1d-4a212d14fa8a','50db492a-679a-4a21-bad4-b1e45394bab2'),
('df4f0e49-26a3-4a1e-a650-766d70bdc47a','dotuandat2004nd@gmail.com','2025-03-24 10:43:45.437772',1,'dotuandat2004nd@gmail.com','2025-03-24 10:43:45.437772',5400000,50,'559a3f11-a62d-4615-9a48-4f2db168cac8','a060c6ea-41f0-4b45-87e5-064bb54a5328'),
('e3443f3a-e470-4a0c-b60b-39981a1a1064','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.396386',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.396386',490000,50,'a444a1a5-96fb-47fd-b67a-9f3db1d67105','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('e52b1133-3fc4-4071-83b9-6144acf3500a','pesmobile5404@gmail.com','2025-02-23 14:24:26.905046',1,'pesmobile5404@gmail.com','2025-02-23 14:24:26.905046',5000,80,'0cb1fccc-eb7b-4a58-8b4e-09d3dc1c7d4a','b927eeb0-927e-4642-afac-7d384e6d9e2d'),
('e57bb256-8f37-4b7a-aa09-7897974d7029','pesmobile5404@gmail.com','2025-02-23 14:25:03.475826',1,'pesmobile5404@gmail.com','2025-02-23 14:25:03.475826',17000000,50,'349c97b3-d00f-4afd-ab38-899e3b1bd15b','5f67d4aa-e7b0-42e3-a6f8-59e5ae56c740'),
('ebb1f9c8-01e5-48d4-9613-2d3df4aba874','dotuandat2004nd@gmail.com','2025-03-12 01:05:02.456263',1,'dotuandat2004nd@gmail.com','2025-03-12 01:05:02.456263',10990000,30,'ed9ef5ce-5cb6-4672-8a87-0f112214098c','512eff7d-e023-452d-97b8-dfd8e37389da'),
('ed5c8b44-9937-498d-8ecd-a5461fb3ffbf','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.324415',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.324415',2390000,50,'350925fb-f69f-41e2-aa90-548c57a40f89','be2198fb-f016-48b5-b324-58b32b725882'),
('efe1c01a-ea05-44da-b558-56d97da8ddf2','dotuandat2004nd@gmail.com','2025-03-10 15:41:40.777941',1,'dotuandat2004nd@gmail.com','2025-03-10 15:41:40.777941',24990000,100,'9d03cf1b-094c-4a09-b74f-7491540500ed','bdcc2d5c-b204-40a3-b20f-284d8f2ea6f1'),
('f1201899-bf49-4ea8-800c-e8f81ab14712','dotuandat2004nd@gmail.com','2025-03-10 15:41:40.773934',1,'dotuandat2004nd@gmail.com','2025-03-10 15:41:40.773934',4000000,100,'1ba152b2-c6be-4760-85eb-2ac641181afe','bdcc2d5c-b204-40a3-b20f-284d8f2ea6f1'),
('f21e6305-bb32-4f1a-ac5c-33466a43723e','dotuandat2004nd@gmail.com','2025-03-10 17:23:15.288309',1,'dotuandat2004nd@gmail.com','2025-03-10 17:23:15.288309',30990000,50,'bf125273-6496-45a4-8d19-18050fad5746','a3ad1e70-a248-413b-8af1-86219b3a1c02'),
('f29ac84f-2d0a-4f4a-958f-18f7cc87bf05','dotuandat2004nd@gmail.com','2025-03-12 01:05:02.458292',1,'dotuandat2004nd@gmail.com','2025-03-12 01:05:02.458292',32990000,30,'4f688179-ba15-4207-a3a9-bc00f5cb9b69','512eff7d-e023-452d-97b8-dfd8e37389da'),
('f38d8097-c96f-4db2-956b-881ef0a3bd31','dotuandat2004nd@gmail.com','2025-03-24 10:43:45.436787',1,'dotuandat2004nd@gmail.com','2025-03-24 10:43:45.436787',300000,50,'110c1813-8460-4067-9d0b-f0b8619c3dfa','a060c6ea-41f0-4b45-87e5-064bb54a5328'),
('f60653e4-24bc-4ad7-a9c5-5ee2db9103e3','dotuandat2004nd@gmail.com','2025-03-24 10:43:45.435747',1,'dotuandat2004nd@gmail.com','2025-03-24 10:43:45.435747',7500000,50,'06066a00-bf92-4e2b-8099-b834ca442e2c','a060c6ea-41f0-4b45-87e5-064bb54a5328'),
('f642adf9-bbff-4a05-a5e4-7f9642b31c64','dotuandat2004nd@gmail.com','2025-04-04 11:53:39.742341',1,'dotuandat2004nd@gmail.com','2025-04-04 11:53:39.742341',350000,50,'1b30f875-77c5-4f3e-af60-cdb09a1e2861','03001106-df33-4e43-a681-c40e9a60062e'),
('f67cbf98-1098-469e-9137-022d693fd43f','dotuandat2004nd@gmail.com','2025-03-24 10:43:45.435747',1,'dotuandat2004nd@gmail.com','2025-03-24 10:43:45.435747',1900000,50,'eee070b2-016f-4411-bd36-8eb4e07182e5','a060c6ea-41f0-4b45-87e5-064bb54a5328'),
('f7ad855e-3d71-4633-80ca-81ece2f951dc','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.397386',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.397386',290000,50,'260bc683-3527-4bcd-9ce9-d614f347fd0f','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('fafc697f-76cf-490e-91be-edbc6d2a57ee','dotuandat2004nd@gmail.com','2025-03-10 15:41:40.783155',1,'dotuandat2004nd@gmail.com','2025-03-10 15:41:40.783155',3000000,100,'de81ab29-a374-4f13-9f91-57f0a1be3bf1','bdcc2d5c-b204-40a3-b20f-284d8f2ea6f1'),
('fbf889a8-7e12-4ac4-b249-f44d36d8a38f','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.323397',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.323397',1790000,50,'9a0aae00-5dfa-4c86-8f85-4f62faeec6cf','be2198fb-f016-48b5-b324-58b32b725882'),
('fc1c8ae7-f9ce-4708-bf0c-e439595eb00d','dotuandat2004nd@gmail.com','2025-03-24 10:29:27.325410',1,'dotuandat2004nd@gmail.com','2025-03-24 10:29:27.325410',890000,50,'e4557f80-4dcc-4857-9f88-1dcf63544ede','be2198fb-f016-48b5-b324-58b32b725882'),
('fc92e29f-947e-405e-b1af-7ace8928966b','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.398390',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.398390',250000,50,'5642f7cf-1a10-430b-ace8-b491918064b9','0e149c35-b9e4-4af1-ba4d-b7285111ffc6'),
('fef1c0ec-270c-47fe-855e-2b6109c1b9e0','dotuandat2004nd@gmail.com','2025-03-10 17:28:20.091240',1,'dotuandat2004nd@gmail.com','2025-03-10 17:28:20.091240',10000000,100,'4ae28144-f22b-4708-b9c8-5c98028e09e1','d72c2816-d523-4527-8628-295919f9cb63'),
('fef9ee7c-3321-4d11-9cac-9bdb05279277','dotuandat2004nd@gmail.com','2025-03-24 10:31:06.400721',1,'dotuandat2004nd@gmail.com','2025-03-24 10:31:06.400721',790000,50,'c873e3c6-4459-4134-9ea8-a5163db96242','0e149c35-b9e4-4af1-ba4d-b7285111ffc6');
/*!40000 ALTER TABLE `inventory_receipt_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `id` varchar(36) NOT NULL,
  `createdby` varchar(255) DEFAULT NULL,
  `createddate` datetime(6) DEFAULT NULL,
  `is_active` tinyint NOT NULL,
  `modifiedby` varchar(255) DEFAULT NULL,
  `modifieddate` datetime(6) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `order_type` enum('OFFLINE','ONLINE') NOT NULL,
  `payment_method` enum('CASH','COD','E_WALLET') DEFAULT NULL,
  `status` enum('CANCELLED','COMPLETED','CONFIRMED','FAILED','PENDING','SHIPPING') NOT NULL,
  `total_price` bigint NOT NULL,
  `address_id` varchar(36) DEFAULT NULL,
  `user_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK145gxdq9etc0fv3a0vutmkbye` (`address_id`),
  KEY `FKrcaf946w0bh6qj0ljiw3pwpnu` (`user_id`),
  CONSTRAINT `FK145gxdq9etc0fv3a0vutmkbye` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`),
  CONSTRAINT `FKrcaf946w0bh6qj0ljiw3pwpnu` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES ('01c7e22d-fc4e-41de-9e1a-839b9f37eb40','anonymousUser','2025-03-24 09:31:28.918503',1,'dotuandat2004nd@gmail.com','2025-03-24 09:39:16.153026',NULL,'ONLINE','E_WALLET','COMPLETED',4784250,'4e598437-7468-49f0-a714-d48b5e9d582b','afff85d7-53e8-40f9-9271-440bde54b151'),
('021d184b-db35-4542-a8d1-292debeb2b34','anonymousUser','2025-03-07 13:55:28.289927',1,'huy90@gmail.com','2025-03-07 13:57:18.026567',NULL,'ONLINE','COD','CANCELLED',1999200000,'eb8b8775-6512-48ee-bc7b-ccb199290aeb','2172f496-dfaf-4450-9148-f3fecc0a40f8'),
('05f12696-9528-4431-951e-11bb3f74ce2c','anonymousUser','2025-03-06 17:23:27.085671',1,'dotuandat2004nd@gmail.com','2025-03-16 00:12:30.969851','Giao ngoài giờ hành chính','ONLINE','COD','COMPLETED',3032000,'0d7a65d4-17f6-406a-9584-ed1520686897','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('0607b94f-8561-484f-a8ae-ea0cdb846308','anonymousUser','2025-03-15 10:10:16.557743',1,'dotuandat2004nd@gmail.com','2025-03-16 00:08:38.302329',NULL,'ONLINE','E_WALLET','COMPLETED',19415750,'a387501c-a3fc-4993-91dd-01ed8ded5afe','cfdae048-449a-4e64-aabc-1422eb3c0f2b'),
('06f7a494-3f96-463d-8c4f-d324e18aed4f','anonymousUser','2025-03-07 15:26:28.666334',1,'dotuandat2004nd@gmail.com','2025-03-08 18:30:06.034924',NULL,'ONLINE','COD','COMPLETED',26392000,'fe8ae9a7-ff9e-4eb8-bd3f-b934e119c5a2','024317a8-9e55-419d-bb9e-ed4cb104d020'),
('07ca77b8-e32a-462f-a97a-424b88b695c0','anonymousUser','2025-03-04 22:03:20.824009',1,'dotuandat2004nd@gmail.com','2025-03-08 22:40:25.331169',NULL,'ONLINE','COD','CANCELLED',113968000,'1fad1d40-f249-41e4-8f5b-6f7e16633596','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('0ac21b13-b92f-4beb-9546-b9e564dee328','anonymousUser','2025-03-25 19:15:50.498380',1,'admin@gmail.com','2025-03-25 19:17:11.539887',NULL,'OFFLINE','E_WALLET','COMPLETED',11891500,NULL,'c68506d2-7c97-4f6e-b51a-826f467dbd4e'),
('0d1d4739-45f4-488a-8fd8-994e08fede5f','anonymousUser','2025-03-12 01:30:32.701379',1,'dotuandat2004nd@gmail.com','2025-03-16 00:12:55.059681',NULL,'ONLINE','COD','COMPLETED',20340750,'1edad4b3-e040-4822-86cb-6f5d8aa418f8','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('1016c793-ca2c-44e8-8f68-7819a27b96b1','anonymousUser','2025-03-07 15:24:41.937661',1,'dotuandat2004nd@gmail.com','2025-03-08 22:40:12.716055',NULL,'ONLINE','COD','CANCELLED',19992000,'a8a681d2-784d-4b2a-a721-7530ddcb1f93','024317a8-9e55-419d-bb9e-ed4cb104d020'),
('12c02487-4e93-4f8c-8f1a-50717dcc7048','anonymousUser','2025-03-07 15:22:50.241523',1,'dotuandat2004nd@gmail.com','2025-03-08 18:29:54.059895',NULL,'ONLINE','COD','COMPLETED',19992000,'a8a681d2-784d-4b2a-a721-7530ddcb1f93','024317a8-9e55-419d-bb9e-ed4cb104d020'),
('153d727b-ac41-4b81-8ae3-9eea1db10320','anonymousUser','2025-03-25 19:08:50.807292',1,'admin@gmail.com','2025-03-25 19:20:39.308626','abc','OFFLINE','CASH','COMPLETED',13852750,NULL,'c68506d2-7c97-4f6e-b51a-826f467dbd4e'),
('1b22190c-8523-4671-8045-d6b667b5dc40','anonymousUser','2025-03-12 20:43:24.387782',1,'dotuandat2004nd@gmail.com','2025-03-12 20:44:08.546394',NULL,'ONLINE','E_WALLET','COMPLETED',3592000,'2d2a1d37-951f-4e3a-8b44-67c82b825339','d0abf087-be2a-4a40-b002-bfff337c026f'),
('1e63dbb3-d3b6-4358-900f-632563ad95c7','anonymousUser','2025-03-07 15:31:33.180579',1,'dotuandat2004nd@gmail.com','2025-03-08 17:21:41.558278',NULL,'ONLINE','COD','CANCELLED',26000000,'995a1bdf-e09f-4c79-8e5a-e50653fe1580','024317a8-9e55-419d-bb9e-ed4cb104d020'),
('20cf20a7-8067-4e21-9011-e21e2efd3124','anonymousUser','2025-03-07 13:58:50.033451',1,'dotuandat2004nd@gmail.com','2025-03-07 13:59:32.041092',NULL,'ONLINE','COD','COMPLETED',16792000,'0d7a65d4-17f6-406a-9584-ed1520686897','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('23872424-6493-4e66-91b8-3044778d31fc','anonymousUser','2025-04-04 16:29:10.560948',1,'anonymousUser','2025-04-04 16:29:10.560948',NULL,'ONLINE','COD','PENDING',50469000,'e4bd3a74-2d34-4d46-be40-103f633dd476','c68506d2-7c97-4f6e-b51a-826f467dbd4e'),
('23bc7c49-87f0-404d-a5b2-4c7487c54728','anonymousUser','2025-03-09 19:52:37.416651',1,'dotuandat2004nd@gmail.com','2025-03-16 00:11:54.986896',NULL,'ONLINE','E_WALLET','COMPLETED',26000000,'0d7a65d4-17f6-406a-9584-ed1520686897','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('24c323af-7ef6-42e1-9129-321fe4d52c4f','anonymousUser','2025-03-03 20:23:06.914426',1,'admin@gmail.com','2025-03-04 14:02:54.799936',NULL,'OFFLINE','E_WALLET','CANCELLED',28780000,'0d7a65d4-17f6-406a-9584-ed1520686897','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('257b8e94-106e-444e-b42a-21372b173a12','anonymousUser','2025-03-04 22:02:05.564173',1,'dotuandat2004nd@gmail.com','2025-03-16 00:12:59.713320',NULL,'ONLINE','COD','COMPLETED',72776000,'7d3cb495-12b6-4028-a718-1311ca69c611','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('2858c7ae-96dd-40b2-961f-d76d11558239','anonymousUser','2025-03-25 19:08:52.233662',1,'admin@gmail.com','2025-03-25 19:19:48.638870','abc','OFFLINE','CASH','COMPLETED',13852750,NULL,'c68506d2-7c97-4f6e-b51a-826f467dbd4e'),
('29e0ae88-dd5b-4e74-8163-6a9bfaa8beea','anonymousUser','2025-03-09 19:37:40.417276',1,'dotuandat2004nd@gmail.com','2025-03-16 00:12:02.654754',NULL,'ONLINE','COD','COMPLETED',36536000,'7d3cb495-12b6-4028-a718-1311ca69c611','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('2aea30eb-324b-427c-b73f-3bf1c1bd5418','anonymousUser','2025-03-25 19:16:38.294171',1,'admin@gmail.com','2025-03-25 19:17:01.876860',NULL,'OFFLINE','CASH','COMPLETED',13591500,NULL,'1ffca06b-0ee6-45ff-8d52-dbdba8440c75'),
('2dbcad88-fedd-409b-a8a0-ce8e02315373','anonymousUser','2025-03-04 21:52:21.150542',1,'dotuandat2004nd@gmail.com','2025-03-16 00:13:09.344949',NULL,'ONLINE','COD','COMPLETED',3032000,'7d3cb495-12b6-4028-a718-1311ca69c611','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('2df09e5a-78b9-47ed-849e-81312d0e9b1d','anonymousUser','2025-03-04 22:16:38.510558',1,'dotuandat2004nd@gmail.com','2025-03-05 20:38:15.937688',NULL,'ONLINE','COD','COMPLETED',11932500,'ea23d399-2f70-4d89-b85b-a5a983da6894','8491c9bb-e3a3-4436-abd8-c3d74216d422'),
('2dfcf01d-44bf-483b-b750-531d427e7820','anonymousUser','2025-03-06 17:44:40.314342',1,'dotuandat2004nd@gmail.com','2025-03-08 23:44:56.974247',NULL,'ONLINE','COD','CANCELLED',21520000,'0d7a65d4-17f6-406a-9584-ed1520686897','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('3022bac5-837f-4c04-83db-9577ce92071d','anonymousUser','2025-03-10 22:14:37.451984',1,'admin@gmail.com','2025-03-11 18:14:14.053446',NULL,'ONLINE','E_WALLET','CANCELLED',20609000,'468b1d1c-e91a-40fa-9fd4-bce8f2600012','a7ddd32e-f737-4ff4-af59-18144fc9a432'),
('319b11c3-d290-492d-b99d-e5ce67e37fa4','anonymousUser','2025-03-08 02:08:52.620017',1,'dotuandat2004nd@gmail.com','2025-03-08 02:09:04.858334',NULL,'ONLINE','COD','COMPLETED',1193250,'0d7a65d4-17f6-406a-9584-ed1520686897','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('3207eaf8-1a44-489b-8194-551354cef121','anonymousUser','2025-03-03 17:12:01.454508',1,'admin@gmail.com','2025-03-04 14:08:47.785322',NULL,'OFFLINE','COD','COMPLETED',250000000,'48d6ff76-96d1-4252-80e2-52d1c6137d36','d435d2b6-34f2-4226-85d4-1149f12c4761'),
('3235056a-dbe6-4176-8d87-0aff005d2c58','anonymousUser','2025-03-25 13:54:09.123722',1,'admin@gmail.com','2025-03-25 19:21:17.986661',NULL,'ONLINE','E_WALLET','COMPLETED',8082000,'1f7cbc7f-9ef3-478e-a85d-578088909de8','a7ddd32e-f737-4ff4-af59-18144fc9a432'),
('324e039f-5a61-44dc-8771-2bba0b366854','anonymousUser','2025-03-09 15:29:14.964241',1,'dotuandat2004nd@gmail.com','2025-03-09 15:35:34.054816',NULL,'ONLINE','COD','COMPLETED',16792000,'7fa49ed3-3939-40ba-86f7-1e0e978bc43e','d0abf087-be2a-4a40-b002-bfff337c026f'),
('339ac8c4-d5f6-42ea-b389-5429ea474ce4','anonymousUser','2025-03-12 01:33:18.582698',1,'dotuandat2004nd@gmail.com','2025-03-16 00:11:28.511359',NULL,'ONLINE','COD','COMPLETED',46741500,'19fdeb54-c98e-4427-900d-79b615b8196e','ef72e64a-4ba2-41cf-8b49-5be97968f3ad'),
('35cb316c-54b1-440a-ae06-209e120f933c','anonymousUser','2025-03-17 01:20:21.660874',1,'admin@gmail.com','2025-03-17 01:21:33.657396',NULL,'ONLINE','COD','CANCELLED',22455000,'5010a4e9-2b63-4c3c-b8c2-08b88f9857c4','8491c9bb-e3a3-4436-abd8-c3d74216d422'),
('39d9d5e6-dd81-4a68-9789-465b6e9003fa','anonymousUser','2025-03-04 22:09:46.306257',1,'admin@gmail.com','2025-03-11 18:14:55.228142',NULL,'ONLINE','E_WALLET','CANCELLED',17592000,'fcea98cb-e68e-46ff-a849-79d03acc849a','93c1c628-da91-4834-a776-4e3c9d7220b6'),
('3c23df98-712d-4ee5-872f-a93d0e834317','anonymousUser','2025-03-09 15:29:45.297327',1,'dotuandat2004nd@gmail.com','2025-03-09 15:35:03.903159',NULL,'ONLINE','COD','COMPLETED',19992000,'7fa49ed3-3939-40ba-86f7-1e0e978bc43e','d0abf087-be2a-4a40-b002-bfff337c026f'),
('3c64f3f3-d43c-4d52-a14e-77b3622b9d58','anonymousUser','2025-03-08 23:50:39.338822',1,'dotuandat2004nd@gmail.com','2025-03-09 00:15:41.040449',NULL,'ONLINE','COD','COMPLETED',26000000,'0d7a65d4-17f6-406a-9584-ed1520686897','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('3e49ce81-9a48-4ddd-9a9e-d4fc14b70f30','anonymousUser','2025-03-07 15:16:08.743047',1,'dotuandat2004nd@gmail.com','2025-03-08 18:30:20.104025',NULL,'ONLINE','COD','COMPLETED',17592000,'a8a681d2-784d-4b2a-a721-7530ddcb1f93','024317a8-9e55-419d-bb9e-ed4cb104d020'),
('3fdb61aa-6df4-449c-8d93-b96e5fa84178','anonymousUser','2025-03-17 11:47:48.301233',1,'admin@gmail.com','2025-03-17 11:48:22.177498',NULL,'ONLINE','COD','CANCELLED',5805000,'f9714155-883e-49b9-bf90-5f1be2226da3','c2672bf7-d02f-4a99-aefd-6042bbfc374b'),
('42778028-1f3c-4b82-aba0-fc0adbb700e7','anonymousUser','2025-03-04 22:06:56.772820',1,'dotuandat2004nd@gmail.com','2025-03-16 00:12:46.242191','abc...','ONLINE','E_WALLET','COMPLETED',7257250,'710e3dfc-9fc6-4d8d-ae02-03f8e6c2d27e','df365c04-5060-4315-9222-7c2f007a44d3'),
('45aa6ec0-75bd-49c8-a093-76814e829e1d','anonymousUser','2025-03-16 16:31:11.655481',1,'admin@gmail.com','2025-03-16 16:31:30.407890',NULL,'ONLINE','COD','COMPLETED',2421000,'995a1bdf-e09f-4c79-8e5a-e50653fe1580','024317a8-9e55-419d-bb9e-ed4cb104d020'),
('467d8eb7-00c3-4143-acf7-03cfa57a3ff1','mthong@gmail.com','2025-03-25 19:43:33.064503',1,'mthong@gmail.com','2025-03-25 19:43:33.064503',NULL,'OFFLINE','CASH','COMPLETED',23417250,NULL,'a6664967-a0da-4b31-b893-1b4241881672'),
('47d1bf4b-6574-498c-ab8c-db018469fb7a','anonymousUser','2025-03-07 15:13:30.098980',1,'huyquanhoa@gmail.com','2025-03-08 22:45:57.204752',NULL,'ONLINE','COD','CANCELLED',26392000,'a8a681d2-784d-4b2a-a721-7530ddcb1f93','024317a8-9e55-419d-bb9e-ed4cb104d020'),
('48bc4f66-85a2-48ca-a369-0ff057a10c04','anonymousUser','2025-03-09 21:33:51.826592',1,'dotuandat2004nd@gmail.com','2025-03-16 00:11:44.185336',NULL,'ONLINE','COD','COMPLETED',22181500,'1edad4b3-e040-4822-86cb-6f5d8aa418f8','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('4b5aafa4-4f82-4b2d-bb05-fc5a51ab6048','anonymousUser','2025-03-04 21:36:36.198787',1,'nqhai@gmail.com','2025-03-06 17:12:05.643411',NULL,'ONLINE','COD','CANCELLED',4225250,'27dece2a-6167-4b2c-b52b-09e20d4d2485','d0abf087-be2a-4a40-b002-bfff337c026f'),
('4c067478-8c6f-4970-9b55-7f43e7074a89','anonymousUser','2025-03-25 19:44:18.175932',1,'mthong@gmail.com','2025-03-25 19:44:44.418813',NULL,'ONLINE','E_WALLET','COMPLETED',29250000,'5917480b-ce9c-4eab-ae1c-ce74e3e95880','1e92be5e-320c-4606-854e-27bc0814b803'),
('4e589222-ce87-47d5-bd6a-366f0c9d0043','anonymousUser','2025-03-08 01:59:55.108082',1,'dotuandat2004nd@gmail.com','2025-03-08 02:00:19.110647',NULL,'ONLINE','COD','COMPLETED',1193250,'0d7a65d4-17f6-406a-9584-ed1520686897','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('4ee0d4c7-cf44-4dda-a09f-52e7155d5190','anonymousUser','2025-03-09 17:18:27.417547',1,'dotuandat2004nd@gmail.com','2025-03-16 00:12:10.360119',NULL,'ONLINE','COD','COMPLETED',26000000,'0d7a65d4-17f6-406a-9584-ed1520686897','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('4fd50b8d-eb85-4004-b4f6-9c3956950c62','anonymousUser','2025-03-11 07:16:59.757484',1,'dotuandat2004nd@gmail.com','2025-03-11 07:17:25.093329',NULL,'ONLINE','E_WALLET','COMPLETED',39407750,'1fad1d40-f249-41e4-8f5b-6f7e16633596','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('5479692b-492f-4695-a129-4000b6a56fb8','anonymousUser','2025-03-09 00:59:02.286743',1,'dotuandat2004nd@gmail.com','2025-03-16 00:12:23.541523',NULL,'ONLINE','COD','COMPLETED',17592000,'7d3cb495-12b6-4028-a718-1311ca69c611','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('553105ae-25c3-4b47-93a4-32d4883282fb','anonymousUser','2025-03-24 09:38:08.853844',1,'dotuandat2004nd@gmail.com','2025-03-24 09:38:56.871911',NULL,'ONLINE','COD','COMPLETED',40635250,'b90cf096-6d7e-4858-a906-41a82f808e28','b3e71cdf-5efa-4d05-a164-23b46b60750d'),
('55e229de-b332-4d3e-8efe-a55c0f35c7d0','anonymousUser','2025-03-08 18:08:36.450496',1,'dotuandat2004nd@gmail.com','2025-03-08 18:08:57.445543',NULL,'ONLINE','COD','COMPLETED',17985250,'0d7a65d4-17f6-406a-9584-ed1520686897','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('580dc181-b7fb-4834-b696-fb84436a06ca','anonymousUser','2025-03-05 20:24:33.766216',1,'dotuandat2004nd@gmail.com','2025-03-05 20:31:29.381592',NULL,'ONLINE','COD','COMPLETED',2488250,'0d7a65d4-17f6-406a-9584-ed1520686897','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('5865f3c3-c3af-442e-8dd5-022687d448d7','anonymousUser','2025-03-04 22:51:06.432687',1,'dotuandat2004nd@gmail.com','2025-03-05 21:08:57.477511',NULL,'ONLINE','COD','CANCELLED',73981500,'0d7a65d4-17f6-406a-9584-ed1520686897','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('5a4168ef-4e36-4f19-94f6-a6f59ba87e1e','anonymousUser','2025-03-09 01:20:14.333988',1,'dotuandat2004nd@gmail.com','2025-03-09 18:41:09.046524',NULL,'ONLINE','COD','COMPLETED',26392000,'0d7a65d4-17f6-406a-9584-ed1520686897','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('5e118451-413f-4c1b-9236-b4e91879d999','anonymousUser','2025-03-09 19:42:54.333390',1,'dotuandat2004nd@gmail.com','2025-03-16 00:09:32.612378',NULL,'ONLINE','COD','COMPLETED',11090750,'0d7a65d4-17f6-406a-9584-ed1520686897','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('65487212-a442-49aa-99dc-9aa0ca08c0a2','anonymousUser','2025-03-25 19:10:04.144209',1,'admin@gmail.com','2025-03-25 19:19:30.323817','abc','OFFLINE','CASH','COMPLETED',81395000,NULL,'c68506d2-7c97-4f6e-b51a-826f467dbd4e'),
('66aedff0-d1e7-40f9-a2f7-10870878a6b3','anonymousUser','2025-03-04 21:05:09.147977',1,'dotuandat2004nd@gmail.com','2025-03-08 22:49:25.494586',NULL,'ONLINE','COD','CANCELLED',4225250,'60364830-2a3a-4159-ba17-41db4c7fdf30','dc73d495-715f-4795-97dd-bd05b73e9668'),
('67e235bc-6821-4ea2-9988-46072d66403c','anonymousUser','2025-03-04 22:35:21.569385',1,'dotuandat2004nd@gmail.com','2025-03-08 17:32:19.203926',NULL,'ONLINE','COD','COMPLETED',49765000,'0d7a65d4-17f6-406a-9584-ed1520686897','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('68a064b7-c4e0-4480-bb92-5baa312fac02','anonymousUser','2025-03-05 21:13:19.877778',1,'dotuandat2004nd@gmail.com','2025-03-05 21:15:07.964552','F','ONLINE','E_WALLET','COMPLETED',24882500,'de011204-b3cb-40b3-8393-96dadf7d8712','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('69629a51-56f3-47da-b639-94429838c002','anonymousUser','2025-03-09 00:35:28.726360',1,'dotuandat2004nd@gmail.com','2025-03-09 00:36:00.400031',NULL,'ONLINE','COD','COMPLETED',17592000,'1edad4b3-e040-4822-86cb-6f5d8aa418f8','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('6d6cc7bb-e4cd-4251-9e8b-f4d9ab5ef932','mthong@gmail.com','2025-03-25 19:37:57.145662',1,'mthong@gmail.com','2025-03-25 19:39:48.824049',NULL,'OFFLINE','CASH','COMPLETED',119157500,NULL,'dc4cb5e8-00b7-4c85-bed7-85a9e96de897'),
('6f772e57-c137-4172-8b3f-f65d23513aae','anonymousUser','2025-03-17 01:23:57.627810',1,'admin@gmail.com','2025-03-17 01:25:26.228855',NULL,'ONLINE','E_WALLET','COMPLETED',41760000,'d88b502f-8d81-4a24-a10a-b4075a9ec09c','20731af4-0523-4f77-8e17-f800af2bb718'),
('7036e79e-f2e8-455b-9bce-ac09e8f29a98','anonymousUser','2025-04-04 00:09:27.800440',1,'anonymousUser','2025-04-04 00:09:27.800440',NULL,'ONLINE','COD','PENDING',4041000,'995a1bdf-e09f-4c79-8e5a-e50653fe1580','024317a8-9e55-419d-bb9e-ed4cb104d020'),
('71397f90-0e81-4f7e-aabb-36263e6326ab','anonymousUser','2025-03-24 09:32:49.356010',1,'dotuandat2004nd@gmail.com','2025-03-24 09:39:07.725247',NULL,'ONLINE','COD','COMPLETED',56492000,'4e598437-7468-49f0-a714-d48b5e9d582b','afff85d7-53e8-40f9-9271-440bde54b151'),
('71834902-fffa-426a-be67-21764f063146','anonymousUser','2025-03-16 16:40:36.202273',1,'admin@gmail.com','2025-03-16 16:42:16.996246',NULL,'ONLINE','COD','COMPLETED',2421000,'f96ac8e5-b29a-4c18-886a-6e724f7841c8','0e285053-f2fd-485d-9f2f-4ea8d6951d17'),
('72412cdb-063f-4af9-9824-e7749fabee82','anonymousUser','2025-03-09 23:34:26.382010',1,'dotuandat2004nd@gmail.com','2025-03-10 15:05:46.404104',NULL,'ONLINE','COD','COMPLETED',2765750,'e3912d54-8282-43b7-aeb8-3a1d66621383','0a262bfd-d8c9-426f-a2f7-abaec3b0039c'),
('74d892d6-dfe0-4e24-8f81-49fbc7a1ab17','anonymousUser','2025-03-04 22:51:30.968236',1,'dotuandat2004nd@gmail.com','2025-03-05 21:08:44.084471',NULL,'ONLINE','COD','FAILED',1193250,'0d7a65d4-17f6-406a-9584-ed1520686897','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('796ca1af-cdeb-4ff0-87da-be0017be7372','anonymousUser','2025-03-09 15:30:02.299191',1,'dotuandat2004nd@gmail.com','2025-03-09 15:34:49.792640',NULL,'ONLINE','COD','COMPLETED',2152000,'7fa49ed3-3939-40ba-86f7-1e0e978bc43e','d0abf087-be2a-4a40-b002-bfff337c026f'),
('7b4bdf68-adb4-47c3-9245-64c620d29d13','anonymousUser','2025-03-09 15:28:24.374277',1,'dotuandat2004nd@gmail.com','2025-03-09 15:33:51.620144','sau 9h sáng','ONLINE','E_WALLET','COMPLETED',26000000,'7fa49ed3-3939-40ba-86f7-1e0e978bc43e','d0abf087-be2a-4a40-b002-bfff337c026f'),
('7b997171-c1c4-4b3e-888d-ae9617f63995','anonymousUser','2025-03-09 14:34:38.337040',1,'dotuandat2004nd@gmail.com','2025-03-09 18:40:32.480906',NULL,'ONLINE','E_WALLET','CANCELLED',17592000,'0d7a65d4-17f6-406a-9584-ed1520686897','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('80474789-5dce-4413-b66f-cc05a4845277','anonymousUser','2025-03-07 15:11:39.093801',1,'dotuandat2004nd@gmail.com','2025-03-08 18:30:34.621693',NULL,'ONLINE','COD','COMPLETED',3968250,'a8a681d2-784d-4b2a-a721-7530ddcb1f93','024317a8-9e55-419d-bb9e-ed4cb104d020'),
('813cb0da-da71-482d-bf5d-f42cd58be122','anonymousUser','2025-03-16 16:43:15.351642',1,'admin@gmail.com','2025-03-16 16:43:37.759855',NULL,'ONLINE','COD','COMPLETED',4842000,'0bcd7042-bf43-4917-b0ca-0707945eabf6','d435d2b6-34f2-4226-85d4-1149f12c4761'),
('82814020-544b-4a77-92a0-ab2c8d370a06','anonymousUser','2025-03-04 21:47:41.233447',1,'dotuandat2004nd@gmail.com','2025-03-08 22:49:10.487551',NULL,'ONLINE','COD','CANCELLED',1193250,'1aa3ad91-b456-4a28-8f4a-dbf696ae4111','dc73d495-715f-4795-97dd-bd05b73e9668'),
('881e778a-2eeb-4eba-af27-3743a16eaf29','anonymousUser','2025-03-21 18:37:55.873183',1,'dotuandat2004nd@gmail.com','2025-03-22 10:19:24.779349',NULL,'ONLINE','COD','CANCELLED',29250000,'1fad1d40-f249-41e4-8f5b-6f7e16633596','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('91517afe-32f9-4311-9bb1-f20cac7a24e1','anonymousUser','2025-03-05 21:15:46.759275',1,'dotuandat2004nd@gmail.com','2025-03-05 21:16:26.408487',NULL,'ONLINE','COD','CANCELLED',21520000,'0d7a65d4-17f6-406a-9584-ed1520686897','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('91b62b4b-f765-4f9c-b403-0ff3bc0778aa','anonymousUser','2025-03-25 19:08:51.820496',1,'admin@gmail.com','2025-03-25 19:19:20.460480','abc','OFFLINE','CASH','COMPLETED',13852750,NULL,'c68506d2-7c97-4f6e-b51a-826f467dbd4e'),
('97ff1c63-19e6-49c5-87c8-0b6e72f84e79','anonymousUser','2025-03-08 02:09:59.876423',1,'dotuandat2004nd@gmail.com','2025-03-08 02:10:16.404412',NULL,'ONLINE','COD','COMPLETED',1193250,'0d7a65d4-17f6-406a-9584-ed1520686897','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('9df644c2-4fb3-41b1-aac5-205539c77bde','anonymousUser','2025-03-12 01:33:42.389580',1,'admin@gmail.com','2025-03-12 17:28:29.963854',NULL,'ONLINE','COD','COMPLETED',19415750,'468b1d1c-e91a-40fa-9fd4-bce8f2600012','a7ddd32e-f737-4ff4-af59-18144fc9a432'),
('a271e378-461a-41bd-95d1-aebb1c202ad4','anonymousUser','2025-03-15 10:18:28.533714',1,'dotuandat2004nd@gmail.com','2025-03-15 10:20:59.217981','Giao ngoài giờ hành chính','ONLINE','E_WALLET','COMPLETED',257255250,'e8874359-5f87-46ed-ab65-7d435e176750','a90533bf-ce4b-4187-8c5e-77046b70c03e'),
('a507c215-88f4-480f-acaf-90287bf77c97','anonymousUser','2025-03-17 01:19:34.864763',1,'admin@gmail.com','2025-03-17 01:21:55.485148',NULL,'ONLINE','E_WALLET','COMPLETED',19305000,'0c2c3e40-037e-42cf-8c88-fe803e95cc81','dc73d495-715f-4795-97dd-bd05b73e9668'),
('ad99dcb2-2ed5-456e-ad14-9ddf53cbb291','anonymousUser','2025-03-17 11:44:23.395958',1,'admin@gmail.com','2025-03-17 11:48:21.034354','Không','ONLINE','COD','CANCELLED',116100000,'69ff3b0c-fcdd-46cc-b440-2e3be5562925','8de76534-51ca-48e5-b776-6dffb98f3835'),
('b8d815e8-b00f-4a7e-a4d7-cd9257ef7fe1','anonymousUser','2025-03-16 16:30:53.995120',1,'admin@gmail.com','2025-03-16 16:31:41.038459',NULL,'ONLINE','COD','COMPLETED',32445750,'2d2a1d37-951f-4e3a-8b44-67c82b825339','d0abf087-be2a-4a40-b002-bfff337c026f'),
('b9538a9f-2efa-429e-9109-d9cd993f8ad1','anonymousUser','2025-03-03 18:19:23.359236',1,'admin@gmail.com','2025-03-03 18:24:18.258074',NULL,'OFFLINE','COD','CANCELLED',250000000,'48d6ff76-96d1-4252-80e2-52d1c6137d36','d435d2b6-34f2-4226-85d4-1149f12c4761'),
('ba627644-d99b-4736-baf2-9a6d569bc48e','anonymousUser','2025-03-10 22:15:48.492857',1,'dotuandat2004nd@gmail.com','2025-03-16 00:11:36.341181',NULL,'ONLINE','COD','COMPLETED',8315750,'468b1d1c-e91a-40fa-9fd4-bce8f2600012','a7ddd32e-f737-4ff4-af59-18144fc9a432'),
('baa0113e-27bb-45fd-b685-c78719214af8','anonymousUser','2025-03-09 18:43:53.841745',1,'admin@gmail.com','2025-03-12 17:28:42.673679',NULL,'ONLINE','E_WALLET','CANCELLED',17592000,'0bcd7042-bf43-4917-b0ca-0707945eabf6','d435d2b6-34f2-4226-85d4-1149f12c4761'),
('bee79ece-d649-4b9b-848b-7347ad10fb58','anonymousUser','2025-03-08 02:00:41.591375',1,'dotuandat2004nd@gmail.com','2025-03-08 02:01:00.034767',NULL,'ONLINE','COD','COMPLETED',1193250,'0d7a65d4-17f6-406a-9584-ed1520686897','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('c199296a-244e-415a-aa25-d5565e8c95eb','anonymousUser','2025-03-21 18:19:22.851507',1,'dotuandat2004nd@gmail.com','2025-03-22 10:18:52.754136',NULL,'ONLINE','COD','COMPLETED',20340750,'1edad4b3-e040-4822-86cb-6f5d8aa418f8','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('c3ae3d84-6f5c-44c9-a58d-cd8f5a4a0c13','anonymousUser','2025-03-25 18:57:39.213134',1,'admin@gmail.com','2025-03-25 19:21:06.916173',NULL,'ONLINE','COD','COMPLETED',4491000,'1f7cbc7f-9ef3-478e-a85d-578088909de8','a7ddd32e-f737-4ff4-af59-18144fc9a432'),
('c57378ad-861d-4258-89cd-390feeb96070','anonymousUser','2025-03-09 00:40:23.038969',1,'dotuandat2004nd@gmail.com','2025-03-09 00:41:40.581235','Sau 5h chiều','ONLINE','COD','COMPLETED',17592000,'fdec56a1-48ad-434c-982f-6b922f9133c4','c68506d2-7c97-4f6e-b51a-826f467dbd4e'),
('cb8269d6-ccdf-4460-a11d-c2ab0cf61932','anonymousUser','2025-03-03 17:13:59.328166',1,'pesmobile5404@gmail.com','2025-03-05 18:29:11.471526',NULL,'OFFLINE','COD','CANCELLED',250000000,'48d6ff76-96d1-4252-80e2-52d1c6137d36','d435d2b6-34f2-4226-85d4-1149f12c4761'),
('cbabaaa4-2f8a-4927-8212-6854f4b89817','anonymousUser','2025-03-09 19:35:18.944595',1,'admin@gmail.com','2025-03-11 18:15:13.333331',NULL,'ONLINE','E_WALLET','COMPLETED',105169250,'c8ec6885-65f9-499e-a967-9ac3a069e91f','dc73d495-715f-4795-97dd-bd05b73e9668'),
('ccb9f305-0387-47df-a66e-8f0a9982175a','anonymousUser','2025-03-05 21:18:11.783065',1,'j97@gmail.com','2025-03-06 16:55:25.366766',NULL,'ONLINE','COD','CANCELLED',2152000,'6b01dc09-aac5-4795-92f5-ad8d6cb61da2','b3e71cdf-5efa-4d05-a164-23b46b60750d'),
('ce5cd10e-0f9a-4764-aa72-38a97d6e6729','anonymousUser','2025-03-08 02:02:10.057562',1,'dotuandat2004nd@gmail.com','2025-03-08 02:02:23.346199',NULL,'ONLINE','COD','COMPLETED',1193250,'0d7a65d4-17f6-406a-9584-ed1520686897','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('cf6cf86b-5145-460c-84ad-daa58da5f436','anonymousUser','2025-03-21 15:58:32.524339',1,'dotuandat2004nd@gmail.com','2025-03-21 15:59:11.951581',NULL,'ONLINE','COD','COMPLETED',25391250,'4a954c4b-6311-4caf-b288-b0b16ec0a971','e2579cb8-b240-4405-a3ba-e52b55831a33'),
('d352aee0-6793-430e-bc41-8f723479307b','anonymousUser','2025-04-04 00:09:02.695314',1,'anonymousUser','2025-04-04 00:09:02.695314',NULL,'ONLINE','COD','PENDING',2961000,'2d2a1d37-951f-4e3a-8b44-67c82b825339','d0abf087-be2a-4a40-b002-bfff337c026f'),
('d6d7ce82-ef4f-463a-aa9b-066a4e94bb12','anonymousUser','2025-03-16 00:07:43.161976',1,'dotuandat2004nd@gmail.com','2025-03-16 00:08:28.324576',NULL,'ONLINE','COD','COMPLETED',187730000,'f5c652dc-14dc-4563-8bd6-38fb0012fd86','decd643b-2bce-411c-8b04-ffaf9681ac10'),
('daf27e75-7fe6-451e-ac4e-85692f25832c','anonymousUser','2025-03-11 08:57:02.155605',1,'admin@gmail.com','2025-03-11 08:57:53.434961',NULL,'ONLINE','COD','COMPLETED',101703750,'bb3f1a2c-ab26-4cc0-b3e5-45400b445523','a7ddd32e-f737-4ff4-af59-18144fc9a432'),
('dba784cb-2bfe-4979-9644-780f161d6686','anonymousUser','2025-03-25 19:08:51.480143',1,'admin@gmail.com','2025-03-25 19:19:58.529035','abc','OFFLINE','CASH','COMPLETED',13852750,NULL,'c68506d2-7c97-4f6e-b51a-826f467dbd4e'),
('dbc0a2d3-bea1-4d66-a880-3262222616e7','anonymousUser','2025-03-09 15:28:54.310792',1,'dotuandat2004nd@gmail.com','2025-03-09 15:35:44.447369',NULL,'ONLINE','COD','COMPLETED',17592000,'7fa49ed3-3939-40ba-86f7-1e0e978bc43e','d0abf087-be2a-4a40-b002-bfff337c026f'),
('dc295f9a-de97-4def-b543-5801f98d9169','anonymousUser','2025-03-04 22:01:29.020714',1,'dotuandat2004nd@gmail.com','2025-03-16 00:13:04.247689',NULL,'ONLINE','COD','COMPLETED',1193250,'0d7a65d4-17f6-406a-9584-ed1520686897','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('e20b53c6-2db4-4219-bddc-c581647d5b8f','anonymousUser','2025-03-04 22:05:12.540301',1,'dotuandat2004nd@gmail.com','2025-03-09 00:33:01.449132',NULL,'ONLINE','COD','CANCELLED',2386500,'1edad4b3-e040-4822-86cb-6f5d8aa418f8','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('e3a48e41-4d16-4b80-b129-30191d3ed54c','anonymousUser','2025-03-25 19:08:42.329215',1,'admin@gmail.com','2025-03-25 19:20:09.595577','abc','OFFLINE','CASH','COMPLETED',13852750,NULL,'c68506d2-7c97-4f6e-b51a-826f467dbd4e'),
('e3bceadf-990f-4b8a-b688-d4e90bc0eabf','anonymousUser','2025-03-25 19:08:34.992933',1,'admin@gmail.com','2025-03-25 19:20:29.681628','abc','OFFLINE','CASH','COMPLETED',13852750,NULL,'c68506d2-7c97-4f6e-b51a-826f467dbd4e'),
('e5bf3dbd-f428-41ca-a0a4-5ce4cce29aff','anonymousUser','2025-03-09 01:02:19.127734',1,'dotuandat2004nd@gmail.com','2025-03-09 01:11:56.296306',NULL,'ONLINE','COD','CANCELLED',1193250,'0d7a65d4-17f6-406a-9584-ed1520686897','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('e75ddfc1-588a-4072-a1e0-ad882cf3929f','anonymousUser','2025-03-09 15:29:28.177502',1,'dotuandat2004nd@gmail.com','2025-03-09 15:35:21.798025',NULL,'ONLINE','COD','COMPLETED',1193250,'7fa49ed3-3939-40ba-86f7-1e0e978bc43e','d0abf087-be2a-4a40-b002-bfff337c026f'),
('e835aac9-9f63-4a32-a0ad-78e6be2b4e50','anonymousUser','2025-03-04 21:32:43.412467',1,'dotuandat2004nd@gmail.com','2025-03-06 16:52:47.043713','Note...','ONLINE','COD','CANCELLED',63976000,'0d7a65d4-17f6-406a-9584-ed1520686897','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('ead5f7ca-49f9-4d65-bc49-7886df0cd7bf','anonymousUser','2025-03-04 21:50:50.607585',1,'dotuandat2004nd@gmail.com','2025-03-16 00:12:39.239963',NULL,'ONLINE','COD','COMPLETED',19992000,'0d7a65d4-17f6-406a-9584-ed1520686897','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('eb131799-f54b-4cd5-b0e8-3e2bffb6fab4','anonymousUser','2025-03-09 15:32:52.225684',1,'dotuandat2004nd@gmail.com','2025-03-09 15:34:02.289004',NULL,'ONLINE','COD','COMPLETED',3968250,'7fa49ed3-3939-40ba-86f7-1e0e978bc43e','d0abf087-be2a-4a40-b002-bfff337c026f'),
('ec6d6afc-4247-4428-83e2-328b5e8fedc5','anonymousUser','2025-03-25 19:08:43.133965',1,'admin@gmail.com','2025-03-25 19:20:48.220087','abc','OFFLINE','CASH','COMPLETED',13852750,NULL,'c68506d2-7c97-4f6e-b51a-826f467dbd4e'),
('f5bfff00-e875-4c65-b6a9-8cf21a8213da','anonymousUser','2025-03-25 19:12:42.926678',1,'admin@gmail.com','2025-03-25 19:17:30.181534','abc','OFFLINE','CASH','COMPLETED',21241500,NULL,'c68506d2-7c97-4f6e-b51a-826f467dbd4e'),
('f985d47c-5b5e-4959-8d64-9f7722d3a029','anonymousUser','2025-03-25 07:53:29.315913',1,'admin@gmail.com','2025-03-25 19:20:56.647385',NULL,'ONLINE','COD','COMPLETED',2421000,'2d2a1d37-951f-4e3a-8b44-67c82b825339','d0abf087-be2a-4a40-b002-bfff337c026f'),
('f9db287f-0b77-478d-8b5c-82901fb6ff80','dotuandat2004nd@gmail.com','2025-03-25 19:47:12.797790',1,'dotuandat2004nd@gmail.com','2025-03-25 19:47:12.797790','abc','OFFLINE','E_WALLET','COMPLETED',53910000,NULL,'bc2b20c0-49d8-4f5a-83eb-600cb8086d92'),
('fd0bcb32-9f3e-4666-9cc8-84c7568bff8f','anonymousUser','2025-03-09 15:30:22.652567',1,'dotuandat2004nd@gmail.com','2025-03-09 15:34:22.454950',NULL,'ONLINE','COD','COMPLETED',26392000,'7fa49ed3-3939-40ba-86f7-1e0e978bc43e','d0abf087-be2a-4a40-b002-bfff337c026f'),
('fd69486f-369e-4d8f-9a8f-1c9cf0eece74','anonymousUser','2025-03-25 19:08:33.063684',1,'admin@gmail.com','2025-03-25 19:20:19.947275','abc','OFFLINE','CASH','COMPLETED',13852750,NULL,'c68506d2-7c97-4f6e-b51a-826f467dbd4e'),
('fe5d9afb-c0eb-4041-8ebb-e071b76b3ac5','anonymousUser','2025-03-09 14:26:30.488828',1,'dotuandat2004nd@gmail.com','2025-03-16 00:12:17.238347',NULL,'ONLINE','COD','COMPLETED',35184000,'7d3cb495-12b6-4028-a718-1311ca69c611','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_detail` (
  `id` varchar(36) NOT NULL,
  `createdby` varchar(255) DEFAULT NULL,
  `createddate` datetime(6) DEFAULT NULL,
  `is_active` tinyint NOT NULL,
  `modifiedby` varchar(255) DEFAULT NULL,
  `modifieddate` datetime(6) DEFAULT NULL,
  `price_at_purchase` bigint NOT NULL,
  `quantity` int NOT NULL,
  `order_id` varchar(36) NOT NULL,
  `product_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKlb8mofup9mi791hraxt9wlj5u` (`order_id`),
  KEY `FKb8bg2bkty0oksa3wiq5mp5qnc` (`product_id`),
  CONSTRAINT `FKb8bg2bkty0oksa3wiq5mp5qnc` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FKlb8mofup9mi791hraxt9wlj5u` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
INSERT INTO `order_detail` VALUES ('0115f8a8-0a9a-4be1-86e4-f8f338cd4560','anonymousUser','2025-03-04 22:16:38.511715',1,'anonymousUser','2025-03-04 22:16:38.511715',1193250,10,'2df09e5a-78b9-47ed-849e-81312d0e9b1d','0e4353ac-d554-48cc-bee4-fa16af1552f7'),
('01e13a08-28e3-49db-843a-06944044e6c8','anonymousUser','2025-03-04 21:47:41.235445',1,'anonymousUser','2025-03-04 21:47:41.235445',1193250,1,'82814020-544b-4a77-92a0-ab2c8d370a06','0e4353ac-d554-48cc-bee4-fa16af1552f7'),
('01ec4c8b-65b6-4350-878a-f4e936fb5daa','anonymousUser','2025-03-09 01:02:19.133735',1,'anonymousUser','2025-03-09 01:02:19.133735',1193250,1,'e5bf3dbd-f428-41ca-a0a4-5ce4cce29aff','0e4353ac-d554-48cc-bee4-fa16af1552f7'),
('038b7456-be1a-461b-b727-e1bea3400ae1','anonymousUser','2025-03-08 01:59:55.110874',1,'anonymousUser','2025-03-08 01:59:55.110874',1193250,1,'4e589222-ce87-47d5-bd6a-366f0c9d0043','0e4353ac-d554-48cc-bee4-fa16af1552f7'),
('03ba1628-af65-4c22-b564-29499da85087','anonymousUser','2025-03-09 21:33:51.833261',1,'anonymousUser','2025-03-09 21:33:51.833261',11090750,2,'48bc4f66-85a2-48ca-a369-0ff057a10c04','04bb4b23-8316-45f5-8534-6766fbca71d1'),
('04c9c6f0-e3c5-4c7f-9887-59e1c07bed13','anonymousUser','2025-03-25 19:08:51.821049',1,'anonymousUser','2025-03-25 19:08:51.821049',4041000,1,'91b62b4b-f765-4f9c-b403-0ff3bc0778aa','f75b73a8-353b-4412-8e85-040e376e94e5'),
('0757effa-e3af-496a-b4cd-9784ea514596','anonymousUser','2025-03-25 19:08:52.233662',1,'anonymousUser','2025-03-25 19:08:52.233662',4041000,1,'2858c7ae-96dd-40b2-961f-d76d11558239','f75b73a8-353b-4412-8e85-040e376e94e5'),
('078ef910-ed63-4ac9-887d-024c8b323974','anonymousUser','2025-03-04 21:32:43.435512',1,'anonymousUser','2025-03-04 21:32:43.435512',26392000,1,'e835aac9-9f63-4a32-a0ad-78e6be2b4e50','eadecf1a-53dd-4460-a0ed-4d175a2b000a'),
('09c98e4c-3084-45de-b215-b61d1b5748af','anonymousUser','2025-03-04 22:03:20.824553',1,'anonymousUser','2025-03-04 22:03:20.824553',17592000,1,'07ca77b8-e32a-462f-a97a-424b88b695c0','71ab414c-9228-430a-a356-523fefcf3691'),
('0aa8b943-9ada-493c-98f9-763e5990ca2f','anonymousUser','2025-03-04 22:03:20.824009',1,'anonymousUser','2025-03-04 22:03:20.824009',26000000,1,'07ca77b8-e32a-462f-a97a-424b88b695c0','5e2a4f52-906c-4cf8-9ec4-a559524e0879'),
('0c5ea8bc-e8b3-498a-89d8-dc40fc9cda75','anonymousUser','2025-03-25 19:08:42.330234',1,'anonymousUser','2025-03-25 19:08:42.330234',2421000,1,'e3a48e41-4d16-4b80-b129-30191d3ed54c','ed919e14-5063-4b42-bcee-6c881db5d21c'),
('0c70516f-fc4d-4334-ab17-15a726c28ccf','anonymousUser','2025-03-04 22:05:12.540850',1,'anonymousUser','2025-03-04 22:05:12.540850',1193250,2,'e20b53c6-2db4-4219-bddc-c581647d5b8f','0e4353ac-d554-48cc-bee4-fa16af1552f7'),
('0d406832-ed8a-4dba-b731-11ec26a69aaf','anonymousUser','2025-03-16 00:07:43.169575',1,'anonymousUser','2025-03-16 00:07:43.169575',17990000,1,'d6d7ce82-ef4f-463a-aa9b-066a4e94bb12','f53fb25d-f92d-4628-bd09-513cc3d90273'),
('0e3c3d9a-805a-4807-b8e5-753da347b23b','anonymousUser','2025-03-09 19:37:40.418417',1,'anonymousUser','2025-03-09 19:37:40.418417',16792000,1,'29e0ae88-dd5b-4e74-8163-6a9bfaa8beea','53622008-8cea-4304-a861-2e32869c0c45'),
('0f2acb02-aced-4b0c-af3e-b8158d9e10a5','anonymousUser','2025-03-07 15:26:28.668805',1,'anonymousUser','2025-03-07 15:26:28.668805',26392000,1,'06f7a494-3f96-463d-8c4f-d324e18aed4f','eadecf1a-53dd-4460-a0ed-4d175a2b000a'),
('10ceb869-4c28-43c9-81b6-c03dd1c121a8','anonymousUser','2025-03-15 10:18:28.535996',1,'anonymousUser','2025-03-15 10:18:28.535996',19415750,2,'a271e378-461a-41bd-95d1-aebb1c202ad4','53622008-8cea-4304-a861-2e32869c0c45'),
('156a94c5-58d4-46a1-b15c-740fac3192e7','anonymousUser','2025-03-07 15:31:33.187662',1,'anonymousUser','2025-03-07 15:31:33.187662',26000000,1,'1e63dbb3-d3b6-4358-900f-632563ad95c7','5e2a4f52-906c-4cf8-9ec4-a559524e0879'),
('16431769-0382-4d6f-a4b0-61b42c802790','anonymousUser','2025-03-15 10:18:28.536569',1,'anonymousUser','2025-03-15 10:18:28.536569',4041000,1,'a271e378-461a-41bd-95d1-aebb1c202ad4','f75b73a8-353b-4412-8e85-040e376e94e5'),
('17a67383-d7df-41e0-8c11-0d8587e0ac0e','anonymousUser','2025-03-24 09:38:08.854397',1,'anonymousUser','2025-03-24 09:38:08.854397',1563250,1,'553105ae-25c3-4b47-93a4-32d4883282fb','1ed493f3-53bc-46d3-b1b4-2d90be4f22fe'),
('1882915a-b7c6-49f8-9fb7-f45aca5c2d85','anonymousUser','2025-03-04 22:09:46.307336',1,'anonymousUser','2025-03-04 22:09:46.307336',17592000,1,'39d9d5e6-dd81-4a68-9789-465b6e9003fa','71ab414c-9228-430a-a356-523fefcf3691'),
('1c92b18a-b157-44f2-98d9-7ee2b04f3108','anonymousUser','2025-03-24 09:31:28.922511',1,'anonymousUser','2025-03-24 09:31:28.922511',3591000,1,'01c7e22d-fc4e-41de-9e1a-839b9f37eb40','1d5a4adf-d476-4690-a4a2-98906b6c7d7d'),
('1d4f1838-62ab-40bd-a828-2efc953c36db','anonymousUser','2025-03-17 01:23:57.628901',1,'anonymousUser','2025-03-17 01:23:57.628901',5391000,5,'6f772e57-c137-4172-8b3f-f65d23513aae','ab93e3b9-2e84-4dfb-8e9e-2b907505143e'),
('1d91cf53-7a3b-4ebb-84a6-15618b703fd9','anonymousUser','2025-03-25 19:12:42.927816',1,'anonymousUser','2025-03-25 19:12:42.927816',21241500,1,'f5bfff00-e875-4c65-b6a9-8cf21a8213da','af3a0e21-1a61-46a0-82b7-cf4697249c07'),
('1e4eec15-969d-4369-8d10-c5b200348b14','anonymousUser','2025-03-15 10:18:28.536569',1,'anonymousUser','2025-03-15 10:18:28.536569',3861000,2,'a271e378-461a-41bd-95d1-aebb1c202ad4','ff7a2db9-ade5-431b-96da-de04db3ba72a'),
('1e8f01b4-4886-4941-b573-52094324a07c','anonymousUser','2025-03-04 21:05:09.154927',1,'anonymousUser','2025-03-04 21:05:09.154927',3032000,1,'66aedff0-d1e7-40f9-a2f7-10870878a6b3','387bf7c9-0173-4976-be07-f1ba43845092'),
('1ec05b74-9a0d-47dc-88a5-bc292ac68b95','anonymousUser','2025-03-12 01:33:18.585695',1,'anonymousUser','2025-03-12 01:33:18.585695',46741500,1,'339ac8c4-d5f6-42ea-b389-5429ea474ce4','80b4f151-0089-4dd9-a239-5eb61d09bfb7'),
('1fa385ba-2e9c-497c-a36d-97c6782e249b','anonymousUser','2025-03-07 13:55:28.308162',1,'anonymousUser','2025-03-07 13:55:28.308162',19992000,100,'021d184b-db35-4542-a8d1-292debeb2b34','0cb1fccc-eb7b-4a58-8b4e-09d3dc1c7d4a'),
('21531f24-347d-461a-b708-db3bdbcb239c','anonymousUser','2025-03-11 07:16:59.775216',1,'anonymousUser','2025-03-11 07:16:59.775216',19415750,1,'4fd50b8d-eb85-4004-b4f6-9c3956950c62','53622008-8cea-4304-a861-2e32869c0c45'),
('2423eba2-f32e-4d66-820c-965aa4834ffb','anonymousUser','2025-03-07 15:22:50.258329',1,'anonymousUser','2025-03-07 15:22:50.258329',19992000,1,'12c02487-4e93-4f8c-8f1a-50717dcc7048','349c97b3-d00f-4afd-ab38-899e3b1bd15b'),
('2537a492-c4c8-4c68-8c27-c462c0a76130','anonymousUser','2025-03-04 21:50:50.607585',1,'anonymousUser','2025-03-04 21:50:50.607585',19992000,1,'ead5f7ca-49f9-4d65-bc49-7886df0cd7bf','0cb1fccc-eb7b-4a58-8b4e-09d3dc1c7d4a'),
('26981fd4-ab78-4623-9ab8-c5bdda67f1fe','anonymousUser','2025-03-03 20:23:06.931423',1,'anonymousUser','2025-03-03 20:23:06.931423',3790000,1,'24c323af-7ef6-42e1-9129-321fe4d52c4f','387bf7c9-0173-4976-be07-f1ba43845092'),
('2819ed05-eb9d-4905-8fd7-ade1b05a6537','anonymousUser','2025-03-15 10:18:28.536569',1,'anonymousUser','2025-03-15 10:18:28.536569',1840750,1,'a271e378-461a-41bd-95d1-aebb1c202ad4','0ebf1a90-739d-49af-bf50-023441bbb245'),
('2b2bc171-16aa-4f02-87dc-2bbf3cc0cb74','anonymousUser','2025-03-25 19:08:43.134547',1,'anonymousUser','2025-03-25 19:08:43.134547',7390750,1,'ec6d6afc-4247-4428-83e2-328b5e8fedc5','1a71e553-885e-44bc-9927-648731ea0962'),
('2f0fc398-f851-4c2f-b23b-5088fb00ad45','anonymousUser','2025-03-25 19:08:50.808301',1,'anonymousUser','2025-03-25 19:08:50.808301',4041000,1,'153d727b-ac41-4b81-8ae3-9eea1db10320','f75b73a8-353b-4412-8e85-040e376e94e5'),
('2ffc3e10-63d9-48bf-8375-3defbf88c2f6','anonymousUser','2025-03-25 19:08:43.133965',1,'anonymousUser','2025-03-25 19:08:43.133965',4041000,1,'ec6d6afc-4247-4428-83e2-328b5e8fedc5','f75b73a8-353b-4412-8e85-040e376e94e5'),
('305a84bb-2ad7-4f32-a0e0-02061432386c','anonymousUser','2025-03-17 11:47:48.301233',1,'anonymousUser','2025-03-17 11:47:48.301233',1161000,5,'3fdb61aa-6df4-449c-8d93-b96e5fa84178','0e4353ac-d554-48cc-bee4-fa16af1552f7'),
('31195418-c2bf-4ff8-9190-9a640793f26a','anonymousUser','2025-03-09 00:35:28.729683',1,'anonymousUser','2025-03-09 00:35:28.729683',17592000,1,'69629a51-56f3-47da-b639-94429838c002','71ab414c-9228-430a-a356-523fefcf3691'),
('3374161d-99ed-42d1-8e96-d102bb01b6a8','anonymousUser','2025-03-15 10:18:28.537756',1,'anonymousUser','2025-03-15 10:18:28.537756',26991000,1,'a271e378-461a-41bd-95d1-aebb1c202ad4','e464bb21-5c91-43de-a392-1f75c5446bb0'),
('33b2938c-a5f4-4336-aad3-4c6d649ca989','anonymousUser','2025-03-04 22:51:30.968791',1,'anonymousUser','2025-03-04 22:51:30.968791',1193250,1,'74d892d6-dfe0-4e24-8f81-49fbc7a1ab17','0e4353ac-d554-48cc-bee4-fa16af1552f7'),
('345414ce-4ae0-41e5-bc63-6e169774bf72','anonymousUser','2025-03-05 21:13:19.879711',1,'anonymousUser','2025-03-05 21:13:19.879711',2488250,10,'68a064b7-c4e0-4480-bb92-5baa312fac02','ed919e14-5063-4b42-bcee-6c881db5d21c'),
('3560240a-766a-4f25-8c83-82158b98d7d5','anonymousUser','2025-03-17 01:20:21.660874',1,'anonymousUser','2025-03-17 01:20:21.660874',4491000,5,'35cb316c-54b1-440a-ae06-209e120f933c','1ba152b2-c6be-4760-85eb-2ac641181afe'),
('38923758-eee1-4c9d-95b9-b7203a1f163c','anonymousUser','2025-03-04 22:35:21.575057',1,'anonymousUser','2025-03-04 22:35:21.575057',2488250,20,'67e235bc-6821-4ea2-9988-46072d66403c','ed919e14-5063-4b42-bcee-6c881db5d21c'),
('38dc2245-6f9c-4647-b6b0-01b8fa92db35','anonymousUser','2025-04-04 00:09:02.700834',1,'anonymousUser','2025-04-04 00:09:02.700834',2961000,1,'d352aee0-6793-430e-bc41-8f723479307b','c4a9d42f-71a1-4c20-86e8-4c21e3469e6f'),
('39856d37-94a9-4dec-91f3-1edc858f6cf8','dotuandat2004nd@gmail.com','2025-03-25 19:47:12.798349',1,'dotuandat2004nd@gmail.com','2025-03-25 19:47:12.798349',5391000,10,'f9db287f-0b77-478d-8b5c-82901fb6ff80','ab93e3b9-2e84-4dfb-8e9e-2b907505143e'),
('39c1fc65-6e2d-4b9c-a22b-1895f4d5b3af','anonymousUser','2025-03-16 16:30:54.001294',1,'anonymousUser','2025-03-16 16:30:54.001294',20340750,1,'b8d815e8-b00f-4a7e-a4d7-cd9257ef7fe1','71ab414c-9228-430a-a356-523fefcf3691'),
('3ed9bf36-ce2c-4311-827d-bb710d8ddae3','anonymousUser','2025-03-15 10:18:28.537144',1,'anonymousUser','2025-03-15 10:18:28.537144',21241500,1,'a271e378-461a-41bd-95d1-aebb1c202ad4','af3a0e21-1a61-46a0-82b7-cf4697249c07'),
('3f82a745-e337-43a7-a7ea-993b8772cbe8','anonymousUser','2025-03-09 19:37:40.418979',1,'anonymousUser','2025-03-09 19:37:40.418979',17592000,1,'29e0ae88-dd5b-4e74-8163-6a9bfaa8beea','71ab414c-9228-430a-a356-523fefcf3691'),
('40a032ed-5b76-4a80-88df-a428219518f1','anonymousUser','2025-03-17 11:44:23.399484',1,'anonymousUser','2025-03-17 11:44:23.399484',1161000,100,'ad99dcb2-2ed5-456e-ad14-9ddf53cbb291','0e4353ac-d554-48cc-bee4-fa16af1552f7'),
('42041c3e-232e-46b0-8f25-55f092866047','anonymousUser','2025-03-16 00:07:43.173617',1,'anonymousUser','2025-03-16 00:07:43.173617',11691000,1,'d6d7ce82-ef4f-463a-aa9b-066a4e94bb12','7257ecd7-5ae9-4d99-bb31-b0aa99617451'),
('45a46683-c4c8-4267-84b2-7f15227c26e0','anonymousUser','2025-03-08 02:00:41.592386',1,'anonymousUser','2025-03-08 02:00:41.592386',1193250,1,'bee79ece-d649-4b9b-848b-7347ad10fb58','0e4353ac-d554-48cc-bee4-fa16af1552f7'),
('46b1c6ca-e4fe-44bc-b845-809b58a404dd','anonymousUser','2025-03-08 23:50:39.351571',1,'anonymousUser','2025-03-08 23:50:39.351571',26000000,1,'3c64f3f3-d43c-4d52-a14e-77b3622b9d58','5e2a4f52-906c-4cf8-9ec4-a559524e0879'),
('47986d14-11f2-4cf1-ae21-38f19a9c1f04','anonymousUser','2025-03-04 21:32:43.435512',1,'anonymousUser','2025-03-04 21:32:43.435512',17592000,1,'e835aac9-9f63-4a32-a0ad-78e6be2b4e50','71ab414c-9228-430a-a356-523fefcf3691'),
('488c5bb1-6b91-43d2-a321-618ae6a6c205','anonymousUser','2025-03-24 09:32:49.356631',1,'anonymousUser','2025-03-24 09:32:49.356631',26990000,1,'71397f90-0e81-4f7e-aabb-36263e6326ab','a16d1150-402d-45c4-8915-3e7e602511f6'),
('4892e054-c63c-4c74-b335-2a3c8353c830','anonymousUser','2025-03-03 17:13:59.329156',1,'anonymousUser','2025-03-03 17:13:59.329156',24990000,5,'cb8269d6-ccdf-4460-a11d-c2ab0cf61932','0cb1fccc-eb7b-4a58-8b4e-09d3dc1c7d4a'),
('48962a4d-b2ed-4c37-986e-80c7a9463cdc','anonymousUser','2025-03-15 10:18:28.537756',1,'anonymousUser','2025-03-15 10:18:28.537756',3968250,1,'a271e378-461a-41bd-95d1-aebb1c202ad4','b2b5d2e3-7f13-49ca-91da-7bd969f794b8'),
('495e5ef3-2c88-436b-aae9-085b59d97031','anonymousUser','2025-03-16 00:07:43.174619',1,'anonymousUser','2025-03-16 00:07:43.174619',20340750,1,'d6d7ce82-ef4f-463a-aa9b-066a4e94bb12','71ab414c-9228-430a-a356-523fefcf3691'),
('4ca90251-e909-4d30-b628-3d62099f80cb','mthong@gmail.com','2025-03-25 19:37:57.154171',1,'mthong@gmail.com','2025-03-25 19:37:57.154171',21241500,5,'6d6cc7bb-e4cd-4251-9e8b-f4d9ab5ef932','af3a0e21-1a61-46a0-82b7-cf4697249c07'),
('4cdf72ea-5917-488e-81ab-68edfed7d79b','anonymousUser','2025-03-08 02:09:59.882425',1,'anonymousUser','2025-03-08 02:09:59.882425',1193250,1,'97ff1c63-19e6-49c5-87c8-0b6e72f84e79','0e4353ac-d554-48cc-bee4-fa16af1552f7'),
('4d9ff289-7342-4969-9e15-c02fd21dcc61','anonymousUser','2025-03-04 21:52:21.151066',1,'anonymousUser','2025-03-04 21:52:21.151066',3032000,1,'2dbcad88-fedd-409b-a8a0-ce8e02315373','387bf7c9-0173-4976-be07-f1ba43845092'),
('4e27e4c3-9c09-4e69-9216-eb60f1346c7e','anonymousUser','2025-03-03 17:12:01.471534',1,'anonymousUser','2025-03-03 17:12:01.471534',4490000,3,'3207eaf8-1a44-489b-8194-551354cef121','f75b73a8-353b-4412-8e85-040e376e94e5'),
('4ef0da42-2b47-47ae-b2fb-18b2b9b56a17','anonymousUser','2025-03-16 00:07:43.174619',1,'anonymousUser','2025-03-16 00:07:43.174619',18990000,1,'d6d7ce82-ef4f-463a-aa9b-066a4e94bb12','439ba2b8-d61d-4e5e-ab1a-ff32f2c78fd8'),
('4f5cada2-62fe-4139-bb59-4c9aa439edfc','anonymousUser','2025-03-03 17:13:59.329156',1,'anonymousUser','2025-03-03 17:13:59.329156',11990000,5,'cb8269d6-ccdf-4460-a11d-c2ab0cf61932','04bb4b23-8316-45f5-8534-6766fbca71d1'),
('51abb71c-1d29-474d-8d13-2c4fddd5a6ff','anonymousUser','2025-03-25 19:08:51.480143',1,'anonymousUser','2025-03-25 19:08:51.480143',4041000,1,'dba784cb-2bfe-4979-9644-780f161d6686','f75b73a8-353b-4412-8e85-040e376e94e5'),
('53032afa-91e9-47b7-8f97-ca5e5e523360','anonymousUser','2025-03-09 00:40:23.039522',1,'anonymousUser','2025-03-09 00:40:23.039522',17592000,1,'c57378ad-861d-4258-89cd-390feeb96070','71ab414c-9228-430a-a356-523fefcf3691'),
('54853d5a-0d92-4c7d-9e53-b08c0d990dfd','anonymousUser','2025-03-16 00:07:43.170572',1,'anonymousUser','2025-03-16 00:07:43.170572',16191000,1,'d6d7ce82-ef4f-463a-aa9b-066a4e94bb12','5acf3d41-2cee-46f9-937e-b8bc074698d4'),
('551d2734-6998-4d2f-b6fb-de8705a1bc67','anonymousUser','2025-03-16 00:07:43.173617',1,'anonymousUser','2025-03-16 00:07:43.173617',13490000,1,'d6d7ce82-ef4f-463a-aa9b-066a4e94bb12','4b18aa0a-ce30-4ccd-8fe6-e4217b97df71'),
('577a43d4-6a90-4900-853d-fc02f760cfdb','anonymousUser','2025-03-09 01:20:14.336094',1,'anonymousUser','2025-03-09 01:20:14.336094',26392000,1,'5a4168ef-4e36-4f19-94f6-a6f59ba87e1e','eadecf1a-53dd-4460-a0ed-4d175a2b000a'),
('58c7ad16-7845-496b-af91-b4853c124f49','anonymousUser','2025-03-07 15:24:41.946652',1,'anonymousUser','2025-03-07 15:24:41.946652',19992000,1,'1016c793-ca2c-44e8-8f68-7819a27b96b1','349c97b3-d00f-4afd-ab38-899e3b1bd15b'),
('5a4bc580-27ca-4743-b509-bbd2c51e69be','anonymousUser','2025-03-25 19:44:18.176945',1,'anonymousUser','2025-03-25 19:44:18.176945',29250000,1,'4c067478-8c6f-4970-9b55-7f43e7074a89','5e2a4f52-906c-4cf8-9ec4-a559524e0879'),
('5b02f06a-de64-4288-885b-537c610515d6','anonymousUser','2025-03-05 21:15:46.759827',1,'anonymousUser','2025-03-05 21:15:46.759827',2152000,10,'91517afe-32f9-4311-9bb1-f20cac7a24e1','ed919e14-5063-4b42-bcee-6c881db5d21c'),
('5c137eec-a722-46a3-b133-ed1e1dfddfdb','anonymousUser','2025-03-25 07:53:29.331721',1,'anonymousUser','2025-03-25 07:53:29.331721',2421000,1,'f985d47c-5b5e-4959-8d64-9f7722d3a029','ed919e14-5063-4b42-bcee-6c881db5d21c'),
('60e78eb0-98de-4af3-8ef8-e541a148e890','anonymousUser','2025-03-15 10:18:28.536569',1,'anonymousUser','2025-03-15 10:18:28.536569',4491000,2,'a271e378-461a-41bd-95d1-aebb1c202ad4','1ba152b2-c6be-4760-85eb-2ac641181afe'),
('61c0fefc-05be-4fa5-9b85-758fd8cef19f','anonymousUser','2025-03-21 15:58:32.531259',1,'anonymousUser','2025-03-21 15:58:32.531259',6003250,3,'cf6cf86b-5145-460c-84ad-daa58da5f436','db4f0c9a-f449-4792-a64e-c55963f5e23e'),
('61d7a45d-6f29-4d42-8363-943771004e9f','anonymousUser','2025-03-03 18:19:23.377280',1,'anonymousUser','2025-03-03 18:19:23.377280',11990000,10,'b9538a9f-2efa-429e-9109-d9cd993f8ad1','0e4353ac-d554-48cc-bee4-fa16af1552f7'),
('64ae2cb5-e4ad-4ee3-8454-bde32ea8a0e0','anonymousUser','2025-03-25 19:08:34.994469',1,'anonymousUser','2025-03-25 19:08:34.994469',7390750,1,'e3bceadf-990f-4b8a-b688-d4e90bc0eabf','1a71e553-885e-44bc-9927-648731ea0962'),
('65c84483-7662-4ec2-98f5-02c18abc3caa','anonymousUser','2025-03-25 19:08:51.480682',1,'anonymousUser','2025-03-25 19:08:51.480682',2421000,1,'dba784cb-2bfe-4979-9644-780f161d6686','ed919e14-5063-4b42-bcee-6c881db5d21c'),
('66759bbd-b90b-4a3f-bd10-ae58fd81fd52','anonymousUser','2025-03-16 00:07:43.172476',1,'anonymousUser','2025-03-16 00:07:43.172476',17990000,1,'d6d7ce82-ef4f-463a-aa9b-066a4e94bb12','be924284-9e15-4ecd-873a-ce466aeb702f'),
('67627b7a-4c6c-48fe-8a84-e65f1204c7c3','anonymousUser','2025-03-04 22:51:06.437595',1,'anonymousUser','2025-03-04 22:51:06.437595',1193250,62,'5865f3c3-c3af-442e-8dd5-022687d448d7','0e4353ac-d554-48cc-bee4-fa16af1552f7'),
('6ac053d2-e9a0-41bc-abb4-1d142cda9a25','anonymousUser','2025-03-25 19:08:43.134547',1,'anonymousUser','2025-03-25 19:08:43.134547',2421000,1,'ec6d6afc-4247-4428-83e2-328b5e8fedc5','ed919e14-5063-4b42-bcee-6c881db5d21c'),
('6be1baa1-2150-44b7-9ed8-af83648609fa','anonymousUser','2025-03-16 00:07:43.172476',1,'anonymousUser','2025-03-16 00:07:43.172476',11891500,2,'d6d7ce82-ef4f-463a-aa9b-066a4e94bb12','ed9ef5ce-5cb6-4672-8a87-0f112214098c'),
('6c3bb3a0-123c-45c8-ba8d-863b9863e898','anonymousUser','2025-03-21 18:19:22.861268',1,'anonymousUser','2025-03-21 18:19:22.861268',20340750,1,'c199296a-244e-415a-aa25-d5565e8c95eb','71ab414c-9228-430a-a356-523fefcf3691'),
('701730e4-84bd-4159-a287-9a6711c69b56','anonymousUser','2025-03-09 15:30:22.652567',1,'anonymousUser','2025-03-09 15:30:22.652567',26392000,1,'fd0bcb32-9f3e-4666-9cc8-84c7568bff8f','eadecf1a-53dd-4460-a0ed-4d175a2b000a'),
('703e26e6-030c-4f03-a770-ed42c2955088','anonymousUser','2025-03-24 09:32:49.357231',1,'anonymousUser','2025-03-24 09:32:49.357231',3411000,1,'71397f90-0e81-4f7e-aabb-36263e6326ab','8f418ffb-2f47-478b-8262-deb06702f20b'),
('7125256b-7b24-4217-ae06-8a1cbc0125cb','anonymousUser','2025-03-11 07:16:59.774324',1,'anonymousUser','2025-03-11 07:16:59.774324',19992000,1,'4fd50b8d-eb85-4004-b4f6-9c3956950c62','349c97b3-d00f-4afd-ab38-899e3b1bd15b'),
('73d4c9c7-44c8-41f1-bf89-470411c428a5','anonymousUser','2025-03-24 09:38:08.853844',1,'anonymousUser','2025-03-24 09:38:08.853844',18891000,1,'553105ae-25c3-4b47-93a4-32d4883282fb','3e6b46aa-612d-4873-b8ac-d0041fe4e53b'),
('74e18be0-cbac-474a-9884-f89d388b535d','anonymousUser','2025-04-04 16:29:10.582963',1,'anonymousUser','2025-04-04 16:29:10.582963',7390750,1,'23872424-6493-4e66-91b8-3044778d31fc','1a71e553-885e-44bc-9927-648731ea0962'),
('779d8bff-47c0-42e0-bd9d-4a63a90073fa','anonymousUser','2025-03-03 17:12:01.471534',1,'anonymousUser','2025-03-03 17:12:01.471534',4290000,2,'3207eaf8-1a44-489b-8194-551354cef121','fcaf6f68-f963-4dce-af8f-c524767834ea'),
('787bac68-8446-4633-92f9-392b02deed12','anonymousUser','2025-03-04 22:06:56.772820',1,'anonymousUser','2025-03-04 22:06:56.772820',1193250,1,'42778028-1f3c-4b82-aba0-fc0adbb700e7','0e4353ac-d554-48cc-bee4-fa16af1552f7'),
('790ac442-08e0-485b-9105-c5d5ed5c8f9a','anonymousUser','2025-03-09 18:43:53.842301',1,'anonymousUser','2025-03-09 18:43:53.842301',17592000,1,'baa0113e-27bb-45fd-b685-c78719214af8','71ab414c-9228-430a-a356-523fefcf3691'),
('79668c4d-ee60-4900-a5bc-92e270e7271c','anonymousUser','2025-03-04 22:03:20.824553',1,'anonymousUser','2025-03-04 22:03:20.824553',23992000,1,'07ca77b8-e32a-462f-a97a-424b88b695c0','e464bb21-5c91-43de-a392-1f75c5446bb0'),
('79df491a-832d-42da-9b7e-ae2c99b04892','anonymousUser','2025-03-16 00:07:43.171600',1,'anonymousUser','2025-03-16 00:07:43.171600',1563250,1,'d6d7ce82-ef4f-463a-aa9b-066a4e94bb12','1ed493f3-53bc-46d3-b1b4-2d90be4f22fe'),
('7ab24ede-28b9-4998-a618-13c68d373b00','anonymousUser','2025-03-15 10:18:28.536569',1,'anonymousUser','2025-03-15 10:18:28.536569',3043250,1,'a271e378-461a-41bd-95d1-aebb1c202ad4','4f80115f-9d53-4e40-b4d8-e363aff005bd'),
('7b0bffdb-05dd-4818-b0ff-d4a9c13783f5','anonymousUser','2025-04-04 00:09:27.800991',1,'anonymousUser','2025-04-04 00:09:27.800991',4041000,1,'7036e79e-f2e8-455b-9bce-ac09e8f29a98','f75b73a8-353b-4412-8e85-040e376e94e5'),
('7d72dc6a-4bd5-4edf-ae7c-296b0b1b1ea6','anonymousUser','2025-03-09 19:35:18.958585',1,'anonymousUser','2025-03-09 19:35:18.958585',17592000,2,'cbabaaa4-2f8a-4927-8212-6854f4b89817','71ab414c-9228-430a-a356-523fefcf3691'),
('8096404a-0078-4ee2-8241-ec8f6349a026','anonymousUser','2025-03-05 20:24:33.771252',1,'anonymousUser','2025-03-05 20:24:33.771252',2488250,1,'580dc181-b7fb-4834-b696-fb84436a06ca','ed919e14-5063-4b42-bcee-6c881db5d21c'),
('81234cd0-1899-45ac-8a80-6c51c3912574','anonymousUser','2025-03-24 09:38:08.854397',1,'anonymousUser','2025-03-24 09:38:08.854397',8490000,1,'553105ae-25c3-4b47-93a4-32d4883282fb','6beb1cca-0011-4142-9dad-10c12e24c3a6'),
('81357b21-8eb7-4e3f-a7c5-4796439d7930','anonymousUser','2025-03-24 09:31:28.922511',1,'anonymousUser','2025-03-24 09:31:28.922511',1193250,1,'01c7e22d-fc4e-41de-9e1a-839b9f37eb40','298940d0-9254-4cdf-b549-ec663f16fdd9'),
('81cf8a6e-8bbe-4c16-869d-d85a2a1c0c01','anonymousUser','2025-03-25 19:08:42.330234',1,'anonymousUser','2025-03-25 19:08:42.330234',7390750,1,'e3a48e41-4d16-4b80-b129-30191d3ed54c','1a71e553-885e-44bc-9927-648731ea0962'),
('85e946cd-4494-40b4-89f7-870e289b730d','anonymousUser','2025-03-25 19:08:50.808301',1,'anonymousUser','2025-03-25 19:08:50.808301',7390750,1,'153d727b-ac41-4b81-8ae3-9eea1db10320','1a71e553-885e-44bc-9927-648731ea0962'),
('8a251ec0-4815-46ba-9098-7ae80cf3da24','anonymousUser','2025-03-25 19:10:04.145312',1,'anonymousUser','2025-03-25 19:10:04.145312',28041500,1,'65487212-a442-49aa-99dc-9aa0ca08c0a2','4f688179-ba15-4207-a3a9-bc00f5cb9b69'),
('8af474c7-6ecc-4659-b12a-dbc3141d6f68','anonymousUser','2025-03-04 21:05:09.154927',1,'anonymousUser','2025-03-04 21:05:09.154927',1193250,1,'66aedff0-d1e7-40f9-a2f7-10870878a6b3','0e4353ac-d554-48cc-bee4-fa16af1552f7'),
('8c86bfaa-df05-4b71-96db-f00ccefb8d73','anonymousUser','2025-03-07 15:16:08.744062',1,'anonymousUser','2025-03-07 15:16:08.744062',17592000,1,'3e49ce81-9a48-4ddd-9a9e-d4fc14b70f30','71ab414c-9228-430a-a356-523fefcf3691'),
('8dd6a37d-8771-44d3-bc06-99585f9962af','anonymousUser','2025-03-09 00:59:02.288957',1,'anonymousUser','2025-03-09 00:59:02.288957',17592000,1,'5479692b-492f-4695-a129-4000b6a56fb8','71ab414c-9228-430a-a356-523fefcf3691'),
('908bb265-b3c7-4403-b54d-cc9dfeaf9005','anonymousUser','2025-03-03 17:12:01.470505',1,'anonymousUser','2025-03-03 17:12:01.470505',4290000,1,'3207eaf8-1a44-489b-8194-551354cef121','ff7a2db9-ade5-431b-96da-de04db3ba72a'),
('911ee369-79c0-4e8e-bf21-2a72f6cbf420','anonymousUser','2025-03-25 19:08:33.072313',1,'anonymousUser','2025-03-25 19:08:33.072313',4041000,1,'fd69486f-369e-4d8f-9a8f-1c9cf0eece74','f75b73a8-353b-4412-8e85-040e376e94e5'),
('91db8575-7e1b-4184-90ca-a83167bc11fd','anonymousUser','2025-03-25 19:10:04.145312',1,'anonymousUser','2025-03-25 19:10:04.145312',21241500,1,'65487212-a442-49aa-99dc-9aa0ca08c0a2','af3a0e21-1a61-46a0-82b7-cf4697249c07'),
('924a1c31-dfb8-46d3-85e9-97592b80157d','anonymousUser','2025-03-16 00:07:43.171087',1,'anonymousUser','2025-03-16 00:07:43.171087',18891000,1,'d6d7ce82-ef4f-463a-aa9b-066a4e94bb12','3e6b46aa-612d-4873-b8ac-d0041fe4e53b'),
('931e3681-66b7-4963-bade-ff33843565e2','anonymousUser','2025-03-08 18:08:36.453985',1,'anonymousUser','2025-03-08 18:08:36.453985',1193250,1,'55e229de-b332-4d3e-8efe-a55c0f35c7d0','0e4353ac-d554-48cc-bee4-fa16af1552f7'),
('93337a81-2911-4984-b323-ba52ae1165d8','anonymousUser','2025-03-10 22:15:48.493401',1,'anonymousUser','2025-03-10 22:15:48.493401',8315750,1,'ba627644-d99b-4736-baf2-9a6d569bc48e','1a33f67d-7bda-422e-be33-9d5c2a3c600a'),
('940d28db-2f66-4823-999e-0be4c6eaa1ed','anonymousUser','2025-03-04 21:36:36.199791',1,'anonymousUser','2025-03-04 21:36:36.199791',3032000,1,'4b5aafa4-4f82-4b2d-bb05-fc5a51ab6048','387bf7c9-0173-4976-be07-f1ba43845092'),
('94d4471c-015e-494e-8797-c93da9223e91','anonymousUser','2025-03-25 19:08:50.808301',1,'anonymousUser','2025-03-25 19:08:50.808301',2421000,1,'153d727b-ac41-4b81-8ae3-9eea1db10320','ed919e14-5063-4b42-bcee-6c881db5d21c'),
('96997762-2691-46d0-9692-a7fdfc99bd1c','anonymousUser','2025-03-17 01:19:34.869762',1,'anonymousUser','2025-03-17 01:19:34.869762',3861000,5,'a507c215-88f4-480f-acaf-90287bf77c97','ff7a2db9-ade5-431b-96da-de04db3ba72a'),
('9825c6c9-ac05-40b1-8932-4315c2c6fd0f','anonymousUser','2025-03-03 20:23:06.930424',1,'anonymousUser','2025-03-03 20:23:06.930424',24990000,1,'24c323af-7ef6-42e1-9129-321fe4d52c4f','349c97b3-d00f-4afd-ab38-899e3b1bd15b'),
('99ae33c3-4d53-4bc6-8e79-98e09d2498ab','anonymousUser','2025-03-15 10:10:16.563739',1,'anonymousUser','2025-03-15 10:10:16.563739',19415750,1,'0607b94f-8561-484f-a8ae-ea0cdb846308','53622008-8cea-4304-a861-2e32869c0c45'),
('9b02de38-1a92-4a75-824a-f13eb984a550','anonymousUser','2025-03-09 19:37:40.418979',1,'anonymousUser','2025-03-09 19:37:40.418979',2152000,1,'29e0ae88-dd5b-4e74-8163-6a9bfaa8beea','ed919e14-5063-4b42-bcee-6c881db5d21c'),
('9b04c37b-3853-4240-bb51-a88b90fe1dff','anonymousUser','2025-03-12 01:30:32.770578',1,'anonymousUser','2025-03-12 01:30:32.770578',20340750,1,'0d1d4739-45f4-488a-8fd8-994e08fede5f','71ab414c-9228-430a-a356-523fefcf3691'),
('9f3122cd-10fa-45ad-a5f1-2b36bae9ea92','anonymousUser','2025-03-16 00:07:43.172476',1,'anonymousUser','2025-03-16 00:07:43.172476',3228250,1,'d6d7ce82-ef4f-463a-aa9b-066a4e94bb12','74efbec6-3bfa-4745-ad2a-f0c7a7ebddcf'),
('9ff9713c-2d56-4f0f-ae4f-37628fb03722','anonymousUser','2025-03-15 10:18:28.537144',1,'anonymousUser','2025-03-15 10:18:28.537144',13591500,2,'a271e378-461a-41bd-95d1-aebb1c202ad4','148f186c-acc4-4f5d-b802-80e2a1aed04c'),
('a2a187a1-0ba9-41d0-8fb1-0abf57c265e2','anonymousUser','2025-03-16 16:43:15.353107',1,'anonymousUser','2025-03-16 16:43:15.353107',2421000,2,'813cb0da-da71-482d-bf5d-f42cd58be122','ed919e14-5063-4b42-bcee-6c881db5d21c'),
('a3df478a-7f20-4258-9995-e54591e7d1a4','anonymousUser','2025-03-16 00:07:43.171600',1,'anonymousUser','2025-03-16 00:07:43.171600',4761000,1,'d6d7ce82-ef4f-463a-aa9b-066a4e94bb12','5b786e42-97b0-4cd9-9234-9d77160ab555'),
('a4058143-5a1e-4c0c-bb30-262d10c79b5c','anonymousUser','2025-03-16 16:40:36.203830',1,'anonymousUser','2025-03-16 16:40:36.203830',2421000,1,'71834902-fffa-426a-be67-21764f063146','ed919e14-5063-4b42-bcee-6c881db5d21c'),
('a4bf2b95-07b0-4820-a2ed-ece6af63ba97','anonymousUser','2025-03-04 22:03:20.824553',1,'anonymousUser','2025-03-04 22:03:20.824553',26392000,1,'07ca77b8-e32a-462f-a97a-424b88b695c0','eadecf1a-53dd-4460-a0ed-4d175a2b000a'),
('a50f5527-a240-42d0-b4e0-07a006761b71','anonymousUser','2025-03-25 19:10:04.145878',1,'anonymousUser','2025-03-25 19:10:04.145878',2421000,1,'65487212-a442-49aa-99dc-9aa0ca08c0a2','ed919e14-5063-4b42-bcee-6c881db5d21c'),
('a58471cd-4cbe-4d71-be4a-b4fb394484ab','anonymousUser','2025-03-09 15:28:24.377562',1,'anonymousUser','2025-03-09 15:28:24.377562',26000000,1,'7b4bdf68-adb4-47c3-9245-64c620d29d13','5e2a4f52-906c-4cf8-9ec4-a559524e0879'),
('a74feb3f-fb6f-463d-9c02-f36035624f40','anonymousUser','2025-03-15 10:18:28.537756',1,'anonymousUser','2025-03-15 10:18:28.537756',46741500,1,'a271e378-461a-41bd-95d1-aebb1c202ad4','80b4f151-0089-4dd9-a239-5eb61d09bfb7'),
('a7eae334-a670-4bb7-b0ec-dbb7d690a4f4','anonymousUser','2025-03-04 22:06:56.773361',1,'anonymousUser','2025-03-04 22:06:56.773361',3032000,2,'42778028-1f3c-4b82-aba0-fc0adbb700e7','387bf7c9-0173-4976-be07-f1ba43845092'),
('a83f82c6-5db9-4fd6-9c63-c442c435ee62','anonymousUser','2025-03-07 15:11:39.099393',1,'anonymousUser','2025-03-07 15:11:39.099393',3968250,1,'80474789-5dce-4413-b66f-cc05a4845277','fcaf6f68-f963-4dce-af8f-c524767834ea'),
('a872f409-414f-4ba7-9390-6227eea62d4c','anonymousUser','2025-03-25 19:08:34.994469',1,'anonymousUser','2025-03-25 19:08:34.994469',4041000,1,'e3bceadf-990f-4b8a-b688-d4e90bc0eabf','f75b73a8-353b-4412-8e85-040e376e94e5'),
('a8cbef93-a719-40c3-b6b8-6f4ac2495fb4','anonymousUser','2025-04-04 16:29:10.579971',1,'anonymousUser','2025-04-04 16:29:10.579971',2421000,1,'23872424-6493-4e66-91b8-3044778d31fc','ed919e14-5063-4b42-bcee-6c881db5d21c'),
('ab5aefba-222d-4892-8e73-86474eeceef0','anonymousUser','2025-03-25 19:08:51.821049',1,'anonymousUser','2025-03-25 19:08:51.821049',2421000,1,'91b62b4b-f765-4f9c-b403-0ff3bc0778aa','ed919e14-5063-4b42-bcee-6c881db5d21c'),
('ad0386a3-33ae-42c3-96fe-4e6afa68d7bb','anonymousUser','2025-03-05 21:18:11.783611',1,'anonymousUser','2025-03-05 21:18:11.783611',2152000,1,'ccb9f305-0387-47df-a66e-8f0a9982175a','ed919e14-5063-4b42-bcee-6c881db5d21c'),
('af562fd1-0bc8-4774-85df-fc4a8a1decb7','anonymousUser','2025-03-21 15:58:32.531259',1,'anonymousUser','2025-03-21 15:58:32.531259',3690750,2,'cf6cf86b-5145-460c-84ad-daa58da5f436','b5e3fe75-5fd3-451a-bf1d-4a212d14fa8a'),
('b0a514d1-d0f5-48c1-aec7-343a9e438b28','mthong@gmail.com','2025-03-25 19:43:33.070503',1,'mthong@gmail.com','2025-03-25 19:43:33.070503',1290000,10,'467d8eb7-00c3-4143-acf7-03cfa57a3ff1','c873e3c6-4459-4134-9ea8-a5163db96242'),
('b0d38544-f0c4-4eea-9dae-3738fece1453','anonymousUser','2025-03-15 10:18:28.538308',1,'anonymousUser','2025-03-15 10:18:28.538308',28041500,1,'a271e378-461a-41bd-95d1-aebb1c202ad4','4f688179-ba15-4207-a3a9-bc00f5cb9b69'),
('b0e14973-f55a-4429-a5c9-8a056752d8d6','anonymousUser','2025-03-04 22:03:20.824553',1,'anonymousUser','2025-03-04 22:03:20.824553',19992000,1,'07ca77b8-e32a-462f-a97a-424b88b695c0','349c97b3-d00f-4afd-ab38-899e3b1bd15b'),
('b1b45cd5-3e05-48eb-9859-96d4bdafd161','anonymousUser','2025-03-09 14:34:38.341046',1,'anonymousUser','2025-03-09 14:34:38.341046',17592000,1,'7b997171-c1c4-4b3e-888d-ae9617f63995','71ab414c-9228-430a-a356-523fefcf3691'),
('b2d5af48-d3d2-4d30-85ec-ada79428253d','anonymousUser','2025-03-09 19:35:18.962587',1,'anonymousUser','2025-03-09 19:35:18.962587',26000000,2,'cbabaaa4-2f8a-4927-8212-6854f4b89817','5e2a4f52-906c-4cf8-9ec4-a559524e0879'),
('b5690437-97d5-42fe-bc98-db01adf80b78','anonymousUser','2025-03-07 15:13:30.099574',1,'anonymousUser','2025-03-07 15:13:30.099574',26392000,1,'47d1bf4b-6574-498c-ab8c-db018469fb7a','eadecf1a-53dd-4460-a0ed-4d175a2b000a'),
('b59b2758-2a6d-4f33-ac21-c63ecd89ddd7','anonymousUser','2025-03-21 18:37:55.886494',1,'anonymousUser','2025-03-21 18:37:55.886494',29250000,1,'881e778a-2eeb-4eba-af27-3743a16eaf29','5e2a4f52-906c-4cf8-9ec4-a559524e0879'),
('b60258d2-25aa-47ab-8fa8-a723497a1a58','mthong@gmail.com','2025-03-25 19:37:57.154171',1,'mthong@gmail.com','2025-03-25 19:37:57.154171',2590000,5,'6d6cc7bb-e4cd-4251-9e8b-f4d9ab5ef932','9a0aae00-5dfa-4c86-8f85-4f62faeec6cf'),
('b759dde5-3778-44d8-b81c-2df2309bfd16','anonymousUser','2025-03-09 19:35:18.960584',1,'anonymousUser','2025-03-09 19:35:18.960584',1193250,1,'cbabaaa4-2f8a-4927-8212-6854f4b89817','0e4353ac-d554-48cc-bee4-fa16af1552f7'),
('b9892b14-4bf9-4d86-b20a-69a8791edeb3','anonymousUser','2025-03-16 16:30:54.001294',1,'anonymousUser','2025-03-16 16:30:54.001294',2421000,5,'b8d815e8-b00f-4a7e-a4d7-cd9257ef7fe1','ed919e14-5063-4b42-bcee-6c881db5d21c'),
('bca8039f-12e2-44d2-8a35-aa54415e2924','anonymousUser','2025-03-25 19:08:33.073310',1,'anonymousUser','2025-03-25 19:08:33.073310',7390750,1,'fd69486f-369e-4d8f-9a8f-1c9cf0eece74','1a71e553-885e-44bc-9927-648731ea0962'),
('bd480ae8-8b52-477e-8312-968222765190','anonymousUser','2025-03-08 02:08:52.625025',1,'anonymousUser','2025-03-08 02:08:52.625025',1193250,1,'319b11c3-d290-492d-b99d-e5ce67e37fa4','0e4353ac-d554-48cc-bee4-fa16af1552f7'),
('bdda6a8a-bfda-4a9b-bb90-c4ff3e4fdcfe','anonymousUser','2025-03-07 13:58:50.034580',1,'anonymousUser','2025-03-07 13:58:50.034580',16792000,1,'20cf20a7-8067-4e21-9011-e21e2efd3124','53622008-8cea-4304-a861-2e32869c0c45'),
('bdda9dd2-d0e4-4152-bd29-c45f989cffd8','anonymousUser','2025-03-15 10:18:28.537756',1,'anonymousUser','2025-03-15 10:18:28.537756',7390750,2,'a271e378-461a-41bd-95d1-aebb1c202ad4','1a71e553-885e-44bc-9927-648731ea0962'),
('be0bb481-2c73-4941-92f6-31230d634187','anonymousUser','2025-03-10 22:14:37.463309',1,'anonymousUser','2025-03-10 22:14:37.463309',1193250,1,'3022bac5-837f-4c04-83db-9577ce92071d','0e4353ac-d554-48cc-bee4-fa16af1552f7'),
('bf779a4f-43da-4a7f-9931-8425f5c4825b','anonymousUser','2025-03-17 01:23:57.628354',1,'anonymousUser','2025-03-17 01:23:57.628354',2961000,5,'6f772e57-c137-4172-8b3f-f65d23513aae','c4a9d42f-71a1-4c20-86e8-4c21e3469e6f'),
('c0c6cc6a-845b-4897-ac26-f5dbd6325ab1','anonymousUser','2025-03-25 18:57:39.242705',1,'anonymousUser','2025-03-25 18:57:39.242705',4491000,1,'c3ae3d84-6f5c-44c9-a58d-cd8f5a4a0c13','1ba152b2-c6be-4760-85eb-2ac641181afe'),
('c57fc74e-b17d-42db-8655-f5f3e94856b1','anonymousUser','2025-03-16 00:07:43.168581',1,'anonymousUser','2025-03-16 00:07:43.168581',8490000,2,'d6d7ce82-ef4f-463a-aa9b-066a4e94bb12','6beb1cca-0011-4142-9dad-10c12e24c3a6'),
('c6a3f469-9a00-4162-939b-5463015cbb23','anonymousUser','2025-03-15 10:18:28.536569',1,'anonymousUser','2025-03-15 10:18:28.536569',20340750,1,'a271e378-461a-41bd-95d1-aebb1c202ad4','71ab414c-9228-430a-a356-523fefcf3691'),
('c6f79c2e-2681-4041-8555-a735843da22b','anonymousUser','2025-03-04 22:02:05.565182',1,'anonymousUser','2025-03-04 22:02:05.565182',19992000,1,'257b8e94-106e-444e-b42a-21372b173a12','349c97b3-d00f-4afd-ab38-899e3b1bd15b'),
('c997e82d-115a-49d8-b2e1-328befc2cc66','anonymousUser','2025-03-25 19:08:33.073310',1,'anonymousUser','2025-03-25 19:08:33.073310',2421000,1,'fd69486f-369e-4d8f-9a8f-1c9cf0eece74','ed919e14-5063-4b42-bcee-6c881db5d21c'),
('cbcf4f7b-eb33-4971-99aa-f0dd7e124cff','anonymousUser','2025-03-08 02:02:10.062003',1,'anonymousUser','2025-03-08 02:02:10.062003',1193250,1,'ce5cd10e-0f9a-4764-aa72-38a97d6e6729','0e4353ac-d554-48cc-bee4-fa16af1552f7'),
('cc201725-09de-4808-adb8-5d5680105742','anonymousUser','2025-03-11 08:57:02.162072',1,'anonymousUser','2025-03-11 08:57:02.162072',20340750,5,'daf27e75-7fe6-451e-ac4e-85692f25832c','71ab414c-9228-430a-a356-523fefcf3691'),
('ce5019ce-9a8a-4167-9142-54af8f02ef9d','anonymousUser','2025-03-09 19:35:18.961587',1,'anonymousUser','2025-03-09 19:35:18.961587',16792000,1,'cbabaaa4-2f8a-4927-8212-6854f4b89817','53622008-8cea-4304-a861-2e32869c0c45'),
('cf134079-9aa7-43ff-a730-029aaaa50518','mthong@gmail.com','2025-03-25 19:43:33.070503',1,'mthong@gmail.com','2025-03-25 19:43:33.070503',3505750,3,'467d8eb7-00c3-4143-acf7-03cfa57a3ff1','cd38996d-e369-424f-bbb0-93c6ece6280a'),
('d0bf6f56-60ae-4cba-a8e7-3ef123a4d1f0','anonymousUser','2025-03-24 09:38:08.853844',1,'anonymousUser','2025-03-24 09:38:08.853844',11691000,1,'553105ae-25c3-4b47-93a4-32d4883282fb','7257ecd7-5ae9-4d99-bb31-b0aa99617451'),
('d342481a-5081-41f8-8479-2881cfc43d95','anonymousUser','2025-03-10 22:14:37.463309',1,'anonymousUser','2025-03-10 22:14:37.463309',19415750,1,'3022bac5-837f-4c04-83db-9577ce92071d','53622008-8cea-4304-a861-2e32869c0c45'),
('d5f5b7d9-60b6-47b3-8b6b-daaf5cc78ac7','anonymousUser','2025-03-06 17:44:40.314888',1,'anonymousUser','2025-03-06 17:44:40.314888',2152000,10,'2dfcf01d-44bf-483b-b750-531d427e7820','ed919e14-5063-4b42-bcee-6c881db5d21c'),
('d6210f68-ce34-4a4e-84c2-e8b1125f6f52','anonymousUser','2025-03-25 19:15:50.499710',1,'anonymousUser','2025-03-25 19:15:50.499710',11891500,1,'0ac21b13-b92f-4beb-9546-b9e564dee328','ed9ef5ce-5cb6-4672-8a87-0f112214098c'),
('d6614b21-535b-4563-a748-d17717e961bf','anonymousUser','2025-03-04 21:32:43.434464',1,'anonymousUser','2025-03-04 21:32:43.434464',19992000,1,'e835aac9-9f63-4a32-a0ad-78e6be2b4e50','349c97b3-d00f-4afd-ab38-899e3b1bd15b'),
('d7eda5f7-d06f-416e-9258-aa49db70cd48','anonymousUser','2025-03-25 13:54:09.130321',1,'anonymousUser','2025-03-25 13:54:09.130321',4041000,2,'3235056a-dbe6-4176-8d87-0aff005d2c58','f75b73a8-353b-4412-8e85-040e376e94e5'),
('da8c75c6-53c9-46a0-b253-cbe06a8cff37','anonymousUser','2025-03-25 19:08:42.330234',1,'anonymousUser','2025-03-25 19:08:42.330234',4041000,1,'e3a48e41-4d16-4b80-b129-30191d3ed54c','f75b73a8-353b-4412-8e85-040e376e94e5'),
('da9ef7b8-c6bc-4140-ad09-4c188d12d3dd','anonymousUser','2025-03-25 19:08:34.994469',1,'anonymousUser','2025-03-25 19:08:34.994469',2421000,1,'e3bceadf-990f-4b8a-b688-d4e90bc0eabf','ed919e14-5063-4b42-bcee-6c881db5d21c'),
('dadf1790-ca6d-417b-bc75-a394d6a5d470','anonymousUser','2025-03-06 17:23:27.090645',1,'anonymousUser','2025-03-06 17:23:27.090645',3032000,1,'05f12696-9528-4431-951e-11bb3f74ce2c','387bf7c9-0173-4976-be07-f1ba43845092'),
('deb37479-bdce-4662-8085-e5bd848c1ba1','anonymousUser','2025-03-09 23:34:26.389666',1,'anonymousUser','2025-03-09 23:34:26.389666',2765750,1,'72412cdb-063f-4af9-9824-e7749fabee82','16f1cf00-9b54-49df-b0a8-9935877ecad9'),
('def5d54f-4250-4a59-9649-66b620507be0','anonymousUser','2025-03-25 19:10:04.145312',1,'anonymousUser','2025-03-25 19:10:04.145312',29691000,1,'65487212-a442-49aa-99dc-9aa0ca08c0a2','eadecf1a-53dd-4460-a0ed-4d175a2b000a'),
('df02ac24-0fc8-490a-9f3c-c7994ee58a6d','anonymousUser','2025-03-08 18:08:36.454563',1,'anonymousUser','2025-03-08 18:08:36.454563',16792000,1,'55e229de-b332-4d3e-8efe-a55c0f35c7d0','53622008-8cea-4304-a861-2e32869c0c45'),
('e1d8f121-8a5c-46ef-83be-8aa3cba11283','anonymousUser','2025-03-09 19:42:54.334404',1,'anonymousUser','2025-03-09 19:42:54.334404',11090750,1,'5e118451-413f-4c1b-9236-b4e91879d999','04bb4b23-8316-45f5-8534-6766fbca71d1'),
('e238e368-26c9-48c1-b015-ff66c2c94c6f','anonymousUser','2025-04-04 16:29:10.581964',1,'anonymousUser','2025-04-04 16:29:10.581964',21241500,1,'23872424-6493-4e66-91b8-3044778d31fc','af3a0e21-1a61-46a0-82b7-cf4697249c07'),
('e493643b-d8b8-4431-9f0b-720402576996','anonymousUser','2025-04-04 16:29:10.578965',1,'anonymousUser','2025-04-04 16:29:10.578965',19415750,1,'23872424-6493-4e66-91b8-3044778d31fc','53622008-8cea-4304-a861-2e32869c0c45'),
('e7577d0a-897d-4857-980b-970e8cbe113f','anonymousUser','2025-03-09 15:30:02.299751',1,'anonymousUser','2025-03-09 15:30:02.299751',2152000,1,'796ca1af-cdeb-4ff0-87da-be0017be7372','ed919e14-5063-4b42-bcee-6c881db5d21c'),
('e97e3be4-734b-4177-8529-8e0021b79b33','anonymousUser','2025-03-25 19:16:38.294751',1,'anonymousUser','2025-03-25 19:16:38.294751',13591500,1,'2aea30eb-324b-427c-b73f-3bf1c1bd5418','148f186c-acc4-4f5d-b802-80e2a1aed04c'),
('eca06097-489b-4ef5-95f3-4c9ccea56e1e','anonymousUser','2025-03-25 19:08:52.233662',1,'anonymousUser','2025-03-25 19:08:52.233662',2421000,1,'2858c7ae-96dd-40b2-961f-d76d11558239','ed919e14-5063-4b42-bcee-6c881db5d21c'),
('f0275bac-4b36-4b9a-898b-4bf2b2edd752','anonymousUser','2025-03-09 14:26:30.500830',1,'anonymousUser','2025-03-09 14:26:30.500830',17592000,2,'fe5d9afb-c0eb-4041-8ebb-e071b76b3ac5','71ab414c-9228-430a-a356-523fefcf3691'),
('f04ba270-674b-4366-b5b6-3459beed2eba','anonymousUser','2025-03-09 15:29:45.297327',1,'anonymousUser','2025-03-09 15:29:45.297327',19992000,1,'3c23df98-712d-4ee5-872f-a93d0e834317','349c97b3-d00f-4afd-ab38-899e3b1bd15b'),
('f07fd396-7712-4b9d-97a6-35433447ce42','anonymousUser','2025-03-09 19:52:37.417217',1,'anonymousUser','2025-03-09 19:52:37.417217',26000000,1,'23bc7c49-87f0-404d-a5b2-4c7487c54728','5e2a4f52-906c-4cf8-9ec4-a559524e0879'),
('f0b48462-2490-4cbf-8d28-cf0047cf21ad','anonymousUser','2025-03-16 16:31:11.656077',1,'anonymousUser','2025-03-16 16:31:11.656077',2421000,1,'45aa6ec0-75bd-49c8-a093-76814e829e1d','ed919e14-5063-4b42-bcee-6c881db5d21c'),
('f13e30d3-00f1-496b-809d-a18524827a8a','anonymousUser','2025-03-24 09:32:49.356631',1,'anonymousUser','2025-03-24 09:32:49.356631',26091000,1,'71397f90-0e81-4f7e-aabb-36263e6326ab','9d03cf1b-094c-4a09-b74f-7491540500ed'),
('f19c3c9f-c965-4230-8280-1cf0b57c3536','anonymousUser','2025-03-12 20:43:24.392792',1,'anonymousUser','2025-03-12 20:43:24.392792',3592000,1,'1b22190c-8523-4671-8045-d6b667b5dc40','f75b73a8-353b-4412-8e85-040e376e94e5'),
('f2a6c6e5-2314-45b9-b76e-17ad902fefed','anonymousUser','2025-03-09 15:29:14.964810',1,'anonymousUser','2025-03-09 15:29:14.964810',16792000,1,'324e039f-5a61-44dc-8771-2bba0b366854','53622008-8cea-4304-a861-2e32869c0c45'),
('f2d283e3-6449-4c2f-99f6-df06d6c256b5','anonymousUser','2025-03-09 15:29:28.177502',1,'anonymousUser','2025-03-09 15:29:28.177502',1193250,1,'e75ddfc1-588a-4072-a1e0-ad882cf3929f','0e4353ac-d554-48cc-bee4-fa16af1552f7'),
('f3832454-4263-45af-be69-a10712321e38','anonymousUser','2025-03-25 19:08:51.821049',1,'anonymousUser','2025-03-25 19:08:51.821049',7390750,1,'91b62b4b-f765-4f9c-b403-0ff3bc0778aa','1a71e553-885e-44bc-9927-648731ea0962'),
('f426b5e5-db88-4232-9511-1a97be068a46','anonymousUser','2025-03-25 19:08:52.233662',1,'anonymousUser','2025-03-25 19:08:52.233662',7390750,1,'2858c7ae-96dd-40b2-961f-d76d11558239','1a71e553-885e-44bc-9927-648731ea0962'),
('f44c733b-a2f4-4940-8b4e-71c64a6572a9','anonymousUser','2025-03-04 21:36:36.199791',1,'anonymousUser','2025-03-04 21:36:36.199791',1193250,1,'4b5aafa4-4f82-4b2d-bb05-fc5a51ab6048','0e4353ac-d554-48cc-bee4-fa16af1552f7'),
('f5d5053c-0bd2-4369-9b26-2067b24fe3fe','anonymousUser','2025-03-09 15:28:54.311359',1,'anonymousUser','2025-03-09 15:28:54.311359',17592000,1,'dbc0a2d3-bea1-4d66-a880-3262222616e7','71ab414c-9228-430a-a356-523fefcf3691'),
('f6a039b2-e3ac-4573-9f7f-8d8957fde35d','anonymousUser','2025-03-16 00:07:43.174619',1,'anonymousUser','2025-03-16 00:07:43.174619',1840750,1,'d6d7ce82-ef4f-463a-aa9b-066a4e94bb12','e4369512-d437-4cf0-9bbd-c4e6fc7829fe'),
('f9aff891-a5ec-46af-830f-23b5a726a9b7','anonymousUser','2025-03-04 22:01:29.022399',1,'anonymousUser','2025-03-04 22:01:29.022399',1193250,1,'dc295f9a-de97-4def-b543-5801f98d9169','0e4353ac-d554-48cc-bee4-fa16af1552f7'),
('fa3dae8f-8568-4c0f-ba20-95acb8071a9e','anonymousUser','2025-03-25 19:08:51.480682',1,'anonymousUser','2025-03-25 19:08:51.480682',7390750,1,'dba784cb-2bfe-4979-9644-780f161d6686','1a71e553-885e-44bc-9927-648731ea0962'),
('fa82d303-0cf8-44dd-90fa-332347bbc1bf','anonymousUser','2025-03-12 01:33:42.390701',1,'anonymousUser','2025-03-12 01:33:42.390701',19415750,1,'9df644c2-4fb3-41b1-aac5-205539c77bde','53622008-8cea-4304-a861-2e32869c0c45'),
('faeda1b0-e50f-4122-81a3-df3c357bfbd3','anonymousUser','2025-03-09 15:32:52.226822',1,'anonymousUser','2025-03-09 15:32:52.226822',3968250,1,'eb131799-f54b-4cd5-b0e8-3e2bffb6fab4','fcaf6f68-f963-4dce-af8f-c524767834ea'),
('fc6ede6c-d3ea-432e-ac37-557bed2f8c98','anonymousUser','2025-03-09 17:18:27.437135',1,'anonymousUser','2025-03-09 17:18:27.437135',26000000,1,'4ee0d4c7-cf44-4dda-a09f-52e7155d5190','5e2a4f52-906c-4cf8-9ec4-a559524e0879'),
('fdb4fae6-e410-41cc-87b7-cbf69548a14a','anonymousUser','2025-03-15 10:18:28.537144',1,'anonymousUser','2025-03-15 10:18:28.537144',3505750,1,'a271e378-461a-41bd-95d1-aebb1c202ad4','cd38996d-e369-424f-bbb0-93c6ece6280a'),
('ff22065c-1f32-4067-ba26-65f152226277','anonymousUser','2025-03-04 22:02:05.565182',1,'anonymousUser','2025-03-04 22:02:05.565182',26392000,2,'257b8e94-106e-444e-b42a-21372b173a12','eadecf1a-53dd-4460-a0ed-4d175a2b000a');
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permission` (
  `id` varchar(36) NOT NULL,
  `code` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_active` tinyint NOT NULL,
  `createddate` datetime(6) DEFAULT NULL,
  `modifieddate` datetime(6) DEFAULT NULL,
  `createdby` varchar(255) DEFAULT NULL,
  `modifiedby` varchar(255) DEFAULT NULL,
  `sort_order` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKa7ujv987la0i7a0o91ueevchc` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission`
--

LOCK TABLES `permission` WRITE;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;
INSERT INTO `permission` VALUES ('004ed0bc-77f0-4f93-a0a2-a3fde7876a45','CUD_CATEGORY_SUPPLIER','Thêm, sửa, xóa danh mục, nhà cung cấp',1,NULL,NULL,NULL,NULL,3),
('135e804e-96d8-4277-b4db-6e80a5aac2d8','CUD_DISCOUNT','Thêm mã giảm giá cho sản phẩm',1,NULL,NULL,NULL,NULL,5),
('32467d71-c742-4635-a534-e7697ec8273d','RUD_ORDER','Xem, sửa, hủy order',1,NULL,NULL,NULL,NULL,7),
('5ffc3ccb-e554-4793-b308-f7efef403bbb','CUD_PRODUCT','Thêm, sửa, xóa sản phẩm',1,NULL,NULL,NULL,NULL,4),
('7c6ef485-d953-48c1-9d64-3187b1dff00d','RU_USER','Xem, sửa tài khoản',1,NULL,NULL,NULL,NULL,1),
('aa9e9619-1e50-46ed-9a57-707ac83a052e','RUD_ADDRESS','Xem, sửa, xóa address',1,NULL,NULL,NULL,NULL,2),
('d6b15258-983f-47b7-ba9b-8400adfd6184','RU_CONTACT','Đọc contact',1,NULL,NULL,NULL,NULL,8),
('f15f8989-6cd5-4f89-95c3-778b7f790bcf','CRU_RECEIPT','Xem, thêm, sửa nhập kho phiếu',1,NULL,NULL,NULL,NULL,6);
/*!40000 ALTER TABLE `permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` varchar(36) NOT NULL,
  `createdby` varchar(255) DEFAULT NULL,
  `createddate` datetime(6) DEFAULT NULL,
  `is_active` tinyint NOT NULL,
  `modifiedby` varchar(255) DEFAULT NULL,
  `modifieddate` datetime(6) DEFAULT NULL,
  `code` varchar(255) NOT NULL,
  `description` text,
  `name` varchar(255) NOT NULL,
  `price` bigint NOT NULL,
  `category_id` varchar(36) DEFAULT NULL,
  `point` double NOT NULL,
  `inventory_quantity` int NOT NULL,
  `supplier_id` varchar(36) DEFAULT NULL,
  `sold_quantity` int DEFAULT NULL,
  `discount_price` bigint DEFAULT NULL,
  `discount_id` varchar(36) DEFAULT NULL,
  `avg_rating` double NOT NULL,
  `review_count` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKh3w5r1mx6d0e5c6um32dgyjej` (`code`),
  KEY `FK1mtsbur82frn64de7balymq9s` (`category_id`),
  KEY `FK2kxvbr72tmtscjvyp9yqb12by` (`supplier_id`),
  KEY `FKps2e0q9jpd0i9kj83je4rsmf1` (`discount_id`),
  CONSTRAINT `FK1mtsbur82frn64de7balymq9s` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FK2kxvbr72tmtscjvyp9yqb12by` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`),
  CONSTRAINT `FKps2e0q9jpd0i9kj83je4rsmf1` FOREIGN KEY (`discount_id`) REFERENCES `discount` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES 
-- 
-- Rau ăn lá
--
('04b55b23-8316-45f5-8534-6766fbca6132','dotuandat2004nd@gmail.com','2025-02-17 01:03:56.657456',1,'dotuandat2004nd@gmail.com','2025-03-16 00:11:44.185336','gen-tam-goi-toan-than-organic-elee-baby-250g','Thành phần: Aqua, Cocamidopropyl Betaine, Sorbitol, PEG-7 Glyceryl Cocoate, Glycerin, Polysorbate 80, Aloe Barbadensis Leaf Extract*, Carica Papaya Fruit Extract*, Parfum**. *Nguyên liệu đạt tiêu chuẩn Organic của EU và USDA.','Gel tắm gội toàn thân Organic Elee Baby 250g',250000,'02aefc7c-a1cf-49e0-ac6a-3da23e1f4131',0.2258,207,'b4c5d6e7-f8a9-4b0c-1d2e-4f5a6b7c8d9e',3, NULL, NULL, 2.5,0),
('06gf6a00-bf92-4e2b-8099-445dsfdggggf','admin@gmail.com','2025-03-22 13:39:50.448146',1,'dotuandat2004nd@gmail.com','2025-03-24 10:43:54.267612','gen-tam-goi-toan-than-organic-elee-fami-250g','* THÀNH PHẦN: COCOS NUCIFERA OIL, PAPAYA FRUIT FERMENT EXTRACT, BEESWAX, PARFUM * HƯỚNG DẪN SỬ DỤNG: – Bảo vệ da, làm mềm da, tăng cường độ ẩm và ngăn ngừa lão hóa cho da. – Dưỡng ẩm và làm mềm môi. – Làm mềm khi cạo rây và giảm kích ứng sau khi cạo râu. – Bảo vệ da sau khi tiếp xúc ánh nắng và dưỡng da sau khi tiếp xúc ánh nắng. * BẢO QUẢN: Nơi khô ráo thoáng mát * HẠN SỬ DỤNG: 1 năm kể từ ngày sản xuất. • Lưu ý: Sản phẩm có thể bị đông lại hoặc chảy ra khi nhiệt độ môi trường khắc nghiệt, tuy nhiên không ảnh hưởng đến chất lượng sản phẩm.* Nguyên liệu đạt tiêu chuẩn Organic của EU và USDA. ** Là tổ hợp mùi thơm của tinh dầu thiên nhiên','Gel bôi dưỡng da đu đủ Organic Elee Fami 250g',319000,'02aefc7c-a1cf-49e0-ac6a-3da23e1f4131',0,50,'b4c5d6e7-f8a9-4b0c-1d2e-4f5a6b7c8d9e',0,NULL,NULL,2.5,0),
-- Dalat Greens (10 bản ghi)
('04bb4b23-8316-45f5-8534-6766fbca71d1', 'dotuandat2004nd@gmail.com', '2025-05-24 15:15:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:15:00.000000', 'rau-muong-organic-300gr', 'Rau muống hữu cơ, giàu vitamin A, C, chất xơ. Bảo quản ở 4-8°C.', 'Rau muống Organic 300gr', 25000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.3, 150, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 5, NULL, NULL, 4.5, 2),
('06066a00-bf92-4e2b-8099-b834ca442e2c', 'admin@gmail.com', '2025-05-24 15:15:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:15:00.000000', 'cai-bap-organic-300gr', 'Cải bắp hữu cơ, tươi ngon, giàu vitamin K. Bảo quản nơi thoáng mát.', 'Cải bắp Organic 300gr', 28000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.4, 120, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 3, NULL, NULL, 4.0, 1),
('06789db5-ae7a-43a5-9398-89ce339d3c52', 'pesmobile5404@gmail.com', '2025-05-24 15:15:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:15:00.000000', 'xalach-organic-300gr', 'Xà lách hữu cơ, giòn, giàu chất xơ. Phù hợp cho salad.', 'Xà lách Organic 300gr', 30000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.5, 100, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 2, NULL, NULL, 4.8, 3),
('0cb1fccc-eb7b-4a58-8b4e-09d3dc1c7d4a', 'dotuandat2004nd@gmail.com', '2025-05-24 15:15:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:15:00.000000', 'rau-ngot-organic-300gr', 'Rau ngót hữu cơ, giàu vitamin C, tốt cho sức khỏe. Bảo quản lạnh.', 'Rau ngót Organic 300gr', 22000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.2, 180, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 8, NULL, NULL, 4.2, 4),
('0cea1533-4a29-49b1-9671-1c804661ab67', 'admin@gmail.com', '2025-05-24 15:15:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:15:00.000000', 'cai-bo-xoi-organic-300gr', 'Cải bó xôi hữu cơ, giàu sắt và vitamin A. Phù hợp cho sinh tố.', 'Cải bó xôi Organic 300gr', 35000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.6, 90, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 4, NULL, NULL, 4.7, 5),
('0e4353ac-d554-48cc-bee4-fa16af1552f7', 'dotuandat2004nd@gmail.com', '2025-05-24 15:15:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:15:00.000000', 'rau-den-do-organic-300gr', 'Rau dền đỏ hữu cơ, giàu chất chống oxy hóa. Bảo quản lạnh.', 'Rau dền đỏ Organic 300gr', 23000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.3, 160, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 6, NULL, NULL, 4.3, 2),
('110c1813-8460-4067-9d0b-f0b8656c3dfa', 'pesmobile5404@gmail.com', '2025-05-24 15:15:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:15:00.000000', 'cai-chip-organic-300gr', 'Cải chíp hữu cơ, ngọt, giòn, giàu vitamin C.', 'Cải chíp Organic 300gr', 26000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.4, 140, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 3, NULL, NULL, 4.6, 3),
('0ebf1a90-739d-49af-bf50-023441bbb245', 'admin@gmail.com', '2025-05-24 15:15:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:15:00.000000', 'rau-mui-organic-100gr', 'Rau mùi hữu cơ, thơm, giàu vitamin A. Phù hợp làm gia vị.', 'Rau mùi Organic 100gr', 15000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.1, 200, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 10, NULL, NULL, 4.0, 1),
('110c1813-8460-4067-9d0b-f0b8619c3dfa', 'dotuandat2004nd@gmail.com', '2025-05-24 15:15:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:15:00.000000', 'cai-xanh-mui-organic-300gr', 'Cải xanh mù tạt hữu cơ, vị cay nhẹ, giàu vitamin K.', 'Cải xanh mù tạt Organic 300gr', 27000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.4, 130, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 2, NULL, NULL, 4.5, 2),
('135861c7-fba7-4b28-9a3d-fed2093d33ca', 'pesmobile5404@gmail.com', '2025-05-24 15:15:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:15:00.000000', 'hung-lui-organic-100gr', 'Húng lủi hữu cơ, thơm, dùng làm gia vị hoặc ăn kèm.', 'Húng lủi Organic 100gr', 16000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.2, 190, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 7, NULL, NULL, 4.2, 3),
-- Organic Farm VN (10 bản ghi)
('rtertefr-5c6d-7e8f-9a0b-1c2d3e4f5a6b', 'admin@gmail.com', '2025-05-24 15:15:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:15:00.000000', 'rau-muong-vn-organic-300gr', 'Rau muống hữu cơ từ Organic Farm VN, giàu vitamin C.', 'Rau muống Organic VN 300gr', 24000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.3, 140, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 4, NULL, NULL, 4.4, 2),
('2f54fr5c-6d7e-8f9a-0b1c-2d3e4f5a6b7c', 'dotuandat2004nd@gmail.com', '2025-05-24 15:15:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:15:00.000000', 'cai-thia-vn-organic-300gr', 'Cải thìa hữu cơ, ngọt, giòn, giàu vitamin A.', 'Cải thìa Organic VN 300gr', 26000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.4, 110, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 3, NULL, NULL, 4.6, 3),
('3r65gc6d-7e8f-9a0b-1c2d-3e4f5a6b7c8d', 'pesmobile5404@gmail.com', '2025-05-24 15:15:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:15:00.000000', 'xalach-romaine-vn-organic-300gr', 'Xà lách Romaine hữu cơ, giòn, phù hợp salad.', 'Xà lách Romaine Organic VN 300gr', 32000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.5, 100, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 2, NULL, NULL, 4.7, 4),
('4b5c457e-8f9a-0b1c-2d3e-4f5a6b7c8d9e', 'dotuandat2004nd@gmail.com', '2025-05-24 15:15:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:15:00.000000', 'rau-ngot-vn-organic-300gr', 'Rau ngót hữu cơ, tươi ngon, giàu vitamin C.', 'Rau ngót Organic VN 300gr', 23000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.2, 170, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 6, NULL, NULL, 4.3, 2),
('5crt7e8f-9a0b-1c2d-3e4f-5a6b7c8d9e0f', 'admin@gmail.com', '2025-05-24 15:15:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:15:00.000000', 'cai-bo-xoi-vn-organic-300gr', 'Cải bó xôi hữu cơ, giàu sắt, tốt cho máu.', 'Cải bó xôi Organic VN 300gr', 34000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.6, 80, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 5, NULL, NULL, 4.8, 5),
('6757hfht-0b1c-2d3e-4f5a-6b7c8d9e0f1a', 'dotuandat2004nd@gmail.com', '2025-05-24 15:15:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:15:00.000000', 'rau-den-xanh-vn-organic-300gr', 'Rau dền xanh hữu cơ, giàu chất xơ, tốt cho tiêu hóa.', 'Rau dền xanh Organic VN 300gr', 22000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.3, 150, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 4, NULL, NULL, 4.4, 3),
('t5ry56ht-1c2d-3e4f-5a6b-7c8d9e0f1a2b', 'pesmobile5404@gmail.com', '2025-05-24 15:15:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:15:00.000000', 'cai-chip-vn-organic-300gr', 'Cải chíp hữu cơ, vị ngọt, giàu vitamin C.', 'Cải chíp Organic VN 300gr', 25000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.4, 130, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 3, NULL, NULL, 4.5, 2),
('re54gfre-2d3e-4f5a-6b7c-8d9e0f1a2b3c', 'admin@gmail.com', '2025-05-24 15:15:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:15:00.000000', 'rau-mui-vn-organic-100gr', 'Rau mùi hữu cơ, thơm, dùng làm gia vị.', 'Rau mùi Organic VN 100gr', 14000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.1, 190, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 8, NULL, NULL, 4.1, 1),
('ryr54yge-3e4f-5a6b-7c8d-9e0f1a2b3c4d', 'dotuandat2004nd@gmail.com', '2025-05-24 15:15:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:15:00.000000', 'cai-xanh-mui-vn-organic-300gr', 'Cải xanh mù tạt hữu cơ, vị cay nhẹ, giàu vitamin K.', 'Cải xanh mù tạt Organic VN 300gr', 26000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.4, 120, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 2, NULL, NULL, 4.6, 3),
('ret4re4g-4f5a-6b7c-8d9e-0f1a2b3c4d5e', 'pesmobile5404@gmail.com', '2025-05-24 15:15:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:15:00.000000', 'hung-que-vn-organic-100gr', 'Húng quế hữu cơ, thơm, dùng cho món Âu và Á.', 'Húng quế Organic VN 100gr', 15000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.2, 180, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 6, NULL, NULL, 4.3, 2),
-- Natural Farm (10 bản ghi)
('hgfhdvcd-5a6b-7c8d-9e0f-1a2b3c4d5e6f', 'admin@gmail.com', '2025-05-24 15:15:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:15:00.000000', 'rau-muong-natural-300gr', 'Rau muống từ Natural Farm, tươi ngon, giàu vitamin.', 'Rau muống Natural 300gr', 23000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.3, 160, 'c9d0e1f2-a3b4-4c5d-6e7f-9a0b1c2d3e4f', 5, NULL, NULL, 4.4, 2),
('ewrewfdc-6b7c-8d9e-0f1a-2b3c4d5e6f7a', 'dotuandat2004nd@gmail.com', '2025-05-24 15:15:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:15:00.000000', 'cai-thia-natural-300gr', 'Cải thìa từ Natural Farm, ngọt, giàu vitamin A.', 'Cải thìa Natural 300gr', 25000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.4, 110, 'c9d0e1f2-a3b4-4c5d-6e7f-9a0b1c2d3e4f', 3, NULL, NULL, 4.5, 3),
('sfsdcdsd-7c8d-9e0f-1a2b-3c4d5e6f7a8b', 'pesmobile5404@gmail.com', '2025-05-24 15:15:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:15:00.000000', 'xalach-lolo-natural-300gr', 'Xà lách lolo từ Natural Farm, giòn, phù hợp salad.', 'Xà lách Lolo Natural 300gr', 31000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.5, 100, 'c9d0e1f2-a3b4-4c5d-6e7f-9a0b1c2d3e4f', 2, NULL, NULL, 4.7, 4),
('dgsgdcdd-8d9e-0f1a-2b3c-4d5e6f7a8b9c', 'dotuandat2004nd@gmail.com', '2025-05-24 15:15:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:15:00.000000', 'rau-ngot-natural-300gr', 'Rau ngót từ Natural Farm, giàu vitamin C, tốt cho sức khỏe.', 'Rau ngót Natural 300gr', 22000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.2, 170, 'c9d0e1f2-a3b4-4c5d-6e7f-9a0b1c2d3e4f', 6, NULL, NULL, 4.3, 2),
('fdsfsdsd-9e0f-1a2b-3c4d-5e6f7a8b9c0d', 'admin@gmail.com', '2025-05-24 15:15:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:15:00.000000', 'cai-bo-xoi-natural-300gr', 'Cải bó xôi từ Natural Farm, giàu sắt, tốt cho máu.', 'Cải bó xôi Natural 300gr', 34000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.6, 80, 'c9d0e1f2-a3b4-4c5d-6e7f-9a0b1c2d3e4f', 5, NULL, NULL, 4.8, 5),
('dsfdgfdf-0f1a-2b3c-4d5e-6f7a8b9c0d1e', 'dotuandat2004nd@gmail.com', '2025-05-24 15:15:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:15:00.000000', 'rau-den-xanh-natural-300gr', 'Rau dền xanh từ Natural Farm, giàu chất xơ.', 'Rau dền xanh Natural 300gr', 22000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.3, 150, 'c9d0e1f2-a3b4-4c5d-6e7f-9a0b1c2d3e4f', 4, NULL, NULL, 4.4, 3),
('6456rter-1a2b-3c4d-5e6f-7a8b9c0d1e2f', 'pesmobile5404@gmail.com', '2025-05-24 15:15:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:15:00.000000', 'cai-chip-natural-300gr', 'Cải chíp từ Natural Farm, vị ngọt, giàu vitamin C.', 'Cải chíp Natural 300gr', 25000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.4, 130, 'c9d0e1f2-a3b4-4c5d-6e7f-9a0b1c2d3e4f', 3, NULL, NULL, 4.5, 2),
('ytryt546-2b3c-4d5e-6f7a-8b9c0d1e2f3a', 'admin@gmail.com', '2025-05-24 15:15:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:15:00.000000', 'rau-mui-natural-100gr', 'Rau mùi từ Natural Farm, thơm, dùng làm gia vị.', 'Rau mùi Natural 100gr', 14000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.1, 190, 'c9d0e1f2-a3b4-4c5d-6e7f-9a0b1c2d3e4f', 8, NULL, NULL, 4.1, 1),
('rreyt556-3c4d-5e6f-7a8b-9c0d1e2f3a4b', 'dotuandat2004nd@gmail.com', '2025-05-24 15:15:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:15:00.000000', 'cai-xanh-mui-natural-300gr', 'Cải xanh mù tạt từ Natural Farm, vị cay nhẹ.', 'Cải xanh mù tạt Natural 300gr', 26000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.4, 120, 'c9d0e1f2-a3b4-4c5d-6e7f-9a0b1c2d3e4f', 2, NULL, NULL, 4.6, 3),
('fgdf45rt-4d5e-6f7a-8b9c-0d1e2f3a4b5c', 'pesmobile5404@gmail.com', '2025-05-24 15:15:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:15:00.000000', 'hung-que-natural-100gr', 'Húng quế từ Natural Farm, thơm, dùng cho món Âu và Á.', 'Húng quế Natural 100gr', 15000, '0edeeec4-514e-4423-a95a-9e7e49fa9ed6', 0.2, 180, 'c9d0e1f2-a3b4-4c5d-6e7f-9a0b1c2d3e4f', 6, NULL, NULL, 4.3, 2),

--
-- Rau ăn quả
--
-- Dalat Greens (15 bản ghi)
('13fda409-9408-4831-ae22-f74e0775f80d', 'dotuandat2004nd@gmail.com', '2025-05-24 15:19:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:19:00.000000', 'ca-chua-organic-500gr', 'Cà chua hữu cơ từ Dalat Greens, giàu lycopene, tốt cho tim mạch. Bảo quản lạnh.', 'Cà chua Organic 500gr', 35000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.4, 150, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 5, NULL, NULL, 4.5, 3),
('148f186c-acc4-4f5d-b802-80e2a1aed04c', 'admin@gmail.com', '2025-05-24 15:19:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:19:00.000000', 'dua-leo-organic-500gr', 'Dưa leo hữu cơ, giòn, giàu nước, tốt cho da. Bảo quản nơi thoáng mát.', 'Dưa leo Organic 500gr', 30000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.3, 120, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 4, NULL, NULL, 4.3, 2),
('16f1cf00-9b54-49df-b0a8-9935877ecad9', 'pesmobile5404@gmail.com', '2025-05-24 15:19:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:19:00.000000', 'bi-xanh-organic-500gr', 'Bí xanh hữu cơ, ngọt, giàu chất xơ. Phù hợp nấu canh.', 'Bí xanh Organic 500gr', 28000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.3, 130, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 3, NULL, NULL, 4.4, 2),
('184b7e9b-7caf-48fd-9bd2-e4c404f77c4e', 'dotuandat2004nd@gmail.com', '2025-05-24 15:19:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:19:00.000000', 'bi-do-organic-500gr', 'Bí đỏ hữu cơ, giàu vitamin A, tốt cho mắt. Bảo quản nơi khô ráo.', 'Bí đỏ Organic 500gr', 32000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.4, 100, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 6, NULL, NULL, 4.6, 4),
('1a33f67d-7bda-422e-be33-9d5c2a3c600a', 'admin@gmail.com', '2025-05-24 15:19:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:19:00.000000', 'ot-chuong-organic-300gr', 'Ớt chuông hữu cơ, nhiều màu, giàu vitamin C. Phù hợp xào hoặc salad.', 'Ớt chuông Organic 300gr', 40000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.5, 90, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 2, NULL, NULL, 4.7, 3),
('1a71e553-885e-44bc-9927-648731ea0962', 'dotuandat2004nd@gmail.com', '2025-05-24 15:19:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:19:00.000000', 'ca-tim-organic-500gr', 'Cà tím hữu cơ, mềm, giàu chất xơ. Phù hợp nướng hoặc kho.', 'Cà tím Organic 500gr', 27000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.3, 140, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 5, NULL, NULL, 4.2, 1),
('1b03173d-e180-48e8-ac98-50fd52462d1f', 'pesmobile5404@gmail.com', '2025-05-24 15:19:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:19:00.000000', 'muop-organic-500gr', 'Mướp hữu cơ, ngọt, tốt cho tiêu hóa. Phù hợp nấu canh.', 'Mướp Organic 500gr', 25000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.3, 160, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 4, NULL, NULL, 4.3, 2),
('1b30f875-77c5-4f3e-af60-cdb09a1e2861', 'admin@gmail.com', '2025-05-24 15:19:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:19:00.000000', 'kho-qua-organic-500gr', 'Khổ qua hữu cơ, vị đắng, tốt cho máu. Bảo quản lạnh.', 'Khổ qua Organic 500gr', 30000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.4, 110, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 3, NULL, NULL, 4.5, 3),
('1b84e9ad-1652-4802-9394-5985583b9c00', 'dotuandat2004nd@gmail.com', '2025-05-24 15:19:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:19:00.000000', 'dau-bap-organic-300gr', 'Đậu bắp hữu cơ, giàu chất xơ, tốt cho tiêu hóa. Phù hợp luộc hoặc xào.', 'Đậu bắp Organic 300gr', 28000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.3, 130, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 6, NULL, NULL, 4.4, 2),
('1ba152b2-c6be-4760-85eb-2ac641181afe', 'pesmobile5404@gmail.com', '2025-05-24 15:19:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:19:00.000000', 'bap-cai-organic-1kg', 'Bắp cải hữu cơ, giòn, giàu vitamin K. Phù hợp làm salad.', 'Bắp cải Organic 1kg', 40000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.5, 80, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 2, NULL, NULL, 4.6, 4),
('1d5a4adf-d476-4690-a4a2-98906b6c7d7d', 'admin@gmail.com', '2025-05-24 15:19:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:19:00.000000', 'sup-lo-xanh-organic-500gr', 'Súp lơ xanh hữu cơ, giàu vitamin C, tốt cho sức khỏe. Bảo quản lạnh.', 'Súp lơ xanh Organic 500gr', 45000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.6, 70, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 3, NULL, NULL, 4.8, 5),
('1d9912ea-00bb-4b0e-beae-a702a8b5f4ed', 'dotuandat2004nd@gmail.com', '2025-05-24 15:19:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:19:00.000000', 'sup-lo-trang-organic-500gr', 'Súp lơ trắng hữu cơ, giòn, giàu chất xơ. Phù hợp hấp hoặc xào.', 'Súp lơ trắng Organic 500gr', 42000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.5, 90, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 4, NULL, NULL, 4.7, 3),
('1e1083a2-b6bc-474b-bc7c-ef2b4c7f8132', 'pesmobile5404@gmail.com', '2025-05-24 15:19:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:19:00.000000', 'ca-chua-bi-organic-500gr', 'Cà chua bi hữu cơ, ngọt, giàu lycopene. Phù hợp salad.', 'Cà chua bi Organic 500gr', 38000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.4, 100, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 5, NULL, NULL, 4.5, 2),
('1ed493f3-53bc-46d3-b1b4-2d90be4f22fe', 'admin@gmail.com', '2025-05-24 15:19:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:19:00.000000', 'ot-chuong-do-organic-300gr', 'Ớt chuông đỏ hữu cơ, ngọt, giàu vitamin A. Phù hợp xào.', 'Ớt chuông đỏ Organic 300gr', 42000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.5, 80, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 3, NULL, NULL, 4.6, 3),
('1fe36d28-4d4a-49f9-afe2-834a4ac5df9d', 'dotuandat2004nd@gmail.com', '2025-05-24 15:19:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:19:00.000000', 'dau-ve-organic-300gr', 'Đậu ve hữu cơ, giòn, giàu chất xơ. Phù hợp xào hoặc luộc.', 'Đậu ve Organic 300gr', 30000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.3, 110, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 4, NULL, NULL, 4.4, 2),
-- Organic Farm VN (15 bản ghi)
('ytrhdhgf-6c7d-8e9f-0a1b-2c3d4e5f6a7b', 'admin@gmail.com', '2025-05-24 15:19:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:19:00.000000', 'ca-chua-vn-organic-500gr', 'Cà chua hữu cơ từ Organic Farm VN, giàu lycopene, tốt cho sức khỏe.', 'Cà chua Organic VN 500gr', 34000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.4, 140, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 5, NULL, NULL, 4.5, 3),
('tretgfdg-7d8e-9f0a-1b2c-3d4e5f6a7b8c', 'dotuandat2004nd@gmail.com', '2025-05-24 15:19:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:19:00.000000', 'dua-leo-vn-organic-500gr', 'Dưa leo hữu cơ, giòn, giàu nước, tốt cho da.', 'Dưa leo Organic VN 500gr', 29000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.3, 130, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 4, NULL, NULL, 4.3, 2),
('hgfddfgf-8e9f-0a1b-2c3d-4e5f6a7b8c9d', 'pesmobile5404@gmail.com', '2025-05-24 15:19:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:19:00.000000', 'bi-xanh-vn-organic-500gr', 'Bí xanh hữu cơ, ngọt, giàu chất xơ. Phù hợp nấu canh.', 'Bí xanh Organic VN 500gr', 27000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.3, 120, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 3, NULL, NULL, 4.4, 2),
('fewfsdfs-9f0a-1b2c-3d4e-5f6a7b8c9d0e', 'dotuandat2004nd@gmail.com', '2025-05-24 15:19:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:19:00.000000', 'bi-do-vn-organic-500gr', 'Bí đỏ hữu cơ, giàu vitamin A, tốt cho mắt.', 'Bí đỏ Organic VN 500gr', 31000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.4, 100, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 6, NULL, NULL, 4.6, 4),
('fgdgregf-0a1b-2c3d-4e5f-6a7b8c9d0e1f', 'admin@gmail.com', '2025-05-24 15:19:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:19:00.000000', 'ot-chuong-vn-organic-300gr', 'Ớt chuông hữu cơ, nhiều màu, giàu vitamin C.', 'Ớt chuông Organic VN 300gr', 39000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.5, 90, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 2, NULL, NULL, 4.7, 3),
('gtregfdg-1b2c-3d4e-5f6a-7b8c9d0e1f2a', 'dotuandat2004nd@gmail.com', '2025-05-24 15:19:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:19:00.000000', 'ca-tim-vn-organic-500gr', 'Cà tím hữu cơ, mềm, giàu chất xơ. Phù hợp nướng.', 'Cà tím Organic VN 500gr', 26000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.3, 140, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 5, NULL, NULL, 4.2, 1),
('gdfgdgfd-2c3d-4e5f-6a7b-8c9d0e1f2a3b', 'pesmobile5404@gmail.com', '2025-05-24 15:19:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:19:00.000000', 'muop-vn-organic-500gr', 'Mướp hữu cơ, ngọt, tốt cho tiêu hóa.', 'Mướp Organic VN 500gr', 24000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.3, 160, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 4, NULL, NULL, 4.3, 2),
('gfdgdfgf-3d4e-5f6a-7b8c-9d0e1f2a3b4c', 'admin@gmail.com', '2025-05-24 15:19:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:19:00.000000', 'kho-qua-vn-organic-500gr', 'Khổ qua hữu cơ, vị đắng, tốt cho máu.', 'Khổ qua Organic VN 500gr', 29000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.4, 110, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 3, NULL, NULL, 4.5, 3),
('fdgdfghy-4e5f-6a7b-8c9d-0e1f2a3b4c5d', 'dotuandat2004nd@gmail.com', '2025-05-24 15:19:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:19:00.000000', 'dau-bap-vn-organic-300gr', 'Đậu bắp hữu cơ, giàu chất xơ, tốt cho tiêu hóa.', 'Đậu bắp Organic VN 300gr', 27000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.3, 130, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 6, NULL, NULL, 4.4, 2),
('gfdgdgdr-5f6a-7b8c-9d0e-1f2a3b4c5d6e', 'pesmobile5404@gmail.com', '2025-05-24 15:19:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:19:00.000000', 'bap-cai-vn-organic-1kg', 'Bắp cải hữu cơ, giòn, giàu vitamin K.', 'Bắp cải Organic VN 1kg', 39000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.5, 80, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 2, NULL, NULL, 4.6, 4),
('gfdgfdgd-6a7b-8c9d-0e1f-2a3b4c5d6e7f', 'admin@gmail.com', '2025-05-24 15:19:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:19:00.000000', 'sup-lo-xanh-vn-organic-500gr', 'Súp lơ xanh hữu cơ, giàu vitamin C, tốt cho sức khỏe.', 'Súp lơ xanh Organic VN 500gr', 44000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.6, 70, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 3, NULL, NULL, 4.8, 5),
('gfdgfrdf-7b8c-9d0e-1f2a-3b4c5d6e7f8a', 'dotuandat2004nd@gmail.com', '2025-05-24 15:19:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:19:00.000000', 'sup-lo-trang-vn-organic-500gr', 'Súp lơ trắng hữu cơ, giòn, giàu chất xơ.', 'Súp lơ trắng Organic VN 500gr', 41000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.5, 90, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 4, NULL, NULL, 4.7, 3),
('ewrewf45-8c9d-0e1f-2a3b-4c5d6e7f8a9b', 'pesmobile5404@gmail.com', '2025-05-24 15:19:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:19:00.000000', 'ca-chua-bi-vn-organic-500gr', 'Cà chua bi hữu cơ, ngọt, giàu lycopene.', 'Cà chua bi Organic VN 500gr', 37000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.4, 100, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 5, NULL, NULL, 4.5, 2),
('54fgr544-9d0e-1f2a-3b4c-5d6e7f8a9b0c', 'admin@gmail.com', '2025-05-24 15:19:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:19:00.000000', 'ot-chuong-do-vn-organic-300gr', 'Ớt chuông đỏ hữu cơ, ngọt, giàu vitamin A.', 'Ớt chuông đỏ Organic VN 300gr', 41000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.5, 80, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 3, NULL, NULL, 4.6, 3),
('456gfdrc-0e1f-2a3b-4c5d-6e7f8a9b0c1d', 'dotuandat2004nd@gmail.com', '2025-05-24 15:19:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:19:00.000000', 'dau-ve-vn-organic-300gr', 'Đậu ve hữu cơ, giòn, giàu chất xơ.', 'Đậu ve Organic VN 300gr', 29000, '1d2299b6-3783-46e0-b0dd-245542d26a4f', 0.3, 110, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 4, NULL, NULL, 4.4, 2),

--
-- Rau ăn củ
--
-- Dalat Greens (15 bản ghi)
('1a2b3c4d-5e6f-7a8b-9c0d-1e2f3a4b0c6d', 'dotuandat2004nd@gmail.com', '2025-05-24 15:34:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:34:00.000000', 'khoai-tay-organic-1kg', 'Khoai tây hữu cơ từ Dalat Greens, giàu tinh bột, tốt cho năng lượng. Bảo quản nơi khô ráo.', 'Khoai tây Organic 1kg', 35000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.4, 150, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 5, NULL, NULL, 4.5, 3),
('2b3c4d5e-6f7a-866c-0d1e-2f3a4b5c6d7e', 'admin@gmail.com', '2025-05-24 15:34:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:34:00.000000', 'ca-rot-organic-1kg', 'Cà rốt hữu cơ, giàu vitamin A, tốt cho mắt. Bảo quản lạnh.', 'Cà rốt Organic 1kg', 30000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.3, 120, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 4, NULL, NULL, 4.3, 2),
('3c4d5e6f-7a8b-934d-1e2f-3a4b5c6d7e8f', 'pesmobile5404@gmail.com', '2025-05-24 15:34:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:34:00.000000', 'cu-cai-trang-organic-1kg', 'Củ cải trắng hữu cơ, giòn, giàu vitamin C. Phù hợp nấu canh.', 'Củ cải trắng Organic 1kg', 25000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.3, 130, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 3, NULL, NULL, 4.4, 2),
('4d5e6f7a-8b9c-065e-2f3a-4b5c6d7e8f9a', 'dotuandat2004nd@gmail.com', '2025-05-24 15:34:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:34:00.000000', 'khoai-lang-organic-1kg', 'Khoai lang hữu cơ, ngọt, giàu chất xơ. Bảo quản nơi thoáng mát.', 'Khoai lang Organic 1kg', 28000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.4, 100, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 6, 25000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.6, 4),
('5e6f7a8b-9c0d-654f-3a4b-5c6d7e8f9a0b', 'admin@gmail.com', '2025-05-24 15:34:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:34:00.000000', 'hanh-tay-organic-1kg', 'Hành tây hữu cơ, thơm, giàu chất chống oxy hóa. Phù hợp xào hoặc salad.', 'Hành tây Organic 1kg', 32000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.5, 90, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 2, NULL, NULL, 4.7, 3),
('6f7a8b9c-0d1e-232a-4b5c-6d7e8f9a0b1c', 'dotuandat2004nd@gmail.com', '2025-05-24 15:34:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:34:00.000000', 'toi-organic-500gr', 'Tỏi hữu cơ, thơm, tốt cho hệ miễn dịch. Bảo quản nơi khô ráo.', 'Tỏi Organic 500gr', 40000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.3, 140, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 5, NULL, NULL, 4.2, 1),
('7a8b9c0d-1e2f-343g-5c6d-7e8f9a0b1c2d', 'pesmobile5404@gmail.com', '2025-05-24 15:34:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:34:00.000000', 'ging-organic-500gr', 'Gừng hữu cơ, cay, tốt cho tiêu hóa. Phù hợp làm gia vị.', 'Gừng Organic 500gr', 35000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.3, 160, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 4, NULL, NULL, 4.3, 2),
('465yrtrf-2f3a-retg-54th-8f9a0b1c2d3e', 'admin@gmail.com', '2025-05-24 15:34:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:34:00.000000', 'cu-den-organic-1kg', 'Củ dền hữu cơ, giàu chất chống oxy hóa, tốt cho máu. Bảo quản lạnh.', 'Củ dền Organic 1kg', 30000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.4, 110, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 3, NULL, NULL, 4.5, 3),
('9c0d1e2f-3a4b-5c6d-ethe-9a0b1c2d3e4f', 'dotuandat2004nd@gmail.com', '2025-05-24 15:34:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:34:00.000000', 'khoai-so-organic-1kg', 'Khoai sọ hữu cơ, bùi, giàu tinh bột. Phù hợp nấu canh.', 'Khoai sọ Organic 1kg', 32000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.3, 130, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 6, NULL, NULL, 4.4, 2),
('0d1e2f3a-4b5c-6d7e-4yrg-0b1c2d3e4f5a', 'pesmobile5404@gmail.com', '2025-05-24 15:34:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:34:00.000000', 'cu-san-organic-1kg', 'Củ sắn hữu cơ, ngọt, giàu chất xơ. Phù hợp luộc hoặc nấu.', 'Củ sắn Organic 1kg', 25000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.5, 80, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 2, NULL, NULL, 4.6, 4),
('1e2f3a4b-5c6d-7e8f-ret5-1c2d3e4f5a6b', 'admin@gmail.com', '2025-05-24 15:34:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:34:00.000000', 'nghe-organic-500gr', 'Nghệ hữu cơ, giàu curcumin, tốt cho sức khỏe. Bảo quản lạnh.', 'Nghệ Organic 500gr', 38000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.6, 70, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 3, 34000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.8, 5),
('2f3a4b5c-6d7e-8f9a-56gf-2d3e4f5a6b7c', 'dotuandat2004nd@gmail.com', '2025-05-24 15:34:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:34:00.000000', 'cu-cai-do-organic-1kg', 'Củ cải đỏ hữu cơ, giòn, giàu vitamin C. Phù hợp salad.', 'Củ cải đỏ Organic 1kg', 32000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.5, 90, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 4, NULL, NULL, 4.7, 3),
('3a4b5c6d-7e8f-9a0b-er35-3e4f5a6b7c8d', 'pesmobile5404@gmail.com', '2025-05-24 15:34:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:34:00.000000', 'khoai-tay-bi-organic-1kg', 'Khoai tây bi hữu cơ, nhỏ, phù hợp nướng hoặc chiên.', 'Khoai tây bi Organic 1kg', 38000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.4, 100, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 5, NULL, NULL, 4.5, 2),
('4b5c6d7e-8f9a-0b1c-rte6-4f5a6b7c8d9e', 'admin@gmail.com', '2025-05-24 15:34:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:34:00.000000', 'cu-dong-organic-1kg', 'Củ đòng hữu cơ, bùi, giàu tinh bột. Phù hợp nấu chè.', 'Củ đòng Organic 1kg', 30000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.5, 80, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 3, NULL, NULL, 4.6, 3),
('5c6d7e8f-9a0b-1c2d-re52-5a6b7c8d9e0f', 'dotuandat2004nd@gmail.com', '2025-05-24 15:34:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:34:00.000000', 'su-hao-organic-1kg', 'Su hào hữu cơ, giòn, giàu vitamin C. Phù hợp xào hoặc làm salad.', 'Su hào Organic 1kg', 27000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.3, 110, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 4, NULL, NULL, 4.4, 2),
-- Organic Farm VN (15 bản ghi)
('6d7e8f9a-rtre-2d3e-4f5a-6b7c8d9e0f1a', 'admin@gmail.com', '2025-05-24 15:34:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:34:00.000000', 'khoai-tay-vn-organic-1kg', 'Khoai tây hữu cơ từ Organic Farm VN, giàu tinh bột, tốt cho năng lượng.', 'Khoai tây Organic VN 1kg', 34000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.4, 140, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 5, NULL, NULL, 4.5, 3),
('7e8f9a0b-1c2d-cewt-5a6b-7c8d9e0f1a2b', 'dotuandat2004nd@gmail.com', '2025-05-24 15:34:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:34:00.000000', 'ca-rot-vn-organic-1kg', 'Cà rốt hữu cơ, giàu vitamin A, tốt cho mắt.', 'Cà rốt Organic VN 1kg', 29000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.3, 130, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 4, NULL, NULL, 4.3, 2),
('8f9a0b1c-2d3e-4f5a-35ew-8d9e0f1a2b3c', 'pesmobile5404@gmail.com', '2025-05-24 15:34:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:34:00.000000', 'cu-cai-trang-vn-organic-1kg', 'Củ cải trắng hữu cơ, giòn, giàu vitamin C.', 'Củ cải trắng Organic VN 1kg', 24000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.3, 120, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 3, NULL, NULL, 4.4, 2),
('9a0b1c2d-3e4f-gfby-7c8d-9e0f1a2b3c4d', 'dotuandat2004nd@gmail.com', '2025-05-24 15:34:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:34:00.000000', 'khoai-lang-vn-organic-1kg', 'Khoai lang hữu cơ, ngọt, giàu chất xơ.', 'Khoai lang Organic VN 1kg', 27000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.4, 100, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 6, 24000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.6, 4),
('0b1c2d3e-r54r-6b7c-8d9e-0f1a2b3c4d5e', 'admin@gmail.com', '2025-05-24 15:34:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:34:00.000000', 'hanh-tay-vn-organic-1kg', 'Hành tây hữu cơ, thơm, giàu chất chống oxy hóa.', 'Hành tây Organic VN 1kg', 31000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.5, 90, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 2, NULL, NULL, 4.7, 3),
('1c2d3e4f-5a6b-sfsf-9e0f-1a2b3c4d5e6f', 'dotuandat2004nd@gmail.com', '2025-05-24 15:34:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:34:00.000000', 'toi-vn-organic-500gr', 'Tỏi hữu cơ, thơm, tốt cho hệ miễn dịch.', 'Tỏi Organic VN 500gr', 39000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.3, 140, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 5, NULL, NULL, 4.2, 1),
('2d3e4f5a-6b7c-dsfg-cbcf-2b3c4d5e6f7a', 'pesmobile5404@gmail.com', '2025-05-24 15:34:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:34:00.000000', 'ging-vn-organic-500gr', 'Gừng hữu cơ, cay, tốt cho tiêu hóa.', 'Gừng Organic VN 500gr', 34000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.3, 160, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 4, NULL, NULL, 4.3, 2),
('3e4f5a6b-7c8d-sger-sdfr-3c4d5e6f7a8b', 'admin@gmail.com', '2025-05-24 15:34:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:34:00.000000', 'cu-den-vn-organic-1kg', 'Củ dền hữu cơ, giàu chất chống oxy hóa, tốt cho máu.', 'Củ dền Organic VN 1kg', 29000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.4, 110, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 3, NULL, NULL, 4.5, 3),
('4f5a6b7c-8d9e-fgdg-gdfg-4d5e6f7a8b9c', 'dotuandat2004nd@gmail.com', '2025-05-24 15:34:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:34:00.000000', 'khoai-so-vn-organic-1kg', 'Khoai sọ hữu cơ, bùi, giàu tinh bột.', 'Khoai sọ Organic VN 1kg', 31000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.3, 130, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 6, NULL, NULL, 4.4, 2),
('5a6b7c8d-9e0f-gdfy-fhdf-5e6f7a8b9c0d', 'pesmobile5404@gmail.com', '2025-05-24 15:34:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:34:00.000000', 'cu-san-vn-organic-1kg', 'Củ sắn hữu cơ, ngọt, giàu chất xơ.', 'Củ sắn Organic VN 1kg', 24000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.5, 80, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 2, NULL, NULL, 4.6, 4),
('6b7c8d9e-0f1a-dfgr-fdht-6f7a8b9c0d1e', 'admin@gmail.com', '2025-05-24 15:34:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:34:00.000000', 'nghe-vn-organic-500gr', 'Nghệ hữu cơ, giàu curcumin, tốt cho sức khỏe.', 'Nghệ Organic VN 500gr', 37000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.6, 70, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 3, 33000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.8, 5),
('7c8d9e0f-1a2b-dfgr-fdgr-7a8b9c0d1e2f', 'dotuandat2004nd@gmail.com', '2025-05-24 15:34:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:34:00.000000', 'cu-cai-do-vn-organic-1kg', 'Củ cải đỏ hữu cơ, giòn, giàu vitamin C.', 'Củ cải đỏ Organic VN 1kg', 31000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.5, 90, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 4, NULL, NULL, 4.7, 3),
('ffrtyvrg-2b3c-4d5e-6f7a-8b9c0d1e2f3a', 'pesmobile5404@gmail.com', '2025-05-24 15:34:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:34:00.000000', 'khoai-tay-bi-vn-organic-1kg', 'Khoai tây bi hữu cơ, nhỏ, phù hợp nướng hoặc chiên.', 'Khoai tây bi Organic VN 1kg', 37000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.4, 100, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 5, NULL, NULL, 4.5, 2),
('5ythtrbt-3c4d-5e6f-7a8b-9c0d1e2f3a4b', 'admin@gmail.com', '2025-05-24 15:34:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:34:00.000000', 'cu-dong-vn-organic-1kg', 'Củ đòng hữu cơ, bùi, giàu tinh bột.', 'Củ đòng Organic VN 1kg', 29000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.5, 80, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 3, NULL, NULL, 4.6, 3),
('56tehtjr-4d5e-6f7a-8b9c-0d1e2f3a4b5c', 'dotuandat2004nd@gmail.com', '2025-05-24 15:34:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:34:00.000000', 'su-hao-vn-organic-1kg', 'Su hào hữu cơ, giòn, giàu vitamin C.', 'Su hào Organic VN 1kg', 26000, '12c833ab-527e-46c6-bb5e-0771a898fc36', 0.3, 110, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 4, NULL, NULL, 4.4, 2),

--
-- Rau củ quả hữu cơ
--


--
-- Thịt heo
--
-- Sản phẩm từ Vissan
('12ab3c4d-5e6f-4a7b-8c9d-0e1f2a3b4c5d', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'thit-ba-chi-vissan-500g', 'Thịt ba chỉ heo Vissan đóng gói 500g, tươi ngon, an toàn vệ sinh thực phẩm', 'Thịt ba chỉ Vissan 500g', 120000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 100, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 50, NULL, NULL, 4.5, 20),
('2b3c4d5e-6f7a-4b8c-9d0e-1f2a3b4c5d6e', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'thit-nac-vai-vissan-500g', 'Thịt nạc vai heo Vissan 500g, thịt mềm, ít mỡ, thích hợp cho nhiều món ăn', 'Thịt nạc vai Vissan 500g', 110000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 80, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 40, NULL, NULL, 4.7, 15),
('3c4d5e6f-7a8b-4c9d-0e1f-2a3b4c5d6e7f', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'suon-non-vissan-500g', 'Sườn non heo Vissan 500g, xương nhỏ, thịt mềm, thích hợp nấu canh, hầm', 'Sườn non Vissan 500g', 150000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 60, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 30, NULL, NULL, 4.8, 25),
('4d5e6f7a-8b9c-4d0e-1f2a-3b4c5d6e7f8a', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'thit-dui-heo-vissan-500g', 'Thịt đùi heo Vissan 500g, thịt nạc nhiều, ít mỡ, thích hợp làm giò, chả', 'Thịt đùi heo Vissan 500g', 105000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 70, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 35, NULL, NULL, 4.6, 18),
('5e6f7a8b-9c0d-4e1f-2a3b-4c5d6e7f8a9b', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'thit-xay-vissan-500g', 'Thịt heo xay Vissan 500g, xay từ thịt nạc vai, tiện lợi cho nhiều món ăn', 'Thịt heo xay Vissan 500g', 95000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 90, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 60, NULL, NULL, 4.9, 30),
('6f7a8b9c-0d1e-4f2a-3b4c-5d6e7f8a9b0c', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'ba-roi-vissan-500g', 'Ba rọi heo Vissan 500g, nhiều thịt, ít mỡ, thích hợp kho, luộc, nướng', 'Ba rọi heo Vissan 500g', 125000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 75, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 45, NULL, NULL, 4.7, 22),
('7a8b9c0d-1e2f-4a3b-5c6d-7e8f9a0b1c2d', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'suon-cuon-vissan-500g', 'Sườn cốt lết Vissan 500g, thịt mềm, xương nhỏ, thích hợp chiên, nướng', 'Sườn cốt lết Vissan 500g', 140000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 65, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 55, NULL, NULL, 4.8, 28),
('8b9c0d1e-2f3a-4b5c-6d7e-8f9a0b1c2d3e', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'thit-tha-luc-vissan-500g', 'Thịt thăn lưng heo Vissan 500g, nạc hoàn toàn, thích hợp làm món xào', 'Thịt thăn lưng Vissan 500g', 130000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 55, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 25, NULL, NULL, 4.9, 20),
('9c0d1e2f-3a4b-5c6d-7e8f-9a0b1c2d3e4f', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'chan-gio-heo-vissan-500g', 'Chân giò heo Vissan 500g, nhiều thịt, thích hợp nấu giả cầy, hầm', 'Chân giò heo Vissan 500g', 90000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 85, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 65, NULL, NULL, 4.5, 15),
('0d1e2f3a-4b5c-6d7e-8f9a-0b1c2d3e4f5a', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'oc-heo-vissan-500g', 'Ốc heo Vissan 500g, thịt mềm, thơm ngon, thích hợp làm món xào', 'Ốc heo Vissan 500g', 110000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 45, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 20, NULL, NULL, 4.6, 12),
('1e2f3a4b-5c6d-7e8f-9a0b-1c2d3e4f5a6b', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'thit-heo-huong-thao-vissan-500g', 'Thịt heo hương thảo Vissan 500g, đã ướp gia vị sẵn, tiện lợi khi chế biến', 'Thịt heo hương thảo Vissan 500g', 135000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 50, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 40, NULL, NULL, 4.8, 18),
('2f3a4b5c-6d7e-8f9a-0b1c-2d3e4f5a6b7c', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'thit-heo-nuong-vissan-500g', 'Thịt heo nướng Vissan 500g, đã tẩm ướp sẵn, chỉ việc nướng và thưởng thức', 'Thịt heo nướng Vissan 500g', 145000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 40, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 30, NULL, NULL, 4.9, 25),
('3a4b5c6d-7e8f-9a0b-1c2d-3e4f5a6b7c8d', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'thit-heo-xong-khoi-vissan-300g', 'Thịt heo xông khói Vissan 300g, thơm ngon, tiện lợi cho bữa sáng', 'Thịt heo xông khói Vissan 300g', 85000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 60, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 50, NULL, NULL, 4.7, 20),
('4b5c6d7e-8f9a-0b1c-2d3e-4f5a6b7c8d9e', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'gio-heo-vissan-300g', 'Giò heo Vissan 300g, thịt nạc nhiều, thích hợp làm giò lụa, chả', 'Giò heo Vissan 300g', 95000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 70, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 45, NULL, NULL, 4.8, 15),
('5c6d7e8f-9a0b-1c2d-3e4f-5a6b7c8d9e0f', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'xuong-ong-heo-vissan-500g', 'Xương ống heo Vissan 500g, nhiều tủy, thích hợp nấu canh, hầm', 'Xương ống heo Vissan 500g', 75000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 80, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 60, NULL, NULL, 4.5, 10),

-- Sản phẩm từ CP Foods
('6d7e8f9a-0b1c-2d3e-4f5a-6b7c8d9e0f1a', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'thit-ba-chi-cp-500g', 'Thịt ba chỉ heo CP Foods 500g, chất lượng cao, đảm bảo an toàn thực phẩm', 'Thịt ba chỉ CP Foods 500g', 125000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 90, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 55, NULL, NULL, 4.7, 22),
('7e8f9a0b-1c2d-3e4f-5a6b-7c8d9e0f1a2b', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'thit-nac-vai-cp-500g', 'Thịt nạc vai heo CP Foods 500g, thịt mềm, ít mỡ, thơm ngon', 'Thịt nạc vai CP Foods 500g', 115000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 85, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 45, NULL, NULL, 4.8, 20),
('8f9a0b1c-2d3e-4f5a-6b7c-8d9e0f1a2b3c', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'suon-non-cp-500g', 'Sườn non heo CP Foods 500g, xương nhỏ, thịt mềm, chất lượng cao', 'Sườn non CP Foods 500g', 155000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 70, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 35, NULL, NULL, 4.9, 25),
('9a0b1c2d-3e4f-5a6b-7c8d-9e0f1a2b3c4d', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'thit-dui-heo-cp-500g', 'Thịt đùi heo CP Foods 500g, nạc nhiều, ít mỡ, thích hợp làm giò, chả', 'Thịt đùi heo CP Foods 500g', 110000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 75, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 40, NULL, NULL, 4.7, 18),
('0b1c2d3e-4f5a-6b7c-8d9e-0f1a2b3c4d5e', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'thit-xay-cp-500g', 'Thịt heo xay CP Foods 500g, xay từ thịt nạc vai, tiện lợi cho nhiều món', 'Thịt heo xay CP Foods 500g', 100000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 95, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 65, NULL, NULL, 4.9, 30),
('1c2d3e4f-5a6b-7c8d-9e0f-1a2b3c4d5e6f', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'ba-roi-cp-500g', 'Ba rọi heo CP Foods 500g, nhiều thịt, ít mỡ, thơm ngon', 'Ba rọi heo CP Foods 500g', 130000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 80, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 50, NULL, NULL, 4.8, 25),
('2d3e4f5a-6b7c-8d9e-0f1a-2b3c4d5e6f7a', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'suon-cuon-cp-500g', 'Sườn cốt lết CP Foods 500g, thịt mềm, xương nhỏ, chất lượng cao', 'Sườn cốt lết CP Foods 500g', 145000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 70, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 45, NULL, NULL, 4.9, 28),
('3e4f5a6b-7c8d-9e0f-1a2b-3c4d5e6f7a8b', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'thit-tha-luc-cp-500g', 'Thịt thăn lưng heo CP Foods 500g, nạc hoàn toàn, thơm ngon', 'Thịt thăn lưng CP Foods 500g', 135000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 60, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 30, NULL, NULL, 4.9, 22),
('4f5a6b7c-8d9e-0f1a-2b3c-4d5e6f7a8b9c', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'chan-gio-heo-cp-500g', 'Chân giò heo CP Foods 500g, nhiều thịt, thích hợp nấu giả cầy, hầm', 'Chân giò heo CP Foods 500g', 95000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 90, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 70, NULL, NULL, 4.6, 18),
('5a6b7c8d-9e0f-1a2b-3c4d-5e6f7a8b9c0d', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'oc-heo-cp-500g', 'Ốc heo CP Foods 500g, thịt mềm, thơm ngon, chất lượng cao', 'Ốc heo CP Foods 500g', 115000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 50, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 25, NULL, NULL, 4.7, 15),
('6b7c8d9e-0f1a-2b3c-4d5e-6f7a8b9c0d1e', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'thit-heo-huong-thao-cp-500g', 'Thịt heo hương thảo CP Foods 500g, đã ướp gia vị sẵn, tiện lợi', 'Thịt heo hương thảo CP Foods 500g', 140000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 55, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 45, NULL, NULL, 4.8, 20),
('7c8d9e0f-1a2b-3c4d-5e6f-7a8b9c0d1e2f', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'thit-heo-nuong-cp-500g', 'Thịt heo nướng CP Foods 500g, đã tẩm ướp sẵn, chất lượng cao', 'Thịt heo nướng CP Foods 500g', 150000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 45, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 35, NULL, NULL, 4.9, 28),
('8d9e0f1a-2b3c-4d5e-6f7a-8b9c0d1e2f3a', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'thit-heo-xong-khoi-cp-300g', 'Thịt heo xông khói CP Foods 300g, thơm ngon, tiện lợi cho bữa sáng', 'Thịt heo xông khói CP Foods 300g', 90000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 65, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 55, NULL, NULL, 4.8, 22),
('9e0f1a2b-3c4d-5e6f-7a8b-9c0d1e2f3a4b', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'gio-heo-cp-300g', 'Giò heo CP Foods 300g, thịt nạc nhiều, chất lượng cao', 'Giò heo CP Foods 300g', 100000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 75, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 50, NULL, NULL, 4.9, 18),
('0f1a2b3c-4d5e-6f7a-8b9c-0d1e2f3a4b5c', 'admin@gmail.com', '2025-03-01 09:00:00', 1, 'admin@gmail.com', '2025-03-01 09:00:00', 'xuong-ong-heo-cp-500g', 'Xương ống heo CP Foods 500g, nhiều tủy, chất lượng cao', 'Xương ống heo CP Foods 500g', 80000, '4ee24d42-77dc-43ce-960f-e06cfb713083', 0, 85, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 65, NULL, NULL, 4.6, 12),

--
-- gia-vi-nguyen-vat-lieu-nau-an
--
-- Dalat Greens (10 bản ghi)
('7b8c9d0e-1f2a-3b4c-5d6e-7f8a9b0c1d2e', 'dotuandat2004nd@gmail.com', '2025-05-24 15:38:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:38:00.000000', 'muoi-bien-organic-500g', 'Muối biển hữu cơ từ Dalat Greens, tinh khiết, dùng làm gia vị nấu ăn. Bảo quản nơi khô ráo.', 'Muối biển Organic 500g', 15000, '8af78245-0016-4e78-8424-82232802e656', 0.1, 200, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 8, NULL, NULL, 4.0, 4),
('8c9d0e1f-2a3b-4c5d-6e7f-8a9b0c1d2e3f', 'admin@gmail.com', '2025-05-24 15:38:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:38:00.000000', 'tieu-den-organic-100g', 'Tiêu đen hữu cơ, thơm nồng, dùng cho món xào và nướng. Bảo quản kín.', 'Tiêu đen Organic 100g', 60000, '8af78245-0016-4e78-8424-82232802e656', 0.3, 150, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 5, 54000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.5, 3),
('9d0e1f2a-3b4c-5d6e-7f8a-9b0c1d2e3f4a', 'pesmobile5404@gmail.com', '2025-05-24 15:38:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:38:00.000000', 'ot-kho-organic-50g', 'Ớt khô hữu cơ, cay nồng, dùng cho món Á. Bảo quản nơi khô ráo.', 'Ớt khô Organic 50g', 25000, '8af78245-0016-4e78-8424-82232802e656', 0.2, 180, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 6, NULL, NULL, 4.2, 2),
('0e1f2a3b-4c5d-6e7f-8a9b-0c1d2e3f4a5b', 'dotuandat2004nd@gmail.com', '2025-05-24 15:38:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:38:00.000000', 'bot-nghe-organic-100g', 'Bột nghệ hữu cơ, giàu curcumin, dùng cho món kho và sức khỏe. Bảo quản kín.', 'Bột nghệ Organic 100g', 40000, '8af78245-0016-4e78-8424-82232802e656', 0.3, 120, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 4, NULL, NULL, 4.6, 3),
('1f2a3b4c-5d6e-7f8a-9b0c-1d2e3f4a5b6c', 'admin@gmail.com', '2025-05-24 15:38:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:38:00.000000', 'duong-thot-not-organic-500g', 'Đường thốt nốt hữu cơ, ngọt thanh, dùng cho món chè và nước chấm. Bảo quản khô ráo.', 'Đường thốt nốt Organic 500g', 50000, '8af78245-0016-4e78-8424-82232802e656', 0.4, 100, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 7, NULL, NULL, 4.7, 5),
('2a3b4c5d-6e7f-8a9b-0c1d-2e3f4a5b6c7d', 'dotuandat2004nd@gmail.com', '2025-05-24 15:38:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:38:00.000000', 'la-chanh-kho-organic-50g', 'Lá chanh khô hữu cơ, thơm, dùng cho món canh và nướng. Bảo quản kín.', 'Lá chanh khô Organic 50g', 20000, '8af78245-0016-4e78-8424-82232802e656', 0.2, 160, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 3, NULL, NULL, 4.3, 2),
('3b4c5d6e-7f8a-9b0c-1d2e-3f4a5b6c7d8e', 'pesmobile5404@gmail.com', '2025-05-24 15:38:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:38:00.000000', 'bot-toi-organic-100g', 'Bột tỏi hữu cơ, thơm, dùng cho món xào và ướp. Bảo quản nơi khô ráo.', 'Bột tỏi Organic 100g', 35000, '8af78245-0016-4e78-8424-82232802e656', 0.3, 140, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 5, NULL, NULL, 4.4, 3),
('4c5d6e7f-8a9b-0c1d-2e3f-4a5b6c7d8e9f', 'admin@gmail.com', '2025-05-24 15:38:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:38:00.000000', 'bot-ca-ri-organic-100g', 'Bột cà ri hữu cơ, đậm đà, dùng cho món cari và kho. Bảo quản kín.', 'Bột cà ri Organic 100g', 45000, '8af78245-0016-4e78-8424-82232802e656', 0.4, 110, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 4, NULL, NULL, 4.5, 4),
('5d6e7f8a-9b0c-1d2e-3f4a-5b6c7d8e9f0a', 'dotuandat2004nd@gmail.com', '2025-05-24 15:38:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:38:00.000000', 'hat-thi-la-organic-50g', 'Hạt thì là hữu cơ, thơm, dùng cho món cá và bánh mì. Bảo quản khô ráo.', 'Hạt thì là Organic 50g', 30000, '8af78245-0016-4e78-8424-82232802e656', 0.2, 130, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 2, NULL, NULL, 4.3, 2),
('6e7f8a9b-0c1d-2e3f-4a5b-6c7d8e9f0a1b', 'pesmobile5404@gmail.com', '2025-05-24 15:38:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:38:00.000000', 'bot-ngu-vi-huong-organic-50g', 'Bột ngũ vị hương hữu cơ, dùng cho món kho và nướng. Bảo quản kín.', 'Bột ngũ vị hương Organic 50g', 35000, '8af78245-0016-4e78-8424-82232802e656', 0.3, 120, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 3, NULL, NULL, 4.6, 3),
-- Organic Farm VN (10 bản ghi)
('7f8a9b0c-1d2e-3f4a-5b6c-7d8e9f0a1b2c', 'admin@gmail.com', '2025-05-24 15:38:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:38:00.000000', 'muoi-bien-vn-organic-500g', 'Muối biển hữu cơ từ Organic Farm VN, tinh khiết, dùng làm gia vị. Bảo quản khô ráo.', 'Muối biển Organic VN 500g', 14000, '8af78245-0016-4e78-8424-82232802e656', 0.1, 190, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 7, NULL, NULL, 4.0, 4),
('8a9b0c1d-2e3f-4a5b-6c7d-8e9f0a1b2c3d', 'dotuandat2004nd@gmail.com', '2025-05-24 15:38:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:38:00.000000', 'tieu-den-vn-organic-100g', 'Tiêu đen hữu cơ, thơm nồng, dùng cho món xào và nướng. Bảo quản kín.', 'Tiêu đen Organic VN 100g', 58000, '8af78245-0016-4e78-8424-82232802e656', 0.3, 140, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 6, 52000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.5, 3),
('9b0c1d2e-3f4a-5b6c-7d8e-9f0a1b2c3d4e', 'pesmobile5404@gmail.com', '2025-05-24 15:38:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:38:00.000000', 'ot-kho-vn-organic-50g', 'Ớt khô hữu cơ, cay nồng, dùng cho món Á. Bảo quản khô ráo.', 'Ớt khô Organic VN 50g', 24000, '8af78245-0016-4e78-8424-82232802e656', 0.2, 170, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 5, NULL, NULL, 4.2, 2),
('0c1d2e3f-4a5b-6c7d-8e9f-0a1b2c3d4e5f', 'admin@gmail.com', '2025-05-24 15:38:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:38:00.000000', 'bot-nghe-vn-organic-100g', 'Bột nghệ hữu cơ, giàu curcumin, dùng cho món kho. Bảo quản kín.', 'Bột nghệ Organic VN 100g', 39000, '8af78245-0016-4e78-8424-82232802e656', 0.3, 110, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 4, NULL, NULL, 4.6, 3),
('1d2e3f4a-5b6c-7d8e-9f0a-1b2c3d4e5f6a', 'dotuandat2004nd@gmail.com', '2025-05-24 15:38:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:38:00.000000', 'duong-thot-not-vn-organic-500g', 'Đường thốt nốt hữu cơ, ngọt thanh, dùng cho món chè. Bảo quản khô ráo.', 'Đường thốt nốt Organic VN 500g', 48000, '8af78245-0016-4e78-8424-82232802e656', 0.4, 90, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 6, NULL, NULL, 4.7, 5),
('2e3f4a5b-6c7d-8e9f-0a1b-2c3d4e5f6a7b', 'pesmobile5404@gmail.com', '2025-05-24 15:38:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:38:00.000000', 'la-chanh-kho-vn-organic-50g', 'Lá chanh khô hữu cơ, thơm, dùng cho món canh. Bảo quản kín.', 'Lá chanh khô Organic VN 50g', 19000, '8af78245-0016-4e78-8424-82232802e656', 0.2, 150, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 3, NULL, NULL, 4.3, 2),
('3f4a5b6c-7d8e-9f0a-1b2c-3d4e5f6a7b8c', 'admin@gmail.com', '2025-05-24 15:38:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:38:00.000000', 'bot-toi-vn-organic-100g', 'Bột tỏi hữu cơ, thơm, dùng cho món xào. Bảo quản khô ráo.', 'Bột tỏi Organic VN 100g', 34000, '8af78245-0016-4e78-8424-82232802e656', 0.3, 130, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 5, NULL, NULL, 4.4, 3),
('4a5b6c7d-8e9f-0a1b-2c3d-4e5f6a7b8c9d', 'dotuandat2004nd@gmail.com', '2025-05-24 15:38:00.000000', 1, 'admin@gmail.com', '2025-05-24 15:38:00.000000', 'bot-ca-ri-vn-organic-100g', 'Bột cà ri hữu cơ, đậm đà, dùng cho món cari. Bảo quản kín.', 'Bột cà ri Organic VN 100g', 44000, '8af78245-0016-4e78-8424-82232802e656', 0.4, 100, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 4, NULL, NULL, 4.5, 4),
('5b6c7d8e-9f0a-1b2c-3d4e-5f6a7b8c9d0e', 'pesmobile5404@gmail.com', '2025-05-24 15:38:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 15:38:00.000000', 'hat-thi-la-vn-organic-50g', 'Hạt thì là hữu cơ, thơm, dùng cho món cá. Bảo quản khô ráo.', 'Hạt thì là Organic VN 50g', 29000, '8af78245-0016-4e78-8424-82232802e656', 0.2, 120, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 2, NULL, NULL, 4.3, 2),
('4trdf546-9f0a-1b2c-3d4e-5f6a7b8c9d0e', 'admin@gmail.com', '2025-05-24 15:38:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 15:38:00.000000', 'bot-ngu-vi-huong-vn-organic-50g', 'Bột ngũ vị hương hữu cơ, dùng cho món kho. Bảo quản kín.', 'Bột ngũ vị hương Organic VN 50g', 34000, '8af78245-0016-4e78-8424-82232802e656', 0.3, 110, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 3, NULL, NULL, 4.6, 3),

--
-- Các loại hạt
--
-- Dalat Greens (15 bản ghi)
('c8f2b7a9-4e3d-5c1f-9a8b-2d6e7f0c3b4a', 'dotuandat2004nd@gmail.com', '2025-05-24 16:06:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:06:00.000000', 'hat-dieu-rang-muoi-organic-500g', 'Hạt điều rang muối hữu cơ từ Dalat Greens, giòn, giàu protein. Bảo quản nơi khô ráo.', 'Hạt điều rang muối Organic 500g', 150000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.4, 120, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 8, 135000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.5, 5),
('a3d9e6b2-7c4f-5a8e-1b9d-3f2c0a6e8d7b', 'admin@gmail.com', '2025-05-24 16:06:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:06:00.000000', 'hat-oc-cho-organic-500g', 'Hạt óc chó hữu cơ, giàu omega-3, tốt cho não. Bảo quản kín.', 'Hạt óc chó Organic 500g', 200000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.5, 100, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 6, NULL, NULL, 4.7, 4),
('b6e1f8c4-2a9d-5b3e-7c0f-4a8d1e9b6f2c', 'pesmobile5404@gmail.com', '2025-05-24 16:06:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:06:00.000000', 'hat-hanh-nhan-organic-500g', 'Hạt hạnh nhân hữu cơ, giàu vitamin E, tốt cho tim. Bảo quản khô ráo.', 'Hạt hạnh nhân Organic 500g', 180000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.4, 110, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 5, NULL, NULL, 4.6, 3),
('d2f7a9e3-6b1c-4d8f-9a2e-5c0b3f7d1e6a', 'dotuandat2004nd@gmail.com', '2025-05-24 16:06:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:06:00.000000', 'hat-de-cuoi-organic-500g', 'Hạt dẻ cười hữu cơ, thơm ngon, giàu protein. Phù hợp ăn vặt.', 'Hạt dẻ cười Organic 500g', 220000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.5, 90, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 7, NULL, NULL, 4.8, 6),
('e9c3b6f1-5a2d-7e4c-8b9f-3d1a0f6e2c7b', 'admin@gmail.com', '2025-05-24 16:06:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:06:00.000000', 'hat-mac-ca-organic-500g', 'Hạt mắc ca hữu cơ, béo ngậy, giàu chất béo tốt. Bảo quản kín.', 'Hạt mắc ca Organic 500g', 250000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.6, 80, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 4, NULL, NULL, 4.7, 4),
('f4a8d1e9-3b6c-5f2a-7d9e-2c0b4f8a6e3d', 'dotuandat2004nd@gmail.com', '2025-05-24 16:06:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:06:00.000000', 'hat-chia-organic-500g', 'Hạt chia hữu cơ, giàu omega-3 và chất xơ. Phù hợp làm sinh tố.', 'Hạt chia Organic 500g', 120000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.3, 130, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 9, NULL, NULL, 4.5, 5),
('a7b2e9c6-4d1f-6a3b-8c0e-5f2d7a9b3e1c', 'pesmobile5404@gmail.com', '2025-05-24 16:06:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:06:00.000000', 'hat-lanh-organic-500g', 'Hạt lanh hữu cơ, giàu chất xơ, tốt cho tiêu hóa. Bảo quản khô ráo.', 'Hạt lanh Organic 500g', 100000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.3, 140, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 3, NULL, NULL, 4.4, 2),
('b9e3f2a7-6c4d-5b1e-8a0f-3d7c9b2e6f4a', 'admin@gmail.com', '2025-05-24 16:06:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:06:00.000000', 'hat-bi-rang-organic-500g', 'Hạt bí rang hữu cơ, thơm ngon, giàu kẽm. Phù hợp ăn vặt.', 'Hạt bí rang Organic 500g', 130000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.4, 100, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 6, NULL, NULL, 4.6, 4),
('c1f8a6b3-7e2d-4a9c-5b0e-9d3f2c7a8e5b', 'dotuandat2004nd@gmail.com', '2025-05-24 16:06:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:06:00.000000', 'hat-huong-duong-organic-500g', 'Hạt hướng dương hữu cơ, giàu vitamin E. Bảo quản nơi khô ráo.', 'Hạt hướng dương Organic 500g', 110000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.3, 120, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 5, NULL, NULL, 4.5, 3),
('d6e2b9f4-3a7c-5d1e-8f0a-2c4b6e9d7a1f', 'pesmobile5404@gmail.com', '2025-05-24 16:06:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:06:00.000000', 'hat-me-den-organic-500g', 'Hạt mè đen hữu cơ, giàu canxi, dùng cho bánh và món Á. Bảo quản kín.', 'Hạt mè đen Organic 500g', 90000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.2, 150, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 4, NULL, NULL, 4.3, 2),
('e8f1c3a6-5b9d-7e2f-4a0c-9b3d6e7f2a8c', 'admin@gmail.com', '2025-05-24 16:06:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:06:00.000000', 'hat-me-trang-organic-500g', 'Hạt mè trắng hữu cơ, thơm, dùng cho bánh và món xào. Bảo quản khô ráo.', 'Hạt mè trắng Organic 500g', 85000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.2, 140, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 3, NULL, NULL, 4.4, 3),
('f2a7b6e9-4c1d-6f3a-8e0b-5d9c2f7a3b4e', 'dotuandat2004nd@gmail.com', '2025-05-24 16:06:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:06:00.000000', 'hat-dua-organic-500g', 'Hạt dưa hữu cơ, giòn, phù hợp ăn vặt. Bảo quản nơi khô ráo.', 'Hạt dưa Organic 500g', 95000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.3, 130, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 6, NULL, NULL, 4.5, 4),
('a9b3e2f7-6d4c-5a1e-8c0f-3b7d9e6a2f1c', 'pesmobile5404@gmail.com', '2025-05-24 16:06:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:06:00.000000', 'hat-quinoa-organic-500g', 'Hạt quinoa hữu cơ, giàu protein, dùng cho salad và cháo. Bảo quản kín.', 'Hạt quinoa Organic 500g', 140000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.4, 100, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 5, NULL, NULL, 4.6, 3),
('b4e9f1c3-7a2d-5b6e-8f0a-4c1d3e7b9a6f', 'admin@gmail.com', '2025-05-24 16:06:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:06:00.000000', 'hat-phi-organic-500g', 'Hạt phỉ hữu cơ, thơm, giàu chất béo tốt. Phù hợp làm bánh.', 'Hạt phỉ Organic 500g', 210000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.5, 90, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 4, NULL, NULL, 4.7, 4),
('c6f2a8b9-3e7d-5c1f-9a0e-2b4d6e3f7c8a', 'dotuandat2004nd@gmail.com', '2025-05-24 16:06:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:06:00.000000', 'hat-thong-organic-500g', 'Hạt thông hữu cơ, béo ngậy, dùng cho salad và bánh. Bảo quản kín.', 'Hạt thông Organic 500g', 230000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.6, 80, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 3, NULL, NULL, 4.8, 5),
-- Organic Farm VN (15 bản ghi)
('d8e3b9f2-4a7c-6e1d-5b0f-9c2a3f7d6e4b', 'admin@gmail.com', '2025-05-24 16:06:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:06:00.000000', 'hat-dieu-rang-muoi-vn-organic-500g', 'Hạt điều rang muối hữu cơ từ Organic Farm VN, giòn, giàu protein.', 'Hạt điều rang muối Organic VN 500g', 145000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.4, 110, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 7, 130000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.5, 5),
('e1f9a6b3-5c2d-7e4f-8a0c-3b9d2f6e7a1c', 'dotuandat2004nd@gmail.com', '2025-05-24 16:06:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:06:00.000000', 'hat-oc-cho-vn-organic-500g', 'Hạt óc chó hữu cơ, giàu omega-3, tốt cho não.', 'Hạt óc chó Organic VN 500g', 195000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.5, 90, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 5, NULL, NULL, 4.7, 4),
('f3a7b2e9-6d1c-4f8a-5b0e-9c3d7e2f6a8b', 'pesmobile5404@gmail.com', '2025-05-24 16:06:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:06:00.000000', 'hat-hanh-nhan-vn-organic-500g', 'Hạt hạnh nhân hữu cơ, giàu vitamin E, tốt cho tim.', 'Hạt hạnh nhân Organic VN 500g', 175000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.4, 100, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 6, NULL, NULL, 4.6, 3),
('a6e2f9b3-7c4d-5a1e-8f0c-2b9d3e7a6f1c', 'admin@gmail.com', '2025-05-24 16:06:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:06:00.000000', 'hat-de-cuoi-vn-organic-500g', 'Hạt dẻ cười hữu cơ, thơm ngon, giàu protein.', 'Hạt dẻ cười Organic VN 500g', 215000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.5, 80, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 5, NULL, NULL, 4.8, 6),
('b9f3a7e2-4c1d-6e8f-5b0a-9d2c3f7a6e4b', 'dotuandat2004nd@gmail.com', '2025-05-24 16:06:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:06:00.000000', 'hat-mac-ca-vn-organic-500g', 'Hạt mắc ca hữu cơ, béo ngậy, giàu chất béo tốt.', 'Hạt mắc ca Organic VN 500g', 245000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.6, 70, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 4, NULL, NULL, 4.7, 4),
('c2e9b6f3-5a7c-4d1e-8f0b-3c9a2f6e7d8a', 'pesmobile5404@gmail.com', '2025-05-24 16:06:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:06:00.000000', 'hat-chia-vn-organic-500g', 'Hạt chia hữu cơ, giàu omega-3 và chất xơ.', 'Hạt chia Organic VN 500g', 115000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.3, 120, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 8, NULL, NULL, 4.5, 5),
('d7f2a9e3-6b1c-5e4f-8a0c-2d9b3f7e6a1b', 'admin@gmail.com', '2025-05-24 16:06:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:06:00.000000', 'hat-lanh-vn-organic-500g', 'Hạt lanh hữu cơ, giàu chất xơ, tốt cho tiêu hóa.', 'Hạt lanh Organic VN 500g', 95000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.3, 130, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 3, NULL, NULL, 4.4, 2),
('e8b3f2a7-4c9d-6e1f-5b0e-9a2c3d7f6e4c', 'dotuandat2004nd@gmail.com', '2025-05-24 16:06:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:06:00.000000', 'hat-bi-rang-vn-organic-500g', 'Hạt bí rang hữu cơ, thơm ngon, giàu kẽm.', 'Hạt bí rang Organic VN 500g', 125000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.4, 90, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 5, NULL, NULL, 4.6, 4),
('f1a7e9b3-5c2d-7f4a-8e0c-3b9d2f6a6e7d', 'pesmobile5404@gmail.com', '2025-05-24 16:06:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:06:00.000000', 'hat-huong-duong-vn-organic-500g', 'Hạt hướng dương hữu cơ, giàu vitamin E.', 'Hạt hướng dương Organic VN 500g', 105000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.3, 110, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 4, NULL, NULL, 4.5, 3),
('a9e3b6f2-4c7d-5e1a-8f0b-2d9c3a7e6f8c', 'admin@gmail.com', '2025-05-24 16:06:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:06:00.000000', 'hat-me-den-vn-organic-500g', 'Hạt mè đen hữu cơ, giàu canxi, dùng cho bánh.', 'Hạt mè đen Organic VN 500g', 85000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.2, 140, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 3, NULL, NULL, 4.3, 2),
('b2f9a7e3-6e1c-5c4d-8a0f-9b3d2e7f6a9c', 'dotuandat2004nd@gmail.com', '2025-05-24 16:06:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:06:00.000000', 'hat-me-trang-vn-organic-500g', 'Hạt mè trắng hữu cơ, thơm, dùng cho món xào.', 'Hạt mè trắng Organic VN 500g', 80000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.2, 130, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 4, NULL, NULL, 4.4, 3),
('c7e2f9b3-5a7c-4d1e-8f0a-2c9d3e6a7f4b', 'pesmobile5404@gmail.com', '2025-05-24 16:06:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:06:00.000000', 'hat-dua-vn-organic-500g', 'Hạt dưa hữu cơ, giòn, phù hợp ăn vặt.', 'Hạt dưa Organic VN 500g', 90000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.3, 120, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 5, NULL, NULL, 4.5, 4),
('d9f3a6e2-4c1d-7e8f-5b0c-9a2e3f7b6d8a', 'admin@gmail.com', '2025-05-24 16:06:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:06:00.000000', 'hat-quinoa-vn-organic-500g', 'Hạt quinoa hữu cơ, giàu protein, dùng cho salad.', 'Hạt quinoa Organic VN 500g', 135000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.4, 90, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 4, NULL, NULL, 4.6, 3),
('e2a7b9f3-6e4c-5d1a-8f0e-3c9b2e7d6f8b', 'dotuandat2004nd@gmail.com', '2025-05-24 16:06:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:06:00.000000', 'hat-phi-vn-organic-500g', 'Hạt phỉ hữu cơ, thơm, giàu chất béo tốt.', 'Hạt phỉ Organic VN 500g', 205000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.5, 80, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 3, NULL, NULL, 4.7, 4),
('f8e3a2b9-4c7d-6e1f-5a0c-9b2d3f7e6a9c', 'pesmobile5404@gmail.com', '2025-05-24 16:06:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:06:00.000000', 'hat-thong-vn-organic-500g', 'Hạt thông hữu cơ, béo ngậy, dùng cho salad.', 'Hạt thông Organic VN 500g', 225000, 'a20e7a76-5913-4025-9e0b-9bfcb20c45c6', 0.6, 70, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 4, NULL, NULL, 4.8, 5),

-- 
-- Supper food
--
-- Các loại hạt dinh dưỡng
('203a8291-c3c7-418b-a56d-1109bdd32002', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'hat-oc-cho-organic-500gr', 'Hạt óc chó Organic nhập khẩu Mỹ, giàu Omega-3, tốt cho tim mạch và trí não', 'Hạt óc chó Organic 500gr', 250000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 100, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 50, NULL, NULL, 4.8, 25),
('22e8cfa1-10ec-43eb-831c-5722554bf637', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'hat-hanh-nhan-500gr', 'Hạt hạnh nhân nguyên vỏ California, giàu vitamin E và chất xơ', 'Hạt hạnh nhân 500gr', 220000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 90, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 60, NULL, NULL, 4.7, 30),
('260bc683-3527-4bcd-9ce9-d614f347fd0f', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'hat-dieu-rang-muoi-500gr', 'Hạt điều rang muối Bình Phước, nguyên chất 100%, giàu protein', 'Hạt điều rang muối 500gr', 180000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 120, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 80, NULL, NULL, 4.9, 35),
('28e0713e-e72a-4665-b102-2671f8087a63', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'hat-macca-500gr', 'Hạt macca Úc, vỏ nứt sẵn, giàu chất béo tốt và khoáng chất', 'Hạt macca 500gr', 300000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 70, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 40, NULL, NULL, 4.8, 20),
('298940d0-9254-4cdf-b549-ec663f16fdd9', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'hat-bi-do-500gr', 'Hạt bí đỏ tách vỏ, giàu magie và kẽm, tốt cho sức khỏe nam giới', 'Hạt bí đỏ 500g', 150000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 110, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 70, NULL, NULL, 4.6, 15),

-- Các loại bột siêu thực phẩm
('2c886de1-a3bd-4348-ad31-7d7001a060fd', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'bot-matcha-100gr', 'Bột matcha Nhật Bản hạng sang, giàu chất chống oxy hóa', 'Bột matcha Nhật Bản 100g', 350000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 60, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 30, NULL, NULL, 4.9, 40),
('2cf69fe3-a41b-4964-ba98-a122cca81a9d', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'bot-maca-200gr', 'Bột maca Peru, tăng cường sinh lý và năng lượng tự nhiên', 'Bột maca 200g', 280000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 50, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 25, NULL, NULL, 4.7, 18),
('2d0a411b-b5e6-4c42-8705-9b09a2d6e2f3', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'bot-spirulina-200gr', 'Bột tảo spirulina hữu cơ, giàu protein và chất dinh dưỡng', 'Bột tảo spirulina 200g', 200000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 80, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 45, NULL, NULL, 4.8, 22),
('2eb9873b-40a8-4aae-bfd4-f5e56f25392c', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'bot-cacao-nguyen-chat-200gr', 'Bột cacao nguyên chất không đường, giàu chất chống oxy hóa', 'Bột cacao nguyên chất 200g', 120000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 100, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 65, NULL, NULL, 4.9, 30),
('349c97b3-d00f-4afd-ab38-899e3b1bd15b', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'bot-quinoa-500gr', 'Bột quinoa hữu cơ, không gluten, giàu protein và axit amin', 'Bột quinoa 500g', 180000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 70, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 40, NULL, NULL, 4.7, 15),

-- Các loại trái cây sấy
('34c24ab7-2b4c-448a-85be-82b48d620199', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'nam-viet-quat-say-200gr', 'Nam việt quất sấy không đường, giàu chất chống oxy hóa', 'Nam việt quất sấy 200g', 250000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 80, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 50, NULL, NULL, 4.8, 25),
('34e6cde9-3e81-4237-b426-366c9f5aca04', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'man-say-200gr', 'Mận sấy không đường, giàu chất xơ và sắt', 'Mận sấy 200g', 120000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 110, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 70, NULL, NULL, 4.6, 20),
('350925fb-f69f-41e2-aa90-548c57a40f89', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'xoai-say-200gr', 'Xoài sấy không đường, giữ nguyên hương vị tự nhiên', 'Xoài sấy 200g', 150000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 90, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 60, NULL, NULL, 4.7, 18),
('387bf7c9-0173-4976-be07-f1ba43845092', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'chuoi-say-200gr', 'Chuối sấy không đường, giàu kali và năng lượng', 'Chuối sấy 200g', 100000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 120, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 80, NULL, NULL, 4.5, 15),
('393cd742-12f6-41f0-aa4a-d032594fc00d', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'du-du-say-200gr', 'Đu đủ sấy không đường, giàu vitamin A và enzyme tiêu hóa', 'Đu đủ sấy 200g', 130000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 85, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 55, NULL, NULL, 4.6, 12),

-- Các loại hạt chia, hạt lanh
('39f1f13f-e152-484d-90c7-cb961dcfbeb9', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'hat-chia-organic-500gr', 'Hạt chia Organic Úc, giàu Omega-3 và chất xơ', 'Hạt chia Organic 500g', 200000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 95, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 65, NULL, NULL, 4.9, 35),
('3ce0a6cd-132a-4fb4-8009-2aa84934a685', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'hat-lanh-vang-500gr', 'Hạt lanh vàng Canada, giàu lignans và chất béo tốt', 'Hạt lanh vàng 500g', 150000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 80, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 50, NULL, NULL, 4.7, 20),
('3e6b46aa-612d-4873-b8ac-d0041fe4e53b', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'bot-hat-lanh-200gr', 'Bột hạt lanh nguyên chất, dễ hấp thu dinh dưỡng', 'Bột hạt lanh 200g', 120000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 70, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 45, NULL, NULL, 4.6, 15),
('439ba2b8-d61d-4e5e-ab1a-ff32f2c78fd8', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'hat-echium-200gr', 'Hạt echium (hạt vĩnh viễn), nguồn Omega-3 từ thực vật', 'Hạt echium 200g', 280000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 50, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 30, NULL, NULL, 4.8, 18),
('4ae28144-f22b-4708-b9c8-5c98028e09e1', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'hat-hemp-200g', 'Hạt hemp (hạt gai dầu), giàu protein hoàn chỉnh', 'Hạt hemp 200g', 220000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 60, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 40, NULL, NULL, 4.7, 16),

-- Các loại quả goji, acai
('4b18aa0a-ce30-4ccd-8fe6-e4217b97df71', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'qua-goji-500gr', 'Quả goji Tây Tạng, giàu chất chống oxy hóa', 'Quả goji 500g', 300000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 65, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 35, NULL, NULL, 4.9, 28),
('4edf8b7d-8031-464c-9ac2-631a826d7096', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'bot-acai-100g', 'Bột acai Brazil, siêu thực phẩm giàu anthocyanin', 'Bột acai 100g', 350000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 45, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 25, NULL, NULL, 4.8, 20),
('4f568e39-17cc-41ab-b485-9882174de621', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'qua-mulberry-say-200g', 'Quả dâu tằm sấy không đường, giàu vitamin C', 'Dâu tằm sấy 200g', 180000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 75, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 50, NULL, NULL, 4.7, 15),
('4f587e57-498c-44cb-9825-36d871822783', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'qua-inca-berry-200g', 'Quả inca berry (quả lý chua Nam Mỹ), giàu vitamin D', 'Inca berry 200g', 250000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 55, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 35, NULL, NULL, 4.6, 12),
('4f688179-ba15-4207-a3a9-bc00f5cb9b69', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'qua-maqui-berry-100g', 'Quả maqui berry Chile, siêu thực phẩm chống oxy hóa', 'Maqui berry 100g', 400000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 40, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 20, NULL, NULL, 4.9, 18),

-- Các loại siêu thực phẩm khác
('4f80115f-9d53-4e40-b4d8-e363aff005bd', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'tinh-bot-nghệ-organic-200g', 'Tinh bột nghệ Organic, giàu curcumin chống viêm', 'Tinh bột nghệ Organic 200g', 150000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 85, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 55, NULL, NULL, 4.8, 25),
('53622008-8cea-4304-a861-2e32869c0c45', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'tinh-chat-nhung-huou-100ml', 'Tinh chất nhung hươu Siberia, tăng cường sinh lực', 'Tinh chất nhung hươu 100ml', 1200000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 30, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 15, NULL, NULL, 4.9, 20),
('559a3f11-a62d-4615-9a48-4f2db168cac8', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'dau-dung-dinh-duong-500ml', 'Dầu dừa nguyên chất ép lạnh, giàu MCT', 'Dầu dừa dinh dưỡng 500ml', 180000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 70, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 45, NULL, NULL, 4.7, 18),
('5642f7cf-1a10-430b-ace8-b491918064b9', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'mat-ong-manuka-mgo-250g', 'Mật ong Manuka New Zealand MGO 100+, kháng khuẩn tự nhiên', 'Mật ong Manuka MGO 250g', 1500000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 25, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 10, NULL, NULL, 5.0, 30),
('58cd58b6-08e4-4892-88f9-2dfe0ea91687', 'admin@gmail.com', NOW(), 1, 'admin@gmail.com', NOW(), 'keo-ong-nguyen-chat-100g', 'Keo ong nguyên chất Brazil, kháng khuẩn, tăng đề kháng', 'Keo ong nguyên chất 100g', 350000, 'b738b69a-cb75-4382-8ce4-2ca62f92af02', 0, 50, 'b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e', 30, NULL, NULL, 4.8, 22),

--
-- Đồ khô khác
--
-- Dalat Greens (15 bản ghi)
('5acf3d41-2cee-46f9-937e-b8bc074698d4', 'dotuandat2004nd@gmail.com', '2025-05-24 16:12:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:12:00.000000', 'nam-huong-kho-organic-500g', 'Nấm hương khô hữu cơ từ Dalat Greens, thơm, dùng cho món canh và xào. Ngâm nước trước khi dùng.', 'Nấm hương khô Organic 500g', 180000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.4, 120, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 8, 162000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.5, 5),
('5b786e42-97b0-4cd9-9234-9d77160ab555', 'admin@gmail.com', '2025-05-24 16:12:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:12:00.000000', 'tom-kho-organic-500g', 'Tôm khô hữu cơ, ngọt tự nhiên, dùng cho món canh và gỏi. Bảo quản kín.', 'Tôm khô Organic 500g', 350000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.5, 100, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 6, NULL, NULL, 4.7, 4),
('5cb0b58c-1cc0-4c29-8ed4-81f5003eebc4', 'pesmobile5404@gmail.com', '2025-05-24 16:12:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:12:00.000000', 'rong-bien-kho-organic-100g', 'Rong biển khô hữu cơ, giàu i-ốt, dùng cho canh và cuốn sushi. Bảo quản khô ráo.', 'Rong biển khô Organic 100g', 60000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.3, 130, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 7, NULL, NULL, 4.4, 3),
('5dfa74bb-cdb3-4e95-8076-e10d0ad2a887', 'dotuandat2004nd@gmail.com', '2025-05-24 16:12:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:12:00.000000', 'mang-kho-organic-500g', 'Măng khô hữu cơ, dùng cho món hầm và xào. Ngâm nước trước khi nấu.', 'Măng khô Organic 500g', 120000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.4, 110, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 5, NULL, NULL, 4.6, 4),
('5e2a4f52-906c-4cf8-9ec4-a559524e0879', 'admin@gmail.com', '2025-05-24 16:12:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:12:00.000000', 'xoai-say-organic-500g', 'Xoài sấy hữu cơ, ngọt tự nhiên, phù hợp ăn vặt. Bảo quản kín.', 'Xoài sấy Organic 500g', 130000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.3, 100, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 9, NULL, NULL, 4.5, 5),
('5f6d2805-6f5b-4036-8f5b-17e5fbe1a504', 'dotuandat2004nd@gmail.com', '2025-05-24 16:12:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:12:00.000000', 'muc-kho-organic-500g', 'Mực khô hữu cơ, thơm ngon, dùng nướng hoặc nấu canh. Bảo quản nơi khô ráo.', 'Mực khô Organic 500g', 400000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.6, 80, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 4, NULL, NULL, 4.8, 6),
('62432bd3-c1bf-426c-8473-793282bdb1e3', 'pesmobile5404@gmail.com', '2025-05-24 16:12:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:12:00.000000', 'ca-kho-organic-500g', 'Cá khô hữu cơ, dùng cho món kho và chiên. Bảo quản kín.', 'Cá khô Organic 500g', 250000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.5, 90, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 6, NULL, NULL, 4.7, 4),
('62d4db98-1226-4e33-b3ed-aa02ba1b1ae4', 'admin@gmail.com', '2025-05-24 16:12:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:12:00.000000', 'mieng-dong-organic-500g', 'Miến dong hữu cơ, dai ngon, dùng cho món xào và canh. Bảo quản khô ráo.', 'Miến dong Organic 500g', 70000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.2, 140, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 8, NULL, NULL, 4.3, 3),
('650c57c6-05a8-47df-a1a4-4951bd1907af', 'dotuandat2004nd@gmail.com', '2025-05-24 16:12:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:12:00.000000', 'hanh-phi-organic-200g', 'Hành phi hữu cơ, thơm giòn, dùng cho món bún và bánh. Bảo quản kín.', 'Hành phi Organic 200g', 50000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.2, 150, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 10, NULL, NULL, 4.5, 5),
('66eb5e10-da3a-482b-ab2a-fe9b3c54cddc', 'pesmobile5404@gmail.com', '2025-05-24 16:12:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:12:00.000000', 'bo-kho-organic-500g', 'Bò khô hữu cơ, đậm đà, phù hợp ăn vặt. Bảo quản nơi khô ráo.', 'Bò khô Organic 500g', 550000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.6, 70, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 5, NULL, NULL, 4.8, 6),
('6ac21426-8242-4345-b406-cf55e082a560', 'admin@gmail.com', '2025-05-24 16:12:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:12:00.000000', 'cha-bong-heo-organic-500g', 'Chà bông heo hữu cơ, thơm ngon, dùng cho bánh mì và cháo. Bảo quản kín.', 'Chà bông heo Organic 500g', 200000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.5, 100, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 7, NULL, NULL, 4.6, 4),
('6b077250-e483-499f-95e3-01e183edd55d', 'dotuandat2004nd@gmail.com', '2025-05-24 16:12:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:12:00.000000', 'khoai-lang-say-organic-500g', 'Khoai lang sấy hữu cơ, ngọt tự nhiên, phù hợp ăn vặt. Bảo quản khô ráo.', 'Khoai lang sấy Organic 500g', 110000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.3, 120, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 6, NULL, NULL, 4.5, 4),
('6beb1cca-0011-4142-9dad-10c12e24c3a6', 'pesmobile5404@gmail.com', '2025-05-24 16:12:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:12:00.000000', 'mit-say-organic-500g', 'Mít sấy hữu cơ, thơm ngọt, dùng ăn vặt hoặc làm bánh. Bảo quản kín.', 'Mít sấy Organic 500g', 140000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.4, 110, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 8, NULL, NULL, 4.7, 5),
('6dfeb536-6fbf-4cd3-afbc-c14626917c80', 'admin@gmail.com', '2025-05-24 16:12:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:12:00.000000', 'nam-meo-kho-organic-500g', 'Nấm mèo khô hữu cơ, giòn, dùng cho món xào và canh. Ngâm nước trước khi dùng.', 'Nấm mèo khô Organic 500g', 100000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.3, 130, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 5, NULL, NULL, 4.4, 3),
('6f4cc978-0ead-4dbc-8fdb-1b8c05346666', 'dotuandat2004nd@gmail.com', '2025-05-24 16:12:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:12:00.000000', 'toi-phi-organic-200g', 'Tỏi phi hữu cơ, thơm giòn, dùng cho món bún và salad. Bảo quản kín.', 'Tỏi phi Organic 200g', 55000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.2, 140, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 9, NULL, NULL, 4.5, 4),
-- Organic Farm VN (15 bản ghi)
('71ab414c-9228-430a-a356-523fefcf3691', 'admin@gmail.com', '2025-05-24 16:12:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:12:00.000000', 'nam-huong-kho-vn-organic-500g', 'Nấm hương khô hữu cơ từ Organic Farm VN, thơm, dùng cho món canh.', 'Nấm hương khô Organic VN 500g', 175000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.4, 110, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 7, 157500, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.5, 5),
('7257ecd7-5ae9-4d99-bb31-b0aa99617451', 'dotuandat2004nd@gmail.com', '2025-05-24 16:12:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:12:00.000000', 'tom-kho-vn-organic-500g', 'Tôm khô hữu cơ, ngọt tự nhiên, dùng cho món gỏi.', 'Tôm khô Organic VN 500g', 340000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.5, 90, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 5, NULL, NULL, 4.7, 4),
('734e4fe0-4074-4055-a713-f719c19f26e0', 'pesmobile5404@gmail.com', '2025-05-24 16:12:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:12:00.000000', 'rong-bien-kho-vn-organic-100g', 'Rong biển khô hữu cơ, giàu i-ốt, dùng cho sushi.', 'Rong biển khô Organic VN 100g', 58000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.3, 120, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 6, NULL, NULL, 4.4, 3),
('748b4c26-ef5c-4f9c-bc2e-d14de6d3ac0b', 'admin@gmail.com', '2025-05-24 16:12:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:12:00.000000', 'mang-kho-vn-organic-500g', 'Măng khô hữu cơ, dùng cho món hầm.', 'Măng khô Organic VN 500g', 115000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.4, 100, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 4, NULL, NULL, 4.6, 4),
('74efbec6-3bfa-4745-ad2a-f0c7a7ebddcf', 'dotuandat2004nd@gmail.com', '2025-05-24 16:12:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:12:00.000000', 'xoai-say-vn-organic-500g', 'Xoài sấy hữu cơ, ngọt tự nhiên, phù hợp ăn vặt.', 'Xoài sấy Organic VN 500g', 125000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.3, 90, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 8, NULL, NULL, 4.5, 5),
('79ca2676-3c09-4600-8c35-b5ddd980dbfc', 'pesmobile5404@gmail.com', '2025-05-24 16:12:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:12:00.000000', 'muc-kho-vn-organic-500g', 'Mực khô hữu cơ, thơm ngon, dùng nướng.', 'Mực khô Organic VN 500g', 390000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.6, 70, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 4, NULL, NULL, 4.8, 6),
('7bb03083-df68-4336-ae50-5e8d26d5f689', 'admin@gmail.com', '2025-05-24 16:12:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:12:00.000000', 'ca-kho-vn-organic-500g', 'Cá khô hữu cơ, dùng cho món kho.', 'Cá khô Organic VN 500g', 240000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.5, 80, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 5, NULL, NULL, 4.7, 4),
('7c8b3714-8b7c-4653-9876-46e9841897ed', 'dotuandat2004nd@gmail.com', '2025-05-24 16:12:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:12:00.000000', 'mieng-dong-vn-organic-500g', 'Miến dong hữu cơ, dai ngon, dùng cho món xào.', 'Miến dong Organic VN 500g', 68000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.2, 130, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 7, NULL, NULL, 4.3, 3),
('7ee92c3e-cb21-4a6a-8b43-a86ebdbd546b', 'pesmobile5404@gmail.com', '2025-05-24 16:12:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:12:00.000000', 'hanh-phi-vn-organic-200g', 'Hành phi hữu cơ, thơm giòn, dùng cho món bún.', 'Hành phi Organic VN 200g', 48000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.2, 140, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 9, NULL, NULL, 4.5, 4),
('7f6f7e9d-6ae1-46cd-9615-82ade765ae0c', 'admin@gmail.com', '2025-05-24 16:12:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:12:00.000000', 'bo-kho-vn-organic-500g', 'Bò khô hữu cơ, đậm đà, phù hợp ăn vặt.', 'Bò khô Organic VN 500g', 540000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.6, 60, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 5, NULL, NULL, 4.8, 6),
('80272589-b7c3-40f8-9a18-11dfaf34cf83', 'dotuandat2004nd@gmail.com', '2025-05-24 16:12:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:12:00.000000', 'cha-bong-heo-vn-organic-500g', 'Chà bông heo hữu cơ, thơm ngon, dùng cho cháo.', 'Chà bông heo Organic VN 500g', 195000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.5, 90, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 6, NULL, NULL, 4.6, 4),
('807b3a15-5c2c-4fe6-be2a-a3056d8e42cd', 'pesmobile5404@gmail.com', '2025-05-24 16:12:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:12:00.000000', 'khoai-lang-say-vn-organic-500g', 'Khoai lang sấy hữu cơ, ngọt tự nhiên, ăn vặt.', 'Khoai lang sấy Organic VN 500g', 105000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.3, 110, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 7, NULL, NULL, 4.5, 4),
('80b4f151-0089-4dd9-a239-5eb61d09bfb7', 'admin@gmail.com', '2025-05-24 16:12:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:12:00.000000', 'mit-say-vn-organic-500g', 'Mít sấy hữu cơ, thơm ngọt, dùng làm bánh.', 'Mít sấy Organic VN 500g', 135000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.4, 100, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 8, NULL, NULL, 4.7, 5),
('853f3885-de4e-4bab-8771-8cffc647e611', 'dotuandat2004nd@gmail.com', '2025-05-24 16:12:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:12:00.000000', 'nam-meo-kho-vn-organic-500g', 'Nấm mèo khô hữu cơ, giòn, dùng cho món xào.', 'Nấm mèo khô Organic VN 500g', 95000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.3, 120, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 5, NULL, NULL, 4.4, 3),
('8688f47f-543c-48cd-aa9e-7a64ac4827c9', 'pesmobile5404@gmail.com', '2025-05-24 16:12:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:12:00.000000', 'toi-phi-vn-organic-200g', 'Tỏi phi hữu cơ, thơm giòn, dùng cho salad.', 'Tỏi phi Organic VN 200g', 53000, 'b75bd02b-6635-4c81-b7bd-d588bd34a28b', 0.2, 130, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 10, NULL, NULL, 4.5, 4),

--
-- Rau gia vị
--
-- Dalat Greens (15 bản ghi)
('8837297c-066c-44a1-bbdc-d27982d4d32f', 'dotuandat2004nd@gmail.com', '2025-05-24 16:16:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:16:00.000000', 'rau-mui-organic-100g', 'Rau mùi hữu cơ từ Dalat Greens, tươi sạch, dùng cho phở và gỏi. Bảo quản tủ lạnh.', 'Rau mùi Organic 100g', 12000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.1, 200, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 15, 10800, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.2, 4),
('8c8dc418-4940-446a-a58d-8bbadc72adc7', 'admin@gmail.com', '2025-05-24 16:16:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:16:00.000000', 'hung-que-organic-100g', 'Húng quế hữu cơ, thơm, dùng cho phở và món Âu. Bảo quản tủ lạnh.', 'Húng quế Organic 100g', 15000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.1, 180, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 12, NULL, NULL, 4.3, 3),
('8e93dd20-77cb-4e33-a8d4-9997a1e40acb', 'pesmobile5404@gmail.com', '2025-05-24 16:16:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:16:00.000000', 'hung-lui-organic-100g', 'Húng lủi hữu cơ, thơm nồng, dùng cho món cuốn và canh. Bảo quản tủ lạnh.', 'Húng lủi Organic 100g', 14000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.1, 190, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 10, NULL, NULL, 4.1, 2),
('8f418ffb-2f47-478b-8262-deb06702f20b', 'dotuandat2004nd@gmail.com', '2025-05-24 16:16:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:16:00.000000', 'rau-ram-organic-100g', 'Rau răm hữu cơ, thơm đặc trưng, dùng cho gỏi gà và cháo. Bảo quản tủ lạnh.', 'Rau răm Organic 100g', 13000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.1, 210, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 14, NULL, NULL, 4.4, 4),
('9016471b-f9c3-4c3c-b553-828acfea63a9', 'admin@gmail.com', '2025-05-24 16:16:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:16:00.000000', 'hanh-la-organic-100g', 'Hành lá hữu cơ, tươi xanh, dùng cho canh và món xào. Bảo quản tủ lạnh.', 'Hành lá Organic 100g', 10000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.1, 220, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 16, NULL, NULL, 4.0, 3),
('920ac346-8d17-4410-ae52-4563b21e8ed3', 'pesmobile5404@gmail.com', '2025-05-24 16:16:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:16:00.000000', 'thi-la-organic-100g', 'Thì là hữu cơ, thơm nhẹ, dùng cho canh cá và bánh. Bảo quản tủ lạnh.', 'Thì là Organic 100g', 16000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.1, 200, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 13, NULL, NULL, 4.2, 3),
('92a24cce-e57a-4502-8a89-e0c9cdcc45ef', 'dotuandat2004nd@gmail.com', '2025-05-24 16:16:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:16:00.000000', 'bac-ha-organic-100g', 'Bạc hà hữu cơ, thơm mát, dùng cho phở và gỏi. Bảo quản tủ lạnh.', 'Bạc hà Organic 100g', 15000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.1, 190, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 11, NULL, NULL, 4.3, 4),
('93685a12-d900-41cd-8983-87cded6976b4', 'admin@gmail.com', '2025-05-24 16:16:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:16:00.000000', 'kinh-gioi-organic-100g', 'Kinh giới hữu cơ, thơm, dùng cho món cuốn và nướng. Bảo quản tủ lạnh.', 'Kinh giới Organic 100g', 14000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.1, 210, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 12, NULL, NULL, 4.1, 2),
('98ee8522-6109-426f-9ee6-c9a36844f510', 'pesmobile5404@gmail.com', '2025-05-24 16:16:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:16:00.000000', 'tia-to-organic-100g', 'Tía tô hữu cơ, thơm đặc trưng, dùng cho món cuốn và canh. Bảo quản tủ lạnh.', 'Tía tô Organic 100g', 15000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.1, 200, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 14, NULL, NULL, 4.4, 4),
('9a0aae00-5dfa-4c86-8f85-4f62faeec6cf', 'dotuandat2004nd@gmail.com', '2025-05-24 16:16:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:16:00.000000', 'la-lot-organic-100g', 'Lá lốt hữu cơ, thơm nồng, dùng cho món cuốn và xào. Bảo quản tủ lạnh.', 'Lá lốt Organic 100g', 16000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.1, 190, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 13, NULL, NULL, 4.3, 3),
('9d03cf1b-094c-4a09-b74f-7491540500ed', 'admin@gmail.com', '2025-05-24 16:16:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:16:00.000000', 'ngo-gai-organic-100g', 'Ngò gai hữu cơ, thơm đặc trưng, dùng cho phở và canh. Bảo quản tủ lạnh.', 'Ngò gai Organic 100g', 14000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.1, 200, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 12, NULL, NULL, 4.2, 3),
('9ffe51ac-e54e-4990-a338-97d860eb2bd1', 'pesmobile5404@gmail.com', '2025-05-24 16:16:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:16:00.000000', 'sa-organic-1kg', 'Sả hữu cơ, thơm nồng, dùng cho món kho và nướng. Bảo quản tủ lạnh.', 'Sả Organic 1kg', 25000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.2, 150, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 10, NULL, NULL, 4.5, 5),
('a04d8194-3c97-4d8b-8d6a-97263387563d', 'dotuandat2004nd@gmail.com', '2025-05-24 16:16:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:16:00.000000', 'gung-organic-1kg', 'Gừng hữu cơ, cay nồng, dùng cho món kho và trà. Bảo quản nơi khô ráo.', 'Gừng Organic 1kg', 35000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.2, 140, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 11, NULL, NULL, 4.4, 4),
('a16d1150-402d-45c4-8915-3e7e602511f6', 'admin@gmail.com', '2025-05-24 16:16:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:16:00.000000', 'ot-tuoi-organic-100g', 'Ớt tươi hữu cơ, cay nồng, dùng cho món xào và nước chấm. Bảo quản tủ lạnh.', 'Ớt tươi Organic 100g', 20000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.1, 180, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 13, NULL, NULL, 4.3, 3),
('a444a1a5-96fb-47fd-b67a-9f3db1d67105', 'pesmobile5404@gmail.com', '2025-05-24 16:16:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:16:00.000000', 'la-chanh-organic-100g', 'Lá chanh hữu cơ, thơm, dùng cho món nướng và canh. Bảo quản tủ lạnh.', 'Lá chanh Organic 100g', 18000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.1, 170, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 12, NULL, NULL, 4.4, 4),
-- Organic Farm VN (15 bản ghi)
('a80ce77b-c73a-4275-a6b6-30dc3ec14779', 'admin@gmail.com', '2025-05-24 16:16:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:16:00.000000', 'rau-mui-vn-organic-100g', 'Rau mùi hữu cơ từ Organic Farm VN, tươi sạch, dùng cho phở. Bảo quản tủ lạnh.', 'Rau mùi Organic VN 100g', 11000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.1, 190, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 14, 9900, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.2, 4),
('a8930bce-5e69-45b4-9653-a4f44e894c9d', 'dotuandat2004nd@gmail.com', '2025-05-24 16:16:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:16:00.000000', 'hung-que-vn-organic-100g', 'Húng quế hữu cơ, thơm, dùng cho phở. Bảo quản tủ lạnh.', 'Húng quế Organic VN 100g', 14000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.1, 170, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 11, NULL, NULL, 4.3, 3),
('ab93e3b9-2e84-4dfb-8e9e-2b907505143e', 'pesmobile5404@gmail.com', '2025-05-24 16:16:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:16:00.000000', 'hung-lui-vn-organic-100g', 'Húng lủi hữu cơ, thơm nồng, dùng cho món cuốn.', 'Húng lủi Organic VN 100g', 13000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.1, 180, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 10, NULL, NULL, 4.1, 2),
('adf2a47b-de30-449d-90d4-72d0991ae30d', 'admin@gmail.com', '2025-05-24 16:16:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:16:00.000000', 'rau-ram-vn-organic-100g', 'Rau răm hữu cơ, thơm, dùng cho gỏi gà.', 'Rau răm Organic VN 100g', 12000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.1, 200, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 13, NULL, NULL, 4.4, 4),
('af3a0e21-1a61-46a0-82b7-cf4697249c07', 'dotuandat2004nd@gmail.com', '2025-05-24 16:16:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:16:00.000000', 'hanh-la-vn-organic-100g', 'Hành lá hữu cơ, tươi xanh, dùng cho canh.', 'Hành lá Organic VN 100g', 9000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.1, 210, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 15, NULL, NULL, 4.0, 3),
('b24e6918-da98-45ab-816d-4f7750420ca3', 'pesmobile5404@gmail.com', '2025-05-24 16:16:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:16:00.000000', 'thi-la-vn-organic-100g', 'Thì là hữu cơ, thơm nhẹ, dùng cho canh cá.', 'Thì là Organic VN 100g', 15000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.1, 190, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 12, NULL, NULL, 4.2, 3),
('b2b5d2e3-7f13-49ca-91da-7bd969f794b8', 'admin@gmail.com', '2025-05-24 16:16:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:16:00.000000', 'bac-ha-vn-organic-100g', 'Bạc hà hữu cơ, thơm mát, dùng cho phở.', 'Bạc hà Organic VN 100g', 14000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.1, 180, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 10, NULL, NULL, 4.3, 4),
('b35565b0-c07f-4313-9fff-6c942c57dd00', 'dotuandat2004nd@gmail.com', '2025-05-24 16:16:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:16:00.000000', 'kinh-gioi-vn-organic-100g', 'Kinh giới hữu cơ, thơm, dùng cho món cuốn.', 'Kinh giới Organic VN 100g', 13000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.1, 200, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 11, NULL, NULL, 4.1, 2),
('b413354a-d216-40cc-8cbf-2d34f0a34e1b', 'pesmobile5404@gmail.com', '2025-05-24 16:16:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:16:00.000000', 'tia-to-vn-organic-100g', 'Tía tô hữu cơ, thơm, dùng cho món cuốn.', 'Tía tô Organic VN 100g', 14000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.1, 190, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 13, NULL, NULL, 4.4, 4),
('b461c187-71d2-4b95-853c-7312ae6d4950', 'admin@gmail.com', '2025-05-24 16:16:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:16:00.000000', 'la-lot-vn-organic-100g', 'Lá lốt hữu cơ, thơm nồng, dùng cho món xào.', 'Lá lốt Organic VN 100g', 15000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.1, 180, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 12, NULL, NULL, 4.3, 3),
('b5e3fe75-5fd3-451a-bf1d-4a212d14fa8a', 'dotuandat2004nd@gmail.com', '2025-05-24 16:16:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:16:00.000000', 'ngo-gai-vn-organic-100g', 'Ngò gai hữu cơ, thơm, dùng cho phở.', 'Ngò gai Organic VN 100g', 13000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.1, 190, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 11, NULL, NULL, 4.2, 3),
('b9dc0806-4e27-4cde-86da-ce5eda3ab7b5', 'pesmobile5404@gmail.com', '2025-05-24 16:16:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:16:00.000000', 'sa-vn-organic-1kg', 'Sả hữu cơ, thơm nồng, dùng cho món kho.', 'Sả Organic VN 1kg', 24000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.2, 140, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 10, NULL, NULL, 4.5, 5),
('bb530f69-9702-424d-bca2-fcfd89625c04', 'admin@gmail.com', '2025-05-24 16:16:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:16:00.000000', 'gung-vn-organic-1kg', 'Gừng hữu cơ, cay nồng, dùng cho trà.', 'Gừng Organic VN 1kg', 34000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.2, 130, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 11, NULL, NULL, 4.4, 4),
('bc4a7421-e936-4c35-83ce-ff54634ec146', 'dotuandat2004nd@gmail.com', '2025-05-24 16:16:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:16:00.000000', 'ot-tuoi-vn-organic-100g', 'Ớt tươi hữu cơ, cay nồng, dùng cho nước chấm.', 'Ớt tươi Organic VN 100g', 19000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.1, 170, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 12, NULL, NULL, 4.3, 3),
('bd0e6c67-f0c8-4848-8cf0-83a0d0194b77', 'pesmobile5404@gmail.com', '2025-05-24 16:16:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:16:00.000000', 'la-chanh-vn-organic-100g', 'Lá chanh hữu cơ, thơm, dùng cho món nướng.', 'Lá chanh Organic VN 100g', 17000, 'bc4d7360-ba80-46f7-acb5-b48d760ff07b', 0.1, 160, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 11, NULL, NULL, 4.4, 4),

--
-- Nấm
--
-- Dalat Greens (15 bản ghi)
('bd26bd43-71b8-427e-852f-bfb95e4066f1', 'dotuandat2004nd@gmail.com', '2025-05-24 16:21:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:21:00.000000', 'nam-rom-organic-500g', 'Nấm rơm hữu cơ từ Dalat Greens, tươi sạch, dùng cho món xào và lẩu. Bảo quản tủ lạnh.', 'Nấm rơm Organic 500g', 50000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.2, 150, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 10, 45000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.2, 4),
('be924284-9e15-4ecd-873a-ce466aeb702f', 'admin@gmail.com', '2025-05-24 16:21:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:21:00.000000', 'nam-bau-ngu-organic-500g', 'Nấm bào ngư hữu cơ, giòn, dùng cho món xào và canh. Bảo quản tủ lạnh.', 'Nấm bào ngư Organic 500g', 40000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.2, 160, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 12, NULL, NULL, 4.3, 3),
('be9b7393-24af-4d4a-b1ee-de629043ba9a', 'pesmobile5404@gmail.com', '2025-05-24 16:21:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:21:00.000000', 'nam-huong-tuoi-organic-500g', 'Nấm hương tươi hữu cơ, thơm, dùng cho món hầm và lẩu. Bảo quản tủ lạnh.', 'Nấm hương tươi Organic 500g', 120000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.3, 140, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 8, NULL, NULL, 4.5, 5),
('bf125273-6496-45a4-8d19-18050fad5746', 'dotuandat2004nd@gmail.com', '2025-05-24 16:21:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:21:00.000000', 'nam-kim-cham-organic-150g', 'Nấm kim châm hữu cơ, giòn, dùng cho lẩu và xào. Bảo quản tủ lạnh.', 'Nấm kim châm Organic 150g', 25000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.1, 180, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 15, NULL, NULL, 4.1, 3),
('bffb2145-7ced-4094-9ed6-3631f7132bcf', 'admin@gmail.com', '2025-05-24 16:21:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:21:00.000000', 'nam-dui-ga-organic-500g', 'Nấm đùi gà hữu cơ, dai giòn, dùng cho món nướng và xào. Bảo quản tủ lạnh.', 'Nấm đùi gà Organic 500g', 60000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.2, 130, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 9, NULL, NULL, 4.4, 4),
('c3565ea0-8639-40c7-9547-7b87deb0bf45', 'dotuandat2004nd@gmail.com', '2025-05-24 16:21:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:21:00.000000', 'nam-mo-organic-500g', 'Nấm mỡ hữu cơ, thơm, dùng cho món Âu và lẩu. Bảo quản tủ lạnh.', 'Nấm mỡ Organic 500g', 55000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.2, 150, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 11, NULL, NULL, 4.3, 4),
('c3fe95e4-d90e-4eb6-90eb-684097c2e74d', 'pesmobile5404@gmail.com', '2025-05-24 16:21:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:21:00.000000', 'nam-linh-chi-organic-500g', 'Nấm linh chi hữu cơ, bổ dưỡng, dùng nấu trà hoặc hầm. Bảo quản khô ráo.', 'Nấm linh chi Organic 500g', 250000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.4, 100, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 6, NULL, NULL, 4.6, 5),
('c4a9d42f-71a1-4c20-86e8-4c21e3469e6f', 'admin@gmail.com', '2025-05-24 16:21:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:21:00.000000', 'nam-tuyet-organic-500g', 'Nấm tuyết hữu cơ, giòn, dùng cho món chè và canh. Ngâm nước trước khi dùng.', 'Nấm tuyết Organic 500g', 80000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.3, 120, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 7, NULL, NULL, 4.2, 3),
('c873e3c6-4459-4134-9ea8-a5163db96242', 'dotuandat2004nd@gmail.com', '2025-05-24 16:21:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:21:00.000000', 'nam-meo-tuoi-organic-500g', 'Nấm mèo tươi hữu cơ, giòn, dùng cho món xào và canh. Ngâm nước trước khi dùng.', 'Nấm mèo tươi Organic 500g', 45000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.2, 140, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 10, NULL, NULL, 4.1, 3),
('c91b7ad8-0519-409e-9699-5ccb92fbf408', 'pesmobile5404@gmail.com', '2025-05-24 16:21:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:21:00.000000', 'nam-moi-organic-500g', 'Nấm mối hữu cơ, thơm ngon, dùng cho món xào và lẩu. Bảo quản tủ lạnh.', 'Nấm mối Organic 500g', 150000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.3, 110, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 8, NULL, NULL, 4.5, 4),
('cd38996d-e369-424f-bbb0-93c6ece6280a', 'admin@gmail.com', '2025-05-24 16:21:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:21:00.000000', 'nam-gan-bo-organic-500g', 'Nấm gan bò hữu cơ, đậm vị, dùng cho món nướng và xào. Bảo quản tủ lạnh.', 'Nấm gan bò Organic 500g', 90000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.3, 130, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 9, NULL, NULL, 4.4, 4),
('d14ff3f3-b2f1-4484-a77d-0df47c5a07b9', 'dotuandat2004nd@gmail.com', '2025-05-24 16:21:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:21:00.000000', 'nam-ngoc-cham-organic-150g', 'Nấm ngọc châm hữu cơ, ngọt, dùng cho lẩu và xào. Bảo quản tủ lạnh.', 'Nấm ngọc châm Organic 150g', 30000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.1, 170, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 12, NULL, NULL, 4.3, 3),
('d4aa66a2-3e73-47bf-b6b1-45db433af1e6', 'pesmobile5404@gmail.com', '2025-05-24 16:21:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:21:00.000000', 'nam-bach-ngoc-organic-500g', 'Nấm bạch ngọc hữu cơ, giòn ngọt, dùng cho món xào và lẩu. Bảo quản tủ lạnh.', 'Nấm bạch ngọc Organic 500g', 65000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.2, 150, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 10, NULL, NULL, 4.2, 4),
('d5321ce2-0cd1-4c9b-a956-93b4c750625c', 'admin@gmail.com', '2025-05-24 16:21:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:21:00.000000', 'nam-hau-thu-organic-500g', 'Nấm hầu thủ hữu cơ, thơm, dùng cho món xào và nướng. Bảo quản tủ lạnh.', 'Nấm hầu thủ Organic 500g', 70000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.2, 140, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 11, NULL, NULL, 4.4, 4),
('d72bf2ed-c66c-4a9c-86a6-a42938765694', 'dotuandat2004nd@gmail.com', '2025-05-24 16:21:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:21:00.000000', 'nam-truffle-organic-100g', 'Nấm truffle hữu cơ, hương vị đặc trưng, dùng cho món Âu. Bảo quản tủ lạnh.', 'Nấm truffle Organic 100g', 500000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.4, 80, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 5, NULL, NULL, 4.6, 5),
-- Organic Farm VN (15 bản ghi)
('d9ab74a7-c4ae-46d6-9457-fc93282c721d', 'admin@gmail.com', '2025-05-24 16:21:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:21:00.000000', 'nam-rom-vn-organic-500g', 'Nấm rơm hữu cơ từ Organic Farm VN, tươi sạch, dùng cho món xào. Bảo quản tủ lạnh.', 'Nấm rơm Organic VN 500g', 48000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.2, 140, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 9, 43200, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.2, 4),
('db4f0c9a-f449-4792-a64e-c55963f5e23e', 'dotuandat2004nd@gmail.com', '2025-05-24 16:21:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:21:00.000000', 'nam-bau-ngu-vn-organic-500g', 'Nấm bào ngư hữu cơ, giòn, dùng cho món canh. Bảo quản tủ lạnh.', 'Nấm bào ngư Organic VN 500g', 38000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.2, 150, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 11, NULL, NULL, 4.3, 3),
('dba4d96f-f938-4f7b-84fe-bfb1ed385e94', 'pesmobile5404@gmail.com', '2025-05-24 16:21:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:21:00.000000', 'nam-huong-tuoi-vn-organic-500g', 'Nấm hương tươi hữu cơ, thơm, dùng cho món lẩu. Bảo quản tủ lạnh.', 'Nấm hương tươi Organic VN 500g', 115000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.3, 130, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 7, NULL, NULL, 4.5, 5),
('de81ab29-a374-4f13-9f91-57f0a1be3bf1', 'admin@gmail.com', '2025-05-24 16:21:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:21:00.000000', 'nam-kim-cham-vn-organic-150g', 'Nấm kim châm hữu cơ, giòn, dùng cho lẩu. Bảo quản tủ lạnh.', 'Nấm kim châm Organic VN 150g', 24000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.1, 170, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 14, NULL, NULL, 4.1, 3),
('e0d72056-d567-4816-92d0-036e9342395a', 'dotuandat2004nd@gmail.com', '2025-05-24 16:21:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:21:00.000000', 'nam-dui-ga-vn-organic-500g', 'Nấm đùi gà hữu cơ, dai giòn, dùng cho món nướng. Bảo quản tủ lạnh.', 'Nấm đùi gà Organic VN 500g', 58000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.2, 120, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 8, NULL, NULL, 4.4, 4),
('e1730841-17f8-422d-8bc3-9898b5a136eb', 'pesmobile5404@gmail.com', '2025-05-24 16:21:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:21:00.000000', 'nam-mo-vn-organic-500g', 'Nấm mỡ hữu cơ, thơm, dùng cho món Âu. Bảo quản tủ lạnh.', 'Nấm mỡ Organic VN 500g', 53000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.2, 140, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 10, NULL, NULL, 4.3, 4),
('e4369512-d437-4cf0-9bbd-c4e6fc7829fe', 'admin@gmail.com', '2025-05-24 16:21:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:21:00.000000', 'nam-linh-chi-vn-organic-500g', 'Nấm linh chi hữu cơ, bổ dưỡng, dùng nấu trà. Bảo quản khô ráo.', 'Nấm linh chi Organic VN 500g', 240000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.4, 90, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 5, NULL, NULL, 4.6, 5),
('e4557f80-4dcc-4857-9f88-1dcf63544ede', 'dotuandat2004nd@gmail.com', '2025-05-24 16:21:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:21:00.000000', 'nam-tuyet-vn-organic-500g', 'Nấm tuyết hữu cơ, giòn, dùng cho món chè. Ngâm nước trước khi dùng.', 'Nấm tuyết Organic VN 500g', 78000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.3, 110, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 6, NULL, NULL, 4.2, 3),
('e464bb21-5c91-43de-a392-1f75c5446bb0', 'pesmobile5404@gmail.com', '2025-05-24 16:21:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:21:00.000000', 'nam-meo-tuoi-vn-organic-500g', 'Nấm mèo tươi hữu cơ, giòn, dùng cho món xào. Ngâm nước trước khi dùng.', 'Nấm mèo tươi Organic VN 500g', 43000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.2, 130, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 9, NULL, NULL, 4.1, 3),
('e4ce10ad-ea59-4e8e-bd7f-8d3b33052471', 'admin@gmail.com', '2025-05-24 16:21:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:21:00.000000', 'nam-moi-vn-organic-500g', 'Nấm mối hữu cơ, thơm ngon, dùng cho món lẩu. Bảo quản tủ lạnh.', 'Nấm mối Organic VN 500g', 145000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.3, 100, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 7, NULL, NULL, 4.5, 4),
('e58f1305-8b66-449d-b56d-a4f8f207f9b3', 'dotuandat2004nd@gmail.com', '2025-05-24 16:21:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:21:00.000000', 'nam-gan-bo-vn-organic-500g', 'Nấm gan bò hữu cơ, đậm vị, dùng cho món nướng. Bảo quản tủ lạnh.', 'Nấm gan bò Organic VN 500g', 88000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.3, 120, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 8, NULL, NULL, 4.4, 4),
('e5c1bb3b-0883-41ce-9d60-5c52db8ba084', 'pesmobile5404@gmail.com', '2025-05-24 16:21:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:21:00.000000', 'nam-ngoc-cham-vn-organic-150g', 'Nấm ngọc châm hữu cơ, ngọt, dùng cho lẩu. Bảo quản tủ lạnh.', 'Nấm ngọc châm Organic VN 150g', 29000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.1, 160, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 11, NULL, NULL, 4.3, 3),
('e901fdec-ac3e-447d-a0bb-dbd749902807', 'admin@gmail.com', '2025-05-24 16:21:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:21:00.000000', 'nam-bach-ngoc-vn-organic-500g', 'Nấm bạch ngọc hữu cơ, giòn ngọt, dùng cho món xào. Bảo quản tủ lạnh.', 'Nấm bạch ngọc Organic VN 500g', 63000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.2, 140, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 9, NULL, NULL, 4.2, 4),
('e9593383-23fa-41b6-a6e2-fff3cc4ffbb1', 'dotuandat2004nd@gmail.com', '2025-05-24 16:21:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:21:00.000000', 'nam-hau-thu-vn-organic-500g', 'Nấm hầu thủ hữu cơ, thơm, dùng cho món nướng. Bảo quản tủ lạnh.', 'Nấm hầu thủ Organic VN 500g', 68000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.2, 130, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 10, NULL, NULL, 4.4, 4),
('eadecf1a-53dd-4460-a0ed-4d175a2b000a', 'pesmobile5404@gmail.com', '2025-05-24 16:21:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:21:00.000000', 'nam-truffle-vn-organic-100g', 'Nấm truffle hữu cơ, hương vị đặc trưng, dùng cho món Âu. Bảo quản tủ lạnh.', 'Nấm truffle Organic VN 100g', 490000, 'd459df02-7e70-4b2e-9f33-0bcd1789c813', 0.4, 70, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 4, NULL, NULL, 4.6, 5),

--
-- Trái cây trong nước
--
-- Dalat Greens (15 bản ghi)
('ebfdedec-4fae-408f-8189-0a81acc23b4b', 'dotuandat2004nd@gmail.com', '2025-05-24 16:27:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:27:00.000000', 'xoai-cat-hoa-loc-organic-1kg', 'Xoài Cát Hòa Lộc hữu cơ từ Tiền Giang, ngọt thanh, dùng ăn tươi. Bảo quản tủ lạnh.', 'Xoài Cát Hòa Lộc Organic 1kg', 65000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.3, 120, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 15, 58500, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.5, 6),
('ec83953c-7ba7-4d80-9df7-af3585885022', 'admin@gmail.com', '2025-05-24 16:27:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:27:00.000000', 'chom-chom-organic-1kg', 'Chôm chôm hữu cơ từ Vĩnh Long, ngọt giòn, ăn tươi. Bảo quản nơi thoáng mát.', 'Chôm chôm Organic 1kg', 35000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.2, 150, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 12, NULL, NULL, 4.3, 4),
('ed919e14-5063-4b42-bcee-6c881db5d21c', 'pesmobile5404@gmail.com', '2025-05-24 16:27:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:27:00.000000', 'sau-rieng-ri6-organic-1kg', 'Sầu riêng Ri6 hữu cơ từ Tây Nguyên, thơm béo, ăn tươi. Bảo quản tủ lạnh.', 'Sầu riêng Ri6 Organic 1kg', 110000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.4, 80, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 10, NULL, NULL, 4.7, 8),
('ed9ef5ce-5cb6-4672-8a87-0f112214098c', 'dotuandat2004nd@gmail.com', '2025-05-24 16:27:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:27:00.000000', 'mang-cut-organic-1kg', 'Măng cụt hữu cơ từ Tiền Giang, ngọt thanh, ăn tươi. Bảo quản tủ lạnh.', 'Măng cụt Organic 1kg', 60000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.3, 100, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 14, NULL, NULL, 4.4, 5),
('ede4eaea-5dac-4d0b-93f2-ed1a3529f768', 'admin@gmail.com', '2025-05-24 16:27:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:27:00.000000', 'dua-organic-1kg', 'Dứa hữu cơ từ Tiền Giang, ngọt thơm, dùng ăn tươi hoặc ép nước. Bảo quản tủ lạnh.', 'Dứa Organic 1kg', 25000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.2, 140, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 16, NULL, NULL, 4.2, 4),
('eec01b6f-c078-4723-815b-6a6e08e2c062', 'pesmobile5404@gmail.com', '2025-05-24 16:27:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:27:00.000000', 'chuoi-gia-organic-1kg', 'Chuối già hữu cơ từ Đồng Nai, ngọt mềm, ăn tươi hoặc làm bánh. Bảo quản nơi thoáng mát.', 'Chuối già Organic 1kg', 30000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.2, 130, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 13, NULL, NULL, 4.3, 4),
('eee070b2-016f-4411-bd36-8eb4e07182e5', 'dotuandat2004nd@gmail.com', '2025-05-24 16:27:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:27:00.000000', 'buoi-dien-organic-1.5kg', 'Bưởi Diễn hữu cơ từ Hà Nội, ngọt thanh, dùng ăn tươi. Bảo quản nơi thoáng mát.', 'Bưởi Diễn Organic 1.5kg', 45000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.3, 110, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 11, NULL, NULL, 4.5, 5),
('f1d5d656-bc34-423a-bf2b-47aceefc6c13', 'admin@gmail.com', '2025-05-24 16:27:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:27:00.000000', 'cam-sanh-organic-1kg', 'Cam sành hữu cơ từ Hàm Yên, ngọt mọng, dùng ăn tươi hoặc ép nước. Bảo quản tủ lạnh.', 'Cam sành Organic 1kg', 35000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.2, 150, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 12, NULL, NULL, 4.4, 4),
('f2443cc6-4b03-473c-a37e-ccc773649e31', 'pesmobile5404@gmail.com', '2025-05-24 16:27:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:27:00.000000', 'mit-thai-organic-1kg', 'Mít Thái hữu cơ từ Tiền Giang, thơm ngọt, ăn tươi. Bảo quản tủ lạnh.', 'Mít Thái Organic 1kg', 40000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.2, 120, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 10, NULL, NULL, 4.3, 3),
('f27dfcf0-1022-4634-aa40-9dc92d858ab7', 'dotuandat2004nd@gmail.com', '2025-05-24 16:27:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:27:00.000000', 'thanh-long-organic-1kg', 'Thanh long hữu cơ từ Bình Thuận, ngọt mát, ăn tươi. Bảo quản tủ lạnh.', 'Thanh long Organic 1kg', 25000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.2, 160, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 14, NULL, NULL, 4.2, 4),
('f3906159-5d5d-4917-869d-980ebc4ea53a', 'admin@gmail.com', '2025-05-24 16:27:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:27:00.000000', 'dua-hau-organic-3kg', 'Dưa hấu hữu cơ từ Long An, ngọt giòn, ăn tươi hoặc ép nước. Bảo quản tủ lạnh.', 'Dưa hấu Organic 3kg', 60000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.3, 100, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 9, NULL, NULL, 4.4, 5),
('f53fb25d-f92d-4628-bd09-513cc3d90273', 'pesmobile5404@gmail.com', '2025-05-24 16:27:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:27:00.000000', 'nhan-long-organic-1kg', 'Nhãn lồng hữu cơ từ Hưng Yên, ngọt thanh, ăn tươi. Bảo quản nơi thoáng mát.', 'Nhãn lồng Organic 1kg', 45000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.3, 130, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 11, NULL, NULL, 4.5, 5),
('f5d82150-08f6-4702-b247-46f59df508ac', 'dotuandat2004nd@gmail.com', '2025-05-24 16:27:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:27:00.000000', 'vai-thieu-organic-1kg', 'Vải thiều hữu cơ từ Bắc Giang, ngọt mọng, ăn tươi. Bảo quản tủ lạnh.', 'Vải thiều Organic 1kg', 50000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.3, 140, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 13, NULL, NULL, 4.6, 6),
('f71f2e64-3edf-4994-8d2a-e21b81447c44', 'admin@gmail.com', '2025-05-24 16:27:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:27:00.000000', 'oi-cat-organic-1kg', 'Ổi Cát hữu cơ từ Đồng Tháp, giòn ngọt, ăn tươi. Bảo quản nơi thoáng mát.', 'Ổi Cát Organic 1kg', 30000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.2, 150, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 12, NULL, NULL, 4.3, 4),
('f75b73a8-353b-4412-8e85-040e376e94e5', 'pesmobile5404@gmail.com', '2025-05-24 16:27:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:27:00.000000', 'bo-hass-organic-1kg', 'Bơ Hass hữu cơ từ Đắk Lắk, béo ngậy, dùng làm sinh tố hoặc salad. Bảo quản tủ lạnh.', 'Bơ Hass Organic 1kg', 70000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.3, 110, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 10, NULL, NULL, 4.5, 5),
-- Organic Farm VN (15 bản ghi)
(UUID(), 'admin@gmail.com', '2025-05-24 16:27:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:27:00.000000', 'xoai-cat-hoa-loc-vn-organic-1kg', 'Xoài Cát Hòa Lộc hữu cơ từ Tiền Giang, ngọt thanh, ăn tươi. Bảo quản tủ lạnh.', 'Xoài Cát Hòa Lộc Organic VN 1kg', 62000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.3, 110, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 14, 55800, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.5, 6),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 16:27:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:27:00.000000', 'chom-chom-vn-organic-1kg', 'Chôm chôm hữu cơ từ Vĩnh Long, ngọt giòn, ăn tươi. Bảo quản nơi thoáng mát.', 'Chôm chôm Organic VN 1kg', 33000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.2, 140, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 11, NULL, NULL, 4.3, 4),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 16:27:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:27:00.000000', 'sau-rieng-ri6-vn-organic-1kg', 'Sầu riêng Ri6 hữu cơ từ Tây Nguyên, thơm béo, ăn tươi. Bảo quản tủ lạnh.', 'Sầu riêng Ri6 Organic VN 1kg', 105000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.4, 70, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 9, NULL, NULL, 4.7, 8),
(UUID(), 'admin@gmail.com', '2025-05-24 16:27:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:27:00.000000', 'mang-cut-vn-organic-1kg', 'Măng cụt hữu cơ từ Tiền Giang, ngọt thanh, ăn tươi. Bảo quản tủ lạnh.', 'Măng cụt Organic VN 1kg', 58000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.3, 90, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 13, NULL, NULL, 4.4, 5),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 16:27:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:27:00.000000', 'dua-vn-organic-1kg', 'Dứa hữu cơ từ Tiền Giang, ngọt thơm, ăn tươi hoặc ép nước. Bảo quản tủ lạnh.', 'Dứa Organic VN 1kg', 24000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.2, 130, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 15, NULL, NULL, 4.2, 4),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 16:27:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:27:00.000000', 'chuoi-gia-vn-organic-1kg', 'Chuối già hữu cơ từ Đồng Nai, ngọt mềm, ăn tươi. Bảo quản nơi thoáng mát.', 'Chuối già Organic VN 1kg', 28000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.2, 120, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 12, NULL, NULL, 4.3, 4),
(UUID(), 'admin@gmail.com', '2025-05-24 16:27:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:27:00.000000', 'buoi-dien-vn-organic-1.5kg', 'Bưởi Diễn hữu cơ từ Hà Nội, ngọt thanh, ăn tươi. Bảo quản nơi thoáng mát.', 'Bưởi Diễn Organic VN 1.5kg', 43000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.3, 100, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 10, NULL, NULL, 4.5, 5),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 16:27:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:27:00.000000', 'cam-sanh-vn-organic-1kg', 'Cam sành hữu cơ từ Hàm Yên, ngọt mọng, ép nước. Bảo quản tủ lạnh.', 'Cam sành Organic VN 1kg', 33000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.2, 140, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 11, NULL, NULL, 4.4, 4),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 16:27:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:27:00.000000', 'mit-thai-vn-organic-1kg', 'Mít Thái hữu cơ từ Tiền Giang, thơm ngọt, ăn tươi. Bảo quản tủ lạnh.', 'Mít Thái Organic VN 1kg', 38000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.2, 110, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 9, NULL, NULL, 4.3, 3),
(UUID(), 'admin@gmail.com', '2025-05-24 16:27:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:27:00.000000', 'thanh-long-vn-organic-1kg', 'Thanh long hữu cơ từ Bình Thuận, ngọt mát, ăn tươi. Bảo quản tủ lạnh.', 'Thanh long Organic VN 1kg', 24000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.2, 150, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 13, NULL, NULL, 4.2, 4),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 16:27:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:27:00.000000', 'dua-hau-vn-organic-3kg', 'Dưa hấu hữu cơ từ Long An, ngọt giòn, ép nước. Bảo quản tủ lạnh.', 'Dưa hấu Organic VN 3kg', 58000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.3, 90, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 8, NULL, NULL, 4.4, 5),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 16:27:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:27:00.000000', 'nhan-long-vn-organic-1kg', 'Nhãn lồng hữu cơ từ Hưng Yên, ngọt thanh, ăn tươi. Bảo quản nơi thoáng mát.', 'Nhãn lồng Organic VN 1kg', 43000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.3, 120, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 10, NULL, NULL, 4.5, 5),
(UUID(), 'admin@gmail.com', '2025-05-24 16:27:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:27:00.000000', 'vai-thieu-vn-organic-1kg', 'Vải thiều hữu cơ từ Bắc Giang, ngọt mọng, ăn tươi. Bảo quản tủ lạnh.', 'Vải thiều Organic VN 1kg', 48000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.3, 130, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 12, NULL, NULL, 4.6, 6),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 16:27:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:27:00.000000', 'oi-cat-vn-organic-1kg', 'Ổi Cát hữu cơ từ Đồng Tháp, giòn ngọt, ăn tươi. Bảo quản nơi thoáng mát.', 'Ổi Cát Organic VN 1kg', 28000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.2, 140, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 11, NULL, NULL, 4.3, 4),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 16:27:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:27:00.000000', 'bo-hass-vn-organic-1kg', 'Bơ Hass hữu cơ từ Đắk Lắk, béo ngậy, làm sinh tố. Bảo quản tủ lạnh.', 'Bơ Hass Organic VN 1kg', 68000, 'ee97933d-86ba-4e3c-8536-f9c70212fa09', 0.3, 100, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 9, NULL, NULL, 4.5, 5),

--
-- Trái cây nhập khẩu
--
-- Global Fruit Co. (15 bản ghi)
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 16:30:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:30:00.000000', 'tao-envy-my-1kg', 'Táo Envy nhập khẩu từ Mỹ, ngọt giòn, dùng ăn tươi hoặc làm salad. Bảo quản tủ lạnh.', 'Táo Envy Mỹ 1kg', 90000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.4, 100, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 10, 81000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.5, 8),
(UUID(), 'admin@gmail.com', '2025-05-24 16:30:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:30:00.000000', 'nho-mau-don-han-1kg', 'Nho mẫu đơn nhập khẩu từ Hàn Quốc, ngọt thanh, ăn tươi. Bảo quản tủ lạnh.', 'Nho mẫu đơn Hàn Quốc 1kg', 220000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.5, 80, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 8, NULL, NULL, 4.7, 9),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 16:30:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:30:00.000000', 'cam-naval-my-1kg', 'Cam Naval nhập khẩu từ Mỹ, mọng nước, dùng ép nước hoặc ăn tươi. Bảo quản tủ lạnh.', 'Cam Naval Mỹ 1kg', 85000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.4, 120, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 12, NULL, NULL, 4.4, 7),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 16:30:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:30:00.000000', 'kiwi-vang-nz-1kg', 'Kiwi vàng nhập khẩu từ New Zealand, ngọt thanh, giàu vitamin C. Bảo quản tủ lạnh.', 'Kiwi vàng New Zealand 1kg', 160000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.4, 90, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 9, NULL, NULL, 4.6, 8),
(UUID(), 'admin@gmail.com', '2025-05-24 16:30:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:30:00.000000', 'cherry-my-500g', 'Cherry nhập khẩu từ Mỹ, ngọt mọng, ăn tươi. Bảo quản tủ lạnh.', 'Cherry Mỹ 500g', 190000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.5, 70, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 7, NULL, NULL, 4.8, 10),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 16:30:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:30:00.000000', 'dau-tay-han-500g', 'Dâu tây nhập khẩu từ Hàn Quốc, ngọt nhẹ, dùng ăn tươi hoặc làm bánh. Bảo quản tủ lạnh.', 'Dâu tây Hàn Quốc 500g', 210000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.5, 80, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 8, NULL, NULL, 4.7, 9),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 16:30:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:30:00.000000', 'le-han-1kg', 'Lê nhập khẩu từ Hàn Quốc, giòn ngọt, ăn tươi. Bảo quản tủ lạnh.', 'Lê Hàn Quốc 1kg', 95000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.4, 110, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 10, NULL, NULL, 4.5, 7),
(UUID(), 'admin@gmail.com', '2025-05-24 16:30:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:30:00.000000', 'luu-peru-1kg', 'Lựu nhập khẩu từ Peru, ngọt chua, dùng ăn tươi hoặc ép nước. Bảo quản tủ lạnh.', 'Lựu Peru 1kg', 120000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.4, 100, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 9, NULL, NULL, 4.4, 6),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 16:30:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:30:00.000000', 'buoi-hong-my-1kg', 'Bưởi hồng nhập khẩu từ Mỹ, ngọt thanh, ăn tươi. Bảo quản tủ lạnh.', 'Bưởi hồng Mỹ 1kg', 110000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.4, 90, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 8, NULL, NULL, 4.6, 7),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 16:30:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:30:00.000000', 'xoai-uc-1kg', 'Xoài nhập khẩu từ Úc, ngọt thơm, ăn tươi. Bảo quản tủ lạnh.', 'Xoài Úc 1kg', 130000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.4, 100, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 9, NULL, NULL, 4.5, 6),
(UUID(), 'admin@gmail.com', '2025-05-24 16:30:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:30:00.000000', 'chanh-day-colombia-1kg', 'Chanh dây nhập khẩu từ Colombia, chua ngọt, dùng làm nước ép. Bảo quản tủ lạnh.', 'Chanh dây Colombia 1kg', 90000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.3, 110, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 10, NULL, NULL, 4.4, 5),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 16:30:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:30:00.000000', 'man-my-1kg', 'Mận nhập khẩu từ Mỹ, ngọt chua, ăn tươi. Bảo quản tủ lạnh.', 'Mận Mỹ 1kg', 140000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.4, 90, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 8, NULL, NULL, 4.5, 6),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 16:30:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:30:00.000000', 'dao-my-1kg', 'Đào nhập khẩu từ Mỹ, ngọt mềm, ăn tươi hoặc làm bánh. Bảo quản tủ lạnh.', 'Đào Mỹ 1kg', 150000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.4, 80, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 7, NULL, NULL, 4.6, 7),
(UUID(), 'admin@gmail.com', '2025-05-24 16:30:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:30:00.000000', 'viet-quat-my-500g', 'Việt quất nhập khẩu từ Mỹ, ngọt nhẹ, dùng ăn tươi hoặc làm sinh tố. Bảo quản tủ lạnh.', 'Việt quất Mỹ 500g', 200000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.5, 70, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 6, NULL, NULL, 4.7, 8),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 16:30:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:30:00.000000', 'mam-xoi-my-500g', 'Mâm xôi nhập khẩu từ Mỹ, chua ngọt, dùng làm bánh hoặc ăn tươi. Bảo quản tủ lạnh.', 'Mâm xôi Mỹ 500g', 210000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.5, 60, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 5, NULL, NULL, 4.8, 9),
-- Import Fresh VN (15 bản ghi)
(UUID(), 'admin@gmail.com', '2025-05-24 16:30:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:30:00.000000', 'tao-envy-my-vn-1kg', 'Táo Envy nhập khẩu từ Mỹ, ngọt giòn, dùng ăn tươi. Bảo quản tủ lạnh.', 'Táo Envy Mỹ VN 1kg', 88000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.4, 90, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 9, 79200, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.5, 8),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 16:30:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:30:00.000000', 'nho-mau-don-han-vn-1kg', 'Nho mẫu đơn nhập khẩu từ Hàn Quốc, ngọt thanh, ăn tươi. Bảo quản tủ lạnh.', 'Nho mẫu đơn Hàn Quốc VN 1kg', 215000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.5, 70, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 7, NULL, NULL, 4.7, 9),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 16:30:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:30:00.000000', 'cam-naval-my-vn-1kg', 'Cam Naval nhập khẩu từ Mỹ, mọng nước, ép nước. Bảo quản tủ lạnh.', 'Cam Naval Mỹ VN 1kg', 83000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.4, 110, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 11, NULL, NULL, 4.4, 7),
(UUID(), 'admin@gmail.com', '2025-05-24 16:30:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:30:00.000000', 'kiwi-vang-nz-vn-1kg', 'Kiwi vàng nhập khẩu từ New Zealand, ngọt thanh. Bảo quản tủ lạnh.', 'Kiwi vàng New Zealand VN 1kg', 155000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.4, 80, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 8, NULL, NULL, 4.6, 8),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 16:30:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:30:00.000000', 'cherry-my-vn-500g', 'Cherry nhập khẩu từ Mỹ, ngọt mọng, ăn tươi. Bảo quản tủ lạnh.', 'Cherry Mỹ VN 500g', 185000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.5, 60, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 6, NULL, NULL, 4.8, 10),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 16:30:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:30:00.000000', 'dau-tay-han-vn-500g', 'Dâu tây nhập khẩu từ Hàn Quốc, ngọt nhẹ, làm bánh. Bảo quản tủ lạnh.', 'Dâu tây Hàn Quốc VN 500g', 205000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.5, 70, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 7, NULL, NULL, 4.7, 9),
(UUID(), 'admin@gmail.com', '2025-05-24 16:30:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:30:00.000000', 'le-han-vn-1kg', 'Lê nhập khẩu từ Hàn Quốc, giòn ngọt, ăn tươi. Bảo quản tủ lạnh.', 'Lê Hàn Quốc VN 1kg', 93000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.4, 100, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 9, NULL, NULL, 4.5, 7),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 16:30:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:30:00.000000', 'luu-peru-vn-1kg', 'Lựu nhập khẩu từ Peru, ngọt chua, ép nước. Bảo quản tủ lạnh.', 'Lựu Peru VN 1kg', 118000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.4, 90, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 8, NULL, NULL, 4.4, 6),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 16:30:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:30:00.000000', 'buoi-hong-my-vn-1kg', 'Bưởi hồng nhập khẩu từ Mỹ, ngọt thanh, ăn tươi. Bảo quản tủ lạnh.', 'Bưởi hồng Mỹ VN 1kg', 108000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.4, 80, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 7, NULL, NULL, 4.6, 7),
(UUID(), 'admin@gmail.com', '2025-05-24 16:30:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:30:00.000000', 'xoai-uc-vn-1kg', 'Xoài nhập khẩu từ Úc, ngọt thơm, ăn tươi. Bảo quản tủ lạnh.', 'Xoài Úc VN 1kg', 128000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.4, 90, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 8, NULL, NULL, 4.5, 6),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 16:30:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:30:00.000000', 'chanh-day-colombia-vn-1kg', 'Chanh dây nhập khẩu từ Colombia, chua ngọt, làm nước ép. Bảo quản tủ lạnh.', 'Chanh dây Colombia VN 1kg', 88000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.3, 100, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 9, NULL, NULL, 4.4, 5),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 16:30:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:30:00.000000', 'man-my-vn-1kg', 'Mận nhập khẩu từ Mỹ, ngọt chua, ăn tươi. Bảo quản tủ lạnh.', 'Mận Mỹ VN 1kg', 138000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.4, 80, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 7, NULL, NULL, 4.5, 6),
(UUID(), 'admin@gmail.com', '2025-05-24 16:30:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:30:00.000000', 'dao-my-vn-1kg', 'Đào nhập khẩu từ Mỹ, ngọt mềm, làm bánh. Bảo quản tủ lạnh.', 'Đào Mỹ VN 1kg', 148000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.4, 70, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 6, NULL, NULL, 4.6, 7),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 16:30:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:30:00.000000', 'viet-quat-my-vn-500g', 'Việt quất nhập khẩu từ Mỹ, ngọt nhẹ, làm sinh tố. Bảo quản tủ lạnh.', 'Việt quất Mỹ VN 500g', 195000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.5, 60, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 5, NULL, NULL, 4.7, 8),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 16:30:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:30:00.000000', 'mam-xoi-my-vn-500g', 'Mâm xôi nhập khẩu từ Mỹ, chua ngọt, làm bánh. Bảo quản tủ lạnh.', 'Mâm xôi Mỹ VN 500g', 205000, 'f15405dd-ba41-4954-bad6-65232a8309ab', 0.5, 50, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 4, NULL, NULL, 4.8, 9),

--
-- Trái cây sấy khô
--
-- Dalat Greens (15 bản ghi)
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 16:41:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:41:00.000000', 'xoai-say-deo-500g', 'Xoài sấy dẻo tự nhiên từ Tiền Giang, ngọt thơm, dùng làm snack. Bảo quản nơi khô ráo.', 'Xoài sấy dẻo 500g', 90000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.3, 150, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 12, 81000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.4, 6),
(UUID(), 'admin@gmail.com', '2025-05-24 16:41:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:41:00.000000', 'mit-say-500g', 'Mít sấy tự nhiên từ Đồng Tháp, giòn thơm, dùng làm snack. Bảo quản nơi khô ráo.', 'Mít sấy 500g', 80000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.3, 140, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 10, NULL, NULL, 4.3, 5),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 16:41:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:41:00.000000', 'chuoi-say-500g', 'Chuối sấy tự nhiên từ Đồng Nai, ngọt mềm, dùng làm snack. Bảo quản nơi khô ráo.', 'Chuối sấy 500g', 60000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.2, 160, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 14, NULL, NULL, 4.2, 4),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 16:41:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:41:00.000000', 'dua-say-500g', 'Dứa sấy tự nhiên từ Tiền Giang, chua ngọt, dùng làm snack. Bảo quản nơi khô ráo.', 'Dứa sấy 500g', 85000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.3, 130, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 11, NULL, NULL, 4.4, 5),
(UUID(), 'admin@gmail.com', '2025-05-24 16:41:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:41:00.000000', 'tao-say-500g', 'Táo sấy tự nhiên, giòn ngọt, dùng làm snack hoặc nấu chè. Bảo quản nơi khô ráo.', 'Táo sấy 500g', 100000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.3, 120, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 9, NULL, NULL, 4.5, 6),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 16:41:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:41:00.000000', 'nho-kho-500g', 'Nho khô tự nhiên, ngọt đậm, dùng làm bánh hoặc ăn trực tiếp. Bảo quản nơi khô ráo.', 'Nho khô 500g', 70000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.2, 170, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 15, NULL, NULL, 4.3, 4),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 16:41:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:41:00.000000', 'cha-la-500g', 'Chà là tự nhiên, ngọt đậm, dùng làm snack hoặc pha trà. Bảo quản nơi khô ráo.', 'Chà là 500g', 110000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.4, 110, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 8, NULL, NULL, 4.6, 7),
(UUID(), 'admin@gmail.com', '2025-05-24 16:41:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:41:00.000000', 'mo-say-500g', 'Mơ sấy tự nhiên, chua ngọt, dùng làm snack hoặc nấu nước. Bảo quản nơi khô ráo.', 'Mơ sấy 500g', 95000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.3, 130, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 10, NULL, NULL, 4.4, 5),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 16:41:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:41:00.000000', 'kiwi-say-500g', 'Kiwi sấy tự nhiên, chua ngọt, dùng làm snack. Bảo quản nơi khô ráo.', 'Kiwi sấy 500g', 120000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.4, 100, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 9, NULL, NULL, 4.5, 6),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 16:41:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:41:00.000000', 'dau-tay-say-500g', 'Dâu tây sấy tự nhiên, ngọt nhẹ, dùng làm bánh hoặc snack. Bảo quản nơi khô ráo.', 'Dâu tây sấy 500g', 160000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.5, 90, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 8, NULL, NULL, 4.7, 8),
(UUID(), 'admin@gmail.com', '2025-05-24 16:41:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:41:00.000000', 'thanh-long-say-500g', 'Thanh long sấy tự nhiên từ Bình Thuận, ngọt nhẹ, dùng làm snack. Bảo quản nơi khô ráo.', 'Thanh long sấy 500g', 85000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.3, 140, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 11, NULL, NULL, 4.3, 4),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 16:41:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:41:00.000000', 'vai-say-500g', 'Vải sấy tự nhiên từ Bắc Giang, ngọt đậm, dùng làm snack. Bảo quản nơi khô ráo.', 'Vải sấy 500g', 90000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.3, 130, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 10, NULL, NULL, 4.4, 5),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 16:41:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:41:00.000000', 'nhan-say-500g', 'Nhãn sấy tự nhiên từ Hưng Yên, ngọt thơm, dùng làm snack. Bảo quản nơi khô ráo.', 'Nhãn sấy 500g', 95000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.3, 120, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 9, NULL, NULL, 4.5, 6),
(UUID(), 'admin@gmail.com', '2025-05-24 16:41:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:41:00.000000', 'oi-say-500g', 'Ổi sấy tự nhiên từ Đồng Tháp, chua ngọt, dùng làm snack. Bảo quản nơi khô ráo.', 'Ổi sấy 500g', 80000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.3, 150, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 12, NULL, NULL, 4.3, 4),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 16:41:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:41:00.000000', 'buoi-say-500g', 'Bưởi sấy tự nhiên, chua ngọt, dùng làm snack hoặc pha trà. Bảo quản nơi khô ráo.', 'Bưởi sấy 500g', 100000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.3, 110, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 8, NULL, NULL, 4.4, 5),
-- Organic Farm VN (15 bản ghi)
(UUID(), 'admin@gmail.com', '2025-05-24 16:41:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:41:00.000000', 'xoai-say-deo-vn-500g', 'Xoài sấy dẻo tự nhiên từ Tiền Giang, ngọt thơm, dùng làm snack. Bảo quản nơi khô ráo.', 'Xoài sấy dẻo VN 500g', 88000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.3, 140, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 11, 79200, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.4, 6),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 16:41:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:41:00.000000', 'mit-say-vn-500g', 'Mít sấy tự nhiên từ Đồng Tháp, giòn thơm, dùng làm snack. Bảo quản nơi khô ráo.', 'Mít sấy VN 500g', 78000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.3, 130, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 9, NULL, NULL, 4.3, 5),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 16:41:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:41:00.000000', 'chuoi-say-vn-500g', 'Chuối sấy tự nhiên từ Đồng Nai, ngọt mềm, dùng làm snack. Bảo quản nơi khô ráo.', 'Chuối sấy VN 500g', 58000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.2, 150, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 13, NULL, NULL, 4.2, 4),
(UUID(), 'admin@gmail.com', '2025-05-24 16:41:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:41:00.000000', 'dua-say-vn-500g', 'Dứa sấy tự nhiên từ Tiền Giang, chua ngọt, dùng làm snack. Bảo quản nơi khô ráo.', 'Dứa sấy VN 500g', 83000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.3, 120, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 10, NULL, NULL, 4.4, 5),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 16:41:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:41:00.000000', 'tao-say-vn-500g', 'Táo sấy tự nhiên, giòn ngọt, dùng làm snack hoặc nấu chè. Bảo quản nơi khô ráo.', 'Táo sấy VN 500g', 98000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.3, 110, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 8, NULL, NULL, 4.5, 6),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 16:41:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:41:00.000000', 'nho-kho-vn-500g', 'Nho khô tự nhiên, ngọt đậm, dùng làm bánh. Bảo quản nơi khô ráo.', 'Nho khô VN 500g', 68000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.2, 160, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 14, NULL, NULL, 4.3, 4),
(UUID(), 'admin@gmail.com', '2025-05-24 16:41:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:41:00.000000', 'cha-la-vn-500g', 'Chà là tự nhiên, ngọt đậm, dùng làm snack. Bảo quản nơi khô ráo.', 'Chà là VN 500g', 108000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.4, 100, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 7, NULL, NULL, 4.6, 7),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 16:41:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:41:00.000000', 'mo-say-vn-500g', 'Mơ sấy tự nhiên, chua ngọt, dùng làm snack. Bảo quản nơi khô ráo.', 'Mơ sấy VN 500g', 93000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.3, 120, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 9, NULL, NULL, 4.4, 5),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 16:41:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:41:00.000000', 'kiwi-say-vn-500g', 'Kiwi sấy tự nhiên, chua ngọt, dùng làm snack. Bảo quản nơi khô ráo.', 'Kiwi sấy VN 500g', 118000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.4, 90, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 8, NULL, NULL, 4.5, 6),
(UUID(), 'admin@gmail.com', '2025-05-24 16:41:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:41:00.000000', 'dau-tay-say-vn-500g', 'Dâu tây sấy tự nhiên, ngọt nhẹ, dùng làm bánh. Bảo quản nơi khô ráo.', 'Dâu tây sấy VN 500g', 158000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.5, 80, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 7, NULL, NULL, 4.7, 8),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 16:41:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:41:00.000000', 'thanh-long-say-vn-500g', 'Thanh long sấy tự nhiên từ Bình Thuận, ngọt nhẹ, dùng làm snack. Bảo quản nơi khô ráo.', 'Thanh long sấy VN 500g', 83000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.3, 130, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 10, NULL, NULL, 4.3, 4),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 16:41:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:41:00.000000', 'vai-say-vn-500g', 'Vải sấy tự nhiên từ Bắc Giang, ngọt đậm, dùng làm snack. Bảo quản nơi khô ráo.', 'Vải sấy VN 500g', 88000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.3, 120, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 9, NULL, NULL, 4.4, 5),
(UUID(), 'admin@gmail.com', '2025-05-24 16:41:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 16:41:00.000000', 'nhan-say-vn-500g', 'Nhãn sấy tự nhiên từ Hưng Yên, ngọt thơm, dùng làm snack. Bảo quản nơi khô ráo.', 'Nhãn sấy VN 500g', 93000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.3, 110, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 8, NULL, NULL, 4.5, 6),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 16:41:00.000000', 1, 'admin@gmail.com', '2025-05-24 16:41:00.000000', 'oi-say-vn-500g', 'Ổi sấy tự nhiên từ Đồng Tháp, chua ngọt, dùng làm snack. Bảo quản nơi khô ráo.', 'Ổi sấy VN 500g', 78000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.3, 140, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 11, NULL, NULL, 4.3, 4),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 16:41:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 16:41:00.000000', 'buoi-say-vn-500g', 'Bưởi sấy tự nhiên, chua ngọt, dùng làm snack hoặc pha trà. Bảo quản nơi khô ráo.', 'Bưởi sấy VN 500g', 98000, '3707cb66-e53a-4295-a5d3-845625c924b6', 0.3, 100, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 7, NULL, NULL, 4.4, 5),

--
-- Thịt bò
--
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:26:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:26:00.000000', 'than-noi-bo-vissan-500g', 'Thăn nội bò Vissan từ bò Úc, mềm ngon, thích hợp nướng hoặc áp chảo. Bảo quản đông lạnh.', 'Thăn nội bò Vissan 500g', 400000, '31f57c4c-b50c-485f-993f-4c480877b3f5', 0.6, 80, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 12, 360000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.7, 8),
(UUID(), 'admin@gmail.com', '2025-05-24 17:26:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:26:00.000000', 'than-ngoai-bo-vissan-500g', 'Thăn ngoại bò Vissan từ bò Úc, thơm ngon, dùng cho bít tết hoặc nướng. Bảo quản đông lạnh.', 'Thăn ngoại bò Vissan 500g', 250000, '31f57c4c-b50c-485f-993f-4c480877b3f5', 0.5, 100, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 15, NULL, NULL, 4.6, 7),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:26:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:26:00.000000', 'bap-bo-vissan-500g', 'Bắp bò Vissan từ bò Việt Nam, săn chắc, thích hợp hầm hoặc xào. Bảo quản đông lạnh.', 'Bắp bò Vissan 500g', 175000, '31f57c4c-b50c-485f-993f-4c480877b3f5', 0.4, 120, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 10, NULL, NULL, 4.5, 6),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:26:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:26:00.000000', 'dui-bo-vissan-500g', 'Đùi bò Vissan từ bò Việt Nam, mềm, dùng cho lẩu hoặc xào. Bảo quản đông lạnh.', 'Đùi bò Vissan 500g', 170000, '31f57c4c-b50c-485f-993f-4c480877b3f5', 0.4, 110, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 13, NULL, NULL, 4.4, 5),
(UUID(), 'admin@gmail.com', '2025-05-24 17:26:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:26:00.000000', 'nac-vai-bo-vissan-500g', 'Nạc vai bò Vissan từ bò Việt Nam, mềm ngon, dùng cho xào hoặc nướng. Bảo quản đông lạnh.', 'Nạc vai bò Vissan 500g', 180000, '31f57c4c-b50c-485f-993f-4c480877b3f5', 0.4, 100, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 11, NULL, NULL, 4.5, 6),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:26:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:26:00.000000', 'ba-chi-bo-vissan-500g', 'Ba chỉ bò Vissan từ bò Úc, béo ngậy, thích hợp nướng hoặc lẩu. Bảo quản đông lạnh.', 'Ba chỉ bò Vissan 500g', 200000, '31f57c4c-b50c-485f-993f-4c480877b3f5', 0.5, 90, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 14, NULL, NULL, 4.6, 7),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:26:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:26:00.000000', 'xuong-bo-vissan-1kg', 'Xương bò Vissan từ bò Việt Nam, ngọt nước, dùng hầm canh hoặc phở. Bảo quản đông lạnh.', 'Xương bò Vissan 1kg', 75000, '31f57c4c-b50c-485f-993f-4c480877b3f5', 0.3, 130, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 16, NULL, NULL, 4.3, 4),
(UUID(), 'admin@gmail.com', '2025-05-24 17:26:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:26:00.000000', 'suon-bo-vissan-500g', 'Sườn bò Vissan từ bò Úc, chắc thịt, thích hợp nướng hoặc hầm. Bảo quản đông lạnh.', 'Sườn bò Vissan 500g', 220000, '31f57c4c-b50c-485f-993f-4c480877b3f5', 0.5, 80, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 9, NULL, NULL, 4.7, 8),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:26:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:26:00.000000', 'bo-xay-vissan-500g', 'Thịt bò xay Vissan từ bò Việt Nam, tươi ngon, dùng cho xào hoặc làm chả. Bảo quản đông lạnh.', 'Thịt bò xay Vissan 500g', 160000, '31f57c4c-b50c-485f-993f-4c480877b3f5', 0.4, 120, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 12, NULL, NULL, 4.4, 5),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:26:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:26:00.000000', 'gan-bo-vissan-500g', 'Gân bò Vissan từ bò Việt Nam, dai giòn, dùng hầm hoặc xào. Bảo quản đông lạnh.', 'Gân bò Vissan 500g', 140000, '31f57c4c-b50c-485f-993f-4c480877b3f5', 0.4, 100, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 10, NULL, NULL, 4.3, 4),
(UUID(), 'admin@gmail.com', '2025-05-24 17:26:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:26:00.000000', 'than-noi-bo-vissan-1kg', 'Thăn nội bò Vissan từ bò Úc, mềm ngon, thích hợp nướng hoặc áp chảo. Bảo quản đông lạnh.', 'Thăn nội bò Vissan 1kg', 780000, '31f57c4c-b50c-485f-993f-4c480877b3f5', 0.7, 60, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 8, 702000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.8, 9),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:26:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:26:00.000000', 'than-ngoai-bo-vissan-1kg', 'Thăn ngoại bò Vissan từ bò Úc, thơm ngon, dùng cho bít tết. Bảo quản đông lạnh.', 'Thăn ngoại bò Vissan 1kg', 480000, '31f57c4c-b50c-485f-993f-4c480877b3f5', 0.6, 70, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 10, NULL, NULL, 4.6, 7),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:26:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:26:00.000000', 'bap-bo-vissan-1kg', 'Bắp bò Vissan từ bò Việt Nam, săn chắc, thích hợp hầm. Bảo quản đông lạnh.', 'Bắp bò Vissan 1kg', 340000, '31f57c4c-b50c-485f-993f-4c480877b3f5', 0.5, 90, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 11, NULL, NULL, 4.5, 6),
(UUID(), 'admin@gmail.com', '2025-05-24 17:26:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:26:00.000000', 'dui-bo-vissan-1kg', 'Đùi bò Vissan từ bò Việt Nam, mềm, dùng cho lẩu. Bảo quản đông lạnh.', 'Đùi bò Vissan 1kg', 330000, '31f57c4c-b50c-485f-993f-4c480877b3f5', 0.5, 100, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 12, NULL, NULL, 4.4, 5),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:26:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:26:00.000000', 'nac-vai-bo-vissan-1kg', 'Nạc vai bò Vissan từ bò Việt Nam, mềm ngon, dùng cho xào. Bảo quản đông lạnh.', 'Nạc vai bò Vissan 1kg', 350000, '31f57c4c-b50c-485f-993f-4c480877b3f5', 0.5, 80, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 10, NULL, NULL, 4.5, 6),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:26:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:26:00.000000', 'ba-chi-bo-vissan-1kg', 'Ba chỉ bò Vissan từ bò Úc, béo ngậy, thích hợp nướng. Bảo quản đông lạnh.', 'Ba chỉ bò Vissan 1kg', 390000, '31f57c4c-b50c-485f-993f-4c480877b3f5', 0.6, 70, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 13, NULL, NULL, 4.6, 7),
(UUID(), 'admin@gmail.com', '2025-05-24 17:26:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:26:00.000000', 'suon-bo-vissan-1kg', 'Sườn bò Vissan từ bò Úc, chắc thịt, thích hợp nướng. Bảo quản đông lạnh.', 'Sườn bò Vissan 1kg', 430000, '31f57c4c-b50c-485f-993f-4c480877b3f5', 0.6, 60, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 8, NULL, NULL, 4.7, 8),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:26:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:26:00.000000', 'bo-xay-vissan-1kg', 'Thịt bò xay Vissan từ bò Việt Nam, tươi ngon, dùng cho xào. Bảo quản đông lạnh.', 'Thịt bò xay Vissan 1kg', 310000, '31f57c4c-b50c-485f-993f-4c480877b3f5', 0.5, 110, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 11, NULL, NULL, 4.4, 5),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:26:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:26:00.000000', 'gan-bo-vissan-1kg', 'Gân bò Vissan từ bò Việt Nam, dai giòn, dùng hầm. Bảo quản đông lạnh.', 'Gân bò Vissan 1kg', 270000, '31f57c4c-b50c-485f-993f-4c480877b3f5', 0.5, 90, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 9, NULL, NULL, 4.3, 4),
(UUID(), 'admin@gmail.com', '2025-05-24 17:26:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:26:00.000000', 'than-noi-bo-vissan-premium-500g', 'Thăn nội bò Vissan cao cấp từ bò Úc, mềm mịn, dùng cho bít tết. Bảo quản đông lạnh.', 'Thăn nội bò Vissan Premium 500g', 450000, '31f57c4c-b50c-485f-993f-4c480877b3f5', 0.7, 50, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 7, 405000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.8, 10),

--
-- Thủy hải sản
--
-- Vissan (10 bản ghi)
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:30:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:30:00.000000', 'ca-hoi-phi-le-vissan-500g', 'Cá hồi phi lê Vissan từ Na Uy, tươi ngon, thích hợp làm sashimi hoặc nướng. Bảo quản đông lạnh.', 'Cá hồi phi lê Vissan 500g', 250000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.5, 100, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 12, 225000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.7, 8),
(UUID(), 'admin@gmail.com', '2025-05-24 17:30:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:30:00.000000', 'tom-su-vissan-500g', 'Tôm sú Vissan từ Cà Mau, tươi ngọt, dùng cho lẩu hoặc nướng. Bảo quản đông lạnh.', 'Tôm sú Vissan 500g', 175000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.4, 120, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 15, NULL, NULL, 4.6, 7),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:30:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:30:00.000000', 'muc-ong-vissan-500g', 'Mực ống Vissan từ Phú Quốc, tươi ngon, dùng chiên hoặc nướng. Bảo quản đông lạnh.', 'Mực ống Vissan 500g', 120000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.4, 110, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 10, NULL, NULL, 4.5, 6),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:30:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:30:00.000000', 'ca-basa-phi-le-vissan-500g', 'Cá basa phi lê Vissan từ Đồng Tháp, mềm ngon, dùng chiên hoặc hấp. Bảo quản đông lạnh.', 'Cá basa phi lê Vissan 500g', 60000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.3, 150, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 18, NULL, NULL, 4.4, 5),
(UUID(), 'admin@gmail.com', '2025-05-24 17:30:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:30:00.000000', 'ngheu-vissan-1kg', 'Nghêu Vissan từ Tiền Giang, ngọt thịt, dùng nấu canh hoặc hấp. Bảo quản tủ lạnh.', 'Nghêu Vissan 1kg', 50000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.3, 200, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 20, NULL, NULL, 4.3, 4),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:30:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:30:00.000000', 'ca-thu-vissan-500g', 'Cá thu Vissan từ Nha Trang, thơm ngon, dùng kho hoặc chiên. Bảo quản đông lạnh.', 'Cá thu Vissan 500g', 90000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.3, 130, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 14, NULL, NULL, 4.5, 6),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:30:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:30:00.000000', 'tom-the-vissan-500g', 'Tôm thẻ Vissan từ Bạc Liêu, tươi ngọt, dùng xào hoặc hấp. Bảo quản đông lạnh.', 'Tôm thẻ Vissan 500g', 140000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.4, 110, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 12, NULL, NULL, 4.4, 5),
(UUID(), 'admin@gmail.com', '2025-05-24 17:30:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:30:00.000000', 'bach-tuoc-vissan-500g', 'Bạch tuộc Vissan từ Kiên Giang, dai ngon, dùng nướng hoặc xào. Bảo quản đông lạnh.', 'Bạch tuộc Vissan 500g', 150000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.4, 100, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 11, NULL, NULL, 4.6, 7),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:30:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:30:00.000000', 'so-diep-vissan-500g', 'Sò điệp Vissan từ Quảng Ninh, ngọt thịt, dùng hấp hoặc nướng. Bảo quản đông lạnh.', 'Sò điệp Vissan 500g', 180000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.5, 90, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 10, NULL, NULL, 4.7, 8),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:30:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:30:00.000000', 'ca-ngu-vissan-500g', 'Cá ngừ Vissan từ Bình Định, tươi ngon, dùng làm sashimi hoặc nướng. Bảo quản đông lạnh.', 'Cá ngừ Vissan 500g', 110000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.4, 120, 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 13, NULL, NULL, 4.5, 6),
-- Bac Tom (10 bản ghi)
(UUID(), 'admin@gmail.com', '2025-05-24 17:30:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:30:00.000000', 'ca-hoi-phi-le-bactom-500g', 'Cá hồi phi lê Bac Tom từ Na Uy, tươi ngon, dùng cho sashimi. Bảo quản đông lạnh.', 'Cá hồi phi lê Bac Tom 500g', 245000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.5, 90, 'd6e7f8a9-b0c1-4d2e-3f4a-6b7c8d9e0f1a', 11, 220500, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.7, 8),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:30:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:30:00.000000', 'tom-su-bactom-500g', 'Tôm sú Bac Tom từ Cà Mau, tươi ngọt, dùng nướng. Bảo quản đông lạnh.', 'Tôm sú Bac Tom 500g', 170000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.4, 110, 'd6e7f8a9-b0c1-4d2e-3f4a-6b7c8d9e0f1a', 14, NULL, NULL, 4.6, 7),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:30:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:30:00.000000', 'muc-ong-bactom-500g', 'Mực ống Bac Tom từ Phú Quốc, tươi ngon, dùng chiên. Bảo quản đông lạnh.', 'Mực ống Bac Tom 500g', 115000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.4, 100, 'd6e7f8a9-b0c1-4d2e-3f4a-6b7c8d9e0f1a', 9, NULL, NULL, 4.5, 6),
(UUID(), 'admin@gmail.com', '2025-05-24 17:30:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:30:00.000000', 'ca-basa-phi-le-bactom-500g', 'Cá basa phi lê Bac Tom từ Đồng Tháp, mềm ngon, dùng hấp. Bảo quản đông lạnh.', 'Cá basa phi lê Bac Tom 500g', 58000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.3, 140, 'd6e7f8a9-b0c1-4d2e-3f4a-6b7c8d9e0f1a', 17, NULL, NULL, 4.4, 5),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:30:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:30:00.000000', 'ngheu-bactom-1kg', 'Nghêu Bac Tom từ Tiền Giang, ngọt thịt, dùng nấu canh. Bảo quản tủ lạnh.', 'Nghêu Bac Tom 1kg', 48000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.3, 190, 'd6e7f8a9-b0c1-4d2e-3f4a-6b7c8d9e0f1a', 19, NULL, NULL, 4.3, 4),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:30:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:30:00.000000', 'ca-thu-bactom-500g', 'Cá thu Bac Tom từ Nha Trang, thơm ngon, dùng kho. Bảo quản đông lạnh.', 'Cá thu Bac Tom 500g', 88000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.3, 120, 'd6e7f8a9-b0c1-4d2e-3f4a-6b7c8d9e0f1a', 13, NULL, NULL, 4.5, 6),
(UUID(), 'admin@gmail.com', '2025-05-24 17:30:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:30:00.000000', 'tom-the-bactom-500g', 'Tôm thẻ Bac Tom từ Bạc Liêu, tươi ngọt, dùng xào. Bảo quản đông lạnh.', 'Tôm thẻ Bac Tom 500g', 135000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.4, 100, 'd6e7f8a9-b0c1-4d2e-3f4a-6b7c8d9e0f1a', 11, NULL, NULL, 4.4, 5),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:30:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:30:00.000000', 'bach-tuoc-bactom-500g', 'Bạch tuộc Bac Tom từ Kiên Giang, dai ngon, dùng nướng. Bảo quản đông lạnh.', 'Bạch tuộc Bac Tom 500g', 145000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.4, 90, 'd6e7f8a9-b0c1-4d2e-3f4a-6b7c8d9e0f1a', 10, NULL, NULL, 4.6, 7),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:30:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:30:00.000000', 'so-diep-bactom-500g', 'Sò điệp Bac Tom từ Quảng Ninh, ngọt thịt, dùng nướng. Bảo quản đông lạnh.', 'Sò điệp Bac Tom 500g', 175000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.5, 80, 'd6e7f8a9-b0c1-4d2e-3f4a-6b7c8d9e0f1a', 9, NULL, NULL, 4.7, 8),
(UUID(), 'admin@gmail.com', '2025-05-24 17:30:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:30:00.000000', 'ca-mu-bactom-500g', 'Cá mú Bac Tom từ Nha Trang, thịt chắc, dùng hấp hoặc chiên. Bảo quản đông lạnh.', 'Cá mú Bac Tom 500g', 160000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.4, 100, 'd6e7f8a9-b0c1-4d2e-3f4a-6b7c8d9e0f1a', 12, NULL, NULL, 4.5, 6),
-- CP Foods (10 bản ghi)
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:30:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:30:00.000000', 'ca-hoi-phi-le-cp-500g', 'Cá hồi phi lê CP Foods từ Na Uy, tươi ngon, dùng sashimi. Bảo quản đông lạnh.', 'Cá hồi phi lê CP Foods 500g', 240000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.5, 80, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 10, 216000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.7, 8),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:30:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:30:00.000000', 'tom-su-cp-500g', 'Tôm sú CP Foods từ Cà Mau, tươi ngọt, dùng lẩu. Bảo quản đông lạnh.', 'Tôm sú CP Foods 500g', 165000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.4, 100, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 13, NULL, NULL, 4.6, 7),
(UUID(), 'admin@gmail.com', '2025-05-24 17:30:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:30:00.000000', 'muc-nang-cp-500g', 'Mực nang CP Foods từ Phú Quốc, tươi ngon, dùng nướng. Bảo quản đông lạnh.', 'Mực nang CP Foods 500g', 130000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.4, 90, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 8, NULL, NULL, 4.5, 6),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:30:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:30:00.000000', 'ca-basa-phi-le-cp-500g', 'Cá basa phi lê CP Foods từ Đồng Tháp, mềm ngon, dùng chiên. Bảo quản đông lạnh.', 'Cá basa phi lê CP Foods 500g', 56000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.3, 130, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 16, NULL, NULL, 4.4, 5),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:30:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:30:00.000000', 'hau-cp-1kg', 'Hàu CP Foods từ Quảng Ninh, tươi ngọt, dùng nướng phô mai. Bảo quản tủ lạnh.', 'Hàu CP Foods 1kg', 80000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.3, 180, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 18, NULL, NULL, 4.3, 4),
(UUID(), 'admin@gmail.com', '2025-05-24 17:30:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:30:00.000000', 'ca-thu-cp-500g', 'Cá thu CP Foods từ Nha Trang, thơm ngon, dùng chiên. Bảo quản đông lạnh.', 'Cá thu CP Foods 500g', 86000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.3, 110, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 12, NULL, NULL, 4.5, 6),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:30:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:30:00.000000', 'tom-the-cp-500g', 'Tôm thẻ CP Foods từ Bạc Liêu, tươi ngọt, dùng hấp. Bảo quản đông lạnh.', 'Tôm thẻ CP Foods 500g', 130000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.4, 90, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 10, NULL, NULL, 4.4, 5),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:30:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:30:00.000000', 'bach-tuoc-cp-500g', 'Bạch tuộc CP Foods từ Kiên Giang, dai ngon, dùng xào. Bảo quản đông lạnh.', 'Bạch tuộc CP Foods 500g', 140000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.4, 80, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 9, NULL, NULL, 4.6, 7),
(UUID(), 'admin@gmail.com', '2025-05-24 17:30:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:30:00.000000', 'ca-chem-cp-500g', 'Cá chẽm CP Foods từ Vũng Tàu, thịt trắng, dùng hấp. Bảo quản đông lạnh.', 'Cá chẽm CP Foods 500g', 100000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.4, 100, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 11, NULL, NULL, 4.5, 6),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:30:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:30:00.000000', 'ca-ngu-cp-500g', 'Cá ngừ CP Foods từ Bình Định, tươi ngon, dùng nướng. Bảo quản đông lạnh.', 'Cá ngừ CP Foods 500g', 105000, '66e4808b-cc16-40d1-8c4c-511785a8b27e', 0.4, 110, 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 12, NULL, NULL, 4.5, 6),

--
-- Sữa bò
--
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:33:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:33:00.000000', 'sua-tuoi-tiet-trung-vinamilk-1l', 'Sữa tươi tiệt trùng Vinamilk 100% từ bò Việt Nam, giàu canxi, thích hợp mọi lứa tuổi. Bảo quản nơi khô ráo.', 'Sữa tươi tiệt trùng Vinamilk 1L', 40000, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.3, 200, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 20, 36000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.6, 12),
(UUID(), 'admin@gmail.com', '2025-05-24 17:33:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:33:00.000000', 'sua-tuoi-thanh-trung-vinamilk-1l', 'Sữa tươi thanh trùng Vinamilk, vị tự nhiên, giàu dinh dưỡng. Bảo quản tủ lạnh.', 'Sữa tươi thanh trùng Vinamilk 1L', 45000, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.3, 180, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 18, NULL, NULL, 4.7, 10),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:33:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:33:00.000000', 'sua-dac-vinamilk-380g', 'Sữa đặc Vinamilk, ngọt đậm, dùng pha cà phê hoặc làm bánh. Bảo quản nơi khô ráo.', 'Sữa đặc Vinamilk 380g', 35000, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.3, 250, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 25, NULL, NULL, 4.5, 15),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:33:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:33:00.000000', 'sua-chua-vinamilk-100ml', 'Sữa chua Vinamilk tự nhiên, tốt cho tiêu hóa, vị ngọt nhẹ. Bảo quản tủ lạnh.', 'Sữa chua Vinamilk 100ml', 8000, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.2, 300, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 30, NULL, NULL, 4.4, 8),
(UUID(), 'admin@gmail.com', '2025-05-24 17:33:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:33:00.000000', 'sua-bot-tre-em-vinamilk-900g', 'Sữa bột Vinamilk Dielac cho trẻ 1-3 tuổi, hỗ trợ phát triển trí não. Bảo quản nơi khô ráo.', 'Sữa bột trẻ em Vinamilk 900g', 400000, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.5, 120, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 15, 360000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.8, 10),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:33:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:33:00.000000', 'sua-bot-nguoi-lon-vinamilk-900g', 'Sữa bột Vinamilk Sure cho người lớn, hỗ trợ xương khớp. Bảo quản nơi khô ráo.', 'Sữa bột người lớn Vinamilk 900g', 350000, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.5, 130, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 12, NULL, NULL, 4.7, 9),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:33:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:33:00.000000', 'sua-tuoi-khong-duong-vinamilk-1l', 'Sữa tươi tiệt trùng Vinamilk không đường, phù hợp người ăn kiêng. Bảo quản nơi khô ráo.', 'Sữa tươi không đường Vinamilk 1L', 42000, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.3, 190, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 22, NULL, NULL, 4.6, 11),
(UUID(), 'admin@gmail.com', '2025-05-24 17:33:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:33:00.000000', 'sua-tuoi-it-duong-vinamilk-1l', 'Sữa tươi tiệt trùng Vinamilk ít đường, vị nhẹ, tốt cho sức khỏe. Bảo quản nơi khô ráo.', 'Sữa tươi ít đường Vinamilk 1L', 41000, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.3, 200, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 21, NULL, NULL, 4.5, 10),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:33:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:33:00.000000', 'sua-tuoi-tach-beo-vinamilk-1l', 'Sữa tươi tiệt trùng Vinamilk tách béo, hỗ trợ kiểm soát cân nặng. Bảo quản nơi khô ráo.', 'Sữa tươi tách béo Vinamilk 1L', 43000, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.3, 180, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 19, NULL, NULL, 4.6, 9),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:33:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:33:00.000000', 'sua-tuoi-nguyen-kem-vinamilk-1l', 'Sữa tươi tiệt trùng Vinamilk nguyên kem, vị béo ngậy, giàu dinh dưỡng. Bảo quản nơi khô ráo.', 'Sữa tươi nguyên kem Vinamilk 1L', 45000, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.3, 170, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 18, NULL, NULL, 4.7, 12),
(UUID(), 'admin@gmail.com', '2025-05-24 17:33:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:33:00.000000', 'sua-tuoi-dau-vinamilk-180ml', 'Sữa tươi tiệt trùng Vinamilk vị dâu, thơm ngon, dành cho trẻ em. Bảo quản nơi khô ráo.', 'Sữa tươi vị dâu Vinamilk 180ml', 9000, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.2, 250, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 28, NULL, NULL, 4.4, 7),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:33:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:33:00.000000', 'sua-tuoi-socola-vinamilk-180ml', 'Sữa tươi tiệt trùng Vinamilk vị socola, ngọt ngào, dành cho trẻ em. Bảo quản nơi khô ráo.', 'Sữa tươi vị socola Vinamilk 180ml', 9000, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.2, 260, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 27, NULL, NULL, 4.5, 8),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:33:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:33:00.000000', 'sua-chua-dau-vinamilk-100ml', 'Sữa chua Vinamilk vị dâu, tốt cho tiêu hóa, dành cho mọi lứa tuổi. Bảo quản tủ lạnh.', 'Sữa chua vị dâu Vinamilk 100ml', 8500, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.2, 280, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 29, NULL, NULL, 4.4, 7),
(UUID(), 'admin@gmail.com', '2025-05-24 17:33:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:33:00.000000', 'sua-chua-nep-cam-vinamilk-100ml', 'Sữa chua Vinamilk nếp cẩm, vị độc đáo, tốt cho tiêu hóa. Bảo quản tủ lạnh.', 'Sữa chua nếp cẩm Vinamilk 100ml', 9000, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.2, 270, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 26, NULL, NULL, 4.5, 8),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:33:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:33:00.000000', 'sua-dac-khong-duong-vinamilk-380g', 'Sữa đặc Vinamilk không đường, phù hợp người ăn kiêng. Bảo quản nơi khô ráo.', 'Sữa đặc không đường Vinamilk 380g', 36000, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.3, 240, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 24, NULL, NULL, 4.6, 9),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:33:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:33:00.000000', 'sua-tuoi-tiet-trung-vinamilk-180ml', 'Sữa tươi tiệt trùng Vinamilk, tiện lợi, phù hợp trẻ em. Bảo quản nơi khô ráo.', 'Sữa tươi tiệt trùng Vinamilk 180ml', 8000, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.2, 290, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 30, NULL, NULL, 4.4, 7),
(UUID(), 'admin@gmail.com', '2025-05-24 17:33:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:33:00.000000', 'sua-bot-tre-em-3-6-vinamilk-900g', 'Sữa bột Vinamilk Dielac cho trẻ 3-6 tuổi, hỗ trợ phát triển chiều cao. Bảo quản nơi khô ráo.', 'Sữa bột trẻ em 3-6 Vinamilk 900g', 420000, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.5, 110, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 14, NULL, NULL, 4.8, 11),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:33:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:33:00.000000', 'sua-bot-nguoi-gia-vinamilk-900g', 'Sữa bột Vinamilk CanxiPro cho người già, hỗ trợ xương chắc khỏe. Bảo quản nơi khô ráo.', 'Sữa bột người già Vinamilk 900g', 370000, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.5, 120, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 13, NULL, NULL, 4.7, 10),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:33:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:33:00.000000', 'sua-tuoi-khong-duong-vinamilk-180ml', 'Sữa tươi tiệt trùng Vinamilk không đường, tiện lợi, phù hợp người lớn. Bảo quản nơi khô ráo.', 'Sữa tươi không đường Vinamilk 180ml', 8500, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.2, 280, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 29, NULL, NULL, 4.5, 8),
(UUID(), 'admin@gmail.com', '2025-05-24 17:33:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:33:00.000000', 'sua-tuoi-it-duong-vinamilk-180ml', 'Sữa tươi tiệt trùng Vinamilk ít đường, tiện lợi, tốt cho sức khỏe. Bảo quản nơi khô ráo.', 'Sữa tươi ít đường Vinamilk 180ml', 8500, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.2, 270, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 28, NULL, NULL, 4.5, 8),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:33:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:33:00.000000', 'sua-tuoi-tach-beo-vinamilk-180ml', 'Sữa tươi tiệt trùng Vinamilk tách béo, tiện lợi, hỗ trợ kiểm soát cân nặng. Bảo quản nơi khô ráo.', 'Sữa tươi tách béo Vinamilk 180ml', 9000, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.2, 260, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 27, NULL, NULL, 4.6, 9),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:33:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:33:00.000000', 'sua-tuoi-nguyen-kem-vinamilk-180ml', 'Sữa tươi tiệt trùng Vinamilk nguyên kem, tiện lợi, vị béo ngậy. Bảo quản nơi khô ráo.', 'Sữa tươi nguyên kem Vinamilk 180ml', 9500, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.2, 250, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 26, NULL, NULL, 4.7, 10),
(UUID(), 'admin@gmail.com', '2025-05-24 17:33:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:33:00.000000', 'sua-tuoi-dau-vinamilk-1l', 'Sữa tươi tiệt trùng Vinamilk vị dâu, thơm ngon, phù hợp trẻ em. Bảo quản nơi khô ráo.', 'Sữa tươi vị dâu Vinamilk 1L', 43000, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.3, 190, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 20, NULL, NULL, 4.4, 7),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:33:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:33:00.000000', 'sua-tuoi-socola-vinamilk-1l', 'Sữa tươi tiệt trùng Vinamilk vị socola, ngọt ngào, phù hợp trẻ em. Bảo quản nơi khô ráo.', 'Sữa tươi vị socola Vinamilk 1L', 43000, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.3, 180, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 19, NULL, NULL, 4.5, 8),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:33:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:33:00.000000', 'sua-chua-khong-duong-vinamilk-100ml', 'Sữa chua Vinamilk không đường, tốt cho tiêu hóa, phù hợp người ăn kiêng. Bảo quản tủ lạnh.', 'Sữa chua không đường Vinamilk 100ml', 8500, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.2, 270, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 28, NULL, NULL, 4.6, 9),
(UUID(), 'admin@gmail.com', '2025-05-24 17:33:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:33:00.000000', 'sua-dac-vinamilk-1kg', 'Sữa đặc Vinamilk, ngọt đậm, dùng pha trà sữa hoặc làm bánh. Bảo quản nơi khô ráo.', 'Sữa đặc Vinamilk 1kg', 85000, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.4, 200, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 22, NULL, NULL, 4.5, 10),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:33:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:33:00.000000', 'sua-bot-tre-em-0-1-vinamilk-900g', 'Sữa bột Vinamilk Dielac cho trẻ 0-1 tuổi, hỗ trợ phát triển toàn diện. Bảo quản nơi khô ráo.', 'Sữa bột trẻ em 0-1 Vinamilk 900g', 450000, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.5, 100, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 12, 405000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.8, 12),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:33:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:33:00.000000', 'sua-tuoi-tiet-trung-vinamilk-4x180ml', 'Sữa tươi tiệt trùng Vinamilk, gói 4 hộp 180ml, tiện lợi cho trẻ em. Bảo quản nơi khô ráo.', 'Sữa tươi tiệt trùng Vinamilk 4x180ml', 32000, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.3, 220, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 25, NULL, NULL, 4.4, 7),
(UUID(), 'admin@gmail.com', '2025-05-24 17:33:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:33:00.000000', 'sua-chua-4-hu-vinamilk-100ml', 'Sữa chua Vinamilk tự nhiên, gói 4 hũ, tốt cho tiêu hóa. Bảo quản tủ lạnh.', 'Sữa chua Vinamilk 4x100ml', 30000, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.3, 230, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 26, NULL, NULL, 4.5, 8),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:33:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:33:00.000000', 'sua-tuoi-nguyen-kem-vinamilk-4x180ml', 'Sữa tươi tiệt trùng Vinamilk nguyên kem, gói 4 hộp, vị béo ngậy. Bảo quản nơi khô ráo.', 'Sữa tươi nguyên kem Vinamilk 4x180ml', 36000, '4fc28aae-8101-4b95-85ac-2c89f6a0c5b9', 0.3, 210, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 24, NULL, NULL, 4.6, 9),

--
-- Sữa hạt
--
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:36:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:36:00.000000', 'sua-hat-dieu-th-1l', 'Sữa hạt điều TH True Milk, thơm béo, giàu vitamin E, phù hợp người ăn chay. Bảo quản nơi khô ráo.', 'Sữa hạt điều TH True Milk 1L', 45000, '43175b90-311c-4643-815c-0e9358a27825', 0.3, 200, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 20, 40500, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.6, 12),
(UUID(), 'admin@gmail.com', '2025-05-24 17:36:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:36:00.000000', 'sua-hanh-nhan-th-1l', 'Sữa hạnh nhân TH True Milk, ít calo, tốt cho tim mạch. Bảo quản nơi khô ráo.', 'Sữa hạnh nhân TH True Milk 1L', 50000, '43175b90-311c-4643-815c-0e9358a27825', 0.3, 180, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 18, NULL, NULL, 4.7, 10),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:36:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:36:00.000000', 'sua-oc-cho-th-1l', 'Sữa óc chó TH True Milk, giàu omega-3, hỗ trợ trí não. Bảo quản nơi khô ráo.', 'Sữa óc chó TH True Milk 1L', 55000, '43175b90-311c-4643-815c-0e9358a27825', 0.4, 170, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 16, NULL, NULL, 4.8, 11),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:36:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:36:00.000000', 'sua-dau-nanh-th-1l', 'Sữa đậu nành TH True Milk, tự nhiên, giàu protein, phù hợp mọi lứa tuổi. Bảo quản nơi khô ráo.', 'Sữa đậu nành TH True Milk 1L', 35000, '43175b90-311c-4643-815c-0e9358a27825', 0.3, 250, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 25, NULL, NULL, 4.5, 15),
(UUID(), 'admin@gmail.com', '2025-05-24 17:36:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:36:00.000000', 'sua-yen-mach-th-1l', 'Sữa yến mạch TH True Milk, giàu chất xơ, hỗ trợ tiêu hóa. Bảo quản nơi khô ráo.', 'Sữa yến mạch TH True Milk 1L', 48000, '43175b90-311c-4643-815c-0e9358a27825', 0.3, 190, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 19, NULL, NULL, 4.6, 10),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:36:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:36:00.000000', 'sua-me-den-th-1l', 'Sữa mè đen TH True Milk, giàu canxi, tốt cho xương. Bảo quản nơi khô ráo.', 'Sữa mè đen TH True Milk 1L', 40000, '43175b90-311c-4643-815c-0e9358a27825', 0.3, 210, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 22, NULL, NULL, 4.5, 9),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:36:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:36:00.000000', 'sua-hat-chia-th-1l', 'Sữa hạt chia TH True Milk, giàu omega-3, hỗ trợ sức khỏe tim mạch. Bảo quản nơi khô ráo.', 'Sữa hạt chia TH True Milk 1L', 50000, '43175b90-311c-4643-815c-0e9358a27825', 0.3, 180, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 17, NULL, NULL, 4.7, 10),
(UUID(), 'admin@gmail.com', '2025-05-24 17:36:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:36:00.000000', 'sua-mac-ca-th-1l', 'Sữa hạt mắc ca TH True Milk, thơm béo, hỗ trợ da và tóc. Bảo quản nơi khô ráo.', 'Sữa hạt mắc ca TH True Milk 1L', 52000, '43175b90-311c-4643-815c-0e9358a27825', 0.4, 170, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 16, NULL, NULL, 4.8, 11),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:36:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:36:00.000000', 'sua-hanh-nhan-oc-cho-th-1l', 'Sữa hạnh nhân-óc chó TH True Milk, giàu dinh dưỡng, hỗ trợ trí não. Bảo quản nơi khô ráo.', 'Sữa hạnh nhân-óc chó TH True Milk 1L', 55000, '43175b90-311c-4643-815c-0e9358a27825', 0.4, 160, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 15, NULL, NULL, 4.7, 10),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:36:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:36:00.000000', 'sua-dau-nanh-yen-mach-th-1l', 'Sữa đậu nành-yến mạch TH True Milk, giàu chất xơ, hỗ trợ tiêu hóa. Bảo quản nơi khô ráo.', 'Sữa đậu nành-yến mạch TH True Milk 1L', 45000, '43175b90-311c-4643-815c-0e9358a27825', 0.3, 200, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 20, NULL, NULL, 4.6, 9),
(UUID(), 'admin@gmail.com', '2025-05-24 17:36:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:36:00.000000', 'sua-hat-dieu-th-180ml', 'Sữa hạt điều TH True Milk, tiện lợi, thơm béo, phù hợp mọi lứa tuổi. Bảo quản nơi khô ráo.', 'Sữa hạt điều TH True Milk 180ml', 10000, '43175b90-311c-4643-815c-0e9358a27825', 0.2, 280, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 28, NULL, NULL, 4.4, 7),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:36:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:36:00.000000', 'sua-hanh-nhan-th-180ml', 'Sữa hạnh nhân TH True Milk, tiện lợi, ít calo, tốt cho sức khỏe. Bảo quản nơi khô ráo.', 'Sữa hạnh nhân TH True Milk 180ml', 11000, '43175b90-311c-4643-815c-0e9358a27825', 0.2, 270, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 27, NULL, NULL, 4.5, 8),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:36:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:36:00.000000', 'sua-oc-cho-th-180ml', 'Sữa óc chó TH True Milk, tiện lợi, giàu omega-3, hỗ trợ trí não. Bảo quản nơi khô ráo.', 'Sữa óc chó TH True Milk 180ml', 12000, '43175b90-311c-4643-815c-0e9358a27825', 0.2, 260, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 26, NULL, NULL, 4.6, 9),
(UUID(), 'admin@gmail.com', '2025-05-24 17:36:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:36:00.000000', 'sua-dau-nanh-th-180ml', 'Sữa đậu nành TH True Milk, tiện lợi, giàu protein, phù hợp mọi lứa tuổi. Bảo quản nơi khô ráo.', 'Sữa đậu nành TH True Milk 180ml', 8000, '43175b90-311c-4643-815c-0e9358a27825', 0.2, 300, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 30, NULL, NULL, 4.4, 7),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:36:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:36:00.000000', 'sua-yen-mach-th-180ml', 'Sữa yến mạch TH True Milk, tiện lợi, giàu chất xơ, hỗ trợ tiêu hóa. Bảo quản nơi khô ráo.', 'Sữa yến mạch TH True Milk 180ml', 10000, '43175b90-311c-4643-815c-0e9358a27825', 0.2, 280, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 28, NULL, NULL, 4.5, 8),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:36:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:36:00.000000', 'sua-me-den-th-180ml', 'Sữa mè đen TH True Milk, tiện lợi, giàu canxi, tốt cho xương. Bảo quản nơi khô ráo.', 'Sữa mè đen TH True Milk 180ml', 9000, '43175b90-311c-4643-815c-0e9358a27825', 0.2, 270, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 27, NULL, NULL, 4.4, 7),
(UUID(), 'admin@gmail.com', '2025-05-24 17:36:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:36:00.000000', 'sua-hat-dieu-th-4x180ml', 'Sữa hạt điều TH True Milk, gói 4 hộp, thơm béo, tiện lợi. Bảo quản nơi khô ráo.', 'Sữa hạt điều TH True Milk 4x180ml', 38000, '43175b90-311c-4643-815c-0e9358a27825', 0.3, 220, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 25, NULL, NULL, 4.5, 8),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:36:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:36:00.000000', 'sua-hanh-nhan-th-4x180ml', 'Sữa hạnh nhân TH True Milk, gói 4 hộp, ít calo, tốt cho sức khỏe. Bảo quản nơi khô ráo.', 'Sữa hạnh nhân TH True Milk 4x180ml', 42000, '43175b90-311c-4643-815c-0e9358a27825', 0.3, 210, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 24, NULL, NULL, 4.6, 9),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:36:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:36:00.000000', 'sua-oc-cho-th-4x180ml', 'Sữa óc chó TH True Milk, gói 4 hộp, giàu omega-3, hỗ trợ trí não. Bảo quản nơi khô ráo.', 'Sữa óc chó TH True Milk 4x180ml', 46000, '43175b90-311c-4643-815c-0e9358a27825', 0.3, 200, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 23, NULL, NULL, 4.7, 10),
(UUID(), 'admin@gmail.com', '2025-05-24 17:36:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:36:00.000000', 'sua-dau-nanh-th-4x180ml', 'Sữa đậu nành TH True Milk, gói 4 hộp, giàu protein, tiện lợi. Bảo quản nơi khô ráo.', 'Sữa đậu nành TH True Milk 4x180ml', 30000, '43175b90-311c-4643-815c-0e9358a27825', 0.3, 230, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 26, NULL, NULL, 4.4, 7),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:36:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:36:00.000000', 'sua-yen-mach-th-4x180ml', 'Sữa yến mạch TH True Milk, gói 4 hộp, giàu chất xơ, hỗ trợ tiêu hóa. Bảo quản nơi khô ráo.', 'Sữa yến mạch TH True Milk 4x180ml', 38000, '43175b90-311c-4643-815c-0e9358a27825', 0.3, 220, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 25, NULL, NULL, 4.5, 8),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:36:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:36:00.000000', 'sua-hat-dieu-khong-duong-th-1l', 'Sữa hạt điều TH True Milk không đường, ít calo, phù hợp người ăn kiêng. Bảo quản nơi khô ráo.', 'Sữa hạt điều không đường TH True Milk 1L', 46000, '43175b90-311c-4643-815c-0e9358a27825', 0.3, 190, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 19, NULL, NULL, 4.6, 9),
(UUID(), 'admin@gmail.com', '2025-05-24 17:36:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:36:00.000000', 'sua-hanh-nhan-khong-duong-th-1l', 'Sữa hạnh nhân TH True Milk không đường, ít calo, tốt cho sức khỏe. Bảo quản nơi khô ráo.', 'Sữa hạnh nhân không đường TH True Milk 1L', 51000, '43175b90-311c-4643-815c-0e9358a27825', 0.3, 180, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 18, NULL, NULL, 4.7, 10),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:36:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:36:00.000000', 'sua-oc-cho-khong-duong-th-1l', 'Sữa óc chó TH True Milk không đường, giàu omega-3, hỗ trợ trí não. Bảo quản nơi khô ráo.', 'Sữa óc chó không đường TH True Milk 1L', 56000, '43175b90-311c-4643-815c-0e9358a27825', 0.4, 170, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 17, NULL, NULL, 4.8, 11),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:36:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:36:00.000000', 'sua-dau-nanh-khong-duong-th-1l', 'Sữa đậu nành TH True Milk không đường, giàu protein, phù hợp người ăn kiêng. Bảo quản nơi khô ráo.', 'Sữa đậu nành không đường TH True Milk 1L', 36000, '43175b90-311c-4643-815c-0e9358a27825', 0.3, 240, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 24, NULL, NULL, 4.5, 9),
(UUID(), 'admin@gmail.com', '2025-05-24 17:36:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:36:00.000000', 'sua-yen-mach-khong-duong-th-1l', 'Sữa yến mạch TH True Milk không đường, giàu chất xơ, hỗ trợ tiêu hóa. Bảo quản nơi khô ráo.', 'Sữa yến mạch không đường TH True Milk 1L', 49000, '43175b90-311c-4643-815c-0e9358a27825', 0.3, 190, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 19, NULL, NULL, 4.6, 10),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:36:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:36:00.000000', 'sua-hat-dieu-th-500ml', 'Sữa hạt điều TH True Milk, dung tích vừa, thơm béo, tiện lợi. Bảo quản nơi khô ráo.', 'Sữa hạt điều TH True Milk 500ml', 25000, '43175b90-311c-4643-815c-0e9358a27825', 0.3, 230, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 22, NULL, NULL, 4.5, 8),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:36:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:36:00.000000', 'sua-hanh-nhan-th-500ml', 'Sữa hạnh nhân TH True Milk, dung tích vừa, ít calo, tốt cho sức khỏe. Bảo quản nơi khô ráo.', 'Sữa hạnh nhân TH True Milk 500ml', 28000, '43175b90-311c-4643-815c-0e9358a27825', 0.3, 220, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 21, NULL, NULL, 4.6, 9),
(UUID(), 'admin@gmail.com', '2025-05-24 17:36:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:36:00.000000', 'sua-dau-nanh-th-500ml', 'Sữa đậu nành TH True Milk, dung tích vừa, giàu protein, tiện lợi. Bảo quản nơi khô ráo.', 'Sữa đậu nành TH True Milk 500ml', 20000, '43175b90-311c-4643-815c-0e9358a27825', 0.3, 250, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 23, NULL, NULL, 4.4, 7),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:36:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:36:00.000000', 'sua-yen-mach-th-500ml', 'Sữa yến mạch TH True Milk, dung tích vừa, giàu chất xơ, hỗ trợ tiêu hóa. Bảo quản nơi khô ráo.', 'Sữa yến mạch TH True Milk 500ml', 26000, '43175b90-311c-4643-815c-0e9358a27825', 0.3, 230, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 22, NULL, NULL, 4.5, 8),

--
-- Chế phẩm từ sữa
--
-- Vinamilk (15 bản ghi)
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:39:00.000000', 'sua-chua-vinamilk-100g', 'Sữa chua Vinamilk tự nhiên, lên men tự nhiên, tốt cho tiêu hóa. Bảo quản tủ lạnh.', 'Sữa chua Vinamilk 100g', 9000, '220d1e42-3ba9-475b-950a-0392668f583c', 0.2, 250, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 25, 8100, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.5, 12),
(UUID(), 'admin@gmail.com', '2025-05-24 17:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:39:00.000000', 'sua-chua-dau-vinamilk-100g', 'Sữa chua Vinamilk vị dâu, thơm ngon, tốt cho tiêu hóa. Bảo quản tủ lạnh.', 'Sữa chua vị dâu Vinamilk 100g', 9500, '220d1e42-3ba9-475b-950a-0392668f583c', 0.2, 240, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 24, NULL, NULL, 4.6, 11),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:39:00.000000', 'sua-chua-nha-dam-vinamilk-100g', 'Sữa chua Vinamilk vị nha đam, thanh mát, tốt cho tiêu hóa. Bảo quản tủ lạnh.', 'Sữa chua nha đam Vinamilk 100g', 9500, '220d1e42-3ba9-475b-950a-0392668f583c', 0.2, 230, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 23, NULL, NULL, 4.5, 10),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:39:00.000000', 'sua-chua-uong-vinamilk-180ml', 'Sữa chua uống Vinamilk tự nhiên, tiện lợi, tốt cho tiêu hóa. Bảo quản tủ lạnh.', 'Sữa chua uống Vinamilk 180ml', 12000, '220d1e42-3ba9-475b-950a-0392668f583c', 0.2, 220, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 22, NULL, NULL, 4.4, 9),
(UUID(), 'admin@gmail.com', '2025-05-24 17:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:39:00.000000', 'sua-chua-uong-dau-vinamilk-180ml', 'Sữa chua uống Vinamilk vị dâu, thơm ngon, tiện lợi. Bảo quản tủ lạnh.', 'Sữa chua uống vị dâu Vinamilk 180ml', 13000, '220d1e42-3ba9-475b-950a-0392668f583c', 0.2, 210, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 21, NULL, NULL, 4.5, 10),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:39:00.000000', 'pho-mai-lat-vinamilk-120g', 'Phô mai lát Vinamilk, giàu canxi, dùng cho bánh mì hoặc nấu ăn. Bảo quản tủ lạnh.', 'Phô mai lát Vinamilk 120g', 35000, '220d1e42-3ba9-475b-950a-0392668f583c', 0.3, 200, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 20, NULL, NULL, 4.6, 11),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:39:00.000000', 'pho-mai-vien-vinamilk-120g', 'Phô mai viên Vinamilk, tiện lợi, phù hợp trẻ em. Bảo quản tủ lạnh.', 'Phô mai viên Vinamilk 120g', 30000, '220d1e42-3ba9-475b-950a-0392668f583c', 0.3, 190, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 19, NULL, NULL, 4.5, 10),
(UUID(), 'admin@gmail.com', '2025-05-24 17:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:39:00.000000', 'bo-lat-vinamilk-200g', 'Bơ lạt Vinamilk, thơm béo, dùng làm bánh hoặc nấu ăn. Bảo quản tủ lạnh.', 'Bơ lạt Vinamilk 200g', 55000, '220d1e42-3ba9-475b-950a-0392668f583c', 0.3, 180, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 18, NULL, NULL, 4.7, 12),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:39:00.000000', 'vang-sua-vinamilk-100g', 'Váng sữa Vinamilk, giàu dinh dưỡng, phù hợp trẻ em. Bảo quản tủ lạnh.', 'Váng sữa Vinamilk 100g', 18000, '220d1e42-3ba9-475b-950a-0392668f583c', 0.2, 200, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 20, NULL, NULL, 4.4, 9),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:39:00.000000', 'sua-chua-4-hu-vinamilk-100g', 'Sữa chua Vinamilk tự nhiên, gói 4 hũ, tốt cho tiêu hóa. Bảo quản tủ lạnh.', 'Sữa chua Vinamilk 4x100g', 34000, '220d1e42-3ba9-475b-950a-0392668f583c', 0.3, 210, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 22, NULL, NULL, 4.5, 10),
(UUID(), 'admin@gmail.com', '2025-05-24 17:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:39:00.000000', 'sua-chua-khong-duong-vinamilk-100g', 'Sữa chua Vinamilk không đường, phù hợp người ăn kiêng. Bảo quản tủ lạnh.', 'Sữa chua không đường Vinamilk 100g', 9500, '220d1e42-3ba9-475b-950a-0392668f583c', 0.2, 230, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 23, NULL, NULL, 4.6, 11),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:39:00.000000', 'pho-mai-tươi-vinamilk-100g', 'Phô mai tươi Vinamilk, mềm mịn, dùng làm bánh hoặc ăn trực tiếp. Bảo quản tủ lạnh.', 'Phô mai tươi Vinamilk 100g', 25000, '220d1e42-3ba9-475b-950a-0392668f583c', 0.3, 190, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 19, NULL, NULL, 4.5, 10),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:39:00.000000', 'sua-chua-nep-cam-vinamilk-100g', 'Sữa chua Vinamilk nếp cẩm, vị độc đáo, tốt cho tiêu hóa. Bảo quản tủ lạnh.', 'Sữa chua nếp cẩm Vinamilk 100g', 10000, '220d1e42-3ba9-475b-950a-0392668f583c', 0.2, 220, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 21, NULL, NULL, 4.6, 11),
(UUID(), 'admin@gmail.com', '2025-05-24 17:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:39:00.000000', 'bo-man-vinamilk-200g', 'Bơ mặn Vinamilk, thơm béo, dùng làm bánh hoặc nấu ăn. Bảo quản tủ lạnh.', 'Bơ mặn Vinamilk 200g', 57000, '220d1e42-3ba9-475b-950a-0392668f583c', 0.3, 180, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 18, NULL, NULL, 4.7, 12),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:39:00.000000', 'sua-chua-uong-4-chai-vinamilk-180ml', 'Sữa chua uống Vinamilk tự nhiên, gói 4 chai, tiện lợi. Bảo quản tủ lạnh.', 'Sữa chua uống Vinamilk 4x180ml', 46000, '220d1e42-3ba9-475b-950a-0392668f583c', 0.3, 200, 'e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b', 20, NULL, NULL, 4.5, 10),
-- TH True Milk (15 bản ghi)
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:39:00.000000', 'sua-chua-th-100g', 'Sữa chua TH True Milk tự nhiên, lên men tự nhiên, tốt cho tiêu hóa. Bảo quản tủ lạnh.', 'Sữa chua TH True Milk 100g', 10000, '220d1e42-3ba9-475b-950a-0392668f583c', 0.2, 250, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 25, 9000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.6, 12),
(UUID(), 'admin@gmail.com', '2025-05-24 17:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:39:00.000000', 'sua-chua-dau-th-100g', 'Sữa chua TH True Milk vị dâu, thơm ngon, tốt cho tiêu hóa. Bảo quản tủ lạnh.', 'Sữa chua vị dâu TH True Milk 100g', 10500, '220d1e42-3ba9-475b-950a-0392668f583c', 0.2, 240, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 24, NULL, NULL, 4.7, 11),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:39:00.000000', 'sua-chua-luu-th-100g', 'Sữa chua TH True Milk vị lựu, thanh mát, tốt cho tiêu hóa. Bảo quản tủ lạnh.', 'Sữa chua lựu TH True Milk 100g', 10500, '220d1e42-3ba9-475b-950a-0392668f583c', 0.2, 230, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 23, NULL, NULL, 4.6, 10),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:39:00.000000', 'sua-chua-uong-th-180ml', 'Sữa chua uống TH True Milk tự nhiên, tiện lợi, tốt cho tiêu hóa. Bảo quản tủ lạnh.', 'Sữa chua uống TH True Milk 180ml', 13000, '220d1e42-3ba9-475b-950a-0392668f583c', 0.2, 220, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 22, NULL, NULL, 4.5, 9),
(UUID(), 'admin@gmail.com', '2025-05-24 17:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:39:00.000000', 'sua-chua-uong-dau-th-180ml', 'Sữa chua uống TH True Milk vị dâu, thơm ngon, tiện lợi. Bảo quản tủ lạnh.', 'Sữa chua uống vị dâu TH True Milk 180ml', 14000, '220d1e42-3ba9-475b-950a-0392668f583c', 0.2, 210, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 21, NULL, NULL, 4.6, 10),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:39:00.000000', 'pho-mai-lat-th-120g', 'Phô mai lát TH True Milk, giàu canxi, dùng cho bánh mì hoặc nấu ăn. Bảo quản tủ lạnh.', 'Phô mai lát TH True Milk 120g', 36000, '220d1e42-3ba9-475b-950a-0392668f583c', 0.3, 200, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 20, NULL, NULL, 4.7, 11),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:39:00.000000', 'pho-mai-vien-th-120g', 'Phô mai viên TH True Milk, tiện lợi, phù hợp trẻ em. Bảo quản tủ lạnh.', 'Phô mai viên TH True Milk 120g', 31000, '220d1e42-3ba9-475b-950a-0392668f583c', 0.3, 190, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 19, NULL, NULL, 4.6, 10),
(UUID(), 'admin@gmail.com', '2025-05-24 17:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:39:00.000000', 'bo-lat-th-200g', 'Bơ lạt TH True Milk, thơm béo, dùng làm bánh hoặc nấu ăn. Bảo quản tủ lạnh.', 'Bơ lạt TH True Milk 200g', 56000, '220d1e42-3ba9-475b-950a-0392668f583c', 0.3, 180, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 18, NULL, NULL, 4.8, 12),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:39:00.000000', 'vang-sua-th-100g', 'Váng sữa TH True Milk, giàu dinh dưỡng, phù hợp trẻ em. Bảo quản tủ lạnh.', 'Váng sữa TH True Milk 100g', 19000, '220d1e42-3ba9-475b-950a-0392668f583c', 0.2, 200, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 20, NULL, NULL, 4.5, 9),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:39:00.000000', 'sua-chua-4-hu-th-100g', 'Sữa chua TH True Milk tự nhiên, gói 4 hũ, tốt cho tiêu hóa. Bảo quản tủ lạnh.', 'Sữa chua TH True Milk 4x100g', 38000, '220d1e42-3ba9-475b-950a-0392668f583c', 0.3, 210, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 22, NULL, NULL, 4.6, 10),
(UUID(), 'admin@gmail.com', '2025-05-24 17:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:39:00.000000', 'sua-chua-khong-duong-th-100g', 'Sữa chua TH True Milk không đường, phù hợp người ăn kiêng. Bảo quản tủ lạnh.', 'Sữa chua không đường TH True Milk 100g', 10500, '220d1e42-3ba9-475b-950a-0392668f583c', 0.2, 230, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 23, NULL, NULL, 4.7, 11),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:39:00.000000', 'pho-mai-tươi-th-100g', 'Phô mai tươi TH True Milk, mềm mịn, dùng làm bánh hoặc ăn trực tiếp. Bảo quản tủ lạnh.', 'Phô mai tươi TH True Milk 100g', 26000, '220d1e42-3ba9-475b-950a-0392668f583c', 0.3, 190, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 19, NULL, NULL, 4.6, 10),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:39:00.000000', 'kem-tuoi-th-200ml', 'Kem tươi TH True Milk, béo ngậy, dùng làm bánh hoặc pha chế. Bảo quản tủ lạnh.', 'Kem tươi TH True Milk 200ml', 30000, '220d1e42-3ba9-475b-950a-0392668f583c', 0.3, 180, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 18, NULL, NULL, 4.7, 11),
(UUID(), 'admin@gmail.com', '2025-05-24 17:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:39:00.000000', 'bo-man-th-200g', 'Bơ mặn TH True Milk, thơm béo, dùng làm bánh hoặc nấu ăn. Bảo quản tủ lạnh.', 'Bơ mặn TH True Milk 200g', 58000, '220d1e42-3ba9-475b-950a-0392668f583c', 0.3, 170, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 17, NULL, NULL, 4.8, 12),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:39:00.000000', 'sua-chua-uong-4-chai-th-180ml', 'Sữa chua uống TH True Milk tự nhiên, gói 4 chai, tiện lợi. Bảo quản tủ lạnh.', 'Sữa chua uống TH True Milk 4x180ml', 50000, '220d1e42-3ba9-475b-950a-0392668f583c', 0.3, 200, 'f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c', 20, NULL, NULL, 4.6, 10),

--
-- Nước rửa chén
--
-- Unilever (8 bản ghi)
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:43:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:43:00.000000', 'nuoc-rua-chen-sunlight-chanh-3.5kg', 'Nước rửa chén Sunlight Chanh, làm sạch dầu mỡ, xả bọt nhanh. Bảo quản nơi khô ráo.', 'Nước rửa chén Sunlight Chanh 3.5kg', 94000, 'c407c1ba-7d80-4684-b82a-db01e9017106', 0.3, 350, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 40, 84600, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.5, 18),
(UUID(), 'admin@gmail.com', '2025-05-24 17:43:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:43:00.000000', 'nuoc-rua-chen-sunlight-matcha-3.4kg', 'Nước rửa chén Sunlight Bio-care Matcha Trà Nhật, gốc thực vật, an toàn da tay. Bảo quản nơi khô ráo.', 'Nước rửa chén Sunlight Matcha 3.4kg', 106000, 'c407c1ba-7d80-4684-b82a-db01e9017106', 0.3, 340, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 38, NULL, NULL, 4.6, 17),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:43:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:43:00.000000', 'nuoc-rua-chen-sunlight-lo-hoi-3.4kg', 'Nước rửa chén Sunlight Bio-care Lô Hội, gốc thực vật, bảo vệ da tay. Bảo quản nơi khô ráo.', 'Nước rửa chén Sunlight Lô Hội 3.4kg', 109000, 'c407c1ba-7d80-4684-b82a-db01e9017106', 0.3, 330, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 36, NULL, NULL, 4.5, 16),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:43:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:43:00.000000', 'nuoc-rua-chen-sunlight-chanh-800ml', 'Nước rửa chén Sunlight Chanh, làm sạch dầu mỡ, hương chanh tươi mát. Bảo quản nơi khô ráo.', 'Nước rửa chén Sunlight Chanh 800ml', 28000, 'c407c1ba-7d80-4684-b82a-db01e9017106', 0.2, 320, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 35, NULL, NULL, 4.4, 15),
(UUID(), 'admin@gmail.com', '2025-05-24 17:43:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:43:00.000000', 'nuoc-rua-chen-sunlight-tra-xanh-3.4kg', 'Nước rửa chén Sunlight Trà Xanh, làm sạch hiệu quả, hương thơm tự nhiên. Bảo quản nơi khô ráo.', 'Nước rửa chén Sunlight Trà Xanh 3.4kg', 100000, 'c407c1ba-7d80-4684-b82a-db01e9017106', 0.3, 310, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 34, NULL, NULL, 4.5, 14),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:43:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:43:00.000000', 'nuoc-rua-chen-sunlight-sa-chanh-3.4kg', 'Nước rửa chén Sunlight Sả Chanh, khử mùi tanh, làm sạch dầu mỡ. Bảo quản nơi khô ráo.', 'Nước rửa chén Sunlight Sả Chanh 3.4kg', 102000, 'c407c1ba-7d80-4684-b82a-db01e9017106', 0.3, 300, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 33, NULL, NULL, 4.6, 13),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:43:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:43:00.000000', 'nuoc-rua-chen-sunlight-huu-co-750ml', 'Nước rửa chén Sunlight Hữu Cơ, chiết xuất thiên nhiên, an toàn sức khỏe. Bảo quản nơi khô ráo.', 'Nước rửa chén Sunlight Hữu Cơ 750ml', 90000, 'c407c1ba-7d80-4684-b82a-db01e9017106', 0.2, 290, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 32, NULL, NULL, 4.5, 12),
(UUID(), 'admin@gmail.com', '2025-05-24 17:43:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:43:00.000000', 'nuoc-rua-chen-sunlight-chanh-1.5kg', 'Nước rửa chén Sunlight Chanh, công thức đậm đặc, tiết kiệm nước. Bảo quản nơi khô ráo.', 'Nước rửa chén Sunlight Chanh 1.5kg', 50000, 'c407c1ba-7d80-4684-b82a-db01e9017106', 0.2, 280, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 31, NULL, NULL, 4.4, 11),
-- Minh Hồng (7 bản ghi)
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:43:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:43:00.000000', 'nuoc-rua-chen-minh-hong-chanh-1l', 'Nước rửa chén Minh Hồng Chanh, chiết xuất rau củ, an toàn da tay. Bảo quản nơi khô ráo.', 'Nước rửa chén Minh Hồng Chanh 1L', 55000, 'c407c1ba-7d80-4684-b82a-db01e9017106', 0.2, 270, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 30, 49500, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.5, 15),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:43:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:43:00.000000', 'nuoc-rua-chen-minh-hong-sa-1l', 'Nước rửa chén Minh Hồng Sả, khử mùi tanh, chiết xuất thiên nhiên. Bảo quản nơi khô ráo.', 'Nước rửa chén Minh Hồng Sả 1L', 56000, 'c407c1ba-7d80-4684-b82a-db01e9017106', 0.2, 260, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 29, NULL, NULL, 4.6, 14),
(UUID(), 'admin@gmail.com', '2025-05-24 17:43:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:43:00.000000', 'nuoc-rua-chen-minh-hong-huu-co-1l', 'Nước rửa chén Minh Hồng Hữu Cơ, chiết xuất rau củ, thân thiện môi trường. Bảo quản nơi khô ráo.', 'Nước rửa chén Minh Hồng Hữu Cơ 1L', 60000, 'c407c1ba-7d80-4684-b82a-db01e9017106', 0.2, 250, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 28, NULL, NULL, 4.5, 13),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:43:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:43:00.000000', 'nuoc-rua-chen-minh-hong-tra-xanh-1l', 'Nước rửa chén Minh Hồng Trà Xanh, làm sạch dầu mỡ, hương thơm dịu nhẹ. Bảo quản nơi khô ráo.', 'Nước rửa chén Minh Hồng Trà Xanh 1L', 55000, 'c407c1ba-7d80-4684-b82a-db01e9017106', 0.2, 240, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 27, NULL, NULL, 4.4, 12),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:43:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:43:00.000000', 'nuoc-rua-chen-minh-hong-cam-1l', 'Nước rửa chén Minh Hồng Cam, chiết xuất thiên nhiên, an toàn sức khỏe. Bảo quản nơi khô ráo.', 'Nước rửa chén Minh Hồng Cam 1L', 57000, 'c407c1ba-7d80-4684-b82a-db01e9017106', 0.2, 230, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 26, NULL, NULL, 4.5, 11),
(UUID(), 'admin@gmail.com', '2025-05-24 17:43:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:43:00.000000', 'nuoc-rua-chen-minh-hong-chanh-500ml', 'Nước rửa chén Minh Hồng Chanh, công thức đậm đặc, tiết kiệm nước. Bảo quản nơi khô ráo.', 'Nước rửa chén Minh Hồng Chanh 500ml', 30000, 'c407c1ba-7d80-4684-b82a-db01e9017106', 0.2, 220, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 25, NULL, NULL, 4.4, 10),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:43:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:43:00.000000', 'nuoc-rua-chen-minh-hong-huu-co-2l', 'Nước rửa chén Minh Hồng Hữu Cơ, dung tích lớn, thân thiện môi trường. Bảo quản nơi khô ráo.', 'Nước rửa chén Minh Hồng Hữu Cơ 2L', 110000, 'c407c1ba-7d80-4684-b82a-db01e9017106', 0.3, 210, 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 24, NULL, NULL, 4.6, 14),

--
-- Nước giặt xả
-- 
-- Unilever (8 bản ghi)
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:49:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:49:00.000000', 'nuoc-giat-omo-matic-3.5kg', 'Nước giặt OMO Matic, làm sạch vết bẩn cứng đầu, phù hợp máy giặt. Bảo quản nơi khô ráo.', 'Nước giặt OMO Matic 3.5kg', 120000, 'aba8a146-dc87-4786-9768-676c813040e0', 0.3, 350, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 40, 108000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.5, 18),
(UUID(), 'admin@gmail.com', '2025-05-24 17:49:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:49:00.000000', 'nuoc-giat-omo-thoai-mai-3.5kg', 'Nước giặt OMO Thỏa Mái, lưu hương thiên nhiên, dịu nhẹ da tay. Bảo quản nơi khô ráo.', 'Nước giặt OMO Thỏa Mái 3.5kg', 125000, 'aba8a146-dc87-4786-9768-676c813040e0', 0.3, 340, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 38, NULL, NULL, 4.6, 17),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:49:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:49:00.000000', 'nuoc-xa-comfort-nuoc-hoa-3.8l', 'Nước xả Comfort Nước Hoa, lưu hương sang trọng, làm mềm vải. Bảo quản nơi khô ráo.', 'Nước xả Comfort Nước Hoa 3.8L', 95000, 'aba8a146-dc87-4786-9768-676c813040e0', 0.3, 330, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 36, NULL, NULL, 4.5, 16),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:49:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:49:00.000000', 'nuoc-xa-comfort-thien-nhien-3.8l', 'Nước xả Comfort Thiên Nhiên, chiết xuất tự nhiên, dịu nhẹ. Bảo quản nơi khô ráo.', 'Nước xả Comfort Thiên Nhiên 3.8L', 90000, 'aba8a146-dc87-4786-9768-676c813040e0', 0.3, 320, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 35, NULL, NULL, 4.4, 15),
(UUID(), 'admin@gmail.com', '2025-05-24 17:49:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:49:00.000000', 'nuoc-giat-omo-matic-800ml', 'Nước giặt OMO Matic, công thức đậm đặc, làm sạch hiệu quả. Bảo quản nơi khô ráo.', 'Nước giặt OMO Matic 800ml', 35000, 'daba8a146-dc87-4786-9768-676c813040e0', 0.2, 310, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 34, NULL, NULL, 4.5, 14),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:49:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:49:00.000000', 'nuoc-xa-comfort-nuoc-hoa-800ml', 'Nước xả Comfort Nước Hoa, lưu hương lâu, làm mềm vải. Bảo quản nơi khô ráo.', 'Nước xả Comfort Nước Hoa 800ml', 30000, 'aba8a146-dc87-4786-9768-676c813040e0', 0.2, 300, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 33, NULL, NULL, 4.6, 13),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:49:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:49:00.000000', 'nuoc-giat-omo-huu-co-2.4kg', 'Nước giặt OMO Hữu Cơ, chiết xuất thiên nhiên, thân thiện môi trường. Bảo quản nơi khô ráo.', 'Nước giặt OMO Hữu Cơ 2.4kg', 130000, 'aba8a146-dc87-4786-9768-676c813040e0', 0.3, 290, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 32, NULL, NULL, 4.5, 12),
(UUID(), 'admin@gmail.com', '2025-05-24 17:49:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:49:00.000000', 'nuoc-xa-comfort-oai-huong-3.8l', 'Nước xả Comfort Oải Hương, hương thơm thư giãn, làm mềm vải. Bảo quản nơi khô ráo.', 'Nước xả Comfort Oải Hương 3.8L', 92000, 'aba8a146-dc87-4786-9768-676c813040e0', 0.3, 280, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 31, NULL, NULL, 4.4, 11),
-- P&G (7 bản ghi)
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:49:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:49:00.000000', 'nuoc-giat-ariel-nuoc-hoa-3.6kg', 'Nước giặt Ariel Nước Hoa, làm sạch sâu, lưu hương sang trọng. Bảo quản nơi khô ráo.', 'Nước giặt Ariel Nước Hoa 3.6kg', 140000, 'aba8a146-dc87-4786-9768-676c813040e0', 0.3, 270, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 30, 126000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.6, 15),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:49:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:49:00.000000', 'nuoc-giat-ariel-thien-nhien-3.6kg', 'Nước giặt Ariel Thiên Nhiên, làm sạch hiệu quả, dịu nhẹ da tay. Bảo quản nơi khô ráo.', 'Nước giặt Ariel Thiên Nhiên 3.6kg', 135000, 'aba8a146-dc87-4786-9768-676c813040e0', 0.3, 260, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 29, NULL, NULL, 4.5, 14),
(UUID(), 'admin@gmail.com', '2025-05-24 17:49:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:49:00.000000', 'nuoc-giat-ariel-matic-2.4kg', 'Nước giặt Ariel Matic, công thức đậm đặc, phù hợp máy giặt. Bảo quản nơi khô ráo.', 'Nước giặt Ariel Matic 2.4kg', 110000, 'aba8a146-dc87-4786-9768-676c813040e0', 0.3, 250, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 28, NULL, NULL, 4.4, 13),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:49:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:49:00.000000', 'nuoc-xa-downy-nuoc-hoa-2.4l', 'Nước xả Downy Nước Hoa, lưu hương lâu, làm mềm vải. Bảo quản nơi khô ráo.', 'Nước xả Downy Nước Hoa 2.4L', 85000, 'aba8a146-dc87-4786-9768-676c813040e0', 0.3, 240, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 27, NULL, NULL, 4.6, 12),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:49:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:49:00.000000', 'nuoc-xa-downy-oai-huong-2.4l', 'Nước xả Downy Oải Hương, hương thơm thư giãn, làm mềm vải. Bảo quản nơi khô ráo.', 'Nước xả Downy Oải Hương 2.4L', 82000, 'aba8a146-dc87-4786-9768-676c813040e0', 0.3, 230, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 26, NULL, NULL, 4.5, 11),
(UUID(), 'admin@gmail.com', '2025-05-24 17:49:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:49:00.000000', 'nuoc-giat-ariel-nuoc-hoa-800ml', 'Nước giặt Ariel Nước Hoa, làm sạch sâu, lưu hương sang trọng. Bảo quản nơi khô ráo.', 'Nước giặt Ariel Nước Hoa 800ml', 40000, 'aba8a146-dc87-4786-9768-676c813040e0', 0.2, 220, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 25, NULL, NULL, 4.4, 10),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:49:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:49:00.000000', 'nuoc-xa-downy-huu-co-2.4l', 'Nước xả Downy Hữu Cơ, chiết xuất thiên nhiên, thân thiện môi trường. Bảo quản nơi khô ráo.', 'Nước xả Downy Hữu Cơ 2.4L', 90000, 'aba8a146-dc87-4786-9768-676c813040e0', 0.3, 210, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 24, NULL, NULL, 4.6, 14),

--
-- Dung dịch tẩy rửa
--
-- Unilever (5 bản ghi)
('fcaf6f68-f963-4dce-af8f-c524767834ea', 'dotuandat2004nd@gmail.com', '2025-05-24 17:52:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:52:00.000000', 'nuoc-lau-san-cif-chanh-1l', 'Nước lau sàn Cif Chanh, làm sạch bề mặt, hương chanh tươi mát, diệt khuẩn. Bảo quản nơi khô ráo.', 'Nước lau sàn Cif Chanh 1L', 50000, '48f8997a-dc5c-4f55-b32d-8a1f3e281fd8', 0.2, 350, 'a7b8c9d0-e1f2-4a3b-5c6d-7e8f9a0b1c2d', 35, 45000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.5, 12),
('fea07871-f3b5-46c4-8666-bb40f646cd2c', 'admin@gmail.com', '2025-05-24 17:52:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:52:00.000000', 'nuoc-lau-san-cif-lavender-1l', 'Nước lau sàn Cif Lavender, làm sạch sâu, hương oải hương thư giãn. Bảo quản nơi khô ráo.', 'Nước lau sàn Cif Lavender 1L', 52000, '48f8997a-dc5c-4f55-b32d-8a1f3e281fd8', 0.2, 340, 'a7b8c9d0-e1f2-4a3b-5c6d-7e8f9a0b1c2d', 34, NULL, NULL, 4.6, 11),
('ff7a2db9-ade5-431b-96da-de04db3ba72a', 'pesmobile5404@gmail.com', '2025-05-24 17:52:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:52:00.000000', 'nuoc-lau-kinh-cif-500ml', 'Nước lau kính Cif, làm sạch kính và bề mặt, không để lại vệt. Bảo quản nơi khô ráo.', 'Nước lau kính Cif 500ml', 35000, '48f8997a-dc5c-4f55-b32d-8a1f3e281fd8', 0.2, 330, 'a7b8c9d0-e1f2-4a3b-5c6d-7e8f9a0b1c2d', 33, NULL, NULL, 4.4, 10),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:52:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:52:00.000000', 'nuoc-tay-nha-ve-sinh-cif-900ml', 'Nước tẩy rửa nhà vệ sinh Cif, diệt khuẩn, làm sạch vết bẩn cứng đầu. Bảo quản nơi khô ráo.', 'Nước tẩy rửa nhà vệ sinh Cif 900ml', 45000, '48f8997a-dc5c-4f55-b32d-8a1f3e281fd8', 0.2, 320, 'a7b8c9d0-e1f2-4a3b-5c6d-7e8f9a0b1c2d', 32, NULL, NULL, 4.5, 9),
(UUID(), 'admin@gmail.com', '2025-05-24 17:52:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:52:00.000000', 'nuoc-lau-bep-cif-800ml', 'Nước lau bếp Cif, làm sạch dầu mỡ, an toàn cho bề mặt bếp. Bảo quản nơi khô ráo.', 'Nước lau bếp Cif 800ml', 48000, '48f8997a-dc5c-4f55-b32d-8a1f3e281fd8', 0.2, 310, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 31, NULL, NULL, 4.6, 8),
-- Minh Hồng (5 bản ghi)
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:52:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:52:00.000000', 'nuoc-lau-san-minh-hong-chanh-1l', 'Nước lau sàn Minh Hồng Chanh, chiết xuất thiên nhiên, diệt khuẩn, an toàn sức khỏe. Bảo quản nơi khô ráo.', 'Nước lau sàn Minh Hồng Chanh 1L', 48000, '48f8997a-dc5c-4f55-b32d-8a1f3e281fd8', 0.2, 300, 'a7b8c9d0-e1f2-4a3b-5c6d-7e8f9a0b1c2d', 30, 43200, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.5, 12),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:52:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:52:00.000000', 'nuoc-lau-san-minh-hong-thong-1l', 'Nước lau sàn Minh Hồng Thông, hương thông tự nhiên, làm sạch hiệu quả. Bảo quản nơi khô ráo.', 'Nước lau sàn Minh Hồng Thông 1L', 49000, '48f8997a-dc5c-4f55-b32d-8a1f3e281fd8', 0.2, 290, 'a7b8c9d0-e1f2-4a3b-5c6d-7e8f9a0b1c2d', 29, NULL, NULL, 4.4, 11),
(UUID(), 'admin@gmail.com', '2025-05-24 17:52:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 17:52:00.000000', 'nuoc-tay-nha-ve-sinh-minh-hong-900ml', 'Nước tẩy rửa nhà vệ sinh Minh Hồng, chiết xuất thiên nhiên, diệt khuẩn mạnh mẽ. Bảo quản nơi khô ráo.', 'Nước tẩy rửa nhà vệ sinh Minh Hồng 900ml', 40000, '48f8997a-dc5c-4f55-b32d-8a1f3e281fd8', 0.2, 280, 'a7b8c9d0-e1f2-4a3b-5c6d-7e8f9a0b1c2d', 28, NULL, NULL, 4.5, 10),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 17:52:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 17:52:00.000000', 'nuoc-lau-kinh-minh-hong-500ml', 'Nước lau kính Minh Hồng, làm sạch kính, không để lại vệt, an toàn sức khỏe. Bảo quản nơi khô ráo.', 'Nước lau kính Minh Hồng 500ml', 32000, '48f8997a-dc5c-4f55-b32d-8a1f3e281fd8', 0.2, 270, 'a7b8c9d0-e1f2-4a3b-5c6d-7e8f9a0b1c2d', 27, NULL, NULL, 4.4, 9),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 17:52:00.000000', 1, 'admin@gmail.com', '2025-05-24 17:52:00.000000', 'nuoc-lau-bep-minh-hong-800ml', 'Nước lau bếp Minh Hồng, chiết xuất thiên nhiên, làm sạch dầu mỡ, an toàn bề mặt. Bảo quản nơi khô ráo.', 'Nước lau bếp Minh Hồng 800ml', 45000, '48f8997a-dc5c-4f55-b32d-8a1f3e281fd8', 0.2, 260, 'a7b8c9d0-e1f2-4a3b-5c6d-7e8f9a0b1c2d', 26, NULL, NULL, 4.5, 8),

-- Combo (15 bản ghi, Dalat Farm)
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 18:39:00.000000', 'combo-rau-sach-dalatfarm', 'Combo rau sạch Dalat Farm, gồm cải xanh, xà lách, rau mùi, tươi ngon, an toàn. Bảo quản trong tủ lạnh.', 'Combo Rau Sạch Dalat Farm', 120000, 'dc9bdcd0-500c-4511-896e-4d828ecfc210', 0.3, 200, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 40, 108000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.5, 20),
(UUID(), 'admin@gmail.com', '2025-05-24 18:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 'combo-trai-cay-dalatfarm', 'Combo trái cây Dalat Farm, gồm dâu tây, táo, lê, tươi ngọt tự nhiên. Bảo quản trong tủ lạnh.', 'Combo Trái Cây Dalat Farm', 180000, 'dc9bdcd0-500c-4511-896e-4d828ecfc210', 0.3, 180, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 38, NULL, NULL, 4.6, 18),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 18:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 18:39:00.000000', 'combo-thit-ca-dalatfarm', 'Combo thịt cá Dalat Farm, gồm cá hồi, thịt bò, thịt heo hữu cơ, tươi sạch. Bảo quản trong tủ lạnh.', 'Combo Thịt Cá Dalat Farm', 350000, 'dc9bdcd0-500c-4511-896e-4d828ecfc210', 0.4, 150, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 35, NULL, NULL, 4.7, 22),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 18:39:00.000000', 'combo-rau-cu-dalatfarm', 'Combo rau củ Dalat Farm, gồm khoai tây, cà rốt, bắp cải, tươi sạch, an toàn. Bảo quản trong tủ lạnh.', 'Combo Rau Củ Dalat Farm', 150000, 'dc9bdcd0-500c-4511-896e-4d828ecfc210', 0.3, 190, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 36, NULL, NULL, 4.5, 19),
(UUID(), 'admin@gmail.com', '2025-05-24 18:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 'combo-huu-co-dalatfarm', 'Combo thực phẩm hữu cơ Dalat Farm, gồm rau cải, cà chua, bí ngòi, an toàn sức khỏe. Bảo quản trong tủ lạnh.', 'Combo Hữu Cơ Dalat Farm', 200000, 'dc9bdcd0-500c-4511-896e-4d828ecfc210', 0.3, 170, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 34, NULL, NULL, 4.6, 17),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 18:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 18:39:00.000000', 'combo-bua-an-gia-dinh-dalatfarm', 'Combo bữa ăn gia đình Dalat Farm, gồm thịt heo, rau xanh, gia vị, tiện lợi. Bảo quản trong tủ lạnh.', 'Combo Bữa Ăn Gia Đình Dalat Farm', 250000, 'dc9bdcd0-500c-4511-896e-4d828ecfc210', 0.4, 160, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 33, NULL, NULL, 4.5, 16),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 18:39:00.000000', 'combo-rau-trai-cay-dalatfarm', 'Combo rau trái cây Dalat Farm, gồm xà lách, dưa leo, táo, cam, tươi sạch. Bảo quản trong tủ lạnh.', 'Combo Rau Trái Cây Dalat Farm', 160000, 'dc9bdcd0-500c-4511-896e-4d828ecfc210', 0.3, 200, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 32, NULL, NULL, 4.4, 15),
(UUID(), 'admin@gmail.com', '2025-05-24 18:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 'combo-thuc-pham-tuoi-dalatfarm', 'Combo thực phẩm tươi Dalat Farm, gồm cá basa, thịt gà, rau cải, tươi ngon. Bảo quản trong tủ lạnh.', 'Combo Thực Phẩm Tươi Dalat Farm', 300000, 'dc9bdcd0-500c-4511-896e-4d828ecfc210', 0.4, 140, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 31, NULL, NULL, 4.6, 14),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 18:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 18:39:00.000000', 'combo-rau-sach-mini-dalatfarm', 'Combo rau sạch mini Dalat Farm, gồm cải ngọt, mồng tơi, rau muống, tiện lợi. Bảo quản trong tủ lạnh.', 'Combo Rau Sạch Mini Dalat Farm', 100000, 'dc9bdcd0-500c-4511-896e-4d828ecfc210', 0.2, 210, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 30, NULL, NULL, 4.5, 13),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 18:39:00.000000', 'combo-trai-cay-mini-dalatfarm', 'Combo trái cây mini Dalat Farm, gồm nho, táo, chuối, tươi ngọt. Bảo quản trong tủ lạnh.', 'Combo Trái Cây Mini Dalat Farm', 130000, 'dc9bdcd0-500c-4511-896e-4d828ecfc210', 0.3, 190, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 29, NULL, NULL, 4.4, 12),
(UUID(), 'admin@gmail.com', '2025-05-24 18:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 'combo-thit-bo-huu-co-dalatfarm', 'Combo thịt bò hữu cơ Dalat Farm, gồm thịt bò thăn, bắp bò, tươi sạch. Bảo quản trong tủ lạnh.', 'Combo Thịt Bò Hữu Cơ Dalat Farm', 400000, 'dc9bdcd0-500c-4511-896e-4d828ecfc210', 0.5, 130, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 28, NULL, NULL, 4.7, 11),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 18:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 18:39:00.000000', 'combo-ca-hoi-tuoi-dalatfarm', 'Combo cá hồi tươi Dalat Farm, gồm cá hồi phi lê, rau ăn kèm, tươi ngon. Bảo quản trong tủ lạnh.', 'Combo Cá Hồi Tươi Dalat Farm', 380000, 'dc9bdcd0-500c-4511-896e-4d828ecfc210', 0.4, 140, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 27, NULL, NULL, 4.6, 10),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 18:39:00.000000', 'combo-rau-gia-vi-dalatfarm', 'Combo rau gia vị Dalat Farm, gồm húng quế, ngò, thì là, tươi thơm. Bảo quản trong tủ lạnh.', 'Combo Rau Gia Vị Dalat Farm', 110000, 'dc9bdcd0-500c-4511-896e-4d828ecfc210', 0.2, 220, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 26, NULL, NULL, 4.5, 9),
(UUID(), 'admin@gmail.com', '2025-05-24 18:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 'combo-thuc-pham-che-bien-dalatfarm', 'Combo thực phẩm chế biến Dalat Farm, gồm xúc xích, chả lụa, tiện lợi. Bảo quản trong tủ lạnh.', 'Combo Thực Phẩm Chế Biến Dalat Farm', 220000, 'dc9bdcd0-500c-4511-896e-4d828ecfc210', 0.3, 160, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 25, NULL, NULL, 4.4, 8),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 18:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 18:39:00.000000', 'combo-rau-cu-huu-co-dalatfarm', 'Combo rau củ hữu cơ Dalat Farm, gồm bắp cải, su su, cà chua, an toàn sức khỏe. Bảo quản trong tủ lạnh.', 'Combo Rau Củ Hữu Cơ Dalat Farm', 190000, 'dc9bdcd0-500c-4511-896e-4d828ecfc210', 0.3, 180, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 24, NULL, NULL, 4.5, 7),

-- Dung-dich-khac (15 bản ghi, Eco Wash)

(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 18:39:00.000000', 'nuoc-tay-da-nang-ecowash-1l', 'Nước tẩy đa năng Eco Wash, làm sạch mọi bề mặt, thân thiện môi trường. Bảo quản nơi khô ráo.', 'Nước Tẩy Đa Năng Eco Wash 1L', 60000, 'dfbeb19c-21d0-4e24-bc60-091f18db6638', 0.2, 250, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 30, 54000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.5, 15),
(UUID(), 'admin@gmail.com', '2025-05-24 18:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 'nuoc-khu-mui-tu-lanh-ecowash-500ml', 'Nước khử mùi tủ lạnh Eco Wash, loại bỏ mùi hôi, an toàn thực phẩm. Bảo quản nơi khô ráo.', 'Nước Khử Mùi Tủ Lạnh Eco Wash 500ml', 45000, 'dfbeb19c-21d0-4e24-bc60-091f18db6638', 0.2, 240, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 29, NULL, NULL, 4.4, 14),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 18:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 18:39:00.000000', 'nuoc-rua-may-giat-ecowash-1l', 'Nước rửa máy giặt Eco Wash, làm sạch lồng giặt, bảo vệ máy giặt. Bảo quản nơi khô ráo.', 'Nước Rửa Máy Giặt Eco Wash 1L', 70000, 'dfbeb19c-21d0-4e24-bc60-091f18db6638', 0.2, 230, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 28, NULL, NULL, 4.5, 13),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 18:39:00.000000', 'nuoc-ve-sinh-dieu-hoa-ecowash-500ml', 'Nước vệ sinh điều hòa Eco Wash, làm sạch bụi bẩn, tăng hiệu suất điều hòa. Bảo quản nơi khô ráo.', 'Nước Vệ Sinh Điều Hòa Eco Wash 500ml', 55000, 'dfbeb19c-21d0-4e24-bc60-091f18db6638', 0.2, 220, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 27, NULL, NULL, 4.4, 12),
(UUID(), 'admin@gmail.com', '2025-05-24 18:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 'nuoc-tay-noi-that-ecowash-800ml', 'Nước tẩy nội thất Eco Wash, làm sạch gỗ, da, thân thiện môi trường. Bảo quản nơi khô ráo.', 'Nước Tẩy Nội Thất Eco Wash 800ml', 65000, 'dfbeb19c-21d0-4e24-bc60-091f18db6638', 0.2, 210, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 26, NULL, NULL, 4.5, 11),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 18:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 18:39:00.000000', 'nuoc-khu-mui-nha-bep-ecowash-500ml', 'Nước khử mùi nhà bếp Eco Wash, loại bỏ mùi dầu mỡ, an toàn sức khỏe. Bảo quản nơi khô ráo.', 'Nước Khử Mùi Nhà Bếp Eco Wash 500ml', 48000, 'dfbeb19c-21d0-4e24-bc60-091f18db6638', 0.2, 200, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 25, NULL, NULL, 4.4, 10),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 18:39:00.000000', 'nuoc-ve-sinh-may-loc-nuoc-ecowash-500ml', 'Nước vệ sinh máy lọc nước Eco Wash, làm sạch màng lọc, an toàn sức khỏe. Bảo quản nơi khô ráo.', 'Nước Vệ Sinh Máy Lọc Nước Eco Wash 500ml', 52000, 'dfbeb19c-21d0-4e24-bc60-091f18db6638', 0.2, 190, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 24, NULL, NULL, 4.5, 9),
(UUID(), 'admin@gmail.com', '2025-05-24 18:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 'nuoc-tay-da-nang-huu-co-ecowash-1l', 'Nước tẩy đa năng hữu cơ Eco Wash, chiết xuất thiên nhiên, an toàn sức khỏe. Bảo quản nơi khô ráo.', 'Nước Tẩy Đa Năng Hữu Cơ Eco Wash 1L', 80000, 'dfbeb19c-21d0-4e24-bc60-091f18db6638', 0.2, 180, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 23, NULL, NULL, 4.6, 8),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 18:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 18:39:00.000000', 'nuoc-khu-mui-phong-ngu-ecowash-500ml', 'Nước khử mùi phòng ngủ Eco Wash, hương lavender, tạo không gian thư giãn. Bảo quản nơi khô ráo.', 'Nước Khử Mùi Phòng Ngủ Eco Wash 500ml', 50000, 'dfbeb19c-21d0-4e24-bc60-091f18db6638', 0.2, 170, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 22, NULL, NULL, 4.4, 7),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 18:39:00.000000', 'nuoc-ve-sinh-lo-vi-song-ecowash-500ml', 'Nước vệ sinh lò vi sóng Eco Wash, làm sạch dầu mỡ, an toàn sức khỏe. Bảo quản nơi khô ráo.', 'Nước Vệ Sinh Lò Vi Sóng Eco Wash 500ml', 55000, 'dfbeb19c-21d0-4e24-bc60-091f18db6638', 0.2, 160, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 21, NULL, NULL, 4.5, 6),
(UUID(), 'admin@gmail.com', '2025-05-24 18:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 'nuoc-tay-tham-ecowash-1l', 'Nước tẩy thảm Eco Wash, làm sạch vết bẩn, bảo vệ sợi thảm. Bảo quản nơi khô ráo.', 'Nước Tẩy Thảm Eco Wash 1L', 75000, 'dfbeb19c-21d0-4e24-bc60-091f18db6638', 0.2, 150, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 20, NULL, NULL, 4.4, 5),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 18:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 18:39:00.000000', 'nuoc-ve-sinh-may-hut-bui-ecowash-500ml', 'Nước vệ sinh máy hút bụi Eco Wash, làm sạch bộ lọc, tăng hiệu suất. Bảo quản nơi khô ráo.', 'Nước Vệ Sinh Máy Hút Bụi Eco Wash 500ml', 58000, 'dfbeb19c-21d0-4e24-bc60-091f18db6638', 0.2, 140, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 19, NULL, NULL, 4.5, 6),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 18:39:00.000000', 'nuoc-khu-mui-nha-ve-sinh-ecowash-500ml', 'Nước khử mùi nhà vệ sinh Eco Wash, loại bỏ mùi hôi, hương chanh tươi mát. Bảo quản nơi khô ráo.', 'Nước Khử Mùi Nhà Vệ Sinh Eco Wash 500ml', 47000, 'dfbeb19c-21d0-4e24-bc60-091f18db6638', 0.2, 130, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 18, NULL, NULL, 4.4, 7),
(UUID(), 'admin@gmail.com', '2025-05-24 18:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 'nuoc-ve-sinh-tu-lanh-ecowash-500ml', 'Nước vệ sinh tủ lạnh Eco Wash, làm sạch bề mặt, an toàn thực phẩm. Bảo quản nơi khô ráo.', 'Nước Vệ Sinh Tủ Lạnh Eco Wash 500ml', 52000, 'dfbeb19c-21d0-4e24-bc60-091f18db6638', 0.2, 120, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 17, NULL, NULL, 4.5, 8),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 18:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 18:39:00.000000', 'nuoc-tay-da-nang-chanh-ecowash-1l', 'Nước tẩy đa năng Eco Wash hương chanh, làm sạch hiệu quả, thân thiện môi trường. Bảo quản nơi khô ráo.', 'Nước Tẩy Đa Năng Chanh Eco Wash 1L', 65000, 'dfbeb19c-21d0-4e24-bc60-091f18db6638', 0.2, 110, 'b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 16, NULL, NULL, 4.4, 9),
-- Hop-gio-qua-bieu-tang (15 bản ghi, Dalat Farm)
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 18:39:00.000000', 'gio-qua-trai-cay-trong-nuoc-dalatfarm', 'Giỏ quà trái cây trong nước Dalat Farm, gồm xoài, bưởi, cam, sang trọng. Bảo quản trong tủ lạnh.', 'Giỏ Quà Trái Cây Trong Nước Dalat Farm', 600000, 'fc130572-0f12-4889-a874-1ce0e6adbc4f', 0.5, 100, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 20, 540000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.7, 25),
(UUID(), 'admin@gmail.com', '2025-05-24 18:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 'gio-qua-trai-cay-nhap-khau-dalatfarm', 'Giỏ quà trái cây nhập khẩu Dalat Farm, gồm táo Mỹ, kiwi, nho mẫu đơn, cao cấp. Bảo quản trong tủ lạnh.', 'Giỏ Quà Trái Cây Nhập Khẩu Dalat Farm', 1200000, 'fc130572-0f12-4889-a874-1ce0e6adbc4f', 0.5, 90, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 19, NULL, NULL, 4.8, 24),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 18:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 18:39:00.000000', 'gio-qua-tet-dalatfarm', 'Giỏ quà Tết Dalat Farm, gồm trái cây, bánh mứt, rượu vang, sang trọng. Bảo quản nơi khô ráo.', 'Giỏ Quà Tết Dalat Farm', 2000000, 'fc130572-0f12-4889-a874-1ce0e6adbc4f', 0.5, 80, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 18, NULL, NULL, 4.7, 23),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 18:39:00.000000', 'gio-qua-huu-co-dalatfarm', 'Giỏ quà hữu cơ Dalat Farm, gồm rau củ, trái cây hữu cơ, an toàn sức khỏe. Bảo quản trong tủ lạnh.', 'Giỏ Quà Hữu Cơ Dalat Farm', 800000, 'fc130572-0f12-4889-a874-1ce0e6adbc4f', 0.5, 100, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 17, NULL, NULL, 4.6, 22),
(UUID(), 'admin@gmail.com', '2025-05-24 18:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 'gio-qua-trai-cay-cao-cap-dalatfarm', 'Giỏ quà trái cây cao cấp Dalat Farm, gồm dâu tây, nho, táo, sang trọng. Bảo quản trong tủ lạnh.', 'Giỏ Quà Trái Cây Cao Cấp Dalat Farm', 1000000, 'fc130572-0f12-4889-a874-1ce0e6adbc4f', 0.5, 95, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 16, NULL, NULL, 4.7, 21),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 18:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 18:39:00.000000', 'gio-qua-tet-huu-co-dalatfarm', 'Giỏ quà Tết hữu cơ Dalat Farm, gồm trái cây, mứt hữu cơ, trà, cao cấp. Bảo quản nơi khô ráo.', 'Giỏ Quà Tết Hữu Cơ Dalat Farm', 1500000, 'fc130572-0f12-4889-a874-1ce0e6adbc4f', 0.5, 85, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 15, NULL, NULL, 4.6, 20),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 18:39:00.000000', 'gio-qua-trai-cay-mini-dalatfarm', 'Giỏ quà trái cây mini Dalat Farm, gồm cam, táo, chuối, tiện lợi. Bảo quản trong tủ lạnh.', 'Giỏ Quà Trái Cây Mini Dalat Farm', 500000, 'fc130572-0f12-4889-a874-1ce0e6adbc4f', 0.4, 110, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 14, NULL, NULL, 4.5, 19),
(UUID(), 'admin@gmail.com', '2025-05-24 18:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 'gio-qua-thuc-pham-cao-cap-dalatfarm', 'Giỏ quà thực phẩm cao cấp Dalat Farm, gồm trái cây, xúc xích, phô mai. Bảo quản trong tủ lạnh.', 'Giỏ Quà Thực Phẩm Cao Cấp Dalat Farm', 1300000, 'fc130572-0f12-4889-a874-1ce0e6adbc4f', 0.5, 90, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 13, NULL, NULL, 4.7, 18),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 18:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 18:39:00.000000', 'gio-qua-trai-cay-vip-dalatfarm', 'Giỏ quà trái cây VIP Dalat Farm, gồm nho mẫu đơn, táo Nhật, lê Hàn, sang trọng. Bảo quản trong tủ lạnh.', 'Giỏ Quà Trái Cây VIP Dalat Farm', 1800000, 'fc130572-0f12-4889-a874-1ce0e6adbc4f', 0.5, 80, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 12, NULL, NULL, 4.8, 17),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 18:39:00.000000', 'gio-qua-tham-benh-dalatfarm', 'Giỏ quà thăm bệnh Dalat Farm, gồm trái cây tươi, sữa, bánh dinh dưỡng. Bảo quản trong tủ lạnh.', 'Giỏ Quà Thăm Bệnh Dalat Farm', 700000, 'fc130572-0f12-4889-a874-1ce0e6adbc4f', 0.5, 100, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 11, NULL, NULL, 4.6, 16),
(UUID(), 'admin@gmail.com', '2025-05-24 18:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 'gio-qua-trai-cay-huu-co-mini-dalatfarm', 'Giỏ quà trái cây hữu cơ mini Dalat Farm, gồm táo, cam, dâu tây hữu cơ. Bảo quản trong tủ lạnh.', 'Giỏ Quà Trái Cây Hữu Cơ Mini Dalat Farm', 550000, 'fc130572-0f12-4889-a874-1ce0e6adbc4f', 0.4, 105, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 10, NULL, NULL, 4.5, 15),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 18:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 18:39:00.000000', 'gio-qua-tet-mini-dalatfarm', 'Giỏ quà Tết mini Dalat Farm, gồm trái cây, bánh mứt, trà, tiện lợi. Bảo quản nơi khô ráo.', 'Giỏ Quà Tết Mini Dalat Farm', 900000, 'fc130572-0f12-4889-a874-1ce0e6adbc4f', 0.5, 95, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 9, NULL, NULL, 4.6, 14),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 18:39:00.000000', 'gio-qua-trai-cay-trong-nuoc-mini-dalatfarm', 'Giỏ quà trái cây trong nước mini Dalat Farm, gồm bưởi, xoài, thanh long. Bảo quản trong tủ lạnh.', 'Giỏ Quà Trái Cây Trong Nước Mini Dalat Farm', 520000, 'fc130572-0f12-4889-a874-1ce0e6adbc4f', 0.4, 110, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 8, NULL, NULL, 4.5, 13),
(UUID(), 'admin@gmail.com', '2025-05-24 18:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 'gio-qua-thuc-pham-huu-co-dalatfarm', 'Giỏ quà thực phẩm hữu cơ Dalat Farm, gồm rau củ, trái cây, mứt hữu cơ. Bảo quản trong tủ lạnh.', 'Giỏ Quà Thực Phẩm Hữu Cơ Dalat Farm', 1100000, 'fc130572-0f12-4889-a874-1ce0e6adbc4f', 0.5, 90, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 7, NULL, NULL, 4.7, 12),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 18:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 18:39:00.000000', 'gio-qua-trai-cay-nhap-khau-mini-dalatfarm', 'Giỏ quà trái cây nhập khẩu mini Dalat Farm, gồm táo Mỹ, nho, kiwi. Bảo quản trong tủ lạnh.', 'Giỏ Quà Trái Cây Nhập Khẩu Mini Dalat Farm', 750000, 'fc130572-0f12-4889-a874-1ce0e6adbc4f', 0.5, 100, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 6, NULL, NULL, 4.6, 11),
-- Combo-di-cho-tiet-kiem (15 bản ghi, Dalat Farm)
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 18:39:00.000000', 'combo-di-cho-tuan-1-dalatfarm', 'Combo đi chợ tuần 1 Dalat Farm, gồm rau xanh, thịt heo, cá basa, tiết kiệm. Bảo quản trong tủ lạnh.', 'Combo Đi Chợ Tuần 1 Dalat Farm', 300000, '7941d5cc-3d0d-4978-8321-8246b61fc67d', 0.4, 150, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 50, 270000, 'f8a8ddbe-dc8b-465d-b877-f688c4ac2e06', 4.5, 20),
(UUID(), 'admin@gmail.com', '2025-05-24 18:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 'combo-di-cho-tuan-2-dalatfarm', 'Combo đi chợ tuần 2 Dalat Farm, gồm rau củ, thịt gà, cá hồi, tiện lợi. Bảo quản trong tủ lạnh.', 'Combo Đi Chợ Tuần 2 Dalat Farm', 350000, '7941d5cc-3d0d-4978-8321-8246b61fc67d', 0.4, 140, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 48, NULL, NULL, 4.6, 19),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 18:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 18:39:00.000000', 'combo-di-cho-tuan-3-dalatfarm', 'Combo đi chợ tuần 3 Dalat Farm, gồm rau sạch, thịt bò, cá basa, tiết kiệm. Bảo quản trong tủ lạnh.', 'Combo Đi Chợ Tuần 3 Dalat Farm', 320000, '7941d5cc-3d0d-4978-8321-8246b61fc67d', 0.4, 130, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 46, NULL, NULL, 4.5, 18),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 18:39:00.000000', 'combo-di-cho-tuan-4-dalatfarm', 'Combo đi chợ tuần 4 Dalat Farm, gồm rau củ, thịt heo, cá hồi, tiện lợi. Bảo quản trong tủ lạnh.', 'Combo Đi Chợ Tuần 4 Dalat Farm', 340000, '7941d5cc-3d0d-4978-8321-8246b61fc67d', 0.4, 120, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 44, NULL, NULL, 4.6, 17),
(UUID(), 'admin@gmail.com', '2025-05-24 18:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 'combo-di-cho-gia-dinh-dalatfarm', 'Combo đi chợ gia đình Dalat Farm, gồm rau, thịt, cá, gia vị, đầy đủ. Bảo quản trong tủ lạnh.', 'Combo Đi Chợ Gia Đình Dalat Farm', 500000, '7941d5cc-3d0d-4978-8321-8246b61fc67d', 0.5, 110, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 42, NULL, NULL, 4.7, 16),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 18:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 18:39:00.000000', 'combo-di-cho-tiet-kiem-mini-dalatfarm', 'Combo đi chợ tiết kiệm mini Dalat Farm, gồm rau xanh, thịt gà, cá basa. Bảo quản trong tủ lạnh.', 'Combo Đi Chợ Tiết Kiệm Mini Dalat Farm', 250000, '7941d5cc-3d0d-4978-8321-8246b61fc67d', 0.3, 100, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 40, NULL, NULL, 4.5, 15),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 18:39:00.000000', 'combo-di-cho-huu-co-dalatfarm', 'Combo đi chợ hữu cơ Dalat Farm, gồm rau củ, thịt bò hữu cơ, an toàn. Bảo quản trong tủ lạnh.', 'Combo Đi Chợ Hữu Cơ Dalat Farm', 450000, '7941d5cc-3d0d-4978-8321-8246b61fc67d', 0.5, 90, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 38, NULL, NULL, 4.6, 14),
(UUID(), 'admin@gmail.com', '2025-05-24 18:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 'combo-di-cho-tuan-5-dalatfarm', 'Combo đi chợ tuần 5 Dalat Farm, gồm rau sạch, thịt heo, cá hồi, tiết kiệm. Bảo quản trong tủ lạnh.', 'Combo Đi Chợ Tuần 5 Dalat Farm', 330000, '7941d5cc-3d0d-4978-8321-8246b61fc67d', 0.4, 80, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 36, NULL, NULL, 4.5, 13),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 18:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 18:39:00.000000', 'combo-di-cho-tuan-6-dalatfarm', 'Combo đi chợ tuần 6 Dalat Farm, gồm rau củ, thịt gà, cá basa, tiện lợi. Bảo quản trong tủ lạnh.', 'Combo Đi Chợ Tuần 6 Dalat Farm', 310000, '7941d5cc-3d0d-4978-8321-8246b61fc67d', 0.4, 70, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 34, NULL, NULL, 4.6, 12),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 18:39:00.000000', 'combo-di-cho-tuan-7-dalatfarm', 'Combo đi chợ tuần 7 Dalat Farm, gồm rau sạch, thịt bò, cá hồi, tiết kiệm. Bảo quản trong tủ lạnh.', 'Combo Đi Chợ Tuần 7 Dalat Farm', 360000, '7941d5cc-3d0d-4978-8321-8246b61fc67d', 0.4, 60, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 32, NULL, NULL, 4.5, 11),
(UUID(), 'admin@gmail.com', '2025-05-24 18:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 'combo-di-cho-tuan-8-dalatfarm', 'Combo đi chợ tuần 8 Dalat Farm, gồm rau củ, thịt heo, cá basa, tiện lợi. Bảo quản trong tủ lạnh.', 'Combo Đi Chợ Tuần 8 Dalat Farm', 320000, '7941d5cc-3d0d-4978-8321-8246b61fc67d', 0.4, 50, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 30, NULL, NULL, 4.6, 10),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 18:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 18:39:00.000000', 'combo-di-cho-gia-dinh-mini-dalatfarm', 'Combo đi chợ gia đình mini Dalat Farm, gồm rau, thịt gà, cá basa, tiết kiệm. Bảo quản trong tủ lạnh.', 'Combo Đi Chợ Gia Đình Mini Dalat Farm', 280000, '7941d5cc-3d0d-4978-8321-8246b61fc67d', 0.3, 100, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 28, NULL, NULL, 4.5, 9),
(UUID(), 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 1, 'admin@gmail.com', '2025-05-24 18:39:00.000000', 'combo-di-cho-huu-co-mini-dalatfarm', 'Combo đi chợ hữu cơ mini Dalat Farm, gồm rau củ, thịt bò hữu cơ, an toàn. Bảo quản trong tủ lạnh.', 'Combo Đi Chợ Hữu Cơ Mini Dalat Farm', 400000, '7941d5cc-3d0d-4978-8321-8246b61fc67d', 0.5, 90, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 26, NULL, NULL, 4.6, 8),
(UUID(), 'admin@gmail.com', '2025-05-24 18:39:00.000000', 1, 'dotuandat2004nd@gmail.com', '2025-05-24 18:39:00.000000', 'combo-di-cho-tuan-9-dalatfarm', 'Combo đi chợ tuần 9 Dalat Farm, gồm rau sạch, thịt heo, cá basa, tiết kiệm. Bảo quản trong tủ lạnh.', 'Combo Đi Chợ Tuần 9 Dalat Farm', 330000, '7941d5cc-3d0d-4978-8321-8246b61fc67d', 0.4, 80, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 24, NULL, NULL, 4.5, 7),
(UUID(), 'pesmobile5404@gmail.com', '2025-05-24 18:39:00.000000', 1, 'doanthitrang@gmail.com', '2025-05-24 18:39:00.000000', 'combo-di-cho-tuan-10-dalatfarm', 'Combo đi chợ tuần 10 Dalat Farm, gồm rau củ, thịt gà, cá hồi, tiện lợi. Bảo quản trong tủ lạnh.', 'Combo Đi Chợ Tuần 10 Dalat Farm', 350000, '7941d5cc-3d0d-4978-8321-8246b61fc67d', 0.4, 70, 'e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b', 22, NULL, NULL, 4.6, 6);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_image`
--

DROP TABLE IF EXISTS `product_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_image` (
  `id` varchar(36) NOT NULL,
  `createdby` varchar(255) DEFAULT NULL,
  `createddate` datetime(6) DEFAULT NULL,
  `is_active` tinyint NOT NULL,
  `modifiedby` varchar(255) DEFAULT NULL,
  `modifieddate` datetime(6) DEFAULT NULL,
  `image_path` varchar(255) NOT NULL,
  `product_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6oo0cvcdtb6qmwsga468uuukk` (`product_id`),
  CONSTRAINT `FK6oo0cvcdtb6qmwsga468uuukk` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_image`
--

LOCK TABLES `product_image` WRITE;
/*!40000 ALTER TABLE `product_image` DISABLE KEYS */;
INSERT INTO `product_image` VALUES ('000983c9-e75a-49c7-a34a-74bc48b27ecb','dotuandat2004nd@gmail.com','2025-03-25 20:12:42.664244',1,'dotuandat2004nd@gmail.com','2025-03-25 20:12:42.664244','5fdade53-e94c-401f-98d6-57c70fedf130.jpg','eadecf1a-53dd-4460-a0ed-4d175a2b000a'),
('08e04431-d330-4cee-a84b-90adc7507d29','dotuandat2004nd@gmail.com','2025-04-04 11:55:17.775546',1,'dotuandat2004nd@gmail.com','2025-04-04 11:55:17.775546','e957fca2-afba-4107-93fe-302e40cc0583.jpg','fcaf6f68-f963-4dce-af8f-c524767834ea'),
('0a93b0fe-c91b-460b-a39e-aad32ac373c3','dotuandat2004nd@gmail.com','2025-04-04 11:58:03.281603',1,'dotuandat2004nd@gmail.com','2025-04-04 11:58:03.281603','fc1042d8-fec7-4fc6-ae0a-626a117e1f2e.webp','c4a9d42f-71a1-4c20-86e8-4c21e3469e6f'),
('1076b3d5-94dc-4565-9822-3b6692ea2b42','dotuandat2004nd@gmail.com','2025-04-04 11:56:36.927329',1,'dotuandat2004nd@gmail.com','2025-04-04 11:56:36.927329','0380cb9e-b5c7-4fef-8eb4-f10673010560.png','af3a0e21-1a61-46a0-82b7-cf4697249c07'),
('19615c3f-b02b-4992-b5ee-542597214984','dotuandat2004nd@gmail.com','2025-04-04 11:56:36.927329',1,'dotuandat2004nd@gmail.com','2025-04-04 11:56:36.927329','17f610b0-25ba-4c25-bf87-68d9425454b5.png','af3a0e21-1a61-46a0-82b7-cf4697249c07'),
('1975ce17-9595-48b7-935c-626df7d82851','dotuandat2004nd@gmail.com','2025-04-04 11:56:01.874481',1,'dotuandat2004nd@gmail.com','2025-04-04 11:56:01.874481','f1cbf677-5240-4b74-a753-22a44f3aa773.png','1a71e553-885e-44bc-9927-648731ea0962'),
('1f10f188-799d-4ff8-82ee-f824f5329b2d','dotuandat2004nd@gmail.com','2025-04-04 11:57:49.095975',1,'dotuandat2004nd@gmail.com','2025-04-04 11:57:49.095975','b6d8046c-c674-4e59-8c3c-43d1cd055151.webp','ab93e3b9-2e84-4dfb-8e9e-2b907505143e'),
('204f33b5-33f6-494b-8ad4-9604e9b1f85b','dotuandat2004nd@gmail.com','2025-04-04 11:58:23.208664',1,'dotuandat2004nd@gmail.com','2025-04-04 11:58:23.208664','539e05eb-eeb6-4447-bc86-363dbe895964.jpg','9a0aae00-5dfa-4c86-8f85-4f62faeec6cf'),
('27134f42-d825-4f73-a373-298d3e6952ad','dotuandat2004nd@gmail.com','2025-03-25 20:12:12.532635',1,'dotuandat2004nd@gmail.com','2025-03-25 20:12:12.532635','2d6bc152-fe61-4556-9dee-4f75cf6f3b07.webp','f75b73a8-353b-4412-8e85-040e376e94e5'),
('2f522c6c-3d6a-46d7-a998-2dc369eeb094','dotuandat2004nd@gmail.com','2025-04-04 11:57:49.095425',1,'dotuandat2004nd@gmail.com','2025-04-04 11:57:49.095425','89b8fd90-98e3-4130-a348-a0ef7ae043e9.webp','ab93e3b9-2e84-4dfb-8e9e-2b907505143e'),
('3084fb47-afde-45aa-a07c-4325eeb10c39','dotuandat2004nd@gmail.com','2025-03-25 20:12:12.533192',1,'dotuandat2004nd@gmail.com','2025-03-25 20:12:12.533192','1ab7a101-24bb-4639-911b-4ba967096318.jpg','f75b73a8-353b-4412-8e85-040e376e94e5'),
('317404d8-d9b1-4572-b6bc-425bfdf3e2b7','dotuandat2004nd@gmail.com','2025-03-25 19:55:08.322020',1,'dotuandat2004nd@gmail.com','2025-03-25 19:55:08.322020','833d151c-1d9b-4221-9013-b6dc04c4edc7.jpg','0e4353ac-d554-48cc-bee4-fa16af1552f7'),
('3a52652f-d040-4597-81f6-30ff513f1efa','dotuandat2004nd@gmail.com','2025-04-04 11:55:17.774543',1,'dotuandat2004nd@gmail.com','2025-04-04 11:55:17.774543','59c22278-8233-4d8e-a6a9-dc217ebb99fb.png','fcaf6f68-f963-4dce-af8f-c524767834ea'),
('3bb7b1b9-fc4c-49ac-8b24-1dfa50b1aaf9','dotuandat2004nd@gmail.com','2025-04-04 11:56:52.854345',1,'dotuandat2004nd@gmail.com','2025-04-04 11:56:52.854345','2fa260d3-3f3e-4706-9c0a-e4b6e79892cb.jpg','cd38996d-e369-424f-bbb0-93c6ece6280a'),
('3d8b797d-a52d-41e8-bec7-9d7042859b7d','dotuandat2004nd@gmail.com','2025-04-04 11:56:01.873835',1,'dotuandat2004nd@gmail.com','2025-04-04 11:56:01.873835','b7cc2520-458c-4a9e-a636-41ba72918b3b.png','1a71e553-885e-44bc-9927-648731ea0962'),
('3f561cbf-081f-4098-b1e2-a00dc154db01','dotuandat2004nd@gmail.com','2025-03-25 20:09:16.166389',1,'dotuandat2004nd@gmail.com','2025-03-25 20:09:16.166389','f3211600-270d-4a36-a215-e1ba2f7f3f85.webp','53622008-8cea-4304-a861-2e32869c0c45'),
('4496bafa-bccc-4de6-b7ce-550e082b863b','dotuandat2004nd@gmail.com','2025-03-25 20:12:42.664787',1,'dotuandat2004nd@gmail.com','2025-03-25 20:12:42.664787','9dd1e89d-06e0-499d-9f17-c6f09c38dfb9.jpg','eadecf1a-53dd-4460-a0ed-4d175a2b000a'),
('4cea8082-8faa-4ff9-ab4a-e8dd9e4e6268','dotuandat2004nd@gmail.com','2025-03-25 20:09:45.725074',1,'dotuandat2004nd@gmail.com','2025-03-25 20:09:45.725074','5f204404-0488-4b9b-914c-85cf2caec29a.jpg','ed919e14-5063-4b42-bcee-6c881db5d21c'),
('505d7f83-2767-4f56-bffc-cc9cbda5bacf','dotuandat2004nd@gmail.com','2025-04-04 11:57:30.496867',1,'dotuandat2004nd@gmail.com','2025-04-04 11:57:30.496867','b6b801dc-4e07-434a-bfcc-9440589bc35d.png','148f186c-acc4-4f5d-b802-80e2a1aed04c'),
('51d69cca-e915-4966-83f6-0818748f353e','dotuandat2004nd@gmail.com','2025-03-25 20:12:27.469447',1,'dotuandat2004nd@gmail.com','2025-03-25 20:12:27.469447','e55b669f-a60c-4837-8f3d-dee3843480cc.webp','ff7a2db9-ade5-431b-96da-de04db3ba72a'),
('59f33cea-c506-4334-a409-72d5c4384522','dotuandat2004nd@gmail.com','2025-03-25 20:12:27.469447',1,'dotuandat2004nd@gmail.com','2025-03-25 20:12:27.469447','837b383b-91d6-46ee-bb23-fc08d3a0e112.webp','ff7a2db9-ade5-431b-96da-de04db3ba72a'),
('5a96015c-3606-4061-a32e-88a3e5dff94f','dotuandat2004nd@gmail.com','2025-03-22 09:59:22.676550',1,'dotuandat2004nd@gmail.com','2025-03-22 09:59:22.676550','4e250ed0-8b64-47bc-8ecf-edf97e2ae806.jpg','71ab414c-9228-430a-a356-523fefcf3691'),
('5be341b2-4e9e-47ca-b6d2-835857391cb9','dotuandat2004nd@gmail.com','2025-03-25 20:09:16.155378',1,'dotuandat2004nd@gmail.com','2025-03-25 20:09:16.155378','f7c47186-a182-4ce7-b52c-04b774cb1055.webp','53622008-8cea-4304-a861-2e32869c0c45'),
('5ee90f31-c9a0-438c-b9e6-f32975e04908','dotuandat2004nd@gmail.com','2025-04-04 11:57:12.263777',1,'dotuandat2004nd@gmail.com','2025-04-04 11:57:12.263777','de3c38a9-1112-49ca-94ed-1b3d9c6fb542.webp','1ba152b2-c6be-4760-85eb-2ac641181afe'),
('6212bed6-a8db-49fe-b228-d8efe9009524','dotuandat2004nd@gmail.com','2025-03-25 20:09:45.723728',1,'dotuandat2004nd@gmail.com','2025-03-25 20:09:45.723728','93f3c939-793c-46b4-890c-f33d053b239a.png','ed919e14-5063-4b42-bcee-6c881db5d21c'),
('678c5e9c-bdc8-455f-845e-12353ea2e1b0','admin@gmail.com','2025-03-25 08:54:43.945857',1,'admin@gmail.com','2025-03-25 08:54:43.945857','db30be94-5915-4bc9-9627-049a1f819e50.jpg','e464bb21-5c91-43de-a392-1f75c5446bb0'),
('67ede65a-a440-4bc1-8b32-1d0e3fd54ff6','admin@gmail.com','2025-03-25 08:54:43.946436',1,'admin@gmail.com','2025-03-25 08:54:43.946436','b61d1fc7-889a-4176-8d92-67c45fa938e2.jpg','e464bb21-5c91-43de-a392-1f75c5446bb0'),
('69984c43-46e3-4bb5-82e1-3014596e1602','admin@gmail.com','2025-03-25 08:54:05.816795',1,'admin@gmail.com','2025-03-25 08:54:05.816795','6f0f17d4-7fc2-4f8b-a58b-8a46ee17beba.jpg','5e2a4f52-906c-4cf8-9ec4-a559524e0879'),
('6ced4a26-e62e-439e-9903-6985f0b54f80','dotuandat2004nd@gmail.com','2025-04-04 11:57:30.496301',1,'dotuandat2004nd@gmail.com','2025-04-04 11:57:30.496301','233cafb2-704d-4cd8-80cf-5e8b51fb6b61.jpg','148f186c-acc4-4f5d-b802-80e2a1aed04c'),
('6edfadb6-18e6-4a31-9a89-5a998321e52a','dotuandat2004nd@gmail.com','2025-04-04 11:58:23.209230',1,'dotuandat2004nd@gmail.com','2025-04-04 11:58:23.209230','fa9598dd-067a-4802-aa30-29d4f0a5d989.jpg','9a0aae00-5dfa-4c86-8f85-4f62faeec6cf'),
('6fe96181-ed7c-4a2f-9c55-f494e315df11','dotuandat2004nd@gmail.com','2025-04-04 11:57:49.095975',1,'dotuandat2004nd@gmail.com','2025-04-04 11:57:49.095975','ec44728e-b501-4370-a5c4-20f765d5acc9.webp','ab93e3b9-2e84-4dfb-8e9e-2b907505143e'),
('77025968-18be-422e-88be-e38440ac5595','admin@gmail.com','2025-03-25 08:54:05.831326',1,'admin@gmail.com','2025-03-25 08:54:05.831326','d198f11a-dec1-413c-9c1f-8ff3bcadb323.jpg','5e2a4f52-906c-4cf8-9ec4-a559524e0879'),
('795382a9-9d5e-4898-b7a6-3d7bf7d2d82e','dotuandat2004nd@gmail.com','2025-04-04 11:56:52.855458',1,'dotuandat2004nd@gmail.com','2025-04-04 11:56:52.855458','4e8d0e45-babc-436e-9ee1-10d201b2469d.png','cd38996d-e369-424f-bbb0-93c6ece6280a'),
('7f7bf37b-73af-4e5a-93fa-a64bde417e72','dotuandat2004nd@gmail.com','2025-03-21 16:26:07.640180',1,'dotuandat2004nd@gmail.com','2025-03-21 16:26:07.640180','6f05b443-0d92-493b-93ba-7b7b76d8e5ce.jpg','7f6f7e9d-6ae1-46cd-9615-82ade765ae0c'),
('7fbfe4ed-a021-4b82-931f-48f720e2bbff','dotuandat2004nd@gmail.com','2025-03-25 20:09:45.724340',1,'dotuandat2004nd@gmail.com','2025-03-25 20:09:45.724340','2efae04d-a18c-40bb-a066-d0055185a7bf.jpg','ed919e14-5063-4b42-bcee-6c881db5d21c'),
('85dab8dc-5560-4d9e-8b65-ee435c9b4137','dotuandat2004nd@gmail.com','2025-04-04 11:58:58.854567',1,'dotuandat2004nd@gmail.com','2025-04-04 11:58:58.854567','69ab5943-d9c7-492f-b6e2-a37797201848.png','4f688179-ba15-4207-a3a9-bc00f5cb9b69'),
('8d826292-f3a8-4016-9b7d-7a3137a22bde','dotuandat2004nd@gmail.com','2025-03-25 20:12:27.468868',1,'dotuandat2004nd@gmail.com','2025-03-25 20:12:27.468868','e0e01a3c-592b-42d7-ad3c-9c065309daf5.jpg','ff7a2db9-ade5-431b-96da-de04db3ba72a'),
('91805ca4-0768-4cf2-b44c-f82afc972aaf','dotuandat2004nd@gmail.com','2025-03-22 09:59:22.676550',1,'dotuandat2004nd@gmail.com','2025-03-22 09:59:22.676550','d3887622-e557-4d3b-8ef2-606b16a65c93.jpg','71ab414c-9228-430a-a356-523fefcf3691'),
('91cbfe18-49ed-4a68-99c1-1d3cc77dd81c','dotuandat2004nd@gmail.com','2025-04-04 11:58:58.854567',1,'dotuandat2004nd@gmail.com','2025-04-04 11:58:58.854567','6ee88b7e-eb14-450b-b1f0-feecf61add88.png','4f688179-ba15-4207-a3a9-bc00f5cb9b69'),
('94a434b6-a860-4726-9379-07d9785a64aa','dotuandat2004nd@gmail.com','2025-03-22 09:59:22.672536',1,'dotuandat2004nd@gmail.com','2025-03-22 09:59:22.672536','4bfcb929-d7d1-4089-8275-ff9d5a80a3d5.jpg','71ab414c-9228-430a-a356-523fefcf3691'),
('972d9422-d2ea-44b8-a4df-3cef7bc1204e','dotuandat2004nd@gmail.com','2025-03-25 19:55:08.322020',1,'dotuandat2004nd@gmail.com','2025-03-25 19:55:08.322020','9de85fb4-83d3-4aa4-9c31-1e0acd2094bb.jpg','0e4353ac-d554-48cc-bee4-fa16af1552f7'),
('9755f718-e386-4191-bed1-6122c23a1840','dotuandat2004nd@gmail.com','2025-04-04 11:56:36.926818',1,'dotuandat2004nd@gmail.com','2025-04-04 11:56:36.926818','257fc985-000b-4a00-a6db-3e297e184d6e.png','af3a0e21-1a61-46a0-82b7-cf4697249c07'),
('a51e4766-17ab-44b2-b2c1-9625912bf2f9','dotuandat2004nd@gmail.com','2025-03-25 20:12:12.534903',1,'dotuandat2004nd@gmail.com','2025-03-25 20:12:12.534903','80e5a6e3-e74c-4a2c-a509-c823ccfa138e.jpg','f75b73a8-353b-4412-8e85-040e376e94e5'),
('aa1ccb4d-e094-42b6-9c92-b7cb97ea5a32','dotuandat2004nd@gmail.com','2025-04-04 11:55:17.775546',1,'dotuandat2004nd@gmail.com','2025-04-04 11:55:17.775546','7a0f1071-14d9-4c45-a34c-5fdbb8265f53.jpg','fcaf6f68-f963-4dce-af8f-c524767834ea'),
('ab920c56-88f6-4854-b56d-584e662e6c00','dotuandat2004nd@gmail.com','2025-04-04 11:56:52.854895',1,'dotuandat2004nd@gmail.com','2025-04-04 11:56:52.854895','ea821749-9e94-4a2e-af7c-20cef20347dd.jpg','cd38996d-e369-424f-bbb0-93c6ece6280a'),
('b31e13bf-a2ac-44b1-824d-669e3fd8acd6','dotuandat2004nd@gmail.com','2025-04-04 11:57:12.264890',1,'dotuandat2004nd@gmail.com','2025-04-04 11:57:12.264890','12554d53-5bb8-4950-9807-a417c625859e.webp','1ba152b2-c6be-4760-85eb-2ac641181afe'),
('b441135c-2b28-45ff-a0eb-6762f28d72db','dotuandat2004nd@gmail.com','2025-04-04 13:32:20.796736',1,'dotuandat2004nd@gmail.com','2025-04-04 13:32:20.796736','8e1a43a1-2c2f-4b0b-a264-041b307df9bb.webp','71ab414c-9228-430a-a356-523fefcf3691'),
('b523e0d8-8393-4abc-b476-89512a68ced2','dotuandat2004nd@gmail.com','2025-04-04 11:58:42.535015',1,'dotuandat2004nd@gmail.com','2025-04-04 11:58:42.535015','cd4b614a-3cc8-413b-b760-d5802af4e635.jpg','80b4f151-0089-4dd9-a239-5eb61d09bfb7'),
('b835001d-c356-4676-89fd-f57100c82b27','dotuandat2004nd@gmail.com','2025-04-04 11:58:03.281603',1,'dotuandat2004nd@gmail.com','2025-04-04 11:58:03.281603','35537cd6-3e7a-4260-b882-4c40eadb8b60.webp','c4a9d42f-71a1-4c20-86e8-4c21e3469e6f'),
('ba7b4275-c352-469c-bb32-709a81912991','dotuandat2004nd@gmail.com','2025-04-04 11:59:34.423396',1,'dotuandat2004nd@gmail.com','2025-04-04 11:59:34.423396','771e52e2-ece1-4831-8c69-711e435e067c.jpg','349c97b3-d00f-4afd-ab38-899e3b1bd15b'),
('be62873c-60bb-4c83-8d92-5a2229d4b5bc','dotuandat2004nd@gmail.com','2025-04-04 11:57:12.264890',1,'dotuandat2004nd@gmail.com','2025-04-04 11:57:12.264890','ebea9b80-3da3-455e-8ba1-2242c38c7f07.webp','1ba152b2-c6be-4760-85eb-2ac641181afe'),
('c38c9a26-10f8-4032-b3f0-e0679e4ede1e','admin@gmail.com','2025-03-21 14:45:05.002450',1,'admin@gmail.com','2025-03-21 14:45:05.002450','d6b02e2e-ea96-4fbb-bb02-bfa345f0982a.jpg','6f4cc978-0ead-4dbc-8fdb-1b8c05346666'),
('cb91982c-b61e-43c3-98b4-1ed7e899f8b8','dotuandat2004nd@gmail.com','2025-04-04 11:58:58.854567',1,'dotuandat2004nd@gmail.com','2025-04-04 11:58:58.854567','69a5d9c2-cc91-4535-8d48-65573dc2ddde.jpg','4f688179-ba15-4207-a3a9-bc00f5cb9b69'),
('cbb6c06a-f04e-401a-84a0-539ef4a44c69','dotuandat2004nd@gmail.com','2025-03-22 12:40:40.929558',1,'dotuandat2004nd@gmail.com','2025-03-22 12:40:40.929558','38455e8f-0497-4f0a-8fbe-b1a003da1a25.jpg','3ce0a6cd-132a-4fb4-8009-2aa84934a685'),
('cbbed9ec-889c-45d1-9287-7d89d2069fa9','dotuandat2004nd@gmail.com','2025-04-04 11:57:30.496867',1,'dotuandat2004nd@gmail.com','2025-04-04 11:57:30.496867','bfdfda89-c226-4cfa-8e6e-f742515f7524.png','148f186c-acc4-4f5d-b802-80e2a1aed04c'),
('cc7a814f-df28-4d67-a61a-487cf4c40ea3','dotuandat2004nd@gmail.com','2025-04-04 11:56:01.874481',1,'dotuandat2004nd@gmail.com','2025-04-04 11:56:01.874481','e56e003e-614a-474c-a3b4-83d4715a527a.jpg','1a71e553-885e-44bc-9927-648731ea0962'),
('cfe1723c-0caf-4b08-a7b6-1b80fb7abdea','dotuandat2004nd@gmail.com','2025-04-04 11:58:23.209230',1,'dotuandat2004nd@gmail.com','2025-04-04 11:58:23.209230','9aa2bbb4-3569-4617-bcb7-395559518aef.jpg','9a0aae00-5dfa-4c86-8f85-4f62faeec6cf'),
('d27e8f0c-2d15-4ff9-8b06-12554fed5a0e','admin@gmail.com','2025-03-25 08:54:43.946985',1,'admin@gmail.com','2025-03-25 08:54:43.946985','4ce21081-b85a-43e7-911e-8ad0a9a05310.jpg','e464bb21-5c91-43de-a392-1f75c5446bb0'),
('d4719b5a-c1df-4428-a206-edce32a5a017','admin@gmail.com','2025-03-25 08:54:05.831326',1,'admin@gmail.com','2025-03-25 08:54:05.831326','a30b310d-5fa2-48f8-8c71-de07d830ced0.jpg','5e2a4f52-906c-4cf8-9ec4-a559524e0879'),
('d50b8066-fa66-473d-85ee-72209ad9d8e9','dotuandat2004nd@gmail.com','2025-04-04 11:59:34.422840',1,'dotuandat2004nd@gmail.com','2025-04-04 11:59:34.422840','9a322c04-d6b0-4c21-a97c-9386fdbc23d2.jpg','349c97b3-d00f-4afd-ab38-899e3b1bd15b'),
('f1f2b291-041d-4abf-a291-1929fe8c6051','dotuandat2004nd@gmail.com','2025-03-25 20:12:42.665341',1,'dotuandat2004nd@gmail.com','2025-03-25 20:12:42.665341','dbe17c3e-cc6e-484c-9be0-0a6f2d9ce2f1.webp','eadecf1a-53dd-4460-a0ed-4d175a2b000a'),
('f3e1c9a7-4c39-4db9-bf80-34e17a1d3a24','dotuandat2004nd@gmail.com','2025-04-04 11:58:42.535662',1,'dotuandat2004nd@gmail.com','2025-04-04 11:58:42.535662','bdf5ec50-391f-4570-a323-afb723308d44.jpg','80b4f151-0089-4dd9-a239-5eb61d09bfb7'),
('fc0df1b8-1cef-47a9-b4a0-f8290d8673cd','dotuandat2004nd@gmail.com','2025-04-04 11:58:03.282152',1,'dotuandat2004nd@gmail.com','2025-04-04 11:58:03.282152','9862ce8a-c839-4e69-9ce9-3033a60b1abb.webp','c4a9d42f-71a1-4c20-86e8-4c21e3469e6f');
/*!40000 ALTER TABLE `product_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `id` varchar(36) NOT NULL,
  `createdby` varchar(255) DEFAULT NULL,
  `createddate` datetime(6) DEFAULT NULL,
  `is_active` tinyint NOT NULL,
  `modifiedby` varchar(255) DEFAULT NULL,
  `modifieddate` datetime(6) DEFAULT NULL,
  `comment` varchar(500) DEFAULT NULL,
  `rating` int NOT NULL,
  `order_id` varchar(36) NOT NULL,
  `product_id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK80acgchiskxpcqegik62mf1jg` (`order_id`),
  KEY `FKiyof1sindb9qiqr9o8npj8klt` (`product_id`),
  KEY `FKj8m0asijw8lfl4jxhcps8tf4y` (`user_id`),
  CONSTRAINT `FK80acgchiskxpcqegik62mf1jg` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`),
  CONSTRAINT `FKiyof1sindb9qiqr9o8npj8klt` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FKj8m0asijw8lfl4jxhcps8tf4y` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES ('0318c4d7-e132-43fc-a4cf-59cdad79d105','haosua@gmail.com','2025-03-15 10:24:05.931716',1,'haosua@gmail.com','2025-03-15 10:24:05.931716',NULL,5,'a271e378-461a-41bd-95d1-aebb1c202ad4','cd38996d-e369-424f-bbb0-93c6ece6280a','a90533bf-ce4b-4187-8c5e-77046b70c03e'),
('041c2fc0-8d88-49cf-9bc3-93c47cf1ee7f','haosua@gmail.com','2025-03-15 10:24:00.816500',1,'haosua@gmail.com','2025-03-15 10:24:00.816500',NULL,5,'a271e378-461a-41bd-95d1-aebb1c202ad4','1a71e553-885e-44bc-9927-648731ea0962','a90533bf-ce4b-4187-8c5e-77046b70c03e'),
('0a7909bc-96d3-4a9b-b344-06d990254e2d','doanthitrang@gmail.com','2025-03-10 15:13:57.330088',1,'doanthitrang@gmail.com','2025-03-10 15:13:57.330088','Sản phẩm tốt !!!',5,'72412cdb-063f-4af9-9824-e7749fabee82','16f1cf00-9b54-49df-b0a8-9935877ecad9','0a262bfd-d8c9-426f-a2f7-abaec3b0039c'),
('0c90b1fd-1939-42d4-95f8-92ba58e28202','dotuandat2004nd@gmail.com','2025-03-08 18:24:07.824123',1,'dotuandat2004nd@gmail.com','2025-03-08 18:24:07.824123','GOOD',5,'55e229de-b332-4d3e-8efe-a55c0f35c7d0','53622008-8cea-4304-a861-2e32869c0c45','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('0c9dd7ec-a9c2-4961-adab-a7323671a95f','dotuandat2004nd@gmail.com','2025-03-24 12:18:57.330684',1,'dotuandat2004nd@gmail.com','2025-03-24 12:18:57.330684',NULL,5,'29e0ae88-dd5b-4e74-8163-6a9bfaa8beea','ed919e14-5063-4b42-bcee-6c881db5d21c','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('0fda8012-8707-4a4c-87f7-51858422a596','dotuandat2004nd@gmail.com','2025-03-09 00:34:09.568630',0,'admin@gmail.com','2025-03-16 16:21:35.695459','!oke',3,'580dc181-b7fb-4834-b696-fb84436a06ca','ed919e14-5063-4b42-bcee-6c881db5d21c','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('111dcd76-1b86-48e7-ba3d-3482e7902948','dotuandat2004nd@gmail.com','2025-03-09 00:33:55.178276',1,'dotuandat2004nd@gmail.com','2025-03-09 00:33:55.178276','oke\n',5,'ce5cd10e-0f9a-4764-aa72-38a97d6e6729','0e4353ac-d554-48cc-bee4-fa16af1552f7','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('12605d3c-2fab-4828-b709-64bdcb934b70','admin@gmail.com','2025-03-11 09:00:55.187567',1,'admin@gmail.com','2025-03-11 09:00:55.187567',NULL,5,'daf27e75-7fe6-451e-ac4e-85692f25832c','71ab414c-9228-430a-a356-523fefcf3691','a7ddd32e-f737-4ff4-af59-18144fc9a432'),
('1ee60744-819a-494d-b409-79ccb9c9abf2','haosua@gmail.com','2025-03-15 10:24:10.632271',1,'haosua@gmail.com','2025-03-15 10:24:10.632271',NULL,5,'a271e378-461a-41bd-95d1-aebb1c202ad4','148f186c-acc4-4f5d-b802-80e2a1aed04c','a90533bf-ce4b-4187-8c5e-77046b70c03e'),
('2a82f297-64ad-4464-9b85-df9235400b40','huyquanhoa@gmail.com','2025-03-08 23:04:25.787413',0,'admin@gmail.com','2025-03-16 16:39:48.273913','Đắt quá !',3,'80474789-5dce-4413-b66f-cc05a4845277','fcaf6f68-f963-4dce-af8f-c524767834ea','024317a8-9e55-419d-bb9e-ed4cb104d020'),
('2b28e456-999a-4e33-8f04-ab3bf9852036','dvlam@gmail.com','2025-03-16 16:42:41.833809',1,'dvlam@gmail.com','2025-03-16 16:42:41.833809',NULL,5,'71834902-fffa-426a-be67-21764f063146','ed919e14-5063-4b42-bcee-6c881db5d21c','0e285053-f2fd-485d-9f2f-4ea8d6951d17'),
('2b564f2a-442e-4914-8ba0-3c1f95c08e68','haosua@gmail.com','2025-03-15 10:23:57.991424',1,'haosua@gmail.com','2025-03-15 10:23:57.991424',NULL,5,'a271e378-461a-41bd-95d1-aebb1c202ad4','4f688179-ba15-4207-a3a9-bc00f5cb9b69','a90533bf-ce4b-4187-8c5e-77046b70c03e'),
('33ded1c9-fc86-464e-9635-b58f37d6ca6f','pesmobile5404@gmail.com','2025-03-16 16:44:00.059384',0,'dotuandat2004nd@gmail.com','2025-03-16 16:44:38.889735',NULL,1,'813cb0da-da71-482d-bf5d-f42cd58be122','ed919e14-5063-4b42-bcee-6c881db5d21c','d435d2b6-34f2-4226-85d4-1149f12c4761'),
('3e1cbbf1-4551-4072-baf5-ad98ad2e4aec','xiaolingamingxg@gmail.com','2025-03-08 21:36:00.280652',1,'xiaolingamingxg@gmail.com','2025-03-08 21:36:00.280652',NULL,5,'2df09e5a-78b9-47ed-849e-81312d0e9b1d','0e4353ac-d554-48cc-bee4-fa16af1552f7','8491c9bb-e3a3-4436-abd8-c3d74216d422'),
('4015d911-1869-4fcd-be90-563f0d5b3448','xiaolingamingxg@gmail.com','2025-03-08 21:34:23.590313',1,'xiaolingamingxg@gmail.com','2025-03-08 21:34:23.590313',NULL,4,'bee79ece-d649-4b9b-848b-7347ad10fb58','0e4353ac-d554-48cc-bee4-fa16af1552f7','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('40c5f957-c43d-4621-8bf9-5f9df7b5f17b','pesmobile5404@gmail.com','2025-03-16 16:44:17.982574',1,'pesmobile5404@gmail.com','2025-03-16 16:44:17.982574',NULL,5,'3207eaf8-1a44-489b-8194-551354cef121','fcaf6f68-f963-4dce-af8f-c524767834ea','d435d2b6-34f2-4226-85d4-1149f12c4761'),
('423a1068-5518-41c4-91da-3d46c6b4d5d6','nqhai@gmail.com','2025-03-09 16:01:03.463119',1,'nqhai@gmail.com','2025-03-09 16:01:03.463119',NULL,4,'3c23df98-712d-4ee5-872f-a93d0e834317','349c97b3-d00f-4afd-ab38-899e3b1bd15b','d0abf087-be2a-4a40-b002-bfff337c026f'),
('425b49e0-2b45-48a0-a0a8-3b2c41622e68','nqhai@gmail.com','2025-03-16 16:32:08.248319',0,'admin@gmail.com','2025-03-16 16:33:15.414848',NULL,5,'b8d815e8-b00f-4a7e-a4d7-cd9257ef7fe1','ed919e14-5063-4b42-bcee-6c881db5d21c','d0abf087-be2a-4a40-b002-bfff337c026f'),
('463de7f3-84c7-4745-a2cb-c170ff4d7b35','qwerty@gmail.com','2025-03-17 01:26:14.572412',0,'admin@gmail.com','2025-03-17 01:26:45.067671',NULL,1,'6f772e57-c137-4172-8b3f-f65d23513aae','c4a9d42f-71a1-4c20-86e8-4c21e3469e6f','20731af4-0523-4f77-8e17-f800af2bb718'),
('48cb6b78-ef99-43ad-a7c1-9c20aedd9563','haosua@gmail.com','2025-03-15 10:23:52.494857',1,'haosua@gmail.com','2025-03-15 10:23:52.494857',NULL,5,'a271e378-461a-41bd-95d1-aebb1c202ad4','b2b5d2e3-7f13-49ca-91da-7bd969f794b8','a90533bf-ce4b-4187-8c5e-77046b70c03e'),
('4ad4cc5f-a3fb-4518-a7a8-5c3147498c65','dotuandat2004nd@gmail.com','2025-03-09 00:29:33.068594',1,'dotuandat2004nd@gmail.com','2025-03-09 00:29:33.068594','oke\n',5,'3c64f3f3-d43c-4d52-a14e-77b3622b9d58','5e2a4f52-906c-4cf8-9ec4-a559524e0879','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('4ef791bb-3d58-42c8-bd0c-fc4ff82180f0','dotuandat2004nd@gmail.com','2025-03-24 12:18:51.883755',1,'dotuandat2004nd@gmail.com','2025-03-24 12:18:51.883755',NULL,5,'29e0ae88-dd5b-4e74-8163-6a9bfaa8beea','53622008-8cea-4304-a861-2e32869c0c45','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('5213670b-1a20-4316-9a0d-ef5feb79f3af','jame4@gmail.com','2025-03-25 19:46:04.940193',1,'jame4@gmail.com','2025-03-25 19:46:04.940193',NULL,5,'467d8eb7-00c3-4143-acf7-03cfa57a3ff1','c873e3c6-4459-4134-9ea8-a5163db96242','a6664967-a0da-4b31-b893-1b4241881672'),
('54e1d503-4431-4e9e-a864-351044e1fc73','vvlam@gmail.com','2025-03-11 18:15:47.446533',1,'vvlam@gmail.com','2025-03-11 18:15:47.446533',NULL,4,'cbabaaa4-2f8a-4927-8212-6854f4b89817','0e4353ac-d554-48cc-bee4-fa16af1552f7','dc73d495-715f-4795-97dd-bd05b73e9668'),
('580e6abf-2cc0-4160-ac7a-ce0ceb5083d2','jame4@gmail.com','2025-03-25 19:46:07.874244',1,'jame4@gmail.com','2025-03-25 19:46:07.874244',NULL,5,'467d8eb7-00c3-4143-acf7-03cfa57a3ff1','cd38996d-e369-424f-bbb0-93c6ece6280a','a6664967-a0da-4b31-b893-1b4241881672'),
('5814dd3c-b97e-4836-adf0-141367a5b70e','nqhai@gmail.com','2025-03-09 16:00:45.935108',1,'nqhai@gmail.com','2025-03-09 16:00:45.935108',NULL,4,'fd0bcb32-9f3e-4666-9cc8-84c7568bff8f','eadecf1a-53dd-4460-a0ed-4d175a2b000a','d0abf087-be2a-4a40-b002-bfff337c026f'),
('5e378ccc-572a-4403-a2da-cd6414b320f0','haosua@gmail.com','2025-03-15 10:24:03.256672',1,'haosua@gmail.com','2025-03-15 10:24:03.256672',NULL,5,'a271e378-461a-41bd-95d1-aebb1c202ad4','71ab414c-9228-430a-a356-523fefcf3691','a90533bf-ce4b-4187-8c5e-77046b70c03e'),
('5ec1024b-da35-4015-958e-826acd189518','dotuandat2004nd@gmail.com','2025-03-08 17:19:18.256071',0,'admin@gmail.com','2025-03-16 16:39:25.729704','oke',4,'20cf20a7-8067-4e21-9011-e21e2efd3124','53622008-8cea-4304-a861-2e32869c0c45','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('67a483de-bd37-422e-ada1-d2fa5632b0f6','nqhai@gmail.com','2025-03-16 16:33:59.295550',1,'nqhai@gmail.com','2025-03-16 16:33:59.295550',NULL,4,'1b22190c-8523-4671-8045-d6b667b5dc40','f75b73a8-353b-4412-8e85-040e376e94e5','d0abf087-be2a-4a40-b002-bfff337c026f'),
('67fc69ae-b9b1-4465-aaec-0f4557e2b4a2','dotuandat2004nd@gmail.com','2025-03-08 18:49:04.985850',0,'admin@gmail.com','2025-03-16 16:29:06.006679','Tạm\nKhông ngon lắm',3,'67e235bc-6821-4ea2-9988-46072d66403c','ed919e14-5063-4b42-bcee-6c881db5d21c','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('680106d8-761e-4a8f-91ba-2c322858f53e','dotuandat2004nd@gmail.com','2025-03-09 14:27:32.566314',0,'admin@gmail.com','2025-03-16 16:17:59.349137','Giao chậm',2,'4e589222-ce87-47d5-bd6a-366f0c9d0043','0e4353ac-d554-48cc-bee4-fa16af1552f7','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('6ae1da5f-113e-4964-8499-7d27bd03a9da','haosua@gmail.com','2025-03-15 10:23:48.268315',1,'haosua@gmail.com','2025-03-15 10:23:48.268315',NULL,5,'a271e378-461a-41bd-95d1-aebb1c202ad4','e464bb21-5c91-43de-a392-1f75c5446bb0','a90533bf-ce4b-4187-8c5e-77046b70c03e'),
('6f866a66-b3f9-407b-9f58-21fb282838f1','dotuandat2004nd@gmail.com','2025-03-08 18:05:39.381682',1,'dotuandat2004nd@gmail.com','2025-03-08 18:05:39.381682','oke',5,'97ff1c63-19e6-49c5-87c8-0b6e72f84e79','0e4353ac-d554-48cc-bee4-fa16af1552f7','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('749de048-206b-42ee-bd6c-3b4fbd0f8f8c','haosua@gmail.com','2025-03-15 10:24:08.397646',1,'haosua@gmail.com','2025-03-15 10:24:08.397646',NULL,5,'a271e378-461a-41bd-95d1-aebb1c202ad4','80b4f151-0089-4dd9-a239-5eb61d09bfb7','a90533bf-ce4b-4187-8c5e-77046b70c03e'),
('776ef222-2056-4801-8020-ceb258e920fe','dotuandat2004nd@gmail.com','2025-04-04 11:54:14.014227',1,'dotuandat2004nd@gmail.com','2025-04-04 11:54:14.014227',NULL,4,'0d1d4739-45f4-488a-8fd8-994e08fede5f','71ab414c-9228-430a-a356-523fefcf3691','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('781dbfc2-217b-4685-8574-5ecc5b01d909','dotuandat2004nd@gmail.com','2025-03-24 12:18:54.609732',1,'dotuandat2004nd@gmail.com','2025-03-24 12:18:54.609732',NULL,5,'29e0ae88-dd5b-4e74-8163-6a9bfaa8beea','71ab414c-9228-430a-a356-523fefcf3691','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('7937b17d-b1b4-4fd0-a5ba-9c4ad281a7b8','haosua@gmail.com','2025-03-15 10:23:45.552454',1,'haosua@gmail.com','2025-03-15 10:23:45.552454',NULL,5,'a271e378-461a-41bd-95d1-aebb1c202ad4','0ebf1a90-739d-49af-bf50-023441bbb245','a90533bf-ce4b-4187-8c5e-77046b70c03e'),
('7d773136-7926-46bd-846c-6bcdb1eb7684','haosua@gmail.com','2025-03-15 10:23:50.341848',1,'haosua@gmail.com','2025-03-15 10:23:50.341848',NULL,5,'a271e378-461a-41bd-95d1-aebb1c202ad4','af3a0e21-1a61-46a0-82b7-cf4697249c07','a90533bf-ce4b-4187-8c5e-77046b70c03e'),
('826db4c1-a961-4a4a-94bc-2bfd5daf2e83','nqhai@gmail.com','2025-03-09 16:00:58.171489',1,'nqhai@gmail.com','2025-03-09 16:00:58.171489',NULL,4,'e75ddfc1-588a-4072-a1e0-ad882cf3929f','0e4353ac-d554-48cc-bee4-fa16af1552f7','d0abf087-be2a-4a40-b002-bfff337c026f'),
('888f0d64-8023-4deb-8b30-ce7848e0b09e','huyquanhoa@gmail.com','2025-03-08 23:04:07.532130',1,'huyquanhoa@gmail.com','2025-03-08 23:04:07.532130','Oke !!!',5,'3e49ce81-9a48-4ddd-9a9e-d4fc14b70f30','71ab414c-9228-430a-a356-523fefcf3691','024317a8-9e55-419d-bb9e-ed4cb104d020'),
('89427ebc-7f76-44b4-9df8-b8ad0ea4029c','dotuandat2004nd@gmail.com','2025-03-08 22:53:58.694334',0,'admin@gmail.com','2025-03-16 16:21:37.244292',NULL,1,'68a064b7-c4e0-4480-bb92-5baa312fac02','ed919e14-5063-4b42-bcee-6c881db5d21c','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('8c5d906c-a0c2-41ff-875c-742fab879e2b','haosua@gmail.com','2025-03-15 10:24:12.822271',1,'haosua@gmail.com','2025-03-15 10:24:12.822271',NULL,5,'a271e378-461a-41bd-95d1-aebb1c202ad4','4f80115f-9d53-4e40-b4d8-e363aff005bd','a90533bf-ce4b-4187-8c5e-77046b70c03e'),
('8cdf7077-b220-45bd-a585-97712be80885','dotuandat2004nd@gmail.com','2025-03-11 07:18:01.161233',1,'dotuandat2004nd@gmail.com','2025-03-11 07:18:01.161233','Đắt',2,'4fd50b8d-eb85-4004-b4f6-9c3956950c62','349c97b3-d00f-4afd-ab38-899e3b1bd15b','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('94d741f1-9ad4-456d-a6ba-0d73f7943ca6','pesmobile5404@gmail.com','2025-03-16 16:44:15.147396',1,'pesmobile5404@gmail.com','2025-03-16 16:44:15.147396',NULL,5,'3207eaf8-1a44-489b-8194-551354cef121','f75b73a8-353b-4412-8e85-040e376e94e5','d435d2b6-34f2-4226-85d4-1149f12c4761'),
('94d92437-17a0-4880-a9fe-cc09c424501f','nqhai@gmail.com','2025-03-09 16:00:52.531306',1,'nqhai@gmail.com','2025-03-09 16:00:52.531306',NULL,5,'eb131799-f54b-4cd5-b0e8-3e2bffb6fab4','fcaf6f68-f963-4dce-af8f-c524767834ea','d0abf087-be2a-4a40-b002-bfff337c026f'),
('994d0b34-225c-40fb-a76b-c03a86ead246','haosua@gmail.com','2025-03-15 10:23:43.232828',1,'haosua@gmail.com','2025-03-15 10:23:43.232828',NULL,5,'a271e378-461a-41bd-95d1-aebb1c202ad4','ff7a2db9-ade5-431b-96da-de04db3ba72a','a90533bf-ce4b-4187-8c5e-77046b70c03e'),
('9ae3b909-81ca-4798-93e0-921b07f907b5','nqhai@gmail.com','2025-03-09 16:01:08.758888',1,'nqhai@gmail.com','2025-03-09 16:01:08.758888',NULL,5,'324e039f-5a61-44dc-8771-2bba0b366854','53622008-8cea-4304-a861-2e32869c0c45','d0abf087-be2a-4a40-b002-bfff337c026f'),
('9b237d86-217b-478e-9780-cc6141afdb11','dotuandat2004nd@gmail.com','2025-03-11 07:17:43.895237',1,'dotuandat2004nd@gmail.com','2025-03-11 07:17:43.895237','oke',5,'4fd50b8d-eb85-4004-b4f6-9c3956950c62','53622008-8cea-4304-a861-2e32869c0c45','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('a1dd977f-2fc4-4383-9604-fc6971f3e85d','vvlam@gmail.com','2025-03-11 18:15:43.035118',1,'vvlam@gmail.com','2025-03-11 18:15:43.035118',NULL,5,'cbabaaa4-2f8a-4927-8212-6854f4b89817','5e2a4f52-906c-4cf8-9ec4-a559524e0879','dc73d495-715f-4795-97dd-bd05b73e9668'),
('a4e1b3bf-fce0-402c-99ab-005e4850869f','dotuandat2004nd@gmail.com','2025-03-12 20:40:47.697177',1,'dotuandat2004nd@gmail.com','2025-03-12 20:40:47.697177',NULL,5,'5a4168ef-4e36-4f19-94f6-a6f59ba87e1e','eadecf1a-53dd-4460-a0ed-4d175a2b000a','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('b7913b8e-48d1-492b-88e7-f1619f0aface','dotuandat2004nd@gmail.com','2025-03-08 18:09:01.045386',1,'dotuandat2004nd@gmail.com','2025-03-08 18:09:01.045386',NULL,5,'55e229de-b332-4d3e-8efe-a55c0f35c7d0','0e4353ac-d554-48cc-bee4-fa16af1552f7','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('bf0c0901-6536-45f3-87a1-db37bc04b6db','dotuandat2004nd@gmail.com','2025-03-09 12:55:35.823518',1,'dotuandat2004nd@gmail.com','2025-03-09 12:55:35.823518','oke',5,'319b11c3-d290-492d-b99d-e5ce67e37fa4','0e4353ac-d554-48cc-bee4-fa16af1552f7','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('c27dd73d-3384-4ae4-9ff8-50f4e3d083cd','qwerty@gmail.com','2025-03-17 01:26:11.956258',0,'admin@gmail.com','2025-03-17 01:26:57.311355',NULL,1,'6f772e57-c137-4172-8b3f-f65d23513aae','ab93e3b9-2e84-4dfb-8e9e-2b907505143e','20731af4-0523-4f77-8e17-f800af2bb718'),
('caa5c7d9-8f82-44c9-ab53-7b4a4c9782e3','vvlam@gmail.com','2025-03-11 18:15:40.383466',1,'vvlam@gmail.com','2025-03-11 18:15:40.383466',NULL,4,'cbabaaa4-2f8a-4927-8212-6854f4b89817','71ab414c-9228-430a-a356-523fefcf3691','dc73d495-715f-4795-97dd-bd05b73e9668'),
('d32fbffe-2465-440d-a6d7-4cf3a871922c','dotuandat2004nd@gmail.com','2025-03-09 01:21:33.591283',1,'dotuandat2004nd@gmail.com','2025-03-09 01:21:33.591283','Quá oke!',5,'69629a51-56f3-47da-b639-94429838c002','71ab414c-9228-430a-a356-523fefcf3691','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('d758e17f-3326-4aef-a81e-78a46e2ab454','nqhai@gmail.com','2025-03-09 16:00:38.093351',1,'nqhai@gmail.com','2025-03-09 16:00:38.093351',NULL,4,'7b4bdf68-adb4-47c3-9245-64c620d29d13','5e2a4f52-906c-4cf8-9ec4-a559524e0879','d0abf087-be2a-4a40-b002-bfff337c026f'),
('dab3a6b4-7fcc-453c-8560-0613e06af54d','nqhai@gmail.com','2025-03-09 16:01:25.348916',0,'admin@gmail.com','2025-03-16 16:21:32.812978',NULL,1,'796ca1af-cdeb-4ff0-87da-be0017be7372','ed919e14-5063-4b42-bcee-6c881db5d21c','d0abf087-be2a-4a40-b002-bfff337c026f'),
('e19e1d67-2827-4e38-8c2d-ab14260947d9','huyquanhoa@gmail.com','2025-03-08 18:31:14.534602',0,'admin@gmail.com','2025-03-16 16:38:53.520071','oke',3,'06f7a494-3f96-463d-8c4f-d324e18aed4f','eadecf1a-53dd-4460-a0ed-4d175a2b000a','024317a8-9e55-419d-bb9e-ed4cb104d020'),
('e5196b5c-63f1-4cd3-a73e-7be941e37b8a','nqhai@gmail.com','2025-03-09 16:01:17.890021',0,'admin@gmail.com','2025-03-16 16:36:02.619903',NULL,3,'dbc0a2d3-bea1-4d66-a880-3262222616e7','71ab414c-9228-430a-a356-523fefcf3691','d0abf087-be2a-4a40-b002-bfff337c026f'),
('e633502f-cb3d-4165-a5ae-e7f706329a5f','pesmobile5404@gmail.com','2025-03-16 16:44:20.986793',1,'pesmobile5404@gmail.com','2025-03-16 16:44:20.986793',NULL,5,'3207eaf8-1a44-489b-8194-551354cef121','ff7a2db9-ade5-431b-96da-de04db3ba72a','d435d2b6-34f2-4226-85d4-1149f12c4761'),
('e7cfd892-3698-4dfe-b84d-3a044005f48f','huyquanhoa@gmail.com','2025-03-16 16:32:32.667708',0,'admin@gmail.com','2025-03-16 16:32:58.624796',NULL,1,'45aa6ec0-75bd-49c8-a093-76814e829e1d','ed919e14-5063-4b42-bcee-6c881db5d21c','024317a8-9e55-419d-bb9e-ed4cb104d020'),
('e8274a61-c770-4da0-9640-da5ed62176fd','haosua@gmail.com','2025-03-15 10:23:38.252202',1,'haosua@gmail.com','2025-03-15 10:23:38.252202',NULL,5,'a271e378-461a-41bd-95d1-aebb1c202ad4','53622008-8cea-4304-a861-2e32869c0c45','a90533bf-ce4b-4187-8c5e-77046b70c03e'),
('e8b8c596-b523-41f0-852a-3130230502ff','huyquanhoa@gmail.com','2025-03-08 18:31:23.106829',1,'huyquanhoa@gmail.com','2025-03-08 18:31:23.106829',NULL,4,'12c02487-4e93-4f8c-8f1a-50717dcc7048','349c97b3-d00f-4afd-ab38-899e3b1bd15b','024317a8-9e55-419d-bb9e-ed4cb104d020'),
('ea9564a1-f0ee-4313-babf-569ae31dc027','vvlam@gmail.com','2025-03-11 18:15:49.925184',1,'vvlam@gmail.com','2025-03-11 18:15:49.925184',NULL,4,'cbabaaa4-2f8a-4927-8212-6854f4b89817','53622008-8cea-4304-a861-2e32869c0c45','dc73d495-715f-4795-97dd-bd05b73e9668'),
('ebaa1f96-2cf7-47f1-94a1-851a7913362f','haosua@gmail.com','2025-03-15 10:23:40.894377',1,'haosua@gmail.com','2025-03-15 10:23:40.894377',NULL,5,'a271e378-461a-41bd-95d1-aebb1c202ad4','f75b73a8-353b-4412-8e85-040e376e94e5','a90533bf-ce4b-4187-8c5e-77046b70c03e'),
('ed498f16-2ae8-4a64-a4d1-0a77f70534c3','haosua@gmail.com','2025-03-15 10:23:54.528500',1,'haosua@gmail.com','2025-03-15 10:23:54.528500',NULL,5,'a271e378-461a-41bd-95d1-aebb1c202ad4','1ba152b2-c6be-4760-85eb-2ac641181afe','a90533bf-ce4b-4187-8c5e-77046b70c03e'),
('fadf2948-7d5d-44e2-8ef4-ba61285ccc9a','nqhai@gmail.com','2025-03-16 16:32:05.744798',1,'nqhai@gmail.com','2025-03-16 16:32:05.744798',NULL,5,'b8d815e8-b00f-4a7e-a4d7-cd9257ef7fe1','71ab414c-9228-430a-a356-523fefcf3691','d0abf087-be2a-4a40-b002-bfff337c026f');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` varchar(36) NOT NULL,
  `code` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_active` tinyint NOT NULL,
  `createddate` datetime(6) DEFAULT NULL,
  `modifieddate` datetime(6) DEFAULT NULL,
  `createdby` varchar(255) DEFAULT NULL,
  `modifiedby` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES ('4f213730-ede7-4709-ac08-ab849fc779de','STAFF_INVENTORY','Nhân viên kiểm kho',1,NULL,NULL,NULL,NULL),
('5376954e-d221-40cb-afa4-35a196ac6769','CUSTOMER','Khách hàng',1,NULL,NULL,NULL,NULL),
('844a29ca-5087-44dc-ab67-1b95628fcd4d','STAFF_SALE','Nhân viên bán hàng',1,NULL,NULL,NULL,NULL),
('b2251a4c-b2f5-48ee-add4-bbd55c543d75','ADMIN','Admin',1,NULL,NULL,NULL,NULL),
('d05f2583-888c-4c8a-bea4-cb5b76154684','STAFF_CUSTOMER_SERVICE','Nhân viên chăm sóc khách hàng',1,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permission`
--

DROP TABLE IF EXISTS `role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_permission` (
  `roleid` varchar(36) NOT NULL,
  `permissionid` varchar(36) NOT NULL,
  PRIMARY KEY (`roleid`,`permissionid`),
  KEY `permissionid` (`permissionid`),
  CONSTRAINT `role_permission_ibfk_1` FOREIGN KEY (`roleid`) REFERENCES `role` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_permission_ibfk_2` FOREIGN KEY (`permissionid`) REFERENCES `permission` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permission`
--

LOCK TABLES `role_permission` WRITE;
/*!40000 ALTER TABLE `role_permission` DISABLE KEYS */;
INSERT INTO `role_permission` VALUES ('4f213730-ede7-4709-ac08-ab849fc779de','004ed0bc-77f0-4f93-a0a2-a3fde7876a45'),
('b2251a4c-b2f5-48ee-add4-bbd55c543d75','004ed0bc-77f0-4f93-a0a2-a3fde7876a45'),
('844a29ca-5087-44dc-ab67-1b95628fcd4d','135e804e-96d8-4277-b4db-6e80a5aac2d8'),
('b2251a4c-b2f5-48ee-add4-bbd55c543d75','135e804e-96d8-4277-b4db-6e80a5aac2d8'),
('844a29ca-5087-44dc-ab67-1b95628fcd4d','32467d71-c742-4635-a534-e7697ec8273d'),
('b2251a4c-b2f5-48ee-add4-bbd55c543d75','32467d71-c742-4635-a534-e7697ec8273d'),
('4f213730-ede7-4709-ac08-ab849fc779de','5ffc3ccb-e554-4793-b308-f7efef403bbb'),
('b2251a4c-b2f5-48ee-add4-bbd55c543d75','5ffc3ccb-e554-4793-b308-f7efef403bbb'),
('b2251a4c-b2f5-48ee-add4-bbd55c543d75','7c6ef485-d953-48c1-9d64-3187b1dff00d'),
('d05f2583-888c-4c8a-bea4-cb5b76154684','7c6ef485-d953-48c1-9d64-3187b1dff00d'),
('b2251a4c-b2f5-48ee-add4-bbd55c543d75','aa9e9619-1e50-46ed-9a57-707ac83a052e'),
('d05f2583-888c-4c8a-bea4-cb5b76154684','aa9e9619-1e50-46ed-9a57-707ac83a052e'),
('b2251a4c-b2f5-48ee-add4-bbd55c543d75','d6b15258-983f-47b7-ba9b-8400adfd6184'),
('d05f2583-888c-4c8a-bea4-cb5b76154684','d6b15258-983f-47b7-ba9b-8400adfd6184'),
('4f213730-ede7-4709-ac08-ab849fc779de','f15f8989-6cd5-4f89-95c3-778b7f790bcf'),
('b2251a4c-b2f5-48ee-add4-bbd55c543d75','f15f8989-6cd5-4f89-95c3-778b7f790bcf');
/*!40000 ALTER TABLE `role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `id` varchar(36) NOT NULL,
  `createdby` varchar(255) DEFAULT NULL,
  `createddate` datetime(6) DEFAULT NULL,
  `is_active` tinyint NOT NULL,
  `modifiedby` varchar(255) DEFAULT NULL,
  `modifieddate` datetime(6) DEFAULT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKu0lh6hby20ok7au7646wrewl` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES 
('a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d','dotuandat2004nd@gmail.com','2025-02-17 01:13:18.125767',1,'dotuandat2004nd@gmail.com','2025-02-17 01:13:18.125767','dalat-greens','Dalat Greens'),
('b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e','pesmobile5404@gmail.com','2025-02-16 12:42:29.960038',1,'pesmobile5404@gmail.com','2025-02-16 12:42:29.960038','organic-farm_vn','Organic Farm VN'),
('c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f','dotuandat2004nd@gmail.com','2025-02-15 10:29:30.935135',1,'dotuandat2004nd@gmail.com','2025-02-15 10:30:00.798146','vissan','Vissan'),
('d4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a','dotuandat2004nd@gmail.com','2025-02-17 00:45:04.278391',1,'dotuandat2004nd@gmail.com','2025-02-17 00:45:04.278391','cp-foods','CP Foods'),
('e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b','dotuandat2004nd@gmail.com','2025-02-16 22:18:52.334828',1,'dotuandat2004nd@gmail.com','2025-02-16 22:18:52.334828','fruit-import-co','Fruit Import Co.'),
('f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c','admin@gmail.com','2025-02-09 14:36:02.314080',1,'dotuandat2004nd@gmail.com','2025-02-09 18:00:16.006165','global-fresh','Global Fresh'),
('a7b8c9d0-e1f2-4a3b-5c6d-7e8f9a0b1c2d','dotuandat2004nd@gmail.com','2025-02-17 01:07:52.077248',1,'dotuandat2004nd@gmail.com','2025-02-17 01:07:52.077248','green-clean','Green Clean'),
('b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e','dotuandat2004nd@gmail.com','2025-02-17 00:48:49.595649',1,'dotuandat2004nd@gmail.com','2025-02-17 00:48:49.595649','eco-wash','Eco Wash'),
('c9d0e1f2-a3b4-4c5d-6e7f-9a0b1c2d3e4f','dotuandat2004nd@gmail.com','2025-02-17 00:52:32.863783',1,'dotuandat2004nd@gmail.com','2025-02-17 00:52:32.863783','natural-farm','Natural Farm'),
('d0e1f2a3-b4c5-4d6e-7f8a-0b1c2d3e4f5a','dotuandat2004nd@gmail.com','2025-02-17 00:50:46.530388',1,'dotuandat2004nd@gmail.com','2025-02-17 00:50:46.530388','fresh-garden','Fresh Garden'),
('e1f2a3b4-c5d6-4e7f-8a9b-1c2d3e4f5a6b','pesmobile5404@gmail.com','2025-02-16 12:38:39.609488',1,'pesmobile5404@gmail.com','2025-02-16 12:38:39.609488','vinamilk','Vinamilk'),
('f2a3b4c5-d6e7-4f8a-9b0c-2d3e4f5a6b7c','dotuandat2004nd@gmail.com','2025-02-16 22:19:03.888171',1,'dotuandat2004nd@gmail.com','2025-02-16 22:19:03.888171','th-true-milk','TH True Milk'),
('a3b4c5d6-e7f8-4a9b-0c1d-3e4f5a6b7c8d','dotuandat2004nd@gmail.com','2025-02-17 01:09:25.645923',1,'dotuandat2004nd@gmail.com','2025-02-17 01:09:25.645923','asia-foods','Asia Foods'),
('b4c5d6e7-f8a9-4b0c-1d2e-4f5a6b7c8d9e','dotuandat2004nd@gmail.com','2025-02-17 00:42:59.045731',1,'dotuandat2004nd@gmail.com','2025-02-17 00:42:59.045731','hanoi-organics','Hanoi Organics'),
('c5d6e7f8-a9b0-4c1d-2e3f-5a6b7c8d9e0f','dotuandat2004nd@gmail.com','2025-02-17 01:06:26.181220',1,'dotuandat2004nd@gmail.com','2025-02-17 01:06:26.181220','saigon-fresh','Saigon Fresh'),
('d6e7f8a9-b0c1-4d2e-3f4a-6b7c8d9e0f1a','pesmobile5404@gmail.com','2025-02-16 12:34:57.623047',1,'pesmobile5404@gmail.com','2025-02-16 12:34:57.623047','bac-tom','Bac Tom'),
('e7f8a9b0-c1d2-4e3f-4a5b-7c8d9e0f1a2b','dotuandat2004nd@gmail.com','2025-02-16 22:19:21.715377',1,'dotuandat2004nd@gmail.com','2025-02-16 22:19:21.715377','dalat-farm','Dalat Farm'),
('f8a9b0c1-d2e3-4f4a-5b6c-8d9e0f1a2b3c','dotuandat2004nd@gmail.com','2025-02-16 22:18:41.115223',1,'dotuandat2004nd@gmail.com','2025-02-16 22:18:41.115223','mekong-foods','Mekong Foods'),
('a9b0c1d2-e3f4-4a5b-6c7d-9e0f1a2b3c4d','dotuandat2004nd@gmail.com','2025-02-16 22:19:14.771816',1,'dotuandat2004nd@gmail.com','2025-02-16 22:19:14.771816','green-fields','Green Fields'),
('b0c1d2e3-f4a5-4b6c-7d8e-0f1a2b3c4d5e','dotuandat2004nd@gmail.com','2025-02-09 15:01:20.509410',1,'dotuandat2004nd@gmail.com','2025-03-22 12:31:31.982161','tropical-fruit','Tropical Fruit'),
('c1d2e3f4-a5b6-4c7d-8e9f-1a2b3c4d5e6f','dotuandat2004nd@gmail.com','2025-02-17 00:47:22.071397',1,'dotuandat2004nd@gmail.com','2025-02-17 00:47:22.071397','pure-organics','Pure Organics');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` varchar(36) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) NOT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `dob` date DEFAULT NULL,
  `is_active` tinyint NOT NULL,
  `createddate` datetime(6) DEFAULT NULL,
  `modifieddate` datetime(6) DEFAULT NULL,
  `createdby` varchar(255) DEFAULT NULL,
  `modifiedby` varchar(255) DEFAULT NULL,
  `is_guest` tinyint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('024317a8-9e55-419d-bb9e-ed4cb104d020','$2a$10$nvzSPO26RCFUoI1sPu64Zei3dpudtd4pOBqnZ807VjFHPOh00e44q','Huy Quần Hoa','0205671231','huyquanhoa@gmail.com',NULL,1,'2025-03-07 15:11:38.852707','2025-03-08 18:31:01.333989','anonymousUser','anonymousUser',0),
('0a262bfd-d8c9-426f-a2f7-abaec3b0039c','$2a$10$hSOGrZdNvIIo7PIFdV5CKeSKxN5kXFfHpJRFP8DE5lC0k.uvRe8um','Đoàn Thị Trang','0893472345','doanthitrang@gmail.com',NULL,1,'2025-03-09 23:34:26.082386','2025-03-10 15:13:17.721624','anonymousUser','anonymousUser',0),
('0e285053-f2fd-485d-9f2f-4ea8d6951d17','$2a$10$7shHrWWWmRyW4I44fbS9auOQM2DQC/ohlM3EhcdiwOBinD2Kc2pL6','Đặng Văn Lâm','0953849748','dvlam@gmail.com','1995-08-30',1,'2025-01-12 23:52:38.178518','2025-02-09 15:10:46.450580','anonymousUser','dotuandat2004nd@gmail.com',0),
('16763e4f-8c7f-4d78-b90f-3f52ff0227b2','$2a$10$.xdZoTjASteid/OtDb0H5uwrxsqLjQZSvgCFsdoGrTHMD.4pPm/QK','Bùi Trí Dũng','0205671231','btdung@gmail.com','2000-08-19',1,'2025-03-12 17:17:55.961214','2025-03-12 17:20:38.244474','anonymousUser','admin@gmail.com',0),
('17d14953-7765-4d41-a2a0-d278aab024ba','$2a$10$Oe9LIFd5PCDoCW3YCBD4duACevlUYn12TjAYCeWZboIHa9IKC7pQi','Selena Gomez','0777777777','selenagz@gmail.com','1999-01-01',0,'2025-01-07 00:42:26.250821',NULL,NULL,NULL,0),
('17f6dcdd-dc2d-42f6-9361-34cc1e3b5c53','$2a$10$Uv6JuPdKNCA9E7BxOAfYxeoNopbRCyReRyMP9X.Sj7Y3KuJk3jJkG','Nguyễn Trọng Hoàng','0987656789','nthoang@gmail.com','1990-12-31',1,'2025-01-12 15:50:28.623016','2025-01-12 15:50:28.623016','anonymousUser','anonymousUser',0),
('1e92be5e-320c-4606-854e-27bc0814b803','$2a$10$BSxhR5l1pEarkx2nFJ4qFOj68qZ2f3c30J0JIKEr8oLAymkOPKrtO','Mai Thị Hồng','0983247594','mthong@gmail.com',NULL,1,'2025-03-10 00:01:54.484068','2025-03-10 00:01:54.484068','anonymousUser','anonymousUser',0),
('1ffca06b-0ee6-45ff-8d52-dbdba8440c75',NULL,'Jame','0205671231','jame2@gmail.com',NULL,1,'2025-03-25 19:16:38.174879','2025-03-25 19:16:38.174879','anonymousUser','anonymousUser',1),
('20731af4-0523-4f77-8e17-f800af2bb718','$2a$10$eXcMGPNnoAN/s9Mwjqnudu0g57pQZq.rXa9cP3oi36cA/uQlM1ONu','QWERTY','0944761755','qwerty@gmail.com',NULL,1,'2025-03-17 01:23:57.505444','2025-03-17 01:26:01.571851','anonymousUser','anonymousUser',0),
('2172f496-dfaf-4450-9148-f3fecc0a40f8','$2a$10$1TSqtce81lsmacqIU4u/7.kRLSTQFciyWyu04BmFcKtTeWuHFQLmi','Huy','0348975394','huy90@gmail.com',NULL,1,'2025-03-07 13:55:27.777813','2025-03-07 13:57:11.786232','anonymousUser','anonymousUser',0),
('21aeec38-45d8-4a94-bb93-e57e12a8e226','$2a$10$BRT/QAvQ6MGsGvlqqQ.G8uJiF7bDsABdHAxeAMgE.HRBNO2inrPNy','TEST & TEST','0975434543','testtest@gmail.com','1997-09-23',1,'2025-03-10 00:02:48.935669','2025-03-10 00:28:46.407099','anonymousUser','dotuandat2004nd@gmail.com',0),
('3625139c-5bcd-4cca-bbec-0d33d5005d2c','$2a$10$9UgFGORjkshV6DcDk8N/T.M2hX/7qLI/JBLXdVzAV8tPnrV3v4x1G','Đạt Đỗ Tuấn','0686868686','dotuandat932004@gmail.com',NULL,1,'2025-01-07 00:42:26.250821','2025-02-07 23:21:06.437333',NULL,'dotuandat2004nd@gmail.com',0),
('3c2ba82a-f421-406d-8e65-2546ff28298e','$2a$10$o6CiA0E3iWZjbFLk50QuGe.BHk7NbPaEsFrUZpWlrf0FzBxytbbJa','Super Hero',NULL,'superhero@gmail.com','1999-01-01',0,'2025-01-07 00:42:26.250821','2025-01-10 22:10:20.995613',NULL,'dotuandat2004nd@gmail.com',0),
('58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02','$2a$10$9UgFGORjkshV6DcDk8N/T.M2hX/7qLI/JBLXdVzAV8tPnrV3v4x1G','Đỗ Tuấn Đạt','0944761755','dotuandat2004nd@gmail.com','2004-04-05',1,'2025-01-07 00:42:26.250821','2025-03-12 20:52:36.655578',NULL,'dotuandat2004nd@gmail.com',0),
('5d337705-f5f9-47c4-9a0a-591be82ba00f','$2a$10$Y578lRcWG735QijT1cU6BO1nkPPFDbJszbfiSSmx.ZqRgsF9.BM.W','Phạm Văn An','0987654123','phamvanan@gmail.com',NULL,1,'2025-01-07 00:42:26.250821',NULL,NULL,NULL,0),
('5f169d55-675f-4825-99e4-fe902635ad6a','$2a$10$AkMWApaTBWqPdqRvd0RIau7WUw14FFZu55Qp//uyl41Q8.HquQ2R.','Test Test','0123456789','test001@gmail.com',NULL,0,'2025-02-22 12:00:21.536476','2025-02-22 12:01:18.748334','anonymousUser','dotuandat2004nd@gmail.com',0),
('637dab9b-00b7-436f-bc54-06fa3ecfd289','$2a$10$4STghHz.TW55.ekDpaN0FuLIecxuUQENwDyXSBHVWbWTodnHX8uK2','John David','0686868686','david123@gmail.com','1999-01-01',1,'2025-01-07 00:42:26.250821','2025-02-16 00:06:53.360690',NULL,'dotuandat2004nd@gmail.com',0),
('65041e99-64d4-4f5a-9d8c-576719adec9d','$2a$10$QBV6abH3.FGYiUy6Gnb4z.EViObKRXvQEAteOYgyK9fzCt2rFVoOK','Nguyễn Công Bằng','0932845893','ncbang@gmail.com','2010-11-29',1,'2025-03-12 19:01:50.603936','2025-03-15 10:22:12.963485','anonymousUser','admin@gmail.com',0),
('715e5eaf-60ac-4554-b00b-16f58ce23c3c',NULL,'Phạm Xuân Mạnh','0000000000','guest@gmail.com',NULL,1,'2025-01-11 11:05:01.546609','2025-03-09 23:21:32.625377','anonymousUser','dotuandat2004nd@gmail.com',1),
('7241e571-1d3a-47e8-b1d9-6dc8942b2f3e',NULL,'TEST & TEST','0000000000','test002@gmail.com',NULL,1,'2025-03-04 19:50:02.404156','2025-03-09 23:21:23.597028','anonymousUser','dotuandat2004nd@gmail.com',1),
('8491c9bb-e3a3-4436-abd8-c3d74216d422',NULL,'Elon Musk','0888888888','richchoi@gmail.com',NULL,1,'2025-03-04 22:16:38.390149','2025-03-09 23:20:15.095635','anonymousUser','dotuandat2004nd@gmail.com',1),
('8b7d2186-6c43-4365-aab7-c957075b68f5',NULL,'nhiên nguyễn',NULL,'nhienn750@gmail.com',NULL,1,'2025-01-07 00:42:26.250821',NULL,NULL,NULL,0),
('8de76534-51ca-48e5-b776-6dffb98f3835',NULL,'Phong T1','0348952893','phongt1@gmail.com',NULL,1,'2025-03-17 11:44:23.219707','2025-03-17 11:44:23.219707','anonymousUser','anonymousUser',1),
('93c1c628-da91-4834-a776-4e3c9d7220b6',NULL,'Phong Đoàn','0328923235','dtphong@gmail.com',NULL,1,'2025-03-04 22:09:46.210816','2025-03-09 23:20:36.285629','anonymousUser','dotuandat2004nd@gmail.com',1),
('a6664967-a0da-4b31-b893-1b4241881672','$2a$10$E5Dxt/YSg8gwMabWZj9SD.Zg3hlEU.g7uIipL1mkpWIbBW.RttVGO','Jame','0342734587','jame4@gmail.com',NULL,1,'2025-03-25 19:40:23.347366','2025-03-25 19:45:38.212187','anonymousUser','anonymousUser',0),
('a7ddd32e-f737-4ff4-af59-18144fc9a432','$2a$10$jU0uL44cuIeROxWyJ20vAu2LNglQXtAexczchPvdvfKSg7GA6ksGC','ADMIN','0999999999','admin@gmail.com','2004-04-05',1,'2025-01-07 00:42:26.250821','2025-03-17 11:32:59.961049',NULL,'admin@gmail.com',0),
('a83217e6-4591-4d14-b822-d7de6b728454',NULL,'TEST & TEST','0000000000','test003@gmail.com',NULL,1,'2025-03-04 21:05:56.372617','2025-03-09 23:21:12.633892','anonymousUser','dotuandat2004nd@gmail.com',1),
('a90533bf-ce4b-4187-8c5e-77046b70c03e','$2a$10$Z3ZuJWPYxVybY5eN0044i.W1F3qxDVSo1llo9cg9q7vVMlz.gw0qm','Hào Sữa','0987654321','haosua@gmail.com',NULL,1,'2025-03-15 10:18:28.235157','2025-03-15 10:23:17.485208','anonymousUser','admin@gmail.com',0),
('afff85d7-53e8-40f9-9271-440bde54b151','$2a$10$qbfMnnYS3U40pQk5scrdeu2om0iuvwq6ZGxhryr2W6Z6cipcgdgcu','Đoàn Thị Yến','0987654567','dtyen@gmail.com','2000-07-24',1,'2025-01-07 00:42:26.250821',NULL,NULL,NULL,0),
('b3e71cdf-5efa-4d05-a164-23b46b60750d','$2a$10$enQ3ulE/hrujJXntBqB69eAkL0tJLMRprAqv6ugdxApRKTcOER3N.','TTP. Tuấn','0205671231','j97@gmail.com','1997-08-19',1,'2025-03-05 21:18:11.660036','2025-03-05 22:28:58.279243','anonymousUser','dotuandat2004nd@gmail.com',0),
('b4efe810-eec2-4fe0-93cf-85f38748aa16',NULL,'Trần Đình Trọng','0123456987','guest123@gmail.com','1990-10-10',1,'2025-01-12 14:07:22.773356','2025-01-12 15:48:31.535607','anonymousUser','anonymousUser',1),
('bc2b20c0-49d8-4f5a-83eb-600cb8086d92',NULL,'Jame','0342734587','jame5@gamil.com',NULL,1,'2025-03-25 19:47:12.747791','2025-03-25 19:47:12.747791','anonymousUser','anonymousUser',1),
('c2672bf7-d02f-4a99-aefd-6042bbfc374b',NULL,'Vũ Thịnh','0350934875','vuthinh13@gmail.com',NULL,1,'2025-03-17 11:47:48.240324','2025-03-17 11:47:48.240324','anonymousUser','anonymousUser',1),
('c4f58d63-22e7-45c2-b99f-94471ba74dac','$2a$10$30u8o1lYlmCsnpBMAnceB.FTjNsUeyYttiDz1V7Cobx/rrRADwKN2','Timber','0955996933','timber1234@gmail.com','1999-04-15',1,'2025-01-07 00:42:26.250821','2025-01-11 00:40:33.845887',NULL,'dotuandat2004nd@gmail.com',0),
('c6182f9b-e889-43b0-b30e-2802c7ff73c9','$2a$10$0O.2Of8fA82/40ZaEsZxKeaAGtyGd5YgMcz0ijyZzcT4Ze4P8JhcK','Ngô Thu Thảo','0832943759','ntthao@gmail.com',NULL,1,'2025-03-17 12:35:45.255429','2025-03-17 12:35:45.255429','anonymousUser','anonymousUser',0),
('c68506d2-7c97-4f6e-b51a-826f467dbd4e',NULL,'Vũ Văn Abc','0345345435','abc@gmail.com',NULL,1,'2025-03-09 00:40:22.950004','2025-03-09 23:19:28.329552','anonymousUser','dotuandat2004nd@gmail.com',1),
('ce43ca27-1e60-4713-affb-81d91fe04994','$2a$10$HQY3sZ6tYwt9hzmFoXxEku4cm1Znj3ifm64GR72x3zeg8LvOI0ndu','Mark','0348572748','mark123@gmail.com','1999-01-01',1,'2025-01-07 00:42:26.250821',NULL,NULL,NULL,0),
('cfdae048-449a-4e64-aabc-1422eb3c0f2b',NULL,'Lê Bảo Bình','0359679235','lbbinh@gmail.com',NULL,1,'2025-03-15 10:10:16.190615','2025-03-15 10:10:16.190615','anonymousUser','anonymousUser',1),
('d0a11fcf-b08f-4116-86e7-ffc7e978246e','$2a$10$I/suujbs434ive0uIXUcfupYS/0qvRys.2CChGgAT8ev8eCVNTyN2','Đinh Thanh Bình','0325385098','dtbinh@gmail.com',NULL,1,'2025-01-13 00:13:00.396646','2025-01-13 00:15:28.570544','anonymousUser','dotuandat2004nd@gmail.com',0),
('d0abf087-be2a-4a40-b002-bfff337c026f','$2a$10$9e0hfWIpRbMWuioMG9Fl2eG4FCC3UTSjX4MTJb2.q8YkNgDBQlX.S','Nguyễn Quang Hải','0955996933','nqhai@gmail.com','1997-04-12',1,'2025-01-08 23:25:57.468101','2025-03-11 11:04:43.750720','anonymousUser','nqhai@gmail.com',0),
('d435d2b6-34f2-4226-85d4-1149f12c4761','$2a$10$RWwle5LA6sUbRtfaWWuzz.stSmys3KK3OtexU9s4h6tiuE95KVKL6','Đạt Đỗ Tuấn','0987654321','pesmobile5404@gmail.com',NULL,1,'2025-01-07 00:42:26.250821','2025-02-12 23:29:14.336779',NULL,'dotuandat2004nd@gmail.com',0),
('dc4cb5e8-00b7-4c85-bed7-85a9e96de897',NULL,'Jame','0205671231','jame3@gmail.com',NULL,1,'2025-03-25 19:32:00.016974','2025-03-25 19:32:00.016974','anonymousUser','anonymousUser',1),
('dc73d495-715f-4795-97dd-bd05b73e9668','$2a$10$WEJShM.ACjMwOB2dnof1KuBlTTomnzSfAwa4w7kmhqMJ3a9v8zydO','Vũ Văn Lâm','0205671231','vvlam@gmail.com','2002-12-18',1,'2025-01-07 00:42:26.250821','2025-03-13 22:24:19.473639','anonymousUser','vvlam@gmail.com',0),
('dcecb39a-f6a8-4c92-b0d3-e42e6579bee3','$2a$10$v7vzTo7Z7M.ww2j.cNYbIuswnAmXIaebK68xhRtwhl2t9XNTJQmSy','Phan Sơn Tùng',NULL,'xiaolingamingxg@gmail.com',NULL,1,'2025-01-07 00:42:26.250821',NULL,NULL,NULL,0),
('decd643b-2bce-411c-8b04-ffaf9681ac10','$2a$10$HrzsPxYBbsg1MGR6urp0weWHjGcChrH7iLguKPdqz8QHHwmlcDCJ2','Bùi Mạnh','0342958973','bmanh005@gmail.com',NULL,1,'2025-03-16 00:05:02.131335','2025-03-16 18:03:18.664632','anonymousUser','dotuandat2004nd@gmail.com',0),
('df365c04-5060-4315-9222-7c2f007a44d3','$2a$10$7DKKUEB2Btn1RUeFXq3SnOJtsFiiMfKs1.BMjbaGwbFgjCcJHf0OG','Đỗ Tuấn Đạt','0944761755','dtdat@gmail.com',NULL,1,'2025-03-04 22:06:56.671096','2025-03-10 00:09:23.943658','anonymousUser','dotuandat2004nd@gmail.com',0),
('e2579cb8-b240-4405-a3ba-e52b55831a33','$2a$10$f3.dOcys9Hoz9/sTcpAGYebXGuEicUtWf500YDi4psSC2ovhhJCgi','Lục Văn Hải','0955996933','lvhai@gmail.com','1999-04-15',1,'2025-01-07 00:42:26.250821','2025-01-10 19:28:57.189776',NULL,'admin@gmail.com',0),
('ed35d4f7-3105-4473-9882-12ca5539d083','$2a$10$1YfFj6kR6cLmZfl5STHZNe3I/nCfivAwk.fdAEnWD0ddjb9tQZJCy','Serena','0222222222','serena@gmail.com','1999-01-01',1,'2025-01-07 00:42:26.250821','2025-01-11 12:01:49.066582',NULL,'dotuandat2004nd@gmail.com',0),
('ef72e64a-4ba2-41cf-8b49-5be97968f3ad','$2a$10$Mu5A0bjxAUnBm3K/UAXrXOrR91gV62lpsEtXPMxH.Qs11noSVA.U2','Nguyễn Công Phượng','0555555555','ncphuong@gmail.com','1997-04-15',1,'2025-01-08 23:13:49.893515','2025-01-12 23:28:43.315004','anonymousUser','admin@gmail.com',0),
('f8057ca0-5b23-466d-ac36-c85ef413e83b','$2a$10$TAmtn7V37Dt7ckPfu0pGWeGjO3LXXRlLbppOjpgEVjk.R.85jyVq.','John Doe','0131313131','johndoe123@gmail.com',NULL,0,'2025-01-07 00:42:26.250821','2025-01-10 20:02:12.655859',NULL,'dotuandat2004nd@gmail.com',0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_role` (
  `roleid` varchar(36) NOT NULL,
  `userid` varchar(36) NOT NULL,
  PRIMARY KEY (`roleid`,`userid`),
  KEY `userid` (`userid`),
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`roleid`) REFERENCES `role` (`id`),
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES ('5376954e-d221-40cb-afa4-35a196ac6769','024317a8-9e55-419d-bb9e-ed4cb104d020'),
('5376954e-d221-40cb-afa4-35a196ac6769','0a262bfd-d8c9-426f-a2f7-abaec3b0039c'),
('5376954e-d221-40cb-afa4-35a196ac6769','0e285053-f2fd-485d-9f2f-4ea8d6951d17'),
('5376954e-d221-40cb-afa4-35a196ac6769','16763e4f-8c7f-4d78-b90f-3f52ff0227b2'),
('5376954e-d221-40cb-afa4-35a196ac6769','17d14953-7765-4d41-a2a0-d278aab024ba'),
('5376954e-d221-40cb-afa4-35a196ac6769','17f6dcdd-dc2d-42f6-9361-34cc1e3b5c53'),
('844a29ca-5087-44dc-ab67-1b95628fcd4d','1e92be5e-320c-4606-854e-27bc0814b803'),
('5376954e-d221-40cb-afa4-35a196ac6769','1ffca06b-0ee6-45ff-8d52-dbdba8440c75'),
('5376954e-d221-40cb-afa4-35a196ac6769','20731af4-0523-4f77-8e17-f800af2bb718'),
('5376954e-d221-40cb-afa4-35a196ac6769','2172f496-dfaf-4450-9148-f3fecc0a40f8'),
('5376954e-d221-40cb-afa4-35a196ac6769','21aeec38-45d8-4a94-bb93-e57e12a8e226'),
('d05f2583-888c-4c8a-bea4-cb5b76154684','21aeec38-45d8-4a94-bb93-e57e12a8e226'),
('5376954e-d221-40cb-afa4-35a196ac6769','3625139c-5bcd-4cca-bbec-0d33d5005d2c'),
('d05f2583-888c-4c8a-bea4-cb5b76154684','3625139c-5bcd-4cca-bbec-0d33d5005d2c'),
('5376954e-d221-40cb-afa4-35a196ac6769','3c2ba82a-f421-406d-8e65-2546ff28298e'),
('b2251a4c-b2f5-48ee-add4-bbd55c543d75','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('5376954e-d221-40cb-afa4-35a196ac6769','5d337705-f5f9-47c4-9a0a-591be82ba00f'),
('5376954e-d221-40cb-afa4-35a196ac6769','5f169d55-675f-4825-99e4-fe902635ad6a'),
('5376954e-d221-40cb-afa4-35a196ac6769','637dab9b-00b7-436f-bc54-06fa3ecfd289'),
('5376954e-d221-40cb-afa4-35a196ac6769','65041e99-64d4-4f5a-9d8c-576719adec9d'),
('5376954e-d221-40cb-afa4-35a196ac6769','715e5eaf-60ac-4554-b00b-16f58ce23c3c'),
('5376954e-d221-40cb-afa4-35a196ac6769','7241e571-1d3a-47e8-b1d9-6dc8942b2f3e'),
('5376954e-d221-40cb-afa4-35a196ac6769','8491c9bb-e3a3-4436-abd8-c3d74216d422'),
('5376954e-d221-40cb-afa4-35a196ac6769','8b7d2186-6c43-4365-aab7-c957075b68f5'),
('844a29ca-5087-44dc-ab67-1b95628fcd4d','8b7d2186-6c43-4365-aab7-c957075b68f5'),
('5376954e-d221-40cb-afa4-35a196ac6769','8de76534-51ca-48e5-b776-6dffb98f3835'),
('5376954e-d221-40cb-afa4-35a196ac6769','93c1c628-da91-4834-a776-4e3c9d7220b6'),
('5376954e-d221-40cb-afa4-35a196ac6769','a6664967-a0da-4b31-b893-1b4241881672'),
('b2251a4c-b2f5-48ee-add4-bbd55c543d75','a7ddd32e-f737-4ff4-af59-18144fc9a432'),
('5376954e-d221-40cb-afa4-35a196ac6769','a83217e6-4591-4d14-b822-d7de6b728454'),
('5376954e-d221-40cb-afa4-35a196ac6769','a90533bf-ce4b-4187-8c5e-77046b70c03e'),
('5376954e-d221-40cb-afa4-35a196ac6769','afff85d7-53e8-40f9-9271-440bde54b151'),
('5376954e-d221-40cb-afa4-35a196ac6769','b3e71cdf-5efa-4d05-a164-23b46b60750d'),
('5376954e-d221-40cb-afa4-35a196ac6769','b4efe810-eec2-4fe0-93cf-85f38748aa16'),
('5376954e-d221-40cb-afa4-35a196ac6769','bc2b20c0-49d8-4f5a-83eb-600cb8086d92'),
('5376954e-d221-40cb-afa4-35a196ac6769','c2672bf7-d02f-4a99-aefd-6042bbfc374b'),
('5376954e-d221-40cb-afa4-35a196ac6769','c4f58d63-22e7-45c2-b99f-94471ba74dac'),
('5376954e-d221-40cb-afa4-35a196ac6769','c6182f9b-e889-43b0-b30e-2802c7ff73c9'),
('5376954e-d221-40cb-afa4-35a196ac6769','c68506d2-7c97-4f6e-b51a-826f467dbd4e'),
('5376954e-d221-40cb-afa4-35a196ac6769','ce43ca27-1e60-4713-affb-81d91fe04994'),
('5376954e-d221-40cb-afa4-35a196ac6769','cfdae048-449a-4e64-aabc-1422eb3c0f2b'),
('5376954e-d221-40cb-afa4-35a196ac6769','d0a11fcf-b08f-4116-86e7-ffc7e978246e'),
('5376954e-d221-40cb-afa4-35a196ac6769','d0abf087-be2a-4a40-b002-bfff337c026f'),
('4f213730-ede7-4709-ac08-ab849fc779de','d435d2b6-34f2-4226-85d4-1149f12c4761'),
('5376954e-d221-40cb-afa4-35a196ac6769','d435d2b6-34f2-4226-85d4-1149f12c4761'),
('5376954e-d221-40cb-afa4-35a196ac6769','dc4cb5e8-00b7-4c85-bed7-85a9e96de897'),
('5376954e-d221-40cb-afa4-35a196ac6769','dc73d495-715f-4795-97dd-bd05b73e9668'),
('5376954e-d221-40cb-afa4-35a196ac6769','dcecb39a-f6a8-4c92-b0d3-e42e6579bee3'),
('844a29ca-5087-44dc-ab67-1b95628fcd4d','dcecb39a-f6a8-4c92-b0d3-e42e6579bee3'),
('5376954e-d221-40cb-afa4-35a196ac6769','decd643b-2bce-411c-8b04-ffaf9681ac10'),
('5376954e-d221-40cb-afa4-35a196ac6769','df365c04-5060-4315-9222-7c2f007a44d3'),
('5376954e-d221-40cb-afa4-35a196ac6769','e2579cb8-b240-4405-a3ba-e52b55831a33'),
('5376954e-d221-40cb-afa4-35a196ac6769','ed35d4f7-3105-4473-9882-12ca5539d083'),
('5376954e-d221-40cb-afa4-35a196ac6769','ef72e64a-4ba2-41cf-8b49-5be97968f3ad'),
('5376954e-d221-40cb-afa4-35a196ac6769','f8057ca0-5b23-466d-ac36-c85ef413e83b');
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wish_list`
--

DROP TABLE IF EXISTS `wish_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wish_list` (
  `id` varchar(36) NOT NULL,
  `createdby` varchar(255) DEFAULT NULL,
  `createddate` datetime(6) DEFAULT NULL,
  `is_active` tinyint NOT NULL,
  `modifiedby` varchar(255) DEFAULT NULL,
  `modifieddate` datetime(6) DEFAULT NULL,
  `product_id` varchar(36) DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKqn4e0ta2823kynefeg4jektp0` (`product_id`),
  KEY `FKfa4fsowv3wmj4ssnvysy2v27i` (`user_id`),
  CONSTRAINT `FKfa4fsowv3wmj4ssnvysy2v27i` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKqn4e0ta2823kynefeg4jektp0` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wish_list`
--

LOCK TABLES `wish_list` WRITE;
/*!40000 ALTER TABLE `wish_list` DISABLE KEYS */;
INSERT INTO `wish_list` VALUES ('09aa8143-d111-4382-8f52-d018266bd79a','dotuandat2004nd@gmail.com','2025-04-04 16:27:57.622487',1,'dotuandat2004nd@gmail.com','2025-04-04 16:27:57.622487','9a0aae00-5dfa-4c86-8f85-4f62faeec6cf','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('185cb6d1-cef0-47b6-ac8e-75955be8771f','admin@gmail.com','2025-03-17 12:26:20.831844',1,'admin@gmail.com','2025-03-17 12:26:20.831844','e58f1305-8b66-449d-b56d-a4f8f207f9b3','a7ddd32e-f737-4ff4-af59-18144fc9a432'),
('1a312c78-3f42-439d-bea8-56da6f9b1d6d','xiaolingamingxg@gmail.com','2025-03-11 19:16:33.427196',1,'xiaolingamingxg@gmail.com','2025-03-11 19:16:33.427196','a16d1150-402d-45c4-8915-3e7e602511f6','dcecb39a-f6a8-4c92-b0d3-e42e6579bee3'),
('1f40ce51-f4e8-4d09-ae31-d06174120a81','admin@gmail.com','2025-03-17 12:25:54.562686',1,'admin@gmail.com','2025-03-17 12:25:54.562686','c3565ea0-8639-40c7-9547-7b87deb0bf45','a7ddd32e-f737-4ff4-af59-18144fc9a432'),
('1fdfa4d7-3de2-42b4-bca9-a5153b7ddde7','dotuandat2004nd@gmail.com','2025-04-04 16:27:50.949913',1,'dotuandat2004nd@gmail.com','2025-04-04 16:27:50.949913','af3a0e21-1a61-46a0-82b7-cf4697249c07','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('44282771-4b2b-4653-8c82-eb436f4c856b','xiaolingamingxg@gmail.com','2025-03-11 19:16:32.106403',1,'xiaolingamingxg@gmail.com','2025-03-11 19:16:32.106403','4b18aa0a-ce30-4ccd-8fe6-e4217b97df71','dcecb39a-f6a8-4c92-b0d3-e42e6579bee3'),
('6372e658-897a-4901-b71a-86b28326ad95','admin@gmail.com','2025-03-17 12:26:17.040451',1,'admin@gmail.com','2025-03-17 12:26:17.040451','f5d82150-08f6-4702-b247-46f59df508ac','a7ddd32e-f737-4ff4-af59-18144fc9a432'),
('6af37653-3a32-472b-8752-fb921035d299','admin@gmail.com','2025-03-17 12:25:56.700220',1,'admin@gmail.com','2025-03-17 12:25:56.700220','b461c187-71d2-4b95-853c-7312ae6d4950','a7ddd32e-f737-4ff4-af59-18144fc9a432'),
('6ba6beec-d769-4b8b-bc10-283d2f70b263','admin@gmail.com','2025-03-17 12:26:05.683273',1,'admin@gmail.com','2025-03-17 12:26:05.683273','93685a12-d900-41cd-8983-87cded6976b4','a7ddd32e-f737-4ff4-af59-18144fc9a432'),
('71d8c1b4-e7ad-47d3-9aee-a7c4c98c4259','admin@gmail.com','2025-03-10 22:44:14.095997',1,'admin@gmail.com','2025-03-10 22:44:14.095997','16f1cf00-9b54-49df-b0a8-9935877ecad9','a7ddd32e-f737-4ff4-af59-18144fc9a432'),
('a9d0691c-32c7-41d2-9a7d-7eaa3bbdf457','xiaolingamingxg@gmail.com','2025-03-11 19:16:34.343121',1,'xiaolingamingxg@gmail.com','2025-03-11 19:16:34.343121','be924284-9e15-4ecd-873a-ce466aeb702f','dcecb39a-f6a8-4c92-b0d3-e42e6579bee3'),
('b0ec33f8-7cae-4ef8-badc-3c61a4b084eb','admin@gmail.com','2025-03-17 12:25:59.269754',1,'admin@gmail.com','2025-03-17 12:25:59.269754','a04d8194-3c97-4d8b-8d6a-97263387563d','a7ddd32e-f737-4ff4-af59-18144fc9a432'),
('b5fdcd2d-155a-4ab3-b607-ec7dec29eeaf','admin@gmail.com','2025-03-17 12:26:00.323904',1,'admin@gmail.com','2025-03-17 12:26:00.323904','9ffe51ac-e54e-4990-a338-97d860eb2bd1','a7ddd32e-f737-4ff4-af59-18144fc9a432'),
('c6562f0d-2572-476f-a06d-37d8355f6176','dotuandat2004nd@gmail.com','2025-04-04 16:27:54.345702',1,'dotuandat2004nd@gmail.com','2025-04-04 16:27:54.345702','148f186c-acc4-4f5d-b802-80e2a1aed04c','58d37bb6-ce0c-4edc-bbf3-e9b7b6c4af02'),
('c65d7ee3-55c3-46f1-bcf1-a18fe463c85f','admin@gmail.com','2025-03-17 12:26:01.953587',1,'admin@gmail.com','2025-03-17 12:26:01.953587','8e93dd20-77cb-4e33-a8d4-9997a1e40acb','a7ddd32e-f737-4ff4-af59-18144fc9a432'),
('c9825008-475c-4a8e-a868-74592feeea6a','admin@gmail.com','2025-03-17 12:26:22.311259',1,'admin@gmail.com','2025-03-17 12:26:22.311259','d72bf2ed-c66c-4a9c-86a6-a42938765694','a7ddd32e-f737-4ff4-af59-18144fc9a432'),
('e4068d87-0db0-45f7-aa62-862c1342e8e0','admin@gmail.com','2025-03-10 22:44:12.134649',1,'admin@gmail.com','2025-03-10 22:44:12.134649','0e4353ac-d554-48cc-bee4-fa16af1552f7','a7ddd32e-f737-4ff4-af59-18144fc9a432'),
('e4b93836-cdb5-44ac-b51d-a1777e428aad','admin@gmail.com','2025-03-17 12:25:57.768382',1,'admin@gmail.com','2025-03-17 12:25:57.768382','b35565b0-c07f-4313-9fff-6c942c57dd00','a7ddd32e-f737-4ff4-af59-18144fc9a432'),
('ec5b2a0b-3109-4c2c-ad8e-f0fe475a0f56','admin@gmail.com','2025-03-11 10:49:33.403126',1,'admin@gmail.com','2025-03-11 10:49:33.403126','4f688179-ba15-4207-a3a9-bc00f5cb9b69','a7ddd32e-f737-4ff4-af59-18144fc9a432');
/*!40000 ALTER TABLE `wish_list` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-25 20:41:53