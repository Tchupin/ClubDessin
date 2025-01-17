DROP TABLE IF EXISTS Jury;
DROP TABLE IF EXISTS ClubParticipe;
DROP TABLE IF EXISTS CompetiteurParticipe;
DROP TABLE IF EXISTS Evaluation;
DROP TABLE IF EXISTS Dessin;
DROP TABLE IF EXISTS President;
DROP TABLE IF EXISTS Concours;
DROP TABLE IF EXISTS Evaluateur;
DROP TABLE IF EXISTS Competiteur;
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
    age int,
    login VARCHAR(20),
    motdepasse VARCHAR(40),
    numClub INT,
    PRIMARY KEY(numUtilisateur),
    FOREIGN KEY(numClub) REFERENCES Club(numClub)
);

CREATE TABLE Administrateur (
    dateDebut DATE,
    numAdministrateur INT,
    PRIMARY KEY(numAdministrateur),
    FOREIGN KEY(numAdministrateur) REFERENCES Utilisateur(numUtilisateur)
);

CREATE TABLE Directeur (
    dateDebut DATE,
    numDirecteur INT,
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

Create table Evaluateur(
    specialite varchar(20),
    numEvaluateur int,
    PRIMARY KEY(numEvaluateur),
    FOREIGN KEY(numEvaluateur) REFERENCES Utilisateur(numUtilisateur)
);

Create table Concours(
    numConcours int AUTO_INCREMENT,
    theme varchar(100),
    dateDebut DATE,
    dateFin DATE,
    etat VARCHAR(20) CHECK (etat IN ('non commencé', 'en cours', 'en attente des résultats', 'terminé')),
    PRIMARY KEY(numConcours)
);

Create table President(
    prime int,
    numPresident int,
    numConcours int,
    
    PRIMARY KEY(numPresident,numConcours),
    FOREIGN KEY(numPresident) REFERENCES Utilisateur(numUtilisateur),
    FOREIGN KEY(numConcours) REFERENCES Concours(numConcours)
);

CREATE TABLE Dessin (
    numDessin INT AUTO_INCREMENT PRIMARY KEY,
    numCompetiteur INT,
    commentaire TEXT,
    classement INT,
    dateRemise DATE,
    leDessin TEXT,
    numConcours INT,
    FOREIGN KEY (numCompetiteur) REFERENCES Competiteur(numCompetiteur),
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
    FOREIGN KEY (numCompetiteur) REFERENCES Competiteur(numCompetiteur),
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
