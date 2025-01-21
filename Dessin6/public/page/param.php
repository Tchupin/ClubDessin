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

// Récupérer les informations de l'utilisateur
$login = $_SESSION['login']; // Assurez-vous que la session contient le login de l'utilisateur
$query = "SELECT * FROM Utilisateur WHERE login = ?";
$stmt = $mysqli->prepare($query);
$stmt->bind_param("s", $login);
$stmt->execute();
$result = $stmt->get_result();
$user = $result->fetch_assoc();
$stmt->close();

// Traitement de la mise à jour des informations du profil
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Récupérer les nouvelles informations
    $new_nom = $_POST['nom'];
    $new_prenom = $_POST['prenom'];
    $new_adresse = $_POST['adresse'];
    $new_age = $_POST['age'];
    $new_login = $_POST['login'];
    $new_motdepasse = $_POST['motdepasse'];
    
    // Si un mot de passe est fourni, le mettre à jour
    if (!empty($new_motdepasse)) {
        $new_motdepasse = password_hash($new_motdepasse, PASSWORD_DEFAULT); // Hashage du mot de passe
        $update_query = "UPDATE Utilisateur SET nom = ?, prenom = ?, adresse = ?, age = ?, login = ?, motdepasse = ? WHERE login = ?";
        $stmt = $mysqli->prepare($update_query);
        $stmt->bind_param("sssssss", $new_nom, $new_prenom, $new_adresse, $new_age, $new_login, $new_motdepasse, $login);
    } else {
        $update_query = "UPDATE Utilisateur SET nom = ?, prenom = ?, adresse = ?, age = ?, login = ? WHERE login = ?";
        $stmt = $mysqli->prepare($update_query);
        $stmt->bind_param("ssssss", $new_nom, $new_prenom, $new_adresse, $new_age, $new_login, $login);
    }
    $stmt->execute();
    $stmt->close();
    
    // Rediriger après la mise à jour
    header("Location: param.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Paramètres du Profil</title>
    <link rel="stylesheet" href="../../css/user_dashboard.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            height: 100vh;
            overflow-x: hidden;
        }

        /* Barre de navigation */
        .navbar-list {
            list-style-type: none;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            background-color: #333;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 10px 0;
        }

        .navbar-list li {
            margin: 0 15px;
        }

        .navbar-list li a {
            color: white;
            text-decoration: none;
            padding: 14px 20px;
            font-size: 1.1em;
            display: block;
        }

        .navbar-list li a:hover {
            background-color: #575757;
            border-radius: 4px;
        }

        body {
            padding-top: 60px; /* Ajuste cette valeur selon la hauteur de la barre de navigation */
        }

        /* Formulaire de mise à jour du profil */
        .container {
            width: 80%;
            max-width: 1000px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 40px;
            box-sizing: border-box;
            margin-top: 80px;
            max-height: 90vh;
            overflow-y: auto;
        }

        h2 {
            color: #333;
        }

        .container div {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-size: 1em;
            color: #333;
            margin-bottom: 5px;
        }

        input {
            width: 100%;
            padding: 10px;
            font-size: 1em;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        button {
            padding: 10px 20px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <!-- Inclusion de la barre de navigation -->
    <?php include 'nav.php'; ?>

    <!-- Formulaire de mise à jour du profil -->
    <div class="container">
        <h2>Modifier les informations de votre profil</h2>
        
        <form method="POST">
            <!-- Nom -->
            <div>
                <label for="nom">Nom :</label>
                <input type="text" id="nom" name="nom" value="<?= htmlspecialchars($user['nom']) ?>" required>
            </div>

            <!-- Prénom -->
            <div>
                <label for="prenom">Prénom :</label>
                <input type="text" id="prenom" name="prenom" value="<?= htmlspecialchars($user['prenom']) ?>" required>
            </div>

            <!-- Adresse -->
            <div>
                <label for="adresse">Adresse :</label>
                <input type="text" id="adresse" name="adresse" value="<?= htmlspecialchars($user['adresse']) ?>" required>
            </div>

            <!-- Âge -->
            <div>
                <label for="age">Âge :</label>
                <input type="number" id="age" name="age" value="<?= htmlspecialchars($user['age']) ?>" required>
            </div>

            <!-- Login -->
            <div>
                <label for="login">Login :</label>
                <input type="text" id="login" name="login" value="<?= htmlspecialchars($user['login']) ?>" required>
            </div>

            <!-- Mot de passe -->
            <div>
                <label for="motdepasse">Nouveau mot de passe :</label>
                <input type="password" id="motdepasse" name="motdepasse" placeholder="Laissez vide si vous ne voulez pas changer le mot de passe">
            </div>

            <!-- Soumettre le formulaire -->
            <div>
                <button type="submit">Mettre à jour</button>
            </div>
        </form>
    </div>

</body>
</html>
