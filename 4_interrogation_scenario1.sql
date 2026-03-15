USE cyclisme_equipe_db;

-- ETAPE 1 : Analyse de l’effectif

-- 1. Affiche les coureurs appartenant à l’équipe NovaTech
SELECT c.Nom, c.Prenom, c.Specialite
FROM Coureur c
JOIN Contrat ct ON c.ID_coureur = ct.ID_coureur
JOIN Equipe e ON ct.Id_equipe = e.Id_equipe
WHERE e.nom_equipe = 'NovaTech Factory Racing (WT)'
ORDER BY c.Nom;

-- 2. Affiche les coureurs grimpeurs ou de classement général
SELECT Nom, Prenom, Specialite
FROM Coureur
WHERE Specialite IN ('Montagne','General');

-- 3. Séances d’entraînement longues réalisées par les coureurs
SELECT ID_coureur, distance, duree_seance
FROM Seance
WHERE distance BETWEEN 120 AND 200
ORDER BY distance DESC;

-- 4. Résultats obtenus par les coureurs lors des courses
SELECT c.Nom, c.Prenom, co.nom_course, p.Classement_final
FROM Coureur c
JOIN Participer p ON c.ID_coureur = p.ID_coureur
JOIN Course co ON p.ID_course = co.ID_course
ORDER BY p.Classement_final;

-- 5. Nombre de coureurs par spécialité dans l’équipe
SELECT Specialite, COUNT(*) AS nombre_coureurs
FROM Coureur
GROUP BY Specialite
HAVING COUNT(*) >= 2;

-- ETAPE 2 : Analyse médicale


-- 6. Coureurs ayant une VO2max supérieure à la moyenne
SELECT c.Nom, c.Prenom, d.VO2max
FROM Coureur c
JOIN Dossier_Medical d ON c.ID_coureur = d.ID_coureur
WHERE d.VO2max >
(
SELECT AVG(VO2max)
FROM Dossier_Medical
);

-- 7. VO2max moyenne des coureurs par spécialité.
SELECT c.Specialite, AVG(d.VO2max) AS moyenne_vo2
FROM Coureur c
JOIN Dossier_Medical d ON c.ID_coureur = d.ID_coureur
GROUP BY c.Specialite;

-- 8. Coureurs ne présentant aucune blessure.
SELECT Nom, Prenom
FROM Coureur
WHERE ID_coureur NOT IN
(
SELECT ID_coureur
FROM Dossier_Medical
WHERE Blessure <> 'Aucune'
);

-- 9. Poids moyen des coureurs par nationalité
SELECT c.Nationalite, AVG(d.Poids) AS poids_moyen
FROM Coureur c
JOIN Dossier_Medical d ON c.ID_coureur = d.ID_coureur
GROUP BY c.Nationalite
HAVING AVG(d.Poids) > 55;

-- ETAPE 3 : Vérification du matériel

-- 10. Vélos attribués aux coureurs
SELECT c.Nom, v.Marque, v.Modele
FROM Coureur c
JOIN Affecter a ON c.ID_coureur = a.ID_coureur
JOIN Velo v ON a.ID_velo = v.ID_velo;

-- 11. Nombre de composants installés sur chaque vélo
SELECT v.ID_velo, COUNT(i.ID_composant) AS nb_composants
FROM Velo v
LEFT JOIN Installation i ON v.ID_velo = i.ID_velo
GROUP BY v.ID_velo;

-- 12. Composants ayant plus de kilomètres que la moyenne
SELECT Type_composant, km_cumule
FROM Composant
WHERE km_cumule >
(
SELECT AVG(km_cumule)
FROM Composant
);

-- 13. Nombre d’interventions réalisées par chaque membre du staff
SELECT s.Nom_staff, COUNT(i.ID_intervenir) AS nb_interventions
FROM Staff s
LEFT JOIN Intervenir i ON s.ID_staff = i.ID_staff
GROUP BY s.Nom_staff
ORDER BY nb_interventions DESC;

-- ETAPE 4 : Organisation logistique

-- 14. Véhicules nécessaires pour le Tour de France
SELECT v.Type, v.Immatriculation
FROM Vehicule v
JOIN Necessiter n ON v.ID_vehicule = n.ID_vehicule
JOIN Course c ON n.ID_course = c.ID_course
WHERE c.nom_course = 'Tour de France';

-- 15. Membres du staff mobilisés pour cette course
SELECT st.Nom_staff, r.Metier
FROM Staff st
JOIN Mobiliser m ON st.ID_staff = m.ID_staff
JOIN Role r ON m.ID_role = r.ID_role
JOIN Course c ON m.ID_course = c.ID_course
WHERE c.nom_course = 'Tour de France';

-- 16. Membres du staff conduisant un véhicule
SELECT s.Nom_staff, v.Type
FROM Staff s
JOIN Conduire c ON s.ID_staff = c.ID_staff
JOIN Vehicule v ON c.ID_vehicule = v.ID_vehicule;

-- ETAPE 5 : Analyse des sponsors

-- 17. Sponsors finançant l’équipe NovaTech
SELECT sp.Nom_sponsor
FROM Sponsor sp
JOIN Financer f ON sp.ID_sponsor = f.ID_sponsor
JOIN Equipe e ON f.Id_equipe = e.Id_equipe
WHERE e.nom_equipe = 'NovaTech Factory Racing (WT)';

-- 18. Budget total de sponsoring par équipe
SELECT Id_equipe, SUM(Montant_contrat) AS budget_total
FROM Financer
GROUP BY Id_equipe;

-- 19. Sponsors ayant un contrat supérieur à la moyenne
SELECT Nom_sponsor
FROM Sponsor
WHERE ID_sponsor IN
(
SELECT ID_sponsor
FROM Financer
WHERE Montant_contrat >
(
SELECT AVG(Montant_contrat)
FROM Financer
)
);

-- 20. Équipes possédant au moins un sponsor
SELECT nom_equipe
FROM Equipe e
WHERE EXISTS
(
SELECT *
FROM Financer f
WHERE f.Id_equipe = e.Id_equipe
);
