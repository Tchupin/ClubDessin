DROP TABLE IF EXISTS Concours;
DROP TABLE IF EXISTS Evaluateur;
DROP TABLE IF EXISTS Competiteur;
DROP TABLE IF EXISTS President;
DROP TABLE IF EXISTS Directeur;
DROP TABLE IF EXISTS Administrateur;
DROP TABLE IF EXISTS Utilisateur;
DROP TABLE IF EXISTS Club;

CREATE TABLE Club (
    numClub INT AUTO_INCREMENT,
    nomClub VARCHAR(40) NOT NULL,
    adresse VARCHAR(140),
    numTelephone CHAR(10),
    nombreAdherents INT,
    ville VARCHAR(40),
    departement VARCHAR(60),
    region VARCHAR(60),
    PRIMARY KEY(numClub)
);

CREATE TABLE Utilisateur (
    numUtilisateur INT AUTO_INCREMENT,
    nom VARCHAR(40),
    prenom VARCHAR(40),
    adresse VARCHAR(120),
    login VARCHAR(20),
    motdepasse VARCHAR(40),
    numClub INT,
    PRIMARY KEY(numUtilisateur),
    FOREIGN KEY(numClub) REFERENCES Club(numClub)
);

CREATE TABLE Administrateur (
    numAdministrateur INT,
    dateDebut DATE,
    PRIMARY KEY(numAdministrateur),
    FOREIGN KEY(numAdministrateur) REFERENCES Utilisateur(numUtilisateur)
);

CREATE TABLE Directeur (
    numDirecteur INT,
    dateDebut DATE,
    numClub INT,
    PRIMARY KEY(numDirecteur, numClub),
    FOREIGN KEY(numDirecteur) REFERENCES Utilisateur(numUtilisateur),
    FOREIGN KEY(numClub) REFERENCES Club(numClub)
);


Create table Competiteur(
    numCompetiteur int,
    datePremiereParticipation date,
    PRIMARY KEY (numCompetiteur),
    FOREIGN KEY(numCompetiteur) REFERENCES Utilisateur(numUtilisateur)  
);

Create table President(
    numPresident int,
    prime int,
    PRIMARY KEY(numPresident),
    FOREIGN KEY(numPresident) REFERENCES Utilisateur(numUtilisateur)
);

Create table Evaluateur(
    numEvaluateur int,
    specialite varchar(20),
    PRIMARY KEY(numEvaluateur),
    FOREIGN KEY(numEvaluateur) REFERENCES Utilisateur(numUtilisateur)
);

Create table Concours(
    numConcours int AUTO_INCREMENT,
    theme varchar(20),
    dateDebut DATE,
    dateFin DATE,
    etat VARCHAR(20) CHECK (etat IN ('non commencé', 'en cours', 'en attente des résultats', 'terminé')),
    PRIMARY KEY(numConcours)
);


