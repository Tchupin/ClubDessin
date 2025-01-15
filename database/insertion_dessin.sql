/*      Commandes pour l'insertion dans la base de données */

/* Clubs */
INSERT INTO Club VALUES (1,'Angers Dessine', '14 Rue du Musée', '0250251193', 16, 'Angers', 'Maine-et-Loire', 'Pays de la Loire')
INSERT INTO Club VALUES (2, 'Paris Artistes', '12 Boulevard de la Republique', '0140253636', 10, 'Paris', 'Ile-de-France', 'France');
INSERT INTO Club VALUES (3, 'Paris Culture', '34 Avenue de lOpera', '0140259876', 8, 'Paris', 'Ile-de-France', 'France');
INSERT INTO Club VALUES (4, 'Lyon Creatif', '5 Rue de la Liberte', '0478526935', 15, 'Lyon', 'Rhone', 'Auvergne-Rhone-Alpes');
INSERT INTO Club VALUES (5, 'Marseille Express', '7 Boulevard des Docks', '0491514625', 14, 'Marseille', 'Bouches-du-Rhone', 'Provence-Alpes-Cote dAzur');
INSERT INTO Club VALUES (6, 'Toulouse Innovation', '13 Rue du Languedoc', '0561374859', 12, 'Toulouse', 'Haute-Garonne', 'Occitanie');
INSERT INTO Club VALUES (7, 'Nice Vision', '20 Avenue Jean Medecin', '0493887745', 10, 'Nice', 'Alpes-Maritimes', 'Provence-Alpes-Cote dAzur');
INSERT INTO Club VALUES (8, 'Lille Creations', '8 Place du General de Gaulle', '0320741865', 11, 'Lille', 'Nord', 'Hauts-de-France');
INSERT INTO Club VALUES (9, 'Bordeaux Fusion', '9 Rue Sainte-Catherine', '0556987453', 9, 'Bordeaux', 'Gironde', 'Nouvelle-Aquitaine');
INSERT INTO Club VALUES (10, 'Nantes Horizon', '6 Quai de la Fosse', '0240985643', 13, 'Nantes', 'Loire-Atlantique', 'Pays de la Loire');
INSERT INTO Club VALUES (11, 'Strasbourg Impressions', '15 Rue des Hallebardes', '0388246398', 7, 'Strasbourg', 'Bas-Rhin', 'Grand Est');
INSERT INTO Club VALUES (12, 'Rennes Art', '11 Rue de la Monnaie', '0299764825', 9, 'Rennes', 'Ille-et-Vilaine', 'Bretagne');
INSERT INTO Club VALUES (13, 'Grenoble Innovations', '3 Place Victor Hugo', '0476893274', 10, 'Grenoble', 'Isere', 'Auvergne-Rhone-Alpes');
INSERT INTO Club VALUES (14, 'Biarritz Créations', '12 Rue de la Plage', '0559421134', 12, 'Biarritz', 'Pyrénées-Atlantiques', 'Nouvelle-Aquitaine');
INSERT INTO Club VALUES (15, 'Madrid Creativo', '24 Calle Gran Via', '0912345678', 12, 'Madrid', 'Madrid', 'Espagne');
INSERT INTO Club VALUES (16, 'Rome Creativo', '15 Via del Corso', '0667432189', 10, 'Rome', 'Lazio', 'Italie');
INSERT INTO Club VALUES (17, 'Berlin Kultur', '9 Unter den Linden', '0305678987', 11, 'Berlin', 'Berlin', 'Allemagne');
INSERT INTO Club VALUES (18, 'London Ideas', '5 Oxford Street', '0207946123', 9, 'London', 'Greater London', 'Royaume-Uni');
INSERT INTO Club VALUES (19, 'Barcelona Vision', '21 La Rambla', '0934235678', 13, 'Barcelona', 'Catalunya', 'Espagne');
INSERT INTO Club VALUES (20, 'Lisbon Arts', '3 Rua Augusta', '0216754321', 8, 'Lisbon', 'Lisboa', 'Portugal');
INSERT INTO Club VALUES (21, 'Brussels Creativity', '18 Avenue Louise', '0279246701', 12, 'Brussels', 'Brussels-Capital', 'Belgique');
INSERT INTO Club VALUES (22, 'Amsterdam Design', '12 Damstraat', '0206347589', 7, 'Amsterdam', 'Noord-Holland', 'Pays-Bas');
INSERT INTO Club VALUES (23, 'Vienna Arts', '14 Ringstrasse', '0157543123', 10, 'Vienna', 'Wien', 'Autriche');
INSERT INTO Club VALUES (24, 'Zurich Art Space', '22 Bahnhofstrasse', '0441236789', 11, 'Zurich', 'Zurich', 'Suisse');
INSERT INTO Club VALUES (25, 'Tokyo Art', '7 Chome-1-2 Marunouchi', '0332168745', 14, 'Tokyo', 'Tokyo', 'Japon');
INSERT INTO Club VALUES (26, 'Seoul Vision', '10 Insadong-gil', '0276248976', 16, 'Seoul', 'Seoul', 'Coree du Sud');
INSERT INTO Club VALUES (27, 'Singapore Creatives', '25 Orchard Road', '0653657890', 15, 'Singapore', 'Singapore', 'Singapour');
INSERT INTO Club VALUES (28, 'Los Angeles Innovation', '3500 Wilshire Blvd', '3236583921', 13, 'Los Angeles', 'California', 'Etats-Unis');
INSERT INTO Club VALUES (29, 'New York Ideas', '45 Park Avenue', '2128564301', 11, 'New York', 'New York', 'Etats-Unis');
INSERT INTO Club VALUES (30, 'Buenos Aires Art', '100 Avenida 9 de Julio', '0114432178', 12, 'Buenos Aires', 'Ciudad Autonoma de Buenos Aires', 'Argentine');

