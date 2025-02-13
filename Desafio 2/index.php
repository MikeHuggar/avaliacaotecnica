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
        //Queries the entire professor table.
        $queryProf = "SELECT * FROM professor";
        $resultProf = mysqli_query($connection, $queryProf);

        //For each professor, we query their work hours.
        while($row = mysqli_fetch_assoc($resultProf)){
            //Through INNER JOINs, we can get the SUM of each professor's work hours, assuming they have any.
            //INNER JOIN on basically every PRIMARY KEY to make sure we get what we're looking for.
            $queryHours = "SELECT SUM(horario.numhoras) FROM professor
                            INNER JOIN profturma ON professor.codprof = profturma.codprof AND professor.coddepto = profturma.coddepto
                            INNER JOIN turma ON profturma.coddepto = turma.coddepto AND profturma.numdisc = turma.numdisc AND profturma.anosem = turma.anosem AND profturma.siglatur = turma.siglatur
                            INNER JOIN horario ON turma.coddepto = horario.coddepto AND turma.numdisc = horario.numdisc AND turma.anosem = horario.anosem AND turma.siglatur = horario.siglatur
                            WHERE professor.codprof = ".$row['codprof'];

            $resultHours = mysqli_query($connection, $queryHours);
            $sumHours = mysqli_fetch_assoc($resultHours);
            if($sumHours['SUM(horario.numhoras)'] == null){
                //Turns NULL values into 0 for the purpose of actually displaying something.
                $sumHours['SUM(horario.numhoras)'] = 0;
            }
            echo "Horas comprometidas de " . $row['nomeprof'] . ": " . $sumHours['SUM(horario.numhoras)'];
            echo "<br>";

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