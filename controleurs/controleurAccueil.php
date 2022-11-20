<?php
//message d'erreur si il n'y a aucune info de table disponible
$message="";


// recuperation des tops chansons
$topChanson = topElementChanson($connexion); 
if($topChanson == null || count($topChanson) == 0) {
	$message .= "Aucune Chanson dans le top cette semaine !";
}

//recuperation des tops Albums
$topAlbum = topElementAlbum($connexion); 
if($topAlbum == null || count($topAlbum) == 0) {
	$message .= "Aucune Album dans le top cette semaine !";
}

//recuperation des tops Genres
$topGenre = topElementGenre($connexion); 
if($topGenre == null || count($topGenre) == 0) {
	$message .= "Aucune Genre dans le top cette semaine !";
}
?>