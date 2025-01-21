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

// Récupérer tous les clubs pour le sélecteur
$query_clubs = "SELECT * FROM Club";
$stmt_clubs = $mysqli->prepare($query_clubs);
$stmt_clubs->execute();
$clubs_result = $stmt_clubs->get_result();

// Vérifier si un tableau est sélectionné
$table = isset($_POST['table']) ? $_POST['table'] : '';

// Requête par défaut pour afficher les tables
if ($table == 'Mon club') {

    $query_table = " SELECT numClub as ID, nomClub, adresse, numTelephone, nombreAdherents, ville, departement, region 
        FROM Club
        WHERE numClub = (SELECT numClub 
                        FROM Utilisateur 
                        WHERE numUtilisateur = ?)"
        ;

    $stmt_table = $mysqli->prepare($query_table);
    $stmt_table->bind_param('i', $numUtilisateur);
    $stmt_table->execute();
    $table_result = $stmt_table->get_result();    

} elseif ($table == 'membres') {

    $query_table = " SELECT numUtilisateur as ID, nom, prenom, adresse
        FROM Utilisateur 
        WHERE numClub = (SELECT numClub 
                        FROM Utilisateur 
                        WHERE numUtilisateur = ?)"
        ;

    $stmt_table = $mysqli->prepare($query_table);
    $stmt_table->bind_param('i', $numUtilisateur);
    $stmt_table->execute();
    $table_result = $stmt_table->get_result();

} elseif ($table == 'Concours du clubs') {

    $query_table = "SELECT numConcours as ID, theme, dateDebut, dateFin, etat FROM Concours
        WHERE numConcours IN (SELECT numConcours FROM ClubParticipe 
        WHERE numClub = (SELECT numClub FROM Utilisateur 
        WHERE numUtilisateur = ?))
    ";
    
    $stmt_table = $mysqli->prepare($query_table);
    $stmt_table->bind_param('i', $numUtilisateur);
    $stmt_table->execute();
    $table_result = $stmt_table->get_result();

} else {
    $table_result = null;  // Par défaut, pas de table sélectionnée
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Club</title>
    <link rel="stylesheet" href="../../css/user_dashboard.css">
</head>
<body>
<?php include('nav.php'); ?>
    <div class="container">
        <h1>Bienvenue, <?php echo htmlspecialchars($login); ?> !</h1>
        <!-- Sélecteur de table -->
        <div class="select-club">
            <h3>Choisir une table à afficher :</h3>
            <form action="dir_dashboard.php" method="POST">
                <select name="table" id="table">
                    <option value="">-- Sélectionner --</option>
                    <option value="Mon club" <?php echo ($table == 'Mon club') ? 'selected' : ''; ?>>Mon club</option>
                    <option value="membres" <?php echo ($table == 'membres') ? 'selected' : ''; ?>>Membres</option>
                    <option value="Concours du clubs" <?php echo ($table == 'Concours du clubs') ? 'selected' : ''; ?>>Concours du clubs</option>
                </select>
                <button type="submit">Afficher</button>
            </form>
        </div>

        <!-- Affichage des données selon la table choisie -->
        <?php if ($table_result): ?>
            <div class="table-data">
                <h2>Données de la table : <?php echo ucfirst($table); ?></h2>
                <table>
                    <thead>
                        <tr>
                            <?php 
                            // Affichage dynamique des en-têtes selon la table
                            $columns = $table_result->fetch_fields();
                            foreach ($columns as $column) {
                                echo "<th>" . htmlspecialchars($column->name) . "</th>";
                            }
                            ?>
                        </tr>
                    </thead>
                    <tbody>
                        <?php while ($row = $table_result->fetch_assoc()): ?>
                            <tr>
                                <?php foreach ($row as $data): ?>
                                    <td><?php echo htmlspecialchars($data); ?></td>
                                <?php endforeach; ?>
                            </tr>
                        <?php endwhile; ?>
                    </tbody>
                </table>
            </div>
        <?php endif; ?>

        <a href="../co/logout.php" class="logout">Se déconnecter</a>
    </div>

    <!-- Bouton Retour en haut -->
    <button id="scrollToTopBtn">Retour en haut</button>

    <script>
        // Affichage du bouton de retour en haut en fonction du défilement
        window.onscroll = function() {
            let button = document.getElementById('scrollToTopBtn');
            if (document.body.scrollTop > 200 || document.documentElement.scrollTop > 200) {
                button.style.display = "block";
            } else {
                button.style.display = "none";
            }
        };

        // Lorsque l'utilisateur clique sur le bouton, on revient en haut de la page
        document.getElementById('scrollToTopBtn').onclick = function() {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        };
    </script>
</body>
</html>

<?php
// Fermer la connexion à la base de données
$mysqli->close();
?>
