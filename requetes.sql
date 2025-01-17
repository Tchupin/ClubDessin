SELECT 
    u.nom AS NomCompetiteur,
    u.adresse AS AdresseCompetiteur,
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
