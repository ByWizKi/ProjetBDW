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
		$requeteForFichierAudio = "INSERT INTO FichierAudio (numeroVersion, libelleVersion, nomFichierAudio, dureeVersion, dateCreationVersion, playCount, skipCount, descriptionVersion, identifiantChanson) VALUES (NULL, '$version', '$nomFichier', '00:$duree', '$dateSortie', 0, 0, NULL, $lastChanson[0]);";
		$res3 = mysqli_query($connexion, $requeteForFichierAudio);

		if($res1 == true and $res2 == true and $res3 == true ){
			return true;// les requetes on ete transmise et excuter avec succes
		}

		else{
			return false;
		}

	}
}
?>