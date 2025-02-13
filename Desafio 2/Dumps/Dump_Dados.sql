-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: escolagirafales
-- ------------------------------------------------------
-- Server version	8.0.41

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

--
-- Dumping data for table `depto`
--

LOCK TABLES depto WRITE;
/*!40000 ALTER TABLE depto DISABLE KEYS */;
INSERT INTO depto VALUES (1,'Departamento de Humanas'),(2,'Departamento de Ciências da Natureza'),(3,'Departamento de Linguagens'),(4,'Departamento de Matemática');
/*!40000 ALTER TABLE depto ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `disciplina`
--

LOCK TABLES disciplina WRITE;
/*!40000 ALTER TABLE disciplina DISABLE KEYS */;
INSERT INTO disciplina VALUES (1,'Português 1','Gramática e Sintaxe',3),(2,'Português e Literatura','Interpretação de Texto e Gêneros Textuais',3),(3,'Matemática 1','Adição, Subtração, Multiplicação e Divisão',4),(4,'Matemática 2','Álgebra, Geometria e Trigonometria',4),(5,'Línguas Estrangeiras','Inglês e Espanhol',3);
/*!40000 ALTER TABLE disciplina ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `horario`
--

LOCK TABLES horario WRITE;
/*!40000 ALTER TABLE horario DISABLE KEYS */;
INSERT INTO horario VALUES ('Quarta','14:00',4,3,'2025-02','4C',71,13,200),('Quinta','13:00',4,4,'2025-01','4C',71,12,180),('Quinta','18:00',4,4,'2025-01','4C',71,NULL,180),('Segunda','08:30',3,1,'2025-01','4C',71,12,200),('Terça','12:00',3,2,'2025-02','4C',71,13,230),('Terça','15:30',3,5,'2025-02','4C',71,13,220);
/*!40000 ALTER TABLE horario ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `predio`
--

LOCK TABLES predio WRITE;
/*!40000 ALTER TABLE predio DISABLE KEYS */;
INSERT INTO predio VALUES (8,'Pavilhão de Fabricação'),(14,'Pavilhão de TI'),(71,'Pavilhão Principal'),(72,'Pavilhão de Automação');
/*!40000 ALTER TABLE predio ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `prereq`
--

LOCK TABLES prereq WRITE;
/*!40000 ALTER TABLE prereq DISABLE KEYS */;
INSERT INTO prereq VALUES (3,1,3,2),(4,3,4,4);
/*!40000 ALTER TABLE prereq ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `professor`
--

LOCK TABLES professor WRITE;
/*!40000 ALTER TABLE professor DISABLE KEYS */;
INSERT INTO professor VALUES (1,3,5,'Professor Girafales'),(2,4,4,'Seu Madruga'),(3,NULL,NULL,'Dona Florinda');
/*!40000 ALTER TABLE professor ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `profturma`
--

LOCK TABLES profturma WRITE;
/*!40000 ALTER TABLE profturma DISABLE KEYS */;
INSERT INTO profturma VALUES (3,1,'2025-01','4C',1),(3,2,'2025-02','4C',1),(3,5,'2025-02','4C',1),(4,3,'2025-02','4C',2),(4,4,'2025-01','4C',2);
/*!40000 ALTER TABLE profturma ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sala`
--

LOCK TABLES sala WRITE;
/*!40000 ALTER TABLE sala DISABLE KEYS */;
INSERT INTO sala VALUES (4,'Laboratório 1',30,8),(6,'Laboratório 2',20,14),(7,'Laboratório 6',26,8),(9,'Laboratório 7',23,8),(12,'Sala de Aula 01',28,71),(13,'Sala de Aula 02',25,71),(14,'Sala de Aula 03',30,71);
/*!40000 ALTER TABLE sala ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `titulacao`
--

LOCK TABLES titulacao WRITE;
/*!40000 ALTER TABLE titulacao DISABLE KEYS */;
INSERT INTO titulacao VALUES (1,'Graduação'),(2,'Especialização'),(3,'Pós-Graduação'),(4,'Mestrado'),(5,'Doutorado');
/*!40000 ALTER TABLE titulacao ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `turma`
--

LOCK TABLES turma WRITE;
/*!40000 ALTER TABLE turma DISABLE KEYS */;
INSERT INTO turma VALUES (3,1,'2025-01','4C',28),(4,4,'2025-01','4C',30),(3,2,'2025-02','4C',28),(3,5,'2025-02','4C',30),(4,3,'2025-02','4C',30);
/*!40000 ALTER TABLE turma ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-12 16:43:24
