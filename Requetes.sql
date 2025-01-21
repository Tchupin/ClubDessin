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