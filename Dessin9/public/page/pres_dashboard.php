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

// Vérifier si l'utilisateur est président d'un concours
$query_president = "SELECT p.numConcours, c.theme 
                    FROM President p
                    JOIN Concours c ON p.numConcours = c.numConcours
                    WHERE p.numPresident = ?";
$stmt_president = $mysqli->prepare($query_president);
$stmt_president->bind_param("i", $numUtilisateur);
$stmt_president->execute();
$concours_result = $stmt_president->get_result();

if ($concours_result->num_rows == 0) {
    echo "Vous n'êtes pas président d'un concours.";
    exit;
}

// Récupérer le concours du président
$concours = $concours_result->fetch_assoc();
$numConcours = $concours['numConcours'];
$themeConcours = $concours['theme'];

// Récupérer les dessins soumis pour le concours
$query_dessins = "SELECT d.numDessin, d.commentaire, d.classement, d.dateRemise, u.nom AS competiteur 
                  FROM Dessin d
                  JOIN Competiteur c ON d.numCompetiteur = c.numCompetiteur
                  JOIN Utilisateur u ON c.numCompetiteur = u.numUtilisateur
                  WHERE d.numConcours = ?";
$stmt_dessins = $mysqli->prepare($query_dessins);
$stmt_dessins->bind_param("i", $numConcours);
$stmt_dessins->execute();
$dessins_result = $stmt_dessins->get_result();

// Récupérer les évaluateurs éligibles pour le concours
$query_evaluateurs = "SELECT e.numEvaluateur, u.nom 
                      FROM Evaluateur e
                      JOIN Utilisateur u ON e.numEvaluateur = u.numUtilisateur
                      WHERE e.numEvaluateur NOT IN (
                          SELECT numCompetiteur FROM CompetiteurParticipe WHERE numConcours = ?
                      ) AND e.numEvaluateur != (
                          SELECT numPresident FROM President WHERE numConcours = ?
                      )";
$stmt_evaluateurs = $mysqli->prepare($query_evaluateurs);
$stmt_evaluateurs->bind_param("ii", $numConcours, $numConcours);
$stmt_evaluateurs->execute();
$evaluateurs_result = $stmt_evaluateurs->get_result();

// Ajouter une évaluation
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['numDessin'], $_POST['evaluateur1'], $_POST['evaluateur2'], $_POST['note'], $_POST['commentaire'])) {
    $numDessin = $_POST['numDessin'];
    $evaluateur1 = $_POST['evaluateur1'];
    $evaluateur2 = $_POST['evaluateur2'];
    $note = $_POST['note'];
    $commentaire = $_POST['commentaire'];

    if ($evaluateur1 !== $evaluateur2) {
        $query_add_evaluation = "INSERT INTO Evaluation (dateEvaluation, note, commentaire, numDessin, numEvaluateur1, numEvaluateur2)
                                 VALUES (CURDATE(), ?, ?, ?, ?, ?)";
        $stmt_add_evaluation = $mysqli->prepare($query_add_evaluation);
        $stmt_add_evaluation->bind_param("isiii", $note, $commentaire, $numDessin, $evaluateur1, $evaluateur2);
        $stmt_add_evaluation->execute();
        $message = "Évaluation attribuée avec succès.";
    } else {
        $message = "Les deux évaluateurs doivent être différents.";
    }
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Président</title>
    <link rel="stylesheet" href="../../css/user_dashboard.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-image: linear-gradient(to right, #4e73df, #1cc88a);
        }
    </style>
</head>
<body>
<?php include('nav.php'); ?>
    <div class="container">
        <h1>Dashboard Président</h1>
        <h2>Concours : <?php echo htmlspecialchars($themeConcours); ?></h2>

        <?php if (isset($message)): ?>
            <p><?php echo htmlspecialchars($message); ?></p>
        <?php endif; ?>

        <h3>Liste des Dessins</h3>
        <form action="president_dashboard.php" method="POST">
            <table>
                <thead>
                    <tr>
                        <th>ID Dessin</th>
                        <th>Commentaire</th>
                        <th>Date de Remise</th>
                        <th>Compétiteur</th>
                        <th>Évaluateur 1</th>
                        <th>Évaluateur 2</th>
                        <th>Note</th>
                        <th>Attribuer</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($dessin = $dessins_result->fetch_assoc()): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($dessin['numDessin']); ?></td>
                            <td><?php echo htmlspecialchars($dessin['commentaire']); ?></td>
                            <td><?php echo htmlspecialchars($dessin['dateRemise']); ?></td>
                            <td><?php echo htmlspecialchars($dessin['competiteur']); ?></td>
                            <td>
                                <select name="evaluateur1" required>
                                    <option value="">-- Sélectionner --</option>
                                    <?php
                                    $evaluateurs_result->data_seek(0); // Repositionner le curseur pour chaque dessin
                                    while ($eval = $evaluateurs_result->fetch_assoc()): ?>
                                        <option value="<?php echo $eval['numEvaluateur']; ?>">
                                            <?php echo htmlspecialchars($eval['nom']); ?>
                                        </option>
                                    <?php endwhile; ?>
                                </select>
                            </td>
                            <td>
                                <select name="evaluateur2" required>
                                    <option value="">-- Sélectionner --</option>
                                    <?php
                                    $evaluateurs_result->data_seek(0); // Repositionner le curseur pour chaque dessin
                                    while ($eval = $evaluateurs_result->fetch_assoc()): ?>
                                        <option value="<?php echo $eval['numEvaluateur']; ?>">
                                            <?php echo htmlspecialchars($eval['nom']); ?>
                                        </option>
                                    <?php endwhile; ?>
                                </select>
                            </td>
                            <td>
                                <input type="number" name="note" min="0" max="20" required>
                            </td>
                            <td>
                                <button type="submit" name="numDessin" value="<?php echo $dessin['numDessin']; ?>">Attribuer</button>
                            </td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        </form>

        <a href="../co/logout.php" class="logout">Se déconnecter</a>
    </div>
</body>
</html>

<?php
// Fermer la connexion à la base de données
$mysqli->close();
?>
