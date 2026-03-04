CREATE DATABASE cyclisme_equipe_db;
USE cyclisme_equipe_db;

CREATE TABLE Coureur (
    ID_coureur INT AUTO_INCREMENT PRIMARY KEY,
    Nom VARCHAR(50) NOT NULL,
    Prenom VARCHAR(50) NOT NULL,
    Date_naissance DATE,
    Nationalite VARCHAR(30),
    Specialite VARCHAR(30),
    Discipline_secondaire VARCHAR(30),
    Numero_UCI INT UNIQUE
);


CREATE TABLE Velo (
    ID_velo INT AUTO_INCREMENT PRIMARY KEY,
    Numero_serie VARCHAR(30) NOT NULL UNIQUE,
    Type_velo VARCHAR(50),
    Taille_cadre INT,
    Marque VARCHAR(50),
    Modele VARCHAR(50)
);

-- Table Composant
CREATE TABLE Composant (
    ID_composant INT AUTO_INCREMENT PRIMARY KEY,
    km_cumule INT,
    Type_composant VARCHAR(50)
);


CREATE TABLE Course (
    ID_course INT AUTO_INCREMENT PRIMARY KEY,
    nom_course VARCHAR(50) NOT NULL,
    date_debut DATE,
    Date_fin DATE,
    Pays VARCHAR(50)
);


CREATE TABLE Staff (
    ID_staff INT AUTO_INCREMENT PRIMARY KEY,
    Nom_staff VARCHAR(50) NOT NULL,
    Prenom_staff VARCHAR(50) NOT NULL,
    ID_staff_1 INT,
    FOREIGN KEY(ID_staff_1) REFERENCES Staff(ID_staff)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);


CREATE TABLE Sponsor (
    ID_sponsor INT AUTO_INCREMENT PRIMARY KEY,
    Nom_sponsor VARCHAR(50) NOT NULL
);


