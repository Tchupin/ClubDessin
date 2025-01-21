<?php
// Inclusion du fichier de connexion
include_once('../includes/db_connect.php');

// Démarrer la session
session_start();

// Vérification si le formulaire est soumis
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $login = $_POST['login'] ?? '';
    $motdepasse = $_POST['motdepasse'] ?? '';
    $motdepasse_confirm = $_POST['motdepasse_confirm'] ?? '';
    $nom = $_POST['nom'] ?? '';
    $prenom = $_POST['prenom'] ?? '';
    $adresse = $_POST['adresse'] ?? '';
    $numClub = $_POST['numClub'] ?? null;

    // Vérifier si tous les champs sont remplis
    if (empty($login) || empty($motdepasse) || empty($motdepasse_confirm) || empty($nom) || empty($prenom) || empty($adresse)) {
        $error_message = "Veuillez remplir tous les champs.";
    } elseif ($motdepasse !== $motdepasse_confirm) {
        $error_message = "Les mots de passe ne correspondent pas.";
    } else {
        // Vérifier si l'username existe déjà
        $query = "SELECT numUtilisateur FROM Utilisateur WHERE login = ?";
        $stmt = $mysqli->prepare($query);
        $stmt->bind_param("s", $login);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $error_message = "Ce login est déjà utilisé.";
        } else {
            // Insérer les données dans la base
            $query_insert = "INSERT INTO Utilisateur (login, motdepasse, nom, prenom, adresse, numClub) VALUES (?, ?, ?, ?, ?, ?)";
            $stmt_insert = $mysqli->prepare($query_insert);
            $stmt_insert->bind_param("sssssi", $login, $motdepasse, $nom, $prenom, $adresse, $numClub);
            if ($stmt_insert->execute()) {
                // Stocker les informations utilisateur dans la session
                $_SESSION['loggedin'] = true;
                $_SESSION['login'] = $login;

                // Rediriger vers le tableau de bord du club ou de l'administrateur
                if ($numClub === null) {
                    header("Location: admin_dashboard.php");
                } else {
                    header("Location: club_dashboard.php");
                }
                exit;
            } else {
                $error_message = "Erreur lors de l'inscription : " . $mysqli->error;
            }
        }
        $stmt->close();
    }

    // Fermer la connexion
    $mysqli->close();
}
?>

<!-- Formulaire HTML -->
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        /* Style général */
        body {
            font-family: 'Roboto', sans-serif;
            background-image: linear-gradient(to right, #4e73df, #1cc88a);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            color: white;
        }

        .header {
            background-color: #4e73df;
            padding: 15px 0;
            text-align: center;
            color: white;
        }

        .nav {
            display: flex;
            justify-content: center;
            margin-top: 10px;
        }

        .nav a {
            color: white;
            margin: 0 15px;
            text-decoration: none;
            font-weight: bold;
        }

        .nav a:hover {
            color: #2e59d9;
        }

        .login-container {
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 400px;
            box-sizing: border-box;
            text-align: center;
        }

        h1 {
            color: #4e73df;
            margin-bottom: 30px;
            font-size: 2em;
            font-weight: 500;
        }

        label {
            font-size: 1.1em;
            color: #333;
            margin-top: 10px;
            display: block;
        }

        input[type="text"], input[type="password"], input[type="submit"], select {
            width: 100%;
            padding: 12px;
            margin-top: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 1em;
            background-color: #f8f9fc;
        }

        input[type="submit"], button {
            width: 100%;
            padding: 12px;
            background-color: #4e73df;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.1em;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover, button:hover {
            background-color: #2e59d9;
        }

        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #f5c6cb;
            border-radius: 5px;
            font-size: 1.1em;
            text-align: center;
        }

        .footer {
            margin-top: 30px;
            font-size: 1em;
            color: #333;
            text-align: center;
        }

        .footer a {
            color: #4e73df;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer a:hover {
            color: #2e59d9;
        }

        /* Animation pour la page d'inscription */
        .login-container {
            animation: fadeIn 0.5s ease-in-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="logo-container">
           <!-- <img src="https://via.placeholder.com/100" alt="Logo">  Remplacer par votre logo -->
        </div>
        <h1>Inscription</h1>

        <?php if (!empty($error_message)): ?>
            <div class="error-message"><?php echo $error_message; ?></div>
        <?php endif; ?>

        <form method="POST" action="inscription.php">
            <label for="login">Login :</label>
            <input type="text" id="login" name="login" required>

            <label for="motdepasse">Mot de passe :</label>
            <input type="password" id="motdepasse" name="motdepasse" required>

            <label for="motdepasse_confirm">Confirmer le mot de passe :</label>
            <input type="password" id="motdepasse_confirm" name="motdepasse_confirm" required>

            <label for="nom">Nom :</label>
            <input type="text" id="nom" name="nom" required>

            <label for="prenom">Prénom :</label>
            <input type="text" id="prenom" name="prenom" required>

            <label for="adresse">Adresse :</label>
            <input type="text" id="adresse" name="adresse" required>

            <label for="numClub">Numéro de club (optionnel) :</label>
            <input type="text" id="numClub" name="numClub">

            <button type="submit">S'inscrire</button>
        </form>

        <div class="footer">
            <p>Déjà inscrit ? <a href="login.php">Se connecter</a></p>
        </div>
    </div>
</body>
</html>
