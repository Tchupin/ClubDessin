
/* appel de Afficher le nom et l’adresse et l’âge de tous les compétiteurs qui ont participé dans un concours en 2023.  Vous afficherez aussi la description du concours la date de début et la date de fin. Le club du compétiteur, le département et la région. */
SELECT 
    u.nom AS NomCompetiteur,
    u.adresse AS AdresseCompetiteur,
    u.age AS AgeCompetiteur,
    con.theme AS ThemeConcours,
    con.dateDebut AS DateDebutConcours,
    con.dateFin AS DateFinConcours,
    cl.nomClub AS Club,
    cl.departement AS Departement,
    cl.region AS Region
FROM 
    Competiteur c
INNER JOIN 
    CompetiteurParticipe p ON c.numCompetiteur = p.numCompetiteur
INNER JOIN 
    Utilisateur u ON c.numCompetiteur = u.numUtilisateur
INNER JOIN 
    Concours con ON p.numConcours = con.numConcours
INNER JOIN 
    Club cl ON cl.numClub = cl.numClub

WHERE 
    YEAR(con.dateDebut) = 2023;

/* Afficher par ordre croissant de la note tous les dessins qui ont été évalués en 2022. Vous afficherez les informations suivantes : le numéro du dessin et la note attribuée, le nom du compétiteur, la description du concours et le thème du concours. */