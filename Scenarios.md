
# Scénario d’utilisation de la base de données

Pour illustrer l’utilisation de notre base de données, nous avons imaginé un scénario correspondant à la **préparation du Tour de France par une équipe cycliste professionnelle**.

Nous sommes **début juin**, environ **un mois avant le début de la course**. À ce moment-là, l’équipe doit finaliser plusieurs éléments comme analyser les coureurs disponibles, vérifier leur état de forme, préparer le matériel et organiser la logistique autour de la compétition, c'est a ce moment là que notre base de données intervient pour aider à la préparation. 

Notre scenarios et divisé en plusieurs étape, qui corresponde au étape de la préparation. On retrouvera les étapes dans le fichier 4_interrogation.sql

----------

# Étape 1 — Analyse de l’effectif

La première étape consiste à analyser les coureurs de l’équipe afin de composer l'équipe pour le Tour de France.

On s’intéresse notamment aux spécialités des coureurs, à leur sentraînements  et à leurs résultats en compétition.

Les requêtes permettent de :

-   afficher les coureurs de l’équipe World Tour
    
-   identifier certains profils sportifs (grimpeurs, général…)
    
-   analyser les séances d’entraînement importantes
    
-   consulter les résultats obtenus lors des courses
    
-   observer la répartition des spécialités dans l’équipe
    

Ces informations seront nécessaires  pour crée l'équipe dans le but de gagner le tour de France !!!

----------

# Étape 2 — Analyse de la condition physique

Une fois les profils sportifs identifiés, il est important de vérifier la condition physique des coureurs.

Les dossiers médicaux permettent de suivre différents indicateurs comme la VO2max, le poids ou les blessures éventuelles.

Les requêtes permettent notamment de :

-   identifier les coureurs avec une VO2max élevée
    
-   calculer certaines statistiques physiques
    
-   repérer les coureurs sans blessure
    
-   comparer certaines caractéristiques entre coureurs
    

Cela permet de vérifier que les coureurs sélectionnés sont en bonne condition pour participer à une course comme le TDF.

----------

# Étape 3 — Vérification du matériel

Une fois les coureurs identifiés, l’équipe technique doit vérifier le matériel utilisé pendant la course.

La base de données permet de suivre les vélos, les composants installés et les interventions mécaniques réalisées.

Les requêtes permettent par exemple de :

-   voir quels vélos sont attribués aux coureurs
    
-   identifier les composants installés
    
-   analyser l’usure des composants
    
-   consulter les interventions réalisées par le staff
    

Ces informations permettent de s’assurer que tout le matériel est prêt pour la compétition.

----------

# Étape 4 — Organisation logistique

La participation à une course comme le Tour de France nécessite également une organisation logistique importante.

L’équipe doit mobiliser plusieurs membres du staff et préparer différents véhicules pour accompagner les coureurs pendant la course.

Les requêtes permettent notamment de :

-   identifier les véhicules nécessaires pour la course
    
-   connaître les membres du staff mobilisés
    
-   voir quels membres du staff conduisent les véhicules
    

----------

# Étape 5 — Analyse des sponsors

Enfin, l’équipe analyse les sponsors, qui financent une grande partie de son activité.

La base de données permet de connaître les sponsors de l’équipe ainsi que les montants associés aux contrats.

Les requêtes permettent par exemple de :

-   identifier les sponsors de l’équipe
    
-   calculer le budget total de sponsoring
    
-   repérer les contrats les plus importants
    
-   vérifier quelles équipes disposent d’au moins un sponsor
    

Ces informations permettent d’avoir une vision globale du financement de l’équipe.
