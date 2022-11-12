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
    identifiantLieux INT NOT NULL,
    FOREIGN KEY(identifiantGroupe) REFERENCES Groupe(identifiantGroupe),
    FOREIGN KEY(identifiantLieux) REFERENCES Lieux(identifiantLieux));


CREATE TABLE FichierAudio(
    numeroVersion INT UNIQUE NOT NULL,
    libelleVersion VARCHAR(255),
    nomFichierAudio VARCHAR(255),
    dureeVersion TIME CHECK (dureeVersion > '00:00:00' AND dureeVersion <= '23:59:59'),
    dateCreationVersion DATE DEFAULT CURRENT_DATE(),
    playCount INT DEFAULT 0,
    skipCount INT DEFAULT 0,
    descriptionVersion VARCHAR(255),
    identifiantChanson INT NOT NULL,
    PRIMARY KEY (identifiantChanson, numeroVersion),
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

INSERT INTO Album (identifiantAlbum, libelleAlbum, titreAlbum, dateSortieAlbum, nomProducteur, nomIngenieurSon, descriptionAlbum) VALUES (NULL, 'AlbumStudio', 'Elevation', '2022-11-11', 'BEP Music', 'Michel Son', NULL);
INSERT INTO Album (identifiantAlbum, libelleAlbum, titreAlbum, dateSortieAlbum, nomProducteur, nomIngenieurSon, descriptionAlbum) VALUES (NULL, 'AlbumCompilation', 'The Beatles', '1968-11-22', 'Calderstone Productions Limited', NULL, 'Double Album Du groupe The Beatles');
INSERT INTO Album (identifiantAlbum, libelleAlbum, titreAlbum, dateSortieAlbum, nomProducteur, nomIngenieurSon, descriptionAlbum) VALUES (NULL, 'AlbumStudio', 'Ecole des points vitaux', '2010-03-29', 'WHATI-B', 'Renaud Son', NULL);

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

INSERT INTO Groupe (identifiantGroupe, nomGroupe, dateCreationGroupe, dateSeparationGroupe) VALUES (NULL, 'Black Eyed Peas', '1995', NULL);
INSERT INTO Groupe (identifiantGroupe, nomGroupe, dateCreationGroupe, dateSeparationGroupe) VALUES (NULL, 'The Beatles', '1962', '1970');
INSERT INTO Groupe (identifiantGroupe, nomGroupe, dateCreationGroupe, dateSeparationGroupe) VALUES (NULL, 'Sexion d Assaut', '2002', '2013');

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

INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Simply The Best", 1, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Muevelo", 1, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Audios", 1, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Double d'z", 1, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Bailar contigo", 1, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Get down", 1, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Dance 4 u", 1, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Guarantee", 1, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Filipina queen", 1, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Jump", 1, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "In the air", 1, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Fire starter", 1, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "No one loves me", 1, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Don't You Worry", 1, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "L.o.v.e.", 1, NULL);

INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Back In The U.S.S.R.", 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Dear Prudence", 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Glass Onion", 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Ob-La-Di, Ob-La-Da", 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Wild Honey Pie", 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "The Continuing Story Of Bungalow Bill", 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "While My Guitar Gently Weeps", 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Happiness Is A Warm Gun", 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Martha My Dear", 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "I'm So Tired", 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Blackbird", 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Piggies", 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Rocky Raccoon", 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Don't Pass Me By", 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Why Don't We Do It In The Road?", 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "I Will", 2, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Julia", 2, NULL);

INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Intro", 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Casquette à l'envers", 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Mon gars sûr", 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "L'école des points vitaux", 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Ils appellent ça", 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Itinéraire d'un chômeur", 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "La drogue te donne des ailes", 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Tu l'as fait pour elle", 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Paname lève-toi", 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Tel père tel fils", 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Rien n' t'appartient", 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Changement d'ambiance", 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "J'ai pas les Loves", 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Ca chuchote", 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Wati by Night", 3, NULL);
INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, "Désolé", 3, NULL);

INSERT INTO GENRE(identifiantGenre, nomGenre, libelleTypeGenre) VALUES (NULL, "Hip-Hop", NULL);
INSERT INTO GENRE(identifiantGenre, nomGenre, libelleTypeGenre) VALUES (NULL, "Rock", NULL);
INSERT INTO GENRE(identifiantGenre, nomGenre, libelleTypeGenre) VALUES (NULL, "POP", NULL);


INSERT INTO APourGenre(identifiantGenre, identifiantChanson) VALUES ();
 