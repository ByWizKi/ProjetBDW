<?php
//message d'erreur
$message = "";

//nom de la table 
$nomTable = "Album";

//recuperation du nombre d'Album
$nombreAlbum = nombreElementTable($connexion, $nomTable);

//recuperation des infos des Albums
$InfoAlbums = informationTable($connexion, $nomTable);
if($InfoAlbums == NULL && count($InfoAlbums) == 0){
    $message = "Aucun Album n'est present dans notre site.";
}

?>