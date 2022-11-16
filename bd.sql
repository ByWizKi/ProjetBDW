CREATE TABLE Groupe (
    identifiantGroupe INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
    nomGroupe VARCHAR(255), 
    dateCreationGroupe YEAR, 
    dateSeparationGroupe YEAR);


CREATE TABLE Musicien(
    identifiantMusicien INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nomMusicien VARCHAR(255),
    prenomMusicien VARCHAR(255),
    nomScene VARCHAR(255));

CREATE TABLE Genre(
    identifiantGenre INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nomGenre VARCHAR(255),
    libelleTypeGenre VARCHAR(255));

CREATE TABLE Lieux(
    identifiantLieux INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nomLieux VARCHAR(255) UNIQUE,
    coordonneesLieux VARCHAR(255));

CREATE TABLE Album(
    identifiantAlbum INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    libelleAlbum VARCHAR(255),
    titreAlbum VARCHAR(255),
    dateSortieAlbum DATE,
    nomProducteur VARCHAR(255),
    nomIngenieurSon VARCHAR(255),
    descriptionAlbum VARCHAR(255),
    CONSTRAINT CHK_libelleAlbum CHECK (libelleAlbum = "AlbumStudio" OR libelleAlbum = "AlbumCompilation" OR libelleAlbum = "AlbumLives"));

