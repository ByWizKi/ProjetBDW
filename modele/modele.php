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
	$requete = "SELECT COUNT(*) AS nbElementTable From $nomTable";
	$res = mysqli_query($connexion, $requete);
	if ($res != true){
		$row = mysqli_fetch_row($res);
		return $row['nb'];

	} 
	return "Erreur la table n'existe pas";

}

function topElementChanson($connexion){

	$requete = "SELECT titreChanson AS titre From Chanson INNER JOIN FichierAudio ON Chanson.identifiantChanson = FichierAudio.identifiantChanson ORDER BY FichierAudio.playCount ASC";
	$res = mysqli_query($connexion, $requete);
	$resFinal = mysqli_fetch_all($res, MYSQLI_ASSOC);
	return $resFinal;
}

function topElementGenre($connexion){

	$requete = "SELECT nomGenre AS nom FROM Genre NATURAL JOIN APourGenre NATURAL JOIN Chanson NATURAL JOIN FichierAudio GROUP BY Genre.nomGenre ORDER BY FichierAudio.playCount ASC";
	$res = mysqli_query($connexion, $requete);
	$resFinal = mysqli_fetch_all($res, MYSQLI_ASSOC);
	return $res;
}

function topElementAlbum($connexion){

	$requete = "SELECT titreAlbum FROM Album NATURAL JOIN Chanson NATURAL JOIN FichierAudio GROUP BY titreAlbum ORDER BY FichierAudio.playCount ASC";
	$res = mysqli_query($connexion, $requete);
	$resFinal = mysqli_fetch_all($res, MYSQLI_ASSOC);
	return $resFinal;
}

function informationTable($connexion, $nomTable){
	$nomTable = mysqli_real_escape_string($connexion, $nomTable);
	if ($nomTable = "Chanson"){
		$requete = "SELECT titreChanson nomGroupe, dureeVersion, libelleVersion From Chanson NATURAL JOIN Groupe NATURAL JOIN FichierAudio";
	}
	elseif($nomTable = "Groupe"){
		$requete = "SELECT nomGroupe, COUNT(titreChanson), dateCreationGroupe FROM Groupe NATURAL JOIN Chanson GROUP BY nomGroupe";
	}

	elseif($nomTable = "Genre"){
		$requete = "SELECT DISTINCT nomGenre FROM Genre";
	}

	elseif($nomTable = "Album"){
		$requete = "SELECT titreAlbum, COUNT(identifiantchanson), dateSortieAlbum FROM Album NATURAL JOIN Enregistre NATURAL JOIN Groupe NATURAL JOIN Chanson GROUP BY titreAlbum";
	}
	else{
		$requete = "SELECT * FROM $nomTable";
	}

	$res = mysqli_query($connexion, $requete);
	$infoTable = mysqli_fetch_all($res, MYSQLI_ASSOC);
	return $infoTable;
}


		

?>