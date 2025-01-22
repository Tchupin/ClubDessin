<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Évaluation des dessins</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-image: linear-gradient(to right, #4e73df, #1cc88a);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        h1 {
            text-align: center;
            color: #444;
        }

        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
        }

        input[type="number"],
        textarea,
        select {
            width: 100%;
            padding: 8px;
            margin-bottom: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
        }

        button:hover {
            background-color: #0056b3;
        }

        .message {
            background-color: #fff3cd;
            color: #856404;
            padding: 15px;
            border: 1px solid #ffeeba;
            border-radius: 5px;
            margin: 20px 0;
            text-align: center;
        }
    </style>
</head>
<body>
<?php include('nav.php'); ?>
<div class="form-container">
    <h1>Évaluation des dessins</h1>
    <?php
    // Inclure la connexion à la base de données
    include_once('../../includes/db_connect.php');

    // Utiliser l'objet $mysqli pour interagir avec la base de données
    if ($mysqli->connect_error) {
        die("Erreur de connexion : " . $mysqli->connect_error);
    }

    // Identifiant de l'évaluateur (à remplacer par la gestion des sessions si nécessaire)
    $numEvaluateur = 1; 

    // Vérifier les concours actifs pour l'évaluateur
    $sql_concours = "
        SELECT c.numConcours, c.theme
        FROM Concours c
        WHERE c.etat = 'en cours'
        AND NOT EXISTS (
            SELECT 1
            FROM CompetiteurParticipe cp
            WHERE cp.numConcours = c.numConcours
            AND cp.numCompetiteur = $numEvaluateur
        )
    ";
    $result_concours = $mysqli->query($sql_concours);

    if ($result_concours && $result_concours->num_rows > 0) {
        $concours = $result_concours->fetch_assoc();
        $numConcours = $concours['numConcours'];
        $themeConcours = $concours['theme'];

        echo "<h2>Concours : " . htmlspecialchars($themeConcours) . "</h2>";

        // Récupérer les dessins disponibles à évaluer
        $sql_dessins = "
            SELECT d.numDessin, u.nom AS nomCompetiteur, u.prenom AS prenomCompetiteur
            FROM Dessin d
            JOIN Competiteur c ON d.numCompetiteur = c.numCompetiteur
            JOIN Utilisateur u ON c.numCompetiteur = u.numUtilisateur
            WHERE d.numConcours = $numConcours
            AND d.numDessin NOT IN (
                SELECT e.numDessin
                FROM Evaluation e
                WHERE e.numEvaluateur1 = $numEvaluateur OR e.numEvaluateur2 = $numEvaluateur
            )
            LIMIT 8
        ";
        $result_dessins = $mysqli->query($sql_dessins);

        if ($result_dessins && $result_dessins->num_rows > 0) {
            echo '<form method="POST">';
            echo '<label for="numDessin">Sélectionner un dessin :</label>';
            echo '<select name="numDessin" id="numDessin" required>';
            while ($row = $result_dessins->fetch_assoc()) {
                echo '<option value="' . $row['numDessin'] . '">';
                echo "Dessin #" . $row['numDessin'] . " - " . $row['nomCompetiteur'] . " " . $row['prenomCompetiteur'];
                echo '</option>';
            }
            echo '</select>';
            echo '<label for="note">Note (0-20) :</label>';
            echo '<input type="number" name="note" id="note" min="0" max="20" required>';
            echo '<label for="commentaire">Commentaire :</label>';
            echo '<textarea name="commentaire" id="commentaire" required></textarea>';
            echo '<button type="submit">Enregistrer l\'évaluation</button>';
            echo '</form>';
        } else {
            echo '<div class="message">Aucun dessin disponible pour évaluation.</div>';
        }
    } else {
        echo '<div class="message">Aucun concours disponible ou vous êtes compétiteur dans ce concours.</div>';
    }

    // Traitement du formulaire
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        if (!empty($_POST['numDessin']) && !empty($_POST['note']) && isset($_POST['commentaire'])) {
            $numDessin = $_POST['numDessin'];
            $note = $_POST['note'];
            $commentaire = $mysqli->real_escape_string($_POST['commentaire']);
            $dateEvaluation = date('Y-m-d');

            // Insertion dans la table Evaluation
            $sql_insert = "
                INSERT INTO Evaluation (dateEvaluation, note, commentaire, numDessin, numEvaluateur1)
                VALUES ('$dateEvaluation', $note, '$commentaire', $numDessin, $numEvaluateur)
            ";

            if ($mysqli->query($sql_insert) === TRUE) {
                echo '<div class="message" style="background-color: #d4edda; color: #155724; border-color: #c3e6cb;">Évaluation enregistrée avec succès !</div>';
            } else {
                echo '<div class="message" style="background-color: #f8d7da; color: #721c24; border-color: #f5c6cb;">Erreur lors de l\'enregistrement : ' . $mysqli->error . '</div>';
            }
        } else {
            echo '<div class="message" style="background-color: #f8d7da; color: #721c24; border-color: #f5c6cb;">Veuillez remplir tous les champs du formulaire.</div>';
        }
    }

    $mysqli->close();
    ?>
</div>
</body>
</html>
