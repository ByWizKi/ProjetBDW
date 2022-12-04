<?php
// Connexion base de donnees
function getConnexionBD() {
	$connexion = mysqli_connect(SERVEUR, UTILISATRICE, MOTDEPASSE, BDD);
	if (mysqli_connect_errno()) {
	    printf("Échec de la connexion : %s\n", mysqli_connect_error());
	    exit();
	}
	mysqli_query($connexion,'SET NAMES UTF8'); // noms en UTF8
	return $connexion;
}

//Deconnexion base de donnees
function deconnectBD($connexion) {
	mysqli_close($connexion);
}

//nombre d'element dans une table

function nombreElementTable($connexion, $nomTable){
	$nomTable = mysqli_real_escape_string($connexion, $nomTable);
	$requete = "SELECT COUNT(*) AS nbElementTable From $nomTable;";
	$res = mysqli_query($connexion, $requete);
	if ($res != FALSE){
		$row = mysqli_fetch_assoc($res);
		return $row['nbElementTable'];
	} 
	return "Erreur la table n'existe pas";
}

function topElementChanson($connexion){
	$requete = "SELECT titreChanson AS titre From Chanson INNER JOIN FichierAudio ON Chanson.identifiantChanson = FichierAudio.identifiantChanson ORDER BY FichierAudio.playCount DESC;";
	$res = mysqli_query($connexion, $requete);
	$resFinal = mysqli_fetch_all($res, MYSQLI_ASSOC);
	return $resFinal;
}

function topElementGenre($connexion){
	$requete = "SELECT nomGenre AS nom FROM Genre NATURAL JOIN APourGenre NATURAL JOIN Chanson NATURAL JOIN FichierAudio GROUP BY Genre.nomGenre ORDER BY FichierAudio.playCount DESC;";
	$res = mysqli_query($connexion, $requete);
	$resFinal = mysqli_fetch_all($res, MYSQLI_ASSOC);
	return $resFinal;
}

function topElementAlbum($connexion){
	$requete = "SELECT titreAlbum FROM Album NATURAL JOIN Chanson NATURAL JOIN FichierAudio GROUP BY titreAlbum ORDER BY FichierAudio.playCount DESC;";
	$res = mysqli_query($connexion, $requete);
	$resFinal = mysqli_fetch_all($res, MYSQLI_ASSOC);
	return $resFinal;
}

function informationTable($connexion, $nomTable){
	$nomTable = mysqli_real_escape_string($connexion, $nomTable);
	if ($nomTable == 'Chanson'){
		$requete = "SELECT titreChanson, nomGroupe, dureeVersion, libelleVersion From Chanson NATURAL JOIN Groupe NATURAL JOIN FichierAudio;";
	}
	elseif($nomTable == 'Groupe'){
		$requete = "SELECT nomGroupe, COUNT(titreChanson)AS nb_Chanson, dateCreationGroupe FROM Groupe NATURAL JOIN Chanson GROUP BY nomGroupe;";
	}

	elseif($nomTable == 'Genre'){
		$requete = "SELECT DISTINCT nomGenre FROM Genre;";
	}

	elseif($nomTable == 'Album'){
		$requete = "SELECT titreAlbum, dateSortieAlbum FROM Album NATURAL JOIN Enregistre NATURAL JOIN Groupe NATURAL JOIN Chanson GROUP BY titreAlbum;";
	}
	else{
		$requete = "SELECT * FROM $nomTable;";
	}

	$res = mysqli_query($connexion, $requete);
	$infoTable = mysqli_fetch_all($res, MYSQLI_ASSOC);
	return $infoTable;
}

function recherche($connexion, $nomTable, $texteRecherche) {
	$texteRecherche = mysqli_real_escape_string($connexion, $texteRecherche);

	if ($nomTable == 'Chanson'){
		
		$requete = 'SELECT titreChanson, nomGroupe, dureeVersion, libelleVersion From Chanson NATURAL JOIN Groupe NATURAL JOIN FichierAudio WHERE titreChanson LIKE \'%'.$texteRecherche.'%\';';

	}

	elseif($nomTable == 'Groupe'){
		$requete = 'SELECT nomGroupe, COUNT(titreChanson)AS nb_Chanson, dateCreationGroupe FROM Groupe NATURAL JOIN Chanson WHERE nomGroupe LIKE \'%'.$texteRecherche.'%\' GROUP BY nomGroupe;';

	}

	elseif($nomTable == 'Musicien'){
		$requete = 'SELECT prenomMusicien, nomMusicien, nomScene FROM Musicien WHERE nomScene LIKE \'%'.$texteRecherche.'%\';';

	}

	elseif($nomTable == 'Genre'){
		$requete = 'SELECT DISTINCT nomGenre FROM Genre WHERE nomGenre LIKE \'%'.$texteRecherche.'%\';';

	}

	elseif($nomTable == 'Album'){

		$requete = 'SELECT titreAlbum, dateSortieAlbum FROM Album NATURAL JOIN Enregistre NATURAL JOIN Groupe NATURAL JOIN Chanson WHERE titreAlbum LIKE \'%'.$texteRecherche.'%\'GROUP BY titreAlbum;';
	}
	$res = mysqli_query($connexion, $requete);
	$rechercheTable = mysqli_fetch_all($res, MYSQLI_ASSOC);
	return $rechercheTable;

}

