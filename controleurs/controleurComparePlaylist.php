<?php
//message d'erreur si il n'y a aucune info de table disponible
$message="";
$connexion = getConnexionBD();

//recuperation de toutes les playlists
$allPlaylist1 = getAllPlaylist($connexion);

?>