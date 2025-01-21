Requête 1  

SELECT U.nom 

AS NomCompetiteur, U.prenom 
AS PrenomCompetiteur, U.adresse AS AdresseCompetiteur, U.age AS AgeCompetiteur, C.theme AS ThemeConcours, C.dateDebut, C.dateFin, CL.nomClub 
AS NomClub, CL.departement, CL.region 

FROM CompetiteurParticipe CP 

JOIN Competiteur CO ON CP.numCompetiteur = CO.numCompetiteur 
JOIN Utilisateur U ON CO.numCompetiteur = U.numUtilisateur 
JOIN Concours C ON CP.numConcours = C.numConcours 
JOIN Club CL ON U.numClub = CL.numClub WHERE YEAR(C.dateDebut) = 2023;

-----------------------------------------------------------------------

Requête 2

SELECT 
    Dessin.numDessin,
    Evaluation.note,
    Utilisateur.nom AS CompetiteurNom,
    Concours.theme AS Theme
FROM 
    Dessin
JOIN 
    Evaluation ON Dessin.numDessin = Evaluation.numDessin
JOIN 
    Utilisateur ON Dessin.numCompetiteur = Utilisateur.numUtilisateur
JOIN 
    Concours ON Dessin.numConcours = Concours.numConcours
WHERE 
    YEAR(Evaluation.dateEvaluation) = 2022
ORDER BY 
    Evaluation.note ASC;
