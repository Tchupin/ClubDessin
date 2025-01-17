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
    <style>
        /* Style de la page de connexion */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .login-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 400px;
            box-sizing: border-box;
        }

        h1 {
            text-align: center;
            font-size: 2em;
            color: #333;
        }

        label {
            font-size: 1.1em;
            color: #333;
            margin-top: 10px;
            display: block;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1em;
        }

        input[type="submit"], button {
            width: 100%;
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 1.1em;
            cursor: pointer;
        }

        input[type="submit"]:hover, button:hover {
            background-color: #45a049;
        }

        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #f5c6cb;
            border-radius: 5px;
            font-size: 1em;
            text-align: center;
        }

        .footer {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="login-container">
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
            <p>Pas encore inscrit ? <a href="register.php">Créer un compte</a></p>
        </div>
    </div>
</body>
</html>
