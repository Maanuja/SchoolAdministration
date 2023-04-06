# SchoolAdministration

## _Déscription du projet :_

Ce projet consiste à créer une base de données pour une école. La base de données contiendra les tables suivantes :

- classes
- cours
- notes
- étudiants
- enseignants

Chaque table aura ses propres colonnes et sera interconnectée avec les autres tables.

Technologies utilisées :

   - Prisma ORM
   - MySQL
   - GraphQL

## Comment utiliser ce projet :

Clonez le repository GitHub dans votre ordinateur
Installez les dépendances en exécutant la commande `npm install` dans le terminal
Modifiez les informations de connexion à la base de données dans le fichier ".env"
Importer le ficher schooladministrator.sql dans votre base de données (ici mysql)
Créez récupérer la base de donnée en exécutant la commande `npx prisma db pull` dans le terminal
Générez les fichiers pour le serveur GraphQL en exécutant la commande "npx prisma generate" dans le terminal
Démarrez le serveur en exécutant la commande "npx nodemon server.js" dans le terminal
Accédez à l'interface graphique de GraphQL en ouvrant un navigateur et en allant sur http://localhost:3456/schooladministration

## Fonctionnalités actuelles :

Gestion des étudiants :

- Récupération de tous les étudiants, avec leurs informations de base ainsi que les classes et les notes associées.
- Récupération d'un étudiant spécifique en utilisant son identifiant.
- Création ou mise à jour d'un étudiant avec ses informations de base, y compris les classes associées.
- Suppression d'un étudiant spécifique en utilisant son identifiant.

Gestion des classes :

- Récupération de toutes les classes, avec les cours associés.
- Récupération d'une classe spécifique en utilisant son identifiant.
- Création ou mise à jour d'une classe avec son nom.
- Suppression d'une classe spécifique en utilisant son identifiant.

Gestion des cours :

- Récupération de tous les cours, avec les enseignants, les classes et les notes associées.
- Récupération de toutes les classes associées à un cours spécifique en utilisant le nom du cours.

Recupérations des notes:

- Calcul de la note moyenne d'un étudiant spécifique
- Récupération de toutes les notes d'un étudiant spécifique 
- Calcul de la note moyenne d'un cours spécifique pour une classe spécifique

## Limitations actuelles :

Suppression n'est pas autorisée s'il existe une contrainte associées.

## Examples de query et mutation
>Query

```sh
query {
  students {
    student_id
    first_name
    last_name
    email
  }
}
```


> Mutations
```sh
mutation {
  createTeacher(first_name: "Melvin", last_name: "Bissor", gender: M, email: "melvinB@example.com") {
    teacher_id
    first_name
    last_name
    gender
    email
  }
}
```