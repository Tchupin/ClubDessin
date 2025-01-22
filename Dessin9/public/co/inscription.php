<?php
// Inclusion du fichier de connexion
include_once('../../includes/db_connect.php');

// Démarrer la session
session_start();

// Vérification si le formulaire est soumis
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $nom = $_POST['nom'] ?? '';
    $prenom = $_POST['prenom'] ?? '';
    $adresse = $_POST['adresse'] ?? '';
    $age = $_POST['age'] ?? '';
    $login = $_POST['login'] ?? '';
    $motdepasse = $_POST['motdepasse'] ?? '';
    $motdepasse_confirm = $_POST['motdepasse_confirm'] ?? '';
    $numClub = $_POST['numClub'] ?? '';

    // Vérifier si tous les champs sont remplis
    if (empty($nom) || empty($prenom) || empty($adresse) || empty($age) || empty($login) || empty($motdepasse) || empty($motdepasse_confirm) || empty($numClub)) {
        $error_message = "Veuillez remplir tous les champs.";
    } elseif ($motdepasse !== $motdepasse_confirm) {
        $error_message = "Les mots de passe ne correspondent pas.";
    } else {
        // Vérifier la disponibilité du login
        $query = "SELECT numUtilisateur FROM Utilisateur WHERE login = ?";
        $stmt = $mysqli->prepare($query);
        $stmt->bind_param("s", $login);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $error_message = "Ce login est déjà utilisé.";
        } else {
            // Insérer les données dans la table Utilisateur
            $query = "INSERT INTO Utilisateur (nom, prenom, adresse, age, login, motdepasse, numClub) VALUES (?, ?, ?, ?, ?, ?, ?)";
            $stmt = $mysqli->prepare($query);
            $stmt->bind_param("sssiisi", $nom, $prenom, $adresse, $age, $login, $motdepasse, $numClub);
            $stmt->execute();

            // Rediriger l'utilisateur vers la page de connexion
            header("Location: login.php");
            exit;
        }
        $stmt->close();
    }

    // Fermer la connexion
    $mysqli->close();
}
?>

<!-- Formulaire HTML d'inscription -->
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../../css/login.css">
</head>
<body>
    <div class="login-container">
        <div class="logo-container">
           <!-- <img src="https://via.placeholder.com/100" alt="Logo"> -->
        </div>
        <h1>Inscription</h1>

        <?php if (!empty($error_message)): ?>
            <div class="error-message"><?php echo $error_message; ?></div>
        <?php endif; ?>

        <!-- Formulaire d'inscription -->
        <form method="POST" action="inscription.php">
            <div class="input-group">
                <label for="nom">Nom :</label>
                <input type="text" id="nom" name="nom" required>
            </div>

            <div class="input-group">
                <label for="prenom">Prénom :</label>
                <input type="text" id="prenom" name="prenom" required>
            </div>

            <div class="input-group">
                <label for="adresse">Adresse :</label>
                <input type="text" id="adresse" name="adresse" required>
            </div>

            <div class="input-group">
                <label for="age">Âge :</label>
                <input type="number" id="age" name="age" required>
            </div>

            <div class="input-group">
                <label for="login">Login :</label>
                <input type="text" id="login" name="login" required>
            </div>

            <div class="input-group">
                <label for="motdepasse">Mot de passe :</label>
                <input type="password" id="motdepasse" name="motdepasse" required>
            </div>

            <div class="input-group">
                <label for="motdepasse_confirm">Confirmer le mot de passe :</label>
                <input type="password" id="motdepasse_confirm" name="motdepasse_confirm" required>
            </div>

            <div class="input-group">
                <label for="numClub">Numéro de Club :</label>
                <input type="number" id="numClub" name="numClub" required>
            </div>

            <button type="submit">S'inscrire</button>
        </form>

        <div class="footer">
            <p>Déjà inscrit ? <a href="login.php">Se connecter</a></p>
        </div>
    </div>
</body>
</html>
