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
    datePremiereParticipation date,
    numCompetiteur int,
    PRIMARY KEY (numCompetiteur,datePremiereParticipation),
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
    numEvaluateur1 INT,
    numEvaluateur2 INT,
    PRIMARY KEY (numDessin, numEvaluateur1,numEvaluateur2),
    FOREIGN KEY (numDessin) REFERENCES Dessin(numDessin),
    FOREIGN KEY (numEvaluateur1) REFERENCES Evaluateur(numEvaluateur),
    FOREIGN KEY (numEvaluateur2) REFERENCES Evaluateur(numEvaluateur)
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


/*      Commandes pour l'insertion dans la base de données */

/* Clubs */
INSERT INTO Club VALUES (1,'Angers Dessine', '14 Rue du Musée', '0250251193', 16, 'Angers', 'Maine-et-Loire', 'Pays de la Loire');
INSERT INTO Club VALUES (2, 'Paris Artistes', '12 Boulevard de la Republique', '0140253636', 10, 'Paris', 'Ile-de-France', 'France');
INSERT INTO Club VALUES (3, 'Paris Culture', '34 Avenue de lOpera', '0140259876', 10, 'Paris', 'Ile-de-France', 'France');
INSERT INTO Club VALUES (4, 'Lyon Creatif', '5 Rue de la Liberte', '0478526935', 15, 'Lyon', 'Rhone', 'Auvergne-Rhone-Alpes');
INSERT INTO Club VALUES (5, 'Marseille Express', '7 Boulevard des Docks', '0491514625', 14, 'Marseille', 'Bouches-du-Rhone', 'Provence-Alpes-Cote dAzur');
INSERT INTO Club VALUES (6, 'Toulouse Innovation', '13 Rue du Languedoc', '0561374859', 12, 'Toulouse', 'Haute-Garonne', 'Occitanie');
INSERT INTO Club VALUES (7, 'Nice Vision', '20 Avenue Jean Medecin', '0493887745', 10, 'Nice', 'Alpes-Maritimes', 'Provence-Alpes-Cote dAzur');
INSERT INTO Club VALUES (8, 'Lille Creations', '8 Place du General de Gaulle', '0320741865', 11, 'Lille', 'Nord', 'Hauts-de-France');
INSERT INTO Club VALUES (9, 'Bordeaux Fusion', '9 Rue Sainte-Catherine', '0556987453', 9, 'Bordeaux', 'Gironde', 'Nouvelle-Aquitaine');
INSERT INTO Club VALUES (10, 'Nantes Horizon', '6 Quai de la Fosse', '0240985643', 13, 'Nantes', 'Loire-Atlantique', 'Pays de la Loire');
INSERT INTO Club VALUES (11, 'Strasbourg Impressions', '15 Rue des Hallebardes', '0388246398', 9, 'Strasbourg', 'Bas-Rhin', 'Grand Est');
INSERT INTO Club VALUES (12, 'Rennes Art', '11 Rue de la Monnaie', '0299764825', 9, 'Rennes', 'Ille-et-Vilaine', 'Bretagne');
INSERT INTO Club VALUES (13, 'Grenoble Innovations', '3 Place Victor Hugo', '0476893274', 10, 'Grenoble', 'Isere', 'Auvergne-Rhone-Alpes');
INSERT INTO Club VALUES (14, 'Biarritz Créations', '12 Rue de la Plage', '0559421134', 12, 'Biarritz', 'Pyrénées-Atlantiques', 'Nouvelle-Aquitaine');
INSERT INTO Club VALUES (15, 'Madrid Creativo', '24 Calle Gran Via', '0912345678', 12, 'Madrid', 'Madrid', 'Espagne');
INSERT INTO Club VALUES (16, 'Rome Creativo', '15 Via del Corso', '0667432189', 10, 'Rome', 'Lazio', 'Italie');
INSERT INTO Club VALUES (17, 'Berlin Kultur', '9 Unter den Linden', '0305678987', 11, 'Berlin', 'Berlin', 'Allemagne');
INSERT INTO Club VALUES (18, 'London Ideas', '5 Oxford Street', '0207946123', 9, 'London', 'Greater London', 'Royaume-Uni');
INSERT INTO Club VALUES (19, 'Barcelona Vision', '21 La Rambla', '0934235678', 13, 'Barcelona', 'Catalunya', 'Espagne');
INSERT INTO Club VALUES (20, 'Lisbon Arts', '3 Rua Augusta', '0216754321', 9, 'Lisbon', 'Lisboa', 'Portugal');
INSERT INTO Club VALUES (21, 'Brussels Creativity', '18 Avenue Louise', '0279246701', 12, 'Brussels', 'Brussels-Capital', 'Belgique');
INSERT INTO Club VALUES (22, 'Amsterdam Design', '12 Damstraat', '0206347589', 9, 'Amsterdam', 'Noord-Holland', 'Pays-Bas');
INSERT INTO Club VALUES (23, 'Vienna Arts', '14 Ringstrasse', '0157543123', 10, 'Vienna', 'Wien', 'Autriche');
INSERT INTO Club VALUES (24, 'Zurich Art Space', '22 Bahnhofstrasse', '0441236789', 11, 'Zurich', 'Zurich', 'Suisse');
INSERT INTO Club VALUES (25, 'Tokyo Art', '7 Chome-1-2 Marunouchi', '0332168745', 14, 'Tokyo', 'Tokyo', 'Japon');
INSERT INTO Club VALUES (26, 'Seoul Vision', '10 Insadong-gil', '0276248976', 16, 'Seoul', 'Seoul', 'Coree du Sud');
INSERT INTO Club VALUES (27, 'Singapore Creatives', '25 Orchard Road', '0653657890', 15, 'Singapore', 'Singapore', 'Singapour');
INSERT INTO Club VALUES (28, 'Los Angeles Innovation', '3500 Wilshire Blvd', '3236583921', 13, 'Los Angeles', 'California', 'Etats-Unis');
INSERT INTO Club VALUES (29, 'New York Ideas', '45 Park Avenue', '2128564301', 11, 'New York', 'New York', 'Etats-Unis');
INSERT INTO Club VALUES (30, 'Buenos Aires Art', '100 Avenida 9 de Julio', '0114432178', 9, 'Buenos Aires', 'Ciudad Autonoma de Buenos Aires', 'Argentine');

/* Utilisateurs */

/* Angers 16 */
INSERT INTO Utilisateur VALUES (1, 'Duvaquier', 'Simon', '3 rue de la Rame', 28, 'sduvaquier', 'Vd29erS8', 1);
INSERT INTO Utilisateur VALUES (2, 'Lemoine', 'Pierre', '7 rue Saint-Aubin', 34, 'plemoine', 'Pwd39le@', 1);
INSERT INTO Utilisateur VALUES (3, 'Martin', 'Lucie', '12 place du Ralliement', 25, 'lmartin', 'Ml90&qs!', 1);
INSERT INTO Utilisateur VALUES (4, 'Durant', 'Camille', '9 rue de l’Esplanade', 22, 'cdurant', 'Cd87zxe#', 1);
INSERT INTO Utilisateur VALUES (5, 'Bernard', 'Julien', '14 avenue Patton', 30, 'jbernard', 'Jb45%iu9', 1);
INSERT INTO Utilisateur VALUES (6, 'Robert', 'Chloé', '25 rue Beaurepaire', 27, 'crobert', 'Cr33sV9!', 1);
INSERT INTO Utilisateur VALUES (7, 'Petit', 'Manon', '18 quai Félix Faure', 26, 'mpetit', 'Mp29Le@3', 1);
INSERT INTO Utilisateur VALUES (8, 'Dubois', 'Antoine', '10 rue des Lices', 33, 'adubois', 'Ad65!fx$', 1);
INSERT INTO Utilisateur VALUES (9, 'Moreau', 'Emma', '3 rue Toussaint', 24, 'emoreau', 'Em98Xs@2', 1);
INSERT INTO Utilisateur VALUES (10, 'Laurent', 'Nicolas', '6 boulevard Foch', 31, 'nlaurent', 'Nl44Pq&*', 1);
INSERT INTO Utilisateur VALUES (11, 'Simon', 'Sarah', '4 rue Saint-Julien', 29, 'ssimon', 'Ss77Kz!9', 1);
INSERT INTO Utilisateur VALUES (12, 'Michel', 'Alexandre', '22 rue d’Alsace', 35, 'amichel', 'Am93+ty$', 1);
INSERT INTO Utilisateur VALUES (13, 'Lefebvre', 'Claire', '19 rue Saint-Lazare', 28, 'clefebvre', 'Cl32Qx&*', 1);
INSERT INTO Utilisateur VALUES (14, 'Leroy', 'Hugo', '8 rue Voltaire', 32, 'hleroy', 'Hl56We@!', 1);
INSERT INTO Utilisateur VALUES (15, 'Roux', 'Alicia', '11 rue de la Roë', 24, 'aroux', 'Ar45%Gn$', 1);
INSERT INTO Utilisateur VALUES (16, 'Fournier', 'Baptiste', '20 rue des Carmes', 29, 'bfournier', 'Bf23Zx@', 1);

-- Paris Artistes 10 */
INSERT INTO Utilisateur VALUES (17, 'Durand', 'Clara', '25 Rue de la Paix', 22, 'cdurand', 'Xy28zYp7', 2);
INSERT INTO Utilisateur VALUES (18, 'Bernard', 'Paul', '30 Avenue des Champs-Élysées', 40, 'pbernard', 'Pa12Lm@4', 2);
INSERT INTO Utilisateur VALUES (19, 'Martin', 'Sophie', '45 Boulevard Haussmann', 34, 'smartin', 'Sm98Xy#1', 2);
INSERT INTO Utilisateur VALUES (20, 'Petit', 'Thomas', '12 Rue de Rivoli', 29, 'tpetit', 'Tp87Gh$!', 2);
INSERT INTO Utilisateur VALUES (21, 'Porkass', 'Julie', '22 Rue Saint-Honoré', 38, 'jporkass', 'Jl33Bn*7', 2);
INSERT INTO Utilisateur VALUES (22, 'Dubois', 'Camille', '15 Place de la Concorde', 27, 'cdubois', 'Cd55Lp!3', 2);
INSERT INTO Utilisateur VALUES (23, 'Moreau', 'Louis', '17 Rue de la Paix', 32, 'lmoreau', 'Lm42Tx@9', 2);
INSERT INTO Utilisateur VALUES (24, 'Laurent', 'Emma', '8 Rue de la Boétie', 24, 'elaurent', 'El67Qw#2', 2);
INSERT INTO Utilisateur VALUES (25, 'Simon', 'Lucas', '11 Rue de Belleville', 19, 'lsimon', 'Ls23Zx&8', 2);
INSERT INTO Utilisateur VALUES (26, 'Michel', 'Clara', '19 Rue de Lille', 33, 'cmichel', 'Cm34Kp$5', 2);

