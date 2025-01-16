drop table if exists Reservation;
drop table if exists Client;
drop table if exists Chambre;
drop table if exists Hotel;
drop table if exists Station;

CREATE TABLE Station(
    numsta smallint AUTO_INCREMENT,
    nomsta varchar(40),
    altitude float,
    region varchar(20),
    PRIMARY KEY(numsta)
);

CREATE TABLE Hotel(
    numhot integer AUTO_INCREMENT,
    nomhot varchar(20),
    numsta smallint,
    categorie smallint,
    PRIMARY KEY(numhot),
    FOREIGN KEY(numsta) REFERENCES Station(numsta)
);

CREATE TABLE Client(
    numcli integer AUTO_INCREMENT,
    nomcli varchar(40),
    adrcli varchar(120),
    telcli char(10),
    PRIMARY KEY(numcli)
);

CREATE TABLE Chambre(
    numch integer,
    numhot integer,
    nblits integer(4),
    PRIMARY KEY(numhot,numch),
    FOREIGN KEY(numhot) REFERENCES Hotel(numhot)
);
CREATE TABLE Reservation(
    numcli integer,
    numhot integer,
    numch integer,
    datedeb Date,
    datefin Date,
    nbpers smallint check(nbpers<10),
    PRIMARY KEY(numcli,numhot,numch,datedeb),
    FOREIGN KEY(numcli) REFERENCES Client(numcli),
    FOREIGN KEY(numhot) REFERENCES Hotel(numhot),
    FOREIGN KEY(numhot,numch) REFERENCES Chambre(numhot,numch),
    CONSTRAINT DateVerif CHECK (datefin > datedeb)
);


-- Insertion dans la table Station
INSERT INTO Station (nomsta, altitude, region) VALUES
('Alpes d''Huez', 1860, 'Rhônes-Alpes'),
('Chabanon', 1500, 'Provence-Alpes-Côtes-D''Azur'),
('Montgenevre',1860,'Hautes Alpes'),
('Orcieres Merlette',1850,'Hautes Alpes')
;

-- Insertion dans la table Hotel
INSERT INTO Hotel (numsta, nomhot, categorie) VALUES
(1, 'Au Chamois', 3),
(1, 'Le Castillan', 4),
(2, 'Le Blanchon', 2),
(2, 'Le Relais de la Forge', 2),
(3, 'Le Chalet Blanc', 5),
(3, 'Anova Hotel et Spa', 1),
(4, 'Les Etoiles d''Orion', 3),
(4, 'Les Catrems', 1)
;

-- Insertion dans la table Chambre
INSERT INTO Chambre (numhot, numch, nblits) VALUES
(1, 10, 1),
(1, 20, 2),
(1, 30, 4),
(2, 10, 1),
(2, 20, 2),
(2, 30, 4),
(3, 10, 1),
(3, 20, 2),
(3, 30, 4),
(4, 10, 1),
(4, 20, 2),
(4, 30, 4),
(5, 10, 1),
(5, 20, 2),
(5, 30, 4),
(6, 10, 1),
(6, 20, 2),
(6, 30, 4),
(7, 10, 1),
(7, 20, 2),
(7, 30, 4),
(8, 10, 1),
(8, 20, 2),
(8, 30, 4)
;

-- Insertion dans la table Client
INSERT INTO Client (nomcli, adrcli, telcli) VALUES
('Luc Durand', '18 Av Saint Priest, Montpellier', '0123456789'),
('Patrice Dehais', '4 rue de Tunis, Marseille', '0234567890'),
('Valentin Rey', '10 place de l''Europe, Angers', '0345678901'),
('David Bignan', '5 impasse Croix Blance, Nantes', '0456789012'),
('Yanis Temmim', '1 Rue Arthur Rimbaud, Saint-Denis', '0636455982'),
('Eugy Helecafart', '19bis Boulevard des cafards', '0456989012'),
('Robert Balavoine', '5 rue de l''Esperence, Bordeaux', '0786789012')
;

-- Insertion dans la table Reservation
INSERT INTO Reservation (numcli, numhot, numch, datedeb, datefin, nbpers) VALUES
(1, 1, 10, '2014-02-01', '2014-02-07', 2),
(1, 3, 30, '2018-05-01', '2018-05-05', 3),
(2, 3, 20, '2017-07-01', '2017-07-05', 3),
(2, 4, 10, '2019-08-20', '2019-08-22', 2),
(3, 1, 30, '2013-09-01', '2013-09-07', 2),
(3, 4, 30, '2020-01-15', '2020-01-17', 1),
(4, 2, 20, '2017-05-10', '2017-05-12', 2),
(4, 3, 30, '2021-06-01', '2021-06-04', 4),
(5, 1, 20, '2015-02-01', '2015-02-07', 2),
(5, 2, 10, '2017-09-01', '2017-09-05', 3),
(6, 1, 10, '2016-10-01', '2016-10-07', 1),
(6, 2, 20, '2018-11-15', '2018-11-18', 3),
(7, 1, 10, '2012-02-10', '2012-02-12', 3),
(7, 4, 20, '2018-06-01', '2018-06-03', 1);


select titre from film, Role, Artiste rea , Artiste act
where id_realisateur = rea.id_artiste and Film.id_film = Role.id_film and Role.id_acteur = act.id_artiste and upper(rea.nom) = 'WOO' and upper(act.nom) = 'CAGE';