CREATE TABLE Playlist( 
    identifiantPlaylist INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nomPlaylist VARCHAR(255),
    dateCreationPlaylist DATETIME DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE Chanson(
    identifiantChanson INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    titreChanson VARCHAR(255),
    dateCreationChanson DATE,
    identifiantGroupe INT NOT NULL,
    identifiantLieux INT,
    FOREIGN KEY(identifiantGroupe) REFERENCES Groupe(identifiantGroupe),
    FOREIGN KEY(identifiantLieux) REFERENCES Lieux(identifiantLieux));


CREATE TABLE FichierAudio(
    numeroVersion INT AUTO_INCREMENT,
    libelleVersion VARCHAR(255),
    nomFichierAudio VARCHAR(255),
    dureeVersion TIME CHECK (dureeVersion > '00:00:00' AND dureeVersion <= '23:59:59'),
    dateCreationVersion DATE DEFAULT CAST(CURRENT_TIMESTAMP AS DATE),
    playCount INT DEFAULT 0,
    skipCount INT DEFAULT 0,
    descriptionVersion VARCHAR(255),
    identifiantChanson INT NOT NULL,
    PRIMARY KEY (numeroVersion, identifiantChanson),
    FOREIGN KEY(identifiantChanson) REFERENCES Chanson(identifiantChanson)); 

CREATE TABLE Interprete(
    identifiantGroupe INT,
    identifiantChanson INT, 
    numeroVersion INT,
    PRIMARY KEY(identifiantGroupe, identifiantChanson, numeroVersion),
    FOREIGN KEY(identifiantGroupe) REFERENCES Groupe(identifiantGroupe),
    FOREIGN KEY (identifiantChanson) REFERENCES Chanson(identifiantChanson),
    FOREIGN KEY (numeroVersion) REFERENCES FichierAudio(numeroVersion));

CREATE TABLE Enregistre(
    identifiantGroupe INT,
    identifiantAlbum INT,
    PRIMARY KEY(identifiantGroupe, identifiantAlbum),
    FOREIGN KEY(identifiantGroupe) REFERENCES Groupe(identifiantGroupe),
    FOREIGN KEY(identifiantAlbum) REFERENCES Album(identifiantAlbum)
);

CREATE TABLE FaitParti(
    identifiantGroupe INT,
    identifiantMusicien INT,
    roleGroupe VARCHAR(255),
    dateEntrerGroupe YEAR,
    dateSortieGroupe YEAR,
    membreFondateur INT CHECK (membreFondateur = 0 OR membreFondateur = 1),
    PRIMARY KEY(identifiantGroupe, identifiantMusicien),
    FOREIGN KEY(identifiantGroupe) REFERENCES Groupe(identifiantGroupe),
    FOREIGN KEY(identifiantMusicien) REFERENCES Musicien(identifiantMusicien)
);

CREATE TABLE Contient(
    identifiantPlaylist INT,
    identifiantChanson INT, 
    numeroVersion INT,
    dateAjoutPlaylist DATETIME DEFAULT CURRENT_DATE(),
    PRIMARY KEY(identifiantPlaylist, identifiantChanson, numeroVersion),
    FOREIGN KEY(identifiantPlaylist) REFERENCES Playlist(identifiantPlaylist),
    FOREIGN KEY (identifiantChanson) REFERENCES Chanson(identifiantChanson),
    FOREIGN KEY (numeroVersion) REFERENCES FichierAudio(numeroVersion));

CREATE TABLE Produit(
    identifiantGroupe INT,
    identifiantLieux INT,
    identifiantAlbum INT,
    dateProduction DATETIME,
    PRIMARY KEY(identifiantGroupe, identifiantLieux, identifiantAlbum),
    FOREIGN KEY(identifiantGroupe) REFERENCES Groupe(identifiantGroupe),
    FOREIGN KEY(identifiantLieux) REFERENCES Lieux(identifiantLieux),
    FOREIGN KEY(identifiantAlbum) REFERENCES Album(identifiantAlbum)
);

CREATE TABLE Featuring(
    identifiantGroupe INT,
    identifiantMusicien INT,
    identifiantAlbum INT,
    commentaireFeaturing VARCHAR(255),
    PRIMARY KEY(identifiantGroupe, identifiantMusicien, identifiantAlbum),
    FOREIGN KEY(identifiantGroupe) REFERENCES Groupe(identifiantGroupe),
    FOREIGN KEY(identifiantMusicien) REFERENCES Musicien(identifiantMusicien),
    FOREIGN KEY(identifiantAlbum) REFERENCES Album(identifiantAlbum)
);

CREATE TABLE APourGenre(
    identifiantGenre INT,
    identifiantChanson INT,
    PRIMARY KEY(identifiantGenre, identifiantChanson),
    FOREIGN KEY(identifiantGenre) REFERENCES Genre(identifiantGenre),
    FOREIGN KEY(identifiantChanson) REFERENCES Chanson(identifiantChanson)
);

CREATE TABLE APourChanson(
    identifiantAlbum INT,
    identifiantChanson INT, 
    numeroVersion INT,
    numeroPisteChanson INT,
    PRIMARY KEY(identifiantAlbum, numeroVersion),
    FOREIGN KEY(identifiantAlbum) REFERENCES Album(identifiantAlbum),
    FOREIGN KEY (identifiantChanson) REFERENCES Chanson(identifiantChanson),
    FOREIGN KEY (numeroVersion) REFERENCES FichierAudio(numeroVersion));

   
CREATE TABLE RelationChanson(
   identifiantChanson INT,
   identifiantChanson2 INT,
   libelleTypeRelation VARCHAR(255),
   PRIMARY KEY(identifiantChanson, identifiantChanson2),
   FOREIGN KEY(identifiantChanson) REFERENCES Chanson(identifiantChanson),
   FOREIGN KEY(identifiantChanson2) REFERENCES Chanson(identifiantChanson)
);


/* INSERTION */

/* Ajout des Album */
INSERT INTO Album (identifiantAlbum, libelleAlbum, titreAlbum, dateSortieAlbum, nomProducteur, nomIngenieurSon, descriptionAlbum) VALUES (NULL, 'AlbumStudio', 'Elevation', '2022-11-11', 'BEP Music', 'Michel Son', NULL);
INSERT INTO Album (identifiantAlbum, libelleAlbum, titreAlbum, dateSortieAlbum, nomProducteur, nomIngenieurSon, descriptionAlbum) VALUES (NULL, 'AlbumCompilation', 'The Beatles', '1968-11-22', 'Calderstone Productions Limited', NULL, 'Double Album Du groupe The Beatles');
INSERT INTO Album (identifiantAlbum, libelleAlbum, titreAlbum, dateSortieAlbum, nomProducteur, nomIngenieurSon, descriptionAlbum) VALUES (NULL, 'AlbumStudio', 'Ecole des points vitaux', '2010-03-29', 'WHATI-B', 'Renaud Son', NULL);

/* Ajout des Musicien */
INSERT INTO Musicien (identifiantMusicien, nomMusicien, prenomMusicien, nomScene) VALUES (NULL,'Ann Ferguson', 'Stacy', 'Fergie');
INSERT INTO Musicien (identifiantMusicien, nomMusicien, prenomMusicien, nomScene) VALUES (NULL, 'James Adams', 'William ', 'Will.i.am');
INSERT INTO Musicien (identifiantMusicien, nomMusicien, prenomMusicien, nomScene) VALUES (NULL, 'Pineda Lindo', 'Allen', 'Apl.de.ap');
INSERT INTO Musicien (identifiantMusicien, nomMusicien, prenomMusicien, nomScene) VALUES (NULL, 'Hill', 'Kim', 'Kim Hill');
INSERT INTO Musicien (identifiantMusicien, nomMusicien, prenomMusicien, nomScene) VALUES (NULL, 'Luis Gomez', 'James', 'Taboo');

INSERT INTO Musicien (identifiantMusicien, nomMusicien, prenomMusicien, nomScene) VALUES (NULL, 'Lennon', 'Jhon', 'Jhon Lennon');
INSERT INTO Musicien (identifiantMusicien, nomMusicien, prenomMusicien, nomScene) VALUES (NULL, 'McCartney', 'Paul', 'Fergie');
INSERT INTO Musicien (identifiantMusicien, nomMusicien, prenomMusicien, nomScene) VALUES (NULL, 'Starkey', 'Richard', 'Ringo Starr');
INSERT INTO Musicien (identifiantMusicien, nomMusicien, prenomMusicien, nomScene) VALUES (NULL, 'Harrison', 'George', 'George Harrison');
INSERT INTO Musicien (identifiantMusicien, nomMusicien, prenomMusicien, nomScene) VALUES (NULL, 'Fergusson', 'Stuart', 'Stuart Sutcliffe');

INSERT INTO Musicien (identifiantMusicien, nomMusicien, prenomMusicien, nomScene) VALUES (NULL, 'Djuna', 'Gandhi', 'Maître Gims');
INSERT INTO Musicien (identifiantMusicien, nomMusicien, prenomMusicien, nomScene) VALUES (NULL, 'Diallo', 'Adama', 'Barack Adama');
INSERT INTO Musicien (identifiantMusicien, nomMusicien, prenomMusicien, nomScene) VALUES (NULL, 'Diallo', 'Alpha', 'Black M');
INSERT INTO Musicien (identifiantMusicien, nomMusicien, prenomMusicien, nomScene) VALUES (NULL, 'Ballo', 'Karim', 'JR O Crom');
INSERT INTO Musicien (identifiantMusicien, nomMusicien, prenomMusicien, nomScene) VALUES (NULL, 'Vincent', 'Bastien', 'Maska');
INSERT INTO Musicien (identifiantMusicien, nomMusicien, prenomMusicien, nomScene) VALUES (NULL, 'Baldé', 'Mamadou', 'Doomams');
INSERT INTO Musicien (identifiantMusicien, nomMusicien, prenomMusicien, nomScene) VALUES (NULL, 'Fall', 'Abdel Karim', 'Lefa'); 

/* Ajout des groupes */
INSERT INTO Groupe (identifiantGroupe, nomGroupe, dateCreationGroupe, dateSeparationGroupe) VALUES (NULL, 'Black Eyed Peas', '1995', NULL);
INSERT INTO Groupe (identifiantGroupe, nomGroupe, dateCreationGroupe, dateSeparationGroupe) VALUES (NULL, 'The Beatles', '1962', '1970');
INSERT INTO Groupe (identifiantGroupe, nomGroupe, dateCreationGroupe, dateSeparationGroupe) VALUES (NULL, 'Sexion d Assaut', '2002', '2013');

/* Ajout des musiciens au groupe */
INSERT INTO FaitParti (identifiantGroupe, identifiantMusicien, roleGroupe, dateEntrerGroupe, dateSortieGroupe, membreFondateur) VALUES (1, 1, 'Chanteuse', '2003', '2010', 0);
INSERT INTO FaitParti (identifiantGroupe, identifiantMusicien, roleGroupe, dateEntrerGroupe, dateSortieGroupe, membreFondateur) VALUES (1, 2, 'Chanteure', '1995', NULL, 1);
INSERT INTO FaitParti (identifiantGroupe, identifiantMusicien, roleGroupe, dateEntrerGroupe, dateSortieGroupe, membreFondateur) VALUES (1, 3, 'Chanteure', '1995', NULL, 1);
INSERT INTO FaitParti (identifiantGroupe, identifiantMusicien, roleGroupe, dateEntrerGroupe, dateSortieGroupe, membreFondateur) VALUES (1, 4, 'Chanteuse', '1995', '2000', 0);
INSERT INTO FaitParti (identifiantGroupe, identifiantMusicien, roleGroupe, dateEntrerGroupe, dateSortieGroupe, membreFondateur) VALUES (1, 5, 'Chanteure', '1995', NULL, 0);

INSERT INTO FaitParti (identifiantGroupe, identifiantMusicien, roleGroupe, dateEntrerGroupe, dateSortieGroupe, membreFondateur) VALUES (2, 6, 'Guitariste', '1962', '1970', 1);
INSERT INTO FaitParti (identifiantGroupe, identifiantMusicien, roleGroupe, dateEntrerGroupe, dateSortieGroupe, membreFondateur) VALUES (2, 7, 'Bassiste', '1962', '1970', 1);
INSERT INTO FaitParti (identifiantGroupe, identifiantMusicien, roleGroupe, dateEntrerGroupe, dateSortieGroupe, membreFondateur) VALUES (2, 8, 'Batteur', '1962', '1970', 0);
INSERT INTO FaitParti (identifiantGroupe, identifiantMusicien, roleGroupe, dateEntrerGroupe, dateSortieGroupe, membreFondateur) VALUES (2, 9, 'Guitariste', '1962','1970', 0);
INSERT INTO FaitParti (identifiantGroupe, identifiantMusicien, roleGroupe, dateEntrerGroupe, dateSortieGroupe, membreFondateur) VALUES (2, 10, 'Guitariste, Bassiste', '1962','1970', 0);

INSERT INTO FaitParti (identifiantGroupe, identifiantMusicien, roleGroupe, dateEntrerGroupe, dateSortieGroupe, membreFondateur) VALUES (3, 11, 'Rappeur', '2002','2013', 1);
INSERT INTO FaitParti (identifiantGroupe, identifiantMusicien, roleGroupe, dateEntrerGroupe, dateSortieGroupe, membreFondateur) VALUES (3, 12, 'Rappeur', '2002','2013', 1);
INSERT INTO FaitParti (identifiantGroupe, identifiantMusicien, roleGroupe, dateEntrerGroupe, dateSortieGroupe, membreFondateur) VALUES (3, 13, 'Rappeur', '2002','2013', 1);
INSERT INTO FaitParti (identifiantGroupe, identifiantMusicien, roleGroupe, dateEntrerGroupe, dateSortieGroupe, membreFondateur) VALUES (3, 14, 'Rappeur', '2002','2013', 1);
INSERT INTO FaitParti (identifiantGroupe, identifiantMusicien, roleGroupe, dateEntrerGroupe, dateSortieGroupe, membreFondateur) VALUES (3, 15, 'Rappeur', '2002','2013', 1);
INSERT INTO FaitParti (identifiantGroupe, identifiantMusicien, roleGroupe, dateEntrerGroupe, dateSortieGroupe, membreFondateur) VALUES (3, 16, 'Rappeur', '2002','2013', 1);
INSERT INTO FaitParti (identifiantGroupe, identifiantMusicien, roleGroupe, dateEntrerGroupe, dateSortieGroupe, membreFondateur) VALUES (3, 17, 'Rappeur', '2002','2013', 1);

/* Ajout des groupes au Album */
INSERT INTO Enregistre (identifiantGroupe, identifiantAlbum) VALUES (1, 1);
INSERT INTO Enregistre (identifiantGroupe, identifiantAlbum) VALUES (2, 2);
INSERT INTO Enregistre (identifiantGroupe, identifiantAlbum) VALUES (3, 3);


/* Ajout des Chansons dans la base de donnees */
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Simply The Best", '2022-11-11', 1,  NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Muevelo", '2022-11-11', 1, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Audios", '2022-11-11', 1,  NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Double d'z", '2022-11-11', 1, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Bailar contigo", '2022-11-11', 1, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Get down", '2022-11-11', 1, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Dance 4 u", '2022-11-11', 1, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Guarantee", '2022-11-11', 1, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Filipina queen", '2022-11-11', 1, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Jump", '2022-11-11', 1, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "In the air", '2022-11-11', 1, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Fire starter", '2022-11-11',  1, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "No one loves me", '2022-11-11', 1, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Don't You Worry", '2022-11-11', 1, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "L.o.v.e.", '2022-11-11', 1, NULL);

INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Back In The U.S.S.R.", '1968-11-22', 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Dear Prudence", '1968-11-22', 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Glass Onion", '1968-11-22', 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Ob-La-Di, Ob-La-Da", '1968-11-22', 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Wild Honey Pie", '1968-11-22', 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "The Continuing Story Of Bungalow Bill", '1968-11-22', 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "While My Guitar Gently Weeps", '1968-11-22', 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Happiness Is A Warm Gun", '1968-11-22', 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Martha My Dear", '1968-11-22', 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "I'm So Tired", '1968-11-22', 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Blackbird", '1968-11-22', 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Piggies", '1968-11-22',2,  NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Rocky Raccoon", '1968-11-22', 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Don't Pass Me By", '1968-11-22', 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Why Don't We Do It In The Road?", '1968-11-22', 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "I Will", '1968-11-22', 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Julia", '1968-11-22', 2, NULL);

INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Intro", '2010-03-29', 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Casquette à l'envers", '2010-03-29', 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Mon gars sûr", '2010-03-29', 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "L'école des points vitaux", '2010-03-29', 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Ils appellent ça", '2010-03-29', 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Itinéraire d'un chômeur", '2010-03-29', 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "La drogue te donne des ailes", '2010-03-29', 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Tu l'as fait pour elle", '2010-03-29', 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Paname lève-toi", '2010-03-29', 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Tel père tel fils", '2010-03-29', 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Rien n' t'appartient", '2010-03-29', 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Changement d'ambiance", '2010-03-29', 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "J'ai pas les Loves", '2010-03-29', 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Ca chuchote", '2010-03-29', 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Wati by Night", '2010-03-29', 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Désolé", '2010-03-29', 3, NULL);

