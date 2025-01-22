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
$query_participation = "SELECT con.numConcours, con.theme, con.dateDebut, con.dateFin, con.etat
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
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-image: linear-gradient(to right, #4e73df, #1cc88a);
        }
    </style>
</head>
<body>
<?php include('nav.php'); ?>
    <div class="container">
        <h1>Bienvenue, <?php echo htmlspecialchars($login); ?> !</h1>

        <!-- Tableau pour afficher les concours -->
        <div class="table-container">
            <h3>Mes concours :</h3>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Thème</th>
                        <th>Date de début</th>
                        <th>Date de fin</th>
                        <th>État</th>
                    </tr>
                </thead>
                <tbody>
                    <?php if ($concours_result->num_rows > 0): ?>
                        <?php while ($row = $concours_result->fetch_assoc()): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($row['numConcours']); ?></td>
                                <td><?php echo htmlspecialchars($row['theme']); ?></td>
                                <td><?php echo htmlspecialchars($row['dateDebut']); ?></td>
                                <td><?php echo htmlspecialchars($row['dateFin']); ?></td>
                                <td><?php echo htmlspecialchars($row['etat']); ?></td>
                            </tr>
                        <?php endwhile; ?>
                    <?php else: ?>
                        <tr>
                            <td colspan="5">Aucun concours trouvé.</td>
                        </tr>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
						 
        <a href="../co/logout.php" class="logout">Se déconnecter</a>
    </div>
</body>
</html>
