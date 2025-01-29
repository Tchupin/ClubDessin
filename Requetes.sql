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

----------------------------------------------------------------------

Requête 3

SELECT 
    Dessin.numDessin,
    YEAR(Dessin.dateRemise) AS Annee,  -- L'année de la remise du dessin
    Concours.description AS ConcoursDescription,  -- Description du concours
    Utilisateur.nom AS CompetiteurNom,  -- Nom du compétiteur
    Dessin.numDessin AS DessinNum,  -- Numéro du dessin
    Dessin.commentaire AS DessinCommentaire,  -- Commentaire du compétiteur sur le dessin
    Evaluation.note AS EvaluationNote,  -- Note attribuée au dessin
    Evaluation.commentaire AS EvaluationCommentaire,  -- Commentaire de l'évaluateur
    UtilisateurEvaluateur.nom AS EvaluateurNom  -- Nom de l'évaluateur
FROM 
    Dessin
JOIN 
    Concours ON Dessin.numConcours = Concours.numConcours
JOIN 
    Utilisateur ON Dessin.numCompetiteur = Utilisateur.numUtilisateur
JOIN 
    Evaluation ON Dessin.numDessin = Evaluation.numDessin
JOIN 
    Utilisateur AS UtilisateurEvaluateur ON Evaluation.numEvaluateur = UtilisateurEvaluateur.numUtilisateur;


---------------------------------------------------------------------------------------------------------------------

Requête 4 

SELECT 
    Utilisateur.nom, 
    Utilisateur.prenom, 
    Utilisateur.age
FROM 
    Utilisateur
WHERE 
    NOT EXISTS (
        SELECT 1 
        FROM Concours 
        WHERE NOT EXISTS (
            SELECT 1 
            FROM CompetiteurParticipe 
            WHERE CompetiteurParticipe.numCompetiteur = Utilisateur.numUtilisateur
            AND CompetiteurParticipe.numConcours = Concours.numConcours
        )
    )
ORDER BY 
    Utilisateur.age ASC;

----------------------------------------------------------------------------

Requête 5 

SELECT 
    Club.region AS Region, 
    AVG(Evaluation.note) AS MoyenneNote
FROM 
    Club
JOIN 
    Utilisateur ON Club.numClub = Utilisateur.numClub
JOIN 
    Dessin ON Utilisateur.numUtilisateur = Dessin.numCompetiteur
JOIN 
    Evaluation ON Dessin.numDessin = Evaluation.numDessin
GROUP BY 
    Club.region
ORDER BY 
    MoyenneNote DESC
LIMIT 1;

------------------------------------------------------------

Requête 6 : Affichage de la présence des concours qui ont bien 6 clubs participants

SELECT C.numConcours, C.theme, COUNT(DISTINCT CP.numClub) AS totalClubs
FROM Concours C
JOIN ClubParticipe CP ON C.numConcours = CP.numConcours
GROUP BY C.numConcours, C.theme
HAVING totalClubs = 6;

------------------------------------------------------------------

Requête 7 : Affichage des dessins avec moins de 2 évaluateurs

SELECT D.numDessin, D.numConcours, COUNT(DISTINCT EV.numEvaluateur1) + 
COUNT(DISTINCT EV.numEvaluateur2) AS totalEvaluateurs
FROM Dessin D
LEFT JOIN Evaluation EV ON D.numDessin = EV.numDessin
GROUP BY D.numDessin, D.numConcours
HAVING totalEvaluateurs < 2;


------------------------------------------------------------------

Requete 8 : Cette requête trouve les dessins qui ont été évalués par moins de deux évaluateurs.

SELECT D.numDessin, D.numConcours, 
       COUNT(DISTINCT EV.numEvaluateur1) + 
       COUNT(DISTINCT EV.numEvaluateur2) AS totalEvaluateurs
FROM Dessin D
JOIN Evaluation EV ON D.numDessin = EV.numDessin
GROUP BY D.numDessin, D.numConcours
HAVING totalEvaluateurs < 2;
