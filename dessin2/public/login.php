<?php
// Inclusion du fichier de connexion
include_once('../includes/db_connect.php');

// Démarrer la session
session_start();

// Vérification si le formulaire est soumis
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $login = $_POST['login'] ?? '';
    $motdepasse = $_POST['motdepasse'] ?? '';

    // Vérifier si les champs sont remplis
    if (empty($login) || empty($motdepasse)) {
        $error_message = "Veuillez remplir tous les champs.";
    } else {
        // Préparer la requête SQL
        $query = "SELECT numUtilisateur, login, motdepasse, numClub FROM Utilisateur WHERE login = ?";
        $stmt = $mysqli->prepare($query);

        if (!$stmt) {
            $error_message = "Erreur dans la préparation de la requête : " . $mysqli->error;
        } else {
            $stmt->bind_param("s", $login);
            $stmt->execute();
            $result = $stmt->get_result();

            // Vérifier si un utilisateur est trouvé
            if ($result->num_rows === 1) {
                $user = $result->fetch_assoc();

                // Vérifier le mot de passe
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
                    $error_message = "Mot de passe incorrect.";
                }
            } else {
                $error_message = "Aucun utilisateur trouvé avec ce login.";
            }

            $stmt->close();
        }
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
    <title>Connexion</title>
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

        input[type="text"], input[type="password"] {
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
            transition: opacity 0.3s ease-in-out;
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

        /* Effet de logo */
        .logo-container {
            margin-bottom: 20px;
        }

        .logo-container img {
            max-width: 100px;
            margin: 0 auto;
            display: block;
        }

        /* Animation pour la page de connexion */
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
        <h1>Connexion</h1>

        <?php if (!empty($error_message)): ?>
            <div class="error-message"><?php echo $error_message; ?></div>
        <?php endif; ?>

        <form method="POST" action="login.php">
            <label for="login">Login :</label>
            <input type="text" id="login" name="login" required>

            <label for="motdepasse">Mot de passe :</label>
            <input type="password" id="motdepasse" name="motdepasse" required>

            <button type="submit">Se connecter</button>
        </form>

        <div class="footer">
            <p>Pas encore inscrit ? <a href="inscription.php">Créer un compte</a></p>
        </div>
    </div>
</body>
</html>
