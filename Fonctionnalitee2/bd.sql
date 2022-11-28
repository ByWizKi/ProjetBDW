CREATE TABLE Groupe(
   identifiantGroupe INT,
   nomGroupe VARCHAR(255),
   dateCreationGroupe DATE,
   dateSeparationGroupe DATE,
   PRIMARY KEY(identifiantGroupe)
);

CREATE TABLE Musicien(
   identifiantMusicien INT,
   nomMusicien VARCHAR(255),
   prenomMusicien VARCHAR(255),
   nomScene VARCHAR(255),
   PRIMARY KEY(identifiantMusicien)
);

CREATE TABLE Genre(
   identifiantGenre INT,
   nomGenre VARCHAR(255),
   libelleTypeGenre VARCHAR(255),
   PRIMARY KEY(identifiantGenre)
);


CREATE TABLE Album(
   identifiantAlbum INT,
   titreAlbum VARCHAR(255),
   libelleAlbum VARCHAR(255),
   dateSortieAlbum DATE,
   nomProducteur VARCHAR(255),
   nomIngenieurSon VARCHAR(255),
   descriptionAlbum VARCHAR(255),
   PRIMARY KEY(identifiantAlbum),
   CONSTRAINT CHK_libelleAlbum CHECK (libelleAlbum = "AlbumStudio" OR libelleAlbum = "AlbumCompilation" OR libelleAlbum = "AlbumLives")
);

CREATE TABLE Lieux(
   identifiantLieux INT,
   nomLieux VARCHAR(255),
   coordonneesLieux VARCHAR(255),
   PRIMARY KEY(identifiantLieux)
);

CREATE TABLE Playlist(
   identifiantPlaylist INT,
   nomPlaylist VARCHAR(255),
   dateCreationPlaylist DATE,
   PRIMARY KEY(identifiantPlaylist)
);

CREATE TABLE Chanson(
   identifiantChanson INT,
   titreChanson VARCHAR(255),
   dateCreationChanson DATE,
   identifiantGroupe INT NOT NULL,
   identifiantLieux INT NOT NULL,
   PRIMARY KEY(identifiantChanson),
   FOREIGN KEY(identifiantGroupe) REFERENCES Groupe(identifiantGroupe),
   FOREIGN KEY(identifiantLieux) REFERENCES Lieux(identifiantLieux)
);

CREATE TABLE FichierAudio(
   numeroVersion INT,
   libelleVersion VARCHAR(255),
   nomFichierAudio VARCHAR(255),
   dureeVersion TIME,
   dateCreationVersion DATE,
   playCount INT,
   skipCount INT,
   descriptionVersion VARCHAR(255),
   identifiantChanson INT NOT NULL,
   PRIMARY KEY(numeroVersion),
   FOREIGN KEY(identifiantChanson) REFERENCES Chanson(identifiantChanson)
);

CREATE TABLE ProprieteesVersion(
   identifiantPropriete VARCHAR(255),
   nomPropriete VARCHAR(255),
   valeurPropriete VARCHAR(255),
   PRIMARY KEY(identifiantPropriete),
   UNIQUE(nomPropriete)
);

CREATE TABLE Interprete(
   identifiantGroupe INT,
   numeroVersion INT,
   PRIMARY KEY(identifiantGroupe, numeroVersion),
   FOREIGN KEY(identifiantGroupe) REFERENCES Groupe(identifiantGroupe),
   FOREIGN KEY(numeroVersion) REFERENCES FichierAudio(numeroVersion)
);

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
   dateEntrerGroupe DATE,
   dateSortieGroupe DATE,
   membreFondateur LOGICAL,
   PRIMARY KEY(identifiantGroupe, identifiantMusicien),
   FOREIGN KEY(identifiantGroupe) REFERENCES Groupe(identifiantGroupe),
   FOREIGN KEY(identifiantMusicien) REFERENCES Musicien(identifiantMusicien)
);

CREATE TABLE Contient(
   identifiantPlaylist INT,
   numeroVersion INT,
   dateAjoutPlaylist DATETIME,
   PRIMARY KEY(identifiantPlaylist, numeroVersion),
   FOREIGN KEY(identifiantPlaylist) REFERENCES Playlist(identifiantPlaylist),
   FOREIGN KEY(numeroVersion) REFERENCES FichierAudio(numeroVersion)
);

CREATE TABLE Produit(
   identifiantGroupe INT,
   identifiantLieux INT,
   identifiantAlbum INT,
   dateProduction DATETIME,
   PRIMARY KEY(identifiantGroupe, identifiantLieux, identifiantAlbum),
   UNIQUE(dateProduction),
   FOREIGN KEY(identifiantGroupe) REFERENCES Groupe(identifiantGroupe),
   FOREIGN KEY(identifiantLieux) REFERENCES Lieux(identifiantLieux),
   FOREIGN KEY(identifiantAlbum) REFERENCES AlbumLives(identifiantAlbum)
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
   numeroVersion INT,
   numeroPisteChanson INT,
   PRIMARY KEY(identifiantAlbum, numeroVersion),
   FOREIGN KEY(identifiantAlbum) REFERENCES Album(identifiantAlbum),
   FOREIGN KEY(numeroVersion) REFERENCES FichierAudio(numeroVersion)
);

CREATE TABLE RelationChanson(
   identifiantChanson INT,
   identifiantChanson_1 INT,
   libelleTypeRelation VARCHAR(255),
   PRIMARY KEY(identifiantChanson, identifiantChanson_1),
   FOREIGN KEY(identifiantChanson) REFERENCES Chanson(identifiantChanson),
   FOREIGN KEY(identifiantChanson_1) REFERENCES Chanson(identifiantChanson)
);

CREATE TABLE RelationGenre(
   identifiantGenre INT,
   identifiantGenre_1 INT,
   PRIMARY KEY(identifiantGenre, identifiantGenre_1),
   FOREIGN KEY(identifiantGenre) REFERENCES Genre(identifiantGenre),
   FOREIGN KEY(identifiantGenre_1) REFERENCES Genre(identifiantGenre)
);

CREATE TABLE APourPropriete(
   numeroVersion INT,
   identifiantPropriete VARCHAR(255),
   PRIMARY KEY(numeroVersion, identifiantPropriete),
   FOREIGN KEY(numeroVersion) REFERENCES FichierAudio(numeroVersion),
   FOREIGN KEY(identifiantPropriete) REFERENCES ProprieteesVersion(identifiantPropriete)
);