/* Paris Culture 8+2 */
INSERT INTO Utilisateur VALUES (27, 'Martin', 'Paul', '10 Avenue des Champs-Élysées', 35, 'pmartin', 'Df39lVq6', 3);
INSERT INTO Utilisateur VALUES (28, 'Dupont', 'Claire', '12 Rue de Rivoli', 29, 'cdupont', 'Fg78Lp@3', 3);
INSERT INTO Utilisateur VALUES (29, 'Petit', 'Louis', '15 Boulevard Saint-Michel', 26, 'lpetit', 'Hx56Zq&9', 3);
INSERT INTO Utilisateur VALUES (30, 'Morel', 'Julie', '8 Place Vendôme', 40, 'jmorel', 'Jl92Xp#5', 3);
INSERT INTO Utilisateur VALUES (31, 'Kardorim', 'Lucas', '25 Quai de la Tournelle', 32, 'lkardorim', 'Lm44Vp@1', 3);
INSERT INTO Utilisateur VALUES (32, 'Dubois', 'Emma', '18 Rue de la Paix', 27, 'edubois', 'Ed89Yt&7', 3);
INSERT INTO Utilisateur VALUES (33, 'Lemoine', 'Hugo', '10 Rue Saint-Honoré', 38, 'hlemoine', 'Hl33Mx#6', 3);
INSERT INTO Utilisateur VALUES (34, 'Simon', 'Camille', '20 Rue de Belleville', 31, 'csimon', 'Cs77Tx$4', 3);
INSERT INTO Utilisateur VALUES (341, 'Hermenier', 'Marie', '1 rue des Ordres', 24, 'mhermenier', '8nd7ngl', 3);


/* Lyon 15 */
INSERT INTO Utilisateur VALUES (35, 'Lemoine', 'Julien', '8 Rue de la République', 28, 'jlemoine', 'Jm28KbYp', 4);
INSERT INTO Utilisateur VALUES (36, 'Moreau', 'Alice', '12 Place Bellecour', 34, 'amoreau', 'Am45NvTp', 4);
INSERT INTO Utilisateur VALUES (37, 'Durand', 'Victor', '25 Quai de Saône', 29, 'vdurand', 'Vd78XyLp', 4);
INSERT INTO Utilisateur VALUES (38, 'Bernier', 'Sophie', '30 Avenue Jean Jaurès', 38, 'sbernier', 'Sb67PwZq', 4);
INSERT INTO Utilisateur VALUES (39, 'Fuji', 'Lucas', '15 Rue Garibaldi', 27, 'lfuji', 'Lp88KmYq', 4);
INSERT INTO Utilisateur VALUES (40, 'Fabre', 'Chloé', '9 Rue des Marronniers', 26, 'cfabre', 'Cf39LpVq', 4);
INSERT INTO Utilisateur VALUES (41, 'Chevalier', 'Maxime', '14 Boulevard des Brotteaux', 32, 'mchevalier', 'Mc44Xy@q', 4);
INSERT INTO Utilisateur VALUES (42, 'Marchand', 'Léa', '18 Rue Victor Hugo', 24, 'lmarchand', 'Lm89Pw@p', 4);
INSERT INTO Utilisateur VALUES (43, 'Roux', 'Hugo', '22 Rue de la Charité', 33, 'hroux', 'Hr56KvLp', 4);
INSERT INTO Utilisateur VALUES (44, 'Blanc', 'Emma', '28 Rue de la République', 30, 'eblanc', 'Eb77XmTp', 4);
INSERT INTO Utilisateur VALUES (45, 'Garnier', 'Bworker', '11 Place des Terreaux', 35, 'bgarnier', 'Ng33LpWq', 4);
INSERT INTO Utilisateur VALUES (46, 'Perrin', 'Camille', '6 Rue Paul Bert', 25, 'cperrin', 'Cp99XyMp', 4);
INSERT INTO Utilisateur VALUES (47, 'Lopez', 'Jennifer', '21 Quai Claude Bernard', 29, 'jenlopez', 'Jl44KmTp', 4);
INSERT INTO Utilisateur VALUES (48, 'Fontaine', 'Marie', '19 Boulevard des Etats-Unis', 37, 'mfontaine', 'Mf88Lp@q', 4);
INSERT INTO Utilisateur VALUES (49, 'Renard', 'Pauline', '13 Rue Édouard Herriot', 31, 'prenard', 'Pr55Xy@p', 4);

/* Marseille 14 */
INSERT INTO Utilisateur VALUES (50, 'Lefevre', 'Sophie', '15 Boulevard de la Libération', 29, 'slefevre', 'Tg94mFq3', 5);
INSERT INTO Utilisateur VALUES (51, 'Morel', 'Lucas', '8 Rue Saint-Ferréol', 33, 'lmorel', 'Lm72XqTp', 5);
INSERT INTO Utilisateur VALUES (52, 'Dupont', 'Emma', '22 Rue de la République', 27, 'edupont', 'Ed93YqLp', 5);
INSERT INTO Utilisateur VALUES (53, 'Lambert', 'Nathan', '12 Boulevard Longchamp', 31, 'nlambert', 'Nl84KmFp', 5);
INSERT INTO Utilisateur VALUES (54, 'Tournesol', 'Camille', '18 Avenue du Prado', 25, 'ctournesol', 'Cs56XyVp', 5);
INSERT INTO Utilisateur VALUES (55, 'Girard', 'Paul', '25 Quai de Rive Neuve', 30, 'pgirard', 'Pg77Lp@q', 5);
INSERT INTO Utilisateur VALUES (56, 'Morgane', 'Clara', '30 Rue Paradis', 34, 'cmorgane', 'Cm44PwZq', 5);
INSERT INTO Utilisateur VALUES (57, 'David', 'Thomas', '11 Place Castellane', 32, 'tdavid', 'Td99XqMp', 5);
INSERT INTO Utilisateur VALUES (58, 'Roche', 'Julie', '14 Rue Sainte', 28, 'jroche', 'Jr88KvFp', 5);
INSERT INTO Utilisateur VALUES (59, 'Fournier', 'Hugo', '10 Boulevard Chave', 26, 'hfournier', 'Hf55LpTp', 5);
INSERT INTO Utilisateur VALUES (60, 'Noel', 'Alice', '7 Rue d’Aubagne', 36, 'anoel', 'An33XyWq', 5);
INSERT INTO Utilisateur VALUES (61, 'Perrier', 'Maxime', '20 Boulevard Baille', 29, 'mperrier', 'Mp66Xq@p', 5);
INSERT INTO Utilisateur VALUES (62, 'Renault', 'Léa', '9 Avenue Jules Cantini', 24, 'lrenault', 'Lr44KmVp', 5);
INSERT INTO Utilisateur VALUES (63, 'Baron', 'Jules', '16 Rue de Rome', 35, 'jbaron', 'Jb89Lp@q', 5);

/* Toulouse 12 */
INSERT INTO Utilisateur VALUES (64, 'Bernard', 'Lucie', '17 Rue de la Rivière', 29, 'lbernard', 'Nq72HpB5', 6);
INSERT INTO Utilisateur VALUES (65, 'Giraud', 'Matthieu', '10 Rue du Taur', 33, 'mgiraud', 'Hg38XpL7', 6);
INSERT INTO Utilisateur VALUES (66, 'Marchand', 'Chloé', '22 Allée Jean Jaurès', 30, 'cmarchand', 'Cm92WpK3', 6);
INSERT INTO Utilisateur VALUES (67, 'Perrot', 'Louis', '15 Rue Lafayette', 27, 'lperrot', 'Lp56KmZ9', 6);
INSERT INTO Utilisateur VALUES (68, 'Aubry', 'Emma', '18 Place du Capitole', 25, 'eaubry', 'Ea44YqTp', 6);
INSERT INTO Utilisateur VALUES (69, 'Durieux', 'Thomas', '12 Rue Gambetta', 34, 'tdurieux', 'Td77LqVp', 6);
INSERT INTO Utilisateur VALUES (70, 'Blanc', 'Manon', '7 Boulevard Carnot', 31, 'mblanc', 'Mb33LpWp', 6);
INSERT INTO Utilisateur VALUES (71, 'Dumas', 'Lucas', '25 Avenue François Verdier', 32, 'ldumas', 'Ld88WpTp', 6);
INSERT INTO Utilisateur VALUES (72, 'Chevalier', 'Sophie', '14 Rue Saint-Rome', 28, 'schevalier', 'Sc66Xp@q', 6);
INSERT INTO Utilisateur VALUES (73, 'Leclerc', 'Nicolas', '30 Rue Alsace Lorraine', 30, 'nleclerc', 'Nl55YqLp', 6);
INSERT INTO Utilisateur VALUES (74, 'Bouvier', 'Alice', '9 Rue Pargaminières', 26, 'abouvier', 'Ab22KmFp', 6);
INSERT INTO Utilisateur VALUES (75, 'Guillot', 'Maxime', '11 Place Saint-Georges', 29, 'mguillot', 'Mg99XqWp', 6);

/* Nice 10 */
INSERT INTO Utilisateur VALUES (76, 'Pires', 'Antoine', '6 Place de la Madeleine', 23, 'apires', 'Uo21NxT9', 7);
INSERT INTO Utilisateur VALUES (77, 'Morel', 'Anitta', '12 Boulevard Victor Hugo', 22, 'amorel', 'Jm43TpN6', 7);
INSERT INTO Utilisateur VALUES (78, 'Roux', 'Pierre', '8 Rue Masséna', 21, 'proux', 'Pr85NxU4', 7);
INSERT INTO Utilisateur VALUES (79, 'Fouquet', 'Claire', '14 Avenue Jean Médecin', 19, 'cfouquet', 'Cf62VpW8', 7);
INSERT INTO Utilisateur VALUES (80, 'Dubois', 'Lucas', '19 Promenade des Anglais', 25, 'ldubois', 'Ld37XqP9', 7);
INSERT INTO Utilisateur VALUES (81, 'Girard', 'Sophie', '22 Rue de France', 20, 'sgirard', 'Sg94WpT7', 7);
INSERT INTO Utilisateur VALUES (82, 'Lemoine', 'Thomas', '11 Place Garibaldi', 24, 'tlemoine', 'Tl56YmL3', 7);
INSERT INTO Utilisateur VALUES (83, 'Brun', 'Emma', '25 Cours Saleya', 23, 'ebrun', 'Eb73NpF2', 7);
INSERT INTO Utilisateur VALUES (84, 'Lambert', 'Maxime', '30 Rue de la République', 22, 'mlambert', 'Ml88XqW5', 7);
INSERT INTO Utilisateur VALUES (85, 'Fontaine', 'Alice', '7 Avenue Félix Faure', 21, 'afontaine', 'Af21NmU6', 7);

/* Lille 11 */
INSERT INTO Utilisateur VALUES (86, 'Dupont', 'Yaroline', '3 Rue du Général de Gaulle', 18, 'ydupont', 'Lq67HfZ5', 8);
INSERT INTO Utilisateur VALUES (87, 'Leclercq', 'Jean', '5 Place Rihour', 19, 'jleclercq', 'Jq43NpY6', 8);
INSERT INTO Utilisateur VALUES (88, 'Dumont', 'Marie', '10 Rue Nationale', 17, 'mdumont', 'Md82WpT3', 8);
INSERT INTO Utilisateur VALUES (89, 'Flament', 'Luc', '12 Rue des Tanneurs', 16, 'lflament', 'Lf91XmQ8', 8);
INSERT INTO Utilisateur VALUES (90, 'Verhaeghe', 'Élise', '7 Rue de Béthune', 19, 'everhaeghe', 'Ev75KpL9', 8);
INSERT INTO Utilisateur VALUES (91, 'Desmet', 'Thomas', '18 Rue Gambetta', 18, 'tdesmet', 'Td38WpR2', 8);
INSERT INTO Utilisateur VALUES (92, 'Vanhee', 'Clara', '9 Avenue Foch', 17, 'cvanhee', 'Cv64NpW7', 8);
INSERT INTO Utilisateur VALUES (93, 'Bailleul', 'Maxime', '21 Boulevard de la Liberté', 16, 'mbailleul', 'Mb47LpX4', 8);
INSERT INTO Utilisateur VALUES (94, 'Delattre', 'Louise','3 Rue du Général de Gaulle', 54, 'ldelattre', 'Ld89QpN3', 8);
INSERT INTO Utilisateur VALUES (95, 'Capelle', 'Nicolas','7 Avenue Félix Faure', 58, 'ncapelle', 'Nc73XmV6', 8);
INSERT INTO Utilisateur VALUES (96, 'Hamelin', 'Sophie','8 Rue Masséna', 52, 'shamelin', 'Sh54WpT8', 8);