CREATE TABLE Seance (
    Id_seance INT AUTO_INCREMENT PRIMARY KEY,
    date_seance DATE NOT NULL,
    puissance_moyenne INT,
    duree_seance VARCHAR(50),
    distance INT,
    BPM INT,
    ID_coureur INT NOT NULL,
    FOREIGN KEY(ID_coureur) REFERENCES Coureur(ID_coureur)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE Etape (
    ID_etape INT AUTO_INCREMENT PRIMARY KEY,
    ID_course INT NOT NULL,
    Num_etape INT NOT NULL,
    type_etape VARCHAR(50),
    Distance DECIMAL(15,2),
    FOREIGN KEY(ID_course) REFERENCES Course(ID_course)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE Role (
    ID_role INT AUTO_INCREMENT PRIMARY KEY,
    Metier VARCHAR(50) NOT NULL
);


CREATE TABLE Equipe (
    Id_equipe INT AUTO_INCREMENT PRIMARY KEY,
    nom_equipe VARCHAR(50) NOT NULL,
    code_uci_equipe INT
);


CREATE TABLE Dossier_Medical (
    ID_dossier INT AUTO_INCREMENT PRIMARY KEY,
    Date_examen DATE,
    VO2max DECIMAL(15,2),
    Poids INT,
    Blessure VARCHAR(50),
    Date_reprise DATE,
    ID_coureur INT NOT NULL,
    FOREIGN KEY(ID_coureur) REFERENCES Coureur(ID_coureur)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE Vehicule (
    ID_vehicule INT AUTO_INCREMENT PRIMARY KEY,
    Type VARCHAR(50),
    Immatriculation VARCHAR(50),
    Capacite INT
);


CREATE TABLE Stage (
    ID_stage INT AUTO_INCREMENT PRIMARY KEY,
    Lieu VARCHAR(50) NOT NULL,
    Date_debut DATE,
    Date_fin DATE,
    Altitude INT,
    Specialite VARCHAR(50)
);


CREATE TABLE Contrat (
    id_contrat INT AUTO_INCREMENT PRIMARY KEY,
    date_debut DATE,
    Date_fin DATE,
    salaire_annuel DECIMAL(15,2),
    Id_equipe INT NOT NULL,
    ID_coureur INT NOT NULL,
    FOREIGN KEY(Id_equipe) REFERENCES Equipe(Id_equipe)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(ID_coureur) REFERENCES Coureur(ID_coureur)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE Mobiliser (
    ID_mobiliser INT AUTO_INCREMENT PRIMARY KEY,
    ID_course INT NOT NULL,
    ID_staff INT NOT NULL,
    ID_role INT NOT NULL,
    FOREIGN KEY(ID_course) REFERENCES Course(ID_course)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(ID_staff) REFERENCES Staff(ID_staff)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(ID_role) REFERENCES Role(ID_role)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE Participer (
    ID_participer INT AUTO_INCREMENT PRIMARY KEY,
    ID_coureur INT NOT NULL,
    ID_course INT NOT NULL,
    Classement_final INT,
    statut VARCHAR(50),
    FOREIGN KEY(ID_coureur) REFERENCES Coureur(ID_coureur)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(ID_course) REFERENCES Course(ID_course)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE Affecter (
    ID_affecter INT AUTO_INCREMENT PRIMARY KEY,
    ID_coureur INT NOT NULL,
    ID_velo INT NOT NULL,
    date_affectation DATE,
    date_restitutions DATE,
    FOREIGN KEY(ID_coureur) REFERENCES Coureur(ID_coureur)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(ID_velo) REFERENCES Velo(ID_velo)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE Installation (
    ID_installation INT AUTO_INCREMENT PRIMARY KEY,
    ID_velo INT NOT NULL,
    ID_composant INT NOT NULL,
    Date_installation DATE,
    Date_retrait DATE,
    FOREIGN KEY(ID_velo) REFERENCES Velo(ID_velo)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(ID_composant) REFERENCES Composant(ID_composant)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE Suivre (
    ID_suivre INT AUTO_INCREMENT PRIMARY KEY,
    ID_coureur INT NOT NULL,
    ID_staff INT NOT NULL,
    Date_intervention DATE,
    Type_intervention VARCHAR(50),
    Description VARCHAR(50),
    FOREIGN KEY(ID_coureur) REFERENCES Coureur(ID_coureur)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(ID_staff) REFERENCES Staff(ID_staff)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Table Financer
CREATE TABLE Financer (
    ID_financer INT AUTO_INCREMENT PRIMARY KEY,
    ID_sponsor INT NOT NULL,
    Id_equipe INT NOT NULL,
    Date_debut DATE,
    Date_fin DATE,
    Montant_contrat DECIMAL(15,2),
    FOREIGN KEY(ID_sponsor) REFERENCES Sponsor(ID_sponsor)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(Id_equipe) REFERENCES Equipe(Id_equipe)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE S_inscrit (
    ID_s_inscrit INT AUTO_INCREMENT PRIMARY KEY,
    ID_course INT NOT NULL,
    Id_equipe INT NOT NULL,
    Date_inscription DATE,
    Statut_invite_automatique_WT VARCHAR(50),
    Directeur_sportif_responsable VARCHAR(50),
    FOREIGN KEY(ID_course) REFERENCES Course(ID_course)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(Id_equipe) REFERENCES Equipe(Id_equipe)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE Intervenir (
    ID_intervenir INT AUTO_INCREMENT PRIMARY KEY,
    ID_velo INT NOT NULL,
    ID_staff INT NOT NULL,
    date_intervention DATE,
    Type_intervention VARCHAR(50),
    pieces_changees VARCHAR(50),
    FOREIGN KEY(ID_velo) REFERENCES Velo(ID_velo)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(ID_staff) REFERENCES Staff(ID_staff)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE Conduire (
    ID_conduire INT AUTO_INCREMENT PRIMARY KEY,
    ID_staff INT NOT NULL,
    ID_vehicule INT NOT NULL,
    FOREIGN KEY(ID_staff) REFERENCES Staff(ID_staff)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(ID_vehicule) REFERENCES Vehicule(ID_vehicule)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Participer_Stage (
    ID_participer_stage INT AUTO_INCREMENT PRIMARY KEY,
    ID_coureur INT NOT NULL,
    ID_stage INT NOT NULL,
    FOREIGN KEY(ID_coureur) REFERENCES Coureur(ID_coureur)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(ID_stage) REFERENCES Stage(ID_stage)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE Necessiter (
    ID_necessiter INT AUTO_INCREMENT PRIMARY KEY,
    ID_course INT NOT NULL,
    ID_vehicule INT NOT NULL,
    FOREIGN KEY(ID_course) REFERENCES Course(ID_course)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(ID_vehicule) REFERENCES Vehicule(ID_vehicule)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);