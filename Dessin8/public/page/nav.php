<?php
// Connexion à la base de données
$mysqli = new mysqli('localhost', 'tchup', '1234', 'concoursdessins', '3307');

// Vérification de la connexion
if ($mysqli->connect_error) {
    die("Échec de la connexion : " . $mysqli->connect_error);
}

// Démarrer la session si elle n'est pas déjà active
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// Vérifier si l'utilisateur est connecté
if (!isset($_SESSION['login'])) {
    header("Location: login.php");
    exit();
}

// Récupérer les rôles de l'utilisateur connecté
$login = $_SESSION['login']; // Assurez-vous que la session contient le login de l'utilisateur
$query = "
SELECT 
    u.login, 
    GROUP_CONCAT(r.role) AS roles
FROM 
    Utilisateur u
LEFT JOIN 
    (
        SELECT numPresident AS numUtilisateur, 'president' AS role FROM President
        UNION
        SELECT numDirecteur AS numUtilisateur, 'directeur' AS role FROM Directeur
        UNION
        SELECT numAdministrateur AS numUtilisateur, 'admin' AS role FROM Administrateur
        UNION
        SELECT numEvaluateur AS numUtilisateur, 'evaluateur' AS role FROM Evaluateur
        UNION
        SELECT numCompetiteur AS numUtilisateur, 'competiteur' AS role FROM Competiteur
    ) r ON u.numUtilisateur = r.numUtilisateur
WHERE u.login = ?
GROUP BY u.numUtilisateur
";

$stmt = $mysqli->prepare($query);
$stmt->bind_param("s", $login);
$stmt->execute();
$result = $stmt->get_result();
$user_roles = [];

if ($row = $result->fetch_assoc()) {
    $user_roles = explode(',', $row['roles']); // Liste des rôles
}

$stmt->close();
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu Utilisateur</title>
    <link rel="stylesheet" href="../../css/user_dashboard.css">
</head>
<body>

    <!-- Barre de navigation -->
    <nav class="navbar"> <!-- Ajoutez ici la classe navbar -->
        <ul class="navbar-list">
            <!-- Menu utilisateur (toujours visible) -->
            <li><a href="user_dashboard.php" class="active">Utilisateur</a></li>

            <!-- Menu Président (visible si l'utilisateur est président) -->
            <?php if (in_array('president', $user_roles)) : ?>
                <li><a href="pres_dashboard.php">Président</a></li>
            <?php endif; ?>

            <!-- Menu Directeur (visible si l'utilisateur est directeur) -->
            <?php if (in_array('directeur', $user_roles)) : ?>
                <li><a href="dir_dashboard.php">Directeur</a></li>
            <?php endif; ?>

            <!-- Menu Admin (visible si l'utilisateur est admin) -->
            <?php if (in_array('admin', $user_roles)) : ?>
                <li><a href="admin_dashboard.php">Admin</a></li>
            <?php endif; ?>

            <!-- Menu Evaluateur (visible si l'utilisateur est évaluateur) -->
            <?php if (in_array('evaluateur', $user_roles)) : ?>
                <li><a href="eval_dashboard.php">Evaluateur</a></li>
            <?php endif; ?>

            <!-- Menu Compétiteur (visible si l'utilisateur est compétiteur) -->
            <?php if (in_array('competiteur', $user_roles)) : ?>
                <li><a href="comp_dashboard.php">Competiteur</a></li>
            <?php endif; ?>

            <!-- Menu Paramètres -->
            <li><a href="param.php">Paramètres</a></li>

            <!-- Menu Déconnexion -->
            <li><a href="../co/logout.php">Déconnexion</a></li>
        </ul>
    </nav>

</body>
</html>