/* Bordeaux 9 */
INSERT INTO Utilisateur VALUES (97, 'Moreau', 'Juliette', '12 Rue de la Porte Cailhau', 18, 'jmoreau', 'Wr34XtL8', 9);
INSERT INTO Utilisateur VALUES (98, 'Blanc', 'Benoît', '14 Rue Sainte-Catherine', 19, 'bblanc', 'Bn45XtQ7', 9);
INSERT INTO Utilisateur VALUES (99, 'Ducasse', 'Claire','14 Rue Sainte-Catherine', 17, 'cducasse', 'Cd62LpW9', 9);
INSERT INTO Utilisateur VALUES (100, 'Laborde', 'Pierre','12 Rue de la Porte Cailhau', 16, 'plaborde', 'Pl83XpT6', 9);
INSERT INTO Utilisateur VALUES (101, 'Dubois', 'Xavier', '13 Place Graslin',55, 'xdubois', 'Ad71WpX3', 9);
INSERT INTO Utilisateur VALUES (102, 'Lemarr', 'Thomas', '13 Place Graslin',52, 'tlemarr', 'Tl58QpN4', 9);
INSERT INTO Utilisateur VALUES (103, 'Perrin', 'Élisa', '8 Allée des Tanneurs', 59, 'eperrin', 'Ep79NmY2', 9);
INSERT INTO Utilisateur VALUES (104, 'Guilhem', 'Nicolas', '14 Place Royale', 54, 'nguilhem', 'Ng63WpT5', 9);
INSERT INTO Utilisateur VALUES (105, 'Rouquette', 'Sophie','2 ile de la Kame House' ,50, 'srouquette', 'Sr82LmV8', 9);


/* Nantes 13 */
INSERT INTO Utilisateur VALUES (106, 'Son', 'Goku', '2 ile de la Kame House', 35, 'sgoku', 'Ej84HtD1', 10);
INSERT INTO Utilisateur VALUES (107, 'Beaupré', 'Louis', '14 Place Royale', 28, 'lbeaupre', 'Lk75HdQ9', 10);
INSERT INTO Utilisateur VALUES (108, 'Le Goff', 'Marie', '22 Rue Crébillon', 24, 'mlegoff', 'Mg62FtR3', 10);
INSERT INTO Utilisateur VALUES (109, 'Chauveau', 'Jean', '8 Allée des Tanneurs', 31, 'jchauveau', 'Jc49XpN7', 10);
INSERT INTO Utilisateur VALUES (110, 'Marchand', 'Anne', '30 Rue de la Juiverie', 26, 'amarchand', 'Am71KpT2', 10);
INSERT INTO Utilisateur VALUES (111, 'Poirier', 'Luc', '5 Rue du Château', 29, 'lpoirier', 'Lp83RmL6', 10);
INSERT INTO Utilisateur VALUES (112, 'Leclerc', 'Pauline', '17 Quai Turenne', 33, 'pleclerc', 'Pl67QxN4', 10);
INSERT INTO Utilisateur VALUES (113, 'Morin', 'Julien', '9 Rue de Strasbourg', 27, 'jmorin', 'Jm58VpT5', 10);
INSERT INTO Utilisateur VALUES (114, 'Renault', 'Sophie', '11 Rue du Roi Albert', 30, 'srenault', 'Sr76NmY8', 10);
INSERT INTO Utilisateur VALUES (115, 'Garnier', 'Nicolas', '13 Place Graslin', 32, 'ngarnier', 'Ng72WpR3', 10);
INSERT INTO Utilisateur VALUES (116, 'Bodet', 'Claire', '20 Cours Cambronne', 25, 'cbodet', 'Cb81LmT9', 10);
INSERT INTO Utilisateur VALUES (117, 'Fournier', 'Thomas', '6 Rue des Carmes', 34, 'tfournier', 'Tf93XnP2', 10);
INSERT INTO Utilisateur VALUES (118, 'Guyon', 'Elisa', '3 Rue Paul Bellamy', 27, 'eguyon', 'Eg89FtV7', 10);

/* Strasbourg 7+2 */
INSERT INTO Utilisateur VALUES (119, 'Guerin', 'Marie', '4 Rue de la Mésange', 26, 'mguerin', 'Vf39WbH2', 11);
INSERT INTO Utilisateur VALUES (120, 'Schmitt', 'Antoine', '12 Rue de la Lanterne', 28, 'aschmitt', 'Ae72XpT9', 11);
INSERT INTO Utilisateur VALUES (121, 'Hoffmann', 'Sophie', '9 Place de la République', 30, 'shoffmann', 'Sh67VdJ1', 11);
INSERT INTO Utilisateur VALUES (122, 'Ougah', 'Léa', '14 Rue des Juifs', 24, 'lougah', 'Lm42DpK5', 11);
INSERT INTO Utilisateur VALUES (123, 'Becker', 'Paul', '20 Rue des Grandes Arcades', 32, 'pbecker', 'Pb81FqM4', 11);
INSERT INTO Utilisateur VALUES (124, 'Klein', 'Élisabeth', '3 Boulevard de la Victoire', 27, 'eklein', 'Ek56NsV8', 11);
INSERT INTO Utilisateur VALUES (125, 'Dufresne', 'Jacques', '7 Rue du Vieil Hôpital', 35, 'jdufresne', 'Jd93RmL2', 11);
INSERT INTO Utilisateur VALUES (342, 'Frizz', 'Missiz', '2 rue de la Bourgade', 29, 'mfrizz', 'Pee38uXl', 11);
INSERT INTO Utilisateur VALUES (343, 'Eggob', 'Docteur', '3 place Otomai', 38, 'deggob', 'Byvv3Er', 11);

/* Rennes 9 */
INSERT INTO Utilisateur VALUES (126, 'Joubert', 'Alice', '18 Rue de la Monnaie', 17, 'ajoubert', 'Cv29DfL1', 12);
INSERT INTO Utilisateur VALUES (127, 'Lemoine', 'Benoît', '25 Rue de la Parcheminerie', 19, 'blemoine', 'Bp84RzQ7', 12);
INSERT INTO Utilisateur VALUES (128, 'Leclerc', 'Claire', '13 Place Sainte-Anne', 16, 'cleclerc', 'Cl57VzT2', 12);
INSERT INTO Utilisateur VALUES (129, 'Bertrand', 'Julien', '19 Rue de la Chalotais', 18, 'jbertrand', 'Jb33KxM5', 12);
INSERT INTO Utilisateur VALUES (130, 'Dufresne', 'Nicolas', '22 Boulevard de la Liberté', 15, 'ndufresne', 'Nd64FdP1', 12);
INSERT INTO Utilisateur VALUES (131, 'Leconte', 'Sophie', '11 Rue de la Monnaie', 14, 'sleconte', 'Sl87GbQ3', 12);
INSERT INTO Utilisateur VALUES (132, 'Guerin', 'Pichon', '5 Rue de la Visitation', 19, 'pguerin', 'Mg50DgJ9', 12);
INSERT INTO Utilisateur VALUES (133, 'Benoît', 'Audrey', '14 Rue de la Fontaine', 13, 'abenoit', 'Ab61WjH4', 12);
INSERT INTO Utilisateur VALUES (134, 'Vasseur', 'Luc', '9 Rue de la Vieille-Draperie', 12, 'lvasseur', 'Lv23HpT2', 12);

/* Grenoble 10 */
INSERT INTO Utilisateur VALUES (135, 'Roche', 'Etienne', '5 Rue des Alpes', 25, 'eroches', 'Mk20VfT7', 13);
INSERT INTO Utilisateur VALUES (136, 'Lemoine', 'Marion', '14 Rue des Tuiles', 27, 'mlemoine', 'Ml37WtR2', 13);
INSERT INTO Utilisateur VALUES (137, 'Perrot', 'Maxime', '3 Boulevard de Mort', 24, 'mperrot', 'Mp56GzF3', 13);
INSERT INTO Utilisateur VALUES (138, 'Mercier', 'Nathalie', '21 Avenue Foch', 30, 'nmercier', 'Nm42CpB8', 13);
INSERT INTO Utilisateur VALUES (139, 'Faure', 'Léa', '9 Rue Saint-Jacques', 23, 'lfaure', 'Lf67VhW1', 13);
INSERT INTO Utilisateur VALUES (140, 'Vidal', 'Pierre', '16 Rue de la Perdrerie', 29, 'pvidal', 'Pv28QkT5', 13);
INSERT INTO Utilisateur VALUES (141, 'Durand', 'Philippe', '11 Place Verdun', 22, 'pdurand', 'Pd52YhM9', 13);
INSERT INTO Utilisateur VALUES (142, 'Gauthier', 'Hélène', '27 Rue des Trois Dauphins', 28, 'hgauthier', 'Hg29RbF4', 13);
INSERT INTO Utilisateur VALUES (143, 'Pires', 'Sébastien', '18 Rue Victor Hugo', 26, 'spires', 'Sp12JbR6', 13);
INSERT INTO Utilisateur VALUES (144, 'Blanc', 'Chloé', '4 Rue des Capucins', 24, 'cblanc', 'Cb30QwG7', 13);

