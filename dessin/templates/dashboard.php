<h2>Tableau de bord administrateur</h2>
<p>Bienvenue, <?php echo htmlspecialchars($_SESSION['username']); ?>.</p>

<h3>Liste des utilisateurs</h3>
<?php
$result = $mysqli->query("SELECT username, role FROM users");
echo "<ul>";
while ($user = $result->fetch_assoc()) {
    echo "<li>" . htmlspecialchars($user['username']) . " (" . htmlspecialchars($user['role']) . ")</li>";
}
echo "</ul>";
?>

<h3>Liste des clubs</h3>
<?php
$result = $mysqli->query("SELECT * FROM clubs");
echo "<ul>";
while ($club = $result->fetch_assoc()) {
    echo "<li>" . htmlspecialchars($club['name']) . " : " . htmlspecialchars($club['description']) . "</li>";
}
echo "</ul>";
?>
