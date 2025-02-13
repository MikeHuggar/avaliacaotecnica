<?php
    $db_server="localhost:3307";
    $db_user="root";
    $db_pass="";
    $db_name="escolagirafales";

    $connection="";

    try {
        $connection = mysqli_connect($db_server, $db_user, $db_pass, $db_name);
    } catch(mysqli_sql_exception) {
        echo "Erro ao conectar ao DB {$db_name} <br>";
    }
    

    /* if($connection){
        echo "Conectado ao DB {$db_name} <br>";
    } */
?>