USE cyclisme_equipe_db;
ALTER TABLE Coureur 
ADD CONSTRAINT chk_numero_uci CHECK (Numero_UCI BETWEEN 1000000000 AND 9999999999);

ALTER TABLE Velo 
ADD CONSTRAINT chk_taille_cadre CHECK (Taille_cadre > 0 AND Taille_cadre < 100);

ALTER TABLE Composant 
ADD CONSTRAINT chk_km_cumule CHECK (km_cumule >= 0);


ALTER TABLE Velo 
ADD CONSTRAINT chk_type_velo CHECK (Type_velo IN ('Route', 'CLM', 'VTT', 'Cyclo-cross'));


ALTER TABLE Course 
ADD CONSTRAINT chk_dates_course CHECK (Date_fin >= date_debut);

ALTER TABLE Contrat 
ADD CONSTRAINT chk_dates_contrat CHECK (Date_fin > date_debut);

ALTER TABLE Financer 
ADD CONSTRAINT chk_dates_financement CHECK (Date_fin > Date_debut);

ALTER TABLE Stage 
ADD CONSTRAINT chk_dates_stage CHECK (Date_fin >= Date_debut);

ALTER TABLE Affecter 
ADD CONSTRAINT chk_dates_affectation CHECK (date_restitutions >= date_affectation);


ALTER TABLE Dossier_Medical 
ADD CONSTRAINT chk_vo2max CHECK (VO2max > 0 AND VO2max < 110);

ALTER TABLE Dossier_Medical 
ADD CONSTRAINT chk_poids CHECK (Poids BETWEEN 40 AND 130);

ALTER TABLE Seance 
ADD CONSTRAINT chk_puissance CHECK (puissance_moyenne >= 0 AND puissance_moyenne < 1500);

ALTER TABLE Seance 
ADD CONSTRAINT chk_bpm CHECK (BPM BETWEEN 30 AND 220),
ADD CONSTRAINT chk_distance_seance CHECK (distance > 0);

ALTER TABLE Etape 
ADD CONSTRAINT chk_distance_etape CHECK (Distance > 0);

ALTER TABLE Etape 
ADD CONSTRAINT chk_type_etape CHECK (type_etape IN ('Plat', 'Montagne', 'Vallonné', 'CLM Individuel', 'CLM par équipe'));

ALTER TABLE Participer 
ADD CONSTRAINT chk_classement CHECK (Classement_final > 0);


ALTER TABLE Contrat 
ADD CONSTRAINT chk_salaire CHECK (salaire_annuel >= 0);

ALTER TABLE Financer 
ADD CONSTRAINT chk_montant_sponsor CHECK (Montant_contrat >= 0);

ALTER TABLE Vehicule 
ADD CONSTRAINT chk_capacite_vehicule CHECK (Capacite > 0);

