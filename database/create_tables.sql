CREATE TABLE Utilisateurs (
    id_utilisateur INT AUTO_INCREMENT PRIMARY KEY, 
    nom VARCHAR(50) NOT NULL,                   
    prenom VARCHAR(50) NOT NULL,                  
    adresse TEXT,                                 
    login VARCHAR(50) UNIQUE NOT NULL,           
    mot_de_passe VARCHAR(255) NOT NULL,          
    role ENUM('administrateur', 'directeur', 'président', 'évaluateur', 'compétiteur') NOT NULL, 
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);