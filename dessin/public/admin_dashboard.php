<?php
// Démarrer la session
session_start();

// Inclusion du fichier de connexion à la base de données
require_once('../includes/db_connect.php');

// Vérifier si l'utilisateur est connecté et administrateur
if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    header('Location: login.php');
    exit;
}

// Vérifier si l'utilisateur est administrateur
if (!isset($_SESSION['numUtilisateur'])) {
    header('Location: login.php');
    exit;
}

$numUtilisateur = $_SESSION['numUtilisateur'];

// Requête pour vérifier si l'utilisateur est administrateur
$query = "SELECT * FROM Administrateur WHERE numAdministrateur = ?";
$stmt = $mysqli->prepare($query);
$stmt->bind_param("i", $numUtilisateur);
$stmt->execute();
$result = $stmt->get_result();

// Vérifier si l'utilisateur est un administrateur
if ($result->num_rows === 0) {
    echo "Vous n'êtes pas autorisé à accéder à cette page.";
    exit;
}

?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Dashboard Admin</title>
</head>
<body>
    <h1>Bienvenue, Administrateur</h1>

    <h2>Liste des utilisateurs :</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Login</th>
            <th>Club</th>
            <th>Action</th>
        </tr>

        <?php
        // Requête pour obtenir tous les utilisateurs
        $query = "SELECT * FROM Utilisateur";
        $stmt = $mysqli->prepare($query);
        $stmt->execute();
        $result = $stmt->get_result();

        while ($user = $result->fetch_assoc()) {
            echo "<tr>";
            echo "<td>" . $user['numUtilisateur'] . "</td>";
            echo "<td>" . $user['nom'] . " " . $user['prenom'] . "</td>";
            echo "<td>" . $user['login'] . "</td>";

            // Afficher le club associé
            $clubQuery = "SELECT nomClub FROM Club WHERE numClub = ?";
            $clubStmt = $mysqli->prepare($clubQuery);
            $clubStmt->bind_param("i", $user['numClub']);
            $clubStmt->execute();
            $clubResult = $clubStmt->get_result();
            $club = $clubResult->fetch_assoc();
            echo "<td>" . ($club ? $club['nomClub'] : "Aucun club") . "</td>";

            // Ajouter une action (par exemple, modifier ou supprimer un utilisateur)
            echo "<td><a href='edit_user.php?id=" . $user['numUtilisateur'] . "'>Modifier</a> | <a href='delete_user.php?id=" . $user['numUtilisateur'] . "'>Supprimer</a></td>";
            echo "</tr>";
        }
        ?>
    </table>

    <h2>Liste des clubs :</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Adresse</th>
            <th>Description</th>
        </tr>

        <?php
        // Requête pour obtenir tous les clubs
        $query = "SELECT * FROM Club";
        $stmt = $mysqli->prepare($query);
        $stmt->execute();
        $result = $stmt->get_result();

        while ($club = $result->fetch_assoc()) {
            echo "<tr>";
            echo "<td>" . $club['numClub'] . "</td>";
            echo "<td>" . $club['nomClub'] . "</td>";
            echo "<td>" . $club['adresse'] . "</td>";
            echo "<td>" . $club['description'] . "</td>";
            echo "</tr>";
        }
        ?>
    </table>

    <a href="logout.php">Se déconnecter</a>
</body>
</html>

<?php
// Fermer la connexion à la base de données
$mysqli->close();
?>
