/*
Creacion de la bbdd SPOTIFY
*/
/*creacion bbdd*/
CREATE DATABASE IF NOT EXISTS `M704Spotify`
USE M704Spotify

/* =================== Creacion tablas =================== */
CREATE TABLE `Usuarios` (
  `idUsuarios` int unsigned NOT NULL AUTO_INCREMENT,
  `tipo` set('free','premium') DEFAULT NULL COMMENT 'tipo: free o premium',
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `nombre_usuario` varchar(50) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `sexo` set('hombre','mujer') DEFAULT NULL COMMENT 'sexo: hombre / mujer',
  `pais` varchar(50) DEFAULT NULL,
  `cp` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`idUsuarios`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Suscripciones` (
  `idSuscripciones` int unsigned NOT NULL AUTO_INCREMENT,
  `idUsuario` int unsigned DEFAULT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_renovacion` date NOT NULL,
  `forma_de_pago` set('tarjeta','paypal') NOT NULL COMMENT 'Tarjeta o PayPal',
  PRIMARY KEY (`idSuscripciones`),
  KEY `inx_idUsuario` (`idUsuario`),
  CONSTRAINT `fk_Sus_idUsuarios` FOREIGN KEY (`idUsuario`) REFERENCES `Usuarios` (`idUsuarios`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Tarjetas_Credito` (
  `idTarjetasCredito` int unsigned NOT NULL AUTO_INCREMENT,
  `idUsuario` int unsigned DEFAULT NULL,
  `numero_tarjeta` varchar(19) DEFAULT NULL,
  `año_caducidad` year DEFAULT NULL,
  `mes_caducidad` int DEFAULT NULL,
  `codigo_seguridad` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idTarjetasCredito`),
  KEY `inx_idUsuario` (`idUsuario`),
  CONSTRAINT `fk_TarjCre_idUsuarios` FOREIGN KEY (`idUsuario`) REFERENCES `Usuarios` (`idUsuarios`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Pagos_Paypal` (
  `idPagosPaypal` int unsigned NOT NULL AUTO_INCREMENT,
  `idUsuarios` int unsigned DEFAULT NULL,
  `nombreUsuarioPaypal` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idPagosPaypal`),
  KEY `inx_idUsuarios` (`idUsuarios`),
  CONSTRAINT `fk_PagPay_idUsuarios` FOREIGN KEY (`idUsuarios`) REFERENCES `Usuarios` (`idUsuarios`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Pagos_Usuarios_Premium` (
  `idPagos` int unsigned NOT NULL AUTO_INCREMENT,
  `idUsuario` int unsigned DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `num_orden` int DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`idPagos`),
  UNIQUE KEY `num_orden_UNIQUE` (`num_orden`) /*!80000 INVISIBLE */,
  KEY `inx_idUsuario` (`idUsuario`),
  CONSTRAINT `fk_PagUsuPrem_idUsuario` FOREIGN KEY (`idUsuario`) REFERENCES `Usuarios` (`idUsuarios`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Playlists` (
  `idPlaylists` int unsigned NOT NULL AUTO_INCREMENT,
  `idUsuario` int unsigned DEFAULT NULL,
  `titulo` varchar(50) NOT NULL,
  `numero_canciones` int DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `estado` set('activa','eliminada') DEFAULT NULL,
  `fechaEliminada` date DEFAULT NULL,
  PRIMARY KEY (`idPlaylists`),
  KEY `inx_idusuario` (`idUsuario`),
  CONSTRAINT `fk_Play_idUsuarios` FOREIGN KEY (`idUsuario`) REFERENCES `Usuarios` (`idUsuarios`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Artistas` (
  `idArtistas` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `imagen_url` varchar(50) DEFAULT NULL,
  `idArtistas_seguimiento` int unsigned DEFAULT NULL,
  PRIMARY KEY (`idArtistas`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Albumes` (
  `idAlbumes` int unsigned NOT NULL AUTO_INCREMENT,
  `titulo` varchar(50) DEFAULT NULL,
  `idArtista` int unsigned DEFAULT NULL,
  `año_publicacion` year DEFAULT NULL,
  `imagen_url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idAlbumes`),
  KEY `inx_idArtistas` (`idArtista`),
  CONSTRAINT `fk_Albu_idArtista` FOREIGN KEY (`idArtista`) REFERENCES `Artistas` (`idArtistas`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Canciones` (
  `idCanciones` int unsigned NOT NULL AUTO_INCREMENT,
  `titulo` varchar(50) DEFAULT NULL,
  `duracion` int unsigned DEFAULT NULL COMMENT 'duracion en minutos.',
  `numero_reproducciones` int unsigned DEFAULT NULL,
  `idAlbumes` int unsigned DEFAULT NULL,
  PRIMARY KEY (`idCanciones`),
  KEY `fk_Can_idAlbumes_idx` (`idAlbumes`),
  CONSTRAINT `fk_Can_idAlbumes` FOREIGN KEY (`idAlbumes`) REFERENCES `Albumes` (`idAlbumes`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Playlists_Detalle` (
  `idPlaylistsDetalle` int unsigned NOT NULL AUTO_INCREMENT,
  `idPlaylist` int unsigned DEFAULT NULL,
  `idCancion` int unsigned DEFAULT NULL,
  `idUsuario` int unsigned DEFAULT NULL,
  `fecha_añadida` date DEFAULT NULL,
  PRIMARY KEY (`idPlaylistsDetalle`),
  KEY `inx_idPlaylist` (`idPlaylist`),
  KEY `inx_idCancion` (`idCancion`),
  KEY `inx_idUsuario` (`idUsuario`) /*!80000 INVISIBLE */,
  CONSTRAINT `fk_PlayDet_idCancion` FOREIGN KEY (`idCancion`) REFERENCES `Canciones` (`idCanciones`),
  CONSTRAINT `fk_PlayDet_idPlaylist` FOREIGN KEY (`idPlaylist`) REFERENCES `Playlists` (`idPlaylists`),
  CONSTRAINT `fk_PlayDet_idUsuario` FOREIGN KEY (`idUsuario`) REFERENCES `Usuarios` (`idUsuarios`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Usuarios_Seguimientos_Artistas` (
  `idSeguimientos` int unsigned NOT NULL AUTO_INCREMENT,
  `idUsuario` int unsigned DEFAULT NULL,
  `idArtista` int unsigned DEFAULT NULL,
  PRIMARY KEY (`idSeguimientos`),
  KEY `inx_idUsuarios` (`idUsuario`) /*!80000 INVISIBLE */,
  KEY `inx_idArtistas` (`idArtista`),
  CONSTRAINT `fk_UsuSegu_idArtistas` FOREIGN KEY (`idArtista`) REFERENCES `Artistas` (`idArtistas`),
  CONSTRAINT `fk_UsuSegu_idUsuarios` FOREIGN KEY (`idUsuario`) REFERENCES `Usuarios` (`idUsuarios`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Artistas_Relacionados` (
  `idArtistasRelacionados` int unsigned NOT NULL AUTO_INCREMENT,
  `artista` int unsigned DEFAULT NULL,
  `artista_relacionado` int unsigned DEFAULT NULL,
  PRIMARY KEY (`idArtistasRelacionados`),
  KEY `inx_idArtistas` (`artista`) /*!80000 INVISIBLE */,
  KEY `inx_idArtistas1` (`artista_relacionado`),
  CONSTRAINT `fk_ArtRel_idArtistaPrin` FOREIGN KEY (`artista`) REFERENCES `Artistas` (`idArtistas`),
  CONSTRAINT `fk_ArtRel_idArtistaRel` FOREIGN KEY (`artista_relacionado`) REFERENCES `Artistas` (`idArtistas`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Usuarios_AlbumesFav` (
  `idFavoritosAlbumes` int unsigned NOT NULL AUTO_INCREMENT,
  `idUsuario` int unsigned DEFAULT NULL,
  `idAlbumes` int unsigned DEFAULT NULL,
  PRIMARY KEY (`idFavoritosAlbumes`),
  KEY `inx_idUsuario` (`idUsuario`) /*!80000 INVISIBLE */,
  KEY `inx_idAlbumes` (`idAlbumes`) /*!80000 INVISIBLE */,
  CONSTRAINT `fk_UsuAlbF_idAlbum` FOREIGN KEY (`idAlbumes`) REFERENCES `Albumes` (`idAlbumes`),
  CONSTRAINT `fk_UsuAlbF_idUsuarios` FOREIGN KEY (`idUsuario`) REFERENCES `Usuarios` (`idUsuarios`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Usuarios_CancionesFav` (
  `idFavoritos` int unsigned NOT NULL AUTO_INCREMENT,
  `idUsuario` int unsigned DEFAULT NULL,
  `idCancion` int unsigned DEFAULT NULL,
  PRIMARY KEY (`idFavoritos`),
  KEY `inx_idUsuarios` (`idUsuario`),
  KEY `inx_idCanciones` (`idCancion`),
  CONSTRAINT `fk_UsuCancF_idCanciones` FOREIGN KEY (`idCancion`) REFERENCES `Canciones` (`idCanciones`),
  CONSTRAINT `fk_UsuCancF_idUsuarios` FOREIGN KEY (`idUsuario`) REFERENCES `Usuarios` (`idUsuarios`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/* =================== Datos de pruebas=================== */
INSERT INTO `Usuarios` VALUES (1,'free','jose@gmail.com','1234','Jose','1980-01-01','hombre','España','08001'),
(2,'free','carlos@gmail.com','1234','Carlos','1980-01-02','hombre','España','08002'),
(3,'premium','maria@gmail.com','1234','Maria','1980-01-03','mujer','España','08003'),
(4,'premium','antonio@gmail.com','1234','Antonio','1980-01-04','hombre','España','08004'),
(5,'premium','marisol@gmail.com','1234','Mari Sol','1980-01-05','mujer','España','08005'),
(6,'premium','javier@gmail.com','1234','Javier','1980-01-06','hombre','España','08014'),
(7,'free','fernando@gmail.com','1234','Fernando','1980-01-17','hombre','España','08015');

INSERT INTO `Suscripciones` VALUES 
(1,3,'2019-01-01','2021-06-01','tarjeta'), 
(2,4,'2019-01-02','2021-06-02','paypal'),
(3,5,'2019-01-03','2021-06-03','tarjeta'),
(4,6,'2019-01-04','2021-06-04','paypal');

INSERT INTO `Tarjetas_Credito` VALUES
(1,1,'1234567890',2022,5,'1234'),
(2,2,'1234567890',2022,6,'1234'),
(3,3,'1234567890',2022,7,'1234'),
(4,4,'1234567890',2022,8,'1234'),
(5,5,'1234567890',2022,9,'1234');

INSERT INTO `Pagos_Paypal` VALUES 
(1,3,'paypalUsu6'),
(2,4,'paypalUsu7'),
(3,5,'paypalUsu8'),
(4,6,'paypalUsu9');

INSERT INTO `Pagos_Usuarios_Premium` VALUES 
(1,3,'2021-01-01',1,20.00),
(2,4,'2021-01-02',2,24.00),
(3,5,'2021-01-03',3,23.00),
(4,6,'2021-01-04',4,16.00);

INSERT INTO `Playlists` VALUES 
(1,1,'clasica',3,'2021-01-01','activa',NULL),
(2,2,'rock',3,'2021-01-02','activa',NULL),
(5,3,'bandas sonoras',4,'2021-01-03','activa',NULL),
(6,4,'instrumental',4,'2021-01-03','eliminada','2021-02-01'),
(7,5,'disco',4,'2021-01-04','activa',NULL);

INSERT INTO `Artistas` VALUES 
(1,'Michael Jackosn','/img/michael.jpg',NULL),
(2,'Madonna','/img/madonna.jpg',NULL),
(3,'Britney Spears','/img/britney.jpg',NULL),
(4,'Whitney Houston','/img/whitney.jpg',NULL),
(5,'BackStreet boys','/img/backstreet.jpg',NULL);

INSERT INTO `Albumes` VALUES 
(1,'Thriller',1,1995,'/img/thriller.jpg'),
(2,'Like a prayer',2,1989,'/img/likeaprayer.jpg'),
(3,'baby one more time',3,1999,'/img/baby.jpg'),
(4,'Whitney Houston',4,1987,'/img/whitney.jpg'),
(5,'BackStreet\'s back',5,1997,'/img/bacstreet.jpg');

INSERT INTO `Canciones` VALUES 
(1,'Thriller',8,100,1),
(2,'Like a prayer',5,101,2),
(3,'Baby one more time',4,102,3),
(4,'I wanna dance with somebody',6,103,4),
(5,'Everybody',4,104,5),
(6,'Beat it',4,60,1),
(7,'Express yourself',5,88,2);

INSERT INTO `Playlists_Detalle` VALUES 
(2,1,1,1,'2021-02-01'),
(3,1,2,1,'2021-02-02'),
(4,1,3,1,'2021-02-03'),
(5,1,4,1,'2021-02-04'),
(6,1,5,1,'2021-02-05'),
(7,2,1,2,'2021-02-01'),
(8,2,2,2,'2021-02-02');

INSERT INTO `Usuarios_Seguimientos_Artistas` 
VALUES (1,1,2),
(2,1,3),
(3,1,4),
(4,1,5);

INSERT INTO `Artistas_Relacionados` VALUES 
(1,1,2),
(2,1,3),
(3,2,4),
(4,2,5);

INSERT INTO `Usuarios_AlbumesFav` VALUES 
(1,1,1),
(2,2,2),
(3,3,3),
(4,4,4),
(5,5,5);

INSERT INTO `Usuarios_CancionesFav` VALUES 
(1,1,1),
(2,2,2),
(3,3,3),
(4,4,4),
(5,5,5);
