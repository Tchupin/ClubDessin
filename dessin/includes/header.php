<?php
// Démarrer la session
session_start();
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mon Site</title>
    <!-- Inclure le fichier CSS pour le style (si nécessaire) -->
    <link rel="stylesheet" href="styles.css">
</head>
<body>

<!-- Barre de navigation -->
<nav>
    <ul>
        <li><a href="index.php">Accueil</a></li>
        
        <!-- Afficher la connexion ou déconnexion selon l'état de l'utilisateur -->
        <?php if (isset($_SESSION['loggedin']) && $_SESSION['loggedin'] === true): ?>
            <!-- L'utilisateur est connecté -->
            <li><a href="dashboard.php">Dashboard</a></li>
            <li><a href="logout.php">Se déconnecter</a></li>
        <?php else: ?>
            <!-- L'utilisateur n'est pas connecté -->
            <li><a href="login.php">Connexion</a></li>
        <?php endif; ?>
    </ul>
</nav>

<!-- Contenu de la page (le reste de votre code HTML ici) -->

</body>
</html>
