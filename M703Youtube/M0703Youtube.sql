/*
Creacion de la bbdd YOUTUBE
*/
/*creacion bbdd*/
CREATE DATABASE IF NOT EXISTS `M703Youtube_`
USE M703Youtube_

/* =================== Creacion tablas =================== */
CREATE TABLE `Usuarios` (
  `idUsuarios` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `nombre_usuario` varchar(50) NOT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `sexo` set('hombre','mujer') DEFAULT NULL,
  `pais` varchar(50) DEFAULT NULL,
  `cp` varchar(10) DEFAULT NULL COMMENT 'Zip code',
  PRIMARY KEY (`idUsuarios`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Videos` (
  `idVideos` int unsigned NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `tamaño` int DEFAULT NULL COMMENT 'en Kb',
  `nombre_archivo` varchar(50) DEFAULT NULL,
  `duracion` int DEFAULT NULL COMMENT 'duracion del video en minutos.',
  `miniatura` varchar(100) DEFAULT NULL,
  `num_reproducciones` int unsigned DEFAULT NULL,
  `likes` int unsigned DEFAULT NULL,
  `dislikes` int unsigned DEFAULT NULL,
  `estado` set('publico','oculto','privado') DEFAULT NULL,
  `idEtiquetas` int DEFAULT NULL,
  `idUsuarios` varchar(45) DEFAULT NULL,
  `FechaHoraPublicacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idVideos`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `Etiquetas` (
  `idEtiquetas` int unsigned NOT NULL AUTO_INCREMENT,
  `idVideos` int unsigned DEFAULT NULL,
  `textoEtiqueta` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idEtiquetas`),
  KEY `inx_idVideos` (`idVideos`),
  CONSTRAINT `fk_Eti_idVideos` FOREIGN KEY (`idVideos`) REFERENCES `Videos` (`idVideos`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `Publicacion_videos` (
  `idPublicacion_videos` int unsigned NOT NULL AUTO_INCREMENT,
  `idUsuario` int unsigned DEFAULT NULL,
  `idVideo` int unsigned DEFAULT NULL,
  `fechaHora` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPublicacion_videos`),
  KEY `inx_idUsuario` (`idUsuario`),
  KEY `inx_idVideo` (`idVideo`),
  CONSTRAINT `fk_idUsuarios` FOREIGN KEY (`idUsuario`) REFERENCES `Usuarios` (`idUsuarios`),
  CONSTRAINT `fk_idVideos` FOREIGN KEY (`idVideo`) REFERENCES `Videos` (`idVideos`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Canales` (
  `idCanales` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` varchar(50) DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `idUsuario_Creacion` int unsigned DEFAULT NULL,
  PRIMARY KEY (`idCanales`),
  KEY `inx_idUsuario` (`idUsuario_Creacion`),
  CONSTRAINT `fk_idUsuario` FOREIGN KEY (`idUsuario_Creacion`) REFERENCES `Usuarios` (`idUsuarios`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Likes` (
  `idLikes` int unsigned NOT NULL AUTO_INCREMENT,
  `idVideos` int unsigned DEFAULT NULL,
  `tipo` set('like','dislike') DEFAULT NULL,
  `idUsuario` int unsigned DEFAULT NULL,
  `idVideo` int unsigned DEFAULT NULL,
  `fechahora_like` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idLikes`),
  KEY `inx_idVideos` (`idVideos`) /*!80000 INVISIBLE */,
  CONSTRAINT `fk_Lik_idVideos` FOREIGN KEY (`idVideos`) REFERENCES `Videos` (`idVideos`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/* Playlist videos (se crea primero ya que tiene relacion) */
CREATE TABLE `Playlist_videos` (
  `idPlayListVideos` int unsigned NOT NULL AUTO_INCREMENT,
  `idPlayList` int unsigned DEFAULT NULL,
  `idVideos` int unsigned DEFAULT NULL,
  PRIMARY KEY (`idPlayListVideos`),
  KEY `idPlaylist` (`idPlayList`) /*!80000 INVISIBLE */,
  KEY `idVideos` (`idVideos`) /*!80000 INVISIBLE */,
  CONSTRAINT `fk_PlayVid_idVideos` FOREIGN KEY (`idVideos`) REFERENCES `Videos` (`idVideos`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Playlists` (
  `idPlaylists` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `estado` set('publica','privada') DEFAULT NULL COMMENT 'publica o privada',
  `idPlayVid` int unsigned NOT NULL,
  PRIMARY KEY (`idPlaylists`),
  KEY `inx_idPlayVid` (`idPlayVid`) /*!80000 INVISIBLE */,
  CONSTRAINT `fk_idPlayVid` FOREIGN KEY (`idPlayVid`) REFERENCES `Playlist_videos` (`idPlayListVideos`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Comentarios` (
  `idComentarios` int unsigned NOT NULL AUTO_INCREMENT,
  `idVideos` int unsigned NOT NULL,
  `comentario` varchar(100) DEFAULT NULL,
  `fechaHora_comentario` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idComentarios`),
  KEY `inx_idVideo2` (`idVideos`),
  CONSTRAINT `fk_idVideos2` FOREIGN KEY (`idVideos`) REFERENCES `Videos` (`idVideos`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ComentariosLikes` (
  `idComentariosLikes` int unsigned NOT NULL AUTO_INCREMENT,
  `idComentario` int unsigned DEFAULT NULL,
  `idUsuario` int unsigned DEFAULT NULL,
  `tipo` set('like','dislike') DEFAULT NULL COMMENT 'like o dislike',
  `fechaHora_ComentarioLike` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idComentariosLikes`),
  KEY `inx_idUsuario` (`idUsuario`),
  KEY `inx_idComentario` (`idComentario`),
  CONSTRAINT `fk_idComentario` FOREIGN KEY (`idComentario`) REFERENCES `Comentarios` (`idComentarios`),
  CONSTRAINT `fk_idUsuario3` FOREIGN KEY (`idUsuario`) REFERENCES `Usuarios` (`idUsuarios`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/* =================== Datos de pruebas=================== */
/* usuarios */ 
INSERT INTO `Usuarios` VALUES 
(1,'Jose','jose@gmail.com','1234','jose1234','1970-01-01','hombre','España','08001'),
(2,'Maria','maraia@gmail.com','1234','maria1234','1970-01-02','mujer','España','08002'),
(3,'Antonio','antonio@gmail.com','1234','antonio1234','1970-01-03','hombre','España','08003'),
(4,'Raquel','raquel@gmail.com','1234','raquel1234','1970-01-04','mujer','España','08004'),
(5,'Juan','juan@gmail.com','1234','juan1234','1970-01-05','hombre','España','08005');

/* videos */ 
INSERT INTO `Videos` VALUES 
(1,'gatito','gatito simpatico',1,'gatito.mp4',2,'/vid/mini/miniGatito.jpg',1,1,1,'publico',NULL,NULL,'2021-04-13 13:54:46'),
(2,'perrito','perrito simpatico',2,'perrito.mp4',2,'/vid/mini/miniPerrito.jpg',1,1,1,'oculto',NULL,NULL,'2021-04-13 13:55:57'),
(3,'caballito','potro simpatico',1,'caballito.mp4',2,'/vid/mini/miniCaballo.jpg',1,1,1,'privado',NULL,NULL,'2021-04-13 14:01:37'),
(4,'peces','peces de colores',1,'peces.mp4',2,'/vid/mini/miniPeces.jpg',1,1,1,'publico',NULL,NULL,'2021-04-13 14:02:51'),
(5,'pajaritos','pajaros cantando',1,'pajaros.mp4',2,'/vid/mini/miniPajaros.jpg',1,1,1,'oculto',NULL,NULL,'2021-04-13 14:03:50'),
(6,'paisajes','paisajes de montaña',1,'rios.mp4',2,'/vid/mini/rios.jpg',1,1,1,'oculto',NULL,NULL,'2021-04-14 14:03:50');

/* etiquetas */
INSERT INTO `Etiquetas` VALUES 
(1, 1, 'me gusta'),
(2, 2, 'no me gusta'),
(3, 3,'es muy largo'),
(4, 4,'es muy tonto'),
(5, 5,'es raro'),
(6, 6,'la tematica no me gusta');

/* publicacion videos */
INSERT INTO `Publicacion_videos` VALUES 
(1,1,1,'2021-04-13 14:21:14'),
(2,1,2,'2021-04-13 14:21:39'),
(3,1,3,'2021-04-13 14:21:39'),
(4,2,4,'2021-04-13 14:21:39'),
(5,2,5,'2021-04-13 14:21:39');

/* Canales */
INSERT INTO `Canales` VALUES (1,'Canal info','info general','2021-01-01',1),
(2,'Canal el tiempo','meteorologia','2021-01-02',1),
(3,'Canal de viajes','viajes','2021-01-03',1),
(4,'Canal de aficiones','aficiones','2021-01-04',2),
(5,'Canal de politica','polictica','2021-01-05',2);

INSERT INTO `Likes` VALUES 
(1, 1, 'like',1,1,'2021-04-13 14:37:06'),
(2, 2, 'dislike',1,2,'2021-04-13 14:37:06'),
(3, 3, 'like',2,1,'2021-04-13 14:37:06'),
(4, 4, 'dislike',2,2,'2021-04-13 14:37:06'),
(5, 5, 'like',2,3,'2021-04-13 14:37:06'),
(6, 6, 'dislike',3,1,'2021-04-13 14:37:06');

INSERT INTO `Playlist_videos` VALUES 
(1,1,1),
(2,1,2),
(3,2,3),
(4,2,4),
(5,3,5);

INSERT INTO `Playlists` VALUES 
(1,'mi playlist 1','2021-01-01','publica',1),
(2,'mi playlist 2','2021-01-02','publica',1),
(3,'mi playlist 3','2021-01-03','publica',2);

INSERT INTO `Comentarios` VALUES 
(1,1,'muy bueno, me ha gustado','2021-04-13 14:50:34'),
(2,2,'no me gusta nada.','2021-04-13 14:50:34'),
(3,3,'esta bien, pero cansa.','2021-04-13 14:51:21'),
(4,4,'este tema no me gusta','2021-04-13 14:51:21'),
(5,5,'me encanta el motivo del vido','2021-04-13 14:51:21');

INSERT INTO `ComentariosLikes` VALUES 
(1,1,1,'like','2021-04-13 14:54:19'),
(2,2,2,'dislike','2021-04-13 14:57:14'),
(3,3,1,'like','2021-04-13 14:57:14'),
(4,4,1,'dislike','2021-04-13 14:57:14'),
(5,5,3,'dislike','2021-04-13 14:57:14');