/* Biarritz 16 */
INSERT INTO Utilisateur VALUES (145, 'Saperlipopette', 'Chloé', '1 Rue de la Plage', 22, 'cdupuis', 'Qp82KrT5', 14);
INSERT INTO Utilisateur VALUES (146, 'Ithurbide', 'Jean', '2 Boulevard de la Côte', 24, 'jithurbide', 'Ji45HuR8', 14);
INSERT INTO Utilisateur VALUES (147, 'Mendibil', 'Mikel', '3 Rue du Lac', 23, 'mmendibil', 'Mm57KrJ9', 14);
INSERT INTO Utilisateur VALUES (148, 'Etxebarria', 'Ane', '4 Rue des Quatre Vents', 21, 'aetxebarria', 'Ae64FwT2', 14);
INSERT INTO Utilisateur VALUES (149, 'Garcia', 'Koldo', '5 Avenue de la Mer', 25, 'kgarcia', 'Kg58VxM3', 14);
INSERT INTO Utilisateur VALUES (150, 'Aranburu', 'Amaia', '6 Place de la Liberté', 20, 'aaranburu', 'Aa39BzP7', 14);
INSERT INTO Utilisateur VALUES (151, 'Uribe', 'Igor', '7 Rue de la Paix', 22, 'iuribe', 'Iu41LpQ6', 14);
INSERT INTO Utilisateur VALUES (152, 'Zabala', 'Lourdes', '8 Rue de la Plage', 24, 'lzabala', 'Lz55GjR1', 14);
INSERT INTO Utilisateur VALUES (153, 'Etxeberria', 'Joaquín', '9 Boulevard des Plages', 23, 'jetxeberria', 'Je62HxW4', 14);
INSERT INTO Utilisateur VALUES (154, 'Lopez', 'Nerea', '10 Rue du Soleil', 25, 'nlopez', 'Nl23BtV9', 14);
INSERT INTO Utilisateur VALUES (155, 'Olabarria', 'Xabier', '11 Avenue des Cèdres', 21, 'xolabarria', 'Xo19FwS5', 14);
INSERT INTO Utilisateur VALUES (156, 'Bordagaray', 'Maite', '12 Rue des Océans', 22, 'mbordagaray', 'Mb44VzY8', 14);
INSERT INTO Utilisateur VALUES (157, 'Larralde', 'Pello', '13 Rue des Alizés', 23, 'plarralde', 'Pl55XkT3', 14);
INSERT INTO Utilisateur VALUES (158, 'Goikoetxea', 'Maider', '14 Rue des Vagues', 24, 'mgoikoetxea', 'Mg29PvL2', 14);
INSERT INTO Utilisateur VALUES (159, 'Arozena', 'Aitor', '15 Rue de la Dune', 22, 'aarozena', 'Aa36LwZ7', 14);
INSERT INTO Utilisateur VALUES (160, 'Santos', 'Zurine', '16 Rue des Pins', 23, 'zsantos', 'Zs41MtP4', 14);


/* Madrid 12 */
INSERT INTO Utilisateur VALUES (161, 'Sanchez', 'Carlos', '21 Calle Mayor', 26, 'csanchez', 'Fn39TxP6', 15);
INSERT INTO Utilisateur VALUES (162, 'González', 'María', '22 Calle Gran Vía', 28, 'mgonzalez', 'Mg67KlY1', 15);
INSERT INTO Utilisateur VALUES (163, 'Martínez', 'Luis', '23 Plaza Mayor', 27, 'lmartinez', 'Lm89JvR4', 15);
INSERT INTO Utilisateur VALUES (164, 'Rodríguez', 'Ana', '24 Avenida de América', 30, 'arodriguez', 'Ar21ZkV9', 15);
INSERT INTO Utilisateur VALUES (165, 'López', 'Juan', '25 Calle de Alcalá', 29, 'jlopez', 'Jp72QmA3', 15);
INSERT INTO Utilisateur VALUES (166, 'Hernández', 'Sofía', '26 Paseo del Prado', 24, 'shernandez', 'Sh34XpB7', 15);
INSERT INTO Utilisateur VALUES (167, 'García', 'Antonio', '27 Plaza de Cibeles', 30, 'agarcia', 'Ag23MzT2', 15);
INSERT INTO Utilisateur VALUES (168, 'Pérez', 'Isabel', '28 Calle de Serrano', 28, 'iperez', 'Ip98AkP1', 15);
INSERT INTO Utilisateur VALUES (169, 'Martín', 'Carlos', '29 Avenida de la Castellana', 25, 'cmartin', 'Cm52LwT5', 15);
INSERT INTO Utilisateur VALUES (170, 'Fernández', 'Claudia', '30 Calle del Marqués de Riscal', 27, 'cfernandez', 'Cf67JdW8', 15);
INSERT INTO Utilisateur VALUES (171, 'Sanchez', 'Pedro', '31 Calle de Gran Vía', 26, 'psanchez', 'Pj74BzV3', 15);
INSERT INTO Utilisateur VALUES (172, 'Jiménez', 'Marta', '32 Plaza de España', 25, 'mjimenez', 'Mj52JbH6', 15);

/* Rome 10 */
INSERT INTO Utilisateur VALUES (173, 'Bianchi', 'Giulia', '30 Via del Corso', 26, 'gbianchi', 'Bs58OpV7', 16);
INSERT INTO Utilisateur VALUES (174, 'Verratti', 'Marco', '31 Via Nazionale', 27, 'mrossi', 'Mr62GpH4', 16);
INSERT INTO Utilisateur VALUES (175, 'Russo', 'Laura', '32 Piazza di Spagna', 25, 'lrusso', 'Lr45JdS1', 16);
INSERT INTO Utilisateur VALUES (176, 'Giordano', 'Alessandro', '33 Via Veneto', 28, 'agiordano', 'Ag23NzT2', 16);
INSERT INTO Utilisateur VALUES (177, 'Conti', 'Francesca', '34 Via del Tritone', 30, 'fconti', 'Fc58LwB3', 16);
INSERT INTO Utilisateur VALUES (178, 'Moretti', 'Luca', '35 Piazza Navona', 27, 'lmoretti', 'Lm87QsK6', 16);
INSERT INTO Utilisateur VALUES (179, 'Corleone', 'Vito', '36 Via del Quirinale', 29, 'gdeluca', 'Gd99FpJ5', 16);
INSERT INTO Utilisateur VALUES (180, 'Esposito', 'Stefano', '37 Via dei Fori Imperiali', 30, 'sesposito', 'Sx11QmC8', 16);
INSERT INTO Utilisateur VALUES (181, 'Bianchi', 'Emanuele', '38 Piazza del Popolo', 28, 'emabianchi', 'Eb34KmZ9', 16);
INSERT INTO Utilisateur VALUES (182, 'Ferrari', 'Alessia', '39 Via della Conciliazione', 25, 'aferrari', 'Af66RzW2', 16);

/* Berlin 11 */
INSERT INTO Utilisateur VALUES (183, 'Muller', 'Thomas', '15 Unter den Linden', 30, 'lschmidt', 'Fd70TxJ3', 17);
INSERT INTO Utilisateur VALUES (184, 'Neuer', 'Manuel', '17 Unter den Linden', 32, 'mneuer', 'Kw29AxP6', 17);
INSERT INTO Utilisateur VALUES (185, 'Götze', 'Mario', '19 Unter den Linden', 28, 'mgoetze', 'Zl37HpK2', 17);
INSERT INTO Utilisateur VALUES (186, 'Hummels', 'Mats', '21 Unter den Linden', 33, 'mhummels', 'Vp94HgY9', 17);
INSERT INTO Utilisateur VALUES (187, 'Kimmich', 'Joshua', '23 Unter den Linden', 26, 'jkimmich', 'Wy56DlO3', 17);
INSERT INTO Utilisateur VALUES (188, 'Reus', 'Marco', '25 Unter den Linden', 31, 'mreus', 'Er84CtJ1', 17);
INSERT INTO Utilisateur VALUES (189, 'Ozil', 'Mesut', '27 Unter den Linden', 34, 'mozil', 'Uv92EqW7', 17);
INSERT INTO Utilisateur VALUES (190, 'Sane', 'Leroy', '29 Unter den Linden', 27, 'lsane', 'Lf28ErG6', 17);
INSERT INTO Utilisateur VALUES (191, 'Bender', 'Lars', '31 Unter den Linden', 35, 'lbender', 'Rd57VoL8', 17);
INSERT INTO Utilisateur VALUES (192, 'Podolski', 'Lukas', '33 Unter den Linden', 36, 'lpodolski', 'Tz46JfB9', 17);
INSERT INTO Utilisateur VALUES (193, 'Schürrle', 'André', '35 Unter den Linden', 32, 'aschurrle', 'Fd71TwX0', 17);

/* London 9 */
INSERT INTO Utilisateur VALUES (194, 'Morris', 'Emily', '7 Oxford Street', 29, 'emorris', 'Lp89KvQ6', 18);
INSERT INTO Utilisateur VALUES (195, 'Bronze', 'Lucy', '9 Oxford Street', 28, 'lbronze', 'Jd57GtL3', 18);
INSERT INTO Utilisateur VALUES (196, 'Kelly', 'Chloe', '11 Oxford Street', 27, 'ckelly', 'Vs62FnK7', 18);
INSERT INTO Utilisateur VALUES (197, 'Parris', 'Nikita', '13 Oxford Street', 30, 'nparris', 'Rf83BpV9', 18);
INSERT INTO Utilisateur VALUES (198, 'Houghton', 'Steph', '15 Oxford Street', 31, 'shoughton', 'Ty56UbJ5', 18);
INSERT INTO Utilisateur VALUES (199, 'Williamson', 'Leah', '17 Oxford Street', 28, 'lwilliamson', 'Qw71KnP4', 18);
INSERT INTO Utilisateur VALUES (200, 'Scott', 'Jill', '19 Oxford Street', 32, 'jscott', 'Mb37WxH2', 18);
INSERT INTO Utilisateur VALUES (201, 'Mead', 'Beth', '21 Oxford Street', 26, 'bmead', 'Nq68ZbD0', 18);
INSERT INTO Utilisateur VALUES (202, 'Kirby', 'Fran', '23 Oxford Street', 27, 'fkirby', 'Hp84TbW6', 18);

/* Barcelona 13 */
INSERT INTO Utilisateur VALUES (203, 'Messi', 'Lionel', '22 La Rambla', 35, 'mlopez', 'Vt82ReP4', 19);
INSERT INTO Utilisateur VALUES (204, 'Messi', 'Thiago', '24 La Rambla', 33, 'tlopez', 'Cr92UtG3', 19);
INSERT INTO Utilisateur VALUES (205, 'Neymar', 'Jr', '26 La Rambla', 31, 'jneymar', 'Wz37XhS9', 19);
INSERT INTO Utilisateur VALUES (206, 'Suarez', 'Luis', '28 La Rambla', 34, 'lsuarez', 'Uv65NyQ8', 19);
INSERT INTO Utilisateur VALUES (207, 'Messi', 'Matias', '30 La Rambla', 32, 'mmatias', 'Lw43XpT1', 19);
INSERT INTO Utilisateur VALUES (208, 'Neymar', 'Thiago', '32 La Rambla', 29, 'tneymar', 'Hp77JzP5', 19);
INSERT INTO Utilisateur VALUES (209, 'Suarez', 'Santiago', '34 La Rambla', 27, 'ssuarez', 'Vq25XkW2', 19);
INSERT INTO Utilisateur VALUES (210, 'Messi', 'Maximiliano', '36 La Rambla', 28, 'mmessi', 'Fg48BtQ7', 19);
INSERT INTO Utilisateur VALUES (211, 'Neymar', 'Lucas', '38 La Rambla', 30, 'lneymar', 'Ex19KjF4', 19);
INSERT INTO Utilisateur VALUES (212, 'Suarez', 'Carlos', '40 La Rambla', 33, 'csuarez', 'Te57KwB3', 19);
INSERT INTO Utilisateur VALUES (213, 'Messi', 'Javier', '42 La Rambla', 34, 'jmessi', 'Qu16YpL0', 19);
INSERT INTO Utilisateur VALUES (214, 'Neymar', 'Rafael', '44 La Rambla', 29, 'rneymar', 'Dw90VxT2', 19);
INSERT INTO Utilisateur VALUES (215, 'Suarez', 'Fernando', '46 La Rambla', 32, 'fsuarez', 'Mt56RdS5', 19);

