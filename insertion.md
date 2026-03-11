# voici ce que 'lon a demandé a l'IAG 
```
CONTEXTE
Il s’agit de générer des données pour créer une base de données cohérente et réaliste dans le cadre d’un projet de gestion d’une équipe de cyclistes professionnels (coureurs, vélos, courses, contrats, staff, sponsors, entraînements, etc.).
OBJECTIF
Les données générées doivent être crédibles, cohérentes entre elles et suffisamment fournies afin de permettre de tester correctement la base de données.
Donne les requêtes d’insertion permettant de remplir la base de données dont le modèle relationnel est le suivant :
Coureur = (ID_coureur_ INT, Nom VARCHAR(50), prénom VARCHAR(50), Date_ DATE, Nationalité VARCHAR(30), Specialité VARCHAR(30), discipline_secondaire VARCHAR(30), Numero_UCI INT);
Vélo_ = (ID_velo INT, Numero_série VARCHAR(30), Type_velo VARCHAR(50), Taille_cadre INT, Marque VARCHAR(50), Modele VARCHAR(50));
Composant = (ID_composant INT, km_cumule INT, Type_composant VARCHAR(50));
Course = (ID_course INT, nom_course VARCHAR(50), Date_fin DATE, Pays VARCHAR(50), date_debut DATE);
Staff = (ID_staff INT, Nom_staff VARCHAR(50), Prenom_staff VARCHAR(50), #ID_staff_1*);
Sponsor = (ID_sponsor INT, Nom_sponsor VARCHAR(50));
Seance = (Id_seance VARCHAR(50), date_seance DATE, puissance_moyenne INT, duree_seance VARCHAR(50), distance INT, BPM INT, #ID_coureur_);
Etape = (#ID_course, ID_etape INT, Num_etape INT, type_etape VARCHAR(50), Distance DECIMAL(15,2));
Role = (ID_role INT, Metier VARCHAR(50));
Equipe = (Id_equipe INT, nom_equipe VARCHAR(50), code_uci_equipe INT);
Dossier_Medical = (ID_dossier INT, Date_examen DATE, VO2max DECIMAL(15,2), Poids INT, Blessure VARCHAR(50), Date_reprise DATE, #ID_coureur_);
Vehicule = (ID_vehicule INT, Type VARCHAR(50), Immatriculation VARCHAR(50), Capacité INT);
Stage = (ID_stage INT, Lieu VARCHAR(50), Date_debut DATE, Date_fin DATE, Altitude INT, Spécialité_ VARCHAR(50));
Contrat = (id_contrat INT, date_debut DATE, Date_fin DATE, salaire_annuel DECIMAL(15,2), #Id_equipe, #ID_coureur_);
Mobiliser = (#ID_course, #ID_staff, #ID_role);
Participer = (#ID_coureur_, #ID_course, Classement_final INT, statut VARCHAR(50));
Affecter = (#ID_coureur_, #ID_velo, date_afffectation DATE, Date_restitutions DATE);
Installation = (#ID_velo, #ID_composant, Date_installation DATE, Date_retrait DATE);
Suivre = (#ID_coureur_, #ID_staff, Date_intervention DATE, Type_intervention VARCHAR(50), Description VARCHAR(50));
Financer = (#ID_sponsor, #Id_equipe, Date_debut DATE, Date_fin DATE, Montant_contrat DECIMAL(15,2));
s_inscrit = (#ID_course, #Id_equipe, Date_inscription DATE, Statut_invité_automatique_WT_ VARCHAR(50), Directeur_sportif_responsable VARCHAR(50));
Intervienir = (#ID_velo, #ID_staff, date_intervention DATE, Type_intervention VARCHAR(50), pieces_changees VARCHAR(50));
Conduire = (#ID_staff, #ID_vehicule);
Participer_Stage = (#ID_coureur_, #ID_stage);
Necessiter = (#ID_course, #ID_vehicule);
Les clés primaires correspondent aux id, sauf si autre chose est précisé (quand c'est un attribut composé) les clés étrangères sont identifiées par les #, et ont le même nom que les clés primaires auxquelles elles font référence.
Je souhaite obtenir entre 10 et 15 lignes par table.
Les données générées doivent impérativement respecter les contraintes CHECK suivantes :
Numero_UCI : entier entre 1000000000 et 9999999999
Taille_cadre : > 0 et < 100
km_cumule : >= 0
Type_velo : uniquement parmi ('Route', 'CLM', 'VTT', 'Cyclo-cross')
Date_fin >= Date_debut (Course et Stage)
Date_fin > Date_debut (Contrat et Financer)
date_restitutions >= date_affectation (Affecter)
VO2max : > 0 et < 110
Poids : entre 40 et 130
puissance_moyenne : >= 0 et < 1500
BPM : entre 30 et 220
distance (Seance et Etape) : > 0
type_etape : parmi ('Plat', 'Montagne', 'Vallonné', 'CLM Individuel', 'CLM par équipe')
Classement_final : > 0
salaire_annuel : >= 0
Montant_contrat : >= 0
Capacite (Vehicule) : > 0
Les clés étrangères doivent faire référence aux clés primaires existantes : donne les lignes en commençant par remplir les tables dans lesquelles il n'y a pas de clés étrangères, puis les tables dans lesquelles les clés étrangères font références à des clés primaires des tables déjà remplies.
Fournis l'ensemble sous la forme d’un script SQL prêt à être exécuté.
```
L'IAG nous a sorti une réponse que l'on ne trouvait pas très satisfaisante, nous lui avons donc envoyé un second prompt.


```
fais la même chose sans prendre sur une équipe déjà existante. Juste tu peux garder quelques noms de coureurs connus (problème de transfert vers notre nouvelle équipe et des personnes random clément LOY et Nathan LAFFEZ comme coureurs). Aussi, un truc que tu peux faire pour avoir beaucoup de données, c'est de les répartir selon les tables importantes(par exemple, pas forcément besoin d'avoir 30 sponsors ou 30 équipes (juste 5 suffisent mais avoir peut-être 55 couleurs ou autre)
```

Voici ça reponse 





Voici le script SQL entièrement repensé. J'ai créé une structure d'équipe fictive très ambitieuse nommée **"NovaTech Factory Racing"**, qui s'offre les plus grandes stars du peloton et y intègre vos coureurs personnalisés (**Clément LOY** et **Nathan LAFFEZ**). 

J'ai appliqué votre consigne d'optimisation de la répartition : 
- Les tables structurelles (Équipes, Sponsors, Rôles, Stages) ont volontairement peu de lignes (environ 5 à 10).
- Les tables métiers centrales (Coureurs, Vélos, Contrats, Dossiers Médicaux, Séances, Affectations) ont **55 lignes**, toutes parfaitement interconnectées.
- Toutes vos contraintes (`CHECK`, clés primaires/étrangères) sont rigoureusement respectées.

