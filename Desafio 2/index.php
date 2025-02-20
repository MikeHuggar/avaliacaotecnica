<?php
    include("db.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Desafio 2</title>
</head>
<body>
    <h1>Horas comprometidas:</h1>
    <?php
        //Since we may have a teacher with no hours/department, we use left joins
        $queryHours = "SELECT IFNULL(SUM(horario.numhoras), 0) AS total, professor.nomeprof FROM professor
                        LEFT JOIN profturma ON professor.codprof = profturma.codprof AND professor.coddepto = profturma.coddepto
                        LEFT JOIN turma ON profturma.coddepto = turma.coddepto AND profturma.numdisc = turma.numdisc AND profturma.anosem = turma.anosem AND profturma.siglatur = turma.siglatur
                        LEFT JOIN horario ON turma.coddepto = horario.coddepto AND turma.numdisc = horario.numdisc AND turma.anosem = horario.anosem AND turma.siglatur = horario.siglatur
                        GROUP BY professor.nomeprof ORDER BY total DESC";

        $resultHours = mysqli_query($connection, $queryHours);
        while($row = mysqli_fetch_assoc($resultHours)){
            echo "Horas comprometidas de " . $row['nomeprof'] . ": " . $row['total'] . "<br>";
        }
    ?>
    <h1>Listas de Salas:</h1>
    <?php
        /* We have to GROUP BY the classroom's number since a classroom can be used for
        various topics, which would give us duplicates. */
        $queryRooms = "SELECT horario.numsala FROM sala
                        INNER JOIN horario ON sala.codpredio = horario.codpredio AND sala.numsala = horario.numsala
                        WHERE horario.numhoras > 0 GROUP BY horario.numsala";
        $resultRooms = mysqli_query($connection, $queryRooms);
        echo "<h2>Salas ocupadas:</h2>";
        while($row = mysqli_fetch_assoc($resultRooms)){
            echo "Sala " . $row['numsala'] . "<br>";
        }
        //Since we're looking for rooms that don't have any topics assigned to them, we use a LEFT JOIN.
        $queryRooms = "SELECT sala.numsala FROM sala
                        LEFT JOIN horario ON sala.codpredio = horario.codpredio AND sala.numsala = horario.numsala
                        WHERE horario.numhoras IS NULL OR horario.numhoras = 0";
        $resultRooms = mysqli_query($connection, $queryRooms);
        echo "<h2>Salas livres:</h2>";
        while($row = mysqli_fetch_assoc($resultRooms)){
            echo "Sala " . $row['numsala'] . "<br>";
        }
    ?>
</body>
</html>