/* Lisbon 8+1 */
INSERT INTO Utilisateur VALUES (216, 'Costa', 'Pedro', '9 Rua Augusta', 30, 'pcosta', 'Yt43RjK7', 20);
INSERT INTO Utilisateur VALUES (217, 'Ronaldo', 'Cristiano', '11 Rua Augusta', 38, 'cronaldo', 'Gp92TnV3', 20);
INSERT INTO Utilisateur VALUES (218, 'Penaldo', 'Ricardo', '13 Rua Augusta', 29, 'rpenaldo', 'Hv56BzT2', 20);
INSERT INTO Utilisateur VALUES (219, 'Ronaldo', 'Geovani', '15 Rua Augusta', 32, 'gronaldo', 'Fw82JpS4', 20);
INSERT INTO Utilisateur VALUES (220, 'Penaldo', 'João', '17 Rua Augusta', 27, 'jpenaldo', 'Kt69LvQ8', 20);
INSERT INTO Utilisateur VALUES (221, 'Ronaldo', 'Fernando', '19 Rua Augusta', 28, 'fronaldo', 'Zn84YpJ1', 20);
INSERT INTO Utilisateur VALUES (222, 'Penaldo', 'Tiago', '21 Rua Augusta', 26, 'tpenaldo', 'Xy58RaF6', 20);
INSERT INTO Utilisateur VALUES (223, 'Ronaldo', 'Antonio', '23 Rua Augusta', 29, 'aronaldo', 'Rm74KlL0', 20);
INSERT INTO Utilisateur VALUES (344, 'Ronaldo', 'Zentorno', '26 Rua Augusta', 25, 'zronaldo', 'Kr28FGc0', 20);

/* Brussels 12 */
INSERT INTO Utilisateur VALUES (224, 'Van der Merwe', 'Elsa', '14 Avenue Louise', 21, 'evandermerwe', 'Rp58MhT2', 21);
INSERT INTO Utilisateur VALUES (225, 'Hazard', 'Eden', '22 Avenue Louise', 21, 'ehazard', 'Gp73BxS5', 21);
INSERT INTO Utilisateur VALUES (226, 'De Bruyne', 'Kevin', '24 Avenue Louise', 21, 'kdebruyne', 'Mk91NtJ2', 21);
INSERT INTO Utilisateur VALUES (227, 'Lukaku', 'Romelu', '26 Avenue Louise', 21, 'rlukaku', 'Xn54FqT7', 21);
INSERT INTO Utilisateur VALUES (228, 'Courtois', 'Thibaut', '28 Avenue Louise', 21, 'tcourtois', 'Av85FwQ4', 21);
INSERT INTO Utilisateur VALUES (229, 'Mertens', 'Dries', '30 Avenue Louise', 21, 'dmertens', 'Hv66LdJ1', 21);
INSERT INTO Utilisateur VALUES (230, 'Dupont', 'Marc', '32 Avenue Louise', 21, 'mdupont', 'Gf22TkL8', 21);
INSERT INTO Utilisateur VALUES (231, 'Lemoine', 'Claire', '34 Avenue Louise', 21, 'clemoine', 'Dq39XvJ0', 21);
INSERT INTO Utilisateur VALUES (232, 'Dumont', 'Luc', '36 Avenue Louise', 21, 'ldumont', 'Kh51HjQ3', 21);
INSERT INTO Utilisateur VALUES (233, 'Boone', 'Isabelle', '38 Avenue Louise', 21, 'iboone', 'Qp23JbW9', 21);
INSERT INTO Utilisateur VALUES (234, 'Renard', 'Thierry', '40 Avenue Louise', 21, 'trenard', 'Vt47NzH1', 21);
INSERT INTO Utilisateur VALUES (235, 'Martin', 'François', '42 Avenue Louise', 21, 'fmartin', 'Jz18MpB5', 21);

/* Amsterdam 7+2 */
INSERT INTO Utilisateur VALUES (236, 'Janssen', 'Hugo', '17 Damstraat', 22, 'hjanssen', 'Nz39FiP5', 22);
INSERT INTO Utilisateur VALUES (237, 'Ziyech', 'Hakim', '19 Damstraat', 22, 'hziyech', 'Rj72GhU4', 22);
INSERT INTO Utilisateur VALUES (238, 'Tadic', 'Dusan', '21 Damstraat', 22, 'dtadic', 'Ku84NxW3', 22);
INSERT INTO Utilisateur VALUES (239, 'Onana', 'Andre', '23 Damstraat', 22, 'aonana', 'Lg67TrF9', 22);
INSERT INTO Utilisateur VALUES (240, 'Blind', 'Daley', '25 Damstraat', 22, 'dblind', 'Dp39HzM7', 22);
INSERT INTO Utilisateur VALUES (241, 'Klaassen', 'Davy', '27 Damstraat', 22, 'dklaassen', 'Zv23PjQ6', 22);
INSERT INTO Utilisateur VALUES (242, 'Labyad', 'Zakaria', '29 Damstraat', 22, 'zlabyad', 'He48UvB1', 22);
INSERT INTO Utilisateur VALUES (345, 'Park', 'Chaewon', '78 Damstraat', 22, 'pchaewon', '9dzij2d', 22);
INSERT INTO Utilisateur VALUES (346, 'Harebourg', 'Comte', '15 Damstraat', 22, 'charebourg', 'Fr1g05t', 22);

/* Vienna 10 */
INSERT INTO Utilisateur VALUES (243, 'Schuster', 'Anna', '2 Ringstrasse', 23, 'aschuster', 'Wx52VsB8', 23);
INSERT INTO Utilisateur VALUES (244, 'Hofer', 'Johann', '4 Ringstrasse', 23, 'jhofer', 'Nc58WsY7', 23);
INSERT INTO Utilisateur VALUES (245, 'Kaiser', 'Friedrich', '6 Ringstrasse', 23, 'fkaiser', 'Pk93GmV2', 23);
INSERT INTO Utilisateur VALUES (246, 'Habsburg', 'Karl', '8 Ringstrasse', 23, 'khabsburg', 'Xz47PwC1', 23);
INSERT INTO Utilisateur VALUES (247, 'Linz', 'Matthias', '10 Ringstrasse', 23, 'mlinz', 'Os22FnD5', 23);
INSERT INTO Utilisateur VALUES (248, 'Waldner', 'Klaus', '12 Ringstrasse', 23, 'kwaldner', 'Dt58UbV3', 23);
INSERT INTO Utilisateur VALUES (249, 'Bismarck', 'Otto', '14 Ringstrasse', 23, 'obismarck', 'Lv91WrE4', 23);
INSERT INTO Utilisateur VALUES (250, 'Kraft', 'Elisabeth', '16 Ringstrasse', 23, 'ekraft', 'Hp76GwT2', 23);
INSERT INTO Utilisateur VALUES (251, 'Eisenstein', 'Adelaide', '18 Ringstrasse', 23, 'aeisenstein', 'Kr82JwV5', 23);
INSERT INTO Utilisateur VALUES (252, 'Schwarz', 'Margarethe', '20 Ringstrasse', 23, 'mschwarz', 'St50LxP1', 23);

/* Zurich 11 */
INSERT INTO Utilisateur VALUES (253, 'Meier', 'Sven', '8 Bahnhofstrasse', 24, 'smeier', 'Vo29KxZ4', 24);
INSERT INTO Utilisateur VALUES (254, 'Müller', 'Tobias', '10 Bahnhofstrasse', 24, 'tmuller', 'Ua68ZjD3', 24);
INSERT INTO Utilisateur VALUES (255, 'Schneider', 'Lena', '12 Bahnhofstrasse', 24, 'lschneider', 'Mn57KvS2', 24);
INSERT INTO Utilisateur VALUES (256, 'Fischer', 'Hannah', '14 Bahnhofstrasse', 24, 'hfischer', 'Ez31LpN8', 24);
INSERT INTO Utilisateur VALUES (257, 'Zimmermann', 'Lukas', '16 Bahnhofstrasse', 24, 'lzimmermann', 'Gt92FwP6', 24);
INSERT INTO Utilisateur VALUES (258, 'Wagner', 'Nina', '18 Bahnhofstrasse', 24, 'nwagner', 'Dp49JkZ5', 24);
INSERT INTO Utilisateur VALUES (259, 'Hoffmann', 'Xilovya', '20 Bahnhofstrasse', 24, 'xhoffmann', 'Qx70RmA1', 24);
INSERT INTO Utilisateur VALUES (260, 'Bauer', 'Marie', '22 Bahnhofstrasse', 24, 'mbauer', 'Xb56JwL9', 24);
INSERT INTO Utilisateur VALUES (261, 'Keller', 'Markus', '24 Bahnhofstrasse', 24, 'mkeller', 'Qd83VrP4', 24);
INSERT INTO Utilisateur VALUES (262, 'Weber', 'Sarah', '26 Bahnhofstrasse', 24, 'sweber', 'Uk58FhD7', 24);
INSERT INTO Utilisateur VALUES (263, 'Lang', 'Peter', '28 Bahnhofstrasse', 24, 'plang', 'Ht22FzQ3', 24);

/* Tokyo 14 */
INSERT INTO Utilisateur VALUES (264, 'Tanaka', 'Hiroshi', '5 Chome-2-1 Shibuya', 25, 'htanaka', 'Vj39LzP7', 25);
INSERT INTO Utilisateur VALUES (265, 'Sato', 'Yuri', '7 Chome-3-2 Shibuya', 25, 'ysato', 'Kb91PxV6', 25);
INSERT INTO Utilisateur VALUES (266, 'Takahashi', 'Keiko', '8 Chome-1-4 Shibuya', 25, 'ktakahashi', 'Fr78BpN2', 25);
INSERT INTO Utilisateur VALUES (267, 'MonkeyD', 'Ruffy', '4 rue du Japon', 25, 'mruffy', 'RdPoPnJ', 25);
INSERT INTO Utilisateur VALUES (268, 'Watanabe', 'Yuki', '3 Chome-4-7 Shibuya', 25, 'ywatanabe', 'Jk52LhD9', 25);
INSERT INTO Utilisateur VALUES (269, 'Kobayashi', 'Miyuki', '2 Chome-6-3 Shibuya', 25, 'mkobayashi', 'Gn24SkM5', 25);
INSERT INTO Utilisateur VALUES (270, 'Yamamoto', 'Sakura', '6 Chome-1-2 Shibuya', 25, 'syamamoto', 'Lx84RaB1', 25);
INSERT INTO Utilisateur VALUES (271, 'Kageyama', 'Tobio', '6 Chome-9-3 Karasuno', 25, 'tkageyama', 'Hr84ZwK1', 25);
INSERT INTO Utilisateur VALUES (272, 'Inoue', 'Honoka', '4 Chome-2-9 Shibuya', 25, 'hinoue', 'Vw20PjQ8', 25);
INSERT INTO Utilisateur VALUES (273, 'Kimura', 'Haruto', '1 Chome-7-4 Shibuya', 25, 'hkimura', 'Zy65AfJ2', 25);
INSERT INTO Utilisateur VALUES (274, 'Uchiha', 'Sasuke', '1 Chome-3-5 Konoha', 25, 'suchiha', 'Fq84HnP1', 25);
INSERT INTO Utilisateur VALUES (275, 'Naruto', 'Uzumaki', '2 Chome-1-9 Konoha', 25, 'nuzumaki', 'Gp90TjQ3', 25);
INSERT INTO Utilisateur VALUES (276, 'Haruno', 'Sakura', '3 Chome-5-6 Konoha', 25, 'hsakura', 'Cn51BdL7', 25);
INSERT INTO Utilisateur VALUES (277, 'Uchiha', 'Madara', '4 Chome-2-4 Konoha', 25, 'muchiha', 'Wx76ZnR2', 25);