/* Utilisateurs */

-- Angers 16
INSERT INTO Utilisateur VALUES (1, 'Duvaquier', 'Simon', '3 rue de la Rame', 'sduvaquier', 'Vd29erS8', 1);

-- Paris Artistes 10
INSERT INTO Utilisateur VALUES (2, 'Durand', 'Clara', '25 Rue de la Paix', 'cdurand', 'Xy28zYp7', 2);

-- Paris Culture 8
INSERT INTO Utilisateur VALUES (3, 'Martin', 'Paul', '10 Avenue des Champs-Élysées', 'pmartin', 'Df39lVq6', 3);

-- Lyon 15
INSERT INTO Utilisateur VALUES (4, 'Lemoine', 'Julien', '8 Rue de la République', 'jlemoine', 'Jm28KbYp', 4);

-- Marseille 14
INSERT INTO Utilisateur VALUES (5, 'Lefevre', 'Sophie', '15 Boulevard de la Libération', 'slefevre', 'Tg94mFq3', 5);

-- Toulouse 12
INSERT INTO Utilisateur VALUES (6, 'Bernard', 'Lucie', '17 Rue de la Rivière', 'lbernard', 'Nq72HpB5', 6);

-- Nice 10
INSERT INTO Utilisateur VALUES (7, 'Pires', 'Antoine', '6 Place de la Madeleine', 'apires', 'Uo21NxT9', 7);

-- Lille 11
INSERT INTO Utilisateur VALUES (8, 'Dupont', 'Caroline', '3 Rue du Général de Gaulle', 'cdupont', 'Lq67HfZ5', 8);

-- Bordeaux 9
INSERT INTO Utilisateur VALUES (9, 'Moreau', 'Juliette', '12 Rue de la Porte Cailhau', 'jmoreau', 'Wr34XtL8', 9);

-- Nantes 13
INSERT INTO Utilisateur VALUES (10, 'Blanc', 'Victor', '20 Quai de la Fosse', 'vblanc', 'Ej84HtD1', 10);