function getNomGroupe($connexion){
	$requete = "SELECT identifiantGroupe, nomGroupe FROM Groupe;";
	$res = mysqli_query($connexion, $requete);
	$resFinal = mysqli_fetch_all($res, MYSQLI_ASSOC);
	return $resFinal;
}

function getNomGenre($connexion){
	$requete = "SELECT DISTINCT identifiantGenre, nomGenre FROM Genre;";
	$res = mysqli_query($connexion, $requete);
	$resFinal = mysqli_fetch_all($res, MYSQLI_ASSOC);
	return $resFinal;
}

function chansonExiste($connexion, $titre, $version, $groupe){
	$version = strtoupper($version);
	$requete = "SELECT titreChanson FROM Chanson NATURAL JOIN Groupe NATURAL JOIN FichierAudio WHERE titreChanson = '$titre' AND libelleVersion = '$version' AND identifiantGroupe = $groupe;";
	$res = mysqli_query($connexion, $requete);
	if ($res != FALSE){
		$resFinal = mysqli_fetch_all($res, MYSQLI_ASSOC);
		if(count($resFinal) == 0){
			
			return true;
		}
		else{
			return false;
		}
	}
	return -1;
}


function insertInto($connexion, $titre, $idGroupe, $idGenre, $version, $duree, $dateSortie){
	//Convertion des donnees du formaulaire
	$titre = mysqli_real_escape_string($connexion, $titre); 
	$version = mysqli_real_escape_string($connexion, $version);
	$version = strtoupper($version);
	$testChansonExist = chansonExiste($connexion, $titre, $version, $idGroupe);
	if($testChansonExist==false){
		return false;//impossible d'ajouter la chanson
	}

	else{
		//Ajout de la chanson dans la table chanson
		$requeteForChanson = "INSERT INTO Chanson(identifiantChanson, titreChanson, dateCreationChanson, identifiantGroupe, identifiantLieux) VALUES (NULL, '$titre', '$dateSortie', $idGroupe, NULL);";
		$res1 = mysqli_query($connexion, $requeteForChanson);
		//Convertion du nom du fichier
		$nomFichier = $titre.'.mp3';

		//Recuperation de l'identifiant de la nouvelle chanson ajouter
		$requeteChanson = "SELECT identifiantChanson AS id FROM Chanson WHERE '$titre' = titreChanson ORDER BY identifiantChanson DESC;";
		$res= mysqli_query($connexion, $requeteChanson);
		if ($res != FALSE){
			$lastChanson = mysqli_fetch_row($res);
		} 

		//Ajout du genre de la chanson
		$requeteForApourGenre = "INSERT INTO APourGenre (identifiantGenre, identifiantChanson) VALUES ($idGenre, $lastChanson[0]);";
		$res2 = mysqli_query($connexion, $requeteForApourGenre);

		//Ajout de la version dans la table ficher audio
		$requeteForFichierAudio = "INSERT INTO FichierAudio (numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, '$version', '$nomFichier', '$duree', '$dateSortie', 0, 0, NULL, $lastChanson[0]);";
		$res3 = mysqli_query($connexion, $requeteForFichierAudio);

		if($res1 == true and $res2 == true and $res3 == true ){
			return true;// les requetes on ete transmise et excuter avec succes
		}

		else{
			return false;
		}

	}
}

