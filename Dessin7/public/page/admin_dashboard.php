<?php
// Démarrer la session
session_start();

// Inclusion du fichier de connexion à la base de données
require_once('../../includes/db_connect.php');

// Vérifier si l'utilisateur est connecté
if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    header('Location: ../co/login.php');
    exit;
}

// Récupérer les informations utilisateur
$numUtilisateur = $_SESSION['numUtilisateur'];
$login = $_SESSION['login'];

// Récupérer tous les utilisateurs non compétiteurs ni évaluateurs
$query_utilisateurs = "SELECT u.numUtilisateur, u.nom, u.prenom 
                       FROM Utilisateur u 
                       LEFT JOIN Competiteur c ON u.numUtilisateur = c.numCompetiteur 
                       LEFT JOIN Evaluateur e ON u.numUtilisateur = e.numEvaluateur
                       WHERE c.numCompetiteur IS NULL AND e.numEvaluateur IS NULL";
$stmt_utilisateurs = $mysqli->prepare($query_utilisateurs);
$stmt_utilisateurs->execute();
$utilisateurs_result = $stmt_utilisateurs->get_result();

// Vérification de l'ajout d'un concours
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['create_concours'])) {
    // Récupérer les données du formulaire
    $theme = $_POST['theme'];
    $dateDebut = $_POST['dateDebut'];
    $dateFin = $_POST['dateFin'];
    $president = $_POST['president'];

    // Insertion du concours
    $query = "INSERT INTO Concours (theme, dateDebut, dateFin) VALUES (?, ?, ?)";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("sss", $theme, $dateDebut, $dateFin);
    $stmt->execute();

    // Récupérer l'ID du concours inséré
    $numConcours = $mysqli->insert_id;

    // Attribuer un président au concours
    $query_president = "INSERT INTO President (numPresident, numConcours) VALUES (?, ?)";
    $stmt_president = $mysqli->prepare($query_president);
    $stmt_president->bind_param("ii", $president, $numConcours);
    $stmt_president->execute();

    echo "Concours créé avec succès!";
}

?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Club</title>
    <?php include('nav.php'); ?>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-image: linear-gradient(to right, #4e73df, #1cc88a);
        }

        .container {
            width: 80%;
            margin: auto;
            padding: 20px;
        }

        h1 {
            color: #333;
        }

        .form-container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .form-container h2 {
            text-align: center;
            color: #444;
        }

        .form-container label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        .form-container input, .form-container select, .form-container button {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .form-container button {
            background-color: #4CAF50;
            color: white;
            border: none;
        }

        .form-container button:hover {
            background-color: #45a049;
        }

        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }

        table th, table td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        table th {
            background-color: #f2f2f2;
        }

        .logout {
            display: inline-block;
            background-color: #f44336;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
        }

        .logout:hover {
            background-color: #d32f2f;
        }

        #scrollToTopBtn {
            display: none;
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #008CBA;
            color: white;
            border: none;
            padding: 15px;
            border-radius: 50%;
            font-size: 18px;
            cursor: pointer;
        }

        #scrollToTopBtn:hover {
            background-color: #005f6a;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Bienvenue, <?php echo htmlspecialchars($login); ?> !</h1>

        <!-- Formulaire de création de concours -->
        <div class="form-container">
            <h2>Créer un Concours</h2>
            <form action="admin_dashboard.php" method="POST">
                <label for="theme">Thème du concours :</label>
                <input type="text" id="theme" name="theme" required>

                <label for="dateDebut">Date de début :</label>
                <input type="date" id="dateDebut" name="dateDebut" required>

                <label for="dateFin">Date de fin :</label>
                <input type="date" id="dateFin" name="dateFin" required>

                <label for="president">Choisir un Président :</label>
                <select id="president" name="president" required>
                    <option value="">-- Sélectionner un président --</option>
                    <?php while ($user = $utilisateurs_result->fetch_assoc()): ?>
                        <option value="<?php echo $user['numUtilisateur']; ?>">
                            <?php echo htmlspecialchars($user['nom']) . ' ' . htmlspecialchars($user['prenom']); ?>
                        </option>
                    <?php endwhile; ?>
                </select>

                <button type="submit" name="create_concours">Créer le concours</button>
            </form>
        </div>

        <!-- Affichage des concours existants -->
        <div class="table-data">
            <h2>Concours Existants</h2>
            <table>
                <thead>
                    <tr>
                        <th>Thème</th>
                        <th>Date Début</th>
                        <th>Date Fin</th>
                        <th>Président</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    // Récupérer tous les concours existants
                    $query_concours = "SELECT c.numConcours, c.theme, c.dateDebut, c.dateFin, u.nom AS president_nom, u.prenom AS president_prenom 
                                       FROM Concours c
                                       JOIN President p ON c.numConcours = p.numConcours
                                       JOIN Utilisateur u ON p.numPresident = u.numUtilisateur";
                    $stmt_concours = $mysqli->prepare($query_concours);
                    $stmt_concours->execute();
                    $concours_result = $stmt_concours->get_result();

                    while ($concours = $concours_result->fetch_assoc()): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($concours['theme']); ?></td>
                            <td><?php echo htmlspecialchars($concours['dateDebut']); ?></td>
                            <td><?php echo htmlspecialchars($concours['dateFin']); ?></td>
                            <td><?php echo htmlspecialchars($concours['president_nom']) . ' ' . htmlspecialchars($concours['president_prenom']); ?></td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        </div>

        <a href="../co/logout.php" class="logout">Se déconnecter</a>
    </div>

    <!-- Bouton Retour en haut -->
    <button id="scrollToTopBtn">↑</button>

    <script>
        window.onscroll = function() {
            let button = document.getElementById('scrollToTopBtn');
            if (document.body.scrollTop > 200 || document.documentElement.scrollTop > 200) {
                button.style.display = "block";
            } else {
                button.style.display = "none";
            }
        };

        document.getElementById('scrollToTopBtn').onclick = function() {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        };
    </script>
</body>
</html>

<?php
// Fermer la connexion à la base de données
$mysqli->close();
?>
