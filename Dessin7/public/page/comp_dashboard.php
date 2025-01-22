<?php
// Démarrer la session
session_start();

// Inclusion du fichier de connexion à la base de données
require_once('../../includes/db_connect.php');

// Vérifier si l'utilisateur est connecté
if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    header('Location: ../co/login.php');
    exit;
}

// Récupérer les informations utilisateur
$numUtilisateur = $_SESSION['numUtilisateur'];
$login = $_SESSION['login'];

// Récupérer les concours auxquels l'utilisateur participe
$query_participation = "SELECT con.numConcours, con.theme 
                        FROM Concours con
                        JOIN CompetiteurParticipe p ON con.numConcours = p.numConcours
                        WHERE p.numCompetiteur = ?";
$stmt_participation = $mysqli->prepare($query_participation);
$stmt_participation->bind_param("i", $numUtilisateur);
$stmt_participation->execute();
$concours_result = $stmt_participation->get_result();

// Récupérer tous les clubs pour le sélecteur
$query_clubs = "SELECT * FROM Club";
$stmt_clubs = $mysqli->prepare($query_clubs);
$stmt_clubs->execute();
$clubs_result = $stmt_clubs->get_result();

// Vérifier si un tableau est sélectionné
$concoursSelected = isset($_POST['concours']) ? $_POST['concours'] : '';
$etatConcours = isset($_POST['etatConcours']) ? $_POST['etatConcours'] : ''; // Nouveau filtre par état

// Si aucun concours n'est sélectionné, ne pas exécuter la requête pour afficher les concours
if ($concoursSelected != '') {
    $query_table = "SELECT numConcours, theme, dateDebut, dateFin, etat 
                    FROM Concours WHERE numConcours = ?";
    if ($etatConcours != '') {
        $query_table .= " AND etat = ?";
    }
    
    $stmt_table = $mysqli->prepare($query_table);
    if ($etatConcours != '') {
        $stmt_table->bind_param("is", $concoursSelected, $etatConcours); // Bind à deux paramètres
    } else {
        $stmt_table->bind_param("i", $concoursSelected); // Bind à un seul paramètre
    }
    
    $stmt_table->execute();
    $table_result = $stmt_table->get_result();
} else {
    // Si aucun concours n'est sélectionné, ne rien afficher
    $table_result = null;
}

?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Club</title>
    <link rel="stylesheet" href="../../css/user_dashboard.css">
    <style>
        body {
            background-image: linear-gradient(to right, #4e73df, #1cc88a);
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
    </style>
</head>
<body>
<?php include('nav.php'); ?>
    <div class="container">
        <h1>Bienvenue, <?php echo htmlspecialchars($login); ?> !</h1>
        
        <!-- Sélecteurs pour filtrer les concours -->
        <div class="select-filters">
            <h3>Filtrer les concours :</h3>
            
            <!-- Premier sélecteur pour choisir un concours -->
            <form action="comp_dashboard.php" method="POST" class="filter-form">
                <select name="concours" id="concours">
                    <option value="">-- Sélectionner un concours --</option>
                    <?php while ($row = $concours_result->fetch_assoc()): ?>
                        <option value="<?php echo $row['numConcours']; ?>" <?php echo ($concoursSelected == $row['numConcours']) ? 'selected' : ''; ?>>
                            <?php echo htmlspecialchars($row['theme']); ?>
                        </option>
                    <?php endwhile; ?>
                </select>
                
                <!-- Deuxième sélecteur pour filtrer par état -->
                <select name="etatConcours" id="etatConcours">
                    <option value="">-- Sélectionner l'état --</option>
                    <option value="en_cours" <?php echo ($etatConcours == 'en_cours') ? 'selected' : ''; ?>>En cours</option>
                    <option value="termine" <?php echo ($etatConcours == 'termine') ? 'selected' : ''; ?>>Terminé</option>
                    <option value="annule" <?php echo ($etatConcours == 'annule') ? 'selected' : ''; ?>>Annulé</option>
                </select>
                
                <button type="submit">Filtrer</button>