/* Seoul 16 */
INSERT INTO Utilisateur VALUES (278, 'Kim', 'Jiwon', '10 Insadong-gil', 25, 'jkim', 'Bq20XsD8', 26);
INSERT INTO Utilisateur VALUES (279, 'Park', 'Somi', '11 Hongdae', 27, 'somipark', 'Gh39LpK1', 26);
INSERT INTO Utilisateur VALUES (280, 'Choi', 'Seohyun', '12 Itaewon', 30, 'seohyunchoi', 'Yn71VmW3', 26);
INSERT INTO Utilisateur VALUES (281, 'Lee', 'Yuna', '13 Gangnam-gu', 23, 'yunalee', 'Hq47NzT8', 26);
INSERT INTO Utilisateur VALUES (282, 'Jeon', 'Jiwon', '14 Sinchon', 32, 'jiwonjeon', 'Vm54UrP6', 26);
INSERT INTO Utilisateur VALUES (283, 'Jung', 'Jisoo', '15 Myeongdong', 29, 'jisoojung', 'Kb61WsY2', 26);
INSERT INTO Utilisateur VALUES (284, 'Yang', 'Soyeon', '16 Seongnae-dong', 26, 'soyeonyang', 'Xp82LyW7', 26);
INSERT INTO Utilisateur VALUES (285, 'Ahn', 'Yerin', '17 Gwanghwamun', 28, 'yerinahn', 'Za39BcP4', 26);
INSERT INTO Utilisateur VALUES (286, 'Lim', 'Eunha', '18 Apgujeong', 24, 'eunhalim', 'Mr82FzJ3', 26);
INSERT INTO Utilisateur VALUES (287, 'Kim', 'Yeri', '19 Dongdaemun', 31, 'yerikim', 'Uq71HkP5', 26);
INSERT INTO Utilisateur VALUES (288, 'Choi', 'Jiwon', '20 Cheongdam-dong', 27, 'jiwonchoi', 'Wm41LdB6', 26);
INSERT INTO Utilisateur VALUES (289, 'Son', 'Somin', '21 Han River Park', 33, 'sominson', 'Tq69PrX4', 26);
INSERT INTO Utilisateur VALUES (290, 'Kim', 'Chaewon', '22 Yeongdeungpo-gu', 22, 'chaewonkim', 'No83XfQ9', 26);
INSERT INTO Utilisateur VALUES (291, 'Seung', 'Gihun', '23 Namsan Park', 35, 'sgihun', 'Fo20YvN5', 26);
INSERT INTO Utilisateur VALUES (292, 'Lee', 'Nayeon', '24 Gyeongbokgung', 26, 'nayeonlee', 'Zx91MwP3', 26);
INSERT INTO Utilisateur VALUES (293, 'Im', 'Ahyeon', '11 Ilsan-han', 27, 'ahyeonim', 'Ud98dlz', 26);

/* Singapore 15 */
INSERT INTO Utilisateur VALUES (294, 'Tan', 'Jing', '14 Victoria Street', 29, 'tanjing', 'Vr39LpX6', 27);
INSERT INTO Utilisateur VALUES (295, 'Lee', 'Mei', '15 Bukit Timah Road', 31, 'leemei', 'Qg42DzJ7', 27);
INSERT INTO Utilisateur VALUES (296, 'Lim', 'Hong', '16 Tanjong Pagar Road', 24, 'limhong', 'Zu30LrF5', 27);
INSERT INTO Utilisateur VALUES (297, 'Koh', 'Zhi', '17 Jalan Besar', 28, 'kohzhi', 'Ym72TnX9', 27);
INSERT INTO Utilisateur VALUES (298, 'Lai', 'Zhen', '18 Telok Ayer Street', 30, 'laizhen', 'Wb58HrP6', 27);
INSERT INTO Utilisateur VALUES (299, 'Chong', 'Hui', '19 Hill Street', 26, 'chonghui', 'Fi72DwR4', 27);
INSERT INTO Utilisateur VALUES (300, 'Tan', 'Xiu', '20 Orchard Boulevard', 33, 'tanxiu', 'Ev57YkP3', 27);
INSERT INTO Utilisateur VALUES (301, 'Kumar', 'Ravi', '21 Eunos Road', 35, 'ravikumar', 'Bt93UzK8', 27);
INSERT INTO Utilisateur VALUES (302, 'Ahmed', 'Salim', '22 Queen Street', 32, 'ahmedsalim', 'Po28FwN6', 27);
INSERT INTO Utilisateur VALUES (303, 'Hossain', 'Arif', '23 Bedok Reservoir', 34, 'arifhossain', 'Iv38NzR5', 27);
INSERT INTO Utilisateur VALUES (304, 'Ali', 'Youssef', '24 Kallang Road', 25, 'aliyoussef', 'Gk55KmV2', 27);
INSERT INTO Utilisateur VALUES (305, 'Abdi', 'Omar', '25 Jurong East', 27, 'abdiomar', 'Af71HpR4', 27);
INSERT INTO Utilisateur VALUES (306, 'Mok', 'Jun', '26 Serangoon Road', 36, 'mokjun', 'Te49DbL3', 27);
INSERT INTO Utilisateur VALUES (307, 'Chen', 'Wei', '12 Clementi Avenue', 29, 'chenwei', 'Pw89FgX2', 27);
INSERT INTO Utilisateur VALUES (308, 'Lin', 'Hua', '8 Tampines Street', 38, 'linhua', 'Ab56GtY9', 27);

/* Los Angeles 13 */
INSERT INTO Utilisateur VALUES (309, 'Pitt', 'Brad', '31 Sunset Blvd', 40, 'bradpitt', 'Pl45NrF2', 28);
INSERT INTO Utilisateur VALUES (310, 'Smith', 'Will', '33 Bel Air Rd', 38, 'willsmith', 'Rc52GpX1', 28);
INSERT INTO Utilisateur VALUES (311, 'Kardashian', 'Kim', '34 Hollywood Blvd', 35, 'kimkardashian', 'Lx21FcJ3', 28);
INSERT INTO Utilisateur VALUES (312, 'West', 'Kanye', '35 Rodeo Dr', 37, 'kanyewest', 'Mt74KzN2', 28);
INSERT INTO Utilisateur VALUES (313, 'Cohen', 'Sacha', '36 Laurel Canyon Blvd', 41, 'sachacohen', 'Nr65ZyW4', 28);
INSERT INTO Utilisateur VALUES (314, 'Eminem', 'Marshall', '37 Melrose Ave', 39, 'eminem', 'Jw38PzT5', 28);
INSERT INTO Utilisateur VALUES (315, 'Lizzo', 'Melissa', '38 Hollywood Hills', 32, 'lizzo', 'Ky25VbN6', 28);
INSERT INTO Utilisateur VALUES (316, 'Mendes', 'Shawn', '39 Santa Monica Blvd', 29, 'shawnmendes', 'Ln84FsW7', 28);
INSERT INTO Utilisateur VALUES (317, 'Gaga', 'Lady', '40 Vine St', 32, 'ladygaga', 'Zv92WpB3', 28);
INSERT INTO Utilisateur VALUES (318, 'Drake', 'Aubrey', '41 Pacific Palisades', 34, 'drake', 'Fi56BdQ9', 28);
INSERT INTO Utilisateur VALUES (319, 'Grande', 'Ariana', '42 Sunset Strip', 28, 'arianagrande', 'Vo23KbX6', 28);
INSERT INTO Utilisateur VALUES (320, 'Jolie', 'Angelina', '32 Mulholland Dr', 30, 'angelinajolie', 'Jk23MtW5', 28);
INSERT INTO Utilisateur VALUES (321, 'Bieber', 'Justin', '30 Wilshire Blvd', 26, 'jbieber', 'Tq67EuK9', 28);

/* New York 11 */
INSERT INTO Utilisateur VALUES (322, 'Gotti', 'John', '27 Fifth Ave', 29, 'johngotti', 'Fg91DxL3', 29);
INSERT INTO Utilisateur VALUES (323, 'Luciano', 'Lucky', '28 Grand St', 32, 'luckyluciano', 'Kd53VgB1', 29);
INSERT INTO Utilisateur VALUES (324, 'Colombo', 'Joseph', '29 Broadway', 34, 'josephcolombo', 'Nm72JyT8', 29);
INSERT INTO Utilisateur VALUES (325, 'Genovese', 'Vito', '30 Wall St', 33, 'vitogenovese', 'Wl93XaS2', 29);
INSERT INTO Utilisateur VALUES (326, 'Tammaro', 'Paul', '31 42nd St', 35, 'paultammaro', 'Hs39BxD6', 29);
INSERT INTO Utilisateur VALUES (327, 'Bonanno', 'Salvatore', '32 Madison Ave', 37, 'salvatorebonanno', 'Yp55RfQ1', 29);
INSERT INTO Utilisateur VALUES (328, 'Luchese', 'Anthony', '33 Central Park West', 40, 'anthonyluchese', 'Wz19StP9', 29);
INSERT INTO Utilisateur VALUES (329, 'Rizzuto', 'Vincenzo', '34 Bowery St', 39, 'vincenzorizzuto', 'Xa76NzF4', 29);
INSERT INTO Utilisateur VALUES (330, 'Bruno', 'Frank', '35 Park Row', 32, 'frankbruno', 'Hs39WxV2', 29);
INSERT INTO Utilisateur VALUES (331, 'Johnson', 'William', '25 Park Avenue', 36, 'wjohnson', 'Zo78VgQ4', 29);
INSERT INTO Utilisateur VALUES (332, 'Capone', 'Al', '26 Lexington Ave', 41, 'alcapone', 'Tp65VzP7', 29);

/* Buenos Aires 8+1 */
INSERT INTO Utilisateur VALUES (333, 'Müller', 'Felix', '8 Avenida Libertador', 29, 'fmuller', 'Zw56NpH3', 30);
INSERT INTO Utilisateur VALUES (334, 'Diaz', 'Carlos', '32 Calle Corrientes', 30, 'cdiaz', 'Xs47YvQ2', 30);
INSERT INTO Utilisateur VALUES (335, 'Weber', 'Paul', '15 Avenida de Mayo', 28, 'pweber', 'Dd84FzL5', 30);
INSERT INTO Utilisateur VALUES (336, 'Mitroglou', 'Marcos', '7 Calle de la Paz', 32, 'mmitroglou', 'Wz32NpJ7', 30);
INSERT INTO Utilisateur VALUES (337, 'Schulz', 'Tobias', '5 Calle Juan B. Justo', 30, 'tschulz', 'Yr99CpM6', 30);
INSERT INTO Utilisateur VALUES (338, 'Fernandez', 'Lucía', '10 Calle Tucumán', 31, 'lfernandez', 'Gb71QkW8', 30);
INSERT INTO Utilisateur VALUES (339, 'Schmitt', 'Emilia', '13 Calle Belgrano', 30, 'eschmitt', 'Vh50RtE3', 30);
INSERT INTO Utilisateur VALUES (340, 'Martinez', 'Alberto', '28 Calle San Martín', 33, 'amartinez', 'Tj84KuV1', 30);
INSERT INTO Utilisateur VALUES (347, 'Pierre', 'Chabrier', '1 rue de la Marronaderie', 38, 'pchabrier', 'Sk7vc8jk', 30);