-- Strasbourg 7
INSERT INTO Utilisateur VALUES (11, 'Guerin', 'Marie', '4 Rue de la Mésange', 'mguerin', 'Vf39WbH2', 11);

-- Rennes 9
INSERT INTO Utilisateur VALUES (12, 'Joubert', 'Alice', '18 Rue de la Monnaie', 'ajoubert', 'Cv29DfL1', 12);

-- Grenoble 10
INSERT INTO Utilisateur VALUES (13, 'Roche', 'Etienne', '5 Rue des Alpes', 'eroches', 'Mk20VfT7', 13);

-- Biarritz 16
INSERT INTO Utilisateur VALUES (14, 'Dupuis', 'Chloé', '1 Rue de la Plage', 'cdupuis', 'Qp82KrT5', 14);

-- Madrid 12
INSERT INTO Utilisateur VALUES (15, 'Sánchez', 'Carlos', '21 Calle Mayor', 'csanchez', 'Fn39TxP6', 15);

-- Rome 10
INSERT INTO Utilisateur VALUES (16, 'Bianchi', 'Giulia', '30 Via del Corso', 'gbianchi', 'Bs58OpV7', 16);

-- Berlin 11
INSERT INTO Utilisateur VALUES (17, 'Schmidt', 'Lukas', '15 Unter den Linden', 'lschmidt', 'Fd70TxJ3', 17);

-- London 9
INSERT INTO Utilisateur VALUES (18, 'Morris', 'Emily', '7 Oxford Street', 'emorris', 'Lp89KvQ6', 18);

-- Barcelona 13
INSERT INTO Utilisateur VALUES (19, 'Lopez', 'Marc', '22 La Rambla', 'mlopez', 'Vt82ReP4', 19);

-- Lisbon 8
INSERT INTO Utilisateur VALUES (20, 'Costa', 'Pedro', '9 Rua Augusta', 'pcosta', 'Yt43RjK7', 20);

-- Brussels 12
INSERT INTO Utilisateur VALUES (21, 'Van der Merwe', 'Elsa', '14 Avenue Louise', 'evandermerwe', 'Rp58MhT2', 21);

-- Amsterdam 7
INSERT INTO Utilisateur VALUES (22, 'Janssen', 'Hugo', '17 Damstraat', 'hjanssen', 'Nz39FiP5', 22);

-- Vienna 10
INSERT INTO Utilisateur VALUES (23, 'Schuster', 'Anna', '2 Ringstrasse', 'aschuster', 'Wx52VsB8', 23);

-- Zurich 11
INSERT INTO Utilisateur VALUES (24, 'Meier', 'Sven', '8 Bahnhofstrasse', 'smeier', 'Vo29KxZ4', 24);

-- Tokyo 14
INSERT INTO Utilisateur VALUES (25, 'Tanaka', 'Hiroshi', '5 Chome-2-1 Shibuya', 'htanaka', 'Vj39LzP7', 25);

-- Seoul 16
INSERT INTO Utilisateur VALUES (26, 'Kim', 'Jiwon', '10 Insadong-gil', 'jkim', 'Bq20XsD8', 26);

-- Singapore 15
INSERT INTO Utilisateur VALUES (27, 'Ng', 'Wei', '12 Orchard Road', 'wng', 'Ck21DqF3', 27);

-- Los Angeles 13
INSERT INTO Utilisateur VALUES (28, 'Garcia', 'Sofia', '30 Wilshire Blvd', 'sgarcia', 'Tq67EuK9', 28);

-- New York 11
INSERT INTO Utilisateur VALUES (29, 'Johnson', 'William', '25 Park Avenue', 'wjohnson', 'Zo78VgQ4', 29);

-- Buenos Aires 12
INSERT INTO Utilisateur VALUES (30, 'Gomez', 'Mateo', '18 Avenida 9 de Julio', 'mgomez', 'Al45UpK2', 30);