USE cyclisme_equipe_db;

-- Vérifie que le numéro UCI d’un coureur est un numéro valide à 10 chiffres
ALTER TABLE Coureur 
ADD CONSTRAINT chk_numero_uci CHECK (Numero_UCI BETWEEN 1000000000 AND 9999999999);

-- Vérifie que la taille du cadre du vélo est positive et réaliste
ALTER TABLE Velo 
ADD CONSTRAINT chk_taille_cadre CHECK (Taille_cadre > 0 AND Taille_cadre < 100);

-- Vérifie que le kilométrage cumulé d’un composant n’est pas négatif
ALTER TABLE Composant 
ADD CONSTRAINT chk_km_cumule CHECK (km_cumule >= 0);

-- Vérifie que le type de vélo appartient à une liste autorisée
ALTER TABLE Velo 
ADD CONSTRAINT chk_type_velo CHECK (Type_velo IN ('Route', 'CLM', 'VTT', 'Cyclo-cross'));

-- Vérifie que la date de fin d’une course est après ou égale à la date de début
ALTER TABLE Course 
ADD CONSTRAINT chk_dates_course CHECK (Date_fin >= date_debut);

-- Vérifie que la date de fin du contrat est après la date de début
ALTER TABLE Contrat 
ADD CONSTRAINT chk_dates_contrat CHECK (Date_fin > date_debut);

-- Vérifie que la date de fin du financement est après la date de début
ALTER TABLE Financer 
ADD CONSTRAINT chk_dates_financement CHECK (Date_fin > Date_debut);

-- Vérifie que la date de fin du stage est après ou égale à la date de début
ALTER TABLE Stage 
ADD CONSTRAINT chk_dates_stage CHECK (Date_fin >= Date_debut);

-- Vérifie que la restitution du matériel est après son affectation
ALTER TABLE Affecter 
ADD CONSTRAINT chk_dates_affectation CHECK (date_restitutions >= date_affectation);

-- Vérifie que la VO2max est dans une plage physiologique réaliste
ALTER TABLE Dossier_Medical 
ADD CONSTRAINT chk_vo2max CHECK (VO2max > 0 AND VO2max < 110);

-- Vérifie que le poids du coureur est dans une plage réaliste
ALTER TABLE Dossier_Medical 
ADD CONSTRAINT chk_poids CHECK (Poids BETWEEN 40 AND 130);

-- Vérifie que la puissance moyenne d’une séance est positive et réaliste
ALTER TABLE Seance 
ADD CONSTRAINT chk_puissance CHECK (puissance_moyenne >= 0 AND puissance_moyenne < 1500);

-- Vérifie que la fréquence cardiaque est dans une plage humaine possible
ALTER TABLE Seance 
ADD CONSTRAINT chk_bpm CHECK (BPM BETWEEN 30 AND 220),

-- Vérifie que la distance parcourue pendant une séance est positive
ADD CONSTRAINT chk_distance_seance CHECK (distance > 0);

-- Vérifie que la distance d’une étape est positive
ALTER TABLE Etape 
ADD CONSTRAINT chk_distance_etape CHECK (Distance > 0);

-- Vérifie que le type d’étape est dans la liste des types possibles
ALTER TABLE Etape 
ADD CONSTRAINT chk_type_etape CHECK (type_etape IN ('Plat', 'Montagne', 'Vallonné', 'CLM Individuel', 'CLM par équipe'));

-- Vérifie que le classement final est supérieur à 0
ALTER TABLE Participer 
ADD CONSTRAINT chk_classement CHECK (Classement_final > 0);

-- Vérifie que le salaire annuel n’est pas négatif
ALTER TABLE Contrat 
ADD CONSTRAINT chk_salaire CHECK (salaire_annuel >= 0);

-- Vérifie que le montant du contrat de sponsoring est positif
ALTER TABLE Financer 
ADD CONSTRAINT chk_montant_sponsor CHECK (Montant_contrat >= 0);

-- Vérifie que la capacité du véhicule est supérieure à 0
ALTER TABLE Vehicule 
ADD CONSTRAINT chk_capacite_vehicule CHECK (Capacite > 0);
