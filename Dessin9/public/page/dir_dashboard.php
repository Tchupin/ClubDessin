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

// Requête pour afficher les données en fonction de la table sélectionnée
if ($table == 'Mon club') {
    $query_table = "SELECT numClub as ID, nomClub, adresse, numTelephone, nombreAdherents, ville, departement, region 
                    FROM Club
                    WHERE numClub = (SELECT numClub FROM Utilisateur WHERE numUtilisateur = ?)";
    $stmt_table = $mysqli->prepare($query_table);
    $stmt_table->bind_param('i', $numUtilisateur);
    $stmt_table->execute();
    $table_result = $stmt_table->get_result();
} elseif ($table == 'membres') {
    $query_table = "SELECT numUtilisateur as ID, nom, prenom, adresse
                    FROM Utilisateur 
                    WHERE numClub = (SELECT numClub FROM Utilisateur WHERE numUtilisateur = ?)";
    $stmt_table = $mysqli->prepare($query_table);
    $stmt_table->bind_param('i', $numUtilisateur);
    $stmt_table->execute();
    $table_result = $stmt_table->get_result();
} elseif ($table == 'Concours du clubs') {
    $query_table = "SELECT numConcours as ID, theme, dateDebut, dateFin, etat 
                    FROM Concours
                    WHERE numConcours IN (
                        SELECT numConcours 
                        FROM ClubParticipe 
                        WHERE numClub = (SELECT numClub FROM Utilisateur WHERE numUtilisateur = ?)
                    )";
    $stmt_table = $mysqli->prepare($query_table);
    $stmt_table->bind_param('i', $numUtilisateur);
    $stmt_table->execute();
    $table_result = $stmt_table->get_result();
} else {
    $table_result = null; // Pas de table sélectionnée
}

// Gestion de l'attribution d'un concours au club
if (isset($_POST['attribuer_concours']) && isset($_POST['concours'])) {
    $numConcours = $_POST['concours'];
    $query_attribuer = "INSERT INTO ClubParticipe (numClub, numConcours) 
                        VALUES (
                            (SELECT numClub FROM Utilisateur WHERE numUtilisateur = ?), 
                            ?
                        )";
    $stmt_attribuer = $mysqli->prepare($query_attribuer);
    $stmt_attribuer->bind_param('ii', $numUtilisateur, $numConcours);

    if ($stmt_attribuer->execute()) {
        $message = "Concours attribué avec succès au club !";
    } else {
        $message = "Erreur lors de l'attribution : " . $mysqli->error;
    }
}

// Récupérer tous les concours non attribués au club du directeur
$query_concours_disponibles = "
    SELECT numConcours, theme 
    FROM Concours
    WHERE numConcours NOT IN (
        SELECT numConcours 
        FROM ClubParticipe 
        WHERE numClub = (SELECT numClub FROM Utilisateur WHERE numUtilisateur = ?)
    )";
$stmt_concours_disponibles = $mysqli->prepare($query_concours_disponibles);
$stmt_concours_disponibles->bind_param('i', $numUtilisateur);
$stmt_concours_disponibles->execute();
$concours_disponibles = $stmt_concours_disponibles->get_result();
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

        <!-- Formulaire pour attribuer un concours au club -->
        <div class="assign-concours">
            <h3>Attribuer un concours au club :</h3>
            <?php if ($concours_disponibles->num_rows > 0): ?>
                <form action="dir_dashboard.php" method="POST">
                    <label for="concours">Concours disponibles :</label>
                    <select name="concours" id="concours" required>
                        <?php while ($concours = $concours_disponibles->fetch_assoc()): ?>
                            <option value="<?php echo $concours['numConcours']; ?>">
                                <?php echo htmlspecialchars($concours['theme']); ?>
                            </option>
                        <?php endwhile; ?>
                    </select>
                    <button type="submit" name="attribuer_concours">Attribuer</button>
                </form>
            <?php else: ?>
                <p>Aucun concours disponible à attribuer.</p>
            <?php endif; ?>
        </div>

        <!-- Affichage des messages -->
        <?php if (isset($message)): ?>
            <div class="message">
                <?php echo htmlspecialchars($message); ?>
            </div>
        <?php endif; ?>

        <a href="../co/logout.php" class="logout">Se déconnecter</a>
    </div>
</body>
</html>

<?php
// Fermer la connexion à la base de données
$mysqli->close();
?>