function randomName($connexion, $genre){
	// recupe de tout les noms est identifant dans l'ordre dec
	$requete = "SELECT identifiantPlaylist FROM Playlist ORDER BY identifiantPlaylist DESC";
	$res = mysqli_query($connexion, $requete);
	$resultat = mysqli_fetch_all($res, MYSQLI_ASSOC);
	if(count($resultat) == 0){
		$lastID = 1;
	}

	else
	{
		$lastID = $resultat[0]['identifiantPlaylist'] + 1;
	}

	// test si genre est null 
	if($genre != NULL)
	{
		$nomPlaylist = "Playlist"." ".$genre." ".$lastID;
		return $nomPlaylist;
	}

	else
	{
		$nomPlaylist = "Playlist"." ".$lastID;
		return $nomPlaylist;
	}
}

function namePlaylistExiste($connexion, $nomPlaylist){
	$requete = "SELECT nomPlaylist FROM Playlist WHERE '$nomPlaylist' = nomPlaylist";
	$res = mysqli_query($connexion, $requete);
	$resultat = mysqli_fetch_all($res, MYSQLI_ASSOC);
	if(count($resultat) == 0){
		return false;
	}
	else{
		return true;
	}
}

function createPlaylist($connexion, $nomPlaylist, $genrePlaylist, $timePlaylist, $pref, $percPref){
	// test si le nom == null
	if ($nomPlaylist == NULL)
	{
		$nomPlaylist = randomName($connexion, $genrePlaylist);
	}

	// test de si le nom de la playlist existe
	if(namePlaylistExiste($connexion, $nomPlaylist) == true){
		return false;
	}

	// ajout de la playlist dans le bd
	$requete = "INSERT INTO Playlist (identifiantPlaylist, nomPlaylist) VALUES (NULL, '$nomPlaylist')";
	$res = mysqli_query($connexion, $requete);
	if($res == true){
		//recup l'identifiant de la derniere playlist creer
		$requete2 = "SELECT identifiantPlaylist FROM Playlist ORDER BY dateCreationPlaylist DESC";
		$res2 = mysqli_query($connexion, $requete2);
		$resultatIdPlaylist = mysqli_fetch_all($res2, MYSQLI_ASSOC);
		$idPlaylist = $resultatIdPlaylist[0]['identifiantPlaylist'];

		// ajout des musique dans la base donnees
		insertMusicIntoPlaylist($connexion, $idPlaylist, $genrePlaylist, $timePlaylist, $pref, $percPref);
		return true;
	}
	return false;
	
}

