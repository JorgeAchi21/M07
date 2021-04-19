/*
Creacion de la bbdd M701OPTICA
*/
/*creacion bbdd*/
CREATE DATABASE IF NOT EXISTS `M701Optica`
USE M701Optica

/* =================== Creacion tablas =================== */
CREATE TABLE `Proveedores` (
  `idProveedores` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `calle` varchar(50) NOT NULL,
  `numero` int DEFAULT NULL,
  `piso` varchar(5) DEFAULT NULL,
  `puerta` varchar(5) DEFAULT NULL,
  `ciudad` varchar(50) DEFAULT NULL,
  `codigo_postal` varchar(5) NOT NULL,
  `pais` varchar(50) NOT NULL,
  `telefono` varchar(9) NOT NULL,
  `fax` varchar(9) DEFAULT NULL,
  `nif` varchar(9) NOT NULL,
  PRIMARY KEY (`idProveedores`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Empleados` (
  `idEmpleados` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `cargo` varchar(50) NOT NULL,
  PRIMARY KEY (`idEmpleados`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Clientes` (
  `idClientes` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `direccion_postal` varchar(50) DEFAULT NULL,
  `telefono` varchar(9) NOT NULL,
  `correo_electronico` varchar(100) DEFAULT NULL,
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `cliente_recomendado` int unsigned DEFAULT NULL,
  PRIMARY KEY (`idClientes`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Gafas` (
  `idGafas` int unsigned NOT NULL AUTO_INCREMENT,
  `modelo` varchar(50) NOT NULL,
  `marca` varchar(50) NOT NULL,
  `graduacion_der` float NOT NULL,
  `graducacion_izq` float NOT NULL,
  `tipo_de_montura` enum('flotante','pasta','metalica') DEFAULT NULL,
  `color_de_la_montura` varchar(50) DEFAULT NULL,
  `color_vidrio_der` varchar(50) DEFAULT NULL,
  `color_vidrio_izq` varchar(50) DEFAULT NULL,
  `precio` float NOT NULL,
  `idProveedor` int unsigned DEFAULT NULL,
  `idEmpleado` int unsigned DEFAULT NULL,
  `idClientes` int unsigned DEFAULT NULL,
  PRIMARY KEY (`idGafas`),
  KEY `idx_empleados` (`idEmpleado`),
  KEY `idx_proveedores` (`idProveedor`),
  KEY `inx_clientes` (`idClientes`),
  CONSTRAINT `fk_clientes` FOREIGN KEY (`idClientes`) REFERENCES `Clientes` (`idClientes`),
  CONSTRAINT `fk_empleados` FOREIGN KEY (`idEmpleado`) REFERENCES `Empleados` (`idEmpleados`),
  CONSTRAINT `fk_proveedores` FOREIGN KEY (`idProveedor`) REFERENCES `Proveedores` (`idProveedores`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/* =================== Datos de pruebas=================== */
/* !!! insertar los datos en este orden para que no de error!!! */
INSERT INTO `Proveedores` VALUES 
(22,'Ray-Ban','Paseo de Gracia',12,'1','1','Barcelona','08014','España','931231231','931231231','12345678A'),
(23,'Oakley','Avd. Diagonal',13,'1','1','Barcelona','08015','España','931231232','931231232','12345678A'),
(24,'Carrera','Gran Via',14,'1','1','Barcelona','08016','España','931231233','931231233','12345678A'),
(25,'Arnette','Rbla Cataluña',15,'1','1','Barcelona','08017','España','931231234','931231234','12345678A'),
(26,'Police','Crta. Santas',16,'1','1','Barcelona','08018','España','931231235','931231235','12345678A');

INSERT INTO `Empleados` VALUES 
(30,'Antonio','Empleado'),
(31,'José ','Empleado'),
(32,'Francisco ','Empleado'),
(33,'David','Responsable'),
(34,'Javier','Empleado');

INSERT INTO `Clientes` VALUES 
(16,'María Carmen','C Granvia','931231231','correo1@correo.com','2019-12-31 22:00:00',NULL),
(17,'José Luis ','C Entenza','931231232','correo2@correo.com','2020-01-01 22:00:00',1),
(18,'Daniel','C Bailen','931231233','correo3@correo.com','2020-01-02 22:00:00',1),
(19,'Isabel','C Constitucion','931231234','correo4@correo.com','2020-01-03 22:00:00',2),
(20,'Javier','Las Ramblas','931231235','correo5@correo.com','2020-04-04 20:00:00',NULL);

INSERT INTO `Gafas` VALUES 
(26,'Modelo 1','Ray-Ban',1,0,'flotante','azul metalizado','azulado','azulado',150,22,30,16),
(27,'Modelo 2','Ray-Ban',0,1,'flotante','verde','sin color','sin color',110,22,30,17),
(28,'Modelo 1','Oakley',1,1.5,'pasta','pulimentado','espejado','espejado',200,23,31,18),
(29,'Modelo 2','Oakey',1,1.5,'pasta','pulido','sin color','sin color',100,23,31,19),
(30,'Modelo 25','Carrera',0,1.75,'metalica','titanio','espejado','espejado',250,24,32,20);