/* Directeurs des clubs */

INSERT INTO Directeur VALUES (2017, 1, 1);
INSERT INTO Directeur VALUES (2020, 17, 2);
INSERT INTO Directeur VALUES (2015, 27, 3);
INSERT INTO Directeur VALUES (2018, 35, 4);
INSERT INTO Directeur VALUES (2013, 50, 5);
INSERT INTO Directeur VALUES (2022, 64, 6);
INSERT INTO Directeur VALUES (2016, 76, 7);
INSERT INTO Directeur VALUES (2014, 86, 8);
INSERT INTO Directeur VALUES (2021, 97, 9);
INSERT INTO Directeur VALUES (2019, 106, 10);
INSERT INTO Directeur VALUES (2012, 119, 11);
INSERT INTO Directeur VALUES (2020, 126, 12);
INSERT INTO Directeur VALUES (2017, 135, 13);
INSERT INTO Directeur VALUES (2018, 145, 14);
INSERT INTO Directeur VALUES (2015, 161, 15);
INSERT INTO Directeur VALUES (2019, 173, 16);
INSERT INTO Directeur VALUES (2021, 183, 17);
INSERT INTO Directeur VALUES (2022, 194, 18);
INSERT INTO Directeur VALUES (2013, 203, 19);
INSERT INTO Directeur VALUES (2016, 216, 20);
INSERT INTO Directeur VALUES (2014, 224, 21);
INSERT INTO Directeur VALUES (2018, 236, 22);
INSERT INTO Directeur VALUES (2020, 243, 23);
INSERT INTO Directeur VALUES (2019, 253, 24);
INSERT INTO Directeur VALUES (2022, 264, 25);
INSERT INTO Directeur VALUES (2017, 278, 26);
INSERT INTO Directeur VALUES (2015, 294, 27);
INSERT INTO Directeur VALUES (2014, 309, 28);
INSERT INTO Directeur VALUES (2021, 322, 29);
INSERT INTO Directeur VALUES (2016, 333, 30);

/* Administrateur */
INSERT INTO Administrateur VALUES (2011, 271); 



/* Concours */
INSERT INTO Concours (numConcours, theme, dateDebut, dateFin, etat) VALUES

-- Année 2023 (terminé)
(1, 'Concours Illustration Art Numérique', '2023-01-18', '2023-01-23', 'terminé'),
(2, 'Concours Dessin en Plein Air', '2023-04-03', '2023-04-08', 'terminé'),
(3, 'Concours Peinture Été', '2023-07-16', '2023-07-20', 'terminé'),

-- Année 2024
(4, 'Concours Sculpture Numérique', '2024-01-17', '2024-01-21', 'terminé'),
(5, 'Concours Gravure Printanière', '2024-04-09', '2024-04-13', 'terminé'),
(6, 'Concours Art Fantastique Été', '2024-07-15', '2024-07-19', 'terminé'),
(7, 'Concours Dessin Automnal', '2024-10-10', '2024-10-15', 'terminé'),

-- Année 2025 (non commencé)
(8, 'Concours Peinture Hivernale 2025', '2025-01-15', '2025-01-20', 'en cours');




/* Presidents des concours */
INSERT INTO President VALUES (1200, 1, 1);
INSERT INTO President VALUES (1100, 17, 2);
INSERT INTO President VALUES (1200, 20, 3);
INSERT INTO President VALUES (1000, 30, 4);
INSERT INTO President VALUES (1300, 40, 5);
INSERT INTO President VALUES (1100, 50, 6);
INSERT INTO President VALUES (1200, 60, 7);
INSERT INTO President VALUES (1000, 70, 8);

/* Evaluateur */
INSERT INTO Evaluateur VALUES ("Pastel", 7);
INSERT INTO Evaluateur VALUES ("Craie", 8);
INSERT INTO Evaluateur VALUES ("Fusain", 9);
INSERT INTO Evaluateur VALUES ("Aquarelle", 23);
INSERT INTO Evaluateur VALUES ("Huile", 24);
INSERT INTO Evaluateur VALUES ("Gouache", 25);
INSERT INTO Evaluateur VALUES ("Fusain", 33);
INSERT INTO Evaluateur VALUES ("Acrylique", 34);
INSERT INTO Evaluateur VALUES ("Encre", 341);
INSERT INTO Evaluateur VALUES ("Craie", 42);
INSERT INTO Evaluateur VALUES ("Pastel", 43);
INSERT INTO Evaluateur VALUES ("Huile", 45);
INSERT INTO Evaluateur VALUES ("Aquarelle", 56);
INSERT INTO Evaluateur VALUES ("Fusain", 57);
INSERT INTO Evaluateur VALUES ("Craie", 70);
INSERT INTO Evaluateur VALUES ("Pastel", 71);
INSERT INTO Evaluateur VALUES ("Gouache", 72);
INSERT INTO Evaluateur VALUES ("Acrylique", 82);
INSERT INTO Evaluateur VALUES ("Huile", 83);
INSERT INTO Evaluateur VALUES ("Aquarelle", 84);
INSERT INTO Evaluateur VALUES ("Encre", 92);
INSERT INTO Evaluateur VALUES ("Pastel", 93);
INSERT INTO Evaluateur VALUES ("Gouache", 94);
INSERT INTO Evaluateur VALUES ("Craie", 103);
INSERT INTO Evaluateur VALUES ("Encre", 104);
INSERT INTO Evaluateur VALUES ("Fusain", 105);
INSERT INTO Evaluateur VALUES ("Acrylique", 112);
INSERT INTO Evaluateur VALUES ("Aquarelle", 113);
INSERT INTO Evaluateur VALUES ("Pastel", 114);
INSERT INTO Evaluateur VALUES ("Huile", 125);
INSERT INTO Evaluateur VALUES ("Craie", 342);
INSERT INTO Evaluateur VALUES ("Fusain", 343);
INSERT INTO Evaluateur VALUES ("Encre", 132);
INSERT INTO Evaluateur VALUES ("Gouache", 133);
INSERT INTO Evaluateur VALUES ("Huile", 134);
INSERT INTO Evaluateur VALUES ("Fusain", 141);
INSERT INTO Evaluateur VALUES ("Acrylique", 142);
INSERT INTO Evaluateur VALUES ("Pastel", 143);
INSERT INTO Evaluateur VALUES ("Encre", 151);
INSERT INTO Evaluateur VALUES ("Huile", 167);
INSERT INTO Evaluateur VALUES ("Craie", 168);
INSERT INTO Evaluateur VALUES ("Gouache", 169);
INSERT INTO Evaluateur VALUES ("Pastel", 179);
INSERT INTO Evaluateur VALUES ("Encre", 180);
INSERT INTO Evaluateur VALUES ("Acrylique", 181);
INSERT INTO Evaluateur VALUES ("Craie", 189);
INSERT INTO Evaluateur VALUES ("Fusain", 190);
INSERT INTO Evaluateur VALUES ("Huile", 191);
INSERT INTO Evaluateur VALUES ("Acrylique", 200);
INSERT INTO Evaluateur VALUES ("Pastel", 201);
INSERT INTO Evaluateur VALUES ("Encre", 202);
INSERT INTO Evaluateur VALUES ("Craie", 209);
INSERT INTO Evaluateur VALUES ("Aquarelle", 210);
INSERT INTO Evaluateur VALUES ("Fusain", 211);
INSERT INTO Evaluateur VALUES ("Huile", 222);
INSERT INTO Evaluateur VALUES ("Gouache", 223);
INSERT INTO Evaluateur VALUES ("Pastel", 344);
INSERT INTO Evaluateur VALUES ("Craie", 230);
INSERT INTO Evaluateur VALUES ("Encre", 231);
INSERT INTO Evaluateur VALUES ("Acrylique", 232);
INSERT INTO Evaluateur VALUES ("Aquarelle", 242);
INSERT INTO Evaluateur VALUES ("Craie", 345);
INSERT INTO Evaluateur VALUES ("Gouache", 346);
INSERT INTO Evaluateur VALUES ("Fusain", 249);
INSERT INTO Evaluateur VALUES ("Acrylique", 250);
INSERT INTO Evaluateur VALUES ("Huile", 251);
INSERT INTO Evaluateur VALUES ("Encre", 259);
INSERT INTO Evaluateur VALUES ("Pastel", 260);
INSERT INTO Evaluateur VALUES ("Aquarelle", 261);
INSERT INTO Evaluateur VALUES ("Craie", 270);
INSERT INTO Evaluateur VALUES ("Fusain", 268);
INSERT INTO Evaluateur VALUES ("Huile", 269);
INSERT INTO Evaluateur VALUES ("Encre", 285);
INSERT INTO Evaluateur VALUES ("Craie", 286);
INSERT INTO Evaluateur VALUES ("Acrylique", 287);
INSERT INTO Evaluateur VALUES ("Pastel", 300);
INSERT INTO Evaluateur VALUES ("Fusain", 301);
INSERT INTO Evaluateur VALUES ("Huile", 302);
INSERT INTO Evaluateur VALUES ("Aquarelle", 313);
INSERT INTO Evaluateur VALUES ("Craie", 314);
INSERT INTO Evaluateur VALUES ("Pastel", 324);
INSERT INTO Evaluateur VALUES ("Encre", 326);
INSERT INTO Evaluateur VALUES ("Fusain", 325);
INSERT INTO Evaluateur VALUES ("Acrylique", 333);
INSERT INTO Evaluateur VALUES ("Gouache", 334);
INSERT INTO Evaluateur VALUES ("Huile", 335);
INSERT INTO Evaluateur VALUES ("Aquarelle", 10);
INSERT INTO Evaluateur VALUES ("Craie", 20);
INSERT INTO Evaluateur VALUES ("Pastel", 19);
INSERT INTO Evaluateur VALUES ("Gouache", 18);
INSERT INTO Evaluateur VALUES ("Acrylique", 28);
INSERT INTO Evaluateur VALUES ("Huile", 29);
INSERT INTO Evaluateur VALUES ("Aquarelle", 27);
INSERT INTO Evaluateur VALUES ("Encre", 79);
INSERT INTO Evaluateur VALUES ("Pastel", 78);
INSERT INTO Evaluateur VALUES ("Gouache", 77);
INSERT INTO Evaluateur VALUES ("Craie", 90);
INSERT INTO Evaluateur VALUES ("Encre", 89);
INSERT INTO Evaluateur VALUES ("Fusain", 88);
INSERT INTO Evaluateur VALUES ("Acrylique", 99);
INSERT INTO Evaluateur VALUES ("Aquarelle", 98);
INSERT INTO Evaluateur VALUES ("Pastel", 97);
INSERT INTO Evaluateur VALUES ("Craie", 111);
INSERT INTO Evaluateur VALUES ("Fusain", 110);
INSERT INTO Evaluateur VALUES ("Encre", 121);
INSERT INTO Evaluateur VALUES ("Gouache", 120);
INSERT INTO Evaluateur VALUES ("Huile", 119);
INSERT INTO Evaluateur VALUES ("Fusain", 128);
INSERT INTO Evaluateur VALUES ("Acrylique", 127);
INSERT INTO Evaluateur VALUES ("Pastel", 126);
INSERT INTO Evaluateur VALUES ("Huile",138);
INSERT INTO Evaluateur VALUES ("Fusain", 137);
INSERT INTO Evaluateur VALUES ("Acrylique", 136);
INSERT INTO Evaluateur VALUES ("Encre", 154);
INSERT INTO Evaluateur VALUES ("Fusain", 152);
INSERT INTO Evaluateur VALUES ("Aquarelle", 153);
INSERT INTO Evaluateur VALUES ("Huile", 166);
INSERT INTO Evaluateur VALUES ("Craie", 165);
INSERT INTO Evaluateur VALUES ("Gouache", 164);
INSERT INTO Evaluateur VALUES ("Pastel", 176);
INSERT INTO Evaluateur VALUES ("Encre", 175);
INSERT INTO Evaluateur VALUES ("Acrylique", 174);
INSERT INTO Evaluateur VALUES ("Craie", 187);
INSERT INTO Evaluateur VALUES ("Fusain", 186);
INSERT INTO Evaluateur VALUES ("Huile", 185);
INSERT INTO Evaluateur VALUES ("Acrylique", 196);
INSERT INTO Evaluateur VALUES ("Pastel", 195);
INSERT INTO Evaluateur VALUES ("Encre", 194);
INSERT INTO Evaluateur VALUES ("Aquarelle", 208);
INSERT INTO Evaluateur VALUES ("Fusain", 207);
INSERT INTO Evaluateur VALUES ("Huile", 218);
INSERT INTO Evaluateur VALUES ("Gouache", 217);
INSERT INTO Evaluateur VALUES ("Pastel", 216);
INSERT INTO Evaluateur VALUES ("Craie", 229);
INSERT INTO Evaluateur VALUES ("Encre", 228);
INSERT INTO Evaluateur VALUES ("Acrylique",227 );


