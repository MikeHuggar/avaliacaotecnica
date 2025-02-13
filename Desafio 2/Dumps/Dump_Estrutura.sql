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
-- Table structure for table `depto`
--

DROP TABLE IF EXISTS depto;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE depto (
  coddepto int NOT NULL,
  nomedepto varchar(50) NOT NULL,
  PRIMARY KEY (coddepto)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `disciplina`
--

DROP TABLE IF EXISTS disciplina;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE disciplina (
  numdisc int NOT NULL,
  nomedisc varchar(50) NOT NULL,
  creditosdisc varchar(100) DEFAULT NULL,
  coddepto int NOT NULL,
  PRIMARY KEY (numdisc,coddepto),
  KEY coddepto (coddepto),
  CONSTRAINT disciplina_ibfk_1 FOREIGN KEY (coddepto) REFERENCES depto (coddepto)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `horario`
--

DROP TABLE IF EXISTS horario;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE horario (
  diasem varchar(7) NOT NULL,
  horainicio varchar(5) NOT NULL,
  coddepto int NOT NULL,
  numdisc int NOT NULL,
  anosem varchar(10) NOT NULL,
  siglatur varchar(5) NOT NULL,
  codpredio int DEFAULT NULL,
  numsala int DEFAULT NULL,
  numhoras int NOT NULL,
  PRIMARY KEY (diasem,horainicio,coddepto,numdisc,anosem,siglatur),
  KEY coddepto (coddepto,numdisc,anosem,siglatur),
  KEY codpredio (codpredio,numsala),
  CONSTRAINT horario_ibfk_1 FOREIGN KEY (coddepto, numdisc, anosem, siglatur) REFERENCES turma (coddepto, numdisc, anosem, siglatur),
  CONSTRAINT horario_ibfk_2 FOREIGN KEY (codpredio, numsala) REFERENCES sala (codpredio, numsala)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `predio`
--

DROP TABLE IF EXISTS predio;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE predio (
  codpredio int NOT NULL,
  descricaopredio varchar(50) NOT NULL,
  PRIMARY KEY (codpredio),
  UNIQUE KEY codpredio (codpredio)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prereq`
--

DROP TABLE IF EXISTS prereq;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE prereq (
  coddeptoprereq int NOT NULL,
  numdiscprereq int NOT NULL,
  coddepto int NOT NULL,
  numdisc int NOT NULL,
  PRIMARY KEY (coddeptoprereq,numdiscprereq,coddepto,numdisc),
  KEY coddepto (coddepto),
  KEY numdisc (numdisc),
  CONSTRAINT prereq_ibfk_1 FOREIGN KEY (coddepto) REFERENCES disciplina (coddepto),
  CONSTRAINT prereq_ibfk_2 FOREIGN KEY (numdisc) REFERENCES disciplina (numdisc)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `professor`
--

DROP TABLE IF EXISTS professor;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE professor (
  codprof int NOT NULL,
  coddepto int DEFAULT NULL,
  codtit int DEFAULT NULL,
  nomeprof varchar(50) DEFAULT NULL,
  PRIMARY KEY (codprof),
  KEY coddepto (coddepto),
  KEY codtit (codtit),
  CONSTRAINT professor_ibfk_1 FOREIGN KEY (coddepto) REFERENCES depto (coddepto),
  CONSTRAINT professor_ibfk_2 FOREIGN KEY (codtit) REFERENCES titulacao (codtit)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `profturma`
--

DROP TABLE IF EXISTS profturma;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE profturma (
  coddepto int NOT NULL,
  numdisc int NOT NULL,
  anosem varchar(10) NOT NULL,
  siglatur varchar(5) NOT NULL,
  codprof int NOT NULL,
  PRIMARY KEY (coddepto,numdisc,anosem,siglatur,codprof),
  KEY codprof (codprof),
  CONSTRAINT profturma_ibfk_1 FOREIGN KEY (codprof) REFERENCES professor (codprof),
  CONSTRAINT profturma_ibfk_2 FOREIGN KEY (coddepto, numdisc, anosem, siglatur) REFERENCES turma (coddepto, numdisc, anosem, siglatur)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sala`
--

DROP TABLE IF EXISTS sala;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE sala (
  numsala int NOT NULL,
  descricaosala varchar(50) DEFAULT NULL,
  capacidade int NOT NULL,
  codpredio int NOT NULL,
  PRIMARY KEY (numsala,codpredio),
  UNIQUE KEY numsala_UNIQUE (numsala),
  KEY codpredio (codpredio),
  CONSTRAINT sala_ibfk_1 FOREIGN KEY (codpredio) REFERENCES predio (codpredio)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `titulacao`
--

DROP TABLE IF EXISTS titulacao;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE titulacao (
  codtit int NOT NULL,
  nometit varchar(50) DEFAULT NULL,
  PRIMARY KEY (codtit)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `turma`
--

DROP TABLE IF EXISTS turma;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE turma (
  coddepto int NOT NULL,
  numdisc int NOT NULL,
  anosem varchar(10) NOT NULL,
  siglatur varchar(5) NOT NULL,
  capacidade int DEFAULT NULL,
  PRIMARY KEY (anosem,siglatur,coddepto,numdisc),
  KEY coddepto (coddepto,numdisc),
  CONSTRAINT turma_ibfk_1 FOREIGN KEY (coddepto, numdisc) REFERENCES disciplina (coddepto, numdisc)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-12 16:39:58
