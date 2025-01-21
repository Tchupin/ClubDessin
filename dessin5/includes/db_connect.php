<?php
// Connexion à la base de données
$mysqli = new mysqli('localhost', 'tchup', '1234', 'concoursdessins','3307');
if ($mysqli->connect_error) {
    die("Connexion échouée: " . $mysqli->connect_error);
}
?>
