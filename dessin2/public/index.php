<?php
// Inclusion du fichier de connexion à la base de données
include_once('../includes/db_connect.php');

// Démarrer la session
session_start();

// Vérification si le formulaire est soumis
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $login = $_POST['login'] ?? '';
    $motdepasse = $_POST['motdepasse'] ?? '';

    // Vérifier si les champs sont remplis
    if (empty($login) || empty($motdepasse)) {
        echo "Veuillez remplir tous les champs.";
        exit;
    }

    // Préparer la requête SQL
    $query = "SELECT numUtilisateur, login, motdepasse, numClub FROM Utilisateur WHERE login = ?";
    $stmt = $mysqli->prepare($query);

    if (!$stmt) {
        echo "Erreur dans la préparation de la requête : " . $mysqli->error;
        exit;
    }

    $stmt->bind_param("s", $login);
    $stmt->execute();
    $result = $stmt->get_result();

    // Vérifier si un utilisateur est trouvé
    if ($result->num_rows === 1) {
        $user = $result->fetch_assoc();

        // Vérifier le mot de passe (comparaison en clair)
        if ($motdepasse === $user['motdepasse']) {
            // Stocker les informations utilisateur dans la session
            $_SESSION['loggedin'] = true;
            $_SESSION['numUtilisateur'] = $user['numUtilisateur'];
            $_SESSION['login'] = $user['login'];
            $_SESSION['numClub'] = $user['numClub'];

            // Rediriger selon le rôle de l'utilisateur
            if ($user['numClub'] === null) { // Administrateur ou utilisateur sans club
                header("Location: admin_dashboard.php");
            } else { // Utilisateur lié à un club
                header("Location: club_dashboard.php");
            }
            exit;
        } else {
            echo "Mot de passe incorrect.";
        }
    } else {
        echo "Aucun utilisateur trouvé avec ce login.";
    }

    $stmt->close();
}

// Fermer la connexion
$mysqli->close();
?>

<!-- Formulaire HTML -->
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion</title>
</head>
<body>
    <h1>Connexion</h1>
    <form method="POST" action="login.php">
        <label for="login">Login :</label>
        <input type="text" id="login" name="login" required>

        <label for="motdepasse">Mot de passe :</label>
        <input type="password" id="motdepasse" name="motdepasse" required>

        <button type="submit">Se connecter</button>
    </form>
</body>
</html>