function insertMusicIntoPlaylist($connexion, $idPlaylist, $genre, $time, $pref, $percPerf){

	//test si time est null
	if($time == NULL)
	{
		$requeteTime = "SELECT TIME_TO_SEC('00:20:00') AS 'time'";
		$resTime = mysqli_query($connexion, $requeteTime);
		$time = mysqli_fetch_assoc($resTime)['time'];
	}

	else
	{
		$requeteTime = "SELECT TIME_TO_SEC('$time') AS 'time'";
		$resTime = mysqli_query($connexion, $requeteTime);
		$time = mysqli_fetch_assoc($resTime)['time'];

	}

	//test si genre est null
	if($genre != NULL)
	{
		if($pref != NULL){
			// recup les donnees selon le genre et la pref
			$requetePrefGenre = "SELECT identifiantChanson, numeroVersion FROM FichierAudio NATURAL JOIN APourGenre NATURAL JOIN Genre WHERE '$genre' = nomGenre ORDER BY '$pref' DESC; ";
			$resPrefGenre = mysqli_query($connexion, $requetePrefGenre);
			$prefGenre = mysqli_fetch_all($resPrefGenre, MYSQLI_ASSOC);
		}
		else{
			// recup les donnees selon le genre
			$requeteGenre = "SELECT identifiantChanson, numeroVersion FROM FichierAudio NATURAL JOIN APourGenre NATURAL JOIN Genre WHERE '$genre' = nomGenre;";
			$resGenre = mysqli_query($connexion, $requeteGenre);
			$prefGenre = mysqli_fetch_all($resGenre, MYSQLI_ASSOC);
		}
	}
	// test si pref est null
	elseif($pref != NULL)
	{
		if ($pref = 'MorePlayCount')
		{
			$requetePref = "SELECT identifiantChanson, numeroVersion FROM FichierAudio NATURAL JOIN APourGenre NATURAL JOIN Genre ORDER BY '$pref' DESC ;";
			$resPref = mysqli_query($connexion, $requetePref);
			$prefData = mysqli_fetch_all($resPref, MYSQLI_ASSOC);
		}
		else
		{
			$requetePref = "SELECT identifiantChanson, numeroVersion FROM FichierAudio NATURAL JOIN APourGenre NATURAL JOIN Genre ORDER BY '$pref' ASC ;";
			$resPref = mysqli_query($connexion, $requetePref);
			$prefData = mysqli_fetch_all($resPref, MYSQLI_ASSOC);
		}
	}
	// recup les donnnes sans filtre
	$requeteAllSong = "SELECT identifiantChanson, numeroVersion FROM FichierAudio;";
	$resAllSong = mysqli_query($connexion, $requeteAllSong);
	$allSong= mysqli_fetch_all($resAllSong, MYSQLI_ASSOC);
	

	$compteur = $time;
	$compteur2 = $time;

	while(($compteur > 0))
	{
		if ($pref == NULL && $genre == NULL)
		{
			$randomInt = random_int(0, count($allSong)-1);
			$requeteNoPref = "INSERT INTO Contient (identifiantPlaylist, identifiantChanson, numeroVersion) VALUES ($idPlaylist, ".$allSong[$randomInt]['identifiantChanson'].", ".$allSong[$randomInt]['numeroVersion'].");";
			$resNoPref = mysqli_query($connexion, $requeteNoPref);
			// recup de la duree de la derniere musique ajouter a la playlist 
			$requeteLastInsertInPlaylist = "SELECT TIME_TO_SEC(dureeVersion) AS 'time' FROM FichierAudio WHERE identifiantChanson IN(SELECT identifiantChanson FROM Contient ORDER BY dateAjoutPlaylist DESC) 
			AND numeroVersion IN (SELECT numeroVersion FROM Contient ORDER BY dateAjoutPlaylist DESC) ;";
			$resLastInsertInPlaylist = mysqli_query($connexion, $requeteLastInsertInPlaylist);
			$lastInsertInPlaylist = mysqli_fetch_assoc($resLastInsertInPlaylist)['time'];
			$compteur = $compteur - $lastInsertInPlaylist;
		}

		elseif($pref != NULL && $genre == NULL)
		{	
			echo " je suis la";
			while($compteur >= $compteur2*((100-$percPerf)/100))
			{
				$randomInt = random_int(0, count($prefData)/2);
				$requetePref = "INSERT INTO Contient (identifiantPlaylist, identifiantChanson, numeroVersion) VALUES ($idPlaylist, ".$prefData[$randomInt]['identifiantChanson'].", ".$prefData[$randomInt]['numeroVersion'].");";
				$resPref = mysqli_query($connexion, $requetePref);
				// recup de la duree de la derniere musique ajouter a la playlist 
				$requeteLastInsertInPlaylist = "SELECT TIME_TO_SEC(dureeVersion) AS 'time' FROM FichierAudio WHERE identifiantChanson IN(SELECT identifiantChanson FROM Contient ORDER BY dateAjoutPlaylist DESC) 
				AND numeroVersion IN (SELECT numeroVersion FROM Contient ORDER BY dateAjoutPlaylist DESC) ;";
				$resLastInsertInPlaylist = mysqli_query($connexion, $requeteLastInsertInPlaylist);
				$lastInsertInPlaylist = mysqli_fetch_assoc($resLastInsertInPlaylist)['time'];
				$compteur = $compteur - $lastInsertInPlaylist;
				
			}
			$pref = NULL;
		}

		elseif($pref == NULL && $genre != NULL)
		{	
			$randomInt = random_int(0, count($prefGenre)-1);
			$requeteWithGenre = "INSERT INTO Contient (identifiantPlaylist, identifiantChanson, numeroVersion) VALUES ($idPlaylist, ".$prefGenre[$randomInt]['identifiantChanson'].", ".$prefGenre[$randomInt]['numeroVersion'].");";
			$resWithGenre = mysqli_query($connexion, $requeteWithGenre);
			// recup de la duree de la derniere musique ajouter a la playlist 
			$requeteLastInsertInPlaylist = "SELECT TIME_TO_SEC(dureeVersion) AS 'time' FROM FichierAudio WHERE identifiantChanson IN(SELECT identifiantChanson FROM Contient ORDER BY dateAjoutPlaylist DESC) 
			AND numeroVersion IN (SELECT numeroVersion FROM Contient ORDER BY dateAjoutPlaylist DESC) ;";
			$resLastInsertInPlaylist = mysqli_query($connexion, $requeteLastInsertInPlaylist);
			$lastInsertInPlaylist = mysqli_fetch_assoc($resLastInsertInPlaylist)['time'];
			$compteur = $compteur - $lastInsertInPlaylist;
			if($compteur > 0){$genre=NULL;}
		}

		else
		{	
			while($compteur*($percPerf/100) >= $compteur*(100-$percPerf/100))
			{
				$randomInt = random_int(0, count($prefGenre)/2);
				$requetePrefGenre = "INSERT INTO Contient (identifiantPlaylist, identifiantChanson, numeroVersion) VALUES ($idPlaylist, ".$prefGenre[$randomInt]['identifiantChanson'].", ".$prefGenre[$randomInt]['numeroVersion'].");";
				$resPrefGenre = mysqli_query($connexion, $requetePrefGenre);
				// recup de la duree de la derniere musique ajouter a la playlist 
				$requeteLastInsertInPlaylist = "SELECT TIME_TO_SEC(dureeVersion) AS 'time' FROM FichierAudio WHERE identifiantChanson IN(SELECT identifiantChanson FROM Contient ORDER BY dateAjoutPlaylist DESC) 
				AND numeroVersion IN (SELECT numeroVersion FROM Contient ORDER BY dateAjoutPlaylist DESC) ;";
				$resLastInsertInPlaylist = mysqli_query($connexion, $requeteLastInsertInPlaylist);
				$lastInsertInPlaylist = mysqli_fetch_assoc($resLastInsertInPlaylist)['time'];
				$compteur = $compteur - $lastInsertInPlaylist;

			}
			$pref = NULL;
		}
	}
}

