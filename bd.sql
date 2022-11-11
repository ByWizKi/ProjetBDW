CREATE TABLE Groupe (
    identifiantGroupe INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
    nomGroupe VARCHAR(255), 
    dateCreationGroupe DATE, 
    dateSeparationGroupe DATE);


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
    dateCreationPlaylist DATE DEFAULT CURRENT_TIMESTAMP);

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
    dateEntrerGroupe DATE,
    dateSortieGroupe DATE,
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
