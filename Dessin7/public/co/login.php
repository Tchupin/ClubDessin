<?php
// Inclusion du fichier de connexion
include_once('../../includes/db_connect.php');

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
        $query = "SELECT numUtilisateur, login, motdepasse FROM Utilisateur WHERE login = ?";
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

                    $userId = $user['numUtilisateur'];

                    // Vérifier le rôle de l'utilisateur
                    $roleQuery = "SELECT 
                        'admin' AS role FROM Administrateur WHERE numAdministrateur = ? 
                        UNION 
                        SELECT 'evaluateur' AS role FROM Evaluateur WHERE numEvaluateur = ? 
                        UNION 
                        SELECT 'president' AS role FROM President WHERE numPresident = ? 
                        UNION 
                        SELECT 'competiteur' AS role FROM Competiteur WHERE numCompetiteur = ?
                        UNION 
                        SELECT 'directeur' AS role FROM Directeur WHERE numDirecteur = ?
                        UNION 
                        SELECT 'user' AS role FROM Utilisateur WHERE numUtilisateur = ?
                    ";
                    $roleStmt = $mysqli->prepare($roleQuery);
                    $roleStmt->bind_param("iiiiii", $userId, $userId, $userId, $userId, $userId, $userId);
                    $roleStmt->execute();
                    $roleResult = $roleStmt->get_result();

                    // Vérifier si un rôle est trouvé
                    if ($roleResult->num_rows > 0) {
                        $role = $roleResult->fetch_assoc()['role'];

                        // Rediriger en fonction du rôle
                        switch ($role) {
                            case 'admin':
                                header("Location: ../page/admin_dashboard.php");
                                break;
                            case 'evaluateur':
                                header("Location: ../page/eval_dashboard.php");
                                break;
                            case 'president':
                                header("Location: ../page/pres_dashboard.php");
                                break;
                            case 'competiteur':
                                header("Location: ../page/comp_dashboard.php");
                                break;
                            case 'directeur':
                                header("Location: ../page/dir_dashboard.php");
                                break;
                            case 'user':
                                header("Location: ../page/user_dashboard.php");
                                break;
                            default:
                                // Aucun rôle trouvé, rediriger vers une page générique
                                header("Location: ../page/user_dashboard.php");
                                break;
                        }
                    } else {
                        // Aucune correspondance de rôle, message d'erreur et redirection vers user_dashboard
                        $error_message = "L'utilisateur n'a aucun rôle défini.";
                        header("Location: ../page/user_dashboard.php");
                    }

                    $roleStmt->close();
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
    <link rel="stylesheet" href="../../css/login.css">
</head>
<body>
    <div class="login-container">
        <div class="logo-container">
           <!-- <img src="https://via.placeholder.com/100" alt="Logo"> -->
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
