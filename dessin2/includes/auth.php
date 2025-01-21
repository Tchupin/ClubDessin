<?php
// Démarrage de la session
session_start();

// Inclusion du fichier de connexion à la base de données
require_once('db_connect.php');

// Fonction pour vérifier si un utilisateur est connecté
function is_logged_in() {
    return isset($_SESSION['loggedin']) && $_SESSION['loggedin'] === true;
}

// Fonction pour vérifier si un utilisateur est administrateur
function is_admin() {
    global $mysqli;
    if (!is_logged_in()) return false;

    $numUtilisateur = $_SESSION['numUtilisateur'];
    $query = "SELECT * FROM Administrateur WHERE numAdministrateur = ?";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("i", $numUtilisateur);
    $stmt->execute();
    $result = $stmt->get_result();

    return $result->num_rows > 0;
}

// Fonction pour vérifier si un utilisateur est président
function is_president() {
    global $mysqli;
    if (!is_logged_in()) return false;

    $numUtilisateur = $_SESSION['numUtilisateur'];
    $query = "SELECT * FROM President WHERE numPresident = ?";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("i", $numUtilisateur);
    $stmt->execute();
    $result = $stmt->get_result();

    return $result->num_rows > 0;
}

// Fonction pour vérifier si un utilisateur est directeur
function is_director() {
    global $mysqli;
    if (!is_logged_in()) return false;

    $numUtilisateur = $_SESSION['numUtilisateur'];
    $query = "SELECT * FROM Directeur WHERE numDirecteur = ?";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("i", $numUtilisateur);
    $stmt->execute();
    $result = $stmt->get_result();

    return $result->num_rows > 0;
}

// Fonction pour connecter un utilisateur
function login($login, $motdepasse) {
    global $mysqli;

    $query = "SELECT * FROM Utilisateur WHERE login = ?";
    $stmt = $mysqli->prepare($query);
    $stmt->bind_param("s", $login);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();
        // Vérifie le mot de passe
        if (password_verify($motdepasse, $user['motdepasse'])) {
            // Enregistre les informations dans la session
            $_SESSION['loggedin'] = true;
            $_SESSION['numUtilisateur'] = $user['numUtilisateur'];
            $_SESSION['nom'] = $user['nom'];
            $_SESSION['prenom'] = $user['prenom'];

            return true;
        }
    }
    return false;
}

// Fonction pour déconnecter un utilisateur
function logout() {
    session_unset();
    session_destroy();
}

// Fonction pour rediriger si non connecté
function require_login() {
    if (!is_logged_in()) {
        header('Location: login.php');
        exit;
    }
}
?>
