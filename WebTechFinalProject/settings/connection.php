<?php

$SERVER = "localhost";
$USERNAME = "root";
$PASSWORD = "";
$DATABASE = "asbedDatabase";

$con = new mysqli($SERVER, $USERNAME, $PASSWORD, $DATABASE) or die ("could not connect to database");

if ($con->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} else {
    echo "Connected successfully";
} 
?>