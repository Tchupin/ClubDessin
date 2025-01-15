/*   	Commandes de création de la base pour les concours de dessins  */

DROP TABLE IF EXISTS Club;
DROP TABLE IF EXISTS Utilisateur;
DROP TABLE IF EXISTS Directeur;
DROP TABLE IF EXISTS Administrateur;
DROP TABLE IF EXISTS Président;
DROP TABLE IF EXISTS Evaluateur;
DROP TABLE IF EXISTS Concours;
DROP TABLE IF EXISTS Compétiteur;
DROP TABLE IF EXISTS Dessin;
DROP TABLE IF EXISTS Evaluation;
DROP TABLE IF EXISTS CompetiteurParticipe;
DROP TABLE IF EXISTS ClubParticipe;
DROP TABLE IF EXISTS Jury;

CREATE TABLE Club (
    numClub INT AUTO_INCREMENT PRIMARY KEY,
    nomClub VARCHAR(100) NOT NULL,
    adresse TEXT,
    numTéléphone VARCHAR(15),
    nombreAdhérents INT,
    ville VARCHAR(50),
    département VARCHAR(50),
    région VARCHAR(50)
);

CREATE TABLE Utilisateur (
    numUtilisateur INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prénom VARCHAR(50) NOT NULL,
    adresse TEXT,
    login VARCHAR(50) UNIQUE NOT NULL,
    motdepasse VARCHAR(255) NOT NULL,
    numClub INT,
    FOREIGN KEY (numClub) REFERENCES Club(numClub)
);

CREATE TABLE Directeur (
    dateDebut DATE NOT NULL,
    numDirecteur INT PRIMARY KEY,
    numClub INT,
    FOREIGN KEY (numDirecteur) REFERENCES Utilisateur(numUtilisateur),
    FOREIGN KEY (numClub) REFERENCES Club(numClub)
);

CREATE TABLE Administrateur (
    dateDebut DATE NOT NULL,
    numAdministrateur INT PRIMARY KEY,
    FOREIGN KEY (numAdministrateur) REFERENCES Utilisateur(numUtilisateur)
);

CREATE TABLE Président (
    prime DECIMAL(10, 2),
    numPresident INT PRIMARY KEY,
    FOREIGN KEY (numPresident) REFERENCES Utilisateur(numUtilisateur)
);

CREATE TABLE Evaluateur (
    spécialité VARCHAR(100) NOT NULL,
    numEvaluateur INT PRIMARY KEY,
    FOREIGN KEY (numEvaluateur) REFERENCES Utilisateur(numUtilisateur)
);

CREATE TABLE Concours (
    numConcours INT AUTO_INCREMENT PRIMARY KEY,
    thème VARCHAR(255) NOT NULL,
    dateDebut DATE NOT NULL,
    dateFin DATE NOT NULL,
    état VARCHAR(50) NOT NULL
);

CREATE TABLE Compétiteur (
    datePremièreParticipation DATE,
    numCompetiteur INT PRIMARY KEY,
    FOREIGN KEY (numCompetiteur) REFERENCES Utilisateur(numUtilisateur)
);

CREATE TABLE Dessin (
    numDessin INT AUTO_INCREMENT PRIMARY KEY,
    numCompetiteur INT,
    commentaire TEXT,
    classement INT,
    dateRemise DATE,
    leDessin TEXT,
    numConcours INT,
    FOREIGN KEY (numCompetiteur) REFERENCES Compétiteur(numCompetiteur),
    FOREIGN KEY (numConcours) REFERENCES Concours(numConcours)
);

CREATE TABLE Evaluation (
    dateEvaluation DATE NOT NULL,
    note INT NOT NULL,
    commentaire TEXT,
    numDessin INT,
    numEvaluateur INT,
    PRIMARY KEY (numDessin, numEvaluateur),
    FOREIGN KEY (numDessin) REFERENCES Dessin(numDessin),
    FOREIGN KEY (numEvaluateur) REFERENCES Evaluateur(numEvaluateur)
);

CREATE TABLE CompetiteurParticipe (
    numCompetiteur INT,
    numConcours INT,
    PRIMARY KEY (numCompetiteur, numConcours),
    FOREIGN KEY (numCompetiteur) REFERENCES Compétiteur(numCompetiteur),
    FOREIGN KEY (numConcours) REFERENCES Concours(numConcours)
);

CREATE TABLE ClubParticipe (
    numClub INT,
    numConcours INT,
    PRIMARY KEY (numClub, numConcours),
    FOREIGN KEY (numClub) REFERENCES Club(numClub),
    FOREIGN KEY (numConcours) REFERENCES Concours(numConcours)
);

CREATE TABLE Jury (
    numEvaluateur INT,
    numConcours INT,
    PRIMARY KEY (numEvaluateur, numConcours),
    FOREIGN KEY (numEvaluateur) REFERENCES Evaluateur(numEvaluateur),
    FOREIGN KEY (numConcours) REFERENCES Concours(numConcours)
);