/* Ajout des genres dans la base de donnees */
INSERT INTO Genre(identifiantGenre, nomGenre, libelleTypeGenre) VALUES (NULL, "Hip-Hop", NULL);
INSERT INTO Genre(identifiantGenre, nomGenre, libelleTypeGenre) VALUES (NULL, "Rock", NULL);
INSERT INTO Genre(identifiantGenre, nomGenre, libelleTypeGenre) VALUES (NULL, "POP", NULL);

/* Ajout des genres au chanson */
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 1);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 2);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 3);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 4);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 5);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 6);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 7);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 8);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 9);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 10);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 11);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 12);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 13);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 14);

INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (2, 15);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 16);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 17);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 18);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 19);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 20);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 21);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 22);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 23);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 24);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 25);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 26);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 27);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 28);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 29);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 30);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 31);

INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 32);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 33);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 34);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 35);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 36);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 37);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 38);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 39);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 40);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 41);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 42);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 43);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 44);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 45);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 46);
INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES (3, 47);

/* Ajout des chanson au fichier audio */
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "Muevelo.mp3", '00:04:14', '2022-11-11', 2020, 102, NULL, 2);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "Audios.mp3", '00:03:40', '2022-11-11', 27520, 10102, NULL, 3);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "Double d'z.mp3", '00:03:20', '2022-11-11', 7520, 12, NULL, 4);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "Bailar contigo.mp3", '00:03:43', '2022-11-11', 70, 233, NULL, 5);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "Get down.mp3", '00:03:52', '2022-11-11', 7033, 2313, NULL, 6);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "Dance 4 u.mp3", '00:04:35', '2022-11-11', 72033, 231, NULL, 7);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "Guarantee.mp3", '00:03:40', '2022-11-11', 73, 2831, NULL, 8);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "Filipina queen.mp3", '00:03:30', '2022-11-11', 7323, 1831, NULL, 9);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "Jump.mp3", '00:03:36', '2022-11-11', 73223, 181, NULL, 10);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "In the air.mp3", '00:03:40', '2022-11-11', 709, 81, NULL, 11);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "Fire starter.mp3", '00:03:14', '2022-11-11', 7029, 8111, NULL, 12);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "No one loves me.mp3", '00:04:23', '2022-11-11', 71029, 11, NULL, 13);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "Don't You Worry.mp3", '00:03:14', '2022-11-11', 4029, 1001, NULL, 14);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "L.o.v.e..mp3", '00:03:57', '2022-11-11', 40129, 191, NULL, 15);

INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "REMASTERED", "Back In The U.S.S.R..mp3", '00:02:43', '1968-11-22', 1222, 191, NULL, 16);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "REMASTERED", "Dear Prudence.mp3", '00:03:55', '1968-11-22', 12122, 11191, NULL, 17);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "REMASTERED", "Glass Onion.mp3", '00:02:17', '1968-11-22', 12452, 111, NULL, 18);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "REMASTERED", "Ob-La-Di, Ob-La-Da.mp3", '00:03:08', '1968-11-22', 12952, 11001, NULL, 19);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "REMASTERED", "Wild Honey Pie.mp3", '00:03:52', '1968-11-22', 1292, 111, NULL, 20);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "REMASTERED", "The Continuing Story Of Bungalow Bill.mp3", '00:00:52', '1968-11-22', 1292, 111, NULL, 21);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "REMASTERED", "While My Guitar Gently Weeps.mp3", '00:03:14', '1968-11-22', 922, 901, NULL, 22);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "REMASTERED", "Happiness Is A Warm Gun.mp3", '00:04:45', '1968-11-22', 12912, 11, NULL, 23);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "REMASTERED", "Martha My Dear.mp3", '00:02:28', '1968-11-22', 12292, 1101, NULL, 24);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "REMASTERED", "I'm So Tired.mp3", '00:02:44', '1968-11-22', 122, 1101, NULL, 25);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "REMASTERED", "Blackbird.mp3", '00:05:43', '1968-11-22', 12332, 231, NULL, 26);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "REMASTERED", "Piggies.mp3", '00:03:28', '1968-11-22', 98932, 4038, NULL, 27);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "REMASTERED", "Rocky Raccoon.mp3", '00:02:48', '1968-11-22', 832, 892, NULL, 28);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "REMASTERED", "Don't Pass Me By.mp3", '00:03:50', '1968-11-22', 32, 4129, NULL, 29);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "REMASTERED", "Why Don't We Do It In The Road?.mp3", '00:01:41', '1968-11-22', 3209, 419, NULL, 30);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "REMASTERED", "I Will.mp3", '00:01:45', '1968-11-22', 2124, 29, NULL, 31);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "REMASTERED", "Julia.mp3", '00:02:56', '1968-11-22', 223124, 2339, NULL, 32);

INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "Intro.mp3", '00:07:10', '2010-03-29', 22321, 24339, NULL, 33);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "Casquette à l'envers.mp3", '00:04:43', '2010-03-29', 12311121, 1040339, NULL, 34);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "Mon gars sûr.mp3", '00:04:41', '2010-03-29', 213343, 10409, NULL, 35);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "L'école des points vitaux.mp3", '00:03:51', '2010-03-29', 43243, 8709, NULL, 36);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "Ils appellent ça.mp3", '00:05:00', '2010-03-29', 41243, 3409, NULL, 37);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "Itinéraire d'un chômeur.mp3", '00:04:17', '2010-03-29', 47643, 899, NULL, 38);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "La drogue te donne des ailes.mp3", '00:05:03', '2010-03-29', 31243, 9322, NULL, 39);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "Tu l'as fait pour elle.mp3", '00:04:06', '2010-03-29', 3123, 322, NULL, 40);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "Paname lève-toi.mp3", '00:04:13', '2010-03-29', 12823, 3322, NULL, 41);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "Tel père tel fils.mp3", '00:04:33', '2010-03-29', 2431, 9822, NULL, 42);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "Rien n' t'appartient.mp3", '00:05:24', '2010-03-29', 13431, 822, NULL, 43);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "Changement d'ambiance.mp3", '00:05:01', '2010-03-29', 1231, 3222, NULL, 43);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "J'ai pas les Loves.mp3", '00:05:36', '2010-03-29', 56431, 4522, NULL, 45);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "Ca chuchote.mp3", '00:03:42', '2010-03-29', 6731, 722, NULL, 46);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "Wati by Night.mp3", '00:04:08', '2010-03-29', 9543871, 5422, NULL, 47);
INSERT INTO FichierAudio(numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, "ORIGINAL", "Désolé.mp3", '00:03:24', '2010-03-29', 1000771, 532222, NULL, 48);

/* Insertion de lieux */
INSERT INTO Lieux(identifiantLieux, nomLieux, coordonneesLieux) VALUES (NULL, "Accor Arena", "48.83853603276041, 2.3785848204020192");
INSERT INTO Lieux(identifiantLieux, nomLieux, coordonneesLieux) VALUES (NULL, "Le Transbordeur", "45.78389428150223, 4.860441760475767");
INSERT INTO Lieux(identifiantLieux, nomLieux, coordonneesLieux) VALUES (NULL, "Stade de France", "48.92445389223188, 2.3601618162509532");
INSERT INTO Lieux(identifiantLieux, nomLieux, coordonneesLieux) VALUES (NULL, "La Cigale", "48.88251870962403, 2.3401513043013047");
INSERT INTO Lieux(identifiantLieux, nomLieux, coordonneesLieux) VALUES (NULL, "Uuma", "48.890974872927885, 2.3233270000212354");