```sql

use cyclisme_equipe_db;

INSERT INTO Equipe (Id_equipe, nom_equipe, code_uci_equipe) VALUES
(1, 'NovaTech Factory Racing (WT)', 101),
(2, 'NovaTech Women Elite', 102),
(3, 'NovaTech Development (U23)', 103),
(4, 'NovaTech Juniors (U19)', 104),
(5, 'NovaTech Off-Road (VTT/CX)', 105);

-- 2. Table Sponsor (5 sponsors clés du projet)
INSERT INTO Sponsor (ID_sponsor, Nom_sponsor) VALUES
(1, 'NovaTech Industries'),
(2, 'Quantum Energy Drink'),
(3, 'AeroBikes'),
(4, 'HyperWeave Apparel'),
(5, 'Global Finance Bank');

-- 3. Table Role (8 rôles essentiels)
INSERT INTO Role (ID_role, Metier) VALUES
(1, 'Manager Général'),
(2, 'Directeur Sportif'),
(3, 'Mécanicien Chef'),
(4, 'Mécanicien'),
(5, 'Entraîneur Performance'),
(6, 'Médecin'),
(7, 'Masseur-Kinésithérapeute'),
(8, 'Chauffeur');

-- 4. Table Stage (5 stages pour couvrir toutes les sections)
INSERT INTO Stage (ID_stage, Lieu, Date_debut, Date_fin, Altitude, Specialite) VALUES
(1, 'Tenerife (Teide)', '2026-01-10', '2026-01-25', 2100, 'Montagne'),
(2, 'Calpe (Espagne)', '2026-01-05', '2026-01-15', 50, 'Général WT'),
(3, 'Girona (Espagne)', '2026-02-01', '2026-02-14', 100, 'Volume U23'),
(4, 'Font Romeu (France)', '2026-07-01', '2026-07-15', 1800, 'Montagne Women'),
(5, 'Banyoles (Espagne)', '2026-02-15', '2026-02-25', 200, 'VTT XC');

-- 5. Table Vehicule (8 véhicules pour la logistique)
INSERT INTO Vehicule (ID_vehicule, Type, Immatriculation, Capacite) VALUES
(1, 'Bus Impérial WT', 'NV-100-WT', 40),
(2, 'Bus Women Elite', 'NV-200-WE', 35),
(3, 'Camion Atelier', 'NV-300-CA', 4),
(4, 'Voiture DS 1', 'NV-001-DS', 5),
(5, 'Voiture DS 2', 'NV-002-DS', 5),
(6, 'Minibus Devo', 'NV-400-MB', 9),
(7, 'Fourgon Off-Road', 'NV-500-FG', 3),
(8, 'Voiture Médicale', 'NV-999-MD', 5);

-- 6. Table Course (10 courses emblématiques)
INSERT INTO Course (ID_course, nom_course, Date_fin, Pays, date_debut) VALUES
(1, 'Tour de France', '2026-07-26', 'France', '2026-07-04'),
(2, 'Giro d''Italia', '2026-05-31', 'Italie', '2026-05-09'),
(3, 'Paris-Roubaix', '2026-04-12', 'France', '2026-04-12'),
(4, 'Tour des Flandres', '2026-04-05', 'Belgique', '2026-04-05'),
(5, 'Tour de France Femmes', '2026-08-02', 'France', '2026-07-27'),
(6, 'Tour de l''Avenir', '2026-08-30', 'France', '2026-08-23'),
(7, 'Paris-Roubaix Juniors', '2026-04-12', 'France', '2026-04-12'),
(8, 'Coupe du Monde VTT Les Gets', '2026-09-06', 'France', '2026-09-04'),
(9, 'Championnat du Monde CX', '2026-02-01', 'Pays-Bas', '2026-01-31'),
(10, 'Liege-Bastogne-Liege', '2026-04-26', 'Belgique', '2026-04-26');

-- 7. Table Composant (10 composants)
INSERT INTO Composant (ID_composant, km_cumule, Type_composant) VALUES
(1, 1500, 'Dérailleur arrière'),
(2, 2000, 'Chaîne 12v'),
(3, 5000, 'Roue carbone 50mm'),
(4, 5000, 'Roue lenticulaire CLM'),
(5, 500, 'Cassette 11-30'),
(6, 300, 'Plaquettes de frein'),
(7, 1000, 'Capteur de puissance'),
(8, 2500, 'Cintre aéro intégré'),
(9, 4000, 'Fourche suspendue VTT'),
(10, 800, 'Pneus Tubeless 28mm');

-- 8. Table Staff (10 membres du staff global)
INSERT INTO Staff (ID_staff, Nom_staff, Prenom_staff, ID_staff_1) VALUES
(1, 'Gomez', 'Ricardo', NULL),       -- Manager
(2, 'Leclerc', 'Mathieu', 1),        -- DS WT
(3, 'Roux', 'Sylvie', 1),            -- DS Femmes
(4, 'Dupont', 'Jean', 2),            -- Mécano Chef
(5, 'Martin', 'Lucas', 4),           -- Mécano
(6, 'Bernard', 'Paul', 2),           -- Entraîneur
(7, 'Dubois', 'Marie', 2),           -- Médecin
(8, 'Moreau', 'Luc', 7),             -- Kiné
(9, 'Simon', 'Pierre', 1),           -- DS VTT
(10, 'Laurent', 'Jacques', 2);       -- Chauffeur

-- 9. Table Coureur (55 Coureurs : Les stars mondiales + Custom + Jeunes/VTT)
INSERT INTO Coureur (ID_coureur, Nom, prenom, Date_naissance, Nationalite, Specialite, discipline_secondaire, Numero_UCI) VALUES
-- Vos coureurs personnalisés (Transférés WT)
(1, 'Loy', 'Clément', '2001-05-14', 'France', 'Puncheur', 'Classiques', 1000000001),
(2, 'Laffez', 'Nathan', '2002-08-22', 'France', 'Montagne', 'Général', 1000000002),
-- La super-team WT Hommes
(3, 'Pogacar', 'Tadej', '1998-09-21', 'Slovénie', 'Général', 'Classiques', 1000000003),
(4, 'Vingegaard', 'Jonas', '1996-12-10', 'Danemark', 'Montagne', 'Général', 1000000004),
(5, 'Evenepoel', 'Remco', '2000-01-25', 'Belgique', 'CLM', 'Général', 1000000005),
(6, 'Van der Poel', 'Mathieu', '1995-01-19', 'Pays-Bas', 'Classiques', 'Cyclo-cross', 1000000006),
(7, 'Van Aert', 'Wout', '1994-09-15', 'Belgique', 'Sprint', 'Cyclo-cross', 1000000007),
(8, 'Pidcock', 'Thomas', '1999-07-30', 'Royaume-Uni', 'Puncheur', 'VTT', 1000000008),
(9, 'Alaphilippe', 'Julian', '1992-06-11', 'France', 'Puncheur', 'Classiques', 1000000009),
(10, 'Gaudu', 'David', '1996-10-10', 'France', 'Montagne', 'Général', 1000000010),
(11, 'Philipsen', 'Jasper', '1998-03-02', 'Belgique', 'Sprint', 'Classiques', 1000000011),
(12, 'Pedersen', 'Mads', '1995-12-18', 'Danemark', 'Sprint', 'Classiques', 1000000012),
(13, 'Roglic', 'Primoz', '1989-10-29', 'Slovénie', 'Général', 'CLM', 1000000013),
(14, 'Kuss', 'Sepp', '1994-09-13', 'Etats-Unis', 'Montagne', 'Général', 1000000014),
(15, 'Laporte', 'Christophe', '1992-12-11', 'France', 'Classiques', 'Sprint', 1000000015),
(16, 'Kung', 'Stefan', '1993-11-16', 'Suisse', 'CLM', 'Classiques', 1000000016),
(17, 'Ganna', 'Filippo', '1996-07-25', 'Italie', 'CLM', 'Piste', 1000000017),
(18, 'Milan', 'Jonathan', '2000-10-01', 'Italie', 'Sprint', 'Piste', 1000000018),
(19, 'Healy', 'Ben', '2000-09-11', 'Irlande', 'Baroudeur', 'Puncheur', 1000000019),
(20, 'Ayuso', 'Juan', '2002-09-16', 'Espagne', 'Général', 'Montagne', 1000000020),
-- Section Women Elite
(21, 'Vollering', 'Demi', '1996-11-15', 'Pays-Bas', 'Général', 'Montagne', 1000000021),
(22, 'Kopecky', 'Lotte', '1995-11-10', 'Belgique', 'Classiques', 'Sprint', 1000000022),
(23, 'Vos', 'Marianne', '1987-05-13', 'Pays-Bas', 'Classiques', 'Cyclo-cross', 1000000023),
(24, 'Niewiadoma', 'Katarzyna', '1994-09-29', 'Pologne', 'Puncheur', 'Montagne', 1000000024),
(25, 'Labous', 'Juliette', '1998-11-04', 'France', 'Général', 'CLM', 1000000025),
(26, 'Muzic', 'Evita', '1999-05-26', 'France', 'Montagne', 'Général', 1000000026),
(27, 'Longo Borghini', 'Elisa', '1991-12-10', 'Italie', 'Puncheur', 'Classiques', 1000000027),
(28, 'Balsamo', 'Elisa', '1998-02-27', 'Italie', 'Sprint', 'Piste', 1000000028),
(29, 'Reusser', 'Marlen', '1991-09-20', 'Suisse', 'CLM', 'Rouleur', 1000000029),
(30, 'Wiebes', 'Lorena', '1999-03-17', 'Pays-Bas', 'Sprint', 'Classiques', 1000000030),
(31, 'Garcia', 'Mavi', '1984-01-02', 'Espagne', 'Montagne', 'Général', 1000000031),
(32, 'Brown', 'Grace', '1992-07-07', 'Australie', 'CLM', 'Classiques', 1000000032),
-- Section U23 (Devo)
(33, 'Morgado', 'António', '2004-01-28', 'Portugal', 'Puncheur', 'Classiques', 1000000033),
(34, 'Gautherat', 'Pierre', '2003-01-16', 'France', 'Classiques', 'Sprint', 1000000034),
(35, 'Baudin', 'Alex', '2001-05-25', 'France', 'Général', 'Montagne', 1000000035),
(36, 'Del Toro', 'Isaac', '2003-08-11', 'Mexique', 'Général', 'Montagne', 1000000036),
(37, 'Staune-Mittet', 'Johannes', '2002-01-18', 'Norvège', 'Montagne', 'Général', 1000000037),
(38, 'Gelders', 'Gil', '2002-12-16', 'Belgique', 'Classiques', 'Rouleur', 1000000038),
(39, 'Christen', 'Jan', '2004-06-26', 'Suisse', 'Puncheur', 'Cyclo-cross', 1000000039),
(40, 'Lovidius', 'Edvin', '2002-03-02', 'Suède', 'CLM', 'Rouleur', 1000000040),
(41, 'Isidore', 'Noa', '2004-09-17', 'France', 'Puncheur', 'Classiques', 1000000041),
(42, 'Tjotta', 'Martin', '2001-01-27', 'Norvège', 'Montagne', 'Général', 1000000042),
-- Section U19 (Juniors)
(43, 'Seixas', 'Paul', '2006-09-24', 'France', 'Montagne', 'CLM', 1000000043),
(44, 'Sparfel', 'Aubin', '2006-05-18', 'France', 'Cyclo-cross', 'Classiques', 1000000044),
(45, 'Vandevyvere', 'Emiel', '2006-02-10', 'Belgique', 'Sprint', 'Classiques', 1000000045),
(46, 'Fietzke', 'Paul', '2006-01-24', 'Allemagne', 'Puncheur', 'Rouleur', 1000000046),
(47, 'Philipsen', 'Albert', '2006-09-02', 'Danemark', 'Général', 'VTT', 1000000047),
(48, 'Finn', 'Lorenzo', '2006-12-19', 'Italie', 'Montagne', 'Général', 1000000048),
(49, 'Alvarez', 'Hector', '2006-12-11', 'Espagne', 'Puncheur', 'Classiques', 1000000049),
-- Section Off-Road (VTT & CX)
(50, 'Ferrand-Prévot', 'Pauline', '1992-02-10', 'France', 'Général', 'VTT', 1000000050),
(51, 'Koretzky', 'Victor', '1994-08-26', 'France', 'VTT', 'Route', 1000000051),
(52, 'Schurter', 'Nino', '1986-05-13', 'Suisse', 'VTT', 'Général', 1000000052),
(53, 'Richards', 'Evie', '1997-03-11', 'Royaume-Uni', 'VTT', 'Cyclo-cross', 1000000053),
(54, 'Iserbyt', 'Eli', '1997-10-22', 'Belgique', 'Cyclo-cross', 'Puncheur', 1000000054),
(55, 'Alvarado', 'Ceylin', '1998-08-06', 'Pays-Bas', 'Cyclo-cross', 'VTT', 1000000055);

-- 10. Table Vélo_ (55 Vélos : 1 pour chaque coureur, fournis par AeroBikes)
INSERT INTO Velo (ID_velo, Numero_serie, Type_velo, Taille_cadre, Marque, Modele) VALUES
(1, 'AERO-R-01', 'Route', 54, 'AeroBikes', 'Nova Pro'),
(2, 'AERO-R-02', 'Route', 52, 'AeroBikes', 'Nova Pro'),
(3, 'AERO-R-03', 'Route', 54, 'AeroBikes', 'Nova Pro'),
(4, 'AERO-R-04', 'Route', 52, 'AeroBikes', 'Nova Pro'),
(5, 'AERO-C-05', 'CLM', 54, 'AeroBikes', 'TimeWarp'),
(6, 'AERO-CX-06', 'Cyclo-cross', 56, 'AeroBikes', 'MudSlayer'),
(7, 'AERO-R-07', 'Route', 56, 'AeroBikes', 'Nova Pro'),
(8, 'AERO-V-08', 'VTT', 54, 'AeroBikes', 'Peak 900'),
(9, 'AERO-R-09', 'Route', 52, 'AeroBikes', 'Nova Pro'),
(10, 'AERO-R-10', 'Route', 50, 'AeroBikes', 'Nova Pro'),
(11, 'AERO-R-11', 'Route', 56, 'AeroBikes', 'Aero Sprint'),
(12, 'AERO-R-12', 'Route', 58, 'AeroBikes', 'Aero Sprint'),
(13, 'AERO-R-13', 'Route', 54, 'AeroBikes', 'Nova Pro'),
(14, 'AERO-R-14', 'Route', 56, 'AeroBikes', 'Nova Pro'),
(15, 'AERO-R-15', 'Route', 58, 'AeroBikes', 'Aero Sprint'),
(16, 'AERO-C-16', 'CLM', 58, 'AeroBikes', 'TimeWarp'),
(17, 'AERO-C-17', 'CLM', 60, 'AeroBikes', 'TimeWarp'),
(18, 'AERO-R-18', 'Route', 58, 'AeroBikes', 'Aero Sprint'),
(19, 'AERO-R-19', 'Route', 54, 'AeroBikes', 'Nova Pro'),
(20, 'AERO-R-20', 'Route', 54, 'AeroBikes', 'Nova Pro'),
(21, 'AERO-R-21', 'Route', 52, 'AeroBikes', 'Nova Pro Women'),
(22, 'AERO-R-22', 'Route', 54, 'AeroBikes', 'Aero Sprint Women'),
(23, 'AERO-CX-23', 'Cyclo-cross', 52, 'AeroBikes', 'MudSlayer'),
(24, 'AERO-R-24', 'Route', 50, 'AeroBikes', 'Nova Pro Women'),
(25, 'AERO-R-25', 'Route', 52, 'AeroBikes', 'Nova Pro Women'),
(26, 'AERO-R-26', 'Route', 50, 'AeroBikes', 'Nova Pro Women'),
(27, 'AERO-R-27', 'Route', 54, 'AeroBikes', 'Nova Pro Women'),
(28, 'AERO-R-28', 'Route', 54, 'AeroBikes', 'Aero Sprint Women'),
(29, 'AERO-C-29', 'CLM', 54, 'AeroBikes', 'TimeWarp Women'),
(30, 'AERO-R-30', 'Route', 56, 'AeroBikes', 'Aero Sprint Women'),
(31, 'AERO-R-31', 'Route', 50, 'AeroBikes', 'Nova Pro Women'),
(32, 'AERO-C-32', 'CLM', 54, 'AeroBikes', 'TimeWarp Women'),
(33, 'AERO-R-33', 'Route', 54, 'AeroBikes', 'Nova Pro Devo'),
(34, 'AERO-R-34', 'Route', 56, 'AeroBikes', 'Aero Sprint Devo'),
(35, 'AERO-R-35', 'Route', 54, 'AeroBikes', 'Nova Pro Devo'),
(36, 'AERO-R-36', 'Route', 54, 'AeroBikes', 'Nova Pro Devo'),
(37, 'AERO-R-37', 'Route', 56, 'AeroBikes', 'Nova Pro Devo'),
(38, 'AERO-R-38', 'Route', 56, 'AeroBikes', 'Aero Sprint Devo'),
(39, 'AERO-CX-39', 'Cyclo-cross', 54, 'AeroBikes', 'MudSlayer'),
(40, 'AERO-C-40', 'CLM', 56, 'AeroBikes', 'TimeWarp'),
(41, 'AERO-R-41', 'Route', 54, 'AeroBikes', 'Nova Pro Devo'),
(42, 'AERO-R-42', 'Route', 56, 'AeroBikes', 'Nova Pro Devo'),
(43, 'AERO-R-43', 'Route', 52, 'AeroBikes', 'Nova Pro U19'),
(44, 'AERO-CX-44', 'Cyclo-cross', 54, 'AeroBikes', 'MudSlayer'),
(45, 'AERO-R-45', 'Route', 56, 'AeroBikes', 'Aero Sprint U19'),
(46, 'AERO-R-46', 'Route', 54, 'AeroBikes', 'Nova Pro U19'),
(47, 'AERO-V-47', 'VTT', 54, 'AeroBikes', 'Peak 900'),
(48, 'AERO-R-48', 'Route', 52, 'AeroBikes', 'Nova Pro U19'),
(49, 'AERO-R-49', 'Route', 54, 'AeroBikes', 'Nova Pro U19'),
(50, 'AERO-V-50', 'VTT', 50, 'AeroBikes', 'Peak 900 Women'),
(51, 'AERO-V-51', 'VTT', 54, 'AeroBikes', 'Peak 900'),
(52, 'AERO-V-52', 'VTT', 56, 'AeroBikes', 'Peak 900'),
(53, 'AERO-V-53', 'VTT', 52, 'AeroBikes', 'Peak 900 Women'),
(54, 'AERO-CX-54', 'Cyclo-cross', 54, 'AeroBikes', 'MudSlayer'),
(55, 'AERO-CX-55', 'Cyclo-cross', 52, 'AeroBikes', 'MudSlayer');


-- ==============================================================================
-- NIVEAU 1 : Tables avec dépendances simples
-- ==============================================================================

-- 11. Table Contrat (55 contrats reliant les 55 coureurs aux 5 équipes)
-- Répartition :
-- Equipe 1 (WT) : 1 à 20
-- Equipe 2 (Women WT) : 21 à 32
-- Equipe 3 (U23) : 33 à 42
-- Equipe 4 (U19) : 43 à 49
-- Equipe 5 (Off-Road) : 50 à 55
INSERT INTO Contrat (id_contrat, date_debut, Date_fin, salaire_annuel, Id_equipe, ID_coureur) VALUES
(1, '2025-01-01', '2028-12-31', 800000.00, 1, 1),   -- Clément Loy (WT)
(2, '2025-01-01', '2028-12-31', 650000.00, 1, 2),   -- Nathan Laffez (WT)
(3, '2024-01-01', '2030-12-31', 6000000.00, 1, 3),  -- Pogacar
(4, '2024-01-01', '2029-12-31', 4500000.00, 1, 4),  -- Vingegaard
(5, '2024-01-01', '2028-12-31', 3500000.00, 1, 5),  -- Evenepoel
(6, '2024-01-01', '2027-12-31', 3000000.00, 1, 6),
(7, '2024-01-01', '2027-12-31', 3000000.00, 1, 7),
(8, '2024-01-01', '2028-12-31', 2500000.00, 1, 8),
(9, '2025-01-01', '2026-12-31', 1500000.00, 1, 9),
(10, '2024-01-01', '2027-12-31', 1200000.00, 1, 10),
(11, '2024-01-01', '2027-12-31', 2000000.00, 1, 11),
(12, '2024-01-01', '2026-12-31', 1800000.00, 1, 12),
(13, '2024-01-01', '2026-12-31', 2800000.00, 1, 13),
(14, '2024-01-01', '2027-12-31', 1400000.00, 1, 14),
(15, '2024-01-01', '2026-12-31', 1300000.00, 1, 15),
(16, '2024-01-01', '2026-12-31', 1100000.00, 1, 16),
(17, '2024-01-01', '2027-12-31', 2200000.00, 1, 17),
(18, '2025-01-01', '2028-12-31', 1500000.00, 1, 18),
(19, '2024-01-01', '2027-12-31', 1000000.00, 1, 19),
(20, '2024-01-01', '2030-12-31', 2500000.00, 1, 20),
(21, '2025-01-01', '2028-12-31', 1000000.00, 2, 21), -- Vollering
(22, '2025-01-01', '2028-12-31', 800000.00, 2, 22),
(23, '2024-01-01', '2026-12-31', 500000.00, 2, 23),
(24, '2024-01-01', '2027-12-31', 700000.00, 2, 24),
(25, '2025-01-01', '2028-12-31', 400000.00, 2, 25),
(26, '2025-01-01', '2027-12-31', 350000.00, 2, 26),
(27, '2024-01-01', '2026-12-31', 600000.00, 2, 27),
(28, '2024-01-01', '2027-12-31', 450000.00, 2, 28),
(29, '2024-01-01', '2026-12-31', 400000.00, 2, 29),
(30, '2024-01-01', '2027-12-31', 550000.00, 2, 30),
(31, '2024-01-01', '2026-12-31', 300000.00, 2, 31),
(32, '2024-01-01', '2026-12-31', 350000.00, 2, 32),
(33, '2025-01-01', '2027-12-31', 120000.00, 3, 33), -- Devo
(34, '2025-01-01', '2026-12-31', 90000.00, 3, 34),
(35, '2024-01-01', '2026-12-31', 100000.00, 3, 35),
(36, '2024-01-01', '2027-12-31', 150000.00, 3, 36),
(37, '2024-01-01', '2026-12-31', 80000.00, 3, 37),
(38, '2025-01-01', '2027-12-31', 75000.00, 3, 38),
(39, '2024-01-01', '2027-12-31', 110000.00, 3, 39),
(40, '2025-01-01', '2026-12-31', 60000.00, 3, 40),
(41, '2025-01-01', '2026-12-31', 65000.00, 3, 41),
(42, '2024-01-01', '2026-12-31', 70000.00, 3, 42),
(43, '2025-01-01', '2026-12-31', 30000.00, 4, 43), -- U19
(44, '2025-01-01', '2026-12-31', 30000.00, 4, 44),
(45, '2025-01-01', '2026-12-31', 30000.00, 4, 45),
(46, '2025-01-01', '2026-12-31', 30000.00, 4, 46),
(47, '2025-01-01', '2026-12-31', 35000.00, 4, 47),
(48, '2025-01-01', '2026-12-31', 30000.00, 4, 48),
(49, '2025-01-01', '2026-12-31', 30000.00, 4, 49),
(50, '2024-01-01', '2027-12-31', 600000.00, 5, 50), -- PFP (Off-Road)
(51, '2024-01-01', '2027-12-31', 400000.00, 5, 51),
(52, '2024-01-01', '2026-12-31', 800000.00, 5, 52),
(53, '2025-01-01', '2027-12-31', 300000.00, 5, 53),
(54, '2024-01-01', '2026-12-31', 450000.00, 5, 54),
(55, '2024-01-01', '2026-12-31', 350000.00, 5, 55);

-- 12. Table Dossier_Medical (55 Dossiers Médicaux)
INSERT INTO Dossier_Medical (ID_dossier, Date_examen, VO2max, Poids, Blessure, Date_reprise, ID_coureur) VALUES
(1, '2026-01-10', 82.00, 68, 'Aucune', NULL, 1),
(2, '2026-01-10', 84.50, 61, 'Aucune', NULL, 2),
(3, '2026-01-11', 89.50, 66, 'Aucune', NULL, 3),
(4, '2026-01-11', 88.00, 60, 'Aucune', NULL, 4),
(5, '2026-01-12', 87.50, 62, 'Aucune', NULL, 5),
(6, '2026-01-12', 86.00, 75, 'Aucune', NULL, 6),
(7, '2026-01-13', 85.00, 78, 'Aucune', NULL, 7),
(8, '2026-01-13', 86.50, 58, 'Aucune', NULL, 8),
(9, '2026-01-14', 83.00, 62, 'Aucune', NULL, 9),
(10, '2026-01-14', 84.00, 60, 'Aucune', NULL, 10),
(11, '2026-01-15', 79.00, 75, 'Aucune', NULL, 11),
(12, '2026-01-15', 80.00, 76, 'Aucune', NULL, 12),
(13, '2026-01-16', 85.50, 65, 'Aucune', NULL, 13),
(14, '2026-01-16', 86.00, 61, 'Aucune', NULL, 14),
(15, '2026-01-17', 78.50, 76, 'Aucune', NULL, 15),
(16, '2026-01-17', 83.00, 83, 'Aucune', NULL, 16),
(17, '2026-01-18', 84.00, 82, 'Aucune', NULL, 17),
(18, '2026-01-18', 80.00, 84, 'Aucune', NULL, 18),
(19, '2026-01-19', 82.50, 65, 'Aucune', NULL, 19),
(20, '2026-01-19', 86.00, 63, 'Aucune', NULL, 20),
(21, '2026-01-20', 74.00, 57, 'Aucune', NULL, 21), -- Femmes VO2 adaptées
(22, '2026-01-20', 71.00, 66, 'Aucune', NULL, 22),
(23, '2026-01-21', 72.50, 58, 'Aucune', NULL, 23),
(24, '2026-01-21', 73.00, 50, 'Aucune', NULL, 24),
(25, '2026-01-22', 70.00, 55, 'Aucune', NULL, 25),
(26, '2026-01-22', 69.50, 52, 'Aucune', NULL, 26),
(27, '2026-01-23', 71.50, 54, 'Aucune', NULL, 27),
(28, '2026-01-23', 68.00, 58, 'Aucune', NULL, 28),
(29, '2026-01-24', 70.50, 65, 'Aucune', NULL, 29),
(30, '2026-01-24', 69.00, 60, 'Aucune', NULL, 30),
(31, '2026-01-25', 67.00, 52, 'Aucune', NULL, 31),
(32, '2026-01-25', 68.50, 58, 'Aucune', NULL, 32),
(33, '2026-01-26', 82.00, 65, 'Aucune', NULL, 33),
(34, '2026-01-26', 78.00, 72, 'Aucune', NULL, 34),
(35, '2026-01-27', 81.00, 61, 'Aucune', NULL, 35),
(36, '2026-01-27', 84.50, 63, 'Aucune', NULL, 36),
(37, '2026-01-28', 83.00, 62, 'Aucune', NULL, 37),
(38, '2026-01-28', 77.00, 70, 'Aucune', NULL, 38),
(39, '2026-01-29', 80.50, 65, 'Aucune', NULL, 39),
(40, '2026-01-29', 79.00, 71, 'Aucune', NULL, 40),
(41, '2026-01-30', 81.00, 66, 'Aucune', NULL, 41),
(42, '2026-01-30', 82.50, 60, 'Aucune', NULL, 42),
(43, '2026-01-31', 84.00, 59, 'Aucune', NULL, 43),
(44, '2026-01-31', 80.00, 64, 'Aucune', NULL, 44),
(45, '2026-02-01', 77.00, 68, 'Aucune', NULL, 45),
(46, '2026-02-01', 78.50, 66, 'Aucune', NULL, 46),
(47, '2026-02-02', 82.00, 62, 'Aucune', NULL, 47),
(48, '2026-02-02', 83.50, 58, 'Aucune', NULL, 48),
(49, '2026-02-03', 79.00, 65, 'Aucune', NULL, 49),
(50, '2026-02-03', 72.00, 54, 'Aucune', NULL, 50),
(51, '2026-02-04', 83.00, 64, 'Aucune', NULL, 51),
(52, '2026-02-04', 85.00, 68, 'Aucune', NULL, 52),
(53, '2026-02-05', 70.00, 56, 'Aucune', NULL, 53),
(54, '2026-02-05', 81.00, 60, 'Aucune', NULL, 54),
(55, '2026-02-06', 69.00, 55, 'Aucune', NULL, 55);

-- 13. Table Seance (55 Séances d'entraînement)
INSERT INTO Seance (Id_seance, date_seance, puissance_moyenne, duree_seance, distance, BPM, ID_coureur) VALUES
('01', '2026-02-10', 270, '04:00:00', 130, 140, 1),
('02', '2026-02-10', 255, '04:30:00', 140, 142, 2),
('03', '2026-02-10', 290, '05:00:00', 160, 138, 3),
('04', '2026-02-10', 285, '05:00:00', 160, 136, 4),
('05', '2026-02-10', 300, '02:00:00', 80, 145, 5),
('06', '2026-02-10', 320, '01:30:00', 40, 155, 6),
('07', '2026-02-10', 315, '02:00:00', 65, 150, 7),
('08', '2026-02-10', 250, '03:00:00', 80, 148, 8),
('09', '2026-02-10', 260, '03:30:00', 110, 142, 9),
('10', '2026-02-10', 245, '04:00:00', 120, 139, 10),
('11', '2026-02-10', 280, '03:00:00', 105, 141, 11),
('12', '2026-02-10', 275, '03:00:00', 105, 140, 12),
('13', '2026-02-10', 265, '04:30:00', 145, 135, 13),
('14', '2026-02-10', 240, '05:00:00', 150, 133, 14),
('15', '2026-02-10', 270, '02:30:00', 85, 144, 15),
('16', '2026-02-10', 310, '01:45:00', 75, 158, 16),
('17', '2026-02-10', 330, '01:30:00', 65, 160, 17),
('18', '2026-02-10', 305, '02:00:00', 80, 155, 18),
('19', '2026-02-10', 260, '03:45:00', 125, 145, 19),
('20', '2026-02-10', 255, '04:15:00', 135, 138, 20),
('21', '2026-02-10', 210, '04:00:00', 115, 142, 21),
('22', '2026-02-10', 205, '03:30:00', 105, 140, 22),
('23', '2026-02-10', 220, '02:00:00', 65, 148, 23),
('24', '2026-02-10', 200, '03:45:00', 110, 145, 24),
('25', '2026-02-10', 195, '04:00:00', 115, 141, 25),
('26', '2026-02-10', 190, '04:15:00', 120, 139, 26),
('27', '2026-02-10', 215, '03:00:00', 95, 144, 27),
('28', '2026-02-10', 225, '02:30:00', 80, 146, 28),
('29', '2026-02-10', 230, '01:45:00', 65, 155, 29),
('30', '2026-02-10', 210, '02:45:00', 90, 143, 30),
('31', '2026-02-10', 185, '04:30:00', 125, 138, 31),
('32', '2026-02-10', 220, '02:00:00', 70, 150, 32),
('33', '2026-02-10', 265, '03:30:00', 115, 146, 33),
('34', '2026-02-10', 275, '02:30:00', 85, 148, 34),
('35', '2026-02-10', 245, '04:00:00', 125, 140, 35),
('36', '2026-02-10', 250, '04:15:00', 130, 141, 36),
('37', '2026-02-10', 240, '04:30:00', 135, 139, 37),
('38', '2026-02-10', 280, '02:00:00', 75, 152, 38),
('39', '2026-02-10', 290, '01:30:00', 50, 155, 39),
('40', '2026-02-10', 300, '01:45:00', 65, 158, 40),
('41', '2026-02-10', 260, '03:00:00', 100, 145, 41),
('42', '2026-02-10', 255, '03:45:00', 120, 142, 42),
('43', '2026-02-10', 235, '03:00:00', 95, 145, 43),
('44', '2026-02-10', 280, '01:30:00', 40, 160, 44),
('45', '2026-02-10', 250, '02:30:00', 85, 148, 45),
('46', '2026-02-10', 245, '03:15:00', 105, 144, 46),
('47', '2026-02-10', 260, '02:00:00', 50, 150, 47),
('48', '2026-02-10', 240, '03:30:00', 110, 142, 48),
('49', '2026-02-10', 255, '02:45:00', 90, 146, 49),
('50', '2026-02-10', 210, '02:00:00', 45, 155, 50),
('51', '2026-02-10', 310, '01:45:00', 40, 165, 51),
('52', '2026-02-10', 320, '01:30:00', 35, 168, 52),
('53', '2026-02-10', 220, '01:45:00', 40, 158, 53),
('54', '2026-02-10', 300, '01:00:00', 25, 170, 54),
('55', '2026-02-10', 240, '01:00:00', 25, 165, 55);

-- 14. Table Participer_Stage (55 Participations aux stages)
INSERT INTO Participer_Stage (ID_coureur, ID_stage) VALUES
(1, 2), (2, 1), (3, 1), (4, 1), (5, 2), (6, 2), (7, 2), (8, 5), (9, 2), (10, 1),
(11, 2), (12, 2), (13, 1), (14, 1), (15, 2), (16, 2), (17, 2), (18, 2), (19, 2), (20, 1),
(21, 4), (22, 4), (23, 4), (24, 4), (25, 4), (26, 4), (27, 4), (28, 4), (29, 4), (30, 4),
(31, 4), (32, 4),
(33, 3), (34, 3), (35, 3), (36, 3), (37, 3), (38, 3), (39, 3), (40, 3), (41, 3), (42, 3),
(43, 3), (44, 3), (45, 3), (46, 3), (47, 5), (48, 3), (49, 3),
(50, 5), (51, 5), (52, 5), (53, 5), (54, 5), (55, 5);

-- 15. Table Etape (15 Étapes des différentes courses)
INSERT INTO Etape (ID_course, ID_etape, Num_etape, type_etape, Distance) VALUES
(1, 1, 1, 'Plat', 180.50),
(1, 2, 14, 'Montagne', 165.00),
(1, 3, 20, 'CLM Individuel', 35.40),
(2, 4, 1, 'CLM Individuel', 18.00),
(2, 5, 16, 'Montagne', 215.00),
(3, 6, 1, 'Plat', 255.00),
(4, 7, 1, 'Vallonné', 270.00),
(5, 8, 4, 'Vallonné', 130.00),
(5, 9, 8, 'Montagne', 115.50),
(6, 10, 6, 'Montagne', 120.00),
(7, 11, 1, 'Plat', 110.00),
(8, 12, 1, 'Vallonné', 30.00),
(9, 13, 1, 'Vallonné', 25.00),
(10, 14, 1, 'Vallonné', 258.00),
(1, 15, 3, 'CLM par équipe', 28.00);

-- 16. Table Financer (5 contrats de sponsoring majeurs)
INSERT INTO Financer (ID_sponsor, Id_equipe, Date_debut, Date_fin, Montant_contrat) VALUES
(1, 1, '2024-01-01', '2028-12-31', 20000000.00),
(2, 1, '2024-01-01', '2027-12-31', 5000000.00),
(3, 1, '2024-01-01', '2028-12-31', 4000000.00),
(1, 2, '2024-01-01', '2028-12-31', 6000000.00),
(5, 3, '2024-01-01', '2026-12-31', 2000000.00);

-- 17. Table Necessiter (15 affectations de véhicules sur les courses)
INSERT INTO Necessiter (ID_course, ID_vehicule) VALUES
(1, 1), (1, 3), (1, 4), (1, 5), (1, 8),
(2, 1), (2, 3), (2, 4),
(5, 2), (5, 5), (5, 8),
(6, 6), (6, 4),
(8, 7),
(9, 7);

-- 18. Table s_inscrit (10 inscriptions aux épreuves)
INSERT INTO s_inscrit (ID_course, Id_equipe, Date_inscription, Statut_invite_automatique_WT, Directeur_sportif_responsable) VALUES
(1, 1, '2026-01-10', 'Automatique WT', 'Mathieu Leclerc'),
(2, 1, '2026-01-15', 'Automatique WT', 'Mathieu Leclerc'),
(3, 1, '2026-02-01', 'Automatique WT', 'Mathieu Leclerc'),
(4, 1, '2026-02-10', 'Automatique WT', 'Mathieu Leclerc'),
(5, 2, '2026-01-20', 'Automatique WT', 'Sylvie Roux'),
(6, 3, '2026-03-01', 'Sélection', 'Ricardo Gomez'),
(7, 4, '2026-03-15', 'Sélection', 'Ricardo Gomez'),
(8, 5, '2026-04-01', 'Elite Team', 'Pierre Simon'),
(9, 5, '2025-12-01', 'Sélection', 'Pierre Simon'),
(10, 1, '2026-02-20', 'Automatique WT', 'Mathieu Leclerc');

-- 19. Table Conduire (10 assignations de véhicules)
INSERT INTO Conduire (ID_staff, ID_vehicule) VALUES
(10, 1), -- Chauffeur -> Bus WT
(10, 2), -- Chauffeur -> Bus Women
(4, 3),  -- Mécano Chef -> Camion Atelier
(2, 4),  -- DS WT -> Voiture DS 1
(3, 5),  -- DS Women -> Voiture DS 2
(9, 7),  -- DS VTT -> Fourgon Off-Road
(7, 8),  -- Médecin -> Voiture Médicale
(5, 6),  -- Mécano -> Minibus Devo
(1, 4),  -- Manager -> Voiture DS 1 (parfois)
(8, 6);  -- Kiné -> Minibus


-- ==============================================================================
-- NIVEAU 2 : Tables avec multiples dépendances
-- ==============================================================================

-- 20. Table Mobiliser (10 affectations de staff)
INSERT INTO Mobiliser (ID_course, ID_staff, ID_role) VALUES
(1, 2, 2),  -- Leclerc au TDF (DS)
(1, 4, 3),  -- Dupont au TDF (Mécano)
(1, 7, 6),  -- Dubois au TDF (Médecin)
(5, 3, 2),  -- Roux au TDF Femmes (DS)
(5, 5, 4),  -- Martin au TDF Femmes (Mécano)
(8, 9, 2),  -- Simon à la CDM VTT (DS)
(3, 2, 2),  -- Leclerc à Roubaix (DS)
(6, 1, 1),  -- Gomez au Tour Avenir (Manager)
(2, 2, 2),  -- Leclerc au Giro (DS)
(1, 8, 7);  -- Moreau au TDF (Kiné)

-- 21. Table Affecter (55 vélos affectés à l'année aux 55 coureurs)
INSERT INTO Affecter (ID_coureur, ID_velo, date_affectation, Date_restitutions) VALUES
(1, 1, '2026-01-01', '2026-12-31'),
(2, 2, '2026-01-01', '2026-12-31'),
(3, 3, '2026-01-01', '2026-12-31'),
(4, 4, '2026-01-01', '2026-12-31'),
(5, 5, '2026-01-01', '2026-12-31'),
(6, 6, '2026-01-01', '2026-12-31'),
(7, 7, '2026-01-01', '2026-12-31'),
(8, 8, '2026-01-01', '2026-12-31'),
(9, 9, '2026-01-01', '2026-12-31'),
(10, 10, '2026-01-01', '2026-12-31'),
(11, 11, '2026-01-01', '2026-12-31'),
(12, 12, '2026-01-01', '2026-12-31'),
(13, 13, '2026-01-01', '2026-12-31'),
(14, 14, '2026-01-01', '2026-12-31'),
(15, 15, '2026-01-01', '2026-12-31'),
(16, 16, '2026-01-01', '2026-12-31'),
(17, 17, '2026-01-01', '2026-12-31'),
(18, 18, '2026-01-01', '2026-12-31'),
(19, 19, '2026-01-01', '2026-12-31'),
(20, 20, '2026-01-01', '2026-12-31'),
(21, 21, '2026-01-01', '2026-12-31'),
(22, 22, '2026-01-01', '2026-12-31'),
(23, 23, '2026-01-01', '2026-12-31'),
(24, 24, '2026-01-01', '2026-12-31'),
(25, 25, '2026-01-01', '2026-12-31'),
(26, 26, '2026-01-01', '2026-12-31'),
(27, 27, '2026-01-01', '2026-12-31'),
(28, 28, '2026-01-01', '2026-12-31'),
(29, 29, '2026-01-01', '2026-12-31'),
(30, 30, '2026-01-01', '2026-12-31'),
(31, 31, '2026-01-01', '2026-12-31'),
(32, 32, '2026-01-01', '2026-12-31'),
(33, 33, '2026-01-01', '2026-12-31'),
(34, 34, '2026-01-01', '2026-12-31'),
(35, 35, '2026-01-01', '2026-12-31'),
(36, 36, '2026-01-01', '2026-12-31'),
(37, 37, '2026-01-01', '2026-12-31'),
(38, 38, '2026-01-01', '2026-12-31'),
(39, 39, '2026-01-01', '2026-12-31'),
(40, 40, '2026-01-01', '2026-12-31'),
(41, 41, '2026-01-01', '2026-12-31'),
(42, 42, '2026-01-01', '2026-12-31'),
(43, 43, '2026-01-01', '2026-12-31'),
(44, 44, '2026-01-01', '2026-12-31'),
(45, 45, '2026-01-01', '2026-12-31'),
(46, 46, '2026-01-01', '2026-12-31'),
(47, 47, '2026-01-01', '2026-12-31'),
(48, 48, '2026-01-01', '2026-12-31'),
(49, 49, '2026-01-01', '2026-12-31'),
(50, 50, '2026-01-01', '2026-12-31'),
(51, 51, '2026-01-01', '2026-12-31'),
(52, 52, '2026-01-01', '2026-12-31'),
(53, 53, '2026-01-01', '2026-12-31'),
(54, 54, '2026-01-01', '2026-12-31'),
(55, 55, '2026-01-01', '2026-12-31');

-- 22. Table Participer (55 Résultats en course)
INSERT INTO Participer (ID_coureur, ID_course, Classement_final, statut) VALUES
(1, 10, 15, 'Terminé'),    -- Loy à LBL
(2, 1, 18, 'Terminé'),     -- Laffez au TDF
(3, 1, 1, 'Terminé'),      -- Pogacar gagne le TDF
(4, 1, 2, 'Terminé'),      -- Vingegaard 2e
(5, 1, 3, 'Terminé'),      -- Evenepoel 3e
(6, 3, 1, 'Terminé'),      -- VDP gagne Roubaix
(7, 4, 1, 'Terminé'),      -- WVA gagne Flandres
(8, 8, 1, 'Terminé'),      -- Pidcock gagne VTT
(9, 10, 5, 'Terminé'),
(10, 1, 9, 'Terminé'),
(11, 1, 110, 'Terminé'),   -- Philipsen sprinteur
(12, 3, 4, 'Terminé'),
(13, 2, 1, 'Terminé'),     -- Roglic gagne Giro
(14, 2, 10, 'Terminé'),
(15, 3, 8, 'Terminé'),
(16, 4, 12, 'Terminé'),
(17, 2, 85, 'Terminé'),
(18, 2, 120, 'Terminé'),
(19, 10, 7, 'Terminé'),
(20, 1, 5, 'Terminé'),
(21, 5, 1, 'Terminé'),     -- Vollering gagne TDF Femmes
(22, 5, 25, 'Terminé'),
(23, 9, 2, 'Terminé'),
(24, 5, 3, 'Terminé'),
(25, 5, 6, 'Terminé'),
(26, 5, 12, 'Terminé'),
(27, 5, 8, 'Terminé'),
(28, 5, 60, 'Terminé'),
(29, 5, 15, 'Terminé'),
(30, 5, 80, 'Terminé'),
(31, 5, 10, 'Terminé'),
(32, 5, 22, 'Terminé'),
(33, 6, 1, 'Terminé'),     -- Morgado au Tour Avenir
(34, 6, 25, 'Terminé'),
(35, 6, 12, 'Terminé'),
(36, 6, 2, 'Terminé'),
(37, 6, 5, 'Terminé'),
(38, 6, 40, 'Terminé'),
(39, 9, 5, 'Terminé'),
(40, 6, 30, 'Terminé'),
(41, 6, 15, 'Terminé'),
(42, 6, 8, 'Terminé'),
(43, 7, 1, 'Terminé'),     -- Seixas gagne Roubaix Juniors
(44, 9, 1, 'Terminé'),     -- Sparfel champion du monde CX Juniors
(45, 7, 5, 'Terminé'),
(46, 7, 12, 'Terminé'),
(47, 8, 3, 'Terminé'),
(48, 7, 25, 'Terminé'),
(49, 7, 8, 'Terminé'),
(50, 8, 1, 'Terminé'),     -- PFP gagne VTT
(51, 8, 2, 'Terminé'),
(52, 8, 5, 'Terminé'),
(53, 8, 3, 'Terminé'),
(54, 9, 3, 'Terminé'),
(55, 9, 1, 'Terminé');     -- Alvarado gagne CX

-- 23. Table Installation (15 Composants installés sur divers vélos)
INSERT INTO Installation (ID_velo, ID_composant, Date_installation, Date_retrait) VALUES
(1, 1, '2026-01-01', NULL),
(2, 2, '2026-01-01', '2026-06-01'),
(3, 3, '2026-01-01', NULL),
(5, 4, '2026-01-01', NULL),
(4, 5, '2026-01-01', '2026-04-01'),
(6, 6, '2026-01-01', '2026-02-15'),
(1, 7, '2026-01-01', NULL),
(7, 8, '2026-01-01', NULL),
(8, 9, '2026-01-01', NULL),
(9, 10, '2026-01-01', '2026-03-01'),
(21, 3, '2026-01-01', NULL),
(33, 1, '2026-01-01', NULL),
(43, 2, '2026-01-01', NULL),
(50, 9, '2026-01-01', NULL),
(54, 6, '2026-01-01', NULL);

-- 24. Table Suivre (15 Interventions staff sur les coureurs)
INSERT INTO Suivre (ID_coureur, ID_staff, Date_intervention, Type_intervention, Description) VALUES
(1, 6, '2026-02-15', 'Entraînement', 'Analyse PMA'),
(2, 7, '2026-03-01', 'Médical', 'Bilan sanguin'),
(3, 8, '2026-07-15', 'Massage', 'Récupération TDF'),
(4, 6, '2026-05-10', 'Entraînement', 'Test Aéro'),
(21, 8, '2026-07-30', 'Massage', 'TDF Femmes'),
(33, 6, '2026-04-01', 'Entraînement', 'Planification Avenir'),
(43, 7, '2026-02-10', 'Médical', 'Certificat aptitude'),
(50, 6, '2026-08-15', 'Entraînement', 'Reconnaissance VTT'),
(6, 8, '2026-04-13', 'Massage', 'Post Roubaix'),
(7, 6, '2026-03-20', 'Entraînement', 'Sprint training'),
(13, 7, '2026-05-15', 'Médical', 'Suture genou'),
(24, 8, '2026-07-28', 'Massage', 'TDF Femmes'),
(44, 6, '2026-01-20', 'Entraînement', 'Stage CX'),
(51, 8, '2026-09-05', 'Massage', 'Pré course VTT'),
(55, 7, '2026-01-15', 'Médical', 'Test PCR');

-- 25. Table Intervienir (15 interventions mécaniques)
INSERT INTO Intervenir (ID_velo, ID_staff, date_intervention, Type_intervention, pieces_changees) VALUES
(1, 4, '2026-06-01', 'Maintenance', 'Chaîne'),
(2, 5, '2026-04-01', 'Réparation', 'Guidoline'),
(6, 4, '2026-02-15', 'Maintenance', 'Plaquettes de frein CX'),
(8, 5, '2026-08-20', 'Maintenance', 'Purge fourche VTT'),
(3, 4, '2026-07-10', 'Réparation', 'Dérailleur TDF'),
(5, 4, '2026-07-24', 'Optimisation', 'Roue lenticulaire TDF'),
(21, 5, '2026-07-26', 'Maintenance', 'Pneus TDF Femmes'),
(43, 5, '2026-04-10', 'Maintenance', 'Boyaux Roubaix Juniors'),
(54, 4, '2026-01-30', 'Lavage', 'Nettoyage CX complet'),
(50, 5, '2026-09-03', 'Optimisation', 'Pression amortisseur'),
(10, 4, '2026-03-01', 'Réparation', 'Pneus crevés'),
(13, 5, '2026-05-15', 'Maintenance', 'Cassette Giro'),
(23, 4, '2026-01-15', 'Réparation', 'Patte dérailleur CX'),
(33, 5, '2026-08-20', 'Lavage', 'Prépa Tour Avenir'),
(47, 4, '2026-09-01', 'Maintenance', 'Roulements VTT');
```