function getAllPlaylist($connexion){
	$requete = "SELECT DISTINCT * FROM Playlist";
	$res = mysqli_query($connexion, $requete);
	$allPlaylist = mysqli_fetch_all($res, MYSQLI_ASSOC);
	return $allPlaylist;
}

function getAllSong($connexion){
	$requete = "SELECT titreChanson, numeroVersion, libelleVersion,identifiantChanson FROM FichierAudio NATURAL JOIN Chanson";
	$res = mysqli_query($connexion, $requete);
	$allSong = mysqli_fetch_all($res, MYSQLI_ASSOC);
	return $allSong;
}

function getAllSongFromPlaylist($connexion, $idPlaylist){
	$requete = "SELECT identifiantPlaylist, numeroVersion, identifiantChanson, titreChanson, libelleVersion FROM FichierAudio NATURAL JOIN Contient NATURAL JOIN Chanson 
	WHERE Contient.identifiantPlaylist = $idPlaylist; ";
	$res = mysqli_query($connexion, $requete);
	$allSongFPL = mysqli_fetch_all($res, MYSQLI_ASSOC);
	return $allSongFPL;
}

function addPlaylist($connexion, $idPlaylist, $numeroVersion){
	$requeteBis = "SELECT identifiantChanson FROM FichierAudio WHERE $numeroVersion=numeroVersion;";
	$resBis = mysqli_query($connexion, $requeteBis);
	$idChanson = mysqli_fetch_assoc($resBis);
	$requete = "INSERT INTO Contient (identifiantPlaylist, identifiantChanson, numeroVersion) VALUES ($idPlaylist, ".$idChanson['identifiantChanson']." , $numeroVersion);";
	$res = mysqli_query($connexion, $requete);
	if($res ==true){return true;}
	else{return false;}
}

function delPlaylist($connexion, $idPlaylist, $numeroVersion){
	$requeteBis = "SELECT identifiantChanson FROM FichierAudio WHERE $numeroVersion=numeroVersion;";
	$resBis = mysqli_query($connexion, $requeteBis);
	$idChanson = mysqli_fetch_assoc($resBis);
	$requete = "DELETE FROM Contient WHERE identifiantChanson = ".$idChanson['identifiantChanson']." AND identifiantPlaylist = $idPlaylist AND numeroVersion = $numeroVersion;";
	$res = mysqli_query($connexion, $requete);
	if($res == true){return true;}
	else{return false;}
}

function getInfoAboutPlaylist($connexion, $idPlaylist){
	$requete = "SELECT identifiantPlaylist, nomPlaylist, DATE_FORMAT(SEC_TO_TIME(SUM(TIME_TO_SEC(dureeVersion))), '%imin%ssec') AS 
	dureePlaylist, COUNT(numeroVersion) AS numSong FROM Contient NATURAL JOIN FichierAudio NATURAL JOIN Playlist WHERE Playlist.identifiantPlaylist = $idPlaylist";
	$res = mysqli_query($connexion, $requete);
	$info = mysqli_fetch_all($res, MYSQLI_ASSOC);
	return $info;
}

?>