/* Compétiteur */

/* 6 ou + par club par concours */

-- Génération des INSERT INTO Competiteur VALUES avec les num et remplacement de 2012 par 2023
INSERT INTO Competiteur VALUES 
("2023-01-18", 1),
("2023-01-18", 2),
("2023-01-18", 3),
("2023-01-18", 4),
("2023-01-18", 5),
("2023-01-18", 6),
("2023-01-18", 17),
("2023-01-18", 18),
("2023-01-18", 19),
("2023-01-18", 20),
("2023-01-18", 21),
("2023-01-18", 22),
("2023-01-18", 27),
("2023-01-18", 28),
("2023-01-18", 29),
("2023-01-18", 30),
("2023-01-18", 31),
("2023-01-18", 32),
("2023-01-18", 35),
("2023-01-18", 36),
("2023-01-18", 37),
("2023-01-18", 38),
("2023-01-18", 39),
("2023-01-18", 40),
("2023-01-18", 50),
("2023-01-18", 51),
("2023-01-18", 52),
("2023-01-18", 53),
("2023-01-18", 54),
("2023-01-18", 55),
("2023-01-18", 64),
("2023-01-18", 65),
("2023-01-18", 66),
("2023-01-18", 67),
("2023-01-18", 68),
("2023-01-18", 69),
('2023-04-03', 76),
('2023-04-03', 77),
('2023-04-03', 78),
('2023-04-03', 79),
('2023-04-03', 80),
('2023-04-03', 81),
('2023-04-03', 86),
('2023-04-03', 87),
('2023-04-03', 88),
('2023-04-03', 89),
('2023-04-03', 90),
('2023-04-03', 91),
('2023-04-03', 97),
('2023-04-03', 98),
('2023-04-03', 99),
('2023-04-03', 100),
('2023-04-03', 101),
('2023-04-03', 102),
('2023-04-03', 106),
('2023-04-03', 107),
('2023-04-03', 108),
('2023-04-03', 109),
('2023-04-03', 110),
('2023-04-03', 111),
('2023-04-03', 119),
('2023-04-03', 120),
('2023-04-03', 121),
('2023-04-03', 122),
('2023-04-03', 123),
('2023-04-03', 124),
('2023-04-03', 126),
('2023-04-03', 127),
('2023-04-03', 128),
('2023-04-03', 129),
('2023-04-03', 130),
('2023-04-03', 131),
('2023-07-16', 135),
('2023-07-16', 136),
('2023-07-16', 137),
('2023-07-16', 138),
('2023-07-16', 139),
('2023-07-16', 140),
('2023-07-16', 145),
('2023-07-16', 146),
('2023-07-16', 147),
('2023-07-16', 148),
('2023-07-16', 149),
('2023-07-16', 150),
('2023-07-16', 161),
('2023-07-16', 162),
('2023-07-16', 163),
('2023-07-16', 164),
('2023-07-16', 165),
('2023-07-16', 166),
('2023-07-16', 173),
('2023-07-16', 174),
('2023-07-16', 175),
('2023-07-16', 176),
('2023-07-16', 177),
('2023-07-16', 178),
('2023-07-16', 183),
('2023-07-16', 184),
('2023-07-16', 185),
('2023-07-16', 186),
('2023-07-16', 187),
('2023-07-16', 188),
('2023-07-16', 194),
('2023-07-16', 195),
('2023-07-16', 196),
('2023-07-16', 197),
('2023-07-16', 198),
('2023-07-16', 199),
('2024-01-17', 203),
('2024-01-17', 204),
('2024-01-17', 205),
('2024-01-17', 206),
('2024-01-17', 207),
('2024-01-17', 208),
('2024-01-17', 216),
('2024-01-17', 217),
('2024-01-17', 218),
('2024-01-17', 219),
('2024-01-17', 220),
('2024-01-17', 221),
('2024-01-17', 224),
('2024-01-17', 225),
('2024-01-17', 226),
('2024-01-17', 227),
('2024-01-17', 228),
('2024-01-17', 229),
('2024-01-17', 236),
('2024-01-17', 237),
('2024-01-17', 238),
('2024-01-17', 239),
('2024-01-17', 240),
('2024-01-17', 241),
('2024-01-17', 243),
('2024-01-17', 244),
('2024-01-17', 245),
('2024-01-17', 246),
('2024-01-17', 247),
('2024-01-17', 248),
('2024-01-17', 253),
('2024-01-17', 254),
('2024-01-17', 255),
('2024-01-17', 256),
('2024-01-17', 257),
('2024-01-17', 258),
('2024-04-09', 277),
('2024-04-09', 276),
('2024-04-09', 275),
('2024-04-09', 274),
('2024-04-09', 273),
('2024-04-09', 272),
('2024-04-09', 293),
('2024-04-09', 292),
('2024-04-09', 291),
('2024-04-09', 290),
('2024-04-09', 289),
('2024-04-09', 288),
('2024-04-09', 308),
('2024-04-09', 307),
('2024-04-09', 306),
('2024-04-09', 305),
('2024-04-09', 304),
('2024-04-09', 303),
('2024-04-09', 321),
('2024-04-09', 320),
('2024-04-09', 319),
('2024-04-09', 318),
('2024-04-09', 317),
('2024-04-09', 316),
('2024-04-09', 332),
('2024-04-09', 331),
('2024-04-09', 330),
('2024-04-09', 329),
('2024-04-09', 328),
('2024-04-09', 327),
('2024-04-09', 347),
('2024-04-09', 346),
('2024-04-09', 345),
('2024-04-09', 344),
('2024-04-09', 343),
('2024-04-09', 342),
('2024-07-15', 16),
('2024-07-15', 15),
('2024-07-15', 14),
('2024-07-15', 13),
('2024-07-15', 12),
('2024-07-15', 11),
('2024-07-15', 26),
('2024-07-15', 25),
('2024-07-15', 24),
('2024-07-15', 23),
('2024-07-15', 22),
('2024-07-15', 21),
('2024-07-15', 341),
('2024-07-15', 34),
('2024-07-15', 33),
('2024-07-15', 32),
('2024-07-15', 31),
('2024-07-15', 30),
('2024-07-15', 85),
('2024-07-15', 84),
('2024-07-15', 83),
('2024-07-15', 82),
('2024-07-15', 81),
('2024-07-15', 80),
('2024-07-15', 96),
('2024-07-15', 95),
('2024-07-15', 94),
('2024-07-15', 93),
('2024-07-15', 92),
('2024-07-15', 91),
('2024-07-15', 105),
('2024-07-15', 104),
('2024-07-15', 103),
('2024-07-15', 102),
('2024-07-15', 101),
('2024-07-15', 100);



-- Concours 1
INSERT INTO ClubParticipe VALUES (1, 1);
INSERT INTO ClubParticipe VALUES (2, 1);
INSERT INTO ClubParticipe VALUES (3, 1);
INSERT INTO ClubParticipe VALUES (4, 1);
INSERT INTO ClubParticipe VALUES (5, 1);
INSERT INTO ClubParticipe VALUES (6, 1);
-- Concours 2
INSERT INTO ClubParticipe VALUES (7, 2);
INSERT INTO ClubParticipe VALUES (8, 2);
INSERT INTO ClubParticipe VALUES (9, 2);
INSERT INTO ClubParticipe VALUES (10, 2);
INSERT INTO ClubParticipe VALUES (11, 2);
INSERT INTO ClubParticipe VALUES (12, 2);
-- Concours 3
INSERT INTO ClubParticipe VALUES (13, 3);
INSERT INTO ClubParticipe VALUES (14, 3);
INSERT INTO ClubParticipe VALUES (15, 3);
INSERT INTO ClubParticipe VALUES (16, 3);
INSERT INTO ClubParticipe VALUES (17, 3);
INSERT INTO ClubParticipe VALUES (18, 3);
-- Concours 4
INSERT INTO ClubParticipe VALUES (19, 4);
INSERT INTO ClubParticipe VALUES (20, 4);
INSERT INTO ClubParticipe VALUES (21, 4);
INSERT INTO ClubParticipe VALUES (22, 4);
INSERT INTO ClubParticipe VALUES (23, 4);
INSERT INTO ClubParticipe VALUES (24, 4);
-- Concours 5
INSERT INTO ClubParticipe VALUES (25, 5);
INSERT INTO ClubParticipe VALUES (26, 5);
INSERT INTO ClubParticipe VALUES (27, 5);
INSERT INTO ClubParticipe VALUES (28, 5);
INSERT INTO ClubParticipe VALUES (29, 5);
INSERT INTO ClubParticipe VALUES (30, 5);
-- Concours 6
INSERT INTO ClubParticipe VALUES (1, 6);
INSERT INTO ClubParticipe VALUES (2, 6);
INSERT INTO ClubParticipe VALUES (3, 6);
INSERT INTO ClubParticipe VALUES (7, 6);
INSERT INTO ClubParticipe VALUES (8, 6);
INSERT INTO ClubParticipe VALUES (9, 6);
-- Concours 7
INSERT INTO ClubParticipe VALUES (10, 7);
INSERT INTO ClubParticipe VALUES (11, 7);
INSERT INTO ClubParticipe VALUES (12, 7);
INSERT INTO ClubParticipe VALUES (13, 7);
INSERT INTO ClubParticipe VALUES (14, 7);
INSERT INTO ClubParticipe VALUES (15, 7);
-- Concours 8
INSERT INTO ClubParticipe VALUES (16, 8);
INSERT INTO ClubParticipe VALUES (17, 8);
INSERT INTO ClubParticipe VALUES (18, 8);
INSERT INTO ClubParticipe VALUES (19, 8);
INSERT INTO ClubParticipe VALUES (20, 8);
INSERT INTO ClubParticipe VALUES (21, 8);


