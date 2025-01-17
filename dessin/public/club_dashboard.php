<?php
// Démarrer la session
session_start();

// Inclusion du fichier de connexion à la base de données
require_once('../includes/db_connect.php');

// Vérifier si l'utilisateur est connecté
if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    header('Location: login.php');
    exit;
}

// Récupérer les informations utilisateur
$numUtilisateur = $_SESSION['numUtilisateur'];
$login = $_SESSION['login'];
$numClub = $_SESSION['numClub'];

// Vérifier si l'utilisateur a un club
if ($numClub === null) {
    echo "Vous n'êtes pas associé à un club.";
    exit;
}

// Récupérer les détails du club
$query = "SELECT * FROM Club WHERE numClub = ?";
$stmt = $mysqli->prepare($query);
$stmt->bind_param("i", $numClub);
$stmt->execute();
$result = $stmt->get_result();

// Vérifier si le club existe
if ($result->num_rows > 0) {
    $club = $result->fetch_assoc();
} else {
    echo "Aucun club trouvé.";
    exit;
}

// Récupérer tous les clubs pour le sélecteur
$query_clubs = "SELECT * FROM Club";
$stmt_clubs = $mysqli->prepare($query_clubs);
$stmt_clubs->execute();
$clubs_result = $stmt_clubs->get_result();

// Vérifier si un tableau est sélectionné
$table = isset($_POST['table']) ? $_POST['table'] : '';

// Requête par défaut pour afficher les utilisateurs
if ($table == 'utilisateur') {
    $query_table = "SELECT numUtilisateur, nom, prénom, login FROM Utilisateur";
    $stmt_table = $mysqli->prepare($query_table);
    $stmt_table->execute();
    $table_result = $stmt_table->get_result();
} elseif ($table == 'concours') {
    $query_table = "SELECT numConcours, thème, dateDebut, dateFin, état FROM Concours";
    $stmt_table = $mysqli->prepare($query_table);
    $stmt_table->execute();
    $table_result = $stmt_table->get_result();
} elseif ($table == 'club') {
    $query_table = "SELECT numClub, nomClub, adresse, ville, région FROM Club";
    $stmt_table = $mysqli->prepare($query_table);
    $stmt_table->execute();
    $table_result = $stmt_table->get_result();
} elseif ($table == 'administrateur') {
    $query_table = "SELECT numAdministrateur, dateDebut FROM Administrateur WHERE numAdministrateur = ?";
    $stmt_table = $mysqli->prepare($query_table);
    $stmt_table->bind_param("i", $numUtilisateur);  // Afficher seulement l'administrateur connecté
    $stmt_table->execute();
    $table_result = $stmt_table->get_result();
} else {
    $table_result = null;  // Par défaut, pas de table sélectionnée
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Club</title>
    <style>
        /* Style global */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow-x: hidden; /* Empêche le défilement horizontal */
        }

        .container {
            width: 80%;
            max-width: 1000px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 40px;
            box-sizing: border-box;
            max-height: 90vh;
            overflow-y: auto; /* Permet de faire défiler verticalement */
        }

        h1, h2, h3 {
            color: #333;
        }

        .club-info {
            background-color: #fafafa;
            border-radius: 6px;
            padding: 20px;
            margin-top: 20px;
        }

        .select-club {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .select-club select {
            padding: 10px;
            font-size: 1em;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 70%;
        }

        .select-club button {
            padding: 10px 20px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .select-club button:hover {
            background-color: #0056b3;
        }

        .logout {
            margin-top: 30px;
            display: block;
            text-align: center;
            font-size: 1.1em;
            color: #007BFF;
            text-decoration: none;
        }

        .logout:hover {
            text-decoration: underline;
        }

        .club-details {
            list-style-type: none;
            padding: 0;
        }

        .club-details li {
            margin-bottom: 10px;
            font-size: 1.1em;
        }

        .club-details li span {
            font-weight: bold;
        }

        .table-data {
            margin-top: 30px;
        }

        .table-data table {
            width: 100%;
            border-collapse: collapse;
        }

        .table-data th, .table-data td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }

        .table-data th {
            background-color: #f1f1f1;
        }

        /* Style pour le bouton Retour en haut */
        #scrollToTopBtn {
            display: none;
            position: fixed;
            bottom: 20px;
            right: 20px;
            padding: 10px 20px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        #scrollToTopBtn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Bienvenue, <?php echo htmlspecialchars($login); ?> !</h1>
        <!-- Sélecteur de table -->
        <div class="select-club">
            <h3>Choisir une table à afficher :</h3>
            <form action="club_dashboard.php" method="POST">
                <select name="table" id="table">
                    <option value="">-- Sélectionner --</option>
                    <option value="club" <?php echo ($table == 'club') ? 'selected' : ''; ?>>Club</option>
                    <option value="utilisateur" <?php echo ($table == 'utilisateur') ? 'selected' : ''; ?>>Utilisateurs</option>
                    <option value="administrateur" <?php echo ($table == 'administrateur') ? 'selected' : ''; ?>>Administrateurs</option>
                    <option value="concours" <?php echo ($table == 'concours') ? 'selected' : ''; ?>>Concours</option>
                </select>
                <button type="submit">Afficher</button>
            </form>
        </div>

        <!-- Affichage des données selon la table choisie -->
        <?php if ($table_result): ?>
            <div class="table-data">
                <h2>Données de la table : <?php echo ucfirst($table); ?></h2>
                <table>
                    <thead>
                        <tr>
                            <?php 
                            // Affichage dynamique des en-têtes selon la table
                            $columns = $table_result->fetch_fields();
                            foreach ($columns as $column) {
                                echo "<th>" . htmlspecialchars($column->name) . "</th>";
                            }
                            ?>
                        </tr>
                    </thead>
                    <tbody>
                        <?php while ($row = $table_result->fetch_assoc()): ?>
                            <tr>
                                <?php foreach ($row as $data): ?>
                                    <td><?php echo htmlspecialchars($data); ?></td>
                                <?php endforeach; ?>
                            </tr>
                        <?php endwhile; ?>
                    </tbody>
                </table>
            </div>
        <?php endif; ?>

        <a href="logout.php" class="logout">Se déconnecter</a>
    </div>

    <!-- Bouton Retour en haut -->
    <button id="scrollToTopBtn">Retour en haut</button>

    <script>
        // Affichage du bouton de retour en haut en fonction du défilement
        window.onscroll = function() {
            let button = document.getElementById('scrollToTopBtn');
            if (document.body.scrollTop > 200 || document.documentElement.scrollTop > 200) {
                button.style.display = "block";
            } else {
                button.style.display = "none";
            }
        };

        // Lorsque l'utilisateur clique sur le bouton, on revient en haut de la page
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
