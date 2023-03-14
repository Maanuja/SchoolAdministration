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
Installez les dépendances en exécutant la commande "npm install" dans le terminal
Modifiez les informations de connexion à la base de données dans le fichier ".env"
Créez la base de données en exécutant la commande "npx prisma db push" dans le terminal
Générez les fichiers pour le serveur GraphQL en exécutant la commande "npx prisma generate" dans le terminal
Démarrez le serveur en exécutant la commande "npx nodemon server.js" dans le terminal
Accédez à l'interface graphique de GraphQL en ouvrant un navigateur et en allant sur http://localhost:3456/schooladministration

## Fonctionnalités actuelles :

- Ajout d'une classe
- Ajout d'un cours à une classe
- Ajout d'un étudiant à une classe
- Ajout d'un enseignant
- Ajout d'une note pour un étudiant dans un cours donné
- Modification d'une note pour un étudiant dans un cours donné
- Suppression d'une note pour un étudiant dans un cours donné

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