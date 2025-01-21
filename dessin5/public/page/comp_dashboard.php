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

// Récupérer les concours auxquels le compétiteur participe
$query_concours = "SELECT 
    c.numConcours, c.theme, c.dateDebut, c.dateFin, c.etat, 
    p.numCompetiteur 
FROM Concours c
INNER JOIN CompetiteurParticipe p ON c.numConcours = p.numConcours
WHERE p.numCompetiteur = ? 
ORDER BY c.dateDebut DESC";

$stmt_concours = $mysqli->prepare($query_concours);
$stmt_concours->bind_param("i", $numUtilisateur);
$stmt_concours->execute();
$concours_result = $stmt_concours->get_result();

// Requête pour récupérer les dessins déjà soumis pour chaque concours
$query_dessins = "SELECT 
    numDessin, numConcours, commentaire, dateRemise 
FROM Dessin 
WHERE numCompetiteur = ? 
ORDER BY dateRemise DESC";
$stmt_dessins = $mysqli->prepare($query_dessins);
$stmt_dessins->bind_param("i", $numUtilisateur);
$stmt_dessins->execute();
$dessins_result = $stmt_dessins->get_result();

// Logique pour ajouter un dessin dans un concours
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['submit_dessin'])) {
    $numConcours = $_POST['numConcours'];
    $commentaire = $_POST['commentaire'];

    // Vérifier que le compétiteur n'a pas déjà soumis 3 dessins pour ce concours
    $query_count = "SELECT COUNT(*) FROM Dessin WHERE numCompetiteur = ? AND numConcours = ?";
    $stmt_count = $mysqli->prepare($query_count);
    $stmt_count->bind_param("ii", $numUtilisateur, $numConcours);
    $stmt_count->execute();
    $stmt_count->bind_result($count);
    $stmt_count->fetch();

    if ($count < 3) {
        // Insertion du dessin
        $query_insert = "INSERT INTO Dessin (numCompetiteur, numConcours, commentaire) VALUES (?, ?, ?)";
        $stmt_insert = $mysqli->prepare($query_insert);
        $stmt_insert->bind_param("iis", $numUtilisateur, $numConcours, $commentaire);
        $stmt_insert->execute();
        echo "Dessin ajouté avec succès.";
    } else {
        echo "Vous avez déjà soumis 3 dessins pour ce concours.";
    }
}
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Compétiteur</title>
    <link rel="stylesheet" href="../../css/user_dashboard.css">
</head>
<body>
<?php include('nav.php'); ?>
    <div class="container">
        <h1>Bienvenue, <?php echo htmlspecialchars($login); ?> !</h1>
        
        <div class="select-concours">
            <h3>Choisir un concours auquel vous participez :</h3>
            <form action="comp_dashboard.php" method="POST">
                <select name="numConcours" id="numConcours">
                    <option value="">-- Sélectionner --</option>
                    <?php while ($concours = $concours_result->fetch_assoc()): ?>
                        <option value="<?php echo $concours['numConcours']; ?>">
                            <?php echo htmlspecialchars($concours['theme']) . ' - ' . date('d/m/Y', strtotime($concours['dateDebut'])) . ' au ' . date('d/m/Y', strtotime($concours['dateFin'])); ?>
                        </option>
                    <?php endwhile; ?>
                </select>
                <button type="submit">Afficher</button>
            </form>
        </div>

        <?php if (isset($_POST['numConcours'])): ?>
            <?php
            $numConcours = $_POST['numConcours'];
            $query_concours_detail = "SELECT * FROM Concours WHERE numConcours = ?";
            $stmt_concours_detail = $mysqli->prepare($query_concours_detail);
            $stmt_concours_detail->bind_param("i", $numConcours);
            $stmt_concours_detail->execute();
            $concours_detail = $stmt_concours_detail->get_result()->fetch_assoc();
            ?>
            <h2>Concours: <?php echo htmlspecialchars($concours_detail['theme']); ?></h2>
            <p>Date de début: <?php echo date('d/m/Y', strtotime($concours_detail['dateDebut'])); ?></p>
            <p>Date de fin: <?php echo date('d/m/Y', strtotime($concours_detail['dateFin'])); ?></p>
            <p>État: <?php echo $concours_detail['etat']; ?></p>

            <?php if (strtotime($concours_detail['dateDebut']) > time()): ?>
                <!-- Concours futur -->
                <p>Ce concours est à venir. Vous ne pouvez pas soumettre de dessin pour le moment.</p>
            <?php elseif (strtotime($concours_detail['dateFin']) < time()): ?>
                <!-- Concours passé -->
                <h3>Historique des dessins soumis :</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Date de remise</th>
                            <th>Commentaire</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php while ($dessin = $dessins_result->fetch_assoc()): ?>
                            <tr>
                                <td><?php echo date('d/m/Y', strtotime($dessin['dateRemise'])); ?></td>
                                <td><?php echo htmlspecialchars($dessin['commentaire']); ?></td>
                            </tr>
                        <?php endwhile; ?>
                    </tbody>
                </table>
            <?php else: ?>
                <!-- Concours présent -->
                <form action="comp_dashboard.php" method="POST">
                    <textarea name="commentaire" placeholder="Ajoutez un commentaire"></textarea>
                    <button type="submit" name="submit_dessin">Ajouter un dessin</button>
                </form>
            <?php endif; ?>
        <?php endif; ?>

        <a href="../co/logout.php" class="logout">Se déconnecter</a>
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
